Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44443 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbbJCLIZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Oct 2015 07:08:25 -0400
Subject: Re: [PATCH v3 1/4] iio: bmc150: Use i2c regmap
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
	Markus Pargmann <mpa@pengutronix.de>
References: <1442832916-30774-1-git-send-email-mpa@pengutronix.de>
 <1442832916-30774-2-git-send-email-mpa@pengutronix.de>
 <1F3AC3675D538145B1661F571FE1805F2F0E78F1@irsmsx105.ger.corp.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <560FB727.9080702@kernel.org>
Date: Sat, 3 Oct 2015 12:08:23 +0100
MIME-Version: 1.0
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0E78F1@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/15 13:47, Tirdea, Irina wrote:
> 
> 
>> -----Original Message-----
>> From: Markus Pargmann [mailto:mpa@pengutronix.de]
>> Sent: 21 September, 2015 13:55
>> To: Jonathan Cameron
>> Cc: Srinivas Pandruvada; Tirdea, Irina; Lars-Peter Clausen; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
>> kernel@pengutronix.de; Markus Pargmann
>> Subject: [PATCH v3 1/4] iio: bmc150: Use i2c regmap
>>
>> This replaces all usage of direct i2c accesses with regmap accesses.
>>
>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> Tested-by: Irina Tirdea <irina.tirdea@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
>> ---
>>  drivers/iio/accel/Kconfig        |   2 +
>>  drivers/iio/accel/bmc150-accel.c | 225 +++++++++++++++++----------------------
>>  2 files changed, 99 insertions(+), 128 deletions(-)
>>
>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>> index a59047d7657e..3ff2c83f7492 100644
>> --- a/drivers/iio/accel/Kconfig
>> +++ b/drivers/iio/accel/Kconfig
>> @@ -22,6 +22,8 @@ config BMC150_ACCEL
>>  	depends on I2C
>>  	select IIO_BUFFER
>>  	select IIO_TRIGGERED_BUFFER
>> +	select REGMAP
>> +	select REGMAP_I2C
>>  	help
>>  	  Say yes here to build support for the following Bosch accelerometers:
>>  	  BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
>> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
>> index 0104cdef8709..a17034fd53fb 100644
>> --- a/drivers/iio/accel/bmc150-accel.c
>> +++ b/drivers/iio/accel/bmc150-accel.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/iio/trigger.h>
>>  #include <linux/iio/trigger_consumer.h>
>>  #include <linux/iio/triggered_buffer.h>
>> +#include <linux/regmap.h>
>>
>>  #define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
>>  #define BMC150_ACCEL_IRQ_NAME			"bmc150_accel_event"
>> @@ -186,6 +187,8 @@ enum bmc150_accel_trigger_id {
>>
>>  struct bmc150_accel_data {
>>  	struct i2c_client *client;
>> +	struct regmap *regmap;
>> +	struct device *dev;
>>  	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
>>  	atomic_t active_intr;
>>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>> @@ -242,6 +245,12 @@ static const struct {
>>  				       {500000, BMC150_ACCEL_SLEEP_500_MS},
>>  				       {1000000, BMC150_ACCEL_SLEEP_1_SEC} };
>>
>> +static const struct regmap_config bmc150_i2c_regmap_conf = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.max_register = 0x3f,
>> +};
>> +
>>  static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
>>  				 enum bmc150_power_modes mode,
>>  				 int dur_us)
>> @@ -271,8 +280,7 @@ static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
>>
>>  	dev_dbg(&data->client->dev, "Set Mode bits %x\n", lpw_bits);
>>
>> -	ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_PMU_LPW, lpw_bits);
>> +	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_LPW, lpw_bits);
>>  	if (ret < 0) {
>>  		dev_err(&data->client->dev, "Error writing reg_pmu_lpw\n");
>>  		return ret;
>> @@ -290,8 +298,7 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
>>  	for (i = 0; i < ARRAY_SIZE(bmc150_accel_samp_freq_table); ++i) {
>>  		if (bmc150_accel_samp_freq_table[i].val == val &&
>>  		    bmc150_accel_samp_freq_table[i].val2 == val2) {
>> -			ret = i2c_smbus_write_byte_data(
>> -				data->client,
>> +			ret = regmap_write(data->regmap,
>>  				BMC150_ACCEL_REG_PMU_BW,
>>  				bmc150_accel_samp_freq_table[i].bw_bits);
>>  			if (ret < 0)
>> @@ -308,26 +315,19 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
>>
>>  static int bmc150_accel_update_slope(struct bmc150_accel_data *data)
>>  {
>> -	int ret, val;
>> +	int ret;
>>
>> -	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_6,
>> +	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_6,
>>  					data->slope_thres);
>>  	if (ret < 0) {
>>  		dev_err(&data->client->dev, "Error writing reg_int_6\n");
>>  		return ret;
>>  	}
>>
>> -	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_INT_5);
>> +	ret = regmap_update_bits(data->regmap, BMC150_ACCEL_REG_INT_5,
>> +				 BMC150_ACCEL_SLOPE_DUR_MASK, data->slope_dur);
>>  	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error reading reg_int_5\n");
>> -		return ret;
>> -	}
>> -
>> -	val = (ret & ~BMC150_ACCEL_SLOPE_DUR_MASK) | data->slope_dur;
>> -	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_5,
>> -					val);
>> -	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error write reg_int_5\n");
>> +		dev_err(&data->client->dev, "Error updating reg_int_5\n");
>>  		return ret;
>>  	}
>>
>> @@ -470,38 +470,18 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>>  		return ret;
>>
>>  	/* map the interrupt to the appropriate pins */
>> -	ret = i2c_smbus_read_byte_data(data->client, info->map_reg);
>> -	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error reading reg_int_map\n");
>> -		goto out_fix_power_state;
>> -	}
>> -	if (state)
>> -		ret |= info->map_bitmask;
>> -	else
>> -		ret &= ~info->map_bitmask;
>> -
>> -	ret = i2c_smbus_write_byte_data(data->client, info->map_reg,
>> -					ret);
>> +	ret = regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
>> +				 (state ? info->map_bitmask : 0));
>>  	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error writing reg_int_map\n");
>> +		dev_err(&data->client->dev, "Error updating reg_int_map\n");
>>  		goto out_fix_power_state;
>>  	}
>>
>>  	/* enable/disable the interrupt */
>> -	ret = i2c_smbus_read_byte_data(data->client, info->en_reg);
>> +	ret = regmap_update_bits(data->regmap, info->en_reg, info->en_bitmask,
>> +				 (state ? info->en_bitmask : 0));
>>  	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error reading reg_int_en\n");
>> -		goto out_fix_power_state;
>> -	}
>> -
>> -	if (state)
>> -		ret |= info->en_bitmask;
>> -	else
>> -		ret &= ~info->en_bitmask;
>> -
>> -	ret = i2c_smbus_write_byte_data(data->client, info->en_reg, ret);
>> -	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error writing reg_int_en\n");
>> +		dev_err(&data->client->dev, "Error updating reg_int_en\n");
>>  		goto out_fix_power_state;
>>  	}
>>
>> @@ -523,8 +503,7 @@ static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>>
>>  	for (i = 0; i < ARRAY_SIZE(data->chip_info->scale_table); ++i) {
>>  		if (data->chip_info->scale_table[i].scale == val) {
>> -			ret = i2c_smbus_write_byte_data(
>> -				     data->client,
>> +			ret = regmap_write(data->regmap,
>>  				     BMC150_ACCEL_REG_PMU_RANGE,
>>  				     data->chip_info->scale_table[i].reg_range);
>>  			if (ret < 0) {
>> @@ -544,16 +523,17 @@ static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>>  static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *val)
>>  {
>>  	int ret;
>> +	unsigned int value;
>>
>>  	mutex_lock(&data->mutex);
>>
>> -	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_TEMP);
>> +	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_TEMP, &value);
>>  	if (ret < 0) {
>>  		dev_err(&data->client->dev, "Error reading reg_temp\n");
>>  		mutex_unlock(&data->mutex);
>>  		return ret;
>>  	}
>> -	*val = sign_extend32(ret, 7);
>> +	*val = sign_extend32(value, 7);
>>
>>  	mutex_unlock(&data->mutex);
>>
>> @@ -566,6 +546,7 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
>>  {
>>  	int ret;
>>  	int axis = chan->scan_index;
>> +	unsigned int raw_val;
>>
>>  	mutex_lock(&data->mutex);
>>  	ret = bmc150_accel_set_power_state(data, true);
>> @@ -574,15 +555,15 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
>>  		return ret;
>>  	}
>>
>> -	ret = i2c_smbus_read_word_data(data->client,
>> -				       BMC150_ACCEL_AXIS_TO_REG(axis));
>> +	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
>> +			       &raw_val, 2);
>>  	if (ret < 0) {
>>  		dev_err(&data->client->dev, "Error reading axis %d\n", axis);
>>  		bmc150_accel_set_power_state(data, false);
>>  		mutex_unlock(&data->mutex);
>>  		return ret;
>>  	}
>> -	*val = sign_extend32(ret >> chan->scan_type.shift,
>> +	*val = sign_extend32(raw_val >> chan->scan_type.shift,
>>  			     chan->scan_type.realbits - 1);
>>  	ret = bmc150_accel_set_power_state(data, false);
>>  	mutex_unlock(&data->mutex);
>> @@ -846,52 +827,34 @@ static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
>>   * We must read at least one full frame in one burst, otherwise the rest of the
>>   * frame data is discarded.
>>   */
>> -static int bmc150_accel_fifo_transfer(const struct i2c_client *client,
>> +static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
>>  				      char *buffer, int samples)
>>  {
>>  	int sample_length = 3 * 2;
>> -	u8 reg_fifo_data = BMC150_ACCEL_REG_FIFO_DATA;
>> -	int ret = -EIO;
>> -
>> -	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>> -		struct i2c_msg msg[2] = {
>> -			{
>> -				.addr = client->addr,
>> -				.flags = 0,
>> -				.buf = &reg_fifo_data,
>> -				.len = sizeof(reg_fifo_data),
>> -			},
>> -			{
>> -				.addr = client->addr,
>> -				.flags = I2C_M_RD,
>> -				.buf = (u8 *)buffer,
>> -				.len = samples * sample_length,
>> -			}
>> -		};
>> +	int ret;
>> +	int total_length = samples * sample_length;
>> +	int i;
>> +	size_t step = regmap_get_raw_read_max(data->regmap);
>>
>> -		ret = i2c_transfer(client->adapter, msg, 2);
>> -		if (ret != 2)
>> -			ret = -EIO;
>> -		else
>> -			ret = 0;
>> -	} else {
>> -		int i, step = I2C_SMBUS_BLOCK_MAX / sample_length;
>> -
>> -		for (i = 0; i < samples * sample_length; i += step) {
>> -			ret = i2c_smbus_read_i2c_block_data(client,
>> -							    reg_fifo_data, step,
>> -							    &buffer[i]);
>> -			if (ret != step) {
>> -				ret = -EIO;
>> -				break;
>> -			}
>> +	if (!step || step > total_length)
>> +		step = total_length;
>> +	else if (step < total_length)
>> +		step = sample_length;
>>
>> -			ret = 0;
>> -		}
>> +	/*
>> +	 * Seems we have a bus with size limitation so we have to execute
>> +	 * multiple reads
>> +	 */
>> +	for (i = 0; i < total_length; i += step) {
>> +		ret = regmap_raw_read(data->regmap, BMC150_ACCEL_REG_FIFO_DATA,
>> +				      &buffer[i], step);
>> +		if (ret)
>> +			break;
>>  	}
>>
>>  	if (ret)
>> -		dev_err(&client->dev, "Error transferring data from fifo\n");
>> +		dev_err(data->dev, "Error transferring data from fifo in single steps of %zu\n",
>> +			step);
>>
>>  	return ret;
>>  }
>> @@ -905,15 +868,15 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>>  	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
>>  	int64_t tstamp;
>>  	uint64_t sample_period;
>> +	unsigned int val;
>>
>> -	ret = i2c_smbus_read_byte_data(data->client,
>> -				       BMC150_ACCEL_REG_FIFO_STATUS);
>> +	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_FIFO_STATUS, &val);
>>  	if (ret < 0) {
>>  		dev_err(&data->client->dev, "Error reading reg_fifo_status\n");
>>  		return ret;
>>  	}
>>
>> -	count = ret & 0x7F;
>> +	count = val & 0x7F;
>>
>>  	if (!count)
>>  		return 0;
>> @@ -952,7 +915,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>>  	if (samples && count > samples)
>>  		count = samples;
>>
>> -	ret = bmc150_accel_fifo_transfer(data->client, (u8 *)buffer, count);
>> +	ret = bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
>>  	if (ret)
>>  		return ret;
>>
>> @@ -1155,17 +1118,19 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
>>  	struct iio_dev *indio_dev = pf->indio_dev;
>>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>>  	int bit, ret, i = 0;
>> +	unsigned int raw_val;
>>
>>  	mutex_lock(&data->mutex);
>>  	for_each_set_bit(bit, indio_dev->active_scan_mask,
>>  			 indio_dev->masklength) {
>> -		ret = i2c_smbus_read_word_data(data->client,
>> -					       BMC150_ACCEL_AXIS_TO_REG(bit));
>> +		ret = regmap_bulk_read(data->regmap,
>> +				       BMC150_ACCEL_AXIS_TO_REG(bit), &raw_val,
>> +				       2);
>>  		if (ret < 0) {
>>  			mutex_unlock(&data->mutex);
>>  			goto err_read;
>>  		}
>> -		data->buffer[i++] = ret;
>> +		data->buffer[i++] = raw_val;
>>  	}
>>  	mutex_unlock(&data->mutex);
>>
>> @@ -1189,10 +1154,9 @@ static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
>>
>>  	mutex_lock(&data->mutex);
>>  	/* clear any latched interrupt */
>> -	ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_INT_RST_LATCH,
>> -					BMC150_ACCEL_INT_MODE_LATCH_INT |
>> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
>> +	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
>> +			   BMC150_ACCEL_INT_MODE_LATCH_INT |
>> +			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>>  	mutex_unlock(&data->mutex);
>>  	if (ret < 0) {
>>  		dev_err(&data->client->dev,
>> @@ -1249,20 +1213,20 @@ static int bmc150_accel_handle_roc_event(struct iio_dev *indio_dev)
>>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>>  	int dir;
>>  	int ret;
>> +	unsigned int val;
>>
>> -	ret = i2c_smbus_read_byte_data(data->client,
>> -				       BMC150_ACCEL_REG_INT_STATUS_2);
>> +	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_INT_STATUS_2, &val);
>>  	if (ret < 0) {
>>  		dev_err(&data->client->dev, "Error reading reg_int_status_2\n");
>>  		return ret;
>>  	}
>>
>> -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_SIGN)
>> +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_SIGN)
>>  		dir = IIO_EV_DIR_FALLING;
>>  	else
>>  		dir = IIO_EV_DIR_RISING;
>>
>> -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_X)
>> +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_X)
>>  		iio_push_event(indio_dev,
>>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>>  						  0,
>> @@ -1271,7 +1235,7 @@ static int bmc150_accel_handle_roc_event(struct iio_dev *indio_dev)
>>  						  dir),
>>  			       data->timestamp);
>>
>> -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Y)
>> +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_Y)
>>  		iio_push_event(indio_dev,
>>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>>  						  0,
>> @@ -1280,7 +1244,7 @@ static int bmc150_accel_handle_roc_event(struct iio_dev *indio_dev)
>>  						  dir),
>>  			       data->timestamp);
>>
>> -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Z)
>> +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_Z)
>>  		iio_push_event(indio_dev,
>>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>>  						  0,
>> @@ -1315,10 +1279,9 @@ static irqreturn_t bmc150_accel_irq_thread_handler(int irq, void *private)
>>  	}
>>
>>  	if (ack) {
>> -		ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_INT_RST_LATCH,
>> -					BMC150_ACCEL_INT_MODE_LATCH_INT |
>> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
>> +		ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
>> +				   BMC150_ACCEL_INT_MODE_LATCH_INT |
>> +				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>>  		if (ret)
>>  			dev_err(&data->client->dev,
>>  				"Error writing reg_int_rst_latch\n");
>> @@ -1459,7 +1422,7 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
>>  	u8 reg = BMC150_ACCEL_REG_FIFO_CONFIG1;
>>  	int ret;
>>
>> -	ret = i2c_smbus_write_byte_data(data->client, reg, data->fifo_mode);
>> +	ret = regmap_write(data->regmap, reg, data->fifo_mode);
>>  	if (ret < 0) {
>>  		dev_err(&data->client->dev, "Error writing reg_fifo_config1\n");
>>  		return ret;
>> @@ -1468,9 +1431,8 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
>>  	if (!data->fifo_mode)
>>  		return 0;
>>
>> -	ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_FIFO_CONFIG0,
>> -					data->watermark);
>> +	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_FIFO_CONFIG0,
>> +			   data->watermark);
>>  	if (ret < 0)
>>  		dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
>>
>> @@ -1557,23 +1519,25 @@ static const struct iio_buffer_setup_ops bmc150_accel_buffer_ops = {
>>  static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>>  {
>>  	int ret, i;
>> +	unsigned int val;
>>
>> -	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_CHIP_ID);
>> +	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);
>>  	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error: Reading chip id\n");
>> +		dev_err(&data->client->dev,
>> +			"Error: Reading chip id\n");
>>  		return ret;
>>  	}
>>
>> -	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
>> +	dev_dbg(&data->client->dev, "Chip Id %x\n", val);
>>  	for (i = 0; i < ARRAY_SIZE(bmc150_accel_chip_info_tbl); i++) {
>> -		if (bmc150_accel_chip_info_tbl[i].chip_id == ret) {
>> +		if (bmc150_accel_chip_info_tbl[i].chip_id == val) {
>>  			data->chip_info = &bmc150_accel_chip_info_tbl[i];
>>  			break;
>>  		}
>>  	}
>>
>>  	if (!data->chip_info) {
>> -		dev_err(&data->client->dev, "Unsupported chip %x\n", ret);
>> +		dev_err(&data->client->dev, "Invalid chip %x\n", val);
>>  		return -ENODEV;
>>  	}
>>
>> @@ -1587,11 +1551,11 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>>  		return ret;
>>
>>  	/* Set Default Range */
>> -	ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_PMU_RANGE,
>> -					BMC150_ACCEL_DEF_RANGE_4G);
>> +	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_RANGE,
>> +			   BMC150_ACCEL_DEF_RANGE_4G);
>>  	if (ret < 0) {
>> -		dev_err(&data->client->dev, "Error writing reg_pmu_range\n");
>> +		dev_err(&data->client->dev,
>> +					"Error writing reg_pmu_range\n");
>>  		return ret;
>>  	}
>>
>> @@ -1605,10 +1569,9 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>>  		return ret;
>>
>>  	/* Set default as latched interrupts */
>> -	ret = i2c_smbus_write_byte_data(data->client,
>> -					BMC150_ACCEL_REG_INT_RST_LATCH,
>> -					BMC150_ACCEL_INT_MODE_LATCH_INT |
>> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
>> +	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
>> +			   BMC150_ACCEL_INT_MODE_LATCH_INT |
>> +			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>>  	if (ret < 0) {
>>  		dev_err(&data->client->dev,
>>  			"Error writing reg_int_rst_latch\n");
>> @@ -1633,6 +1596,13 @@ static int bmc150_accel_probe(struct i2c_client *client,
>>  	data = iio_priv(indio_dev);
>>  	i2c_set_clientdata(client, indio_dev);
>>  	data->client = client;
>> +	data->dev = &client->dev;
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf);
>> +	if (IS_ERR(data->regmap)) {
>> +		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
>> +		return PTR_ERR(data->regmap);
>> +	}
>>
>>  	if (id)
>>  		name = id->name;
>> @@ -1679,9 +1649,8 @@ static int bmc150_accel_probe(struct i2c_client *client,
>>  		 * want to use latch mode when we can to prevent interrupt
>>  		 * flooding.
>>  		 */
>> -		ret = i2c_smbus_write_byte_data(data->client,
>> -						BMC150_ACCEL_REG_INT_RST_LATCH,
>> -					     BMC150_ACCEL_INT_MODE_LATCH_RESET);
>> +		ret = regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
>> +				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>>  		if (ret < 0) {
>>  			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
>>  			goto err_buffer_cleanup;
>> --
>> 2.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

