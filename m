Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F502931F5;
	Sat, 25 Jul 2026 23:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785023914; cv=none; b=LdROiMIeKkSMloVS6fao+KHhieR7xXDouxGyzdrxihOrQ9jGpP3Bx916ycJL/niUZhJS0BKagQv4K4D6vU05hMlrj89OeIII79iWRMma1mVF8iStWR7jYe2qlFioDerggZkiuoiBZpVoNG9wRy9XyOnoyrpxM+qD+I6HKUqHFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785023914; c=relaxed/simple;
	bh=V4Sy9SUH4V/DVoc4yHGyYukFWXOtq2gZCA2CWpSrVFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sY/Gma0WHyXt3xuyhS42sp5LtFwscRBy0rtNplmXWzeqWP6Ap+Al7zlfnX3se2xUmq8kftmXeNquHJ1DD9L0BokFwyxN4Ml0mSd41HMYQOBt6gcMABtmBQqgl2knuQdF5X/eXWi4yxw7n2Ux+uSAxszvh3EyqUWXAaYXBrZt+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsIhtjBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsIhtjBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C261F000E9;
	Sat, 25 Jul 2026 23:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785023912;
	bh=eojsk60CIcocl2x7KJ/oS9iux+Ybj19ZGjlkT1bruPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YsIhtjBqoNJgJ7rnMUNBufobLiozz0XePfm8V8dgtwPg6SMkgPIYEngSJFh78niFz
	 5UkVJa3ShGTJnrYNWp2PtaPyzjqPVmLGn0XmR7tBSy2nIcyGTz/yNYbq3uQ0AORr3V
	 zeiOoXri9T1ystwrWFuhavpw7LD7XYGPQg5lSaT+4infl1Bp9rrQ37w0NV1BTFV//l
	 HXnYnU0+bMVqi0asDsCP74W+wzL5hNr2nd7TWSDZQwAClb3p6/12kh5PkGNamKxLN7
	 KdFw8pkO60DU+RhGxR6nLNO+SrvFfNp30DlKBu180GLudkGg6txr5eftO5+KwgzofO
	 XWNPcFIk3dMeQ==
Date: Sun, 26 Jul 2026 00:58:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <andy@kernel.org>, <nuno.sa@analog.com>, <linux@roeck-us.net>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <dlechner@baylibre.com>, <ciprian.hegbeli@analog.com>,
 <siratul.islam@linux.dev>, <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v5 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <20260726005827.31aec2b0@jic23-huawei>
In-Reply-To: <20260723065036.2683075-3-stefan.popa@analog.com>
References: <20260723065036.2683075-1-stefan.popa@analog.com>
	<20260723065036.2683075-3-stefan.popa@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 09:50:36 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
> 
> Add a direct-mode IIO driver exposing the current and voltage channels
> with raw, scale and hardware-gain attributes, a configurable
> oversampling (digital averaging) ratio, and PEC-protected register
> access. The current scale is derived from the shunt resistor value
> described in the device tree.
> 
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Hi Stefan

I've tried to avoid duplicating the stuff Siratul already called out.
Various things inline.

Jonathan

> diff --git a/drivers/iio/adc/max40080.c b/drivers/iio/adc/max40080.c
> new file mode 100644
> index 0000000000000..cdf626dccb24f
> --- /dev/null
> +++ b/drivers/iio/adc/max40080.c
> @@ -0,0 +1,586 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MAX40080 Digital Current-Sense Amplifier driver
> + *
> + * Copyright 2026 Analog Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define MAX40080_REG_CFG		0x00
> +#define  MAX40080_MODE_MSK		GENMASK(2, 0)
I'd prefer these to include CFG so it is obvious which register
they are in. Same for other registers.
> +#define  MAX40080_PEC_EN_MSK		BIT(5)
> +#define  MAX40080_RANGE_MSK		BIT(6)

For the two values that go in here, add some defines.  They will
come in handy below.
#define     MAX40080_CFG_RANGE_50MV		0
#define     MAX40080_CFG_RANGE_10MV		1

> +#define  MAX40080_FILTER_MSK		GENMASK(14, 12)
> +
> +#define MAX40080_REG_FIFO_CFG		0x0A
> +#define  MAX40080_STORE_IV_MSK		GENMASK(1, 0)
> +
> +#define MAX40080_REG_IV			0x10
> +/* Current is a 13-bit two's-complement value (magnitude + sign bit). */
> +#define  MAX40080_IV_I_MSK		GENMASK(12, 0)
> +#define  MAX40080_IV_I_SIGN_BIT		12
> +#define  MAX40080_IV_V_MAG_MSK		GENMASK(27, 16)
> +#define  MAX40080_IV_VALID_MSK		BIT(31)
> +
> +/* CFG.mode field */
> +#define MAX40080_STDBY_MODE		0x00
> +#define MAX40080_SINGLE_MODE		0x02	/* one conversion per Quick Command */
> +
> +/* FIFO_CFG.store_iv field */
> +#define MAX40080_STORE_I_V		0x02
> +
> +#define MAX40080_ADC_RES		4096

I'd express resolution in bits.  Then use (1 << RES) or similar where this comes up.

> +#define MAX40080_INTER_VREF_MV		1250
This one is used in a few places, so fine to have a define
> +#define MAX40080_V_BUFF_GAIN		30
As is this.


> +#define MAX40080_CSA_50MV_GAIN		25
> +#define MAX40080_CSA_10MV_GAIN		125

These last two at least bring less value than the numbers have if used
to assign to something where the naming describes what it is.

> +
> +/*
> + * The RANGE field (CFG bit 6) selects one of two current-sense full-scale
Do as below and this bit is obvious
> + * ranges (the MAX40080 supports exactly two: +/-50 mV and +/-10 mV). Ordered
> + * so that the array index equals the RANGE field value: index 0 = 50 mV range
> + * (gain 25 V/V), index 1 = 10 mV range (gain 125 V/V).

Make all that explicit as below and this is obvious as well. Hence
the comment is replaced by clear code.

> + */
> +static const int max40080_csa_gain[] = {
> +	MAX40080_CSA_50MV_GAIN, MAX40080_CSA_10MV_GAIN,
	[MAX40080_CFG_RANGE_50MV] = 25,
	[MAX40080_CFG_RANGE_10MV] = 125,

> +};

...

> +static int max40080_update_bits(struct max40080_state *st, u8 reg,
> +				u16 mask, u16 val)
> +{
> +	int ret;
> +	int tmp;
> +
> +	guard(mutex)(&st->lock);
> +
> +	tmp = i2c_smbus_read_word_data(st->client, reg);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	tmp &= ~mask;
> +	tmp |= val & mask;
> +
> +	ret = i2c_smbus_write_word_data(st->client, reg, tmp);

return i2c_smbus..

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}

...

> +
> +static int max40080_get_voltage(struct max40080_state *st, int *val)
> +{
> +	u32 iv = 0;

I'd kind of hope that the compiler could figure out that we don't
use iv unless it is set.  If not fine to keep these assignments.

> +	int ret;
> +
> +	ret = max40080_read_iv(st, &iv);
> +	if (ret)
> +		return ret;
> +
> +	*val = FIELD_GET(MAX40080_IV_V_MAG_MSK, iv);
> +
> +	return 0;
> +}
> +
> +static int max40080_set_oversampling_ratio(struct max40080_state *st, int val)
> +{
> +	int ret, filter = max40080_oversampling_to_filter(val);
> +
> +	if (filter < 0)
> +		return filter;
> +
> +	ret = max40080_update_bits(st, MAX40080_REG_CFG, MAX40080_FILTER_MSK,
> +				   FIELD_PREP(MAX40080_FILTER_MSK, filter));
> +	if (ret)
> +		return ret;
> +
> +	st->oversampling_ratio = val;

Sashiko calls out that you have a lock but don't hold it over the combined
write plus cached value update. Check if sysfs file locking is enough for
that to not be a problem. 
https://sashiko.dev/#/patchset/20260723065036.2683075-1-stefan.popa%40analog.com

> +
> +	return 0;
> +}
> +
> +static int max40080_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val,
> +			     int *val2,
> +			     long mask)
> +{
> +	struct max40080_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_CURRENT) {
> +			ret = max40080_get_current(st, val);
> +			if (ret)
> +				return ret;
> +		} else if (chan->type == IIO_VOLTAGE) {
> +			ret = max40080_get_voltage(st, val);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_CURRENT) {
> +			/*
> +			 * The selectable current-sense range is exposed through
> +			 * scale: each RANGE setting has its own precomputed
> +			 * mA-per-code value. Userspace picks the range by writing
> +			 * the matching scale.
> +			 */
> +			*val = st->current_scale[st->range][0];
> +			*val2 = st->current_scale[st->range][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
> +		/* voltage[mV] = raw * Vref[mV] * buffer_gain / ADC_RES */
> +		*val = MAX40080_INTER_VREF_MV * MAX40080_V_BUFF_GAIN;
> +		*val2 = MAX40080_ADC_RES;
> +		return IIO_VAL_FRACTIONAL;

FRACTIONAL_LOG2 exists for this sort of case but does require use of
of a resolution expressed as number of bits.

> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = max40080_get_oversampling_ratio(st, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +/*
> + * Configure the device from the cached state. The device powers up in standby
> + * with PEC enabled (CFG POR = 0x0060), so PEC is kept enabled throughout.
> + */
> +static int max40080_init(struct max40080_state *st)
> +{

...
> +	/*
> +	 * Use single-measurement mode: the device stays idle and converts once
> +	 * per SMBus Quick Command (see max40080_trigger_measurement()), so each
> +	 * read returns a fresh sample rather than a queued FIFO entry.
> +	 */
> +	cfg = FIELD_PREP(MAX40080_MODE_MSK, MAX40080_SINGLE_MODE) |
> +	      FIELD_PREP(MAX40080_PEC_EN_MSK, 1) |
> +	      FIELD_PREP(MAX40080_RANGE_MSK, st->range) |
> +	      FIELD_PREP(MAX40080_FILTER_MSK, filter);
> +
> +	ret = i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
return i2c_smbus_write_word_data()
Note you are a bit inconsistent on return values checks for i2dc_smbus_write_word_data()
Assume 0 or < 0 only are possible (as documented). 

> +}
> +
> +static int max40080_probe(struct i2c_client *client)
> +{
> +	const char *propname = "shunt-resistor-micro-ohms";
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max40080_state *st;
> +	int ret;
> +
> +	/*
> +	 * The device powers up with PEC enabled (CFG POR = 0x0060) and rejects
> +	 * unprotected transactions, so PEC support is mandatory, along with word
> +	 * access, the I2C block read used for the current/voltage pair, and the
> +	 * Quick Command used to trigger a conversion.
> +	 */
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_QUICK |
> +				     I2C_FUNC_SMBUS_PEC))
> +		return -EOPNOTSUPP;
> +
> +	client->flags |= I2C_CLIENT_PEC;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);

Not seeing this used.

> +
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_property_read_u32(dev, propname, &st->shunt_resistor_uohm);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "can't read %s\n", propname);
> +	if (!st->shunt_resistor_uohm)
> +		return dev_err_probe(dev, -EINVAL, "%s must be non-zero\n",
> +				     propname);
> +
> +	max40080_calc_current_scale(st);
> +
> +	/* Defaults: 50 mV range (index 0), no averaging. */
> +	st->range = 0;

Use the define I suggest above. Then it becomes self documenting and the
comment isn't needed.  

> +	st->oversampling_ratio = 1;


