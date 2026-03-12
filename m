Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E2362149;
	Thu, 12 Mar 2026 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327503; cv=none; b=WrnTAsiwMDTa9PF9Qu7iJwE7tb+sMQVhT1IHtgINjZ3c7W/D8r0F9j5SWtgcqaV/IFz/kC7HS2rR/KtLYY36ls005W9E2SsSdnHdlL8gAzxjSVE/GdtwWg5Q6pMc4TVUdvElUodq6jKSSEVksFIh6Nkt+Cjs6G2oAqc2DAZBmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327503; c=relaxed/simple;
	bh=fmBj0Y6Gg3Z3owlhIN52o7BilfrhRwuoR9SH2Ku4WwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNVKDWPGur9nU4YSWCNdE3ec41DdreJY8KsdIcvokt9Fg71EsLXBB786d5gH1Uzo2Jzphy1XHOzmZDoWsZJjdXFFDlCEBzl8i3bSoz3/mAPfmhm9X8zWoWKPuKPFZJI9uI4/fC/jGIpJhF05SXLTRbMkHsKMU+719X68v9F/LUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PrZb4q4h; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PrZb4q4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773327501; x=1804863501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fmBj0Y6Gg3Z3owlhIN52o7BilfrhRwuoR9SH2Ku4WwQ=;
  b=PrZb4q4hxgNg1BJ3KzsSexTGN98e6HJQmzPk243/Ot56d9trmLeWlA8g
   tfl/Ia39ntBjBSnPviF2ppOwTGentOGt2+2th87ZdB1MGDVLOARjScZiJ
   S2YoogkVwmJlY0ijEU8ow7QwsDV0aVWplbF9F8Fb04sMxHPbM97YHEJ5h
   ZJxtmRfWo2c/fFOb74n3JqNG8pYJqt/r7+8I+1LlMT0X1twaSKA4AQ797
   N5s67k5pVSBvxk32IkCQWCd2TlRbkbU7Jg7/XN7e+hJSB6fYs+ukLx88D
   y6j05iGJZIkng53odLcNN+oojb0lmAzOa0RNh1mUhob6gxKspjZW6yq7G
   Q==;
X-CSE-ConnectionGUID: Vup4l0LlRwysqo5NfF0QSQ==
X-CSE-MsgGUID: +A+TKWR6QZixK34Y52BY7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85898806"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85898806"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:58:17 -0700
X-CSE-ConnectionGUID: uR+A2H3TQP+fA1rOr9vsJg==
X-CSE-MsgGUID: apVq05d3S3OfX5uKuSPk4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="221030078"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:58:14 -0700
Date: Thu, 12 Mar 2026 16:58:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <abLUgxivQnz2ISeY@ashevche-desk.local>
References: <20260311224044.21480-1-email@sirat.me>
 <20260311224044.21480-3-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311224044.21480-3-email@sirat.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 04:40:37AM +0600, Siratul Islam wrote:
> Add support for the STMicroelectronics VL53L1X Time-of-Flight
> ranging sensor with I2C interface.

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

+ time.h // for USEC_PER_*

> +#include <linux/types.h>

+ asm/byteorder.h // for be16_to_*() et alai

...

> +#define VL53L1X_OSC_CORRECTION_FACTOR	1075
> +#define VL53L1X_OSC_CORRECTION_DIVISOR	1000

In math.h we have struct u32_fract. Use that instead

/* ...the comment... */
static const struct u32_fract ..._correction = {
	.numerator = 1075,
	.denominator = 1000,
};

...

> +struct vl53l1x_data {
> +	struct regmap *regmap;
> +	struct completion completion;
> +	struct regulator *vdd_supply;
> +	struct gpio_desc *xshut_gpio;
> +	enum vl53l1x_distance_mode distance_mode;
> +	u16 osc_calibrate_val;
> +	u8 gpio_polarity;
> +	int irq;
> +};

> +static const struct regmap_config vl53l1x_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,

No cache?

> +};

...

> +static int vl53l1x_read_u16(struct vl53l1x_data *data, u16 reg, u16 *val)
> +{
> +	__be16 buf;
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, reg, &buf, 2);

Here, and everywhere else in the same situation use sizeof().

> +	if (ret)
> +		return ret;
> +
> +	*val = be16_to_cpu(buf);
> +	return 0;
> +}

...

> +static int vl53l1x_clear_irq(struct vl53l1x_data *data)
> +{
> +	return regmap_write(data->regmap, VL53L1X_SYSTEM__INTERRUPT_CLEAR,
> +			    0x01);

It's perfectly one line (yes, it's fine to have it 81 characters).

> +}

...

> +static const u8 vl53l1x_default_config[] = {
> +	/* 0x2D, 0x2E, 0x2F, 0x30, 0x31, 0x32, 0x33, 0x34 */

	Just compress this to


> +	0x00, 0x00, 0x00, 0x01, 0x02, 0x00, 0x02, 0x08,

	0x00, 0x00, 0x00, 0x01, 0x02, 0x00, 0x02, 0x08,		/* 0x2d..0x34 */

Same approach to the rest.

> +	/* 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C */
> +	0x00, 0x08, 0x10, 0x01, 0x01, 0x00, 0x00, 0x00,
> +	/* 0x3D, 0x3E, 0x3F, 0x40, 0x41, 0x42, 0x43, 0x44 */
> +	0x00, 0xFF, 0x00, 0x0F, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C */
> +	0x00, 0x20, 0x0B, 0x00, 0x00, 0x02, 0x0A, 0x21,
> +	/* 0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52, 0x53, 0x54 */
> +	0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0xC8,
> +	/* 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C */
> +	0x00, 0x00, 0x38, 0xFF, 0x01, 0x00, 0x08, 0x00,
> +	/* 0x5D, 0x5E, 0x5F, 0x60, 0x61, 0x62, 0x63, 0x64 */
> +	0x00, 0x01, 0xCC, 0x0F, 0x01, 0xF1, 0x0D, 0x01,
> +	/* 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C */
> +	0x68, 0x00, 0x80, 0x08, 0xB8, 0x00, 0x00, 0x00,
> +	/* 0x6D, 0x6E, 0x6F, 0x70, 0x71, 0x72, 0x73, 0x74 */
> +	0x00, 0x0F, 0x89, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C */
> +	0x00, 0x00, 0x01, 0x0F, 0x0D, 0x0E, 0x0E, 0x00,
> +	/* 0x7D, 0x7E, 0x7F, 0x80, 0x81, 0x82, 0x83, 0x84 */
> +	0x00, 0x02, 0xC7, 0xFF, 0x9B, 0x00, 0x00, 0x00,
> +	/* 0x85, 0x86, 0x87 */
> +	0x01, 0x00, 0x00,
> +};

...

> +static int vl53l1x_chip_init(struct vl53l1x_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int val;
> +	u16 model_id;
> +	int ret;
> +
> +	if (!data->xshut_gpio) {
> +		ret = regmap_write(data->regmap, VL53L1X_SOFT_RESET, 0x00);
> +		if (ret)
> +			return ret;
> +		fsleep(100); /* conservative reset pulse, no spec */
> +
> +		ret = regmap_write(data->regmap, VL53L1X_SOFT_RESET, 0x01);
> +		if (ret)
> +			return ret;
> +		fsleep(1000); /* conservative boot wait, no spec */
> +	}
> +
> +	ret = regmap_read_poll_timeout(data->regmap,
> +				       VL53L1X_FIRMWARE__SYSTEM_STATUS, val,
> +				       val & BIT(0),
> +				       1 * USEC_PER_MSEC,
> +				       100 * USEC_PER_MSEC);
> +	if (ret) {

> +		dev_err(dev, "firmware boot timeout\n");
> +		return ret;

This is used solely in probe phase, hence it's fine to

		return dev_err_probe(...);

> +	}
> +
> +	ret = vl53l1x_read_u16(data, VL53L1X_IDENTIFICATION__MODEL_ID,
> +			       &model_id);
> +	if (ret)
> +		return ret;
> +
> +	if (model_id != VL53L1X_MODEL_ID_VAL)
> +		dev_info(dev, "unknown model id: 0x%04x, continuing\n", model_id);
> +
> +	ret = vl53l1x_read_u16(data, VL53L1X_RESULT__OSC_CALIBRATE_VAL,
> +			       &data->osc_calibrate_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_write(data->regmap, VL53L1X_DEFAULT_CONFIG_ADDR,
> +				vl53l1x_default_config,
> +				sizeof(vl53l1x_default_config));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, VL53L1X_GPIO_HV_MUX__CTRL, &val);
> +	if (ret)
> +		return ret;
> +	data->gpio_polarity = !!(val & VL53L1X_GPIO_HV_MUX_POLARITY);
> +
> +	/* Initial ranging cycle for VHV calibration */
> +	ret = vl53l1x_start_ranging(data);
> +	if (ret)
> +		return ret;
> +
> +	/* 1ms poll, 1s timeout covers max timing budgets (per ST ULD) */

What does ST ULD mean?! Please, avoid being cryptic in the comments.

> +	ret = regmap_read_poll_timeout(data->regmap,
> +				       VL53L1X_GPIO__TIO_HV_STATUS, val,
> +				       (val & 0x01) == (!data->gpio_polarity),

Too many parentheses

> +				       1 * USEC_PER_MSEC,
> +				       1000 * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_clear_irq(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_stop_ranging(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap,
> +			   VL53L1X_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND,
> +			   VL53L1X_VHV_LOOP_BOUND_TWO);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(data->regmap, VL53L1X_VHV_CONFIG__INIT, 0x00);
> +}

...

> +static const struct reg_sequence vl53l1x_mode_short[] = {
> +	{ VL53L1X_PHASECAL_CONFIG__TIMEOUT_MACROP,	0x14 },
> +	{ VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_A,		0x07 },
> +	{ VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_B,		0x05 },
> +	{ VL53L1X_RANGE_CONFIG__VALID_PHASE_HIGH,	0x38 },
> +	{ VL53L1X_SD_CONFIG__WOI_SD0,			0x07 },
> +	{ VL53L1X_SD_CONFIG__WOI_SD1,			0x05 },

> +	{ VL53L1X_SD_CONFIG__INITIAL_PHASE_SD0,		6 },
> +	{ VL53L1X_SD_CONFIG__INITIAL_PHASE_SD1,		6 },

Why out of a sudden decimal values? Why the rest is not decimal?

> +};
> +
> +static const struct reg_sequence vl53l1x_mode_long[] = {
> +	{ VL53L1X_PHASECAL_CONFIG__TIMEOUT_MACROP,	0x0A },
> +	{ VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_A,		0x0F },
> +	{ VL53L1X_RANGE_CONFIG__VCSEL_PERIOD_B,		0x0D },
> +	{ VL53L1X_RANGE_CONFIG__VALID_PHASE_HIGH,	0xB8 },
> +	{ VL53L1X_SD_CONFIG__WOI_SD0,			0x0F },
> +	{ VL53L1X_SD_CONFIG__WOI_SD1,			0x0D },
> +	{ VL53L1X_SD_CONFIG__INITIAL_PHASE_SD0,		14 },
> +	{ VL53L1X_SD_CONFIG__INITIAL_PHASE_SD1,		14 },

Ditto.

> +};

...

> +	inter_meas = clock_pll * period_ms;
> +	inter_meas = (inter_meas * VL53L1X_OSC_CORRECTION_FACTOR) /
> +		     VL53L1X_OSC_CORRECTION_DIVISOR;

Will become

	inter_meas = (clock_pll * period_ms * ..._correction.numerator) / ..._correction.denominator.

...


> +static int vl53l1x_read_proximity(struct vl53l1x_data *data, int *val)
> +{
> +	unsigned long time_left;

Useless, one time use variable.

> +	unsigned int range_status;
> +	u16 distance;
> +	int ret;
> +
> +	if (data->irq) {
> +		reinit_completion(&data->completion);
> +
> +		ret = vl53l1x_clear_irq(data);
> +		if (ret)
> +			return ret;
> +
> +		time_left = wait_for_completion_timeout(&data->completion, HZ);
> +		if (time_left == 0)
> +			return -ETIMEDOUT;

		if (... == 0)
			return -ETIMEDOUT;

> +	} else {
> +		unsigned int rdy;
> +
> +		/* 1ms poll, 1s timeout covers max timing budgets (per ST ULD) */
> +		ret = regmap_read_poll_timeout(data->regmap,
> +					       VL53L1X_GPIO__TIO_HV_STATUS, rdy,
> +					       (rdy & 0x01) == (!data->gpio_polarity),

Too many parentheses.

> +					       1 * USEC_PER_MSEC,
> +					       1000 * USEC_PER_MSEC);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_read(data->regmap, VL53L1X_RESULT__RANGE_STATUS,
> +			  &range_status);
> +	if (ret)
> +		goto clear_irq;
> +
> +	if (FIELD_GET(VL53L1X_RANGE_STATUS_MASK, range_status) != VL53L1X_RANGE_STATUS_VALID) {

Be consistent in the chosen style. Either 80 (which is still preferable in IIO)
or 100, but everywhere.

> +		ret = -EIO;
> +		goto clear_irq;
> +	}
> +
> +	ret = vl53l1x_read_u16(data,
> +			       VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
> +			       &distance);
> +	if (ret)
> +		goto clear_irq;
> +
> +	*val = distance;
> +
> +clear_irq:
> +	vl53l1x_clear_irq(data);
> +	return ret;
> +}

...

> +static int vl53l1x_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan, int *val,
> +			    int *val2, long mask)

Try to make wraps on a logical borders:

static int vl53l1x_read_raw(struct iio_dev *indio_dev,
			    const struct iio_chan_spec *chan,
			    int *val, int *val2, long mask)

...

> +static irqreturn_t vl53l1x_trigger_handler(int irq, void *priv)
> +{
> +	struct iio_poll_func *pf = priv;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +	struct {
> +		u16 distance;
> +		aligned_s64 timestamp;
> +	} scan = {};
> +	unsigned int range_status;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, VL53L1X_RESULT__RANGE_STATUS,
> +			  &range_status);
> +	if (ret || FIELD_GET(VL53L1X_RANGE_STATUS_MASK, range_status) !=
> +			   VL53L1X_RANGE_STATUS_VALID)

Just split for the sake of readability.

> +		goto notify_and_clear_irq;

	if (ret)
		goto notify_and_clear_irq;
	if (FIELD_GET(VL53L1X_RANGE_STATUS_MASK, range_status) !=
		      VL53L1X_RANGE_STATUS_VALID)
		goto notify_and_clear_irq;

> +	ret = vl53l1x_read_u16(data,
> +			       VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
> +			       &scan.distance);
> +	if (ret)
> +		goto notify_and_clear_irq;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +notify_and_clear_irq:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	vl53l1x_clear_irq(data);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int vl53l1x_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = vl53l1x_stop_ranging(data);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&data->completion);

> +	wait_for_completion_timeout(&data->completion, HZ / 10);

No error condition check?

> +	return vl53l1x_clear_irq(data);
> +}

...

> +static int vl53l1x_power_on(struct vl53l1x_data *data)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(data->vdd_supply);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value_cansleep(data->xshut_gpio, 0);
> +	/*
> +	 * 1.2 ms max boot duration.
> +	 * Datasheet Section 3.6 "Power up and boot sequence".
> +	 */
> +	fsleep(1200);
> +
> +	return 0;
> +}

...

> +static int vl53l1x_configure_irq(struct device *dev, int irq,
> +				 struct iio_dev *indio_dev)
> +{
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = devm_request_irq(dev, irq, vl53l1x_irq_handler,
> +			       IRQF_NO_THREAD,
> +			       indio_dev->name, indio_dev);

There is more room on the previous lines, use it.

> +	if (ret)

> +		return dev_err_probe(dev, ret, "failed to request IRQ\n");

Dup. IRQ core prints this for you.

> +
> +	ret = regmap_write(data->regmap, VL53L1X_SYSTEM__INTERRUPT_CONFIG_GPIO,
> +			   VL53L1X_INT_NEW_SAMPLE_READY);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to configure IRQ\n");
> +
> +	return 0;
> +}

...

> +static int vl53l1x_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct vl53l1x_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->irq = client->irq;

> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EOPNOTSUPP;

Why not checking for this before even doing any allocations?

> +	data->regmap = devm_regmap_init_i2c(client, &vl53l1x_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "regmap initialization failed\n");
> +
> +	data->vdd_supply = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
> +				     "Unable to get VDD regulator\n");

> +	data->xshut_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->xshut_gpio))
> +		return dev_err_probe(dev, PTR_ERR(data->xshut_gpio),
> +				     "Cannot get reset GPIO\n");

If it's a reset (semantically), use reset-gpio driver and reset APIs here.

> +	ret = vl53l1x_power_on(data);
> +	if (ret)

> +		return dev_err_probe(dev, ret,
> +				     "Failed to power on the chip\n");

Single line.

> +
> +	ret = devm_add_action_or_reset(dev, vl53l1x_power_off, data);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_chip_init(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_set_distance_mode(data, VL53L1X_LONG);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_set_timing_budget(data, 50);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_set_inter_measurement_ms(data, 50);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_start_ranging(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, vl53l1x_stop_ranging_action, data);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "vl53l1x";
> +	indio_dev->info = &vl53l1x_info;
> +	indio_dev->channels = vl53l1x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(vl53l1x_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	if (client->irq) {
> +		struct iio_trigger *trig;
> +
> +		init_completion(&data->completion);
> +
> +		trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +					      indio_dev->name,
> +					      iio_device_id(indio_dev));

More room on the previous lines, use it.

> +		if (!trig)
> +			return -ENOMEM;
> +
> +		trig->ops = &vl53l1x_trigger_ops;
> +		iio_trigger_set_drvdata(trig, indio_dev);
> +		ret = devm_iio_trigger_register(dev, trig);
> +		if (ret)
> +			return ret;
> +
> +		indio_dev->trig = iio_trigger_get(trig);
> +
> +		ret = vl53l1x_configure_irq(dev, client->irq, indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +						      &vl53l1x_trigger_handler,
> +						      &vl53l1x_buffer_setup_ops);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


