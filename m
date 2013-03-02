Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36460 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab3CBQZR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:25:17 -0500
Message-ID: <513227EC.8090706@kernel.org>
Date: Sat, 02 Mar 2013 16:25:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio:ad5064: Initialize register cache correctly
References: <1362143239-891-1-git-send-email-lars@metafoo.de> <1362143239-891-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1362143239-891-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/01/2013 01:07 PM, Lars-Peter Clausen wrote:
> Initialize the register cache to the proper mid-scale value based on the
> resolution of the device.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
applied to togreg branch of iio.git

Thanks
> ---
>  drivers/iio/dac/ad5064.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index a491976..0c8d03a 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -438,6 +438,7 @@ static int __devinit ad5064_probe(struct device *dev, enum ad5064_type type,
>  {
>  	struct iio_dev *indio_dev;
>  	struct ad5064_state *st;
> +	unsigned int midscale;
>  	unsigned int i;
>  	int ret;
>  
> @@ -474,11 +475,6 @@ static int __devinit ad5064_probe(struct device *dev, enum ad5064_type type,
>  			goto error_free_reg;
>  	}
>  
> -	for (i = 0; i < st->chip_info->num_channels; ++i) {
> -		st->pwr_down_mode[i] = AD5064_LDAC_PWRDN_1K;
> -		st->dac_cache[i] = 0x8000;
> -	}
> -
>  	indio_dev->dev.parent = dev;
>  	indio_dev->name = name;
>  	indio_dev->info = &ad5064_info;
> @@ -486,6 +482,13 @@ static int __devinit ad5064_probe(struct device *dev, enum ad5064_type type,
>  	indio_dev->channels = st->chip_info->channels;
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
> +	midscale = (1 << indio_dev->channels[0].scan_type.realbits) /  2;
> +
> +	for (i = 0; i < st->chip_info->num_channels; ++i) {
> +		st->pwr_down_mode[i] = AD5064_LDAC_PWRDN_1K;
> +		st->dac_cache[i] = midscale;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
>  		goto error_disable_reg;
> 
