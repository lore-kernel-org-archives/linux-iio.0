Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E1346AF00;
	Thu, 15 Oct 2026 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091080; cv=none; b=QngkYJigDcOCjLjo8wNaNrmxOFAeBg8r6hVEZZcjQlR/llKhuOcicE9YOgbR6kqMZmN6op9OQMsOORB3QkjfsWSd5LmDXVceqbkeWjgKwfcEWvQQi10svq5NJw8LpOUIleThKFrlpvQeHVEOBV7gcBA0Rn8rXotx/pwj1Gg687w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091080; c=relaxed/simple;
	bh=HUARTShCakCtORCfTArgzwZOA8FoMRZVrrvbXZgzlIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmV9VFvunZazW4gTCcRNK0QVqpa9OSJe5XrFtRBW2k1QrMbIggYtAJna6mYxv9KZvfegbOnNyGtAIlB5YqAUkOjL+rK69r1uszKsE1ITLbMyNuTd1efghjY8+fOusZOizuhGl02SGvGPABJFxzK5jH8gw7J64cr6zOE6z3NOQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ggecwug5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ggecwug5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091080; x=1823627080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HUARTShCakCtORCfTArgzwZOA8FoMRZVrrvbXZgzlIE=;
  b=Ggecwug5Er2s3LOHWCTPgE2qkVw8d0WrMp13Aw+YXRieBinTcnD6QROX
   YVLeVrwIuogXCCSmlSiespOYxQogmlx1E9M+/tXeP+bd65tdlxiCvY1lO
   f0+piAbRdMoT5/8b35UvdrRjB3vZGAfgM3Ded27SjwlyKmUaT7MTSIwcw
   OR3LWcmQO0NfOCo5SuyxwG95oJ6gH5RIJew4nt+fDO7m8N8N+llwFwbkm
   MS0MGkaV2RjuqD6xOdht+KHhowuAx270U8qog7NAtcp0JunSvm7/czNvb
   wByo0SMfovrVJsEpJpdZccRu6SBMSj23nwDUYNyWuBid9vWbSt6d+g62F
   Q==;
X-CSE-ConnectionGUID: q4A+WjXcT1i+vyaB+WjyxA==
X-CSE-MsgGUID: gAz6S2LDTfuPVripPV9J9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="769993"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="769993"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:04:39 -0700
X-CSE-ConnectionGUID: tfurfY/1QWGm8DMTfWUKhg==
X-CSE-MsgGUID: vdlaLMFQRYqwDE6T1iXi6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1834690"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:04:35 -0700
Date: Thu, 15 Oct 2026 22:04:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: imu: Add driver for the ADI ADIS16607
Message-ID: <atEjwJb7ATxtMT2F@ashevche-desk.local>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
 <20261015-adis16607-v3-3-f972d4efee85@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015-adis16607-v3-3-f972d4efee85@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 15, 2026 at 12:33:00PM +0300, Radu Sabau via B4 Relay wrote:

> The ADIS16607 is a Precision MEMS IMU from Analog Devices with
> triaxial gyroscope and accelerometer, delta angle/velocity, and
> temperature channels, communicating over a custom SPI Half-Duplex
> protocol. ADIS16607-2 has a ±450°/s gyroscope range, ADIS16607-3
> ±2000°/s; both share a ±40g accelerometer range and an 8 kHz internal
> clock.
> 
> This is the base driver: probe, raw channel reads, sampling-frequency
> control, startup/self-test via adislib, and debugfs identity entries.
> No buffered capture, external clock sync, or calibration bias yet -
> those follow in later patches.

...

> +#include <linux/kernel.h>

No way. This header shouldn't appear in a simple driver like this.

> +#include <linux/units.h>
> +#include <linux/module.h>

Keep the list ordered.

> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>

...

> +struct adis16607 {
> +	const struct adis16607_chip_info *info;
> +	struct adis adis;

If you ever use container_of() on this, the moving it to be the first member
saves some .text code.

> +	unsigned long clk_freq;	/* millihertz */
> +	u64 sample_period_ns;
> +	/* IIO buffer for reordered data - sized for max channels */
> +	u8 data[64] __aligned(IIO_DMA_MINALIGN);
> +};

Note, whenever you optimize layout with `pahole` always check with
`bloat-o-meter` to see if the code generation is affected and how.

...

> +	case 2:
> +		adis->tx[0] = reg | BIT(7);
> +		adis->tx[1] = 0;
> +		adis->tx[2] = 0;
> +		adis->tx[3] = 0;
> +
> +		spi_message_init(&msg);
> +		spi_message_add_tail(&xfers[0], &msg);
> +		spi_message_add_tail(&xfers[1], &msg);

There is a function to add multiple transfers to the message.

> +		ret = spi_sync(adis->spi, &msg);
> +		if (ret)
> +			return ret;
> +
> +		*val = get_unaligned_be16(&adis->rx[2]);
> +		break;
> +
> +	case 4:
> +		/* Read MSW from reg */
> +		adis->tx[0] = reg | BIT(7);
> +		adis->tx[1] = 0;
> +		adis->tx[2] = 0;
> +		adis->tx[3] = 0;
> +
> +		spi_message_init(&msg);
> +		spi_message_add_tail(&xfers[0], &msg);
> +		spi_message_add_tail(&xfers[1], &msg);

Ditto.

> +		ret = spi_sync(adis->spi, &msg);
> +		if (ret)
> +			return ret;
> +
> +		val_msw = get_unaligned_be16(&adis->rx[2]);
> +
> +		/* Read LSW from reg+1 */
> +		adis->tx[0] = (reg + 1) | BIT(7);
> +
> +		spi_message_init(&msg);
> +		spi_message_add_tail(&xfers[0], &msg);
> +		spi_message_add_tail(&xfers[1], &msg);
> +
> +		ret = spi_sync(adis->spi, &msg);
> +		if (ret)
> +			return ret;
> +
> +		val_lsw = adis->rx[2];
> +
> +		/* Combine: 24-bit value with MSW in upper 16 bits, LSW in lower 8 bits */
> +		*val = ((val_msw << 8) & 0xFFFF00) | val_lsw;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

Replace breaks with return 0 and drop this one.

...

> +static int adis16607_spi_write(struct adis *adis, unsigned int reg,
> +			       unsigned int val, unsigned int size)
> +{
> +	if (size != 2)
> +		return -EINVAL;
> +
> +	adis->tx[0] = reg;
> +	adis->tx[1] = (val >> 8) & 0xFF;
> +	adis->tx[2] = val & 0xFF;

put_unaligned_be16()

> +	return spi_write(adis->spi, adis->tx, 3);
> +}

...

> +	/* Read first set of self-test data */
> +	for (i = 0; i < 6; i++) {

ARRAY_SIZE()

> +		ret = __adis_read_reg_16(adis, ADIS16607_REG_SELF_TEST_DATA(i),
> +					 &st1_val[i]);
> +		if (ret)
> +			return ret;
> +	}

...

> +	/* Read second set of self-test data */
> +	for (i = 0; i < 6; i++) {

Ditto.

> +		ret = __adis_read_reg_16(adis, ADIS16607_REG_SELF_TEST_DATA(i),
> +					 &st2_val[i]);
> +		if (ret)
> +			return ret;
> +
> +		if (!adis16607_delta_check((s16)st1_val[i], (s16)st2_val[i],
> +					   delta_max[i])) {
> +			dev_err(&adis->spi->dev,
> +				"Self-test failed for axis %d: delta out of range\n", i);
> +			return -EINVAL;
> +		}
> +	}

> +	/* Clear self-test register */
> +	ret = __adis_write_reg_16(adis, ADIS16607_REG_SELF_TEST, 0);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return ..._write_reg_16(...);

...

> +	/* Additional 100ms required at initial startup per datasheet */

Add a reference where in DS it's required.

> +	msleep(100);

...

> +	/* Route a reset-status indicator to its own pin, if reset-gpios is wired */
> +	if (device_property_present(dev, "reset-gpios")) {

Huh?! Can we use reset framework instead and do something with help of it?

> +		ret = __adis_update_bits_base(adis, ADIS16607_REG_USER_GPIO_CFG,
> +					      ADIS16607_RESET_GPIO_MASK,
> +					      FIELD_PREP(ADIS16607_RESET_GPIO_MASK, 1), 2);
> +		if (ret)
> +			return ret;
> +	}

...

> +#ifdef CONFIG_DEBUG_FS
> +static int adis16607_show_firmware_id(void *arg, u64 *val)
> +{
> +	struct adis16607 *st = arg;
> +	u16 rev;
> +	int ret;
> +
> +	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_REV_ID, &rev);
> +	if (ret)
> +		return ret;
> +
> +	*val = (rev >> 8) & 0xff;
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(adis16607_firmware_id_fops,
> +			 adis16607_show_firmware_id, NULL, "%llu\n");
> +
> +static int adis16607_show_revision_id(void *arg, u64 *val)
> +{
> +	struct adis16607 *st = arg;
> +	u16 rev;
> +	int ret;
> +
> +	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_REV_ID, &rev);
> +	if (ret)
> +		return ret;
> +
> +	*val = rev & 0xff;
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(adis16607_revision_id_fops,
> +			 adis16607_show_revision_id, NULL, "%llu\n");

"%u.%u" (major.minor)

...

> +#else
> +static void adis16607_debugfs_init(struct iio_dev *indio_dev)
> +{
> +}
> +#endif

Why? The DebugFS is aware of this, no ugly ifdeffery needed.

...

> +static int adis16607_get_freq(struct adis16607 *st, u32 *freq)
> +{
> +	u16 dec = 0;
> +	int ret;
> +
> +	mutex_lock(&st->adis.state_lock);

What's wrong with guard()()?

> +	ret = __adis_read_reg_16(&st->adis, ADIS16607_REG_DEC_RATE, &dec);
> +	if (ret)
> +		goto unlock;
> +
> +	*freq = DIV_ROUND_CLOSEST(st->clk_freq, dec + 1);
> +
> +unlock:
> +	mutex_unlock(&st->adis.state_lock);
> +	return ret;
> +}

...

> +static int adis16607_config_clk(struct adis16607 *st)
> +{
> +	st->clk_freq = (unsigned long)st->info->int_clk * 1000;

Why casting? What is the meaning of 1000? Why members are without _Hz or alike
units?

> +	st->sample_period_ns = DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * 1000ULL,
> +						     st->clk_freq);

Better to indent like

	st->sample_period_ns =
		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * 1000ULL, st->clk_freq);

> +	return 0;
> +}

...

> +static int adis16607_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct adis16607 *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -EINVAL;

-ENODATA

> +	indio_dev->name = st->info->name;
> +	indio_dev->channels = st->info->channels;
> +	indio_dev->num_channels = st->info->num_channels;
> +	indio_dev->info = &adis16607_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	st->adis.ops = &adis16607_ops;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get vdd regulator\n");
> +
> +	ret = adis_init(&st->adis, indio_dev, spi, &adis16607_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = __adis_initial_startup(&st->adis);
> +	if (ret)
> +		return ret;
> +
> +	ret = adis16607_config_clk(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	adis16607_debugfs_init(indio_dev);
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


