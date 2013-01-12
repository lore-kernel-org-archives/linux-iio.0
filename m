Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44650 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711Ab3ALUy7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jan 2013 15:54:59 -0500
Message-ID: <50F1CD9F.3030803@kernel.org>
Date: Sat, 12 Jan 2013 20:54:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] iio: fix Kconfig for max1363
References: <20130110101642.GA18411@localhost> <1357838990-32503-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1357838990-32503-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/10/2013 05:29 PM, Peter Meerwald wrote:
> ERROR: "iio_triggered_buffer_setup" [drivers/iio/adc/max1363.ko] undefined!
> ERROR: "iio_triggered_buffer_cleanup" [drivers/iio/adc/max1363.ko] undefined!
> 
> add select IIO_TRIGGERED_BUFFER
> 
> IIO_TRIGGERED_BUFFER in turn selects IIO_TRIGGER and IIO_KFIFO_BUF, so drop those
> MAX1363_RING_BUFFER is not used anymore
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
Thanks,

Have added a reported by tag for Fengguang Wu and added to togreg branch of
iio.git
> ---
>  drivers/iio/adc/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index fe822a1..e372257 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -100,10 +100,8 @@ config LP8788_ADC
>  config MAX1363
>  	tristate "Maxim max1363 ADC driver"
>  	depends on I2C
> -	select IIO_TRIGGER
> -	select MAX1363_RING_BUFFER
>  	select IIO_BUFFER
> -	select IIO_KFIFO_BUF
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for many Maxim i2c analog to digital
>  	  converters (ADC). (max1361, max1362, max1363, max1364, max1036,
> 
