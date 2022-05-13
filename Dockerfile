FROM python:3.6
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
COPY docker/sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install vim -y
RUN apt-get install libgl1 -y

RUN pip install matplotlib -i https://pypi.doubanio.com/simple/

RUN pip install paddlehub -i https://pypi.doubanio.com/simple/
RUN pip install paddlepaddle -i https://pypi.doubanio.com/simple/
RUN pip install paddlex -i https://pypi.doubanio.com/simple/

WORKDIR /app
COPY inference_model .

RUN hub convert --model_dir inference_model \
            --module_name fire-smoke-detect-paddle \
            --module_version 1.0.0 \
            --output_dir fire-smoke-detect-paddle-hub

RUN hub install fire-smoke-detect-paddle-hub/fire-smoke-detect-paddle.tar.gz
# hub serving start --modules fire-smoke-detect-paddle
# CMD ["tail", "-f", "/dev/null"]
ENTRYPOINT ["hub", "serving", "start", "--modules", "fire-smoke-detect-paddle"]