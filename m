Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8FB366831;
	Tue,  2 Jun 2026 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394497; cv=none; b=o+lJ+UOL+HuOqfBnhfUS9FWGmUDGxHZmb1H+nMK1og6V6uTTnDAZHhg1jxnHv6MO+BpXWRD5JjlVa07qOnzQy7Yz+hrBYKC+4Jjyc/I+BgmZSJRxV/GovOSVhWQtDKXNXmlgXC9RSY7dwQ6Qf8iVuoF01pi93ecsEPacMmRlqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394497; c=relaxed/simple;
	bh=SFyMNzUfBCHT31dKiixHE7meQZN1GE/AcyU3Ysm426I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI6ZTRL5FnA84+plxCZZgybvkVIhN+kdON1d2TZMYz9Ob4wonSger5IPuYGI85Fh44SuPEjqlBxE3kliw2x9RqqPrKxAyagXEa1vCCiQ3k9374+KQmGlUU+4SGLsHqu5KHEIpz+CZBvTo09gmbAdS8qEFwAZuyinN5reilvkTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WijiYFD5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WijiYFD5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780394495; x=1811930495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFyMNzUfBCHT31dKiixHE7meQZN1GE/AcyU3Ysm426I=;
  b=WijiYFD542SOGbeBS/uBnHwUOPJqc8W2ov6hM9jUGgFegYko3h7Y5yJQ
   UVQe0QQSoAhpY7eRDaCdPSjoOE7raWFULFEl7T4J+6GeGsCwBlCh4XN6H
   U87IC7vKtaBDDI1Zf+9xSwkNBCS/4d2wptkwIIcJFIyE0dFfDONdnathU
   9NlwtMfvXXaNm6jVjujIRr/bhdJjAeILp7p46JVKuCM+D6aI2mPaiR9m/
   6Iw1T1+EUx3lkMUcDUSB2Gy9/blZstfrLnAEBEDs/0yGNNYBp36eUh/tf
   jZ0YbjQzb15vfL8VI9ZLu7K6dUilQcvmGcDp7pBRWceNjob8YKwvzRPo7
   w==;
X-CSE-ConnectionGUID: oJteJz5gT0KRzbLnUl10iQ==
X-CSE-MsgGUID: c3xKpC2fQjKx4my9224pHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="92557243"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="92557243"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:01:34 -0700
X-CSE-ConnectionGUID: BO7QTNWQSVaWLn4HXKkPKQ==
X-CSE-MsgGUID: qiN/LRtDRFmXmWAbaecHag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="267509848"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:01:31 -0700
Date: Tue, 2 Jun 2026 13:01:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <ah6p-f2RCW8VcuDR@ashevche-desk.local>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 31, 2026 at 09:58:22PM +0200, Javier Carrasco wrote:
> These sensors provide two light channels (ALS and IR), I2C communication
> and a multiplexed interrupt line to signal data ready and configurable
> threshold alarms.
> 
> This first implementation provides basic functionality (measurement
> configuration, raw reads and ID validation) and defines the different
> register regions in preparation for extended features in the subsequent
> patches of the series.

...

+ array_size.h

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/i2c.h>

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>

In C locale it seems wrong order.

> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>

+ types.h

> +#include <linux/units.h>

+ Blank line.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/iio-gts-helper.h>

...

> +struct veml6031x00_data {

Have you run `pahole`? Does it agree with your layout?

> +	struct device *dev;
> +	struct iio_gts gts;
> +	struct regmap *regmap;

Do you need dev and regmap? One may be derived from the other in case regmap
uses the same dev on initialisation as the one stored here.

> +	struct veml6031x00_rf rf;
> +	const struct veml6031x00_chip *chip;
> +	/*
> +	 * Serialize access to scale register fields scattered across multiple
> +	 * registers (rf.gain, rf.pd_div4, rf.it) to read and write them as a
> +	 * consistent set.
> +	 */
> +	struct mutex scale_lock;
> +};

...

> +/*
> + * The gain selector encodes (PD_D4 << 2) | GAIN to identify each gain setting.
> + * Gains are multiplied by 8 to work with integers. The values in the iio-gts
> + * tables don't need corrections because the maximum value of the scale refers
> + * to GAIN = x1, and the rest of the values are obtained from the resulting
> + * linear function.
> + * TODO: add support for MILLI_GAIN_X165 and MILLI_GAIN_X660
> + */
> +#define VEML6031X00_SEL_MILLI_GAIN_X125  0x07
> +#define VEML6031X00_SEL_MILLI_GAIN_X250  0x04
> +#define VEML6031X00_SEL_MILLI_GAIN_X500  0x03
> +#define VEML6031X00_SEL_MILLI_GAIN_X1000 0x00
> +#define VEML6031X00_SEL_MILLI_GAIN_X2000 0x01

Not sure if these one-time use definitions improve or not the readability
of the code. Up to Jonathan.

> +static const struct iio_gain_sel_pair veml6031x00_gain_sel[] = {
> +	GAIN_SCALE_GAIN(1, VEML6031X00_SEL_MILLI_GAIN_X125),
> +	GAIN_SCALE_GAIN(2, VEML6031X00_SEL_MILLI_GAIN_X250),
> +	GAIN_SCALE_GAIN(4, VEML6031X00_SEL_MILLI_GAIN_X500),
> +	GAIN_SCALE_GAIN(8, VEML6031X00_SEL_MILLI_GAIN_X1000),
> +	GAIN_SCALE_GAIN(16, VEML6031X00_SEL_MILLI_GAIN_X2000),
> +};

...

> +{
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = data->dev;

In case you really need a 'dev' here, pass via function parameter, no need to
keep it in the 'data'.

> +	struct regmap_field *rm_field;
> +	struct veml6031x00_rf *rf = &data->rf;
> +
> +	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_gain);
> +	if (IS_ERR(rm_field))
> +		return PTR_ERR(rm_field);
> +	rf->gain = rm_field;
> +
> +	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_it);
> +	if (IS_ERR(rm_field))
> +		return PTR_ERR(rm_field);
> +	rf->it = rm_field;
> +
> +	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_pd_div4);
> +	if (IS_ERR(rm_field))
> +		return PTR_ERR(rm_field);
> +	rf->pd_div4 = rm_field;
> +
> +	return 0;
> +}

...

> +static int veml6031x00_get_it(struct veml6031x00_data *data, int *val2)
> +{
> +	int ret, it_idx;

Why is 'it_idx' signed?

> +
> +	scoped_guard(mutex, &data->scale_lock) {
> +		ret = regmap_field_read(data->rf.it, &it_idx);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val2 = ret;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}

...

> +static int veml6031x00_set_it(struct iio_dev *iio, int val, int val2)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret, gain_sel, gain_reg, pd_div4, it_idx, new_gain, prev_gain, prev_it;

Similar question here and so on...

> +	bool in_range;

> +}

...

> +	ret = regmap_field_write(data->rf.pd_div4, gain_sel >> 2);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_field_write(data->rf.gain, gain_sel & 0x03);

Looks like repetitive piece of code, shouldn't be a helper?

...

> +static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
> +				   int *val)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int addr, it_usec, ret;
> +	__le16 reg;
> +
> +	switch (type) {
> +	case IIO_LIGHT:
> +		addr = VEML6031X00_REG_ALS_L;
> +		break;
> +	case IIO_INTENSITY:
> +		addr = VEML6031X00_REG_IR_L;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6031x00_get_it(data, &it_usec);
> +	if (ret < 0)
> +		return ret;

> +	/* integration time + 10 % to ensure completion */

fsleep() adds up to 25%, isn't it enough?

> +	fsleep(it_usec + (it_usec / 10));
> +
> +	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
> +	if (ret)
> +		return ret;
> +
> +	*val = le16_to_cpu(reg);
> +	return IIO_VAL_INT;
> +}

...

> +static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
> +{
> +	int part_id, ret;
> +	__le16 reg;
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_ID_L, &reg,
> +			       sizeof(reg));
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Failed to read ID\n");
> +
> +	part_id = le16_to_cpu(reg);
> +	if (part_id != data->chip->part_id)
> +		dev_warn(data->dev, "Unknown ID %04x\n", part_id);

dev_warn_probe() for the sake of consistency?

> +	return 0;
> +}

...

> +static int veml6031x00_hw_init(struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	/* Max resolution = 6.9632 lx/cnt for gain = 0.125 and IT = 3.125ms */
> +	ret = devm_iio_init_iio_gts(dev, 6, 963200000,
> +				    veml6031x00_gain_sel,
> +				    ARRAY_SIZE(veml6031x00_gain_sel),
> +				    veml6031x00_it_sel,
> +				    ARRAY_SIZE(veml6031x00_it_sel),
> +				    &data->gts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init iio gts\n");

IIO GTS

> +	return 0;
> +}

...

> +static int veml6031x00_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct veml6031x00_data *data;
> +	struct iio_dev *iio;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
> +	if (IS_ERR(regmap))

> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to set regmap\n");

One line is okay.

> +	iio = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio);
> +	i2c_set_clientdata(i2c, iio);

> +	data->dev = dev;
> +	data->regmap = regmap;

As I said, one of these two is redundant.

> +	ret = devm_mutex_init(dev, &data->scale_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6031x00_regfield_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init regfield\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");

> +	data->chip = i2c_get_match_data(i2c);
> +	if (!data->chip)
> +		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");

I would move this closer to the point when we have data allocated. This is
a cheap check and it's better to boil out without need to allocate resources,
touch regulators (that might be undesired from power consumption and physical
processes due to the dragging them on and off), et cetera.

> +	/* The device starts in power down mode by default */
> +	ret = veml6031x00_als_power_on(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to power on the device\n");
> +
> +	ret = devm_add_action_or_reset(dev, veml6031x00_als_shutdown_action, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add shutdown action\n");
> +
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +
> +	ret = devm_pm_runtime_get_noresume(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get runtime PM\n");
> +
> +	ret = veml6031x00_validate_part_id(data);
> +	if (ret)
> +		return ret;
> +
> +	iio->name = data->chip->name;
> +	iio->channels = veml6031x00_channels;
> +	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->info = &veml6031x00_info;
> +
> +	ret = veml6031x00_hw_init(iio);
> +	if (ret)
> +		return ret;

> +	pm_runtime_put_autosuspend(dev);

Hmm... But why? Wouldn't this be problematic with reference count on the failed
devm_iio_device_register() below?

> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device\n");
> +
> +	return 0;
> +}

...

> +static DEFINE_RUNTIME_DEV_PM_OPS(veml6031x00_pm_ops, veml6031x00_runtime_suspend,
> +				 veml6031x00_runtime_resume, NULL);

Wrap this logically:

static DEFINE_RUNTIME_DEV_PM_OPS(veml6031x00_pm_ops,
				 veml6031x00_runtime_suspend,
				 veml6031x00_runtime_resume,
				 NULL);

OR

static DEFINE_RUNTIME_DEV_PM_OPS(veml6031x00_pm_ops,
				 veml6031x00_runtime_suspend, veml6031x00_runtime_resume, NULL);

...

> +static const struct i2c_device_id veml6031x00_id[] = {
> +	{
> +		.name = "veml6031x00",
> +		.driver_data = (kernel_ulong_t)&veml6031x00_chip

In the similar (to OF ID table) way, leave trailing commas.

> +	},
> +	{
> +		.name = "veml6031x01",
> +		.driver_data = (kernel_ulong_t)&veml6031x01_chip },

Broken indentation, should be a new line somewhere.

> +	{
> +		.name = "veml60311x00",
> +		.driver_data = (kernel_ulong_t)&veml60311x00_chip
> +	},
> +	{
> +		.name = "veml60311x01",
> +		.driver_data = (kernel_ulong_t)&veml60311x01_chip
> +	},

> +};

-- 
With Best Regards,
Andy Shevchenko


