#!/usr/bin/env bash
python3 -W ignore /home/mccourt/superresolution/trainer.py \
	--model-name='edsr_pyr' \
	--hr-dir='/home/mccourt/DIV2K/DIV2K_train_HR' \
	--lr-dir='/home/mccourt/DIV2K/DIV2K_train_LR_bicubic/X4' \
	--output-dir='/home/mccourt/superresolution/' \
	--ckpt-dir='/home/mccourt/superresolution/checkpoints' \
	--log-dir='/home/mccourt/superresolution/logs' \
	--learning-rate=.0001 \
	--decay-rate=.96 \
	--decay-step=5 \
	--batch-size=15 \
	--num-epoch=40 \
	--add-dsloss='false' \
	--gpu-device='cuda' \
	--upsample='false' \
	--window=40

#python3 -W ignore //usr/project/xtmp/superresoluter/superresolution/trainer.py \
#	--model-name='edsr_pyr' \
#	--hr-dir='/usr/project/xtmp/superresoluter/dataset/DIV2K/DIV2K_train_HR' \
#	--lr-dir='/usr/project/xtmp/superresoluter/dataset/DIV2K/DIV2K_train_LR_bicubic/X4' \
#	--output-dir='/usr/project/xtmp/superresoluter/superresolution/outputs' \
#	--ckpt-dir='/usr/project/xtmp/superresoluter/superresolution/checkpoints' \
#	--log-dir='/usr/project/xtmp/superresoluter/superresolution/logs' \
#	--learning-rate=.00001 \
#	--decay-rate=.9 \
#	--decay-step=3 \
#	--batch-size=18 \
#	--num-epoch=200 \
#	--add-dsloss='false' \
#	--gpu-device='cuda' \
#	--upsample='false' \
#	--window=40