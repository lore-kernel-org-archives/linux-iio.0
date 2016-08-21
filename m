Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51132 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752930AbcHUK4D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 06:56:03 -0400
Subject: Re: [PATCH v2 1/3] iio: chemical: atlas-ph-sensor: switch to
 iio_device_*_direct_mode helpers
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1471638971-23039-1-git-send-email-mranostay@gmail.com>
 <1471638971-23039-2-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <96914544-91fa-8382-3f6a-3b3435b7035d@kernel.org>
Date: Sun, 21 Aug 2016 11:56:01 +0100
MIME-Version: 1.0
In-Reply-To: <1471638971-23039-2-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/08/16 21:36, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/chemical/atlas-ph-sensor.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index ae038a59d256..696875413d10 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -402,15 +402,13 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
>  		case IIO_PH:
>  		case IIO_CONCENTRATION:
>  		case IIO_ELECTRICALCONDUCTIVITY:
> -			mutex_lock(&indio_dev->mlock);
> +			ret = iio_device_claim_direct_mode(indio_dev);
> +			if (ret)
> +				return ret;
>  
> -			if (iio_buffer_enabled(indio_dev))
> -				ret = -EBUSY;
> -			else
> -				ret = atlas_read_measurement(data,
> -							chan->address, &reg);
> +			ret = atlas_read_measurement(data, chan->address, &reg);
>  
> -			mutex_unlock(&indio_dev->mlock);
> +			iio_device_release_direct_mode(indio_dev);
>  			break;
>  		default:
>  			ret = -EINVAL;
> 

