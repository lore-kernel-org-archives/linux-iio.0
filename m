Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57174 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcCESnN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 13:43:13 -0500
Subject: Re: [PATCH] iio: adc: imx25-gcq: fix do_div
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1457009513-7069-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	linux-iio@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DB28BF.9070508@kernel.org>
Date: Sat, 5 Mar 2016 18:43:11 +0000
MIME-Version: 1.0
In-Reply-To: <1457009513-7069-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 12:51, Sudip Mukherjee wrote:
> We are getting build failure with tilepro allmodconfig with the error:
> 
> drivers/iio/adc/fsl-imx25-gcq.c:236:4: note: in expansion of macro 'do_div'
> do_div(priv->channel_vref_mv[reg], 1000);
>     ^
> 
> include/asm-generic/div64.h:198:17: note: expected 'uint64_t *
> 	{aka long long unsigned int *}' but argument is of type 'u32 *
> 	{aka unsigned int *}'
> 
> Create a temporary variable of type u64 and use that in do_div.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Markus, can you take a quick look at this. 

> ---
> 
> tilepro allmodconfig build log is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/113325889
> 
>  drivers/iio/adc/fsl-imx25-gcq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index 2fd1927..e0636d4 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -174,6 +174,7 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  	struct device *dev = &pdev->dev;
>  	unsigned int refp_used[4] = {};
>  	int ret, i;
> +	u64 temp;
>  
>  	/*
>  	 * Setup all configurations registers with a default conversion
> @@ -233,7 +234,9 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  			priv->channel_vref_mv[reg] =
>  				regulator_get_voltage(priv->vref[refp]);
>  			/* Conversion from uV to mV */
> -			do_div(priv->channel_vref_mv[reg], 1000);
> +			temp = priv->channel_vref_mv[reg];
> +			do_div(temp, 1000);
> +			priv->channel_vref_mv[reg] = temp;
>  			break;
>  		case MX25_ADC_REFP_INT:
>  			priv->channel_vref_mv[reg] = 2500;
> 

