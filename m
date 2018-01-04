Return-Path: <SRS0=KCHU=D7=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] Drivers:iio:dac: Remove unneeded conversion to bool
To: venkat.prashanth2498@gmail.com, Michael.Hennerich@analog.com,
 jic23@kernel.org
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <1515067092-5219-1-git-send-email-venkat.prashanth2498@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <714f6cc7-0c14-c587-2db2-018ad6fca5e1@metafoo.de>
Date: Thu, 4 Jan 2018 13:54:35 +0100
MIME-Version: 1.0
In-Reply-To: <1515067092-5219-1-git-send-email-venkat.prashanth2498@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 01/04/2018 12:58 PM, venkat.prashanth2498@gmail.com wrote:
> From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> 
> This is a patch to the mcp4725.c file which
> fixes the following coccinelle warning:
> 
> WARNING: conversion to bool not needed here
> 
> Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> ---
>  drivers/iio/dac/mcp4725.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index afa856d..8f8c529 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -476,7 +476,6 @@ static int mcp4725_probe(struct i2c_client *client,
>  		goto err_disable_vref_reg;
>  	}
>  	pd = (inbuf[0] >> 1) & 0x3;
> -	data->powerdown = pd > 0 ? true : false;

You removed the complete statement. Not just the conversion to bool.

>  	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
>  	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
>  	if (data->id == MCP4726)
> 
