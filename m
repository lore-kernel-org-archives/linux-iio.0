Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46986 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbbGSMal (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 08:30:41 -0400
Message-ID: <55AB986F.5060202@kernel.org>
Date: Sun, 19 Jul 2015 13:30:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fugang Duan <b38611@freescale.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: adc: vf610: fix the adc register read fail issue
References: <1437029349-5446-1-git-send-email-b38611@freescale.com>
In-Reply-To: <1437029349-5446-1-git-send-email-b38611@freescale.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/07/15 07:49, Fugang Duan wrote:
> Read the register only when the adc register address is 4 byte aligned.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> Signed-off-by: Fugang Duan <B38611@freescale.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
> ---
>  drivers/iio/adc/vf610_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 480f335..819632b 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -635,7 +635,7 @@ static int vf610_adc_reg_access(struct iio_dev *indio_dev,
>  	struct vf610_adc *info = iio_priv(indio_dev);
>  
>  	if ((readval == NULL) ||
> -		(!(reg % 4) || (reg > VF610_REG_ADC_PCTL)))
> +		((reg % 4) || (reg > VF610_REG_ADC_PCTL)))
>  		return -EINVAL;
>  
>  	*readval = readl(info->regs + reg);
> 

