from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import ReceiptSerializer
from .models import Receipt


@api_view(['GET'])
def getRoutes(request):
    routes = [
        {
            'Endpoint': '/receipts/',
            'method': 'GET',
            'body': None,
            'description': 'Returns a list of receipts'
        },
        {
            'Endpoint': '/receipts/id',
            'method': 'GET',
            'body': None,
            'description': 'Returns a single receipt object'
        },
    ]

    return Response(routes)


@api_view(['GET'])
def getReceipts(request):
    receipts = Receipt.objects.all()
    serializer = ReceiptSerializer(receipts, many=True)
    return Response(serializer.data)


@api_view(['GET'])
def getReceipt(request, pk):
    receipt = Receipt.objects.get(id=pk)
    serializer = ReceiptSerializer(receipt, many=False)
    return Response(serializer.data)

@api_view(['DELETE'])
def deleteReceipt(request, pk):
    note = Receipt.objects.get(id=pk)
    note.delete()
    return Response('Receipt was deleted')
