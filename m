Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38673 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbbBHKjR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 05:39:17 -0500
Message-ID: <54D73CD3.7060005@kernel.org>
Date: Sun, 08 Feb 2015 10:39:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Octavian Purdila <octavian.purdila@intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 5/9] iio: bmc150: refactor interrupt enabling
References: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>	 <1422662408-8149-6-git-send-email-octavian.purdila@intel.com> <1423156019.2136.165.camel@spandruv-DESK3.jf.intel.com>
In-Reply-To: <1423156019.2136.165.camel@spandruv-DESK3.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/15 17:06, Srinivas Pandruvada wrote:
> On Sat, 2015-01-31 at 02:00 +0200, Octavian Purdila wrote: 
>> This patch combines the any motion and new data interrupts function
>> into a single, generic, interrupt enable function. On top of this, we
>> can later refactor triggers to make it easier to add new triggers.
>>
>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> 
Worthwhile little refactor on it's own.  Again would ideally have been
in a precursor series, but anyhow, applied to the togreg branch of iio.git.

Thanks,

>> ---
>>  drivers/iio/accel/bmc150-accel.c | 272 ++++++++++++++++-----------------------
>>  1 file changed, 113 insertions(+), 159 deletions(-)
>>
>> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
>> index 2b6b80d..0873925 100644
>> --- a/drivers/iio/accel/bmc150-accel.c
>> +++ b/drivers/iio/accel/bmc150-accel.c
>> @@ -359,137 +359,6 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>>  	return 0;
>>  }
>>  
>> -static int bmc150_accel_setup_any_motion_interrupt(
>> -					struct bmc150_accel_data *data,
>> -					bool status)
>> -{
>> -	int ret;
>> -
>> -	/* Enable/Disable INT1 mapping */
>> -	ret = i2c_smbus_read_byte_data(data->client,
>> -				       BMC150_ACCEL_REG_INT_MAP_0);
>> -	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error reading reg_int_map_0\n");
>> -		return ret;
>> -	}
>> -	if (status)
>> -		ret |= BMC150_ACCEL_INT_MAP_0_BIT_SLOPE;
>> -	else
>> -		ret &= ~BMC150_ACCEL_INT_MAP_0_BIT_SLOPE;
>> -
>> -	ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_INT_MAP_0,
>> -					ret);
>> -	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error writing reg_int_map_0\n");
>> -		return ret;
>> -	}
>> -
>> -	if (status) {
>> -		/*
>> -		 * New data interrupt is always non-latched,
>> -		 * which will have higher priority, so no need
>> -		 * to set latched mode, we will be flooded anyway with INTR
>> -		 */
>> -		if (!data->dready_trigger_on) {
>> -			ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_INT_RST_LATCH,
>> -					BMC150_ACCEL_INT_MODE_LATCH_INT |
>> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
>> -			if (ret < 0) {
>> -				dev_err(&data->client->dev,
>> -					"Error writing reg_int_rst_latch\n");
>> -				return ret;
>> -			}
>> -		}
>> -
>> -		ret = i2c_smbus_write_byte_data(data->client,
>> -						BMC150_ACCEL_REG_INT_EN_0,
>> -						BMC150_ACCEL_INT_EN_BIT_SLP_X |
>> -						BMC150_ACCEL_INT_EN_BIT_SLP_Y |
>> -						BMC150_ACCEL_INT_EN_BIT_SLP_Z);
>> -	} else
>> -		ret = i2c_smbus_write_byte_data(data->client,
>> -						BMC150_ACCEL_REG_INT_EN_0,
>> -						0);
>> -
>> -	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error writing reg_int_en_0\n");
>> -		return ret;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>> -static int bmc150_accel_setup_new_data_interrupt(struct bmc150_accel_data *data,
>> -					   bool status)
>> -{
>> -	int ret;
>> -
>> -	/* Enable/Disable INT1 mapping */
>> -	ret = i2c_smbus_read_byte_data(data->client,
>> -				       BMC150_ACCEL_REG_INT_MAP_1);
>> -	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error reading reg_int_map_1\n");
>> -		return ret;
>> -	}
>> -	if (status)
>> -		ret |= BMC150_ACCEL_INT_MAP_1_BIT_DATA;
>> -	else
>> -		ret &= ~BMC150_ACCEL_INT_MAP_1_BIT_DATA;
>> -
>> -	ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_INT_MAP_1,
>> -					ret);
>> -	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error writing reg_int_map_1\n");
>> -		return ret;
>> -	}
>> -
>> -	if (status) {
>> -		/*
>> -		 * Set non latched mode interrupt and clear any latched
>> -		 * interrupt
>> -		 */
>> -		ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_INT_RST_LATCH,
>> -					BMC150_ACCEL_INT_MODE_NON_LATCH_INT |
>> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
>> -		if (ret < 0) {
>> -			dev_err(&data->client->dev,
>> -				"Error writing reg_int_rst_latch\n");
>> -			return ret;
>> -		}
>> -
>> -		ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_INT_EN_1,
>> -					BMC150_ACCEL_INT_EN_BIT_DATA_EN);
>> -
>> -	} else {
>> -		/* Restore default interrupt mode */
>> -		ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_INT_RST_LATCH,
>> -					BMC150_ACCEL_INT_MODE_LATCH_INT |
>> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
>> -		if (ret < 0) {
>> -			dev_err(&data->client->dev,
>> -				"Error writing reg_int_rst_latch\n");
>> -			return ret;
>> -		}
>> -
>> -		ret = i2c_smbus_write_byte_data(data->client,
>> -						BMC150_ACCEL_REG_INT_EN_1,
>> -						0);
>> -	}
>> -
>> -	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error writing reg_int_en_1\n");
>> -		return ret;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  static int bmc150_accel_get_bw(struct bmc150_accel_data *data, int *val,
>>  			       int *val2)
>>  {
>> @@ -547,6 +416,105 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>>  }
>>  #endif
>>  
>> +static const struct bmc150_accel_interrupt_info {
>> +	u8 map_reg;
>> +	u8 map_bitmask;
>> +	u8 en_reg;
>> +	u8 en_bitmask;
>> +} bmc150_accel_interrupts[] = {
>> +	{ /* data ready interrupt */
>> +		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
>> +		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_DATA,
>> +		.en_reg = BMC150_ACCEL_REG_INT_EN_1,
>> +		.en_bitmask = BMC150_ACCEL_INT_EN_BIT_DATA_EN,
>> +	},
>> +	{  /* motion interrupt */
>> +		.map_reg = BMC150_ACCEL_REG_INT_MAP_0,
>> +		.map_bitmask = BMC150_ACCEL_INT_MAP_0_BIT_SLOPE,
>> +		.en_reg = BMC150_ACCEL_REG_INT_EN_0,
>> +		.en_bitmask =  BMC150_ACCEL_INT_EN_BIT_SLP_X |
>> +			BMC150_ACCEL_INT_EN_BIT_SLP_Y |
>> +			BMC150_ACCEL_INT_EN_BIT_SLP_Z
>> +	},
>> +};
>> +
>> +static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data,
>> +				const struct bmc150_accel_interrupt_info *info,
>> +				      bool state)
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * We will expect the enable and disable to do operation in
>> +	 * in reverse order. This will happen here anyway as our
>> +	 * resume operation uses sync mode runtime pm calls, the
>> +	 * suspend operation will be delayed by autosuspend delay
>> +	 * So the disable operation will still happen in reverse of
>> +	 * enable operation. When runtime pm is disabled the mode
>> +	 * is always on so sequence doesn't matter
>> +	 */
>> +	ret = bmc150_accel_set_power_state(data, state);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* map the interrupt to the appropriate pins */
>> +	ret = i2c_smbus_read_byte_data(data->client, info->map_reg);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Error reading reg_int_map\n");
>> +		goto out_fix_power_state;
>> +	}
>> +	if (state)
>> +		ret |= info->map_bitmask;
>> +	else
>> +		ret &= ~info->map_bitmask;
>> +
>> +	ret = i2c_smbus_write_byte_data(data->client, info->map_reg,
>> +					ret);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Error writing reg_int_map\n");
>> +		goto out_fix_power_state;
>> +	}
>> +
>> +	/* enable/disable the interrupt */
>> +	ret = i2c_smbus_read_byte_data(data->client, info->en_reg);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Error reading reg_int_en\n");
>> +		goto out_fix_power_state;
>> +	}
>> +
>> +	if (state)
>> +		ret |= info->en_bitmask;
>> +	else
>> +		ret &= ~info->en_bitmask;
>> +
>> +	ret = i2c_smbus_write_byte_data(data->client, info->en_reg, ret);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "Error writing reg_int_en\n");
>> +		goto out_fix_power_state;
>> +	}
>> +
>> +	return 0;
>> +
>> +out_fix_power_state:
>> +	bmc150_accel_set_power_state(data, false);
>> +	return ret;
>> +}
>> +
>> +static int bmc150_accel_setup_any_motion_interrupt(
>> +					struct bmc150_accel_data *data,
>> +					bool status)
>> +{
>> +	return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[1],
>> +					  status);
>> +}
>> +
>> +static int bmc150_accel_setup_new_data_interrupt(struct bmc150_accel_data *data,
>> +						 bool status)
>> +{
>> +	return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[0],
>> +					  status);
>> +}
>> +
>>  static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>>  {
>>  	int ret, i;
>> @@ -791,25 +759,8 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
>>  		return 0;
>>  	}
>>  
>> -	/*
>> -	 * We will expect the enable and disable to do operation in
>> -	 * in reverse order. This will happen here anyway as our
>> -	 * resume operation uses sync mode runtime pm calls, the
>> -	 * suspend operation will be delayed by autosuspend delay
>> -	 * So the disable operation will still happen in reverse of
>> -	 * enable operation. When runtime pm is disabled the mode
>> -	 * is always on so sequence doesn't matter
>> -	 */
>> -
>> -	ret = bmc150_accel_set_power_state(data, state);
>> -	if (ret < 0) {
>> -		mutex_unlock(&data->mutex);
>> -		return ret;
>> -	}
>> -
>>  	ret =  bmc150_accel_setup_any_motion_interrupt(data, state);
>>  	if (ret < 0) {
>> -		bmc150_accel_set_power_state(data, false);
>>  		mutex_unlock(&data->mutex);
>>  		return ret;
>>  	}
>> @@ -1039,16 +990,6 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
>>  		return 0;
>>  	}
>>  
>> -	/*
>> -	 * Refer to comment in bmc150_accel_write_event_config for
>> -	 * enable/disable operation order
>> -	 */
>> -	ret = bmc150_accel_set_power_state(data, state);
>> -	if (ret < 0) {
>> -		mutex_unlock(&data->mutex);
>> -		return ret;
>> -	}
>> -
>>  	if (data->motion_trig == trig) {
>>  		ret = bmc150_accel_update_slope(data);
>>  		if (!ret)
>> @@ -1058,7 +999,6 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
>>  		ret = bmc150_accel_setup_new_data_interrupt(data, state);
>>  	}
>>  	if (ret < 0) {
>> -		bmc150_accel_set_power_state(data, false);
>>  		mutex_unlock(&data->mutex);
>>  		return ret;
>>  	}
>> @@ -1244,6 +1184,20 @@ static int bmc150_accel_probe(struct i2c_client *client,
>>  		if (ret)
>>  			return ret;
>>  
>> +		/*
>> +		 * Set latched mode interrupt. While certain interrupts are
>> +		 * non-latched regardless of this settings (e.g. new data) we
>> +		 * want to use latch mode when we can to prevent interrupt
>> +		 * flooding.
>> +		 */
>> +		ret = i2c_smbus_write_byte_data(data->client,
>> +						BMC150_ACCEL_REG_INT_RST_LATCH,
>> +					     BMC150_ACCEL_INT_MODE_LATCH_RESET);
>> +		if (ret < 0) {
>> +			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
>> +			return ret;
>> +		}
>> +
>>  		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
>>  							   "%s-dev%d",
>>  							   indio_dev->name,
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

