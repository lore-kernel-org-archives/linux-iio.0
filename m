Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44396 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbbCIPlc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 11:41:32 -0400
Message-ID: <54FDBF2A.6010402@kernel.org>
Date: Mon, 09 Mar 2015 15:41:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 5/7] iio: mlx90614: Allow tuning EEPROM configuration
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com> <1424879712-28304-6-git-send-email-vianney.leclement@essensium.com> <54FDBDCC.50204@kernel.org>
In-Reply-To: <54FDBDCC.50204@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/15 15:35, Jonathan Cameron wrote:
> On 25/02/15 15:55, Vianney le Clément de Saint-Marcq wrote:
>> Add device attributes for getting/setting emissivity, IIR, and FIR
>> coefficients, and getting the gain (which should not be modified in
>> order to keep factory calibration).
>>
>> The attributes provide raw values whose meaning is described in the
>> datasheet [1].
>>
>> Writing to EEPROM requires an explicit erase by writing zero.  In
>> addition, it takes 20ms for the erase/write to complete.  During this
>> time no EEPROM register should be accessed.  Therefore, two msleep()s
>> are added to the write function and a mutex protects against concurrent
>> access.
>>
>> Since it is not expected to be updated frequently, the configuration
>> register is read before modifying it rather than caching it.
>>
>> [1] http://melexis.com/Assets/IR-sensor-thermometer-MLX90614-Datasheet-5152.aspx
>>
>> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
>> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
> Wolfram, bit of odd i2c usage inline I'd like you to take quick look at.
Sorry, this would work better if I cleared Wolfram's old email addresses out of
my address book at somepoint!

>> ---
>>  drivers/iio/temperature/mlx90614.c | 164 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 163 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
>> index 0b36746..ab98fb6 100644
>> --- a/drivers/iio/temperature/mlx90614.c
>> +++ b/drivers/iio/temperature/mlx90614.c
>> @@ -12,14 +12,16 @@
>>   *
>>   * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
>>   *
>> - * TODO: sleep mode, configuration EEPROM
>> + * TODO: sleep mode
>>   */
>>  
>>  #include <linux/err.h>
>>  #include <linux/i2c.h>
>>  #include <linux/module.h>
>> +#include <linux/delay.h>
>>  
>>  #include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>>  
>>  #define MLX90614_OP_RAM		0x00
>>  #define MLX90614_OP_EEPROM	0x20
>> @@ -53,8 +55,47 @@
>>  
>>  struct mlx90614_data {
>>  	struct i2c_client *client;
>> +	struct mutex lock; /* for EEPROM access only */
>>  };
>>  
>> +/*
>> + * Erase an address and write word.
>> + * The mutex must be locked before calling.
>> + */
>> +static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
>> +			       u16 value)
>> +{
>> +	/*
>> +	 * Note: The mlx90614 requires a PEC on writing but does not send us a
>> +	 * valid PEC on reading.  Hence, we cannot set I2C_CLIENT_PEC in
>> +	 * i2c_client.flags.  As a workaround, we use i2c_smbus_xfer here.
>> +	 */
> That's particularly hideous and someone should shout at whoever implemented that!
> Ah well, such is life.  I want a go ahead on doing this from Wolfram however.
> It's the sort of thing that might well get randomly broken in the future.
> Alternative is to add another flag that indicates to the i2c core that the PEC
> that comes back will be wrong.
>  
>> +	union i2c_smbus_data data;
>> +	s32 ret;
>> +
>> +	dev_dbg(&client->dev, "Writing 0x%x to address 0x%x", value, command);
>> +
>> +	data.word = 0x0000; /* erase command */
>> +	ret = i2c_smbus_xfer(client->adapter, client->addr,
>> +			     client->flags | I2C_CLIENT_PEC,
>> +			     I2C_SMBUS_WRITE, command,
>> +			     I2C_SMBUS_WORD_DATA, &data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	msleep(MLX90614_TIMING_EEPROM);
>> +
>> +	data.word = value; /* actual write */
>> +	ret = i2c_smbus_xfer(client->adapter, client->addr,
>> +			     client->flags | I2C_CLIENT_PEC,
>> +			     I2C_SMBUS_WRITE, command,
>> +			     I2C_SMBUS_WORD_DATA, &data);
>> +
>> +	msleep(MLX90614_TIMING_EEPROM);
>> +
>> +	return ret;
>> +}
>> +
>>  static int mlx90614_read_raw(struct iio_dev *indio_dev,
>>  			    struct iio_chan_spec const *channel, int *val,
>>  			    int *val2, long mask)
>> @@ -111,6 +152,102 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>>  	}
>>  }
>>  
>> +static ssize_t mlx90614_show_emissivity(struct device *dev,
>> +					struct device_attribute *devattr,
>> +					char *buf)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct mlx90614_data *data = iio_priv(indio_dev);
>> +	s32 ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = i2c_smbus_read_word_data(data->client, MLX90614_EMISSIVITY);
>> +	mutex_unlock(&data->lock);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
>> +}
>> +
>> +static ssize_t mlx90614_store_emissivity(struct device *dev,
>> +					 struct device_attribute *devattr,
>> +					 const char *buf, size_t count)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct mlx90614_data *data = iio_priv(indio_dev);
>> +	u16 val;
>> +	s32 ret;
>> +
>> +	if (kstrtou16(buf, 0, &val))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = mlx90614_write_word(data->client, MLX90614_EMISSIVITY, val);
>> +	mutex_unlock(&data->lock);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return count;
>> +}
> Emissivity is well defined. I'd like this to be a standard attribute with
> full documentation please rather than a driver specific one.  Happy
> to have this added to the infomask elements if it make sense.
>> +
>> +static ssize_t mlx90614_show_config(struct device *dev,
>> +				    struct device_attribute *devattr,
>> +				    char *buf)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct mlx90614_data *data = iio_priv(indio_dev);
>> +	struct iio_dev_attr *indio_attr = to_iio_dev_attr(devattr);
>> +	u16 mask = indio_attr->address & 0xffff;
>> +	u16 shift = indio_attr->address >> 16;
>> +	s32 ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
>> +	mutex_unlock(&data->lock);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = (ret & mask) >> shift;
>> +
>> +	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
>> +}
>> +
>> +static ssize_t mlx90614_store_config(struct device *dev,
>> +				     struct device_attribute *devattr,
>> +				     const char *buf, size_t count)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct mlx90614_data *data = iio_priv(indio_dev);
>> +	struct iio_dev_attr *indio_attr = to_iio_dev_attr(devattr);
>> +	u16 mask = indio_attr->address & 0xffff;
>> +	u16 shift = indio_attr->address >> 16;
>> +	u16 val;
>> +	s32 ret;
>> +
>> +	if (kstrtou16(buf, 0, &val) || val != (val & (mask >> shift)))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&data->lock);
>> +
>> +	ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	val = (val << shift) | ((u16)ret & ~mask);
>> +	ret = mlx90614_write_word(data->client, MLX90614_CONFIG, val);
>> +
>> +out:
>> +	mutex_unlock(&data->lock);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return count;
>> +}
>> +
>>  static const struct iio_chan_spec mlx90614_channels[] = {
>>  	{
>>  		.type = IIO_TEMP,
>> @@ -154,7 +291,31 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>>  	},
>>  };
>>  
>> +static IIO_DEVICE_ATTR(emissivity, S_IRUGO | S_IWUSR, mlx90614_show_emissivity,
>> +		mlx90614_store_emissivity, -1);
>> +static IIO_DEVICE_ATTR(iir, S_IRUGO | S_IWUSR,
>> +		mlx90614_show_config, mlx90614_store_config,
>> +		(MLX90614_CONFIG_IIR_SHIFT << 16) | MLX90614_CONFIG_IIR_MASK);
>> +static IIO_DEVICE_ATTR(fir, S_IRUGO | S_IWUSR,
>> +		mlx90614_show_config, mlx90614_store_config,
>> +		(MLX90614_CONFIG_FIR_SHIFT << 16) | MLX90614_CONFIG_FIR_MASK);
>> +static IIO_DEVICE_ATTR(gain, S_IRUGO, mlx90614_show_config, NULL,
>> +		(MLX90614_CONFIG_GAIN_SHIFT << 16) | MLX90614_CONFIG_GAIN_MASK);
>> +
>> +static struct attribute *mlx90614_attr[] = {
>> +	&iio_dev_attr_emissivity.dev_attr.attr,
>> +	&iio_dev_attr_iir.dev_attr.attr,
> Hmm odd to have two different filter types with separate control.
> However we have _filter_low_pass_3db_frequency and whilst it is a pain
> obviously to map this to that form that's the way to go from a useful
> userspace interface point of view.  If we need to extend the filter
> description interface (filter type has been suggested before) then please
> propose that.
> 
> Here I see they are suggesting one filter is effectively for ignoreing
> fast passing objects, and the other for noise prevention.  They both
> effect the settling time.
> 
> Anyhow it's not entirely obvious what the right answer is, but its
> definitely not a driver specific interface such as we have.
> 
> Peter, any thoughts?
>> +	&iio_dev_attr_fir.dev_attr.attr,
>> +	&iio_dev_attr_gain.dev_attr.attr,
> Please use the standard IIO infomask elements for scale (or perhaps
> calibscale - I haven't checked which is appropriate).
>> +	NULL
>> +};
>> +
>> +static struct attribute_group mlx90614_attr_group = {
>> +	.attrs = mlx90614_attr,
>> +};
>> +
>>  static const struct iio_info mlx90614_info = {
>> +	.attrs = &mlx90614_attr_group,
>>  	.read_raw = mlx90614_read_raw,
>>  	.driver_module = THIS_MODULE,
>>  };
>> @@ -189,6 +350,7 @@ static int mlx90614_probe(struct i2c_client *client,
>>  	data = iio_priv(indio_dev);
>>  	i2c_set_clientdata(client, indio_dev);
>>  	data->client = client;
>> +	mutex_init(&data->lock);
>>  
>>  	indio_dev->dev.parent = &client->dev;
>>  	indio_dev->name = id->name;
>>
> 

