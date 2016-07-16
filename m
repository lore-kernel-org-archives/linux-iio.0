Return-Path: <amsfield22@gmail.com>
Date: Fri, 15 Jul 2016 22:23:42 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: humidity: hdc100x: move lock on config updates
 to single function
Message-ID: <20160716052341.GA1872@d830.WORKGROUP>
References: <cover.1468180067.git.amsfield22@gmail.com>
 <634a2c91a91bdbbe3e79872fffb4fbf2d804a59e.1468180067.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <634a2c91a91bdbbe3e79872fffb4fbf2d804a59e.1468180067.git.amsfield22@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jul 10, 2016 at 02:30:01PM -0700, Alison Schofield wrote:
> Move the config register locking to the config update function.  This
> continues to protect updates to heater and integration times. It puts
> the lock in one place, right where it needs to occur.

Since creating this patch, I've learned that it is a design choice in
kernel drivers to keep the locking at a higher level - ie point of entry.
This patch goes against that design, so, I get that it's not do-able.

alisons

> 
> Add the checkpatch required comment on this lock declaration.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> ---
>  drivers/iio/humidity/hdc100x.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index a03832a..ad5a12a 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -31,7 +31,7 @@
>  
>  struct hdc100x_data {
>  	struct i2c_client *client;
> -	struct mutex lock;
> +	struct mutex lock;  /* protect config updates & raw measurements */
>  	u16 config;
>  
>  	/* integration time of the sensor */
> @@ -108,10 +108,12 @@ static int hdc100x_update_config(struct hdc100x_data *data, int mask, int val)
>  	int tmp = (~mask & data->config) | val;
>  	int ret;
>  
> +	mutex_lock(&data->lock);
>  	ret = i2c_smbus_write_word_swapped(data->client,
>  						HDC100X_REG_CONFIG, tmp);
>  	if (!ret)
>  		data->config = tmp;
> +	mutex_unlock(&data->lock);
>  
>  	return ret;
>  }
> @@ -234,26 +236,20 @@ static int hdc100x_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct hdc100x_data *data = iio_priv(indio_dev);
> -	int ret = -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_INT_TIME:
>  		if (val != 0)
>  			return -EINVAL;
>  
> -		mutex_lock(&data->lock);
> -		ret = hdc100x_set_it_time(data, chan->address, val2);
> -		mutex_unlock(&data->lock);
> -		return ret;
> +		return hdc100x_set_it_time(data, chan->address, val2);
> +
>  	case IIO_CHAN_INFO_RAW:
>  		if (chan->type != IIO_CURRENT || val2 != 0)
>  			return -EINVAL;
>  
> -		mutex_lock(&data->lock);
> -		ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_HEATER_EN,
> +		return hdc100x_update_config(data, HDC100X_REG_CONFIG_HEATER_EN,
>  					val ? HDC100X_REG_CONFIG_HEATER_EN : 0);
> -		mutex_unlock(&data->lock);
> -		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.1.4
> 
