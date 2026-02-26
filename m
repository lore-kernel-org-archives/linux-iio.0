Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757123290A4;
	Thu, 26 Feb 2026 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128108; cv=none; b=HGqMMVk8iRngLd3+rhvDsmSMbZb7montoVMF73tbR0FnqBcr1LZleAHSJWHpe44ZbuIoO0BzvVZD0IKUVV0A6jsIX7lLgvMleO52G4ukVz09gD0nA7FTl8FgwfyI2Z0LSbMx3sdwoHREI4lFJw4xG8Q2xnt7kgF6Zm19tHMp0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128108; c=relaxed/simple;
	bh=KOFBdxXZLvXZb+MXTChMG7R0PNFjapyhVuj7jVA+RD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6mtWkFPGS2K08/e6Scwq3ttavALO45ohrxsI7EFHfHjOJlZsibG7mZ1fLryUPTZndI6RgjWxbCkKIKzLa+OdzU8iH9oErLjKLQ1xQLHYjU29zC4S8eZ0Qjwy2eEdd/50gvTmBebi4po0h021IpqPZk7uiVnh7L1PfyFJH8r0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZrPwC3g; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZrPwC3g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772128105; x=1803664105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KOFBdxXZLvXZb+MXTChMG7R0PNFjapyhVuj7jVA+RD4=;
  b=mZrPwC3gTMF4c1mC2tsayjr81PjqQ+fESUUkejWGk+1REiN/28aQLr5P
   hWdHFT3CQ8Bwv3gBgWQCQVxVbT6GbaeUDzw4R6/WY24MHUdTVAhNPLmeI
   GcszstB7nZWLNgn9ZGGM8Q59YA60UQNkw/UNkE0pM8z7OLeI4lYoSfNPt
   YtaH0DTSuwnBTVYCFNceDCc7CY4ME40qmP0n5BIt6TrVPitQ+vansmCe4
   XNhZujWQ1p4/aKdPpJcJIrK3hjLbNG2q5QnvaIFYtOhPej+s9BYTDOxAX
   eRD7tGRDWIIOO/whRQOktexQACiQ7yWL7W8OoiAmZ/abR+gAHyqWJukPP
   g==;
X-CSE-ConnectionGUID: QJPMzClqRuSpxmAZKwc9YQ==
X-CSE-MsgGUID: EsvGfDeBRq+tc1loBTG77w==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="72901261"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="72901261"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 09:48:16 -0800
X-CSE-ConnectionGUID: yTfOAPLTQ1+sgqLqhsyLgQ==
X-CSE-MsgGUID: aJ6PS6cvR9uqAIvYjILDBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="216767409"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 09:48:13 -0800
Date: Thu, 26 Feb 2026 19:48:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: add ADI MAX30210 driver
Message-ID: <aaCHW3hYUqHA4pgy@smile.fi.intel.com>
References: <20260226163041.169786-1-johnerasmusmari.geronimo@analog.com>
 <20260226163041.169786-3-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226163041.169786-3-johnerasmusmari.geronimo@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 12:30:41AM +0800, John Erasmus Mari Geronimo wrote:
> MAX30210 ±0.1°C Accurate Ultra-Small Low-Power Digital Temperature Sensor

Not enough for the commit message.

...

> +#include <asm/div64.h>

linux/math64.h

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>

> +#include <linux/debugfs.h>

Used?

> +#include <linux/delay.h>

> +#include <linux/errno.h>

You missed err.h

> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>

Wow! All of them are in use?

> +#include <linux/interrupt.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/stat.h>
> +#include <linux/string.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>

...

> +struct max30210_state {
> +	/*
> +	 * Prevent simultaneous access to the i2c client.
> +	 */
> +	struct mutex lock;

> +	struct regmap *regmap;


And if you swap them, won't the binary size be less?

> +	struct iio_trigger *trig;
> +	struct gpio_desc *powerdown_gpio;
> +	u8 watermark;
> +	u8 data[3 * MAX30210_FIFO_SIZE]  __aligned(IIO_DMA_MINALIGN);

Hmm... Don't we have a macro for this nowadays?

> +};

...

> +static const int samp_freq_avail[] = {

Why not 2D array?

> +	0, 15625,
> +	0, 31250,
> +	0, 62500,
> +	0, 125000,
> +	0, 250000,
> +	0, 500000,
> +	1, 0,
> +	2, 0,
> +	4, 0,
> +	8, 0

Leave trailing comma, it's not a terminator.

> +};

...

> +static int max30210_read_temp(struct regmap *regmap, unsigned int reg,
> +			      int *temp)
> +{
> +	u8 uval[2] __aligned(IIO_DMA_MINALIGN);

No way. This is variable on stack, not all CPUs / architectures allow this.
And actually why this alignment to begin with? Wouldn't

	__be16 val;

suffice?

> +	int ret;
> +
> +	ret = regmap_bulk_read(regmap, reg, uval, 2);

sizeof()

> +	if (ret)
> +		return ret;
> +
> +	*temp = sign_extend32(get_unaligned_be16(uval), 15);
> +
> +	return IIO_VAL_INT;
> +}

...

> +static void max30210_fifo_read(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	u32 samp;
> +	int ret, i, j;

Why are 'i' and 'j' signed?


> +	ret = regmap_bulk_read(st->regmap, MAX30210_FIFO_DATA_REG,
> +			       st->data, 3 * st->watermark);
> +	if (ret < 0)
> +		return dev_err(&indio_dev->dev, "Failed to read from fifo.\n");
> +
> +	for (i = 0; i < st->watermark; i++) {

'i' is not used outside for-loop, hence

	for (unsigned int i = 0; i < st->watermark; i++) {

> +		samp = 0;
> +		for (j = 0; j < 3; j++) {
> +			samp <<= 8;
> +			samp |= st->data[3 * i + j];
> +		}

Reinventing get_unaligned_be32() if I'm not mistaken.

> +		if (samp == MAX30210_FIFO_INVAL_DATA) {
> +			dev_err(&indio_dev->dev, "Invalid data\n");
> +			continue;
> +		}
> +
> +		iio_push_to_buffers(indio_dev, &samp);
> +	}
> +}

...

> +static int max30210_setup(struct max30210_state *st, struct device *dev)
> +{
> +	unsigned int val;
> +
> +	/* Power down to reset device */
> +	st->powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
> +						     GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->powerdown_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->powerdown_gpio),
> +				     "Failed to request powerdown GPIO.\n");
> +
> +	/* Power up device */
> +	gpiod_set_value(st->powerdown_gpio, 0);

All delays must be documented. Add a comment with the datasheet reference to
explain the value and need of the sleep.

> +	fsleep(700);

> +	/* Clear status byte */
> +	return regmap_read(st->regmap, MAX30210_STATUS_REG, &val);
> +}

...

> +static int max30210_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max30210_state *st;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);

> +	mutex_init(&st->lock);

	ret = devm_mutex_init(...);

> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable vdd regulator.\n");
> +
> +	st->regmap = devm_regmap_init_i2c(client, &max30210_regmap);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to allocate regmap.\n");
> +
> +	ret = max30210_setup(st, dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &max30210_channels;
> +	indio_dev->num_channels = 1;
> +	indio_dev->name = "max30210";
> +	indio_dev->info = &max30210_info;
> +
> +	ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev, NULL,
> +						  max30210_trigger_handler,
> +						  IIO_BUFFER_DIRECTION_IN,
> +						  &max30210_buffer_ops,
> +						  max30210_fifo_attributes);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (client->irq) {
> +		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						  indio_dev->name,
> +						  iio_device_id(indio_dev));
> +		if (!st->trig)
> +			return -ENOMEM;
> +
> +		st->trig->ops = &max30210_trigger_ops;
> +		iio_trigger_set_drvdata(st->trig, indio_dev);
> +		ret = devm_iio_trigger_register(dev, st->trig);
> +		if (ret)
> +			return ret;
> +
> +		indio_dev->trig = st->trig;
> +		ret = devm_request_threaded_irq(dev, client->irq,
> +						iio_trigger_generic_data_rdy_poll,
> +						NULL, IRQF_TRIGGER_FALLING,
> +						indio_dev->name, st->trig);
> +		if (ret)
> +			return ret;
> +	}

> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Wouldn't

	return devm_iio_device_register(dev, indio_dev);

suffice?

> +}

...

> +static const struct i2c_device_id max30210_id[] = {
> +	{ "max30210", 0 },

No ', 0' part.

> +	{ }
> +};

...

Can somebody at Analog start a common internal Wiki or other resources
and collect there typical requirements for the code in IIO? It will prevent
reviewers and maintainers from doing the same replies again and again.

-- 
With Best Regards,
Andy Shevchenko


