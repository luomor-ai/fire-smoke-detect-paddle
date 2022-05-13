FROM registry.baidubce.com/paddlepaddle/paddle:2.2.0
RUN apt-get update
RUN apt-get install vim -y
RUN pip install matplotlib -i https://pypi.doubanio.com/simple/

RUN pip install paddlehub -i https://pypi.doubanio.com/simple/