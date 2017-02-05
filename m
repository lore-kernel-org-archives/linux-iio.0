Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35658 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdBEK3f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2017 05:29:35 -0500
Subject: Re: [PATCH v2] iio:temperature:tmp007: Add irq and threshold events
 support
To: Manivannan Sadhasivam <manivannanece23@gmail.com>,
        pmeerw@pmeerw.net
References: <20170123155329.GA10922@gmail.com>
 <3574e708-d9e3-487c-5109-4df4ed012b08@kernel.org>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bc41a190-e786-2f6a-b52a-4a603742d776@kernel.org>
Date: Sun, 5 Feb 2017 10:29:33 +0000
MIME-Version: 1.0
In-Reply-To: <3574e708-d9e3-487c-5109-4df4ed012b08@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/01/17 12:27, Jonathan Cameron wrote:
> On 23/01/17 15:55, Manivannan Sadhasivam wrote:
>> This patch adds ALERT irq and limit threshold events support for TI TMP007 - 16 bit IR thermopile sensor with integrated
>> math engine.
>>
>> Following threshold events are supported:
>> 1. TObj high limit
>> 2. TObj low limit
>> 3. TDie high limit
>> 4. TDie low limit
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannanece23@gmail.com>
> This is complex enough I'm going to leave some more time for Peter to have
> look at it as well.
> 
> Looks fine to me.
Been long enough I think.

Applied to the togreg branch of iio.git and pushed out as testing.
Probably won't make the upcoming merge window.  Depends on what Linus
says when he pushes out the next rc (i.e. how far away the merge window
actually is!)

Jonathan
> 
> Jonathan
>> ---
>>
>> Changes in v2 (Based on Peter's suggestions)
>>
>> 1. Removed unwanted code cleanups
>> 2. Used mutex for reading status mask
>> 3. Minor code fixes
>>
>>  drivers/iio/temperature/tmp007.c | 277 +++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 265 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
>> index 24c6c16..eae2c29 100644
>> --- a/drivers/iio/temperature/tmp007.c
>> +++ b/drivers/iio/temperature/tmp007.c
>> @@ -11,9 +11,10 @@
>>   *
>>   * (7-bit I2C slave address (0x40 - 0x47), changeable via ADR pins)
>>   *
>> - * Note: This driver assumes that the sensor has been calibrated beforehand
>> - *
>> - * TODO: ALERT irq, limit threshold events
>> + * Note:
>> + * 1. This driver assumes that the sensor has been calibrated beforehand
>> + * 2. Limit threshold events are enabled at the start
>> + * 3. Operating mode: INT
>>   *
>>   */
>>  
>> @@ -24,25 +25,38 @@
>>  #include <linux/pm.h>
>>  #include <linux/bitops.h>
>>  #include <linux/of.h>
>> +#include <linux/irq.h>
>> +#include <linux/interrupt.h>
>>  
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>> +#include <linux/iio/events.h>
>>  
>>  #define TMP007_TDIE 0x01
>>  #define TMP007_CONFIG 0x02
>>  #define TMP007_TOBJECT 0x03
>>  #define TMP007_STATUS 0x04
>>  #define TMP007_STATUS_MASK 0x05
>> +#define TMP007_TOBJ_HIGH_LIMIT 0x06
>> +#define TMP007_TOBJ_LOW_LIMIT 0x07
>> +#define TMP007_TDIE_HIGH_LIMIT 0x08
>> +#define TMP007_TDIE_LOW_LIMIT 0x09
>>  #define TMP007_MANUFACTURER_ID 0x1e
>>  #define TMP007_DEVICE_ID 0x1f
>>  
>>  #define TMP007_CONFIG_CONV_EN BIT(12)
>> -#define TMP007_CONFIG_COMP_EN BIT(5)
>>  #define TMP007_CONFIG_TC_EN BIT(6)
>>  #define TMP007_CONFIG_CR_MASK GENMASK(11, 9)
>> +#define TMP007_CONFIG_ALERT_EN BIT(8)
>>  #define TMP007_CONFIG_CR_SHIFT 9
>>  
>> +/* Status register flags */
>> +#define TMP007_STATUS_ALERT BIT(15)
>>  #define TMP007_STATUS_CONV_READY BIT(14)
>> +#define TMP007_STATUS_OHF BIT(13)
>> +#define TMP007_STATUS_OLF BIT(12)
>> +#define TMP007_STATUS_LHF BIT(11)
>> +#define TMP007_STATUS_LLF BIT(10)
>>  #define TMP007_STATUS_DATA_VALID BIT(9)
>>  
>>  #define TMP007_MANUFACTURER_MAGIC 0x5449
>> @@ -52,7 +66,9 @@
>>  
>>  struct tmp007_data {
>>  	struct i2c_client *client;
>> +	struct mutex lock;
>>  	u16 config;
>> +	u16 status_mask;
>>  };
>>  
>>  static const int tmp007_avgs[5][2] = { {4, 0}, {2, 0}, {1, 0},
>> @@ -156,6 +172,188 @@ static int tmp007_write_raw(struct iio_dev *indio_dev,
>>  	return -EINVAL;
>>  }
>>  
>> +static irqreturn_t tmp007_interrupt_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *indio_dev = private;
>> +	struct tmp007_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret = i2c_smbus_read_word_swapped(data->client, TMP007_STATUS);
>> +	if ((ret < 0) || !(ret & (TMP007_STATUS_OHF | TMP007_STATUS_OLF |
>> +				TMP007_STATUS_LHF | TMP007_STATUS_LLF)))
>> +		return IRQ_NONE;
>> +
>> +	if (ret & TMP007_STATUS_OHF)
>> +		iio_push_event(indio_dev,
>> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
>> +					IIO_MOD_TEMP_OBJECT,
>> +					IIO_EV_TYPE_THRESH,
>> +					IIO_EV_DIR_RISING),
>> +				iio_get_time_ns(indio_dev));
>> +
>> +	if (ret & TMP007_STATUS_OLF)
>> +		iio_push_event(indio_dev,
>> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
>> +					IIO_MOD_TEMP_OBJECT,
>> +					IIO_EV_TYPE_THRESH,
>> +					IIO_EV_DIR_FALLING),
>> +				iio_get_time_ns(indio_dev));
>> +
>> +	if (ret & TMP007_STATUS_LHF)
>> +		iio_push_event(indio_dev,
>> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
>> +					IIO_MOD_TEMP_AMBIENT,
>> +					IIO_EV_TYPE_THRESH,
>> +					IIO_EV_DIR_RISING),
>> +				iio_get_time_ns(indio_dev));
>> +
>> +	if (ret & TMP007_STATUS_LLF)
>> +		iio_push_event(indio_dev,
>> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
>> +					IIO_MOD_TEMP_AMBIENT,
>> +					IIO_EV_TYPE_THRESH,
>> +					IIO_EV_DIR_FALLING),
>> +				iio_get_time_ns(indio_dev));
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int tmp007_write_event_config(struct iio_dev *indio_dev,
>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>> +		enum iio_event_direction dir, int state)
>> +{
>> +	struct tmp007_data *data = iio_priv(indio_dev);
>> +	unsigned int status_mask;
>> +	int ret;
>> +
>> +	switch (chan->channel2) {
>> +	case IIO_MOD_TEMP_AMBIENT:
>> +	if (dir == IIO_EV_DIR_RISING)
>> +			status_mask = TMP007_STATUS_LHF;
>> +		else
>> +			status_mask = TMP007_STATUS_LLF;
>> +		break;
>> +	case IIO_MOD_TEMP_OBJECT:
>> +		if (dir == IIO_EV_DIR_RISING)
>> +			status_mask = TMP007_STATUS_OHF;
>> +		else
>> +			status_mask = TMP007_STATUS_OLF;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = i2c_smbus_read_word_swapped(data->client, TMP007_STATUS_MASK);
>> +	mutex_unlock(&data->lock);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (state)
>> +		ret |= status_mask;
>> +	else
>> +		ret &= ~status_mask;
>> +
>> +	return i2c_smbus_write_word_swapped(data->client, TMP007_STATUS_MASK,
>> +					data->status_mask = ret);
>> +}
>> +
>> +static int tmp007_read_event_config(struct iio_dev *indio_dev,
>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>> +		enum iio_event_direction dir)
>> +{
>> +	struct tmp007_data *data = iio_priv(indio_dev);
>> +	unsigned int mask;
>> +
>> +	switch (chan->channel2) {
>> +	case IIO_MOD_TEMP_AMBIENT:
>> +		if (dir == IIO_EV_DIR_RISING)
>> +			mask = TMP007_STATUS_LHF;
>> +		else
>> +			mask = TMP007_STATUS_LLF;
>> +		break;
>> +	case IIO_MOD_TEMP_OBJECT:
>> +		if (dir == IIO_EV_DIR_RISING)
>> +			mask = TMP007_STATUS_OHF;
>> +		else
>> +			mask = TMP007_STATUS_OLF;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return !!(data->status_mask & mask);
>> +}
>> +
>> +static int tmp007_read_thresh(struct iio_dev *indio_dev,
>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>> +		enum iio_event_direction dir, enum iio_event_info info,
>> +		int *val, int *val2)
>> +{
>> +	struct tmp007_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +	u8 reg;
>> +
>> +	switch (chan->channel2) {
>> +	case IIO_MOD_TEMP_AMBIENT: /* LSB: 0.5 degree Celsius */
>> +		if (dir == IIO_EV_DIR_RISING)
>> +			reg = TMP007_TDIE_HIGH_LIMIT;
>> +		else
>> +			reg = TMP007_TDIE_LOW_LIMIT;
>> +		break;
>> +	case IIO_MOD_TEMP_OBJECT:
>> +		if (dir == IIO_EV_DIR_RISING)
>> +			reg = TMP007_TOBJ_HIGH_LIMIT;
>> +	else
>> +			reg = TMP007_TOBJ_LOW_LIMIT;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = i2c_smbus_read_word_swapped(data->client, reg);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Shift length 7 bits = 6(15:6) + 1(0.5 LSB) */
>> +	*val = sign_extend32(ret, 15) >> 7;
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int tmp007_write_thresh(struct iio_dev *indio_dev,
>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>> +		enum iio_event_direction dir, enum iio_event_info info,
>> +		int val, int val2)
>> +{
>> +	struct tmp007_data *data = iio_priv(indio_dev);
>> +	u8 reg;
>> +
>> +	switch (chan->channel2) {
>> +	case IIO_MOD_TEMP_AMBIENT:
>> +		if (dir == IIO_EV_DIR_RISING)
>> +			reg = TMP007_TDIE_HIGH_LIMIT;
>> +		else
>> +			reg = TMP007_TDIE_LOW_LIMIT;
>> +		break;
>> +	case IIO_MOD_TEMP_OBJECT:
>> +		if (dir == IIO_EV_DIR_RISING)
>> +			reg = TMP007_TOBJ_HIGH_LIMIT;
>> +		else
>> +			reg = TMP007_TOBJ_LOW_LIMIT;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Full scale threshold value is +/- 256 degree Celsius */
>> +	if (val < -256 || val > 255)
>> +		return -EINVAL;
>> +
>> +	/* Shift length 7 bits = 6(15:6) + 1(0.5 LSB) */
>> +	return i2c_smbus_write_word_swapped(data->client, reg, (val << 7));
>> +}
>> +
>>  static IIO_CONST_ATTR(sampling_frequency_available, "4 2 1 0.5 0.25");
>>  
>>  static struct attribute *tmp007_attributes[] = {
>> @@ -167,6 +365,36 @@ static const struct attribute_group tmp007_attribute_group = {
>>  	.attrs = tmp007_attributes,
>>  };
>>  
>> +static const struct iio_event_spec tmp007_obj_event[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_RISING,
>> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> +			BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_FALLING,
>> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> +			BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +};
>> +
>> +static const struct iio_event_spec tmp007_die_event[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_RISING,
>> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> +			BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_FALLING,
>> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> +			BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +};
>> +
>>  static const struct iio_chan_spec tmp007_channels[] = {
>>  	{
>>  		.type = IIO_TEMP,
>> @@ -175,6 +403,8 @@ static const struct iio_chan_spec tmp007_channels[] = {
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>  				BIT(IIO_CHAN_INFO_SCALE),
>>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		.event_spec = tmp007_die_event,
>> +		.num_event_specs = ARRAY_SIZE(tmp007_die_event),
>>  	},
>>  	{
>>  		.type = IIO_TEMP,
>> @@ -183,12 +413,18 @@ static const struct iio_chan_spec tmp007_channels[] = {
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>  				BIT(IIO_CHAN_INFO_SCALE),
>>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		.event_spec = tmp007_obj_event,
>> +		.num_event_specs = ARRAY_SIZE(tmp007_obj_event),
>>  	}
>>  };
>>  
>>  static const struct iio_info tmp007_info = {
>>  	.read_raw = tmp007_read_raw,
>>  	.write_raw = tmp007_write_raw,
>> +	.read_event_config = tmp007_read_event_config,
>> +	.write_event_config = tmp007_write_event_config,
>> +	.read_event_value = tmp007_read_thresh,
>> +	.write_event_value = tmp007_write_thresh,
>>  	.attrs = &tmp007_attribute_group,
>>  	.driver_module = THIS_MODULE,
>>  };
>> @@ -214,7 +450,6 @@ static int tmp007_probe(struct i2c_client *client,
>>  	struct tmp007_data *data;
>>  	struct iio_dev *indio_dev;
>>  	int ret;
>> -	u16  status;
>>  
>>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>>  		return -EOPNOTSUPP;
>> @@ -231,6 +466,7 @@ static int tmp007_probe(struct i2c_client *client,
>>  	data = iio_priv(indio_dev);
>>  	i2c_set_clientdata(client, indio_dev);
>>  	data->client = client;
>> +	mutex_init(&data->lock);
>>  
>>  	indio_dev->dev.parent = &client->dev;
>>  	indio_dev->name = dev_name(&client->dev);
>> @@ -243,7 +479,7 @@ static int tmp007_probe(struct i2c_client *client,
>>  	/*
>>  	 * Set Configuration register:
>>  	 * 1. Conversion ON
>> -	 * 2. Comparator mode
>> +	 * 2. ALERT enable
>>  	 * 3. Transient correction enable
>>  	 */
>>  
>> @@ -252,7 +488,7 @@ static int tmp007_probe(struct i2c_client *client,
>>  		return ret;
>>  
>>  	data->config = ret;
>> -	data->config |= (TMP007_CONFIG_CONV_EN | TMP007_CONFIG_COMP_EN | TMP007_CONFIG_TC_EN);
>> +	data->config |= (TMP007_CONFIG_CONV_EN | TMP007_CONFIG_ALERT_EN | TMP007_CONFIG_TC_EN);
>>  
>>  	ret = i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
>>  					data->config);
>> @@ -260,22 +496,39 @@ static int tmp007_probe(struct i2c_client *client,
>>  		return ret;
>>  
>>  	/*
>> +	 * Only the following flags can activate ALERT pin. Data conversion/validity flags
>> +	 * flags can still be polled for getting temperature data
>> +	 *
>>  	 * Set Status Mask register:
>> -	 * 1. Conversion ready enable
>> -	 * 2. Data valid enable
>> +	 * 1. Object temperature high limit enable
>> +	 * 2. Object temperature low limit enable
>> +	 * 3. TDIE temperature high limit enable
>> +	 * 4. TDIE temperature low limit enable
>>  	 */
>>  
>>  	ret = i2c_smbus_read_word_swapped(data->client, TMP007_STATUS_MASK);
>>  	if (ret < 0)
>>  		goto error_powerdown;
>>  
>> -	status = ret;
>> -	status |= (TMP007_STATUS_CONV_READY | TMP007_STATUS_DATA_VALID);
>> +	data->status_mask = ret;
>> +	data->status_mask |= (TMP007_STATUS_OHF | TMP007_STATUS_OLF
>> +				| TMP007_STATUS_LHF | TMP007_STATUS_LLF);
>>  
>> -	ret = i2c_smbus_write_word_swapped(data->client, TMP007_STATUS_MASK, status);
>> +	ret = i2c_smbus_write_word_swapped(data->client, TMP007_STATUS_MASK, data->status_mask);
>>  	if (ret < 0)
>>  		goto error_powerdown;
>>  
>> +	if (client->irq) {
>> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
>> +				NULL, tmp007_interrupt_handler,
>> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +				tmp007_id->name, indio_dev);
>> +		if (ret) {
>> +			dev_err(&client->dev, "irq request error %d\n", -ret);
>> +			goto error_powerdown;
>> +		}
>> +	}
>> +
>>  	return iio_device_register(indio_dev);
>>  
>>  error_powerdown:
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

