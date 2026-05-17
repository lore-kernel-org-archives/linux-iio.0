Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98FE3815ED;
	Sun, 17 May 2026 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779024899; cv=none; b=MhO8y3PnhSuSb2DwLNv6I7bHBhmldjY2EKRfGFTbMplf3MhQjF6mgYQgcKyeV/T0seO8o8jlHcRGCWHGHcEfh+2WjYPsbMmAM3PPb6ld3ypcwaNYD/XSuQB96wplv2BtMSqGrw4sIgPr3srcml7E8bEdDvOS4dMuOSRoK8aluwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779024899; c=relaxed/simple;
	bh=bKjlUmu59QzY3yUZwYKvRaqn7Hamk+Za8Jpd1+c9Kvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMMkDl6uI3iNULbVY3lksTlXZxNUKgExe1fUimgzLU7JrQC5H4nnYYcBwTgwc1Nac74WI1gcQ/XGYu6NiIRL4Hn9t7wpWRscdzqwMppY0KMKXW3bN5cXsRBJ+F691IDEp1gWr72SDOjDrofGICGoZ+T4tcsZRPZAH4D2LeJGYwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMOPFh46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMOPFh46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE148C2BCB0;
	Sun, 17 May 2026 13:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779024898;
	bh=bKjlUmu59QzY3yUZwYKvRaqn7Hamk+Za8Jpd1+c9Kvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OMOPFh466oF/mwIvfESTrv8xBSGuBY2lPBxnGIbKMcj5RHupBsc9XVAHmnD/tYcD3
	 n4N4oKCdSuwJlBC39TqC3mXmEZdn6HZgEw3A6g1kMW7vaYlxdTKrKN3uWJoo7S5SMF
	 piaQGJTDgpVzi89Saf5UOZcvI9wswTtR8HH5NWhf8CuhUDR/5UySL/T5kJhFc/Qrh/
	 YmAj0uBlkYONd51WF8iplAMHa3l8ViKWirROSryDeMkIl2fjGUnueAXdVMwK3OKK6w
	 bJ/1yaUTF8pcghLrIe7ZbbNDZR7Af+WKi/wvM+pkpaDHhWX5Okb7zyRj6y7JdJSpsy
	 RZOUTCs8HgXdA==
Date: Sun, 17 May 2026 14:34:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: veml3328: add support for new device
Message-ID: <20260517143449.6c30b99f@jic23-huawei>
In-Reply-To: <20260516-veml3328-v1-2-1d4b663e2fe3@gmail.com>
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
	<20260516-veml3328-v1-2-1d4b663e2fe3@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 23:50:54 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Add support for the Vishay VEML3328 RGB/IR light sensor communicating
> via I2C (SMBus compatible).
> 
> Also add a new entry for said driver into Kconfig and Makefile.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Hi Joshua,

Pretty nice for a v1.  A few comments inline to add to
the other reviews (I may well have duplicated some!)

Jonathan

> diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
> new file mode 100644
> index 000000000000..9eb5429c813d
> --- /dev/null
> +++ b/drivers/iio/light/veml3328.c
> @@ -0,0 +1,405 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Vishay VEML3328 RGBCIR light sensor driver
> + *
> + * Copyright (c) 2026 Joshua Crofts <joshua.crofts1@gmail.com>
> + *
> + * Datasheet: https://www.vishay.com/docs/84968/veml3328.pdf
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define VEML3328_REG_CONF		0x00
> +#define VEML3328_REG_ID			0x0c
> +#define VEML3328_REG_DATA_C		0x04
> +#define VEML3328_REG_DATA_R		0x05
> +#define VEML3328_REG_DATA_G		0x06
> +#define VEML3328_REG_DATA_B		0x07
> +#define VEML3328_REG_DATA_IR		0x08
> +
> +#define VEML3328_IT_MASK		GENMASK(5, 4)
> +#define VEML3328_GAIN_MASK		GENMASK(11, 10)
Name these so it is obvious which register they are in.
I guess VEML3328_CONF_IT_MASK etc.


> +
> +#define VEML3328_ID_VAL			0x28
> +
> +#define VEML3328_CONF_SD0		BIT(0)
> +#define VEML3328_CONF_SD1		BIT(15)
These two don't add anything given always used together.
> +#define VEML3328_SHUTDOWN		(VEML3328_CONF_SD0 | VEML3328_CONF_SD1)

#define VEML3328_SHUTDOWN		BIT(0) | BIT(15)

is sufficient

> +
> +struct veml3328_data {
> +	struct regmap *regmap;
> +	struct device *dev;
The use of the one embedded in regmap got mentioned already in another review.

> +	struct mutex lock;
All locks need a comment saying what data they are protecting
(might well be in the device).

Mind you - I'm seeing quite a bit of locking around simple regmap calls.
Given there are locks in regmap, you may need to call out if there
is a particular readout sequence that must not be interrupted.

I'm not immediately seeing one and as such you might not need a local
lock.

> +};
> +
> +static const struct regmap_config veml3328_regmap_config = {
> +	.name = "veml3328",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = VEML3328_REG_ID,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +#define VEML3328_CHAN_SPEC(_color, _addr) { \
> +	.type = IIO_INTENSITY, \
> +	.modified = 1, \
> +	.channel2 = IIO_MOD_LIGHT_##_color, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | \
> +				   BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | \
> +					     BIT(IIO_CHAN_INFO_SCALE), \
> +	.address = _addr, \
> +}
> +
> +static const struct iio_chan_spec veml3328_channels[] = {
> +	VEML3328_CHAN_SPEC(CLEAR, VEML3328_REG_DATA_C),

Would be nice to have a an IIO_LUX channel (always an approximation)
as that tends to be what userspace wanges.

Hmm. I googled a bit. Seems there is a note that has more info.
https://www.vishay.com/docs/80010/designingveml3328.pdf

Interestingly suggests that green channel is nearer than clear.

If you can put the correct scaling in that would be a good thing
to support (keep the green as well).



> +	VEML3328_CHAN_SPEC(RED, VEML3328_REG_DATA_R),
> +	VEML3328_CHAN_SPEC(GREEN, VEML3328_REG_DATA_G),
> +	VEML3328_CHAN_SPEC(BLUE, VEML3328_REG_DATA_B),
> +	VEML3328_CHAN_SPEC(IR, VEML3328_REG_DATA_IR),
> +};

> +
> +static int veml3328_power_up(struct veml3328_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap, VEML3328_REG_CONF,
> +				 VEML3328_SHUTDOWN, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	fsleep(veml3328_it_times[3][1]);

Add a comment on why we need to sleep maximum integration time.

> +
> +	return 0;
> +}
> +
> +static void veml3328_power_down_action(void *data)
> +{
> +	veml3328_power_down(data);
> +}
> +
> +static int veml3328_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct veml3328_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int reg_val;
> +	int ret;
> +	int reg;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(regmap, chan->address, &reg_val);
> +		if (ret < 0)
> +			goto exit;
> +
> +		*val = reg_val;
> +		ret = IIO_VAL_INT;
> +		break;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
> +		if (ret < 0)
> +			goto exit;
> +
> +		reg = FIELD_GET(VEML3328_IT_MASK, reg_val);
> +		if (reg >= ARRAY_SIZE(veml3328_it_times)) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		*val = veml3328_it_times[reg][0];
> +		*val2 = veml3328_it_times[reg][1];
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
> +		if (ret < 0)
> +			goto exit;
> +
> +		reg = FIELD_GET(VEML3328_GAIN_MASK, reg_val);
> +		if (reg >= ARRAY_SIZE(veml3328_scale_vals)) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		*val = veml3328_scale_vals[reg][0];
> +		*val2 = veml3328_scale_vals[reg][1];
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +exit:
> +	pm_runtime_put_autosuspend(data->dev);
See below for comment on how to handle this using stuff that
ultimately comes from cleanup.h

> +
> +	return ret;
> +}
> +

> +
> +static int veml3328_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct veml3328_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret;
> +	int i;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = pm_runtime_resume_and_get(data->dev);

PM_RUNTIME_ACQUIRE_AUTOSUSPEND() will mean you can rely on this
being auto suspended on exiting scope.  Will allow early returns
and get rid of your goto that you noted already.


> +	if (ret < 0)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val != 0) {
> +			ret = -EINVAL;
> +			goto exit;

With above, all these become direct returns.

> +		}
> +
> +		for (i = 0; i < ARRAY_SIZE(veml3328_it_times); i++) {
> +			if (veml3328_it_times[i][1] == val2)
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(veml3328_it_times)) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		ret = regmap_update_bits(regmap, VEML3328_REG_CONF,
> +					 VEML3328_IT_MASK,
> +					 FIELD_PREP(VEML3328_IT_MASK, i));
> +		break;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		for (i = 0; i < ARRAY_SIZE(veml3328_scale_vals); i++) {
> +			if (val == veml3328_scale_vals[i][0] &&
> +			    val2 == veml3328_scale_vals[i][1])
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(veml3328_scale_vals)) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		ret = regmap_update_bits(regmap, VEML3328_REG_CONF,
> +					 VEML3328_GAIN_MASK,
> +					 FIELD_PREP(VEML3328_GAIN_MASK, i));
> +
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +exit:
> +	pm_runtime_put_autosuspend(data->dev);
> +
> +	return ret;
> +}
> +
> +static int veml3328_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return IIO_VAL_INT_PLUS_MICRO;

That's the default - no need for the callback.

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info veml3328_info = {
> +	.read_raw = veml3328_read_raw,
> +	.write_raw = veml3328_write_raw,
> +	.read_avail = veml3328_read_avail,
> +	.write_raw_get_fmt = veml3328_write_raw_get_fmt,
> +};
> +
> +static int veml3328_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct veml3328_data *data;
> +	struct iio_dev *indio_dev;
> +	unsigned int reg_val;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->dev = dev;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &veml3328_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	ret = regmap_read(data->regmap, VEML3328_REG_ID, &reg_val);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to read ID register\n");
> +
> +	if ((reg_val & 0xff) != VEML3328_ID_VAL)
> +		return dev_err_probe(dev, -ENODEV, "Invalid device ID\n");

This breaks fallback dt compatibles.
If some future part is released that backwards compatible with this one, then
the dt-binding will reflect that.  That future part will typically have a different
ID_VAL.  We need that case of new binding, older kernel to work so this can't
fail probe.  It is fine to print a message though to indicate we are seeing
a value that we don't know about.

Note sashiko moans about this sometimes. It's wrong so ignore it on this
particular thing!  Sadly it's seeing a lot of older drivers where we did this
wrong in the past and haven't adding the churn needed to fix them all.

> +
> +	ret = veml3328_power_up(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to power on sensor\n");
> +
> +	ret = devm_add_action_or_reset(dev, veml3328_power_down_action, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register teardown\n");
> +
> +	indio_dev->name = "veml3328";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &veml3328_info;
> +	indio_dev->channels = veml3328_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(veml3328_channels);
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

