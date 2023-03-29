from django.urls import path
from . import views

urlpatterns = [
    path('receipts/', views.getReceipts),
    path('receipts/<str:pk>/', views.getReceiptDetails),
    path('receipts/retailer/<str:pk>/', views.getReceiptsByRetailer), # name of the retailer is the pk
]