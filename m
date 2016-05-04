Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35887 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbcEDOkF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:40:05 -0400
Subject: Re: [PATCH 06/13] iio: health/afe440x: Remove unneeded offset
 handling
To: "Andrew F. Davis" <afd@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1462135023-14445-1-git-send-email-afd@ti.com>
 <1462135023-14445-7-git-send-email-afd@ti.com>
Cc: linux-iio@vger.kernel.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4b396740-4b63-a8ac-b1b5-fe6980272552@kernel.org>
Date: Wed, 4 May 2016 11:04:02 +0100
MIME-Version: 1.0
In-Reply-To: <1462135023-14445-7-git-send-email-afd@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/16 21:36, Andrew F. Davis wrote:
> No channel in the afe4403 driver has IIO_CHAN_INFO_OFFSET set so
> remove the handlers for this.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
Oops :)

Applied.
> ---
>  drivers/iio/health/afe4403.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index bcff528..cac6090 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -293,14 +293,6 @@ static int afe4403_read_raw(struct iio_dev *indio_dev,
>  			if (ret)
>  				return ret;
>  			return IIO_VAL_INT;
> -		case IIO_CHAN_INFO_OFFSET:
> -			ret = regmap_read(afe->regmap, reg_info.offreg,
> -					  val);
> -			if (ret)
> -				return ret;
> -			*val &= reg_info.mask;
> -			*val >>= reg_info.shift;
> -			return IIO_VAL_INT;
>  		}
>  		break;
>  	case IIO_CURRENT:
> @@ -333,15 +325,6 @@ static int afe4403_write_raw(struct iio_dev *indio_dev,
>  	const struct afe440x_reg_info reg_info = afe4403_reg_info[chan->address];
>  
>  	switch (chan->type) {
> -	case IIO_INTENSITY:
> -		switch (mask) {
> -		case IIO_CHAN_INFO_OFFSET:
> -			return regmap_update_bits(afe->regmap,
> -				reg_info.offreg,
> -				reg_info.mask,
> -				(val << reg_info.shift));
> -		}
> -		break;
>  	case IIO_CURRENT:
>  		switch (mask) {
>  		case IIO_CHAN_INFO_RAW:
> 

