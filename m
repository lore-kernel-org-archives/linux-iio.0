Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41759 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753564AbcH2QHo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 12:07:44 -0400
Subject: Re: [PATCH] iio: chemical: ams-iaq-core: remove mutex and replace
 with iio_device_*_direct_mode helpers
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1472013159-9903-1-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2c7455e3-5b4d-1ed4-9b59-4579cf5cd9c7@kernel.org>
Date: Mon, 29 Aug 2016 17:07:41 +0100
MIME-Version: 1.0
In-Reply-To: <1472013159-9903-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/08/16 05:32, Matt Ranostay wrote:
> Using a separate mutex doesn't make sense with the
> iio_device_*_direct_mode helpers that use the indio_dev->mlock mutex
> that already exists.
I'm not keen on using those wrappers for anything other
than what their naming defines (or the underlying mutex
for that matter). Their implementation is effectively
opaque to the drivers.

There are no guarantees that we won't do something different
and nefarious in there some time in the future.

Hence if there is an element of a driver that needs protecting
it makes sense to keep the lock explicitly in the driver
where it is nice and obvious that it is doing it's job.

Clearly we need to be careful about ordering to avoid deadlock,
but that's not exactly tricky in most cases!

Hence, I prefer this as it was before this patch.

Jonathan
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/iio/chemical/ams-iaq-core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
> index 41a8e6f2e31d..4dd5a4db6a75 100644
> --- a/drivers/iio/chemical/ams-iaq-core.c
> +++ b/drivers/iio/chemical/ams-iaq-core.c
> @@ -36,7 +36,6 @@ struct ams_iaqcore_reading {
>  
>  struct ams_iaqcore_data {
>  	struct i2c_client *client;
> -	struct mutex lock;
>  	unsigned long last_update;
>  
>  	struct ams_iaqcore_reading buffer;
> @@ -108,7 +107,10 @@ static int ams_iaqcore_read_raw(struct iio_dev *indio_dev,
>  	if (mask != IIO_CHAN_INFO_PROCESSED)
>  		return -EINVAL;
>  
> -	mutex_lock(&data->lock);
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = ams_iaqcore_get_measurement(data);
>  
>  	if (ret)
> @@ -134,7 +136,7 @@ static int ams_iaqcore_read_raw(struct iio_dev *indio_dev,
>  	}
>  
>  err_out:
> -	mutex_unlock(&data->lock);
> +	iio_device_release_direct_mode(indio_dev);
>  
>  	return ret;
>  }
> @@ -160,7 +162,6 @@ static int ams_iaqcore_probe(struct i2c_client *client,
>  
>  	/* so initial reading will complete */
>  	data->last_update = jiffies - HZ;
> -	mutex_init(&data->lock);
>  
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->info = &ams_iaqcore_info,
> 

