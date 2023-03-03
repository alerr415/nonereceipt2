from rest_framework.serializers import ModelSerializer
from .models import Receipt, Retailer

class ReceiptSerializer(ModelSerializer):
    class Meta:
        model = Receipt
        fields = '__all__'

class RetailerSerializer(ModelSerializer):
    class Meta:
        model = Retailer
        fields = '__all__'