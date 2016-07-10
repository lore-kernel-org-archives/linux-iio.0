Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38882 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138AbcGJNcl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 09:32:41 -0400
Subject: Re: [PATCH 3/4] iio: light: vcnl4000: Cleanup read_raw() returns
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1467714201-11429-1-git-send-email-pmeerw@pmeerw.net>
 <1467714201-11429-4-git-send-email-pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3d5bb0dd-7d85-b2dd-893d-b5e7a79ca8b7@kernel.org>
Date: Sun, 10 Jul 2016 14:32:39 +0100
MIME-Version: 1.0
In-Reply-To: <1467714201-11429-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/16 11:23, Peter Meerwald-Stadler wrote:
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Nice little cleanup.

Applied. Thanks,

Jonathan
> ---
>  drivers/iio/light/vcnl4000.c |   27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 7f247ed..9f94b6b 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -109,7 +109,7 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
>  				int *val, int *val2, long mask)
>  {
> -	int ret = -EINVAL;
> +	int ret;
>  	struct vcnl4000_data *data = iio_priv(indio_dev);
>  
>  	switch (mask) {
> @@ -121,32 +121,27 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				VCNL4000_AL_RESULT_HI, val);
>  			if (ret < 0)
>  				return ret;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		case IIO_PROXIMITY:
>  			ret = vcnl4000_measure(data,
>  				VCNL4000_PS_OD, VCNL4000_PS_RDY,
>  				VCNL4000_PS_RESULT_HI, val);
>  			if (ret < 0)
>  				return ret;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		default:
> -			break;
> +			return -EINVAL;
>  		}
> -		break;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (chan->type == IIO_LIGHT) {
> -			*val = 0;
> -			*val2 = 250000;
> -			ret = IIO_VAL_INT_PLUS_MICRO;
> -		}
> -		break;
> +		if (chan->type != IIO_LIGHT)
> +			return -EINVAL;
> +
> +		*val = 0;
> +		*val2 = 250000;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
> -		break;
> +		return -EINVAL;
>  	}
> -
> -	return ret;
>  }
>  
>  static const struct iio_info vcnl4000_info = {
> 

