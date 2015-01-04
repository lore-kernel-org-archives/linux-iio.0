Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49796 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbADQ1H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 11:27:07 -0500
Message-ID: <54A969D9.8010408@kernel.org>
Date: Sun, 04 Jan 2015 16:27:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 06/11] iio: bmc150: refactor interrupt enabling
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com> <1419122556-8100-7-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1419122556-8100-7-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/12/14 00:42, Octavian Purdila wrote:
> This patch combines the any motion and new data interrupts function
> into a single, generic, interrupt enable function. On top of this, we
> can later refactor triggers to make it easier to add new triggers.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Some really trivial suggests inline.  Looks good even without it being
useful for later stuff ;)
> ---
>  drivers/iio/accel/bmc150-accel.c | 269 ++++++++++++++++-----------------------
>  1 file changed, 113 insertions(+), 156 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index 92f1d2b..53d1d1d 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -144,6 +144,13 @@ struct bmc150_accel_chip_info {
>  	const struct bmc150_scale_info scale_table[4];
>  };
>
I'd be tempted to define this at the place where you fill them below...
> +struct bmc150_accel_interrupt_info {
> +	u8 map_reg;
> +	u8 map_bitmask;
> +	u8 en_reg;
> +	u8 en_bitmask;
> +};
> +
>  struct bmc150_accel_data {
>  	struct i2c_client *client;
>  	struct iio_trigger *dready_trig;
> @@ -375,137 +382,6 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  	return 0;
>  }
>  
> -static int bmc150_accel_setup_any_motion_interrupt(
> -					struct bmc150_accel_data *data,
> -					bool status)
> -{
> -	int ret;
> -
> -	/* Enable/Disable INT1 mapping */
> -	ret = i2c_smbus_read_byte_data(data->client,
> -				       BMC150_ACCEL_REG_INT_MAP_0);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading reg_int_map_0\n");
> -		return ret;
> -	}
> -	if (status)
> -		ret |= BMC150_ACCEL_INT_MAP_0_BIT_SLOPE;
> -	else
> -		ret &= ~BMC150_ACCEL_INT_MAP_0_BIT_SLOPE;
> -
> -	ret = i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_MAP_0,
> -					ret);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_map_0\n");
> -		return ret;
> -	}
> -
> -	if (status) {
> -		/*
> -		 * New data interrupt is always non-latched,
> -		 * which will have higher priority, so no need
> -		 * to set latched mode, we will be flooded anyway with INTR
> -		 */
> -		if (!data->dready_trigger_on) {
> -			ret = i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_RST_LATCH,
> -					BMC150_ACCEL_INT_MODE_LATCH_INT |
> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> -			if (ret < 0) {
> -				dev_err(&data->client->dev,
> -					"Error writing reg_int_rst_latch\n");
> -				return ret;
> -			}
> -		}
> -
> -		ret = i2c_smbus_write_byte_data(data->client,
> -						BMC150_ACCEL_REG_INT_EN_0,
> -						BMC150_ACCEL_INT_EN_BIT_SLP_X |
> -						BMC150_ACCEL_INT_EN_BIT_SLP_Y |
> -						BMC150_ACCEL_INT_EN_BIT_SLP_Z);
> -	} else
> -		ret = i2c_smbus_write_byte_data(data->client,
> -						BMC150_ACCEL_REG_INT_EN_0,
> -						0);
> -
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_en_0\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int bmc150_accel_setup_new_data_interrupt(struct bmc150_accel_data *data,
> -					   bool status)
> -{
> -	int ret;
> -
> -	/* Enable/Disable INT1 mapping */
> -	ret = i2c_smbus_read_byte_data(data->client,
> -				       BMC150_ACCEL_REG_INT_MAP_1);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading reg_int_map_1\n");
> -		return ret;
> -	}
> -	if (status)
> -		ret |= BMC150_ACCEL_INT_MAP_1_BIT_DATA;
> -	else
> -		ret &= ~BMC150_ACCEL_INT_MAP_1_BIT_DATA;
> -
> -	ret = i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_MAP_1,
> -					ret);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_map_1\n");
> -		return ret;
> -	}
> -
> -	if (status) {
> -		/*
> -		 * Set non latched mode interrupt and clear any latched
> -		 * interrupt
> -		 */
> -		ret = i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_RST_LATCH,
> -					BMC150_ACCEL_INT_MODE_NON_LATCH_INT |
> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> -		if (ret < 0) {
> -			dev_err(&data->client->dev,
> -				"Error writing reg_int_rst_latch\n");
> -			return ret;
> -		}
> -
> -		ret = i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_EN_1,
> -					BMC150_ACCEL_INT_EN_BIT_DATA_EN);
> -
> -	} else {
> -		/* Restore default interrupt mode */
> -		ret = i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_RST_LATCH,
> -					BMC150_ACCEL_INT_MODE_LATCH_INT |
> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> -		if (ret < 0) {
> -			dev_err(&data->client->dev,
> -				"Error writing reg_int_rst_latch\n");
> -			return ret;
> -		}
> -
> -		ret = i2c_smbus_write_byte_data(data->client,
> -						BMC150_ACCEL_REG_INT_EN_1,
> -						0);
> -	}
> -
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_en_1\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int bmc150_accel_get_bw(struct bmc150_accel_data *data, int *val,
>  			       int *val2)
>  {
> @@ -560,6 +436,97 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>  }
>  #endif
>  
> +static struct bmc150_accel_interrupt_info bmc150_accel_interrupts[] = {
> +	{ /* data ready interrupt */
> +		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
> +		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_DATA,
> +		.en_reg = BMC150_ACCEL_REG_INT_EN_1,
> +		.en_bitmask = BMC150_ACCEL_INT_EN_BIT_DATA_EN,
> +	},
> +	{  /* motion interrupt */
> +		.map_reg = BMC150_ACCEL_REG_INT_MAP_0,
> +		.map_bitmask = BMC150_ACCEL_INT_MAP_0_BIT_SLOPE,
> +		.en_reg = BMC150_ACCEL_REG_INT_EN_0,
> +		.en_bitmask =  BMC150_ACCEL_INT_EN_BIT_SLP_X |
> +			BMC150_ACCEL_INT_EN_BIT_SLP_Y |
> +			BMC150_ACCEL_INT_EN_BIT_SLP_Z
> +	},
> +};
> +
> +static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data,
> +				      struct bmc150_accel_interrupt_info *info,
> +				      bool state)
> +{
> +	int ret;
> +
> +	/*
> +	 * We will expect the enable and disable to do operation in
> +	 * in reverse order. This will happen here anyway as our
> +	 * resume operation uses sync mode runtime pm calls, the
> +	 * suspend operation will be delayed by autosuspend delay
> +	 * So the disable operation will still happen in reverse of
> +	 * enable operation. When runtime pm is disabled the mode
> +	 * is always on so sequence doesn't matter
> +	 */
> +	ret = bmc150_accel_set_power_state(data, state);
> +	if (ret < 0)
> +		return ret;
> +
> +
> +	/* map the interrupt to the appropriate pins */
> +	ret = i2c_smbus_read_byte_data(data->client, info->map_reg);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_int_map\n");
> +		return ret;
> +	}
> +	if (state)
> +		ret |= info->map_bitmask;
> +	else
> +		ret &= ~info->map_bitmask;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, info->map_reg,
> +					ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_int_map\n");
> +		return ret;
> +	}
> +
> +	/* enable/disable the interrupt */
> +	ret = i2c_smbus_read_byte_data(data->client, info->en_reg);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_int_en\n");
> +		return ret;
> +	}
> +
> +	if (state)
> +		ret |= info->en_bitmask;
> +	else
> +		ret &= ~info->en_bitmask;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, info->en_reg, ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_int_en\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmc150_accel_setup_any_motion_interrupt(
> +					struct bmc150_accel_data *data,
> +					bool status)
> +{
> +	return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[1],
Maybe define a matching enum so the indexes are obvious.
Then is there a lot of point in having these wrappers? I'd just call
it directly so you'd get something like.

bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[bmc150_int_any_mo],
			   status);
> +					  status);
> +}
> +
> +static int bmc150_accel_setup_new_data_interrupt(struct bmc150_accel_data *data,
> +					   bool status)
> +{
> +	return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[0],
> +					  status);
> +}
> +
>  static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>  {
>  	int ret, i;
> @@ -809,22 +776,6 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
>  		return 0;
>  	}
>  
> -	/*
> -	 * We will expect the enable and disable to do operation in
> -	 * in reverse order. This will happen here anyway as our
> -	 * resume operation uses sync mode runtime pm calls, the
> -	 * suspend operation will be delayed by autosuspend delay
> -	 * So the disable operation will still happen in reverse of
> -	 * enable operation. When runtime pm is disabled the mode
> -	 * is always on so sequence doesn't matter
> -	 */
> -
> -	ret = bmc150_accel_set_power_state(data, state);
> -	if (ret < 0) {
> -		mutex_unlock(&data->mutex);
> -		return ret;
> -	}
> -
>  	ret =  bmc150_accel_setup_any_motion_interrupt(data, state);
>  	if (ret < 0) {
>  		mutex_unlock(&data->mutex);
> @@ -1056,15 +1007,6 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  		return 0;
>  	}
>  
> -	/*
> -	 * Refer to comment in bmc150_accel_write_event_config for
> -	 * enable/disable operation order
> -	 */
> -	ret = bmc150_accel_set_power_state(data, state);
> -	if (ret < 0) {
> -		mutex_unlock(&data->mutex);
> -		return ret;
> -	}
>  	if (data->motion_trig == trig)
>  		ret =  bmc150_accel_setup_any_motion_interrupt(data, state);
>  	else
> @@ -1241,6 +1183,21 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  		if (ret)
>  			return ret;
>  
> +		/*
> +		 * Set latched mode interrupt. While certain interrupts are
> +		 * non-latched regardless of this settings (e.g. new data) we
> +		 * want to use latch mode when we can to prevent interrupt
> +		 * flooding.
> +		 */
> +		ret = i2c_smbus_write_byte_data(data->client,
> +						BMC150_ACCEL_REG_INT_RST_LATCH,
> +					     BMC150_ACCEL_INT_MODE_LATCH_RESET);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
> +			return ret;
> +		}
> +
> +
>  		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
>  							   "%s-dev%d",
>  							   indio_dev->name,
> 

