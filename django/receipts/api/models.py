from django.db import models


class Retailer(models.Model):
    name = models.CharField(max_length=100, primary_key=True)
    vat = models.CharField(max_length=100)
    address = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Product(models.Model):
    name = models.CharField(max_length=255)
    price = models.DecimalField(max_digits=8, decimal_places=2)
    # receipt = models.ForeignKey(Receipt, on_delete=models.CASCADE)

    def __str__(self):
        return self.name


class Receipt(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    retailer = models.ForeignKey(Retailer, on_delete=models.CASCADE)
    products = models.ManyToManyField(Product)

    def __str__(self):
        return f"Receipt {self.id}"

    class Meta:
        ordering = ['-created']
