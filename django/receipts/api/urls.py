from django.urls import path
from . import views

urlpatterns = [
    path('', views.getRoutes),
    path('receipts/', views.getReceipts),
    # path('notes/create/', views.createNote),
    # path('notes/<str:pk>/update/', views.updateNote),
    path('receipts/<str:pk>/delete/', views.deleteReceipt),
    path('receipts/<str:pk>/', views.getReceipt),
]