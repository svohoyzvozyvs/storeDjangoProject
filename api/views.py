from rest_framework.response import Response
from rest_framework.decorators import api_view


@api_view(['GET'])
def get_data(request):
    good = {"name": "测试商品", "price": 21.3}
    return Response(good)
