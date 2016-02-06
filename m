Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41057 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbcBFSSW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 13:18:22 -0500
Subject: Re: [PATCH v3 1/2] iio: pressure: ms5611: Add IIO_CHAN_INFO_SCALE to
 mask
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1454518238-7242-1-git-send-email-daniel.baluta@intel.com>
 <1454518238-7242-2-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	lucas.demarchi@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B638E9.2030203@kernel.org>
Date: Sat, 6 Feb 2016 18:18:17 +0000
MIME-Version: 1.0
In-Reply-To: <1454518238-7242-2-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/02/16 16:50, Daniel Baluta wrote:
> This allows data exported via buffer interface to be converted
> to standard units in userspace.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Applied.
> ---
>  drivers/iio/pressure/ms5611_core.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index 2f3d9b4..6cf0e55 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -201,6 +201,18 @@ static int ms5611_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = 10;
> +			return IIO_VAL_INT;
> +		case IIO_PRESSURE:
> +			*val = 0;
> +			*val2 = 1000;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
>  	}
>  
>  	return -EINVAL;
> @@ -218,11 +230,13 @@ static struct ms5611_chip_info chip_info_tbl[] = {
>  static const struct iio_chan_spec ms5611_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_SCALE),
>  	},
>  	{
>  		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_SCALE),
>  	}
>  };
>  
> 

