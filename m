Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A0288B1;
	Sun,  8 Mar 2026 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773004110; cv=none; b=IUzIipRvQkIhac57+YVzSC/XRKsDV0aadOGD7LhRyPylaQVZu+quBVU6lsjiMtZI09TCpwTM98ms9G5fdq+8h+0jDWPiPGs6X8Q1nGWfZjtCtNCYtnMTqew9u15Cr2Qo+0MZSRHGRQZDjS3iE6/gEG1MsJINAEF5R69bxoJgTFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773004110; c=relaxed/simple;
	bh=wGxr/AOXANCCjmASaB3ggrU5zNPddqu/jp8LCfYYHAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh9iLseocv/Llylp32Eft5NsjIvhwaSEfCG1EOCZwmJ2aGRq0EMxEaqSlUNpbzUimCd+OF8LhU/Wooa/93wguCh+uq1NvDBriecLSHVm8o9TT7rNDiYle9A2DfjIsduYTTtEP9Q1XtsrWeJv8GvXQy8dr0Ivy5nK2r47IiY+nSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMY57Kf6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMY57Kf6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773004109; x=1804540109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wGxr/AOXANCCjmASaB3ggrU5zNPddqu/jp8LCfYYHAg=;
  b=JMY57Kf6zAjctspy4KJTQKIHg06IxnhTXIWT7xEVpzcbFH6b6LJ2twcG
   pL8GKqvZnTsVCpVJUWstj4A6acN85A4M392A+8Ah+5lqLeApkUP+TcQWM
   LY6AFsSOMXIKGoPtJq93o1pqdUG+2VWfTnPf9RTS/FXs2clMjAah9LfGC
   A+02eY5gdD8+2LddeGYmTfDazbNi9fDD+RCJpB6EaR+DO00kEBAp7iccM
   XH+uth4ygAdXVIcSSrBwCjxfNLQcqsa9lDwxIjGaBMmeGDRml3TubfgKp
   VHUOK4rhhQgzBM+2ZjL79Nz2cqR2yTxPexfaEqc+ppuOirN2XkYRa477d
   g==;
X-CSE-ConnectionGUID: Nk29LWK0TEOJjhlbRtTVvA==
X-CSE-MsgGUID: hkiUO82aSh6+I4D1+Y+33g==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74223625"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74223625"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 14:08:28 -0700
X-CSE-ConnectionGUID: gGtLYqpkQp+iJuxYkf0l+g==
X-CSE-MsgGUID: 6Vd7+LK1SBqEcc8Uep3wcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="216553050"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 14:08:25 -0700
Date: Sun, 8 Mar 2026 23:08:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <aa3lRthNn_VnFChk@ashevche-desk.local>
References: <20260308113728.40860-1-email@sirat.me>
 <20260308113728.40860-3-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308113728.40860-3-email@sirat.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 08, 2026 at 05:37:28PM +0600, Siratul Islam wrote:
> Add support for the STMicroelectronics VL53L1X Time-of-Flight
> ranging sensor with I2C interface.

I'm sorry, I missed cover letter, but can you remind if it has the explanation
that brand new driver is needed because of ...?

...

+ array_size.h

> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>

> +#include <linux/device.h>

I don't see how it's being used, dev_printk.h is missing, though.

+ err.h

> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

+ types.h

...

> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

Keep it ordered.

...

> +struct vl53l1x_data {

> +	struct i2c_client *client;

Seems to me used only for irq...

> +	struct regmap *regmap;

...device may be derived from here.

Switching saves up to 4 bytes on 64-bit machines.

> +	struct completion completion;
> +	struct regulator *vdd_supply;
> +	struct gpio_desc *xshut_gpio;
> +	enum vl53l1x_distance_mode distance_mode;
> +	u16 osc_calibrate_val;
> +	u8 gpio_polarity;
> +};

...

> +	0xFF, /* 0x80 */
> +	0x9B, /* 0x81 */
> +	0x00, /* 0x82 */
> +	0x00, /* 0x83 */
> +	0x00, /* 0x84 */
> +	0x01, /* 0x85 */
> +	0x00, /* 0x86 */
> +	0x00, /* 0x87 */

Can we have eight per line, please?

...

> +static int vl53l1x_chip_init(struct vl53l1x_data *data)
> +{
> +	struct device *dev = &data->client->dev;

Derive it from regmap.

> +	unsigned int val;
> +	u16 model_id;

> +	int tries = 1000;

Unnecessary, see below how to get rid of it.

> +	bool ready;
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
> +				       val & BIT(0), 1000, 100000);

1 * USEC_PER_MSEC
100 * USEC_PER_MSEC

> +	if (ret) {
> +		dev_err(dev, "firmware boot timeout\n");
> +		return ret;
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
> +	do {
> +		ret = vl53l1x_data_ready(data, &ready);
> +		if (ret)
> +			return ret;
> +		if (ready)
> +			break;
> +		/* 1ms poll, 1s timeout covers max timing budgets (per ST ULD) */
> +		fsleep(1000);
> +	} while (--tries);

Use something from iopoll.h instead.

> +	if (!tries)
> +		return -ETIMEDOUT;
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

> +static int vl53l1x_set_inter_measurement_ms(struct vl53l1x_data *data,
> +					    u16 period_ms)
> +{
> +	u16 clock_pll = data->osc_calibrate_val & VL53L1X_OSC_CALIBRATE_MASK;
> +	u32 inter_meas;
> +
> +	inter_meas = (u32)clock_pll * (u32)period_ms;

Unneeded castings. Standard promotion to int will work here, wouldn't it?

> +	inter_meas = (inter_meas * VL53L1X_OSC_CORRECTION_FACTOR) /
> +		     VL53L1X_OSC_CORRECTION_DIVISOR;
> +
> +	return vl53l1x_write_u32(data, VL53L1X_SYSTEM__INTERMEASUREMENT_PERIOD,
> +				 inter_meas);
> +}

...

> +static int vl53l1x_read_proximity(struct vl53l1x_data *data, int *val)
> +{
> +	unsigned long time_left;
> +	unsigned int range_status;
> +	u16 distance;
> +	int tries = 1000;

iopoll.h

> +	bool ready;
> +	int ret;
> +
> +	if (data->client->irq) {
> +		reinit_completion(&data->completion);
> +
> +		ret = vl53l1x_clear_irq(data);
> +		if (ret)
> +			return ret;
> +
> +		time_left = wait_for_completion_timeout(&data->completion, HZ);
> +		if (time_left == 0)
> +			return -ETIMEDOUT;
> +	} else {
> +		do {
> +			ret = vl53l1x_data_ready(data, &ready);
> +			if (ret)
> +				return ret;
> +
> +			if (ready)
> +				break;
> +			/* 1ms poll, 1s timeout covers max timing budgets (per ST ULD) */
> +			fsleep(1000);
> +		} while (--tries);
> +
> +		if (!tries)
> +			return -ETIMEDOUT;
> +	}
> +
> +	ret = regmap_read(data->regmap, VL53L1X_RESULT__RANGE_STATUS,
> +			  &range_status);
> +	if (ret)
> +		goto clear_irq;
> +
> +	if (FIELD_GET(VL53L1X_RANGE_STATUS_MASK, range_status) != VL53L1X_RANGE_STATUS_VALID) {
> +		ret = -EIO;
> +		goto clear_irq;
> +	}
> +
> +	ret = vl53l1x_read_u16(data,
> +			       VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
> +			       &distance);
> +	if (ret)
> +		goto clear_irq;

> +	dev_dbg(&data->client->dev, "distance=%u\n", distance);

Doesn't sound useful message when debugging a production code...

> +	*val = distance;
> +
> +clear_irq:
> +	vl53l1x_clear_irq(data);
> +	return ret;
> +}

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
> +		goto done;
> +
> +	ret = vl53l1x_read_u16(data,
> +			       VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
> +			       &scan.distance);
> +	if (ret)
> +		goto done;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +done:


The rule of thumb for label naming is what _will_ happen if goto. Here
something like exit_notify_and_clear_irq (or w/o exit_) looks better
to me.

> +	iio_trigger_notify_done(indio_dev->trig);
> +	vl53l1x_clear_irq(data);
> +
> +	return IRQ_HANDLED;
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
> +	fsleep(1200); /* 1.2 ms max boot duration per VL53L1X datasheet */

Please, move the comment to be on top of the line and add a reference to the
datasheet chapter / section / table /et cetera with a title.

> +
> +	return 0;
> +}

...

> +static int vl53l1x_configure_irq(struct i2c_client *client,
> +				 struct iio_dev *indio_dev)
> +{
> +	struct vl53l1x_data *data = iio_priv(indio_dev);

> +	int irq_flags = irq_get_trigger_type(client->irq);

Why?

> +	int ret;
> +
> +	ret = devm_request_irq(&client->dev, client->irq, vl53l1x_irq_handler,
> +			       irq_flags | IRQF_NO_THREAD,
> +			       indio_dev->name, indio_dev);
> +	if (ret)

> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to request IRQ\n");

Unneeded dup message.

> +	ret = regmap_write(data->regmap, VL53L1X_SYSTEM__INTERRUPT_CONFIG_GPIO,
> +			   VL53L1X_INT_NEW_SAMPLE_READY);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to configure IRQ\n");
> +
> +	return 0;
> +}

...

> +static int vl53l1x_probe(struct i2c_client *client)
> +{

	struct device *dev = &client->dev;

here will help a lot in the code below.

> +	struct vl53l1x_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);

> +	data->client = client;

Seems no need for that.
Looking at the data struct you even can keep not an irq, but just a boolean
flag, it will save the whole 8-byte block on 64-bit machines.

> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EOPNOTSUPP;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &vl53l1x_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> +				     "regmap initialization failed\n");
> +
> +	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> +				     "Unable to get VDD regulator\n");
> +
> +	data->xshut_gpio =
> +		devm_gpiod_get_optional(&client->dev, "xshut", GPIOD_OUT_HIGH);

One (single) line with the above suggestion (as an example, there are more like
this improvements can be performed).

> +	if (IS_ERR(data->xshut_gpio))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->xshut_gpio),
> +				     "Cannot get xshut GPIO\n");
> +
> +	ret = vl53l1x_power_on(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to power on the chip\n");
> +
> +	ret = devm_add_action_or_reset(&client->dev, vl53l1x_power_off, data);
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
> +	ret = devm_add_action_or_reset(&client->dev,
> +				       vl53l1x_stop_ranging_action, data);
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
> +		trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> +					      indio_dev->name,
> +					      iio_device_id(indio_dev));
> +		if (!trig)
> +			return -ENOMEM;
> +
> +		trig->ops = &vl53l1x_trigger_ops;
> +		iio_trigger_set_drvdata(trig, indio_dev);
> +		ret = devm_iio_trigger_register(&client->dev, trig);
> +		if (ret)
> +			return ret;
> +
> +		indio_dev->trig = iio_trigger_get(trig);
> +
> +		ret = vl53l1x_configure_irq(client, indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_iio_triggered_buffer_setup(&client->dev,
> +						      indio_dev, NULL,
> +						      &vl53l1x_trigger_handler,
> +						      &vl53l1x_buffer_setup_ops);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


