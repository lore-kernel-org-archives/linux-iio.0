Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC5367B7A;
	Mon,  8 Jun 2026 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943042; cv=none; b=CmMv7Zu+zYS84G52W4epLUqFwFc9opS0iHaEesCVOyW0O3/H0idhQE7vVSmD/SBNmzfbcOlVXSZK6B4T7bHCDrzxUCMfM1aF2hmIzZ0u+N/PWUADN+dQvxbFX9GRDSsvq4b2Z35tyk6sVW95YAtGTCAxhjbYJI98GzAzpcRaGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943042; c=relaxed/simple;
	bh=XlZhKiqZS07ozfiN1bTS8lQJvZYn7Q7syJvxZWA78hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCCEniCB8wTFRmMzlqJRMQ0Lgv90+BmHKEQXAcW5FjFq2sZdWJANThRTLCXmx6tiJlnHlMZgnu/5hcQLVKIuvqj/6Y6oTYvd80g+5+KQJmCVbqmpgnJ7FPFCWbHvKTN6VwwGAIpQbV42eNxmqL6OxGx3w6T/YIMlZw+MzkJUZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhuYs87x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhuYs87x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E071F00893;
	Mon,  8 Jun 2026 18:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780943040;
	bh=n2qQTh3RZwWhV4wGj2fLh77lHuSCta6DbjZuk6WVCwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mhuYs87xHdu6VT3Et2jKhoobB+acTcXJvaShJQfHLtVkTwC7F/IR2GVxKDocEtrNG
	 XFVFXJiJizHnilvL+GZt/Mr3ksefQ6lHtZRCb8+GlIHsU529w2moZUmSwleUoV+Ebu
	 nrC4hmqQgHvRRXpfVmjqtorZ1tYjpw6Sr6BBMQurbEZJaksI4a6PUjzq3BnIhXf5Qt
	 zz1ZxkoLptITuiGST2Qm6U0CP6hVdT45OyVcsTzHC9hBAsIfH5vtsZEjWXKxn7+9eY
	 U5tfdNfaetjjuLxCEKHM3Srn6VbFf9mcBZMcnurQjyTNepI0Ml48Eln+uIIpIszJaN
	 uIDlDW0B2k4rQ==
Date: Mon, 8 Jun 2026 19:23:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mike.looijmans@topic.nl,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 jorge.marques@analog.com, antoniu.miclaus@analog.com,
 mazziesaccount@gmail.com, jishnu.prakash@oss.qualcomm.com,
 duje@dujemihanovic.xyz, wens@kernel.org, sakari.ailus@linux.intel.com,
 linusw@kernel.org
Subject: Re: [PATCH 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100
 driver
Message-ID: <20260608192348.77e542f5@jic23-huawei>
In-Reply-To: <20260607183542.368184-4-jakubszczudlo40@gmail.com>
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
	<20260607183542.368184-4-jakubszczudlo40@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jun 2026 20:35:42 +0200
Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:

> From: jszczudlo <jakubszczudlo40@gmail.com>
> 
> add ADS1100 support
> make changing gain and datarate wait for new reading
> fix unbalanced regulator disable when removing in singleshot mode
> 
> Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>
Hi Jakub,

A few additional things for me.
Note that the IIO tree is closed for this cycle and even if it wasn't
don't rush on sending a new version (at least a few days for a patch like
this between versions). That will give more time for other reviewers
to spot things Joshua and I missed!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads1100.c | 165 ++++++++++++++++++++++++++---------
>  1 file changed, 126 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index aa8946063c7d..11d6fe1e8abc 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -5,18 +5,15 @@
>   * Copyright (c) 2023, Topic Embedded Products
>   *
>   * Datasheet: https://www.ti.com/lit/gpn/ads1100
> - * IIO driver for ADS1100 and ADS1000 ADC 16-bit I2C
> + * IIO driver for ADS1100, ADS1000 and ADS1110 ADC 16-bit I2C
>   */
>  
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> -#include <linux/cleanup.h>
> -#include <linux/delay.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
>  #include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
> -#include <linux/property.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/units.h>
> @@ -39,17 +36,39 @@
>  #define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
>  
>  #define ADS1100_SLEEP_DELAY_MS	2000
> +#define ADS1110_REFERENCE_VOLTAGE_MICROVOLT 2048000
Why not express this in milivolts and move the divisor for the
regulator into the place it is read?

> +
> +/* Timeout based on the minimum sample rate of 8 SPS (7500000us) */
> +#define ADS11x0_MAX_DRDY_TIMEOUT	7500000
>  
>  static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
> +static const int ads1110_data_rate[] = { 240, 60, 30, 15 };
>  static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
>  
> +struct ads11x0_config {
> +	const int *data_rate;
> +	bool has_reference_voltage;

const char *name;
(see below)

> +};
> +
> +static const struct ads11x0_config ads1100_config = {
> +	.data_rate = ads1100_data_rate,
> +	.has_reference_voltage = false,
> +};
> +
> +static const struct ads11x0_config ads1110_config = {
> +	.data_rate = ads1110_data_rate,
> +	.has_reference_voltage = true,
> +};
> +
>  struct ads1100_data {
>  	struct i2c_client *client;
>  	struct regulator *reg_vdd;
>  	struct mutex lock;
>  	int scale_avail[2 * 4]; /* 4 gain settings */
>  	u8 config;
> -	bool supports_data_rate; /* Only the ADS1100 can select the rate */
> +	bool supports_data_rate; /* Only the ADS1100/ADS1110 can select the rate */
> +	bool has_reference_voltage; /* The ADS1110 has an internal reference, so fixed scale */

As suggested below
	struct ads1100_config *config;
rather than fields to copy.

> +	const int *data_rate;
>  };
>  
>  static const struct iio_chan_spec ads1100_channel = {
> @@ -59,12 +78,6 @@ static const struct iio_chan_spec ads1100_channel = {
>  	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	.info_mask_shared_by_all_available =
>  	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -	.scan_type = {
> -		      .sign = 's',
> -		      .realbits = 16,
> -		      .storagebits = 16,
> -		      .endianness = IIO_CPU,
> -		       },

Unrelated change so separate patch.

>  	.datasheet_name = "AIN",
>  };
>  
> @@ -85,6 +98,50 @@ static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
>  	return 0;
>  };
>  
> +static int ads11x0_get_voltage_microvolts(struct ads1100_data *data)
> +{
> +	if (data->has_reference_voltage)
> +		return ADS1110_REFERENCE_VOLTAGE_MICROVOLT;
> +	else
> +		return regulator_get_voltage(data->reg_vdd);
> +}
> +
> +static int ads11x0_get_voltage_milivolts(struct ads1100_data *data)
> +{
> +	return ads11x0_get_voltage_microvolts(data) / (MICRO / MILLI);
> +}
> +
> +static bool ads11x0_new_data_ready(struct ads1100_data *data)
> +{
> +	int ret;
> +	u8 buffer[3];
> +
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +	if (ret < sizeof(buffer)) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return 0;
> +	}
> +
> +	int return_val = FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
> +
> +	return return_val;
Commented on this in Joshua's thread.
> +}
> +
> +static int ads11x0_poll_data_ready(struct ads1100_data *data)
> +{
> +	bool data_ready;
> +	u8 buffer[3];
> +	int datarate = data->data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
> +	unsigned long wait_time = DIV_ROUND_CLOSEST(MICRO, 5 * datarate);

Why that number?

> +
> +	/* To be sure that polled value will have value after config change */
> +	i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));

Why no return value check?  Even if it is just to ensure new data, nice
to know if the bus is falling over.


> +
> +	return read_poll_timeout(ads11x0_new_data_ready, data_ready,
> +				 !data_ready, wait_time,
> +				 ADS11x0_MAX_DRDY_TIMEOUT, false, data);
> +}
> +
>  static int ads1100_data_bits(struct ads1100_data *data)
>  {
>  	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
> @@ -105,9 +162,10 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
>  
>  	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
>  
> +	pm_runtime_mark_last_busy(&data->client->dev);

See below. This is probably an issue with forward porting from an old kernel.
Make sure to check for things like this in upstream as you should have
wondered why something so obvious was missing!  If it were missing this
would have been a fix (it's not missing).

>  	pm_runtime_put_autosuspend(&data->client->dev);
>  
> -	if (ret < 0) {
> +	if (ret < sizeof(buffer)) {
>  		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
>  		return ret;
>  	}
> @@ -127,7 +185,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
>  {
>  	int microvolts;
>  	int gain;
> -
> +	int ret;

Blank line here.

>  	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
>  	if (val)
>  		return -EINVAL;
> @@ -135,7 +193,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
>  	if (!val2)
>  		return -EINVAL;
>  
> -	microvolts = regulator_get_voltage(data->reg_vdd);
> +	microvolts = ads11x0_get_voltage_microvolts(data);
>  	/*
>  	 * val2 is in 'micro' units, n = val2 / 1000000
>  	 * result must be millivolts, d = microvolts / 1000
> @@ -147,34 +205,49 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
>  	if (gain < BIT(0) || gain > BIT(3))
>  		return -EINVAL;
>  
> +	ret = pm_runtime_resume_and_get(&data->client->dev);
> +	if (ret < 0)
> +		return ret;
> +
>  	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
>  
> -	return 0;
> +	ret = ads11x0_poll_data_ready(data);

As below - this applies to existing parts so if it makes sense, separate
patch before you add the new device support. That can have a description
that tells us why this is needed.

> +
> +	pm_runtime_mark_last_busy(&data->client->dev);
> +	pm_runtime_put_autosuspend(&data->client->dev);
> +
> +	return ret;
>  }
>  
>  static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
>  {
>  	unsigned int i;
>  	unsigned int size;
> +	int ret;
>  
>  	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
>  	for (i = 0; i < size; i++) {
> -		if (ads1100_data_rate[i] == rate)
> -			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
> -						       FIELD_PREP(ADS1100_DR_MASK, i));
> +		if (data->data_rate[i] == rate) {
Flip logic.

		if (data->data_rate[i] != rate)
			continue;

		ret = ...

reduces indent and generally simplifies things.

> +			ret = pm_runtime_resume_and_get(&data->client->dev);
> +			if (ret < 0)
> +				return ret;
> +
> +			ads1100_set_config_bits(data, ADS1100_DR_MASK,
> +						FIELD_PREP(ADS1100_DR_MASK, i));
> +			ret = ads11x0_poll_data_ready(data);

Why is the more complex handling needed for existing devices?
If it is then smells like it should be a precursor patch with that
well explained.

> +
> +			pm_runtime_mark_last_busy(&data->client->dev);
> +			pm_runtime_put_autosuspend(&data->client->dev);

Joshua called this out already.  I guess you are forward porting form an old
kernel as for a while the mark_last_busy() has been called by
put_autosuspend().

> +			return ret;
> +		}
>  	}
>  
>  	return -EINVAL;
>  }
>  
> -static int ads1100_get_vdd_millivolts(struct ads1100_data *data)
> -{
> -	return regulator_get_voltage(data->reg_vdd) / (MICRO / MILLI);
> -}
> -
>  static void ads1100_calc_scale_avail(struct ads1100_data *data)
>  {
> -	int millivolts = ads1100_get_vdd_millivolts(data);
> +	int millivolts = ads11x0_get_voltage_milivolts(data);

As below. No to the wild card. If you want to rename that's fine
but almost certainly wants to be a separate patch with a description
of why the rename makes sense.

>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
> @@ -196,7 +269,7 @@ static int ads1100_read_avail(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*type = IIO_VAL_INT;
> -		*vals = ads1100_data_rate;
> +		*vals = data->data_rate;
>  		if (data->supports_data_rate)
>  			*length = ARRAY_SIZE(ads1100_data_rate);
>  		else
> @@ -233,12 +306,11 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		/* full-scale is the supply voltage in millivolts */
> -		*val = ads1100_get_vdd_millivolts(data);
> +		*val = ads11x0_get_voltage_milivolts(data);
Nope. We don't use wild card naming in IIO drivers.  It goes wrong
too often as manufacturers have very inconsistent naming schemes.
+ The wild card is already wrong for the ads1000.

Sticking to existing prefix that matches the driver name is the
way to go.

>  		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
> -						   data->config)];
> +		*val = data->data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
Unrelated.  Check your patches for stuff like this. It is noise
that makes for lower quality reviews.

>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -280,8 +352,8 @@ static int ads1100_setup(struct ads1100_data *data)
>  		return ret;
>  
>  	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
> -	if (ret < 0)
> -		return ret;
> +	if (ret < sizeof(buffer))
> +		return -1;

Proper error returns and first check for ret < 0 as if it is you should return
that rather than eating the more informative error. This check is then only
on postive but too small values - so the rare case of a short recieve.

>  
>  	/* Config register returned in third byte, strip away the busy status */
>  	data->config = buffer[2] & ~ADS1100_CFG_ST_BSY;
> @@ -292,9 +364,13 @@ static int ads1100_setup(struct ads1100_data *data)
>  	return 0;
>  }
>  
> -static void ads1100_reg_disable(void *reg)
> +static void ads1100_reg_disable(void *data)
>  {
> -	regulator_disable(reg);
> +	struct ads1100_data *ads1100_data = data;
> +
> +	/* Disable when not already disabled by the driver */
> +	if (!(ads1100_data->config & ADS1100_CFG_SC))

Not obvious why regulator power is correlated with that register(?)
bit?  I'd imagine this is where issue Joshua called out that sashiko
reported is coming from.

> +		regulator_disable(ads1100_data->reg_vdd);
>  }
>  
>  static void ads1100_disable_continuous(void *data)
> @@ -307,6 +383,7 @@ static int ads1100_probe(struct i2c_client *client)
>  	struct iio_dev *indio_dev;
>  	struct ads1100_data *data;
>  	struct device *dev = &client->dev;
> +	const struct ads11x0_config *model;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -334,10 +411,18 @@ static int ads1100_probe(struct i2c_client *client)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to enable vdd regulator\n");
>  
> -	ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_vdd);
> +	ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data);
Unrelated change. 
>  	if (ret)
>  		return ret;
>  
> +	model = device_get_match_data(dev);
> +	if (!model)
> +		return dev_err_probe(dev, ret,
> +				"Can't set device data\n");
Discussion of this in Joshua's thread.
> +

The name should where possible reflect the actual device. Easy way to do 
this is normally to put a string in the model data and use that for
iio_dev->name.  There is a slightly ABI quirk that the driver doesn't do
this for the existing pair of support parts. We should probably leave
that alone, but we can at least do better for this one.

> +	data->data_rate = model->data_rate;
> +	data->has_reference_voltage = model->has_reference_voltage;

Probably just stash a pointer to model rather that copying elements.
The element copying route tends not to scale as a driver gets more complex.

> +
>  	ret = ads1100_setup(data);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
> @@ -400,16 +485,18 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
>  				 NULL);
>  
>  static const struct i2c_device_id ads1100_id[] = {
> -	{ "ads1100" },
> -	{ "ads1000" },
> +	{ .name = "ads1100", .driver_data = (kernel_ulong_t)&ads1100_config },
> +	{ .name = "ads1000", .driver_data = (kernel_ulong_t)&ads1100_config },
> +	{ .name = "ads1110", .driver_data = (kernel_ulong_t)&ads1110_config },
>  	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(i2c, ads1100_id);
>  
>  static const struct of_device_id ads1100_of_match[] = {
> -	{.compatible = "ti,ads1100" },
> -	{.compatible = "ti,ads1000" },
> +	{ .compatible = "ti,ads1100", .data = &ads1100_config },
> +	{ .compatible = "ti,ads1000", .data = &ads1100_config },
> +	{ .compatible = "ti,ads1110", .data = &ads1110_config },

As with binding, fix the ordering to be alphanumeric whilst we are here

>  	{ }
>  };
>  

