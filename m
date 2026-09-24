Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC5439908
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236505; cv=none; b=qprauO1MyY/E5svooRqulD4s3hgnDy/mZKSr28nLq6cUpHCNv65Xxk0EY/9nXndMGk16DXrHWZCgTJtyUoroUY3JGjzwP6qVyh8H77+KIlVy6wLf122JxBC3FjDYKm96DevvMJMoIK+nw0BT+1wuiU5uj50HtPWJy96wFr2QH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236505; c=relaxed/simple;
	bh=CGYd0ciqKYW9mkCJ0K1h1VaxHB5t87kWYqS7z71Sr9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/C86dwnMZ5eWUn9KBvoo05m9MJzKkIHohF667JcMwJ6L7y6qApcp0BO5LnLAhyZrUZnufYd37aC1D8mpKMWrFJ7bbzV8lCQvbXjauHWNj3M7uK0Z6V/3RP30WbQ2RgNC9p0HXw7JACELZuazCR9RJ4Wvx5OAO+7WsoKQZZ4HiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGSYWvfe; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGSYWvfe"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso1279925e9.3
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790236499; x=1790841299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hp0vvi7Zy65i20xh/BPLreHY1HTMwGwS6+nx6gpYD9c=;
        b=DGSYWvfe+GRjL6QLRV2x8yqL2Nevic8O/gDHOoYzvSOWAKo20C3mpCjg2xQ0CTWnVc
         /cUTHIChr8+unr4x+6JyEP6AtZkboGKrdWW7yDYNJ0Xp9luFm6n9DxMjXgP5SaMRH7Yp
         81dwqv+62tBHvfplOBdtpESBhBsXYSjeAu5ulhXxAzKJq/i7Njg69MRJax6xrUfsiZ7U
         agAx0Z2uPkkB1E7Wh9+8E44FJtzm73K5WumnmQnMTBwDeZfR9P/31ofpt9601QCvVOjA
         5YmZ5EQZpBbvtvGVeS4cuodauV1wxkBNWSy98C8KFznTYKqBnjkpZ4rMxIjspQxcVNzV
         9Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236499; x=1790841299;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hp0vvi7Zy65i20xh/BPLreHY1HTMwGwS6+nx6gpYD9c=;
        b=fsBT5jFUiVfsve+1pwh/EZZiNGxTP0JHbScS/x9/ptcgj+zB2cj3broihOo/vAeCx9
         wfYw104Vnet+2l9EUx7+piOURC+8fdMQOrQ6alf65pzNRQwgxMwLHdAc9ZiJ6a384+A0
         bIXk3U5eZ324wdh7JaTexzIv7MAw4oYbIF/zaF4YAiV3AqukOVouJgXsluMKMUHj/79S
         jB1aO0Rzq9unkTLpPYYeGosNArh0Mb63EmlkRGkJI0m6M2e0tGG0h8sdfAOVIM36LaeR
         dXEaDtjx9v8B6QRz8u36UjNMeUUPdq7VC0Cx+ZizoTAzaq22+AkKJMZRxlkOqA45L5q5
         bW0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxjmZxmXHWpTvE9lgrYCccyXYuj/tmkzINzWaOA+GfMj1icY1fKzEbQW0+8iJgnF6tONktyDwhI7BQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nlWZJomknihqJUfbSk2OOs4jjCBw+Pe6aG25RQxF9tecj16DZz
	ARu2F/rGR0+YQ23FS5f3nG+5ZLawP2nmM5wLRqMO6TWr/yIBKgTDXhF7
X-Gm-Gg: AYBFou0m7mCjDGpjqCU4oPEY4w7PFT09saoVXRU42roV9mhQW/cb/xBPP0eSJ1ykC0f
	4XSCsAymZTfVNtugH7W/K1M/XPRYapxg/s6iPtYXRgD9DoTL7Yfllh8aYe7tei20FgLPrVBv6Vf
	VSOj16iCmV1o6GmTO14/ZgSNaL45nPbazgbZYECZjN25Q3X8bTrGXEi3zyEKSRA/ky3ieZxM9Z6
	QzxLf9l7HtG6939s7Lm0v76p2GeIH3xL6CKOh9/9nEtJs4rvVszXF39PgrTJ/bPwzEydPelx7E8
	3bqbOM3DyTC9q7bb6VTLEFb6dEgOZ/Sp1LyH+ZsMbE1pP9Rzg8Zu8in+zg3hohAmVu4eXnxEfMw
	5QZIkrC6EzgdY4IEsmg9vTbNrVblqaLsQhjH2WXvkoNLInze/dHAxSpT0uKJ32Y12H4Q3ORlV3r
	Ec/DQY0Ja+nVbSVbYbU+jejcwwerbbz4d+5QV4Cfk/cduS2QywbW/OD76UFxbjBmxaMEaoy+i25
	vTC0oJ/9dYj+UtsXjoa2be5dmHT3u7S6JMAUFSgpOllJYvqKAFvR1c36hokezXGRFTQgMF5fIkq
	2DAwZ00MRlaEwlURcL5pkt/mdUGLaWN/YVzEhuHMO0FoZ8negjJvNktIL9UW4U4sP/3nF6FmlhJ
	80cbIiPoAjl8kSkoyJ/J4n7N+B31eW+y4kHnKZWkw+43eo4fg/CEc0UsFpjwcvFWX1RgSt7/FVl
	+RM0rF
X-Received: by 2002:a05:600c:6994:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49fe66cbb4dmr26433385e9.11.1790236499360;
        Thu, 24 Sep 2026 00:54:59 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c50da7sm77327375e9.3.2026.09.24.00.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:54:59 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:54:57 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: add driver for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
Message-ID: <20260924095457.00006ed6@gmail.com>
In-Reply-To: <20260923-topic-sm8x50-iio-max34417-adc-v1-2-41d4ba1bfc41@linaro.org>
References: <20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org>
	<20260923-topic-sm8x50-iio-max34417-adc-v1-2-41d4ba1bfc41@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 21:10:23 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver support
> getting the channels voltage and accumulated average power over an
> I2C/SMBUS serial interface.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Hi Neil,

Several comments inline.

Josh

>  drivers/iio/adc/Kconfig    |  11 ++
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/max34417.c | 356 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 368 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 415e519ad4eb..4c559bafd1ce 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1116,6 +1116,17 @@ config MAX34408
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max34408.
>  
> +config MAX34417
> +	tristate "Maxim max34417 ADC driver"

MAX34417

> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build ADC support for Maxim max34417 Four-Channel High
> +	  Dynamic Range Power Accumulator.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max34417.
> +

...

> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +

+ array_size.h, bits.h, err.h, math64.h, mutex.h, property.h, regulator/consumer.h,
sysfs.h, types.h

> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>

No need for this one, it's already in iio.h.

> +
> +#define MAX34417_UPDATE_REG		0x0
> +#define MAX34417_CONTROL_REG		0x1
> +#define MAX34417_ACC_COUNT_REG		0x2
> +

...

> +
> +/**
> + * struct max34417_data - max34417 specific data.
> + * @regmap:	device register map.
> + * @dev:	max34417 device.
> + * @lock:	lock for protecting access to device hardware registers, mostly

Nit-picking, but... Device, MAX34417, Lock.

> + *		for reading common accumulator count and control register.
> + * @input_correction:	Correction based on the Rsense value from channel nodes.
> + * @input_label:	Channel label from channel nodes.
> + */
> +struct max34417_data {
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct mutex lock;
> +	u32 input_correction[MAX34417_CHANNEL_COUNT];
> +	const char *input_label[MAX34417_CHANNEL_COUNT];
> +};
> +
> +static const struct regmap_config max34417_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= MAX34417_DID_REG,
> +};
> +

...

> +static int max34417_accumulator_update(struct max34417_data *max34417)
> +{
> +	int rc;
> +
> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +	if (rc) {
> +		dev_err(max34417->dev, "Error (%d) writing update register\n", rc);
> +		return rc;
> +	}
> +
> +	/* Wait for accumulator update */
> +	usleep_range(1000, 2000);

fsleep(1000) would be better.

> +
> +	return 0;
> +}
> +
> +static int max34417_read_voltage(struct max34417_data *max34417,
> +				 const struct iio_chan_spec *chan, int *val)
> +{
> +	uint16_t voltage;
> +	uint8_t buf[3];
> +	int rc;
> +
> +	guard(mutex)(&max34417->lock);
> +
> +	rc = max34417_accumulator_update(max34417);
> +	if (rc)
> +		return rc;
> +
> +	rc = regmap_noinc_read(max34417->regmap, chan->address, &buf, 3);
> +	if (rc)
> +		return rc;
> +
> +	voltage = buf[2] | ((uint64_t)buf[1] << 8);
> +	voltage >>= 2;
> +
> +	*val = voltage;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int max34417_read_power(struct max34417_data *max34417,
> +				 const struct iio_chan_spec *chan, int *val, int *val2)

The alignment is off here. Additionally, put val and val2 on a separate line.

> +{
> +	uint32_t acc_count;
> +	uint64_t power;
> +	uint8_t buf[8];
> +	int rc;
> +
> +	guard(mutex)(&max34417->lock);
> +
> +	rc = max34417_accumulator_update(max34417);
> +	if (rc)
> +		return rc;
> +
> +	rc = regmap_noinc_read(max34417->regmap, MAX34417_ACC_COUNT_REG,
> +			       &buf, 4);
> +	if (rc)
> +		return rc;
> +
> +	acc_count = buf[3] | ((uint64_t)buf[2] << 8) | ((uint64_t)buf[1] << 16);

Maybe a check that acc_count isn't zero in case of a bad read etc.?
It could cause a divide-by-zero error later.

> +
> +	rc = regmap_noinc_read(max34417->regmap, chan->address, &buf, 8);
> +	if (rc)
> +		return rc;
> +
> +	power = buf[7];
> +	power |= ((uint64_t)buf[6] << 8UL);
> +	power |= ((uint64_t)buf[5] << 16UL);
> +	power |= ((uint64_t)buf[4] << 24UL);
> +	power |= ((uint64_t)buf[3] << 32UL);
> +	power |= ((uint64_t)buf[2] << 40UL);
> +	power |= ((uint64_t)buf[1] << 48UL);
> +
> +	power = div_u64(power, acc_count);
> +
> +	*val = FIELD_GET(GENMASK(31, 0), power);
> +	*val2 = FIELD_GET(GENMASK(55, 32), power);

Sashiko points out: 

Will this build correctly on 32-bit architectures?

Since GENMASK() operates on unsigned long, which is 32 bits wide on those
platforms, attempting to mask bits 55..32 might result in an out-of-bounds
shift and trigger compiler errors or warnings like BUILD_BUG_ON_ZERO. Should
GENMASK_ULL(55, 32) be used instead?

> +
> +	return IIO_VAL_INT_64;
> +}
> +
> +static int max34417_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max34417_data *max34417 = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_VOLTAGE)
> +			return max34417_read_voltage(max34417, chan, val);
> +		return -EINVAL;

+ Blank line.

> +	case IIO_CHAN_INFO_AVERAGE_RAW:
> +		if (chan->type == IIO_POWER)
> +			return max34417_read_power(max34417, chan, val, val2);

+ Blank line.

> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_VOLTAGE) {
> +			/* Scale to mA */
> +			*val = MAX34417_VOLTAGE_CORRECTION_SCALE * MILLI;
> +			*val2 = MAX34417_VOLTAGE_FULL_SCALE_BITS;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		} else if (chan->type == IIO_POWER) {
> +			/* Scale to mW */
> +			*val = max34417->input_correction[chan->channel] * MILLI;
> +			*val2 = MAX34417_PWR_AVG_FULL_SCALE_BITS;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		}

+ Blank line.

> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max34417_read_label(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       char *label)
> +{
> +	struct max34417_data *max34417 = iio_priv(indio_dev);
> +	const char *input_label = max34417->input_label[chan->channel];
> +
> +	if (chan->type == IIO_VOLTAGE) {
> +		if (input_label)
> +			return sysfs_emit(label, "%s-voltage\n", input_label);

+ Blank line.

> +		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
> +	}
> +
> +	if (chan->type == IIO_POWER) {
> +		if (input_label)
> +			return sysfs_emit(label, "%s-power\n", input_label);

+ Blank line.

> +		return sysfs_emit(label, "channel%d-power\n", chan->channel);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info max34417_info = {
> +	.read_raw	= max34417_read_raw,
> +	.read_label	= max34417_read_label,
> +};
> +
> +static int max34417_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct max34417_data *max34417;
> +	struct fwnode_handle *node;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int rc;
> +
> +	regmap = devm_regmap_init_i2c(client, &max34417_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err_probe(dev, PTR_ERR(regmap),
> +			      "regmap_init failed\n");

One line is okay.

> +		return PTR_ERR(regmap);
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*max34417));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	/* Get and enable regulators */

Redundant comment IMO.

> +	rc = devm_regulator_get_enable(dev, "vdd");
> +	if (rc)
> +		return dev_err_probe(dev, rc, "failed to get vdd regulator\n");
> +
> +	rc = devm_regulator_get_enable(dev, "vio");
> +	if (rc)
> +		return dev_err_probe(dev, rc, "failed to get vio regulator\n");
> +
> +	max34417 = iio_priv(indio_dev);
> +	max34417->regmap = regmap;
> +	max34417->dev = dev;
> +	mutex_init(&max34417->lock);
> +
> +	device_for_each_child_node(dev, node) {

scoped variant would be better, Sashiko points out this could leak on early
exit.

> +		unsigned int correction;
> +		u32 rsense, index;
> +
> +		if (fwnode_property_read_u32(node, "reg", &index)) {
> +			dev_err(dev, "missing reg property of %pfwP\n", node);
> +			return -EINVAL;
> +		} else if (index >= MAX34417_CHANNEL_COUNT) {
> +			dev_err(dev, "invalid reg %d of %pfwP\n", index, node);
> +			return -EINVAL;
> +		}
> +

Why not dev_err_probe()?

> +		fwnode_property_read_string(node, "label", &max34417->input_label[index]);
> +		if (fwnode_property_read_u32(node, "maxim,rsense-val-micro-ohms", &rsense))
> +			rsense = MAX34417_DEFAULT_RSENSE;
> +
> +		/* (100 milliOhm / rsense) * MAX34417_PWR_CORRECTION_SCALE */
> +		correction = (100 * MILLI * MAX34417_PWR_CORRECTION_SCALE) / rsense;
> +
> +		max34417->input_correction[index] = correction;
> +	}
> +
> +	indio_dev->channels = max34417_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max34417_channels);
> +	indio_dev->name = "max34417";
> +	indio_dev->info = &max34417_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* Set as default Manual Mode & Wide ADC */
> +	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, MAX34417_DEFAULT_CMM_WIDE);
> +	if (rc) {
> +		dev_err(max34417->dev, "Error (%d) writing control register\n", rc);

dev_err_probe()? + you can u

-- 
Kind regards,
Joshua Crofts
