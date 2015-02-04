Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60619 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162082AbbBDSkw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Feb 2015 13:40:52 -0500
Message-ID: <54D25061.4030909@kernel.org>
Date: Wed, 04 Feb 2015 17:01:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Nicholas Mc Guire <hofrat@osadl.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Fugang Duan <B38611@freescale.com>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>,
	Sanchayan Maity <maitysanchayan@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: vf610_adc: cleanup wait_for_completion return
 handling
References: <1422866120-10442-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1422866120-10442-1-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/02/15 08:35, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int, this
> patch only fixes up the return handling.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Applied to the togreg branch of iio.git which will at somepoint get
pushed out as testing for the autobuilders to play with. 
If anyone has comments still plenty of time before I push this out
properly!

J
> ---
>  drivers/iio/adc/vf610_adc.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> Rather than changing timeout to unsigned long it can be moved into the
> if condition and dropped.
> 
> Patch was compile tested only for imx_v6_v7_defconfig + CONFIG_IIO=m,
> CONFIG_VF610_ADC=m
> 
> Patch is against 3.19.0-rc6 -next-20150130
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 8ec353c..5b72d17 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -259,7 +259,6 @@ static void vf610_adc_cfg_post_set(struct vf610_adc *info)
>  static void vf610_adc_calibration(struct vf610_adc *info)
>  {
>  	int adc_gc, hc_cfg;
> -	int timeout;
>  
>  	if (!info->adc_feature.calibration)
>  		return;
> @@ -271,9 +270,7 @@ static void vf610_adc_calibration(struct vf610_adc *info)
>  	adc_gc = readl(info->regs + VF610_REG_ADC_GC);
>  	writel(adc_gc | VF610_ADC_CAL, info->regs + VF610_REG_ADC_GC);
>  
> -	timeout = wait_for_completion_timeout
> -			(&info->completion, VF610_ADC_TIMEOUT);
> -	if (timeout == 0)
> +	if (!wait_for_completion_timeout(&info->completion, VF610_ADC_TIMEOUT))
>  		dev_err(info->dev, "Timeout for adc calibration\n");
>  
>  	adc_gc = readl(info->regs + VF610_REG_ADC_GS);
> 

