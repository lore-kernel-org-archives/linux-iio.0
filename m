Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52979 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab3FBSD1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jun 2013 14:03:27 -0400
Message-ID: <51AB88EE.3090602@kernel.org>
Date: Sun, 02 Jun 2013 19:03:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	sameo@linux.intel.com, jic23@cam.ac.uk, dmitry.torokhov@gmail.com,
	balbi@ti.com
Subject: Re: [PATCH 5/5] iio/ti_am335x_adc: check if we found the value
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de> <1369847397-27451-6-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369847397-27451-6-git-send-email-bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/29/2013 06:09 PM, Sebastian Andrzej Siewior wrote:
> Usually we get all the values we wanted but it is possible, that te ADC
> unit is busy performing the conversation for the HW events. In that case
> -EBUSY is returned and the user may re-call the function.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/adc/ti_am335x_adc.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index df2de4c..6a00874 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -161,6 +161,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	int i;
>  	unsigned int fifo1count, read;
>  	u32 step = UINT_MAX;
> +	bool found = false;
>  
>  	/*
>  	 * When the sub-system is first enabled,
> @@ -185,10 +186,14 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
>  	for (i = 0; i < fifo1count; i++) {
>  		read = tiadc_readl(adc_dev, REG_FIFO1);
> -		if (read >> 16 == step)
> +		if (read >> 16 == step) {
>  			*val = read & 0xfff;
> +			found = true;
> +		}
>  	}
>  	tiadc_writel(adc_dev, REG_SE, STPENB_STEPENB);
> +	if (found == false)
> +		return -EBUSY;
>  
>  	return IIO_VAL_INT;
>  }
> 
