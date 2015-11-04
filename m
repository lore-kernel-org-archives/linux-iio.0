Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1bn0108.outbound.protection.outlook.com ([157.56.110.108]:3138
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750741AbbKDGzb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Nov 2015 01:55:31 -0500
From: Duan Andy <fugang.duan@freescale.com>
To: Fabio Estevam <Fabio.Estevam@freescale.com>,
	"jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"festevam@gmail.com" <festevam@gmail.com>,
	Fabio Estevam <Fabio.Estevam@freescale.com>
Subject: RE: [PATCH] iio: adc: vf610: Avoid division by zero
Date: Wed, 4 Nov 2015 06:41:11 +0000
Message-ID: <BN3PR0301MB1219ED45A2E049CDBB2DEEDBF52A0@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1446567530-14725-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1446567530-14725-1-git-send-email-fabio.estevam@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com> Sent: Wednesday, November 04, 2015 12:19 AM
> To: jic23@kernel.org
> Cc: Duan Fugang-B38611; linux-iio@vger.kernel.org; festevam@gmail.com;
> Estevam Fabio-R49496
> Subject: [PATCH] iio: adc: vf610: Avoid division by zero
> 
> When the 'adck-max-frequency' property is not passed in device tree, the
> following division by zero is seen:
> 
> [    2.196814] Hardware name: Freescale i.MX6 SoloX (Device Tree)
> [    2.202652] Backtrace:
> [    2.205156] [<c0013600>] (dump_backtrace) from [<c001379c>]
> (show_stack+0x18/0x1c)
> [    2.212730]  r6:ef138410 r5:00000000 r4:00000000 r3:00000000
> [    2.218494] [<c0013784>] (show_stack) from [<c02d8220>]
> (dump_stack+0x88/0xa4)
> [    2.225756] [<c02d8198>] (dump_stack) from [<c001346c>]
> (__div0+0x18/0x20)
> [    2.232636]  r5:00000001 r4:eeb0a800
> [    2.236286] [<c0013454>] (__div0) from [<c02d6be4>] (Ldiv0+0x8/0x10)
> [    2.242657] [<c0574574>] (vf610_adc_probe) from [<c03c9274>]
> (platform_drv_probe+0x58/0xb4)
> 
> Provide a sane adck_rate default value that can be used in normal, high-
> speed and low-power modes in the case of 'adck-max-frequency' property
> being absent.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
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
> @@ -195,6 +196,7 @@ static inline void vf610_adc_calculate_rates(struct
> vf610_adc *info)
>  	} else {
>  		/* fall-back value using a safe divisor */
>  		adc_feature->clk_div = 8;
> +		adck_rate = ADCK_RATE_MAX_DEFAULT;
>  	}
> 
>  	/*
> --
> 1.9.1

Acked-by: Fugang Duan <B38611@freescale.com>
