from django.urls import path
from . import views

urlpatterns = [
    path('', views.getRoutes),
    # path('receipts/', views.getReceipts),
    # path('receipts/<str:pk>/delete/', views.deleteReceipt),
    # path('receipts/<str:pk>/', views.getReceipt),


    path('retailers/', views.getRetailers),
    path('retailers/<str:pk>/receipts/', views.getReceiptsByRetailer),
    path('receipts/<str:pk>/', views.getReceiptDetails),
    path('receipt/<str:pk>/products/', views.getProductsByReceipt),
    path('products/', views.getProducts),
]