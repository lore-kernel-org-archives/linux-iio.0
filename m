Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E1313E17;
	Mon, 11 May 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514654; cv=none; b=gtu5WBdibpVwDaQp/LcuUCqkRmDnNbqH8Hozm3xLkPgWFPgkULMXa6G0QctcjsUWyEHvA/wsuqetReUMIOBthlUPxpbqLM/8xk5C5Cu2oAFOpFCIHaGBP0LCuldv85pa5Dl+gHIg9cquYlEfHtZZiJQ5gRxhX1lX4fbBfRfQShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514654; c=relaxed/simple;
	bh=XLY6Hf5hfyml7xSnUkZgcpAFFr9L6a0912c876sikQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hongsyz05nX5ICjpJLdfAdWB0rThfaVLR3WH2fib8p8AWYztvrSwSmTnnDzG7AXcDew5veramQdMd9XuYAXAG+Dc5wdLv8nzSPr7rWj3ql6VaFjDMd8Xg+ZXuRNj2e/Q9zhAJOiZUktbKhLi5MkPFIk1M1Vgb57hh+5OeEqAHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn2LMBJq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn2LMBJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB93C2BCB0;
	Mon, 11 May 2026 15:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778514654;
	bh=XLY6Hf5hfyml7xSnUkZgcpAFFr9L6a0912c876sikQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fn2LMBJqCWj3b7KfatHQbbVCONxbMJHCd9UTBzVmvsyIBC6tVQ6ivGjpGDy0q5bbu
	 zbhyf1sR17ZAIf+kRQmBCzNPHqGIV+7LFj8x8mY2NZjBvXBpc296r22BorLoiLAu6n
	 8BUbQJwy5mUfBMbVU4MHK+nRB0o7G1YrGPLOPdkjo7dIyaY8QAiO+/0a6itVKZzSJR
	 tF32ZRkEJNSuH3oKAcTC4B2S/0Gmwr/RqO7m9AtbW4QM/5jihjNtyWAb6ovqTFfbBD
	 uyi8vmuOWt3JQTytAFm4yE+AQx2SGjeu5UIvC0Ur8ryl3EO2PPGH87OTh5cfF+ZiHG
	 0WjN3I5yDeOEQ==
Date: Mon, 11 May 2026 16:50:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandre Hamamdjian via B4 Relay
 <devnull+azkali.limited.gmail.com@kernel.org>
Cc: azkali.limited@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1730: Add bh1730 light sensor driver
Message-ID: <20260511165047.18b2a2a4@jic23-huawei>
In-Reply-To: <20260511-bh1730-v1-2-e0df1f499135@gmail.com>
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
	<20260511-bh1730-v1-2-e0df1f499135@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 01:09:50 +0700
Alexandre Hamamdjian via B4 Relay <devnull+azkali.limited.gmail.com@kernel.org> wrote:

> From: CTCaer <ctcaer@gmail.com>
> 
> Add a driver for the ROHM BH1730FVC ambient light sensor. The device
> is a 16-bit I2C digital sensor with separate visible and infrared
> photodiodes, four selectable gains (1x/2x/64x/128x) and a programmable
> integration time.
> 
> The driver exposes illuminance via IIO, performs runtime gain and
> integration-time tracking to keep the ADC in range, and supports
> optional als-vdd / als-vid regulators. Per-board lux calibration data
> (integration cycles, lux multiplier, optical-window coefficients, and
> gain sensitivity coefficients) can be supplied via device tree;
> sensible defaults are used otherwise.
> 
> Signed-off-by: CTCaer <ctcaer@gmail.com>
> Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
Hi Alexandre

Nice driver in general - some comments inline to add to those from Matti and
Andy.

thanks,

Jonathan

> ---
>  drivers/iio/light/Kconfig  |   9 +
>  drivers/iio/light/Makefile |   1 +
>  drivers/iio/light/bh1730.c | 686 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 696 insertions(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index eff33e456c70..3869060567dd 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -135,6 +135,15 @@ config AS73211
>  	 This driver can also be built as a module.  If so, the module
>  	 will be called as73211.
>  
> +config BH1730
> +	tristate "ROHM BH1730 ambient light sensor"
> +	depends on I2C
> +	help
> +	  Say Y here to build support for the ROHM BH1730 ambient light sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called bh1730.
> +
>  config BH1745
>  	tristate "ROHM BH1745 colour sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c0048e0d5ca8..27ef7906a02a 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_APDS9300)		+= apds9300.o
>  obj-$(CONFIG_APDS9306)		+= apds9306.o
>  obj-$(CONFIG_APDS9960)		+= apds9960.o
>  obj-$(CONFIG_AS73211)		+= as73211.o
> +obj-$(CONFIG_BH1730)		+= bh1730.o
>  obj-$(CONFIG_BH1745)		+= bh1745.o
>  obj-$(CONFIG_BH1750)		+= bh1750.o
>  obj-$(CONFIG_BH1780)		+= bh1780.o
> diff --git a/drivers/iio/light/bh1730.c b/drivers/iio/light/bh1730.c
> new file mode 100644
> index 000000000000..c93290ff5661
> --- /dev/null
> +++ b/drivers/iio/light/bh1730.c
> @@ -0,0 +1,686 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ROHM BH1730 ambient light sensor driver
> + *
> + * Copyright (c) 2021 CTCaer <ctcaer@gmail.com>
> + *
> + * Based on previous iio BH1730FVC drivers from:
> + * Copyright (c) 2018 Google, Inc.
> + * Author: Pierre Bourdon <delroth@google.com>
> + *
> + * Copyright (C) 2012 Samsung Electronics. All rights reserved.
> + * Author: Won Huh <won.huh@samsung.com>
> + *
> + * Data sheets:
> + *  http://www.rohm.com/web/global/datasheet/BH1730FVC/bh1730fvc-e
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/time.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define BH1730_NAME	"bh1730fvc"
Don't have a define like this - it is rarely the case that there
are places where it needs to be the same and it means the value isn't
readily available.

> +
> +#define BH1730_CMD_BIT BIT(7)
> +
> +#define BH1730_REG_CONTROL	0x00
> +#define BH1730_REG_TIMING	0x01
> +#define BH1730_REG_INTERRUPT	0x02
> +#define BH1730_REG_THLLOW	0x03
> +#define BH1730_REG_THLHIGH	0x04
> +#define BH1730_REG_THHLOW	0x05
> +#define BH1730_REG_THHHIGH	0x06
> +#define BH1730_REG_GAIN		0x07
> +#define BH1730_REG_ID		0x12
> +#define BH1730_REG_DATA0LOW	0x14
> +#define BH1730_REG_DATA0HIGH	0x15
> +#define BH1730_REG_DATA1LOW	0x16
> +#define BH1730_REG_DATA1HIGH	0x17
> +
> +#define BH1730_CONTROL_POWER		BIT(0)
> +#define BH1730_CONTROL_ADC_EN		BIT(1)
> +#define BH1730_CONTROL_DATA0_ONLY	BIT(2)
> +#define BH1730_CONTROL_ONE_TIME		BIT(3)
> +#define BH1730_CONTROL_ADC_VALID	BIT(4)
> +#define BH1730_CONTROL_INTR		BIT(5)
> +
> +#define BH1730_INTERNAL_CLOCK_NS	2800
> +/* BH1730_INTERNAL_CLOCK_MS * 714 */
> +#define BH1730_ADC_CALC_DELAY_US	2000
> +/* BH1730_INTERNAL_CLOCK_MS * 964 */
> +#define BH1730_ITIME_TO_US		2700
> +
> +#define BH1730_DEFAULT_INTEG_CYCLE	38
> +#define BH1730_DEFAULT_ITIME_MS		100
> +
> +#define BH1730_POWER_ON_DELAY_US	10000
> +
> +#define BH1730_MAX_MEASURED_LUX		100000
> +
> +enum bh1730_gain {
> +	BH1730_GAIN_1X = 0,
Which each takes a specific value because they are a hardware thing
I'd always set them all - even if it seems a bit silly!
> +	BH1730_GAIN_2X,
> +	BH1730_GAIN_64X,
> +	BH1730_GAIN_128X,
> +};
> +#define BH1730_MAX_GAIN_MULTIPLIER 128

> +static int bh1730_read_word(struct bh1730_data *bh1730, u8 reg)
> +{
> +	int ret = i2c_smbus_read_word_data(bh1730->client,
> +					   BH1730_CMD_BIT | reg);
> +	if (ret < 0)
> +		dev_err(&bh1730->client->dev,
> +			"i2c read failed error %d, register %01x\n",
> +			ret, reg);

As Matti suggested - might be worth looking at regmap as seems to be
fairly standard register interface and that bring a bunch of nice
helpers.

> +
> +	return ret;
> +}
> +
> +static int bh1730_write(struct bh1730_data *bh1730, u8 reg, u8 val)
> +{
> +	int ret = i2c_smbus_write_byte_data(bh1730->client,
> +					    BH1730_CMD_BIT | reg,
> +					    val);
> +	if (ret < 0)
> +		dev_err(&bh1730->client->dev,
> +			"i2c write failed error %d, register %01x\n",
> +			ret, reg);
> +
> +	return ret;
> +}

> +
> +static int bh1730_itime_us(struct bh1730_data *bh1730, int cycle)
> +{
> +	return (BH1730_ITIME_TO_US * cycle);
> +}
Not sure this function is worth having.  The code seems simpler than the
function call!
> +
> +
> +static int bh1730_set_integration_time_cycle(struct bh1730_data *bh1730,
> +					  u32 cycle)
> +{
> +	int ret, itime;
> +
> +	itime = 256 - cycle;
> +
> +	/* ITIME == 0 is reserved for manual integration mode. */
> +	if (itime <= 0 || itime > 255) {
> +		dev_warn(&bh1730->client->dev,
> +		"integration time out of range: %d cycles\n",
> +		 cycle);
Align as:
		dev_warn(&bh1730->client->dev,
			 "integration time out of range: %d cycles\n",
			 cycle);

> +
> +		return -ERANGE;
> +	}
> +
> +	ret = bh1730_write(bh1730, BH1730_REG_TIMING, itime);
> +	if (ret < 0)
> +		return ret;
> +
> +	bh1730->itime_us = bh1730_itime_us(bh1730, cycle);
> +	bh1730->tmt_us = bh1730->itime_us + BH1730_ADC_CALC_DELAY_US;
> +
> +	return 0;
> +}
> +
> +static int bh1730_adjust_gain(struct bh1730_data *bh1730)

Auto ranging is done by some sensor drivers and does explain why
you are hiding the scale.  Ok. I don't mind doing it this way
though ti can be a bit tricky to get working right.

> +{
> +	int visible, ir, highest, gain, ret;
> +
> +	visible = bh1730_read_word(bh1730, BH1730_REG_DATA0LOW);
> +	if (visible < 0)
> +		return visible;
> +
> +	ir = bh1730_read_word(bh1730, BH1730_REG_DATA1LOW);
> +	if (ir < 0)
> +		return ir;
> +
> +	highest = max(visible, ir);
> +
> +	/* Adjust gain based on sensitivity calibration */
> +	gain = bh1730->gain;
> +	if (highest > bh1730->cal.gain_coeff[gain].fl &&
> +	    gain != BH1730_GAIN_1X) {
> +		gain--; /* Decrease sensitivity */
> +	} else if (highest < bh1730->cal.gain_coeff[gain].cl &&
> +		   gain != BH1730_GAIN_128X) {
> +		gain++; /* Increase sensitivity */
> +	}

No {} as only single line statements.

> +
> +	/* Clamp to proper gain values */
> +	if (gain < 0)
> +		gain = BH1730_GAIN_1X;
> +	else if (gain > BH1730_GAIN_128X)
> +		gain = BH1730_GAIN_128X;

clamp()

> +
> +	if (gain != bh1730->gain) {
> +		ret = bh1730_set_gain(bh1730, gain);
> +		if (ret < 0)
> +			return ret;
> +
> +		usleep_range(bh1730->tmt_us, bh1730->tmt_us + 1000);
		fsleep() see below.

> +	}
> +
> +	return 0;
> +}
> +
> +static int bh1730_get_lux(struct bh1730_data *bh1730)
> +{
> +	int i, visible, ir;
> +	struct opt_win_coeff_t *opt_win_coeff;
> +	u64 lux = 0;
> +
> +	visible = bh1730_read_word(bh1730, BH1730_REG_DATA0LOW);
> +
> +	/* If visible is 0, skip calculations */
> +	if (visible <= 0)
> +		return visible;
> +
> +	ir = bh1730_read_word(bh1730, BH1730_REG_DATA1LOW);
> +	if (ir < 0)
> +		return ir;
> +
> +	/* Calibrate based on optical window */
> +	for (i = 0; i < bh1730->cal.opt_win_coeff_count; i++) {
> +		opt_win_coeff = &bh1730->cal.opt_win_coeff[i];
> +		if (1000 * ir / visible < opt_win_coeff->rc) {
> +			lux = ((u64)opt_win_coeff->cv * visible) -
> +				   (opt_win_coeff->ci * ir);
> +			break;
> +		}
> +	}
> +
> +	/* Calculate lux */
> +	lux *= BH1730_DEFAULT_ITIME_MS;
> +	lux /= bh1730_gain_multiplier(bh1730) * bh1730->itime_us;
> +	lux = (lux * bh1730->cal.mul) / 1000;
> +
> +	if (lux > BH1730_MAX_MEASURED_LUX)
> +		lux = BH1730_MAX_MEASURED_LUX;

	lux = min(lux, HB1730_MAX_MEASURED_LUX);

> +
> +	return (int)lux;
Maybe mask it? That will make it more explicit if you expect overflow.

> +}
> +
> +static int bh1730_power_ctrl(struct bh1730_data *bh1730, bool enable)

There is very little shared in here. Would it be cleaner as a power_on and
a power_off as separate functions?

> +{
> +	struct device *dev = &bh1730->client->dev;
> +	static bool enabled;
> +	int ret = 0;
> +
> +	if (enabled == enable)
> +		return ret;
> +
> +	if (enable) {
> +		if (!IS_ERR_OR_NULL(bh1730->reg_vdd)) {
Turn them on anyway - the stub regulators mentioned below should deal
with them not existing. We might end up with a pointless sleep but it's
not very long anyway ;)
> +			ret = regulator_enable(bh1730->reg_vdd);
> +			if (ret) {
> +				dev_err(dev, "%s: Failed to enable vdd: %d\n",
> +					__func__, ret);
> +				return ret;
> +			}
> +		}
> +
> +		if (!IS_ERR_OR_NULL(bh1730->reg_vid)) {
> +			ret = regulator_enable(bh1730->reg_vid);
> +			if (ret) {
> +				dev_err(dev, "%s: Failed to enable vid: %d\n",
> +					__func__, ret);
> +				return ret;
> +			}
> +		}
> +
> +		usleep_range(BH1730_POWER_ON_DELAY_US, BH1730_POWER_ON_DELAY_US + 1000);

		fsleep() for all 'fuzzy' length sleeps like this - it provides
		a standardized amount of slack and cleanly deals with a wider range
		of sleep values than the more specific calls.


> +	} else {
> +		if (!IS_ERR_OR_NULL(bh1730->reg_vdd)) {
> +			ret = regulator_disable(bh1730->reg_vdd);
> +			if (ret) {
> +				dev_err(dev, "%s: Failed to disable vdd: %d\n",
> +					__func__, ret);
> +				return ret;
> +			}
> +		}
> +
> +		if (!IS_ERR_OR_NULL(bh1730->reg_vid)) {
> +			ret = regulator_disable(bh1730->reg_vid);
> +			if (ret) {
> +				dev_err(dev, "%s: Failed to disable vid: %d\n",
> +					__func__, ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	enabled = enable;
> +
> +	return ret;
> +}

> +
> +static int bh1730_power_off(struct bh1730_data *bh1730)
> +{
> +	int ret = bh1730_write(bh1730, BH1730_REG_CONTROL, 0);

Really minor thing:

If you are checking a value like this it is generally nicer to
split declaration and initialization.

	int ret;

	ret = bh...
	if (ret < 0)
		return ret;

> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return bh1730_power_ctrl(bh1730, false);
> +}
> +
> +static int bh1730_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct bh1730_data *bh1730 = iio_priv(indio_dev);
> +	int data_reg, ret;
> +
> +	ret = bh1730_adjust_gain(bh1730);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = bh1730_get_lux(bh1730);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->channel2) {
> +		case IIO_MOD_LIGHT_CLEAR:
> +			data_reg = BH1730_REG_DATA0LOW;
> +			break;
> +		case IIO_MOD_LIGHT_IR:
> +			data_reg = BH1730_REG_DATA1LOW;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		ret = bh1730_read_word(bh1730, data_reg);
> +		if (ret < 0)
> +			return ret;
> +		ret = ret * 1000 / bh1730_gain_multiplier(bh1730);

Intensity channels are always a little odd.
They have no defined units because there isn't a good general definition
but we can still have _SCALE attributes and as such I'd expect that
gain multiplier to be read via that.  Those do have to take in account
changes due to integration time and amplifiers though so can be a bit
fiddly to get right!

> +		*val = ret / 1000;
> +		*val2 = (ret % 1000) * 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = bh1730->itime_us;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bh1730_parse_dt(struct bh1730_data *bh1730, struct device_node *dn)
> +{
> +	struct device *dev = &bh1730->client->dev;
> +	int ret;
> +	u32 *opt_win_coeff = NULL;
> +	u32 *gain_coeff = NULL;
> +	int opt_win_coeff_count = 0, gain_coeff_count = 0, cycle = 0, mul = 0;
> +
> +	memcpy(&bh1730->cal, &def_lux_data, sizeof(struct lux_cal_data_t));
> +
> +	if (dn) {
> +		/* Get regulators */
> +		bh1730->reg_vdd = regulator_get(dev, "als-vdd");
> +		if (IS_ERR_OR_NULL(bh1730->reg_vdd)) {
> +			bh1730->reg_vdd = NULL;
> +			dev_warn(dev, "failed to get als-vdd");
Needs to be more nuanced. Might be a deferred probe. I would always
do
			return dev_err_probe() in this case.
Note that regulators that aren't present will be provided with a
dummy regulator and that will do nothing at all when told to turn on
and off.

if you actually need them to be real then oddly enough you need to
do a regulator_get_optional() as then you'll get an error return.
However - if you do that then add a comment.

> +		}
> +
> +		bh1730->reg_vid = regulator_get(dev, "als-vid");

devm_regulator_get()
As it stands you are leaking a reference so the drivers providing these
can't be fully removed even if all users are.

> +		if (IS_ERR_OR_NULL(bh1730->reg_vid)) {
> +			bh1730->reg_vid = NULL;
> +			dev_warn(dev, "failed to get als-vid");
Its either needed or not.  (Not the stub regulator thing I mention above).
So error out on an error - maybe it's a deferred probe result and we need
to wait for the regulator driver to finish binding.

> +		}
> +
> +		/* Get calibration */
> +		ret = of_property_read_u32(dn,
> +				"rohm,integration-cycle", &cycle);

I'd put that on one line. We are a bit flexible when wrapping is
hurting readability and can go a little past 80 chars.

All these need replacing with equivalents for generic firmware accesses.
		ret = device_property_read_u32() etc


> +		if (ret < 0)
> +			goto out;
> +
> +		ret = of_property_read_u32(dn,
> +				"rohm,lux-multiplier", &mul);
> +		if (ret < 0)
> +			goto out;
> +
> +		if (cycle == 0 || mul == 0)
> +			goto out;
> +
> +		/* Get optical window coefficients */
> +		opt_win_coeff_count = of_property_count_elems_of_size(dn,
> +					"rohm,opt-win-coeff", sizeof(u32));
> +		if (opt_win_coeff_count > 0) {
> +			opt_win_coeff = devm_kzalloc(dev,
> +						sizeof(u32) * opt_win_coeff_count,
> +						GFP_KERNEL);
> +			if (!opt_win_coeff) {
> +				dev_err(dev, "failed to allocate mem for opt_win_coeff");
> +				return -ENOMEM;
> +			}
> +
> +			ret = of_property_read_u32_array(dn, "rohm,opt-win-coeff",
> +					opt_win_coeff, opt_win_coeff_count);
> +
> +			if (ret) {
> +				devm_kfree(dev, opt_win_coeff);
> +				goto out;
> +			}
> +		}
> +
> +		/* Get gain sensitivity coefficients */
> +		gain_coeff_count = of_property_count_elems_of_size(dn,
> +					"rohm,gain-coeff", sizeof(u32));
> +
> +		if (gain_coeff_count == 8) { /* 2 for each gain supported */
> +			gain_coeff = devm_kzalloc(dev,
> +					sizeof(u32) * gain_coeff_count,
> +					GFP_KERNEL);
> +			if (!gain_coeff) {
> +				dev_err(dev, "failed to allocate mem for gain_coeff");
> +				return -ENOMEM;
> +			}
> +
> +			ret = of_property_read_u32_array(dn, "rohm,gain-coeff",
> +					gain_coeff, gain_coeff_count);
> +			if (ret) {
> +				if (opt_win_coeff)
> +					devm_kfree(dev, opt_win_coeff);
> +				devm_kfree(dev, gain_coeff);
> +				goto out;
> +			}
> +		}
> +
> +		if (opt_win_coeff) {
> +			bh1730->cal.opt_win_coeff =
> +					(struct opt_win_coeff_t *)opt_win_coeff;
> +			bh1730->cal.opt_win_coeff_count =
> +					opt_win_coeff_count /
> +					(sizeof(struct opt_win_coeff_t) /
> +					sizeof(u32));
> +		}
> +
> +		if (gain_coeff)
> +			bh1730->cal.gain_coeff = (struct gain_coeff_t *)gain_coeff;
> +
> +		bh1730->cal.itime_cycle = cycle;
> +		bh1730->cal.mul = mul;
> +
> +		return 0;
> +	}
> +
> +out:
> +	dev_info(&bh1730->client->dev, "using default calibration");

Probably a dev_dbg() as seems like a fairly normal thing to do? 
However, if a partial set of calibration properties are supplied then
we don't want to do this and you should just fail the probe.


> +
> +	return 0;
> +}

> +
> +static int bh1730_probe(struct i2c_client *client)
> +{
> +	struct bh1730_data *bh1730;
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
I'd use as
	struct device *dev = &client->dev; as lots of instances of it in here.

> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
> +		return -EIO;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*bh1730));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	bh1730 = iio_priv(indio_dev);
> +	bh1730->client = client;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = bh1730_parse_dt(bh1730, client->dev.of_node);
Andy mentioned this. Make it bh1730_parse_fw() and use
linux/property.h accessors.  Those work for dt and other firwmare types.
Those operate against the struct device rather.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = bh1730_power_on(bh1730);
> +	if (ret < 0)
> +		return ret;
Power is turned on here, but you don't turn it off if init_config fails?
The devm_add_action_or_reset() mentioned below probably belongs here.

> +
> +	ret = bh1730_init_config(bh1730);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &bh1730_info;
> +	indio_dev->name = "bh1730";
> +	indio_dev->channels = bh1730_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(bh1730_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto out_power_off;
> +
> +	return 0;
> +
> +out_power_off:
> +	dev_info(&client->dev, "%s: failed\n", __func__);

Print more relevant error messages where they occur. Also
dev_err and generally no need to add __func__ when messages
are more informative than this one.


> +	bh1730_power_off(bh1730);
If you use the devm_add_action_or_reset() suggested below
this will get cleaned up anyway on error so you can do
direct returns in the error paths.

> +	return ret;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
No need for these using modern intefaces.

> +static int bh1730_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct bh1730_data *bh1730 = iio_priv(indio_dev);
> +
> +	bh1730_power_off(bh1730);
> +
> +	return 0;
> +}
> +
> +static int bh1730_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct bh1730_data *bh1730 = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = bh1730_power_on(bh1730);
> +	if (ret < 0)
> +		return ret;
> +
> +	return bh1730_init_config(bh1730);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(bh1730_pm_ops, bh1730_suspend, bh1730_resume);
DEFINE_SIMPLE_DEV_PM_OPS()
https://elixir.bootlin.com/linux/v7.0.5/source/include/linux/pm.h#L416
(and the deprecation note for the macro you are using just below that)
which does magic to ensure this code is referenced but that the compiler
can figure out it can drop it.  That means we get build coverage but
no bloated code if power management isn't built in.

> +#endif
> +
> +static void bh1730_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct bh1730_data *bh1730 = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	bh1730_power_off(bh1730);

I'd suggest using a devm_add_action_or_reset() call to register that
power off in an appropriate place in probe.  Then you can use
devm_iio_device_register() and no need for a remove() at all.


> +}
> +
> +static const struct i2c_device_id bh1730_i2c_device_id[] = {
> +	{ BH1730_NAME, 0 },
I have no idea why this ", 0" is common. No point to it as it
always gets changed if we add new devices anyway.
	{ "bh1730fvc" }
	
> +	{}
	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, bh1730_i2c_device_id);
> +
> +static const struct of_device_id of_bh1730_match[] = {
> +	{ .compatible = "rohm,bh1730fvc" },
> +	{},
	{ }

So add a space + no comma on terminating entrees like this as
we never want to put anything after them.
> +};
> +MODULE_DEVICE_TABLE(of, of_bh1730_match);
> +
> +static struct i2c_driver bh1730_driver = {
> +	.probe = bh1730_probe,
> +	.remove = bh1730_remove,
> +	.driver = {
> +		.name = BH1730_NAME,
> +		.owner		= THIS_MODULE,
> +		.of_match_table = of_bh1730_match,
> +#ifdef CONFIG_PM_SLEEP
We have had better handling for this for a long time now!
		.pm = pm_sleep_ptr(&bh1730_pm_ops),

> +		.pm		= &bh1730_pm_ops,
> +#endif
> +	},
> +	.id_table = bh1730_i2c_device_id,
> +};
> +module_i2c_driver(bh1730_driver);
> +
> +MODULE_AUTHOR("CTCaer <ctcaer@gmail.com>");
> +MODULE_DESCRIPTION("ROHM BH1730FVC driver");
> +MODULE_LICENSE("GPL v2");
> 

