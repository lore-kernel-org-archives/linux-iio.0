Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F783AEF22
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963163; cv=none; b=g/G3wjJS5KA2giZpNa3cV5TXlK/E37wEhYV02xVfuaLjrI9+CLx4nVSkMbH2aGzdtD2G1ACc7UVtTDbOZ/u59qJH9b5I4gSfnfXhzj3CE52i5FMrUnsT8Blyg+S/L4CiSYkxsA1Zwje+ujGz/n6Wo538LI0pG8qowAiCe9iwEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963163; c=relaxed/simple;
	bh=kmLbVCi89kaJE0ypYjQQN/md543Lp2Ir4dIeAeLGtE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhhxBPPohnULssHbbUjzHdSTSQWJnj8X4ooeeENPSxkHhXsf6zQk75FI94KO2IfSjfxHqoWjDOhEqzolM+XrVwk+l3aO6HAKIlHPpgjoajYFtKRWzYKkp7PimzcB2hO8hzZ3oDqibKZKD4ZDKz5qDA7LtY0NAWDpJ7F6g7JXV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amTK/rM5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amTK/rM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9061F00A3C;
	Thu, 28 May 2026 10:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779963161;
	bh=yc74FEZ3HM9aIePhe35kxYV3CXlYdPFxLSpXD3Z1VLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=amTK/rM5EAZRV7c6+K2QxtOQhWLmmz7qf/xgdsROOz6Ni2gfLY0IdYFUMuq0FWfM/
	 27dZoOFrZ54BPCkXy3piNGyVQFt/zinHbtzzRcZyQRVRM5/bP18dwttgwCCKNMPkwx
	 c+3PvaoELhqy50BOGfBbFU2LRTFRVhw4FQL3UOLgtc4+htwIGv4D6MY8e0GRD7B/zX
	 t3T9D1jdF8pNWCfEWZ9jW6dyzs4j+9PZRE+Uce7HvzNNHdsPqnjLYCVzukaskug/VW
	 QuPze1jWhZsTvIo0qmGjwFuG7eoylXbGpMubevMX8qpcTydqTPUxemXC3ChZIyr790
	 D4jScmLPtaYZA==
Date: Thu, 28 May 2026 11:12:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
Subject: Re: [PATCH 1/4] iio: adc: add ti-ads1110
Message-ID: <20260528111234.02fcd9e1@jic23-huawei>
In-Reply-To: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
References: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 18:43:09 +0200
Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:

> Add a new IIO ADC driver for the TI ADS1110. The driver supports the device's
> internal reference/voltage regulator and enables the high 240 SPS conversion
> rate, exposing the ADC input through the IIO framework.
> 
> Tested on: Raspberry pi 3b+ with 7.0 stable kernel
> 
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
The critical question both for the binding and the driver is the
one David already raised about whether it is more sensible to add
support to an existing driver.  I'm going to put that and the patch
series issue structuring aside for now and do a quick review of the
code you have here.

Also check sashiko 
https://sashiko.dev/#/patchset/20260527164312.355729-1-jakubszczudlo40%40gmail.com
But be careful. It is good, but far from perfect.  Then again, neither are human
reviewers! :)  I took a quick look before doing this review and so generally
won't repeat things in that AI review.


> ---
>  drivers/iio/adc/ti-ads1110.c | 468 +++++++++++++++++++++++++++++++++++
>  1 file changed, 468 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads1110.c
> 
> diff --git a/drivers/iio/adc/ti-ads1110.c b/drivers/iio/adc/ti-ads1110.c
> new file mode 100644
> index 000000000000..ed8c16f7411d
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1110.c
> @@ -0,0 +1,468 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADS1110 - Texas Instruments Analog-to-Digital Converter
> + *
> + * Copyright (c) 2023, Topic Embedded Products

So where did this come from?  Add some more history on this.

> + *
> + * Datasheet: https://www.ti.com/lit/gpn/ads1110
> + * IIO driver for ADS1110
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>

Check these again. I'd expect to see at least
dev_printk.h for example.
For IIO stuff (and kernel in general) we try to follow an approximation
of include what you use, only not including stuff where we know there are
conventions around which header should be included instead.

> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/fwnode.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +/* The ADS1100 has a single byte config register */
> +
> +/* Conversion in progress bit */
> +#define ADS1110_CFG_ST_BSY	BIT(7)
> +/* Single conversion bit */
> +#define ADS1110_CFG_SC		BIT(4)
> +/* Data rate */

I'd use enough in the define to not need the comments.
ADS1110_DATARATE_MASK
and similar.

> +#define ADS1110_DR_MASK		GENMASK(3, 2)
> +/* Gain */
> +#define ADS1110_PGA_MASK	GENMASK(1, 0)

> +
> +static const struct iio_chan_spec ads1110_channel = {
> +	.type = IIO_VOLTAGE,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_shared_by_all =
> +	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.info_mask_shared_by_all_available =
> +	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_type = {
> +		      .sign = 's',
> +		      .realbits = 16,
> +		      .storagebits = 16,
> +		      .endianness = IIO_CPU,

No IIO buffer support in here yet, so this stuff doesn't need to be set.
Add it if / when you do add that supprot.

> +		       },
	},

> +	.datasheet_name = "AIN",
> +};


> +
> +static int ads1110_get_adc_result(struct ads1110_data *data, int chan, int *val)
> +{
> +	int ret;
> +	__be16 buffer;
> +	s16 value;
> +
> +	if (chan != 0)
> +		return -EINVAL;
> +
> +	ret = pm_runtime_resume_and_get(&data->client->dev);
Maybe use the ACQUIRE_ stuff for runtime pm. We don't care if we don't start
autosuspend count down at end of function so will simplify the flow a little.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +
> +	pm_runtime_put_autosuspend(&data->client->dev);
> +
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Value is always 16-bit 2's complement */
> +	value = be16_to_cpu(buffer);
> +
> +	/* Shift result to compensate for bit resolution vs. sample rate */
> +	value <<= 16 - ads1110_data_bits(data);
> +
> +	*val = sign_extend32(value, 15);
> +
> +	return 0;
> +}
> +
> +static int ads1110_set_scale(struct ads1110_data *data, int val, int val2)
> +{
> +	int microvolts;
> +	int gain;
> +	int ret;
> +
> +	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
> +	if (val)
> +		return -EINVAL;
> +
> +	if (!val2)
> +		return -EINVAL;
> +
> +	microvolts = ADS1110_REFERENCE_VOLTAGE_MV * 1000;
> +	/*
> +	 * val2 is in 'micro' units, n = val2 / 1000000
> +	 * result must be millivolts, d = microvolts / 1000
> +	 * the full-scale value is d/n, corresponds to 2^15,
> +	 * hence the gain = (d / n) >> 15, factoring out the 1000 and moving the
> +	 * bitshift so everything fits in 32-bits yields this formula.
> +	 */
> +	gain = DIV_ROUND_CLOSEST(microvolts, BIT(15)) * MILLI / val2;
> +	if (gain < BIT(0) || gain > BIT(3))
> +		return -EINVAL;
> +
> +	dev_dbg(&data->client->dev, "Setting gain to %d", ffs(gain) - 1);
> +
> +	ret = ads1110_set_config_bits(data, ADS1110_PGA_MASK, ffs(gain) - 1);
> +
> +	return ret;
return ads1110_set_config_bits

> +}
> +
> +static int ads1110_set_data_rate(struct ads1110_data *data, int chan, int rate)
> +{
> +	unsigned int i;
> +	unsigned int size;
> +
> +	size = ARRAY_SIZE(ads1110_data_rate);
> +	for (i = 0; i < size; i++) {

	for (unsigned int i = 0; i < ARRAY_SIZE(ads1110_data_rate); i++)

> +		if (ads1110_data_rate[i] == rate)
Might be worth flipping this to reduce indent
		if (ads1110_data_rate[i] != rate)
			continue;

		return
> +			return ads1110_set_config_bits(data, ADS1110_DR_MASK,
> +						       FIELD_PREP(ADS1110_DR_MASK, i));
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ads1110_pga_gain_to_field_value(int gain)
> +{
> +	if (!is_power_of_2(gain) || gain > 8)
> +		return -EINVAL;
> +
> +	return ffs(gain) - 1;
> +}
> +
> +static void ads1110_calc_scale_avail(struct ads1110_data *data)
> +{
> +	int millivolts = ADS1110_REFERENCE_VOLTAGE_MV;
Might as well put that constant below . Don't worry about line being
a bit long.
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
For modern kernel code it's fine to do

	for (unsigned int i = 0; i < ARRAY_SIZE() etc

> +		data->scale_avail[i * 2 + 0] = millivolts;
> +		data->scale_avail[i * 2 + 1] = 15 + i;
> +	}
> +}

> +static int ads1110_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	int ret;
> +	struct ads1110_data *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret = ads1110_get_adc_result(data, chan->address, val);
> +		iio_device_release_direct(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* full-scale is the supply voltage in millivolts */
> +		*val = ADS1110_REFERENCE_VOLTAGE_MV;
> +		*val2 = 15 + FIELD_GET(ADS1110_PGA_MASK, data->config);
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = ads1110_data_rate[FIELD_GET(ADS1110_DR_MASK,
> +						   data->config)];

Put that on line line.

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int ads1110_setup(struct ads1110_data *data)
> +{
> +	int ret;
> +	u8 buffer[3];
> +
> +	/* Setup continuous sampling mode at 15sps */
> +	buffer[0] = ADS1110_DR_MASK | ADS1110_CONTINUOUS;
> +	ret = i2c_master_send(data->client, buffer, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
> +	if (ret < 0)
> +		return ret;

So if you error out here, device is still in continuous mode?
This is why I suggest below that you bring the devm_add_action_or_reset()
into this function rather than registering it sometime later.

> +
> +	/* Config register returned in third byte, strip away the busy status */
> +	data->config = buffer[2] & ~ADS1110_CFG_ST_BSY;
> +
> +	return 0;
> +}
> +
> +static int ads1110_parse_dt(struct ads1110_data *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	int gain;
> +	int rate;
> +	int ret;
> +
> +	if (!fwnode)
> +		return 0;
I'd rather see this done property by property.
> +
> +	ret = fwnode_property_read_u32(fwnode, "ti,gain", &gain);
These are properties of the main device node? If so use
device_property_read_u32() etc.

Sashiko pointed out this property isn't in the binding.
Note that to add it you'll need to justify why it is about the circuitry
around the device rather than sometime we should just leave to userspace.

u32 for the variable gain, not an int.

> +	if (!ret) {
For this preference is to check for fwnode_property_present() or device
equivalent. Then we can try and read it and return an error if it is not
in the right format, whilst also enabling a default fallback.

> +		ret = ads1110_pga_gain_to_field_value(gain);
> +		if (ret < 0) {
> +			dev_warn(dev, "Invalid ti,gain %d, using default gain\n", gain);

Error out on invalid value rather than carrying on.

> +		} else {
> +			ret = ads1110_set_config_bits(data, ADS1110_PGA_MASK,
> +					FIELD_PREP(ADS1110_PGA_MASK, ret));
> +			if (ret < 0)
> +				return ret;
> +		}
> +	} else {
> +		dev_warn(dev, "No ti,gain device tree configuration found; using default gain\n");
Seems like the dt-binding should have a documented default, then no print here.

> +	}
> +
> +	ret = fwnode_property_read_u32(fwnode, "ti,data-rate", &rate);
> +	if (!ret) {
> +		ret = ads1110_set_data_rate(data, 0, rate);
> +		if (ret < 0)
> +			dev_warn(dev, "Invalid ti,data-rate %d, using default data rate\n", rate);
Similar to above.

> +	} else {
> +		dev_warn(dev, "No ti,data-rate device tree configuration found; using default data rate\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void ads1110_disable_continuous(void *data)
> +{
> +	ads1110_set_config_bits(data, ADS1110_CFG_SC, ADS1110_SINGLESHOT);
> +}
> +
> +static int ads1110_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads1110_data *data;
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, data);
> +	data->client = client;
> +	mutex_init(&data->lock);
For new code
	ret = devm_mutex_init(&data->lock);
	if (ret)
		return ret;

the lock debugging is most likely not of much use here, but it's really
cheap to enable it so better to do so.

> +
> +	indio_dev->name = "ads1110";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &ads1110_channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->info = &ads1110_info;
> +
> +	data->reg_vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(data->reg_vdd))
> +		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
> +				     "Failed to get vdd regulator\n");
> +
> +	ret = regulator_enable(data->reg_vdd);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable vdd regulator\n");

Need something to disable the power on remove.  However be careful as we
may or may not be in runtime suspend when the driver is unbound.

> +	ret = ads1110_setup(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to communicate with device\n");

Some of these error prints will be only slightly longer than 80 chars. As such
I'd put them on one line.

> +
> +	ret = ads1110_parse_dt(data);

Not checked?

> +
> +	ret = devm_add_action_or_reset(dev, ads1110_disable_continuous, data);
> +	if (ret)
> +		return ret;

This seems more related to ads1110_setup than parse_dt, so should be a few
lines up.  Maybe even move it in that function so we can see the relationship
to the specific call that enabled continuous mode.

> +
> +	ads1110_calc_scale_avail(data);
> +
> +	pm_runtime_set_autosuspend_delay(dev, ADS1110_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable pm_runtime\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static int ads1110_runtime_suspend(struct device *dev)
> +{
> +	struct ads1110_data *data = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "Suspending device\n");
> +
> +	ads1110_set_config_bits(data, ADS1110_CFG_SC, ADS1110_SINGLESHOT);
> +	regulator_disable(data->reg_vdd);
> +
> +	return 0;
> +}
> +
> +static int ads1110_runtime_resume(struct device *dev)
> +{
> +	struct ads1110_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(dev, "Resuming device\n");
For a simple 'did the function run' we can use ftrace and don't
need debug statements.  Keep those for more interesting fine grained
stuff. 
> +
> +	ret = regulator_enable(data->reg_vdd);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to enable Vdd\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * We'll always change the mode bit in the config register, so there is
> +	 * no need here to "force" a write to the config register. If the device
> +	 * has been power-cycled, we'll re-write its config register now.
> +	 */
> +	return ads1110_set_config_bits(data, ADS1110_CFG_SC,
> +				       ADS1110_CONTINUOUS);
Fits on a line under 80 chars.

> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(ads1110_pm_ops,
> +				 ads1110_runtime_suspend,
> +				 ads1110_runtime_resume,
> +				 NULL);
wrap longer in general for macros and function parameters.
 It's fine to go a little over 80 chars if it helps readability.  This
should probably be:

static DEFINE_RUNTIME_DEV_PM_OPS(ads1110_pm_ops, ads1110_runtime_suspend,
> +				 ads1110_runtime_resume, NULL);

> +
> +static const struct i2c_device_id ads1110_id[] = {
> +	{ "ads1110" },

We have moved IIO to all named initializers for i2c_device_id tables
similar to what we always did for of_device_id.
I have a patch converting all existing drivers on the iio tree for the
next merge cycle.


> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, ads1110_id);
> +
> +static const struct of_device_id ads1110_of_match[] = {
> +	{.compatible = "ti,ads1110" },
	{ .compatible = "ti,ads1110" },

> +	{ }
> +};


