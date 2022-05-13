```shell
sudo docker pull paddlepaddle/serving
sudo docker pull paddlepaddle/paddle
sudo docker pull python:3.6

sudo docker pull registry.baidubce.com/paddlepaddle/paddle:2.2.0

# registry.baidubce.com/paddlepaddle/paddle:2.2.2

sudo docker run -ti --volume="$(pwd)":/app --rm paddlepaddle/paddle:2.2.0 bash
sudo docker run -ti --volume="$(pwd)":/app --rm python:3.6 bash
pip install paddlehub -i https://pypi.doubanio.com/simple/
pip install paddlepaddle -i https://pypi.doubanio.com/simple/

pip show paddlehub

apt-get update && apt-get install -y opencv-python-headless
pip install opencv-python-headless -i https://pypi.doubanio.com/simple/
apt-get update && apt-get install libgl1
pip install opencv-python -i https://pypi.doubanio.com/simple/

hub convert --model_dir inference_model/inference_model \
            --module_name fire-smoke-detect-paddle \
            --module_version 1.0.0 \
            --output_dir fire-smoke-detect-paddle-hub

https://hub.docker.com/r/paddlepaddle/serving
```

```shell
docker paddlehub
```

```shell
# 项目已提供PaddlePaddleX，无需执行此步骤
# !git clone https://github.com/PaddlePaddle/PaddleX.git -b develop

!unzip -q PaddleX.zip

# 安装环境
%cd /home/aistudio/PaddleX
!git checkout develop
!pip install -r requirements.txt
!python setup.py install
!mkdir /home/aistudio/dataset/

# 第一次运行项目执行即可
%cd /home/aistudio/dataset/
!mv /home/aistudio/data/data107770/train_list.txt ./
!mv /home/aistudio/data/data107770/val_list.txt ./
!mv /home/aistudio/data/data107770/labels.txt ./
!unzip -q /home/aistudio/data/data107770/images.zip -d ./
!unzip -q /home/aistudio/data/data107770/annotations.zip -d ./
%cd ..

%cd /home/aistudio/code/

# GPU单卡训练
%cd /home/aistudio/code/
# 可以在code文件夹内选择不同的训练文件进行训练，每个文件使用的策略参考本项目10.3小节
!export CUDA_VISIBLE_DEVICES=0
!python 1.train_ppyolov2_imagenet.py

# GPU多卡训练，例如使用2张卡时执行：
# export CUDA_VISIBLE_DEVICES=0,1 #windows和Mac下不需要执行该命令
# python -m paddle.distributed.launch --gpus 0,1 1.train_ppyolov2_imagenet.py

!mkdir /home/aistudio/dataset/eval_imgs/
!mkdir /home/aistudio/dataset/eval_imgs/fire_smoke/
!mkdir /home/aistudio/dataset/eval_imgs/neg_pics/

!python gen_txt.py

# 评估数据未公开，按上面步骤准备好验证集，即可以执行该命令
!python metric.py

# 模型路径、测试图片路径、结果保存路径、阈值可在predict.py文件内修改
# 如果报错可以检查模型路径等是否正确
!python predict.py

# 根据具体使用的训练文件，修改模型路径model_dir
!paddlex --export_inference --model_dir=/home/aistudio/code/output/ppyolov2_r50vd_dcn/best_model/ --save_dir=/home/aistudio/code/inference_model

# 模型推理
!python infer.py
```