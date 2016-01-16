Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53311 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbcAPMH4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jan 2016 07:07:56 -0500
Subject: Re: [PATCH] iio: adc: Add TI ADS1015 ADC driver support
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1452788708-3003-1-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	lucas.demarchi@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569A3299.3@kernel.org>
Date: Sat, 16 Jan 2016 12:07:53 +0000
MIME-Version: 1.0
In-Reply-To: <1452788708-3003-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/01/16 16:25, Daniel Baluta wrote:
> The driver has sysfs readings with runtime PM support for power saving.
> It also offers buffer support that can be used together with IIO software
> triggers.
> 
> Datasheet can be found here:
> 	http://www.ti.com.cn/cn/lit/ds/symlink/ads1015.pdf
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
The hwmon compatibility stuff has been covered by others so I'll just assume
you'll sort that out :)

Various bits and bobs inline.

Jonathan
> ---
>  drivers/iio/adc/Kconfig      |  14 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-ads1015.c | 452 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 467 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads1015.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 605ff42..fc80ecd 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -360,6 +360,20 @@ config TI_ADC128S052
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-adc128s052.
>  
> +config TI_ADS1015
> +	tristate "Texas Instruments ADS1015 ADC"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  If you say yes here you get support for Texas Instruments ADS1015
> +	  ADC chip.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads1015.
> +
> +
>  config TI_ADS8688
>  	tristate "Texas Instruments ADS8688"
>  	depends on SPI && OF
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 6435780..ce935de 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
> +obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> new file mode 100644
> index 0000000..5016221
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -0,0 +1,452 @@
> +/*
> + * ADS1015 - Texas Instruments Analog-to-Digital Converter
> + *
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * IIO driver for ADS1015 ADC 7-bit I2C slave address:
> + *	* 0x48 - ADDR connectd to Ground
> + *	* 0x49 - ADDR connected to Vdd
> + *	* 0x4A - ADDR connected to SDA
> + *	* 0x4B - ADDR connected to SCL
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/iio/types.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#define ADS1015_DRV_NAME "ads1015"
> +
> +#define ADS1015_CONV_REG	0x00
> +#define ADS1015_CONFIG_REG	0x01
> +
> +#define ADS1015_CONFIG_DR	GENMASK(7, 5)
> +#define ADS1015_CONFIG_MODE	BIT(8)
> +#define ADS1015_CONFIG_SCALE	GENMASK(11, 9)
> +#define ADS1015_CONFIG_MUX	GENMASK(14, 12)
> +
> +#define ADS1015_SLEEP_DELAY_MS	2000
> +
> +enum ads1015_channels {
> +	ADS1015_AIN0_AIN1 = 0,
> +	ADS1015_AIN0_AIN3,
> +	ADS1015_AIN1_AIN3,
> +	ADS1015_AIN2_AIN3,
> +	ADS1015_AIN0,
> +	ADS1015_AIN1,
> +	ADS1015_AIN2,
> +	ADS1015_AIN3,
> +};
> +
> +static const unsigned int ads1015_data_rate[] = {
> +	128, 250, 490, 920, 1600, 2400, 3300, 3300
> +};
> +
> +static const struct {
> +	int scale;
> +	int uscale;
> +} ads1015_scale[] = {
> +	{3, 0},
> +	{2, 0},
> +	{1, 0},
> +	{0, 500000},
> +	{0, 250000},
> +	{0, 125000},
> +	{0, 125000},
> +	{0, 125000},
> +};
> +
> +#define ADS1015_V_CHAN(_chan, _addr) {				\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.address = _addr,					\
> +	.channel = _chan,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = _addr,					\
> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 12,					\
> +		.storagebits = 16,				\
> +		.shift = 4,					\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +}
> +
> +#define ADS1015_V_DIFF_CHAN(_chan, _chan2, _addr) {		\
> +	.type = IIO_VOLTAGE,					\
> +	.differential = 1,					\
> +	.indexed = 1,						\
> +	.address = _addr,					\
> +	.channel = _chan,					\
> +	.channel2 = _chan2,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = _addr,					\
> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 12,					\
> +		.storagebits = 16,				\
> +		.shift = 4,					\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +}
> +
> +struct ads1015_data {
I was a little suprised to see both the i2c_client and regmap in here...
Could use regmap_get_device for most if not all uses in here of the
client pointer..
> +	struct i2c_client *client;
> +	struct regmap *regmap;
You only use buffer[0] that I can see...
> +	s16 buffer[8];
> +	int64_t timestamp;
> +};
> +
> +static bool ads1015_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	return (reg == ADS1015_CONFIG_REG);
> +}
> +
> +static const struct regmap_config ads1015_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = ADS1015_CONFIG_REG,
> +	.writeable_reg = ads1015_is_writeable_reg,
> +};
> +
> +static const struct iio_chan_spec ads1015_channels[] = {
> +	ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1),
> +	ADS1015_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3),
> +	ADS1015_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3),
> +	ADS1015_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3),
> +	ADS1015_V_CHAN(0, ADS1015_AIN0),
> +	ADS1015_V_CHAN(1, ADS1015_AIN1),
> +	ADS1015_V_CHAN(2, ADS1015_AIN2),
> +	ADS1015_V_CHAN(3, ADS1015_AIN3),
> +};
> +
> +static int ads1015_set_power_state(struct ads1015_data *data, bool on)
> +{
> +	int ret;
> +
> +	if (on) {
> +		ret = pm_runtime_get_sync(&data->client->dev);
> +		if (ret < 0)
> +			pm_runtime_put_noidle(&data->client->dev);
> +	} else {
> +		pm_runtime_mark_last_busy(&data->client->dev);
> +		ret = pm_runtime_put_autosuspend(&data->client->dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static
> +int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap, ADS1015_CONFIG_REG,
> +				 ADS1015_CONFIG_MUX, chan << 12);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, ADS1015_CONV_REG, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static irqreturn_t ads1015_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +	s16 res;
> +	int chan, ret;
> +
> +	chan = find_first_bit(indio_dev->active_scan_mask,
> +			      indio_dev->masklength);
hmm. This made me wonder if there was any milage in adding (or an existing)
find_only_bit.  Given the hardware support for many arches for ffs probably
not worthwhile
> +
> +	ret = ads1015_get_adc_result(data, chan, (int *)&res);
> +	if (ret < 0)
> +		goto err;
> +
> +	data->buffer[0] = res;
This made me wonder - what is the rest of buffer for?
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +					   data->timestamp);
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
blank line here.
> +	return IRQ_HANDLED;
> +}
> +
> +static int ads1015_set_scale(struct ads1015_data *data, int scale,
> +				 int uscale)
> +{
> +	int i, rindex = -1;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads1015_scale); i++)
> +		if (ads1015_scale[i].scale == scale &&
> +			ads1015_scale[i].uscale == uscale) {
> +			rindex = i;
> +			break;
> +		}
> +	if (rindex < 0)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(data->regmap, ADS1015_CONFIG_REG,
> +				  ADS1015_CONFIG_SCALE, rindex << 9);
> +}
> +
> +static int ads1015_set_data_rate(struct ads1015_data *data, int rate)
> +{
> +	int i, rindex = -1;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads1015_data_rate); i++)
> +		if (ads1015_data_rate[i] == rate) {
> +			rindex = i;
> +			break;
> +		}
> +	if (rindex < 0)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(data->regmap, ADS1015_CONFIG_REG,
> +				  ADS1015_CONFIG_DR, rindex << 5);
> +}
> +
> +static int ads1015_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	int ret, idx;
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
Locking to prevent concurrent reads via sysfs or a mix of sysfs / buffered
reads?
> +		ret = ads1015_set_power_state(data, true);
> +		if (ret < 0)
> +			return ret;
> +		ret = ads1015_get_adc_result(data, chan->address, val);
> +		if (ret < 0) {
> +			ads1015_set_power_state(data, false);
> +			return ret;
> +		}
> +
> +		/* 12 bit res, D0 is bit 4 in conversion register */
> +		*val = sign_extend32(*val >> 4, 11);
> +
> +		ret = ads1015_set_power_state(data, false);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regmap_read(data->regmap, ADS1015_CONFIG_REG, val);
> +		if (ret < 0)
> +			return ret;
> +		idx = (*val >> 9) & 0x0007;
> +		*val = ads1015_scale[idx].scale;
> +		*val2 = ads1015_scale[idx].uscale;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_read(data->regmap, ADS1015_CONFIG_REG, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		idx = (*val >> 5) & 0x0007;

Feels a touch magic numberish to me. Either use the regmap field reading
stuff to do this cleanly (if a touch verbosely), or at very least add some
defines for the magic constants.

> +		*val = ads1015_data_rate[idx];
> +
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ads1015_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ads1015_set_scale(data, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ads1015_set_data_rate(data, val);
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ads1015_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +
> +	return ads1015_set_power_state(data, true);
> +}
> +
> +static int ads1015_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +
> +	return ads1015_set_power_state(data, false);
I'd roll these two lines into one as I don't personally think any
readability is added by the local variable (don't care that much though)
> +}
> +static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
> +	.preenable	= ads1015_buffer_preenable,
> +	.postenable	= iio_triggered_buffer_postenable,
> +	.postdisable	= ads1015_buffer_postdisable,
> +	.predisable	= iio_triggered_buffer_predisable,
real nitpick but I'd reorder this as it didn't scan right to me.
preenable, postenable, predisable, postdisable.  Then it's obvious
that you have replaced the central pair (which makes sense) rather
than looking like you have gotten it wrong and replaced a non
matched pair!

> +	.validate_scan_mask = &iio_validate_scan_mask_onehot,
> +};
> +
> +static IIO_CONST_ATTR(scale_available, "3 2 1 0.5 0.25 0.125");
> +static IIO_CONST_ATTR(sampling_frequency_available,
> +		      "128 250 490 920 1600 2400 3300");
> +
> +static struct attribute *ads1015_attributes[] = {
> +	&iio_const_attr_scale_available.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ads1015_attribute_group = {
> +	.attrs = ads1015_attributes,
> +};
> +
> +static const struct iio_info ads1015_info = {
> +	.driver_module	= THIS_MODULE,
> +	.read_raw	= ads1015_read_raw,
> +	.write_raw	= ads1015_write_raw,
> +	.attrs		= &ads1015_attribute_group,
> +};
> +
> +static int ads1015_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads1015_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &ads1015_info;
> +	indio_dev->name = ADS1015_DRV_NAME;
> +	indio_dev->channels = ads1015_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads1015_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &ads1015_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&client->dev, "Failed to allocate register map\n");
> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +					 ads1015_trigger_handler,
> +					 &ads1015_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "iio triggered buffer setup failed\n");
> +		return ret;
> +	}
> +
> +	ret = pm_runtime_set_active(&client->dev);
> +	if (ret) {
> +		iio_triggered_buffer_cleanup(indio_dev);
> +		return ret;
> +	}
> +
> +	pm_runtime_enable(&client->dev);
> +
> +	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(&client->dev);
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static int ads1015_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +
Alarm bells immediately ringing... You still have the userspace
interface exposed at this point as the device unregister won't
happen until after this remove function has finished...

Don't use devm_ version of device register unless there is no
remove function.  Here you've removed the buffer when there is nothing
stopping it being started whilst this function is running.

> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +	pm_runtime_put_noidle(&client->dev);
> +
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	/* power down single shot mode */
> +	return regmap_update_bits(data->regmap, ADS1015_CONFIG_REG,
> +				  ADS1015_CONFIG_MODE, 0x01 << 8);
> +}
> +
> +#ifdef CONFIG_PM
> +static int ads1015_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +
> +	return regmap_update_bits(data->regmap, ADS1015_CONFIG_REG,
> +				  ADS1015_CONFIG_MODE, 0x01 << 8);
> +}
> +
> +static int ads1015_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +
> +	return regmap_update_bits(data->regmap, ADS1015_CONFIG_REG,
> +				  ADS1015_CONFIG_MODE, 0x00 << 8);
> +}
> +#endif
> +
> +static const struct dev_pm_ops ads1015_pm_ops = {
> +	SET_RUNTIME_PM_OPS(ads1015_runtime_suspend,
> +			   ads1015_runtime_resume, NULL)
> +};
> +
> +static const struct i2c_device_id ads1015_id[] = {
> +	{"ads1015", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ads1015_id);
> +
> +static struct i2c_driver ads1015_driver = {
> +	.driver = {
> +		.name = ADS1015_DRV_NAME,
> +		.pm = &ads1015_pm_ops,
> +	},
> +	.probe		= ads1015_probe,
> +	.remove		= ads1015_remove,
> +	.id_table	= ads1015_id,
> +};
> +
> +module_i2c_driver(ads1015_driver);
> +
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
> +MODULE_DESCRIPTION("Texas Instruments ADS1015 ADC driver");
> +MODULE_LICENSE("GPL v2");
> 

