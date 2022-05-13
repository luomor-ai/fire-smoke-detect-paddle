# coding: utf8
import requests
import json
import cv2
import base64


def cv2_to_base64(image):
    data = cv2.imencode('.jpg', image)[1]
    return base64.b64encode(data.tostring()).decode('utf8')


if __name__ == '__main__':
    # 获取图片的base64编码格式
    img1 = cv2_to_base64(cv2.imread("fire_smoke/images/fire_000061.jpg"))
    img2 = cv2_to_base64(cv2.imread("fire_smoke/images/smoke_000001.jpg"))
    data = {'images': [img1, img2]}
    # 指定content-type
    headers = {"Content-type": "application/json"}
    # 发送HTTP请求
    url = "http://49.232.6.131:8866/predict/fire-smoke-detect-paddle"
    r = requests.post(url=url, headers=headers, data=json.dumps(data))

    # 打印预测结果
    print(r.json()["results"])