Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37966 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbbHVRV6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 13:21:58 -0400
Subject: Re: [PATCH 3/3] iio:humidity:si7020: added processed data
To: Nicola Corna <nicola@corna.info>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1440079909-1337-1-git-send-email-nicola@corna.info>
 <1440079909-1337-3-git-send-email-nicola@corna.info>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D8AFB3.6010603@kernel.org>
Date: Sat, 22 Aug 2015 18:21:55 +0100
MIME-Version: 1.0
In-Reply-To: <1440079909-1337-3-git-send-email-nicola@corna.info>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 15:11, Nicola Corna wrote:
> The value given by the Si7013/20/21 modules needs a conversion using a
> small expression in order to obtain the measurement in °C or %RH. This
> patch adds the computation inside the si7020 module, allowing the user to
> obtain the measurement in m°C and 10E-3%RH without any additional
> calculation.
> 
> Signed-off-by: Nicola Corna <nicola@corna.info>
What is the benefit in doing this?  Userspace already has all the numbers
to calculate the value?  The calculation is trivial to do in userspace.
The basic principle of IIO is to do as little as possible in the driver
and to leave such calculations to userspace which has the benefit of
easy access to floating point calculations if desired.

So sorry, not taking this one.

Jonathan
> ---
>  drivers/iio/humidity/si7020.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index a8bad04..c534706 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -70,6 +70,7 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_PROCESSED:
>  		if (holdmode) {
>  			ret = i2c_smbus_read_word_data(*client,
>  						       chan->type == IIO_TEMP ?
> @@ -108,6 +109,17 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>  			else if (*val > 55575) /* 100%RH */
>  				*val = 55575;
>  		}
> +		if (mask == IIO_CHAN_INFO_PROCESSED) {
> +			/*
> +			 * To avoid overflows the fractions can be simplified:
> +			 * temperature --> 175720 / (65536 >> 2) = 21965 / 2048
> +			 * humidity    --> 125000 / (65536 >> 2) = 15625 / 2048
> +			 */
> +			if (chan->type == IIO_TEMP)
> +				*val = (*val - 4368) * 21965 / 2048;
> +			else
> +				*val = (*val - 768) * 15625 / 2048;
> +		}
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->type == IIO_TEMP)
> @@ -142,12 +154,14 @@ static const struct iio_chan_spec si7020_channels[] = {
>  	{
>  		.type = IIO_HUMIDITYRELATIVE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |
> +			BIT(IIO_CHAN_INFO_PROCESSED),
>  	},
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |
> +			BIT(IIO_CHAN_INFO_PROCESSED),
>  	}
>  };
>  
> 

