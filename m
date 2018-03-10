Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751169AbeCJOmb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Mar 2018 09:42:31 -0500
Date: Sat, 10 Mar 2018 14:42:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 06/12] staging: iio: tsl2x7x: correctly return errors in
 tsl2x7x_get_prox()
Message-ID: <20180310144225.547f4ec3@archlinux>
In-Reply-To: <20180304014942.18727-7-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
        <20180304014942.18727-7-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Mar 2018 20:49:36 -0500
Brian Masney <masneyb@onstation.org> wrote:

> Not all errors that occurred in tsl2x7x_get_prox() were correctly
> reported in the return value. This patch changes the error handling
> so that errors are now returned properly.
> 
> Note that the ret variable is from the call to tsl2x7x_read_status(),
> and it already has the correct error check. The -EINVAL error code is
> for an unexpected value in the register.
> 
> This patch also corrects an unnecessary word wrap in the call to
> le16_to_cpup() while changes are being made to this code.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Good cleanup.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to work their magic.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 5c611250127f..cc209b64ed5a 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -489,16 +489,20 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  	case tmd2671:
>  	case tsl2771:
>  	case tmd2771:
> -		if (!(ret & TSL2X7X_STA_ADC_VALID))
> +		if (!(ret & TSL2X7X_STA_ADC_VALID)) {
> +			ret = -EINVAL;
>  			goto prox_poll_err;
> +		}
>  		break;
>  	case tsl2572:
>  	case tsl2672:
>  	case tmd2672:
>  	case tsl2772:
>  	case tmd2772:
> -		if (!(ret & TSL2X7X_STA_PRX_VALID))
> +		if (!(ret & TSL2X7X_STA_PRX_VALID)) {
> +			ret = -EINVAL;
>  			goto prox_poll_err;
> +		}
>  		break;
>  	}
>  
> @@ -512,14 +516,13 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  		chdata[i] = ret;
>  	}
>  
> -	chip->prox_data =
> -			le16_to_cpup((const __le16 *)&chdata[0]);
> +	chip->prox_data = le16_to_cpup((const __le16 *)&chdata[0]);
> +	ret = chip->prox_data;
>  
>  prox_poll_err:
> -
>  	mutex_unlock(&chip->prox_mutex);
>  
> -	return chip->prox_data;
> +	return ret;
>  }
>  
>  /**

