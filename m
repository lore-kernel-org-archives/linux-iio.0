Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42602 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbbDZSxr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:53:47 -0400
Message-ID: <553D3439.50802@kernel.org>
Date: Sun, 26 Apr 2015 19:53:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 13/17] iio: accel: mma9553: refactor mma9553_read_raw
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-14-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-14-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:41, Irina Tirdea wrote:
> Refactor code for simplicity and clarity.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  drivers/iio/accel/mma9553.c | 101 +++++++++++++++-----------------------------
>  1 file changed, 33 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 5755977..8bfc618 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -440,6 +440,32 @@ static int mma9553_init(struct mma9553_data *data)
>  	return mma9551_set_device_state(data->client, true);
>  }
>  
> +static int mma9553_read_status_word(struct mma9553_data *data, u16 reg,
> +				    u16 *tmp)
> +{
> +	bool powered_on;
> +	int ret;
> +
> +	/*
> +	 * The HW only counts steps and other dependent
> +	 * parameters (speed, distance, calories, activity)
> +	 * if power is on (from enabling an event or the
> +	 * step counter).
> +	 */
> +	powered_on = mma9553_is_any_event_enabled(data, false, 0) ||
> +		     data->stepcnt_enabled;
> +	if (!powered_on) {
> +		dev_err(&data->client->dev, "No channels enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&data->mutex);
> +	ret = mma9551_read_status_word(data->client, MMA9551_APPID_PEDOMETER,
> +				       reg, tmp);
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +
>  static int mma9553_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -448,70 +474,30 @@ static int mma9553_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  	u16 tmp;
>  	u8 activity;
> -	bool powered_on;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_STEPS:
> -			/*
> -			 * The HW only counts steps and other dependent
> -			 * parameters (speed, distance, calories, activity)
> -			 * if power is on (from enabling an event or the
> -			 * step counter).
> -			 */
> -			powered_on =
> -			    mma9553_is_any_event_enabled(data, false, 0) ||
> -			    data->stepcnt_enabled;
> -			if (!powered_on) {
> -				dev_err(&data->client->dev,
> -					"No channels enabled\n");
> -				return -EINVAL;
> -			}
> -			mutex_lock(&data->mutex);
> -			ret = mma9551_read_status_word(data->client,
> -						       MMA9551_APPID_PEDOMETER,
> +			ret = mma9553_read_status_word(data,
>  						       MMA9553_REG_STEPCNT,
>  						       &tmp);
> -			mutex_unlock(&data->mutex);
>  			if (ret < 0)
>  				return ret;
>  			*val = tmp;
>  			return IIO_VAL_INT;
>  		case IIO_DISTANCE:
> -			powered_on =
> -			    mma9553_is_any_event_enabled(data, false, 0) ||
> -			    data->stepcnt_enabled;
> -			if (!powered_on) {
> -				dev_err(&data->client->dev,
> -					"No channels enabled\n");
> -				return -EINVAL;
> -			}
> -			mutex_lock(&data->mutex);
> -			ret = mma9551_read_status_word(data->client,
> -						       MMA9551_APPID_PEDOMETER,
> +			ret = mma9553_read_status_word(data,
>  						       MMA9553_REG_DISTANCE,
>  						       &tmp);
> -			mutex_unlock(&data->mutex);
>  			if (ret < 0)
>  				return ret;
>  			*val = tmp;
>  			return IIO_VAL_INT;
>  		case IIO_ACTIVITY:
> -			powered_on =
> -			    mma9553_is_any_event_enabled(data, false, 0) ||
> -			    data->stepcnt_enabled;
> -			if (!powered_on) {
> -				dev_err(&data->client->dev,
> -					"No channels enabled\n");
> -				return -EINVAL;
> -			}
> -			mutex_lock(&data->mutex);
> -			ret = mma9551_read_status_word(data->client,
> -						       MMA9551_APPID_PEDOMETER,
> +			ret = mma9553_read_status_word(data,
>  						       MMA9553_REG_STATUS,
>  						       &tmp);
> -			mutex_unlock(&data->mutex);
>  			if (ret < 0)
>  				return ret;
>  
> @@ -536,38 +522,17 @@ static int mma9553_read_raw(struct iio_dev *indio_dev,
>  		case IIO_VELOCITY:	/* m/h */
>  			if (chan->channel2 != IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z)
>  				return -EINVAL;
> -			powered_on =
> -			    mma9553_is_any_event_enabled(data, false, 0) ||
> -			    data->stepcnt_enabled;
> -			if (!powered_on) {
> -				dev_err(&data->client->dev,
> -					"No channels enabled\n");
> -				return -EINVAL;
> -			}
> -			mutex_lock(&data->mutex);
> -			ret = mma9551_read_status_word(data->client,
> -						       MMA9551_APPID_PEDOMETER,
> -						       MMA9553_REG_SPEED, &tmp);
> -			mutex_unlock(&data->mutex);
> +			ret = mma9553_read_status_word(data,
> +						       MMA9553_REG_SPEED,
> +						       &tmp);
>  			if (ret < 0)
>  				return ret;
>  			*val = tmp;
>  			return IIO_VAL_INT;
>  		case IIO_ENERGY:	/* Cal or kcal */
> -			powered_on =
> -			    mma9553_is_any_event_enabled(data, false, 0) ||
> -			    data->stepcnt_enabled;
> -			if (!powered_on) {
> -				dev_err(&data->client->dev,
> -					"No channels enabled\n");
> -				return -EINVAL;
> -			}
> -			mutex_lock(&data->mutex);
> -			ret = mma9551_read_status_word(data->client,
> -						       MMA9551_APPID_PEDOMETER,
> +			ret = mma9553_read_status_word(data,
>  						       MMA9553_REG_CALORIES,
>  						       &tmp);
> -			mutex_unlock(&data->mutex);
>  			if (ret < 0)
>  				return ret;
>  			*val = tmp;
> 

