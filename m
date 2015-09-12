Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55904 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbbILKHU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Sep 2015 06:07:20 -0400
Subject: Re: [PATCH 1/6] iio: mma8452: refactor for seperating chip specific
 data
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
References: <1441107913-4112-1-git-send-email-martink@posteo.de>
 <1441107913-4112-2-git-send-email-martink@posteo.de>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55F3F953.4030209@kernel.org>
Date: Sat, 12 Sep 2015 11:07:15 +0100
MIME-Version: 1.0
In-Reply-To: <1441107913-4112-2-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/15 12:45, Martin Kepplinger wrote:
> This adds a struct mma_chip_info to hold data that will remain specific to
> the chip in use. It is provided during probe() and linked in
> struct of_device_id.
> 
> Also this suggests that the driver is called "mma8452" and now handles the
> MMA8452Q device, but is not limited to it.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Applied to the togreg branch of iio.git.  Initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 183 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 134 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index b921d84..f28428fa 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -22,6 +22,7 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/events.h>
>  #include <linux/delay.h>
> +#include <linux/of_device.h>
>  
>  #define MMA8452_STATUS				0x00
>  #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
> @@ -74,6 +75,52 @@ struct mma8452_data {
>  	struct mutex lock;
>  	u8 ctrl_reg1;
>  	u8 data_cfg;
> +	const struct mma_chip_info *chip_info;
> +};
> +
> +/**
> + * struct mma_chip_info - chip specific data for Freescale's accelerometers
> + * @chip_id:			WHO_AM_I register's value
> + * @channels:			struct iio_chan_spec matching the device's
> + *				capabilities
> + * @num_channels:		number of channels
> + * @mma_scales:			scale factors for converting register values
> + *				to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers
> + *				per mode: m/s^2 and micro m/s^2
> + * @ev_cfg:			event config register address
> + * @ev_cfg_ele:			latch bit in event config register
> + * @ev_cfg_chan_shift:		number of the bit to enable events in X
> + *				direction; in event config register
> + * @ev_src:			event source register address
> + * @ev_src_xe:			bit in event source register that indicates
> + *				an event in X direction
> + * @ev_src_ye:			bit in event source register that indicates
> + *				an event in Y direction
> + * @ev_src_ze:			bit in event source register that indicates
> + *				an event in Z direction
> + * @ev_ths:			event threshold register address
> + * @ev_ths_mask:		mask for the threshold value
> + * @ev_count:			event count (period) register address
> + *
> + * Since not all chips supported by the driver support comparing high pass
> + * filtered data for events (interrupts), different interrupt sources are
> + * used for different chips and the relevant registers are included here.
> + */
> +struct mma_chip_info {
> +	u8 chip_id;
> +	const struct iio_chan_spec *channels;
> +	int num_channels;
> +	const int mma_scales[3][2];
> +	u8 ev_cfg;
> +	u8 ev_cfg_ele;
> +	u8 ev_cfg_chan_shift;
> +	u8 ev_src;
> +	u8 ev_src_xe;
> +	u8 ev_src_ye;
> +	u8 ev_src_ze;
> +	u8 ev_ths;
> +	u8 ev_ths_mask;
> +	u8 ev_count;
>  };
>  
>  static int mma8452_drdy(struct mma8452_data *data)
> @@ -143,16 +190,6 @@ static const int mma8452_samp_freq[8][2] = {
>  	{6, 250000}, {1, 560000}
>  };
>  
> -/*
> - * Hardware has fullscale of -2G, -4G, -8G corresponding to raw value -2048
> - * The userspace interface uses m/s^2 and we declare micro units
> - * So scale factor is given by:
> - *	g * N * 1000000 / 2048 for N = 2, 4, 8 and g = 9.80665
> - */
> -static const int mma8452_scales[3][2] = {
> -	{0, 9577}, {0, 19154}, {0, 38307}
> -};
> -
>  /* Datasheet table 35  (step time vs sample frequency) */
>  static const int mma8452_transient_time_step_us[8] = {
>  	1250,
> @@ -189,8 +226,11 @@ static ssize_t mma8452_show_scale_avail(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> -	return mma8452_show_int_plus_micros(buf, mma8452_scales,
> -					    ARRAY_SIZE(mma8452_scales));
> +	struct mma8452_data *data = iio_priv(i2c_get_clientdata(
> +					     to_i2c_client(dev)));
> +
> +	return mma8452_show_int_plus_micros(buf, data->chip_info->mma_scales,
> +		ARRAY_SIZE(data->chip_info->mma_scales));
>  }
>  
>  static ssize_t mma8452_show_hp_cutoff_avail(struct device *dev,
> @@ -221,9 +261,8 @@ static int mma8452_get_samp_freq_index(struct mma8452_data *data,
>  
>  static int mma8452_get_scale_index(struct mma8452_data *data, int val, int val2)
>  {
> -	return mma8452_get_int_plus_micros_index(mma8452_scales,
> -						 ARRAY_SIZE(mma8452_scales),
> -						 val, val2);
> +	return mma8452_get_int_plus_micros_index(data->chip_info->mma_scales,
> +			ARRAY_SIZE(data->chip_info->mma_scales), val, val2);
>  }
>  
>  static int mma8452_get_hp_filter_index(struct mma8452_data *data,
> @@ -270,14 +309,15 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = sign_extend32(be16_to_cpu(buffer[chan->scan_index]) >> 4,
> -				     11);
> +		*val = sign_extend32(be16_to_cpu(
> +			buffer[chan->scan_index]) >> chan->scan_type.shift,
> +			chan->scan_type.realbits - 1);
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		i = data->data_cfg & MMA8452_DATA_CFG_FS_MASK;
> -		*val = mma8452_scales[i][0];
> -		*val2 = mma8452_scales[i][1];
> +		*val = data->chip_info->mma_scales[i][0];
> +		*val2 = data->chip_info->mma_scales[i][1];
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -439,17 +479,17 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
>  		ret = i2c_smbus_read_byte_data(data->client,
> -					       MMA8452_TRANSIENT_THS);
> +					       data->chip_info->ev_ths);
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = ret & MMA8452_TRANSIENT_THS_MASK;
> +		*val = ret & data->chip_info->ev_ths_mask;
>  
>  		return IIO_VAL_INT;
>  
>  	case IIO_EV_INFO_PERIOD:
>  		ret = i2c_smbus_read_byte_data(data->client,
> -					       MMA8452_TRANSIENT_COUNT);
> +					       data->chip_info->ev_count);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -497,7 +537,8 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
>  		if (val < 0 || val > MMA8452_TRANSIENT_THS_MASK)
>  			return -EINVAL;
>  
> -		return mma8452_change_config(data, MMA8452_TRANSIENT_THS, val);
> +		return mma8452_change_config(data, data->chip_info->ev_ths,
> +					     val);
>  
>  	case IIO_EV_INFO_PERIOD:
>  		steps = (val * USEC_PER_SEC + val2) /
> @@ -507,7 +548,7 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
>  		if (steps < 0 || steps > 0xff)
>  			return -EINVAL;
>  
> -		return mma8452_change_config(data, MMA8452_TRANSIENT_COUNT,
> +		return mma8452_change_config(data, data->chip_info->ev_count,
>  					     steps);
>  
>  	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
> @@ -538,13 +579,15 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
>  				     enum iio_event_direction dir)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	const struct mma_chip_info *chip = data->chip_info;
>  	int ret;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_CFG);
> +	ret = i2c_smbus_read_byte_data(data->client,
> +				       data->chip_info->ev_cfg);
>  	if (ret < 0)
>  		return ret;
>  
> -	return ret & MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index) ? 1 : 0;
> +	return !!(ret & BIT(chan->scan_index + chip->ev_cfg_chan_shift));
>  }
>  
>  static int mma8452_write_event_config(struct iio_dev *indio_dev,
> @@ -554,20 +597,21 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  				      int state)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	const struct mma_chip_info *chip = data->chip_info;
>  	int val;
>  
> -	val = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_CFG);
> +	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>  	if (val < 0)
>  		return val;
>  
>  	if (state)
> -		val |= MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index);
> +		val |= BIT(chan->scan_index + chip->ev_cfg_chan_shift);
>  	else
> -		val &= ~MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index);
> +		val &= ~BIT(chan->scan_index + chip->ev_cfg_chan_shift);
>  
>  	val |= MMA8452_TRANSIENT_CFG_ELE;
>  
> -	return mma8452_change_config(data, MMA8452_TRANSIENT_CFG, val);
> +	return mma8452_change_config(data, chip->ev_cfg, val);
>  }
>  
>  static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
> @@ -576,25 +620,25 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
>  	s64 ts = iio_get_time_ns();
>  	int src;
>  
> -	src = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_SRC);
> +	src = i2c_smbus_read_byte_data(data->client, data->chip_info->ev_src);
>  	if (src < 0)
>  		return;
>  
> -	if (src & MMA8452_TRANSIENT_SRC_XTRANSE)
> +	if (src & data->chip_info->ev_src_xe)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
>  						  IIO_EV_TYPE_MAG,
>  						  IIO_EV_DIR_RISING),
>  			       ts);
>  
> -	if (src & MMA8452_TRANSIENT_SRC_YTRANSE)
> +	if (src & data->chip_info->ev_src_ye)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Y,
>  						  IIO_EV_TYPE_MAG,
>  						  IIO_EV_DIR_RISING),
>  			       ts);
>  
> -	if (src & MMA8452_TRANSIENT_SRC_ZTRANSE)
> +	if (src & data->chip_info->ev_src_ze)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Z,
>  						  IIO_EV_TYPE_MAG,
> @@ -696,7 +740,7 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	.name = "events",
>  };
>  
> -#define MMA8452_CHANNEL(axis, idx) { \
> +#define MMA8452_CHANNEL(axis, idx, bits) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
>  	.channel2 = IIO_MOD_##axis, \
> @@ -708,9 +752,9 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	.scan_index = idx, \
>  	.scan_type = { \
>  		.sign = 's', \
> -		.realbits = 12, \
> +		.realbits = (bits), \
>  		.storagebits = 16, \
> -		.shift = 4, \
> +		.shift = 16 - (bits), \
>  		.endianness = IIO_BE, \
>  	}, \
>  	.event_spec = mma8452_transient_event, \
> @@ -718,12 +762,42 @@ static struct attribute_group mma8452_event_attribute_group = {
>  }
>  
>  static const struct iio_chan_spec mma8452_channels[] = {
> -	MMA8452_CHANNEL(X, 0),
> -	MMA8452_CHANNEL(Y, 1),
> -	MMA8452_CHANNEL(Z, 2),
> +	MMA8452_CHANNEL(X, 0, 12),
> +	MMA8452_CHANNEL(Y, 1, 12),
> +	MMA8452_CHANNEL(Z, 2, 12),
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> +enum {
> +	mma8452,
> +};
> +
> +static const struct mma_chip_info mma_chip_info_table[] = {
> +	[mma8452] = {
> +		.chip_id = MMA8452_DEVICE_ID,
> +		.channels = mma8452_channels,
> +		.num_channels = ARRAY_SIZE(mma8452_channels),
> +		/*
> +		 * Hardware has fullscale of -2G, -4G, -8G corresponding to
> +		 * raw value -2048 for 12 bit or -512 for 10 bit.
> +		 * The userspace interface uses m/s^2 and we declare micro units
> +		 * So scale factor for 12 bit here is given by:
> +		 *	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
> +		 */
> +		.mma_scales = { {0, 9577}, {0, 19154}, {0, 38307} },
> +		.ev_cfg = MMA8452_TRANSIENT_CFG,
> +		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
> +		.ev_cfg_chan_shift = 1,
> +		.ev_src = MMA8452_TRANSIENT_SRC,
> +		.ev_src_xe = MMA8452_TRANSIENT_SRC_XTRANSE,
> +		.ev_src_ye = MMA8452_TRANSIENT_SRC_YTRANSE,
> +		.ev_src_ze = MMA8452_TRANSIENT_SRC_ZTRANSE,
> +		.ev_ths = MMA8452_TRANSIENT_THS,
> +		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
> +		.ev_count = MMA8452_TRANSIENT_COUNT,
> +	},
> +};
> +
>  static struct attribute *mma8452_attributes[] = {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> @@ -841,12 +915,19 @@ static int mma8452_reset(struct i2c_client *client)
>  	return -ETIMEDOUT;
>  }
>  
> +static const struct of_device_id mma8452_dt_ids[] = {
> +	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
> +
>  static int mma8452_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct mma8452_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> +	const struct of_device_id *match;
>  
>  	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
>  	if (ret < 0)
> @@ -854,6 +935,12 @@ static int mma8452_probe(struct i2c_client *client,
>  	if (ret != MMA8452_DEVICE_ID)
>  		return -ENODEV;
>  
> +	match = of_match_device(mma8452_dt_ids, &client->dev);
> +	if (!match) {
> +		dev_err(&client->dev, "unknown device model\n");
> +		return -ENODEV;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -861,14 +948,18 @@ static int mma8452_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  	mutex_init(&data->lock);
> +	data->chip_info = match->data;
> +
> +	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
> +		 match->compatible, data->chip_info->chip_id);
>  
>  	i2c_set_clientdata(client, indio_dev);
>  	indio_dev->info = &mma8452_info;
>  	indio_dev->name = id->name;
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = mma8452_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(mma8452_channels);
> +	indio_dev->channels = data->chip_info->channels;
> +	indio_dev->num_channels = data->chip_info->num_channels;
>  	indio_dev->available_scan_masks = mma8452_scan_masks;
>  
>  	ret = mma8452_reset(client);
> @@ -987,17 +1078,11 @@ static SIMPLE_DEV_PM_OPS(mma8452_pm_ops, mma8452_suspend, mma8452_resume);
>  #endif
>  
>  static const struct i2c_device_id mma8452_id[] = {
> -	{ "mma8452", 0 },
> +	{ "mma8452", mma8452 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mma8452_id);
>  
> -static const struct of_device_id mma8452_dt_ids[] = {
> -	{ .compatible = "fsl,mma8452" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
> -
>  static struct i2c_driver mma8452_driver = {
>  	.driver = {
>  		.name	= "mma8452",
> 

