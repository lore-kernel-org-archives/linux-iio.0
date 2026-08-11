Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63723C1974;
	Tue, 11 Aug 2026 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441199; cv=none; b=YjjdMJ/JAnpTswoZrOOvp+ydBffKq0rHoKwjGVVTHcEkuOabYsPdrVBKSDqKUvWoUx9pZyhRPZho586/D24NealPRf9bpUm1ny/64XvZ5uMIgII9uZN6zL8ESL3Q5NyfHJY96oaNj7LlKyzYZkQMovXcjBzBaSQuN9l7zg3h540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441199; c=relaxed/simple;
	bh=ZO3MFQM2c/n47zfk0CWPrsRPlrhgxkA6KJdl8XN1l/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uivDDGKF47zkbX1Re8/vO8C+gT9BcV4WevBdZYjhXxW46Cdnht0bWQBLnBBPNQpekDauirTrTnOkTfEk0BjrmviO9PDLF36TladJRsgYo/lm0Dv7+PzerwzqllnszWhOHvQ392PI1z8+jPHC5EVp/YoMjaTxcdbeCzKxuqjU7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YN6kbzj4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YN6kbzj4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786441197; x=1817977197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZO3MFQM2c/n47zfk0CWPrsRPlrhgxkA6KJdl8XN1l/4=;
  b=YN6kbzj4HGme5WI0kAtxqaBe6MPzfazulqw+4Z9+HPrBUwSHaYb1k3G5
   La2Q+vnUKzLB13LKxCITHRfUbhQF+YofbOr7HkGl99bjdoffEJ7g5DGdE
   CZphhNWAIMqeBqnR+AN4tg9aNRcxE5o+EVneCp7ZyYITyRiq8QgACq05w
   aMZSZ7xYegc7aeTnWHxJZzjX1oVvQw3RxUqw4I8dCLqJil61LHpeqmig9
   bRfQ1OW1LCZ0OXyFFX78RMXd5jza79MrPnhR+hQsXFUn1DOnJtKzU+xNN
   OnWE3KCe6mt5dk+ttBNVENMcj3yR2Jt5j4+wxg25b8VrQ5thvSAyzlqjr
   A==;
X-CSE-ConnectionGUID: dszAx1NaSECTdsV23TkB0g==
X-CSE-MsgGUID: pGPWPOiHSeGM6lT3W5MyQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86845215"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86845215"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 02:39:56 -0700
X-CSE-ConnectionGUID: ZbCkjo2PQ0yVRJlQ1rzCzw==
X-CSE-MsgGUID: LNCJssDSSgO/aYyHtljIvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="260687536"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 02:39:53 -0700
Date: Tue, 11 Aug 2026 12:39:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Message-ID: <anrt5mJBz5h-a3OL@ashevche-desk.local>
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
 <20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 10:48:38AM +0800, Kyle Hsieh wrote:
> Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> delta-sigma ADCs.
> 
> The driver implements:
> - Single-shot conversions using the IIO raw read interface.
> - Dynamic parsing of single-ended and differential channels from
>   device tree child nodes.
> - Hardware interrupt support via the DRDY pin, falling back to
>   software polling if no IRQ is provided.
> - Scale calculation based on the internal 2.048V reference.
> - Reference voltage scaling via the regulator subsystem (refp-supply),
>   falling back to the internal 2.048V reference if not specified.
>   refn-supply is not yet supported.
> - Hardware reset fallback using GPIO.

...

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/units.h>

...

> +static int ads112c04_wait_for_data(struct ads112c04_state *st)
> +{
> +	int ret, err;
> +	u8 val;
> +
> +	if (st->client->irq > 0) {
> +		/* Timeout is 100ms (slowest data rate is 20 SPS) */
> +		ret = wait_for_completion_timeout(&st->completion,
> +						  msecs_to_jiffies(100));
> +		if (!ret)

In this case semantics of ret differs, that's why it's better to write as

		if (!wait_for_completion_timeout(&st->completion, msecs_to_jiffies(100)))

// and I would even dare to put on a single line.

> +			return -ETIMEDOUT;
> +
> +		return 0;
> +	}
> +
> +	err = read_poll_timeout(ads112c04_read_reg, ret,
> +				(ret < 0 || (val & ADS112C04_CONFIG2_DRDY)),
> +				1000, 100 * USEC_PER_MSEC, false,
> +				st->client, ADS112C04_REG_CONFIG2, &val);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return err;

In this piece I would swap err and ret, so the ret is outer one and err is
the inner one. This will be consistent with other code pieces.

> +}

...

> +static int ads112c04_get_adc_result(struct ads112c04_state *st,
> +				    struct iio_chan_spec const *chan,
> +				    int *val)
> +{
> +	u8 new_config0;
> +	int ret;
> +
> +	new_config0 = st->config0;
> +	FIELD_MODIFY(ADS112C04_CONFIG0_MUX, &new_config0, chan->address);
> +
> +	if (st->config0 != new_config0) {
> +		ret = ads112c04_write_reg(st->client, ADS112C04_REG_CONFIG0, new_config0);
> +		if (ret < 0)
> +			return ret;
> +		st->config0 = new_config0;
> +	}
> +
> +	reinit_completion(&st->completion);
> +
> +	ret = ads112c04_write_cmd(st->client, ADS112C04_CMD_START_SYNC);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ads112c04_wait_for_data(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ads112c04_read_data(st, val);

> +	if (st->client->irq > 0)
> +		enable_irq(st->client->irq);

Why is it fine to leave IRQ enabled even in the error case?

> +	return ret;
> +}

...

> +static int ads112c04_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	struct ads112c04_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = ads112c04_get_adc_result(st, chan, val);
> +		mutex_unlock(&st->lock);
> +
> +		if (ret < 0)
> +			return ret;

If IRQ is left enabled and we call it here, we end up with the unbalanced
depth counting.

> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_mV;
> +		*val2 = 15;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static irqreturn_t ads112c04_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ads112c04_state *st = iio_priv(indio_dev);

> +	disable_irq_nosync(irq);

This is unconditionally called. Where is the guarantee that it becomes enabled
once again?

> +	complete(&st->completion);

> +	return IRQ_HANDLED;
> +}

...

> +static int ads112c04_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct device *dev = indio_dev->dev.parent;
> +	struct ads112c04_state *st = iio_priv(indio_dev);
> +	struct iio_chan_spec *channels;
> +	u32 num_channels, pair[2];

> +	int ret, i = 0;

Why is 'i' signed? And it's better to decouple definition and assignment, so
the assignment will happen closer to when it's really needed.

...

> +		if (fwnode_property_present(child, "reference-sources")) {
> +			const char *ref;
> +
> +			ret = fwnode_property_read_string(child, "reference-sources", &ref);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read reference-sources\n");
> +
> +			if ((!strcmp(ref, "external") && !st->has_refp) ||
> +			    (!strcmp(ref, "internal") && st->has_refp))
> +				return dev_err_probe(dev, -EINVAL,
> +						     "reference-sources does not match refp-supply\n");
> +		}

Reinvention of fwnode_property_match_property_string() ?

...

> +		if (fwnode_property_present(child, "single-channel")) {
> +			ret = fwnode_property_read_u32(child, "single-channel", &pair[0]);

I don't like the (partial) pair reuse here. It's semantically wrong. Just add
another temporary variable and let compiler to choose what to do with a stack
frame in such a case.

> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read single-channel property\n");
> +
> +			if (pair[0] > 3)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "single-channel must be 0-3\n");
> +
> +			spec->channel = pair[0];
> +			spec->address = 0x08 + pair[0];
> +		} else if (fwnode_property_present(child, "diff-channels")) {
> +			ret = fwnode_property_read_u32_array(child, "diff-channels", pair, 2);

ARRAY_SIZE()

> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read diff-channels property\n");
> +
> +			if (pair[0] > 3 || pair[1] > 3)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "diff-channels must be 0-3\n");
> +
> +			spec->channel = pair[0];
> +			spec->channel2 = pair[1];
> +			spec->differential = 1;

> +			if (pair[0] == 0 && pair[1] == 1)
> +				spec->address = 0x00;
> +			else if (pair[0] == 0 && pair[1] == 2)
> +				spec->address = 0x01;
> +			else if (pair[0] == 0 && pair[1] == 3)
> +				spec->address = 0x02;
> +			else if (pair[0] == 1 && pair[1] == 0)
> +				spec->address = 0x03;
> +			else if (pair[0] == 1 && pair[1] == 2)
> +				spec->address = 0x04;
> +			else if (pair[0] == 1 && pair[1] == 3)
> +				spec->address = 0x05;
> +			else if (pair[0] == 2 && pair[1] == 3)
> +				spec->address = 0x06;
> +			else if (pair[0] == 3 && pair[1] == 2)
> +				spec->address = 0x07;

I would do this as a 4x4 table

	-1, 0, 1, 2,
	3, -1, 4, 5,
	-1, -1, -1, 6,
	-1, -1, 7, -1,

With that done you can even supported the swapped cases

	-1, 0, 1, 2,
	3, -1, 4, 5,
	1, 4, -1, 6,
	2, 5, 7, -1,

(but I haven't studied the code if it's toughly relies on the pair[0]/pair[1]
 values to be in a strong order after the address being assigned).

> +			else
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid diff-channels combination\n");

> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "channel node must have single-channel or diff-channels\n");
> +		}
> +
> +		i++;
> +	}
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = i;
> +
> +	return 0;
> +}

...

> +#define ADS112C04_VREF_INTERNAL_MV	2048

_mV

...

> +	if (device_property_present(dev, "refp-supply")) {

A dup property check. if (st->has_refp) should suffice, no?

> +		ret = devm_regulator_get_enable_read_voltage(dev, "refp");
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "failed to get refp voltage\n");
> +
> +		st->vref_mV = ret / (MICRO / MILLI);
> +		st->config1 = 0x02;
> +	} else {
> +		st->vref_mV = ADS112C04_VREF_INTERNAL_MV;
> +		st->config1 = 0x00;
> +	}

...

> +	/* Requesting OUT_HIGH asserts the active-low reset pin immediately */
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return PTR_ERR(reset_gpio);

Why reset-gpio driver can't be used instead?

> +	if (reset_gpio) {
> +		fsleep(1000);

1 * USEC_PER_MSEC

> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +	} else {
> +		ret = ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	fsleep(1000);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


