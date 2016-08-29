Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41992 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753534AbcH2Q4e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 12:56:34 -0400
Subject: Re: [PATCH v2 4/4] iio: chemical: vz89x: remove mutex and replace
 with iio_device_*_direct_mode
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1472107490-11924-1-git-send-email-mranostay@gmail.com>
 <1472107490-11924-5-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5fcf7baf-2189-fd83-c24a-2981c2bbf483@kernel.org>
Date: Mon, 29 Aug 2016 17:56:32 +0100
MIME-Version: 1.0
In-Reply-To: <1472107490-11924-5-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/08/16 07:44, Matt Ranostay wrote:
> There is no reason to have a seperate mutex when indio_dev->mlock can
> be used with the iio_device_*_direct_mode helpers. Also avoid a race
> condition that is possible with multiple IIO_RESISTANCE reads.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Hi Matt,

Hmm. I'm wondering a bit if I jumped the gun in the previous review
of a patch like this.

To my mind these functions are always about preventing mode switches
or multiple reads of the _raw attributes clashing.

I suppose the second case is true here.  If you were for example
also protecting the reading of a scale register, it would be
less obvious though and it's that blur I don't like.

I think I'd still prefer to keep the explicit mutex in place here
and fix the race more directly...

Close run thing though, you nearly had me persuaded :)

Jonathan
> ---
>  drivers/iio/chemical/vz89x.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index cd3870ead3fd..5e5d4a9abe63 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -16,7 +16,6 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/mutex.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
>  #include <linux/of.h>
> @@ -52,7 +51,6 @@ struct vz89x_chip_data;
>  struct vz89x_data {
>  	struct i2c_client *client;
>  	const struct vz89x_chip_data *chip;
> -	struct mutex lock;
>  	int (*xfer)(struct vz89x_data *data, u8 cmd);
>  
>  	bool is_valid;
> @@ -277,26 +275,32 @@ static int vz89x_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&data->lock);
> -		ret = vz89x_get_measurement(data);
> -		mutex_unlock(&data->lock);
> -
> +		ret = iio_device_claim_direct_mode(indio_dev);
>  		if (ret)
>  			return ret;
>  
> +		ret = vz89x_get_measurement(data);
> +		if (ret)
> +			goto error_out;
> +
>  		switch (chan->type) {
>  		case IIO_CONCENTRATION:
>  			*val = data->buffer[chan->address];
> -			return IIO_VAL_INT;
> +			ret = IIO_VAL_INT;
> +			break;
>  		case IIO_RESISTANCE:
>  			ret = vz89x_get_resistance_reading(data, chan, val);
>  			if (!ret)
> -				return IIO_VAL_INT;
> +				ret = IIO_VAL_INT;
>  			break;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
>  		}
> -		break;
> +
> +error_out:
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_RESISTANCE:
> @@ -390,7 +394,6 @@ static int vz89x_probe(struct i2c_client *client,
>  	data->client = client;
>  	data->chip = &vz89x_chips[chip_id];
>  	data->last_update = jiffies - HZ;
> -	mutex_init(&data->lock);
>  
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->info = &vz89x_info,
> 

