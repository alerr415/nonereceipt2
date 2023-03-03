from django.db import models


class Retailer(models.Model):
    name = models.CharField(max_length=100, primary_key=True)
    vat = models.CharField(max_length=100)
    address = models.CharField(max_length=100)

    def __str__(self):
        return self.name
    

class Receipt(models.Model):
    body = models.TextField()
    created = models.DateTimeField(auto_now_add=True)
    retailer = models.ForeignKey(Retailer, on_delete=models.CASCADE)

    def __str__(self):
        return self.body[0:50]

    class Meta:
        ordering = ['-created']
