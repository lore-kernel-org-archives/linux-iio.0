Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46624 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbbKOMhz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 07:37:55 -0500
Subject: Re: [PATCH] iio: adc: vf610: Avoid division by zero
To: Fabio Estevam <fabio.estevam@freescale.com>
References: <1446567530-14725-1-git-send-email-fabio.estevam@freescale.com>
Cc: b38611@freescale.com, linux-iio@vger.kernel.org, festevam@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56487C9F.1070704@kernel.org>
Date: Sun, 15 Nov 2015 12:37:51 +0000
MIME-Version: 1.0
In-Reply-To: <1446567530-14725-1-git-send-email-fabio.estevam@freescale.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/15 16:18, Fabio Estevam wrote:
> When the 'adck-max-frequency' property is not passed in device tree,
> the following division by zero is seen:
> 
> [    2.196814] Hardware name: Freescale i.MX6 SoloX (Device Tree)
> [    2.202652] Backtrace: 
> [    2.205156] [<c0013600>] (dump_backtrace) from [<c001379c>] (show_stack+0x18/0x1c)
> [    2.212730]  r6:ef138410 r5:00000000 r4:00000000 r3:00000000
> [    2.218494] [<c0013784>] (show_stack) from [<c02d8220>] (dump_stack+0x88/0xa4)
> [    2.225756] [<c02d8198>] (dump_stack) from [<c001346c>] (__div0+0x18/0x20)
> [    2.232636]  r5:00000001 r4:eeb0a800
> [    2.236286] [<c0013454>] (__div0) from [<c02d6be4>] (Ldiv0+0x8/0x10)
> [    2.242657] [<c0574574>] (vf610_adc_probe) from [<c03c9274>] (platform_drv_probe+0x58/0xb4)
> 
> Provide a sane adck_rate default value that can be used in normal,
> high-speed and low-power modes in the case of 'adck-max-frequency' property
> being absent.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Hi Fabio

Actually ended up with two different fixes for the same issue merged
so as this was the later one I've dropped it.

The other fix changed the code ordering to set the adck_rate using the default
divisor.
> ---
>  drivers/iio/adc/vf610_adc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 599cde3..424fd69 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -105,6 +105,7 @@
>  #define VF610_ADC_TIMEOUT		msecs_to_jiffies(100)
>  
>  #define DEFAULT_SAMPLE_TIME		1000
> +#define ADCK_RATE_MAX_DEFAULT		20000000
>  
>  enum clk_sel {
>  	VF610_ADCIOC_BUSCLK_SET,
> @@ -195,6 +196,7 @@ static inline void vf610_adc_calculate_rates(struct vf610_adc *info)
>  	} else {
>  		/* fall-back value using a safe divisor */
>  		adc_feature->clk_div = 8;
> +		adck_rate = ADCK_RATE_MAX_DEFAULT;
>  	}
>  
>  	/*
> 

