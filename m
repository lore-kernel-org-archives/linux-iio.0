Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51787 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab3JAIGs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:06:48 -0400
Message-ID: <524A90C3.5080408@kernel.org>
Date: Tue, 01 Oct 2013 10:07:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 16/25] iio:ad7791: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-16-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-16-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Nice cleanup in this one.

Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/adc/ad7791.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index c202035..c19f8fd 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -202,7 +202,6 @@ static int ad7791_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad7791_state *st = iio_priv(indio_dev);
>  	bool unipolar = !!(st->mode & AD7791_MODE_UNIPOLAR);
> -	unsigned long long scale_pv;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -220,23 +219,26 @@ static int ad7791_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		/* The monitor channel uses an internal reference. */
>  		if (chan->address == AD7791_CH_AVDD_MONITOR) {
> -			scale_pv = 5850000000000ULL;
> +			/*
> +			 * The signal is attenuated by a factor of 5 and
> +			 * compared against a 1.17V internal reference.
> +			 */
> +			*val = 1170 * 5;
>  		} else {
>  			int voltage_uv;
>  
>  			voltage_uv = regulator_get_voltage(st->reg);
>  			if (voltage_uv < 0)
>  				return voltage_uv;
> -			scale_pv = (unsigned long long)voltage_uv * 1000000;
> +
> +			*val = voltage_uv / 1000;
>  		}
>  		if (unipolar)
> -			scale_pv >>= chan->scan_type.realbits;
> +			*val2 = chan->scan_type.realbits;
>  		else
> -			scale_pv >>= chan->scan_type.realbits - 1;
> -		*val2 = do_div(scale_pv, 1000000000);
> -		*val = scale_pv;
> +			*val2 = chan->scan_type.realbits - 1;
>  
> -		return IIO_VAL_INT_PLUS_NANO;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	}
>  
>  	return -EINVAL;
> 
