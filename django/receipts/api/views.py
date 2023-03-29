from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import ReceiptSerializer, RetailerSerializer, ProductSerializer
from .models import Receipt, Retailer

# Test route
@api_view(['GET'])
def getRoutes(request):
    routes = [
        {
            'Endpoint': '/retailers/',
            'method': 'GET',
            'body': None,
            'description': 'Returns list of retailers'
        },
        {
            'Endpoint': '/retailers/<str:pk>/receipts',
            'method': 'GET',
            'body': None,
            'description': 'Returns a receipt list for a specific retailer'
        },
        {
            'Endpoint': '/receipts/<str:pk>',
            'method': 'GET',
            'body': None,
            'description': 'Returns a single receipt object'
        },
    ]

    return Response(routes)


# # Get all receipts
# @api_view(['GET'])
# def getReceipts(request):
#     receipts = Receipt.objects.all()
#     serializer = ReceiptSerializer(receipts, many=True)
#     return Response(serializer.data)


# Get a single receipt
@api_view(['GET'])
def getReceiptDetails(request, pk):
    receipt = Receipt.objects.get(id=pk)
    serializer = ReceiptSerializer(receipt, many=False)
    return Response(serializer.data)


# # Delete receipt
# @api_view(['DELETE'])
# def deleteReceipt(request, pk):
#     note = Receipt.objects.get(id=pk)
#     note.delete()
#     return Response('Receipt was deleted')


# Get all retailers
@api_view(['GET'])
def getRetailers(request):
    retailers = Retailer.objects.all()
    serializer = RetailerSerializer(retailers, many=True)
    return Response(serializer.data)


# Get receipts by retailer
@api_view(['GET'])
def getReceiptsByRetailer(request, pk):
    receipts = Receipt.objects.filter(retailer=pk)
    serializer = ReceiptSerializer(receipts, many=True)
    return Response(serializer.data)


# Get products by receipt
@api_view(['GET'])
def getProductsByReceipt(request, pk):
    receipt = Receipt.objects.filter(id=pk)
    serializer = ProductSerializer(receipt, many=True)
    return Response(serializer.data)


# Get products
@api_view(['GET'])
def getProducts(request, pk):
    products = Receipt.objects.all()
    serializer = ProductSerializer(products)
    return Response(serializer.data)