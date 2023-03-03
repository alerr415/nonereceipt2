from django.urls import path
from . import views

urlpatterns = [
    path('', views.getRoutes),
    # path('receipts/', views.getReceipts),
    # path('receipts/<str:pk>/delete/', views.deleteReceipt),
    # path('receipts/<str:pk>/', views.getReceipt),


    path('retailers/', views.getRetailers),
]