import torch
from torch import nn
from model.blocks import ChannelAttentionBlock, MeanShift, CascadingBlock, ConvolutionBlock, PixelShuffleUpscale


class DeepSR(nn.Module):
    def __init__(self, num_blocks=None, num_channel=256, block=CascadingBlock):
        super().__init__()
        if num_blocks is None:
            num_blocks = [15, 5]
        self.model_0 = nn.Sequential(
            MeanShift(sign=-1),
            ConvolutionBlock(in_channels=3, out_channels=num_channel)
        )
        self.model_1 = nn.Sequential(
            *tuple([nn.Sequential(
                block(in_channels=num_channel),
                ChannelAttentionBlock(channel=num_channel)) for _ in range(num_blocks[0])])
        )
        self.upscale_1 = PixelShuffleUpscale(channels=num_channel)
        self.model_2 = nn.Sequential(
            *tuple([nn.Sequential(
                block(in_channels=num_channel),
                ChannelAttentionBlock(channel=num_channel)) for _ in range(num_blocks[1])])
        )
        self.upscale_2 = PixelShuffleUpscale(channels=num_channel)
        self.model_3 = nn.Sequential(
            ConvolutionBlock(in_channels=num_channel, out_channels=3),
            MeanShift(sign=1)
        )

    def forward(self, x, clip_bound=False):
        x = self.model_0(x)
        up_1 = self.upscale_1(self.model_1(x) + x)
        up_2 = self.upscale_2(self.model_2(up_1) + up_1)
        output = self.model_3(up_2)
        if clip_bound:
            return torch.clamp(torch.round(output), 0., 255.).type('torch.cuda.ByteTensor')
        else:
            return output
