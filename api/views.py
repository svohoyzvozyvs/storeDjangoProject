from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view

from api.serializers import GoodsSerializer
from goods.models import Goods


@api_view(['GET', 'POST'])
def goods_list(request):
    if request.method == 'GET':
        good = Goods.objects.all()
        serializer = GoodsSerializer(good, many=True)
        return Response(serializer.data)
    if request.method == 'POST':
        serializer = GoodsSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)


@api_view(['GET', 'PUT', 'DELETE'])
def goods_detail(request, id):
    try:
        good = Goods.objects.get(id=id)
    except Goods.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    if request.method == 'GET':
        serializer = GoodsSerializer(good)
        return Response(serializer.data)
    if request.method == 'PUT':
        serializer = GoodsSerializer(good, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    if request.method == 'DELETE':
        good.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
