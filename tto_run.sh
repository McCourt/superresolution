dataset='Set5'
model='EnhanceNet-E'
method='bicubic+reg+vgg_discriminator'
scale=4
path="/usr/xtmp/superresoluter/superresolution"

source ../sr/bin/activate.csh
python3 -W ignore ${path}/tto.py \
  --model-name=${model} \
  --dataset=${dataset} \
  --scale=${scale}
