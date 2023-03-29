from rest_framework.serializers import ModelSerializer
from .models import Receipt, Retailer, Product

class ReceiptSerializer(ModelSerializer):
    class Meta:
        model = Receipt
        fields = '__all__'

class RetailerSerializer(ModelSerializer):
    class Meta:
        model = Retailer
        fields = '__all__'

class ProductSerializer(ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'