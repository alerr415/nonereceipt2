 #ifdef HAVE_CONFIG_H
 #  include "config.h"
 #endif // HAVE_CONFIG_H
  
 #include <errno.h>
 #include <signal.h>
 #include <stdlib.h>
  
 #include <nfc/nfc.h>
 #include <nfc/nfc-emulation.h>
  
 #include "utils/nfc-utils.h"
  
 static nfc_device *pnd;
 static nfc_context *context;
  
 static void
 stop_emulation(int sig)
 {
   (void)sig;
   if (pnd != NULL) {
     nfc_abort_command(pnd);
   } else {
     nfc_exit(context);
     exit(EXIT_FAILURE);
   }
 }
  
// NFC card memory content
static uint8_t __nfcforum_tag2_memory_area[] = {
  0x00, 0x00, 0x00, 0x00,  // Block 0
  0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0xFF, 0xFF,  // Block 2 (Static lock bytes: CC area and data area are read-only locked)
  0xE1, 0x10, 0x06, 0x0F,  // Block 3 (CC - NFC-Forum Tag Type 2 version 1.0, Data area (from block 4 to the end) is 48 bytes, Read-only mode)
};

 
 #define READ    0x30
 #define WRITE     0xA2
 #define SECTOR_SELECT   0xC2
 #define HALT    0x50

// nfc state machine
 static int nfcforum_tag2_io(
  struct nfc_emulator *emulator, 
  const uint8_t *data_in, 
  const size_t data_in_len, 
  uint8_t *data_out, 
  const size_t data_out_len)
 {
   int res = 0;
  
   uint8_t *nfcforum_tag2_memory_area = (uint8_t *)(emulator->user_data);
  
   printf("    In: ");
   //print_hex(data_in, data_in_len); TODO
  
   switch (data_in[0]) {
     case READ:
       if (data_out_len >= 16) {
         memcpy(data_out, nfcforum_tag2_memory_area + (data_in[1] * 4), 16);
         res = 16;
       } else {
         res = -ENOSPC;
       }
       break;
     case HALT:
       printf("HALT sent\n");
       res = -ECONNABORTED;
       break;
     default:
       printf("Unknown command: 0x%02x\n", data_in[0]);
       res = -ENOTSUP;
   }
  
   if (res < 0) {
     ERR("%s (%d)", strerror(-res), -res);
   } else {
     printf("    Out: ");
     //print_hex(data_out, res); TODO
   }
  
   return res;
 }
  
// This is the entry point of the program, where execution begins. It initializes the NFC controller, sets up the tag emulation mode, and then enters an infinite loop, waiting for incoming NFC commands.

 int
 main(int argc, char *argv[]) {
   (void)argc;
   (void)argv;
  
   // NFC target
   nfc_target nt = {

     // NFC modulation
     .nm = {
       .nmt = NMT_ISO14443A, // ISO/IEC 14443 Type A
       .nbr = NBR_UNDEFINED, // Will be updated by nfc_target_init()
     },

     // NFC target info
     .nti = {
       .nai = { // nfc_iso14443a_info
         .abtAtqa = { 0x00, 0x04 }, // Answer to Request (ATQA) parameter for the Type A anti-collision sequence
         .abtUid = { 0x08, 0x00, 0xb0, 0x0b }, // Unique Identifier (UID) of the target device
         .szUidLen = 4, // the length of the UID
         .btSak = 0x00, // the Select Acknowledge (SAK) parameter
         .szAtsLen = 0, // the length of the Answer to Select (ATS) parameter
       },
     }
   };
  
   struct nfc_emulation_state_machine state_machine = {
     .io = nfcforum_tag2_io
   };

   // Read NDEF content from file
  FILE *file = fopen("ndef.bin", "r");
  if (file != NULL) {
    uint8_t ndef_buffer[48];
    size_t bytes_read = fread(ndef_buffer, sizeof(uint8_t), sizeof(ndef_buffer), file);
    if (bytes_read > 0) {
      memcpy(&__nfcforum_tag2_memory_area[16], ndef_buffer, bytes_read);
    }
    fclose(file);
  }
  
   struct nfc_emulator emulator = {
     .target = &nt,
     .state_machine = &state_machine,
     .user_data = __nfcforum_tag2_memory_area,
   };
  
  // handling interrupt
   signal(SIGINT, stop_emulation);
  
// nfc_init() : This function initializes the NFC controller by calling nfc_open and nfc_initiator_init.
// Initializes libnfc. This function must be called before calling any other libnfc function.

   nfc_init(&context);
   if (context == NULL) {
     ERR("Unable to init libnfc (malloc)");
     exit(EXIT_FAILURE);
   }

// nfc_open() : This function opens the NFC device and returns an NFC device context.
// Opens a NFC device. Returns pointer to a nfc_device (pnd) struct if successful; otherwise returns NULL value.

   pnd = nfc_open(context, NULL); // pointer to nfc device
  
   if (pnd == NULL) {
     ERR("Unable to open NFC device");
     nfc_exit(context);
     exit(EXIT_FAILURE);
   }
  
   printf("NFC device: %s opened\n", nfc_device_get_name(pnd));
   printf("Emulating NDEF tag now, please touch it with a second NFC device\n");
  
// nfc_emulate_target() : emulates the target
// Returns 0 on success, otherwise returns libnfc's error code (negative value).

   if (nfc_emulate_target(pnd, &emulator, 0) < 0) {
    // error handling
     nfc_perror(pnd, argv[0]);
     nfc_close(pnd);
     nfc_exit(context);
     exit(EXIT_FAILURE);
   }
  
  // close device and exit context
   nfc_close(pnd);
   nfc_exit(context);
   exit(EXIT_SUCCESS);
 }