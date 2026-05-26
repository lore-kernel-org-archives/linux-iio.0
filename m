Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516764218B8;
	Tue, 26 May 2026 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818385; cv=none; b=twdSb+SRwTAqJdqWz/hrg+CgNUV9DxS7QHLCE/Wgvf4ytUTZVAIkmSQp6dmyMWgKFjmmZIW1bOHH3KW/vQWeTOmpFY9yKJ9cLWciUz5q5cgxf5Ywvrw6MgAz47qvOUyXgu6SLMPrfJBhw2WOGcRUoyNQWGozMCxJL71WEHL5S6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818385; c=relaxed/simple;
	bh=Bn2KmXeW4OxPMlPq4CD+TF8/I6iECDWC6ZCB/mEefsk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5N5OjAxS28p74egMAfaJVXTMWnSkWT+wTOvXCCRsXwLGxz9bxyZoKFJBPMupwyVlsD16f714jSkvO3ZUcW0Fl+AAj6sBlp2hqQJTxcgBnIbeNFoMx9QaQ7FXq+BzLNVdrdxeJtPuE8GQfA9ujAIb4mFHn9RouCBD4P9l4S4y+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRNkTt9r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRNkTt9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691E31F0156E;
	Tue, 26 May 2026 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779818384;
	bh=r0rsNPFHUc4QovVcKCemrS5n2zS75nSR7UFfzirLv9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oRNkTt9rO7mkrZHKpOufe/KCo+kQvkmN3i+zso6sjMShYyx1XDGSQ4HMSeqbkgOVl
	 pmJsvOjWUCHxcEzLD8TdySIAxJDCODokRsJcgdpaqZqdx/eo6EDvjBPflp3F4vnRKf
	 9TZLbZJpNi8MBP+aBIBEIsOVnFgnsyuHWJUPxv73OochcUC8mFk2iSctAbXQU1bnZQ
	 yWSqQRSaw64v8J+rjid3kj6FtbV+qMM0R0LrnG5C1V+SsMPEgJdE7US9Kjm4hLgZTY
	 L7drBen8cKBf0MDS6+JDyAqppghFd+DzU2qlBOoJc/M2XJ+m50r+ciLoP9KAwHJBor
	 RO0DIJPyvD3ww==
Date: Tue, 26 May 2026 18:59:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260526185933.0084679f@jic23-huawei>
In-Reply-To: <20260524-veml6031x00-v3-2-29165609b2b5@gmail.com>
References: <20260524-veml6031x00-v3-0-29165609b2b5@gmail.com>
	<20260524-veml6031x00-v3-2-29165609b2b5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 23:53:56 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> These sensors provide two light channels (ALS and IR), I2C communication
> and a multiplexed interrupt line to signal data ready and configurable
> threshold alarms.
> 
> This first implementation provides basic functionality (measurement
> configuration, raw reads and ID validation) and defines the different
> register regions in preparation for extended features in the subsequent
> patches of the series.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

A few things inline.  Biggest one is that device driver specific state needs
local well documented locking. Here the whole complex gain handling means there
are a bunch of register field where the accesses to each set of them need
to appear atomic.

> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> new file mode 100644
> index 000000000000..50979d239230
> --- /dev/null
> +++ b/drivers/iio/light/veml6031x00.c
> @@ -0,0 +1,657 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VEML6031X00 Ambient Light Sensor
> + *
> + * Copyright (c) 2026, Javier Carrasco <javier.carrasco.cruz@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>

mod_devicetable.h is missing. Please check again for others.

> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
This isn't needed yet - bring it in when it is.

> +#include <linux/iio/iio-gts-helper.h>

> +static int veml6031x00_set_scale(struct iio_dev *iio, int val, int val2)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int gain_sel, it_sel, ret;
> +
> +	ret = iio_gts_find_gain_time_sel_for_scale(&data->gts, val, val2,
> +						   &gain_sel, &it_sel);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.it, it_sel);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.pd_div4, gain_sel >> 2);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_field_write(data->rf.gain, gain_sel & 0x03);
> +}
> +
> +static int veml6031x00_get_scale(struct veml6031x00_data *data, int *val,

One of the few thing sashiko raised on this patch that seems reasonable is
this is doing a bunch of accesses to fields that are updated via other
paths. It may make sense to ensure we get a consistent set and don't manage
to hit the middle of a write elsewhere - such as in set_scale()

Given that this is a driver specific thing rather than a state transition
matter, a local mutex should be used to ensure these are serialized.
Using the direct mode claim is relying on an internal implementation detail
(that there is a serializing lock in there).


> +				 int *val2)
> +{
> +	int gain, it, gain_reg, pd_div4, it_reg, ret, sel;
> +
> +	ret = regmap_field_read(data->rf.gain, &gain_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(data->rf.pd_div4, &pd_div4);
> +	if (ret)
> +		return ret;
> +
> +	sel = (pd_div4 << 2) | gain_reg;
> +	gain = iio_gts_find_gain_by_sel(&data->gts, sel);
> +	if (gain < 0)
> +		return gain;
> +
> +	ret = regmap_field_read(data->rf.it, &it_reg);
> +	if (ret)
> +		return ret;
> +
> +	it = iio_gts_find_int_time_by_sel(&data->gts, it_reg);
> +	if (it < 0)
> +		return it;
> +
> +	ret = iio_gts_get_scale(&data->gts, gain, it, val, val2);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
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
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
Doing this before you have added any means to get into any other mode
is premature. This claim belongs in the next patch.

> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6031x00_get_it(data, &it_usec);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* integration time + 10 % to ensure completion */
> +	fsleep(it_usec + (it_usec / 10));
> +
> +	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
> +	if (ret)
> +		return ret;
> +
> +	*val = le16_to_cpu(reg);
> +	return IIO_VAL_INT;
> +}
> +
> +static int veml6031x00_read_raw(struct iio_dev *iio,
> +				struct iio_chan_spec const *chan, int *val,
> +				int *val2, long mask)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return veml6031x00_single_read(iio, chan->type, val);
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		return veml6031x00_get_it(data, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return veml6031x00_get_scale(data, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int veml6031x00_write_raw(struct iio_dev *iio,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
> +{
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
As above. 
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return veml6031x00_set_it(iio, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return veml6031x00_set_scale(iio, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
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
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio);
> +	i2c_set_clientdata(i2c, iio);
> +	data->dev = dev;
> +	data->regmap = regmap;
> +
> +	ret = veml6031x00_regfield_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init regfield\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	data->chip = i2c_get_match_data(i2c);
> +	if (!data->chip)
> +		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");
> +
> +	ret = devm_add_action_or_reset(dev, veml6031x00_als_shutdown_action, data);

Why is shutdown cleanup registered before the power_on?  If that has to happen
then add a comment on why here. Otherwise move it down a few lines.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add shutdown action\n");
> +
> +	/* The device starts in power down mode by default */
> +	ret = veml6031x00_als_power_on(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to power on the device\n");
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
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device\n");
> +
> +	return 0;
> +}

> +
> +static const struct of_device_id veml6031x00_of_match[] = {
> +	{
> +		.compatible = "vishay,veml6031x00",
> +		.data = &veml6031x00_chip,
> +	},
> +	{
> +		.compatible = "vishay,veml6031x01",
> +		.data = &veml6031x01_chip,
> +	},
> +	{
> +		.compatible = "vishay,veml60311x00",
> +		.data = &veml60311x00_chip,
> +	},
> +	{
> +		.compatible = "vishay,veml60311x01",
> +		.data = &veml60311x01_chip,

These would actually end up shorter than the i2c_device_id ones below
if they were on one line.  Pick a style and use it for both tables.
I prefer this one a little.


> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, veml6031x00_of_match);
> +
> +static const struct i2c_device_id veml6031x00_id[] = {
> +	{ .name = "veml6031x00", .driver_data = (kernel_ulong_t)&veml6031x00_chip },
> +	{ .name = "veml6031x01", .driver_data = (kernel_ulong_t)&veml6031x01_chip },
> +	{ .name = "veml60311x00", .driver_data = (kernel_ulong_t)&veml60311x00_chip },
> +	{ .name = "veml60311x01", .driver_data = (kernel_ulong_t)&veml60311x01_chip },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, veml6031x00_id);
> +
> +static struct i2c_driver veml6031x00_driver = {
> +	.driver = {
> +		.name = "veml6031x00",
> +		.of_match_table = veml6031x00_of_match,
> +		.pm = pm_ptr(&veml6031x00_pm_ops),
> +	},
> +	.probe = veml6031x00_probe,
> +	.id_table = veml6031x00_id,
> +};
> +module_i2c_driver(veml6031x00_driver);
> +
> +MODULE_AUTHOR("Javier Carrasco <javier.carrasco.cruz@gmail.com>");
> +MODULE_DESCRIPTION("VEML6031X00 Ambient Light Sensor");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_GTS_HELPER");
> 

