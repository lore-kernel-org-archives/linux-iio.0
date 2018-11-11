Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeKKW3R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 17:29:17 -0500
Date: Sun, 11 Nov 2018 12:40:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        freeman.liu@unisoc.com, broonie@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sc27xx: Add ADC data conversion timeout
Message-ID: <20181111124044.52f61897@archlinux>
In-Reply-To: <208f9043fbd9b14b7a0c2743f68fa424388f5dcd.1541733478.git.baolin.wang@linaro.org>
References: <208f9043fbd9b14b7a0c2743f68fa424388f5dcd.1541733478.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  9 Nov 2018 11:25:31 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:

> From: Freeman Liu <freeman.liu@unisoc.com>
> 
> Sometimes the ADC controller met some problems, and it will not complete
> the data conversion, that will can not wake up the read process any more
> to block users. So we should add one maximum conversion time to avoid
> this issue.
> 
> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Hi.

Patch looks good, but sounds like this is a fix so could I have a fixes
tag and a patch title that makes that clear?

I think we will want this one back ported to stable by the sound of it.

If it is just a theoretical issue then perhaps we don't need to bother.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/sc27xx_adc.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 7940b23..f7f7a189 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -52,6 +52,9 @@
>  /* Timeout (ms) for the trylock of hardware spinlocks */
>  #define SC27XX_ADC_HWLOCK_TIMEOUT	5000
>  
> +/* Timeout (ms) for ADC data conversion according to ADC datasheet */
> +#define SC27XX_ADC_RDY_TIMEOUT		100
> +
>  /* Maximum ADC channel number */
>  #define SC27XX_ADC_CHANNEL_MAX		32
>  
> @@ -223,7 +226,14 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>  	if (ret)
>  		goto disable_adc;
>  
> -	wait_for_completion(&data->completion);
> +	ret = wait_for_completion_timeout(&data->completion,
> +				msecs_to_jiffies(SC27XX_ADC_RDY_TIMEOUT));
> +	if (!ret) {
> +		dev_err(data->dev, "read ADC data timeout\n");
> +		ret = -ETIMEDOUT;
> +	} else {
> +		ret = 0;
> +	}
>  
>  disable_adc:
>  	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
