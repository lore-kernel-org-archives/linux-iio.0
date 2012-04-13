Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-152.synserver.de ([212.40.185.152]:1101 "EHLO
	smtp-out-147.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751144Ab2DMOck (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 10:32:40 -0400
Message-ID: <4F883998.3040403@metafoo.de>
Date: Fri, 13 Apr 2012 16:35:04 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/13] staging:iio:adc Add IIO_CHAN_INFO_RAW entries to
 all drivers.
References: <1334311471-23054-1-git-send-email-jic23@kernel.org> <1334311471-23054-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1334311471-23054-4-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/13/2012 12:04 PM, Jonathan Cameron wrote:
> Precursor to making value read / write attribute optional.
> No processed values for adc's.
> 
> Updated to include the spear adc driver (hence introducing a
> dependency on the patch that adds that driver).
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
> [...]
> diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
> index dfc9033..0733d89 100644
> --- a/drivers/staging/iio/adc/lpc32xx_adc.c
> +++ b/drivers/staging/iio/adc/lpc32xx_adc.c
> @@ -73,7 +73,7 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct lpc32xx_adc_info *info = iio_priv(indio_dev);
>  
> -	if (mask == 0) {
> +	if (mask == IIO_CHAN_INFO_RAW) {
>  		mutex_lock(&indio_dev->mlock);
>  		clk_enable(info->clk);
>  		/* Measurement setup */
> @@ -98,12 +98,13 @@ static const struct iio_info lpc32xx_adc_iio_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -#define LPC32XX_ADC_CHANNEL(_index) {		\
> -	.type = IIO_VOLTAGE,			\
> -	.indexed = 1,				\
> -	.channel = _index,			\
> -	.address = AD_IN * _index,		\
> -	.scan_index = _index,			\
> +#define LPC32XX_ADC_CHANNEL(_index) {			\
> +	.type = IIO_VOLTAGE,				\
> +	.indexed = 1,					\
> +	.channel = _index,				\
> +			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,	\

This looks a bit odd.

> +	.address = AD_IN * _index,			\
> +	.scan_index = _index,				\
>  }



