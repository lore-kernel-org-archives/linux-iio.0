Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51462 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab3JAHtZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 03:49:25 -0400
Message-ID: <524A8CB0.7010804@kernel.org>
Date: Tue, 01 Oct 2013 09:49:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/25] iio:ad5380: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/dac/ad5380.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> index 4c791e6..a59ff0e 100644
> --- a/drivers/iio/dac/ad5380.c
> +++ b/drivers/iio/dac/ad5380.c
> @@ -204,7 +204,6 @@ static int ad5380_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long info)
>  {
>  	struct ad5380_state *st = iio_priv(indio_dev);
> -	unsigned long scale_uv;
>  	int ret;
>  
>  	switch (info) {
> @@ -225,10 +224,9 @@ static int ad5380_read_raw(struct iio_dev *indio_dev,
>  		val -= (1 << chan->scan_type.realbits) / 2;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = ((2 * st->vref) >> chan->scan_type.realbits) * 100;
> -		*val =  scale_uv / 100000;
> -		*val2 = (scale_uv % 100000) * 10;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = 2 * st->vref;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
>  		break;
>  	}
> @@ -271,72 +269,72 @@ static const struct ad5380_chip_info ad5380_chip_info_tbl[] = {
>  	[ID_AD5380_3] = {
>  		.channel_template = AD5380_CHANNEL(14),
>  		.num_channels = 40,
> -		.int_vref = 1250000,
> +		.int_vref = 1250,
>  	},
>  	[ID_AD5380_5] = {
>  		.channel_template = AD5380_CHANNEL(14),
>  		.num_channels = 40,
> -		.int_vref = 2500000,
> +		.int_vref = 2500,
>  	},
>  	[ID_AD5381_3] = {
>  		.channel_template = AD5380_CHANNEL(12),
>  		.num_channels = 16,
> -		.int_vref = 1250000,
> +		.int_vref = 1250,
>  	},
>  	[ID_AD5381_5] = {
>  		.channel_template = AD5380_CHANNEL(12),
>  		.num_channels = 16,
> -		.int_vref = 2500000,
> +		.int_vref = 2500,
>  	},
>  	[ID_AD5382_3] = {
>  		.channel_template = AD5380_CHANNEL(14),
>  		.num_channels = 32,
> -		.int_vref = 1250000,
> +		.int_vref = 1250,
>  	},
>  	[ID_AD5382_5] = {
>  		.channel_template = AD5380_CHANNEL(14),
>  		.num_channels = 32,
> -		.int_vref = 2500000,
> +		.int_vref = 2500,
>  	},
>  	[ID_AD5383_3] = {
>  		.channel_template = AD5380_CHANNEL(12),
>  		.num_channels = 32,
> -		.int_vref = 1250000,
> +		.int_vref = 1250,
>  	},
>  	[ID_AD5383_5] = {
>  		.channel_template = AD5380_CHANNEL(12),
>  		.num_channels = 32,
> -		.int_vref = 2500000,
> +		.int_vref = 2500,
>  	},
>  	[ID_AD5390_3] = {
>  		.channel_template = AD5380_CHANNEL(14),
>  		.num_channels = 16,
> -		.int_vref = 1250000,
> +		.int_vref = 1250,
>  	},
>  	[ID_AD5390_5] = {
>  		.channel_template = AD5380_CHANNEL(14),
>  		.num_channels = 16,
> -		.int_vref = 2500000,
> +		.int_vref = 2500,
>  	},
>  	[ID_AD5391_3] = {
>  		.channel_template = AD5380_CHANNEL(12),
>  		.num_channels = 16,
> -		.int_vref = 1250000,
> +		.int_vref = 1250,
>  	},
>  	[ID_AD5391_5] = {
>  		.channel_template = AD5380_CHANNEL(12),
>  		.num_channels = 16,
> -		.int_vref = 2500000,
> +		.int_vref = 2500,
>  	},
>  	[ID_AD5392_3] = {
>  		.channel_template = AD5380_CHANNEL(14),
>  		.num_channels = 8,
> -		.int_vref = 1250000,
> +		.int_vref = 1250,
>  	},
>  	[ID_AD5392_5] = {
>  		.channel_template = AD5380_CHANNEL(14),
>  		.num_channels = 8,
> -		.int_vref = 2500000,
> +		.int_vref = 2500,
>  	},
>  };
>  
> @@ -395,7 +393,7 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
>  		return ret;
>  	}
>  
> -	if (st->chip_info->int_vref == 2500000)
> +	if (st->chip_info->int_vref == 2500)
>  		ctrl |= AD5380_CTRL_INT_VREF_2V5;
>  
>  	st->vref_reg = devm_regulator_get(dev, "vref");
> @@ -411,7 +409,7 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
>  		if (ret < 0)
>  			goto error_disable_reg;
>  
> -		st->vref = ret;
> +		st->vref = ret / 1000;
>  	} else {
>  		st->vref = st->chip_info->int_vref;
>  		ctrl |= AD5380_CTRL_INT_VREF_EN;
> 
