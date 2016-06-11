Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52046 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbcFKPzI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 11:55:08 -0400
Subject: Re: [PATCH] iio: proximity: lidar: switch to iio_device_claim_*_mode
 helpers
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1465359484-26568-1-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8ccdb2de-4315-3f39-12ad-716ee307d0cb@kernel.org>
Date: Sat, 11 Jun 2016 16:55:06 +0100
MIME-Version: 1.0
In-Reply-To: <1465359484-26568-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/06/16 05:18, Matt Ranostay wrote:
> Switch from using indio_dev->mlock to the iio_device_claim_*_mode
> helper functions.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
You beat Alison to it ;)

Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 4f502386..c0b0e82 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -203,22 +203,19 @@ static int lidar_read_raw(struct iio_dev *indio_dev,
>  	struct lidar_data *data = iio_priv(indio_dev);
>  	int ret = -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> -
> -	if (iio_buffer_enabled(indio_dev) && mask == IIO_CHAN_INFO_RAW) {
> -		ret = -EBUSY;
> -		goto error_busy;
> -	}
> -
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW: {
>  		u16 reg;
>  
> +		if (iio_device_claim_direct_mode(indio_dev))
> +			return -EBUSY;
> +
>  		ret = lidar_get_measurement(data, &reg);
>  		if (!ret) {
>  			*val = reg;
>  			ret = IIO_VAL_INT;
>  		}
> +		iio_device_release_direct_mode(indio_dev);
>  		break;
>  	}
>  	case IIO_CHAN_INFO_SCALE:
> @@ -228,9 +225,6 @@ static int lidar_read_raw(struct iio_dev *indio_dev,
>  		break;
>  	}
>  
> -error_busy:
> -	mutex_unlock(&indio_dev->mlock);
> -
>  	return ret;
>  }
>  
> 

