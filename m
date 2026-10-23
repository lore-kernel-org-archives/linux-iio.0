Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792751203;
	b=pqwNlxDyWjJRDUbdm9rI1XYzs7SWM+9sGP1sfEJDa3a7HTvB11jRvJ4BfbMrSLs3r2d7
	 vjL+pfS/JyrkbBk/rCcRp9OBIvKzIxBCWQSp+kmR7MA8lN0aoQStG1GKrFFCJBQ0hOKLX
	 5TfAhelMIBIjWyvtjncVOe/imhwmMlLxQAODnyoSU+aGkRSkCLWuf92y7WbgwokoVqa50
	 O9IwfWh/T99vgTcaowzEAtFTdKxf/yIEW1MOkVZFDqj81b3lnAsjuQ6gCS51W1cBdhv9n
	 8sTzllEXMmLFKpLGZCvs967GdwxIcPx3FrRIDdtr35R6CEBvFnNXaR0GyIhGL2Keciw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792751203;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=OyVZC7TyCFl9hj7gzv9g50lgBQyyWfj16zOWrajtCig=;
	b=VqZ7QAiO1bEGcAQgpIbEGO1W9oJaGRRAOW0JPFezUP1eq5n5e8+t2+MzA6jxNlSiC3Qo
	 8Q+k89bspcVz5GwoPWdfxWqKavB8aIW/M742nRgqc8RReSxzuFSY5kRopHMosayFgVbFg
	 bbH+T+8NdOE7C0yjfSVoDrqMDtuY+ilALjc67Rn/uwyKnGfn3wi2liuAYGyK1PGM+Zf0n
	 yaYQhuzXDM5hGn1Vv+j0z/JmUGadUakLEI2Yq+fnsms1J+VDE7EGyiek0vTwgIgAtWVMi
	 7T8nAEJrX4mVQiaz4KOuyo21cNW1xLko1Wr0HzOq/3U6yy+C3xQgVW82SP1qYn+PYAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XZ+DqvEY;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22A606A31B;
	Fri, 23 Oct 2026 10:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A22A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XZ+DqvEY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792751202; x=1824287202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aPaduRkr9nXpF3GWNMIXAyDhEP1X7FI5F9u8q0iwg7E=;
  b=XZ+DqvEY8AnA1MnV6Cgyutp9ST0kibU3Z1PajjMRKYY5kBEn4SrlHJCX
   iQEDzM67CV4R+/f0kgWc8ziSO9lhqSAAL38KDQ704WDGiQZZ/KOpru0FU
   OyksnU0H/aZnym4WAiSg//aiAoTsPvhN6kj6/lJjLQMZXexzytlszrLPV
   X5g6g6rI7sSdHz5DZasVtn+e4efWAnnTXp9tH35zDmX1803HyOTA7tOuA
   84qqr3/Sm1afeW/IUNmd8PM9tm8AEvvi7GiD6SZyoUoUYEiy8SutakMPb
   lj7gHFc2LR+BTKMUSe9ZzYfkPDBdZe7AqtsmpJlHb5U6jrbsG8TOqV2Dq
   Q==;
X-CSE-ConnectionGUID: gS2/rJJ8TmKfQZtC8FajGQ==
X-CSE-MsgGUID: tDqaVAOQTCii1Q22k+DkCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1412801"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1412801"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 03:26:41 -0700
X-CSE-ConnectionGUID: hca8ocJlTaSy8BALbuAkrg==
X-CSE-MsgGUID: wufAoAgNSDKUR+clE8W0og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3974342"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 03:26:38 -0700
Date: Fri, 23 Oct 2026 13:26:36 +0300
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH v4 5/8] iio: imu: Add driver for the ADI ADIS16607
Message-ID: <ats2XBBnfGmusCI2@ashevche-desk.local>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
 <20261023-adis16607-v4-5-a4d541ebfd13@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261023-adis16607-v4-5-a4d541ebfd13@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 12:30:22PM +0300, Radu Sabau via B4 Relay wrote:

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
> 
> Self-test leaves the device's SELF_TEST register cleared on every exit
> path, not just on success, so a read failure or a failed delta check
> doesn't leave the sensor stuck in its self-test/force state until the
> next reset.

...

> +++ b/drivers/iio/imu/Kconfig

> +	tristate "Analog Devices ADIS16607 and similar IMU driver"

(see below)


...

> +struct adis16607_chip_info {
> +	const struct iio_chan_spec *channels;
> +	const char *name;
> +	u32 num_channels;
> +	u32 gyro_max_val;
> +	u32 gyro_max_scale;
> +	u32 accel_max_val;
> +	u32 accel_max_scale;
> +	u32 temp_scale;
> +	u32 deltang_max_val;
> +	u32 deltvel_max_val;
> +	u32 int_clk_hz;

_Hz

> +	u16 max_dec;
> +};

...

> +struct adis16607 {
> +	struct adis adis;
> +	const struct adis16607_chip_info *info;
> +	unsigned long clk_freq_mhz;

_MHz or _mHz? (I believe it's the first one.)
This is why case-sensitive units (as per physics) are important.

> +	u64 sample_period_ns;
> +};

...

> +		/* Combine: 24-bit value with MSW in upper 16 bits, LSW in lower 8 bits */

Make it multi-line and to fix 80 characters.

> +		*val = ((val_msw << 8) & 0xFFFF00) | val_lsw;

Why not GENMASK()? Can val_msw be u16 or other 16-bit type?

...

> +static int adis16607_sensor_self_test(struct adis16607 *st)
> +{
> +	struct adis *adis = &st->adis;
> +	u16 st1_val[6], st2_val[6];
> +	s16 delta_max[6] = {
> +		ADIS16607_ACCEL_XY_DELTA_MAX,
> +		ADIS16607_ACCEL_XY_DELTA_MAX,
> +		ADIS16607_ACCEL_Z_DELTA_MAX,
> +		ADIS16607_GYRO_DELTA_MAX,
> +		ADIS16607_GYRO_DELTA_MAX,
> +		ADIS16607_GYRO_DELTA_MAX,
> +	};
> +	int ret, i;

Why is 'i' signed?

> +	/* Enable sensor self-test */
> +	ret = __adis_write_reg_16(adis, ADIS16607_REG_SELF_TEST,
> +				  ADIS16607_SNSR_SELF_TEST_MASK);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for self-test to settle before reading results */
> +	msleep(adis->data->timeouts->self_test_ms);
> +
> +	/* Read first set of self-test data */
> +	for (i = 0; i < ARRAY_SIZE(st1_val); i++) {
> +		ret = __adis_read_reg_16(adis, ADIS16607_REG_SELF_TEST_DATA(i),
> +					 &st1_val[i]);
> +		if (ret)
> +			goto clear_self_test;
> +	}
> +
> +	/* Force self-test */
> +	ret = __adis_write_reg_16(adis, ADIS16607_REG_SELF_TEST,
> +				  ADIS16607_SNSR_SELF_TEST_MASK | ADIS16607_ST_FORCE_MASK);
> +	if (ret)
> +		goto clear_self_test;
> +
> +	/* Wait for forced self-test to settle before reading results */
> +	msleep(adis->data->timeouts->self_test_ms);
> +
> +	/* Read second set of self-test data */
> +	for (i = 0; i < ARRAY_SIZE(st2_val); i++) {

In both for-loops iterator is local, so

	for (unsigned int i = 0; i < ARRAY_SIZE(st2_val); i++) {

> +		ret = __adis_read_reg_16(adis, ADIS16607_REG_SELF_TEST_DATA(i),
> +					 &st2_val[i]);
> +		if (ret)
> +			goto clear_self_test;
> +
> +		if (!adis16607_delta_check((s16)st1_val[i], (s16)st2_val[i],
> +					   delta_max[i])) {
> +			dev_err(&adis->spi->dev,
> +				"Self-test failed for axis %d: delta out of range\n", i);
> +			ret = -EINVAL;
> +			goto clear_self_test;
> +		}
> +	}
> +
> +	/* Clear self-test register */
> +	return __adis_write_reg_16(adis, ADIS16607_REG_SELF_TEST, 0);
> +
> +clear_self_test:
> +	/*
> +	 * Best-effort cleanup after a failure above - leave the device out
> +	 * of its self-test/force state rather than stuck in it until the
> +	 * next reset. Warn rather than returning this write's own result,
> +	 * so a cleanup failure doesn't mask the real error that got us here.
> +	 */
> +	if (__adis_write_reg_16(adis, ADIS16607_REG_SELF_TEST, 0))
> +		dev_warn(&adis->spi->dev, "failed to clear self-test register\n");
> +
> +	return ret;
> +}

...

> +static int adis16607_self_test(struct adis *adis)
> +{
> +	struct adis16607 *st = container_of(adis, struct adis16607, adis);
> +	struct device *dev = &adis->spi->dev;
> +	u16 diag_stat;
> +	int ret;
> +
> +	/* Inertial Settling Time (Table 1), needed before self-test reads sensor data */

Make it fit 80.

> +	msleep(40);
> +
> +	ret = adis16607_sensor_self_test(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Read diag_stat again to clear any faults latched during self-test */
> +	ret = __adis_read_reg_16(adis, ADIS16607_REG_DIAG_STAT, &diag_stat);
> +	if (ret)
> +		return ret;
> +
> +	ret = __adis_check_status(adis);
> +	if (ret)
> +		dev_err(dev, "status check after self-test failed: %d\n", ret);
> +
> +	return ret;
> +}

...

> +static int adis16607_firmware_revision_show(struct seq_file *s, void *arg)
> +{
> +	struct adis16607 *st = s->private;
> +	u16 rev;

Can this be

	struct revision {
		u8 minor;
		u8 major;
	} rev;

?

> +	int ret;
> +
> +	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_REV_ID, &rev);
> +	if (ret)
> +		return ret;
> +
> +	seq_printf(s, "%u.%u\n", (rev >> 8) & 0xff, rev & 0xff);
> +	return 0;
> +}

...

> +static int adis16607_show_serial_number(void *arg, u64 *val)
> +{
> +	struct adis16607 *st = arg;
> +	u64 serial;
> +	u16 tmp;
> +	int ret;
> +
> +	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_SERIAL_NUM0, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	serial = (u64)tmp;

How is explicit casting helpful here?

> +	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_SERIAL_NUM1, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	serial |= ((u64)tmp << 16);
> +
> +	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_SERIAL_NUM2, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	serial |= ((u64)tmp << 32);

What about reversing the order and shift serial instead?

	u64 serial = 0;

	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_SERIAL_NUM2, &tmp);
	if (ret)
		return ret;

	serial |= tmp;

	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_SERIAL_NUM1, &tmp);
	if (ret)
		return ret;

	serial <<= 16;
	serial |= tmp;

	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_SERIAL_NUM0, &tmp);
	if (ret)
		return ret;

	serial <<= 16;
	serial |= tmp;

> +	*val = serial;
> +	return 0;
> +}

...

> +static int adis16607_set_freq(struct adis16607 *st, u32 freq)
> +{
> +	u32 dec;
> +	int ret;
> +
> +	if (!freq)
> +		return -EINVAL;
> +
> +	adis_dev_auto_lock(&st->adis);
> +
> +	dec = DIV_ROUND_CLOSEST(st->clk_freq_mhz, freq);
> +	if (dec)
> +		dec--;
> +
> +	dec = min_t(u32, dec, st->info->max_dec);

No min_t(). Make the types to be compatible for min().

> +	ret = __adis_write_reg_16(&st->adis, ADIS16607_REG_DEC_RATE, dec);
> +	if (ret)
> +		return ret;
> +
> +	st->sample_period_ns = DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * 1000ULL * (dec + 1),
> +						     st->clk_freq_mhz);

Make it fit. Using temporary variable usually helps. Also you don't need (u64)
casting or ULL suffix. On top of that, what is another 1000 multiplier for?

I would expect a comment on top with explaining magic(s).

> +	return 0;
> +}

...

> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = adis16607_get_freq(st, &tmp);
> +		if (ret)
> +			return ret;
> +		*val = tmp / 1000;
> +		*val2 = (tmp % 1000) * 1000;

What is 1000? HZ_PER_KHZ? KHZ_PER_MHZ?

> +		return IIO_VAL_INT_PLUS_MICRO;

...

> +static int adis16607_write_raw(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       int val, int val2, long info)
> +{
> +	struct adis16607 *st = iio_priv(indio_dev);
> +	u32 tmp;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		tmp = val * 1000 + val2 / 1000;
> +		return adis16607_set_freq(st, tmp);

Ditto.

> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +#define ADIS16607_MOD_CHAN(_type, _mod, _address, _si) { \
> +	.type = (_type), \
> +	.modified = 1, \
> +	.channel2 = (_mod), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.address = (_address), \
> +	.scan_index = (_si), \
> +	.scan_type = { \
> +		.sign = 's', \
> +		.realbits = 24, \
> +		.storagebits = 32, \
> +		.endianness = IIO_BE, \
> +	}, \
> +}

This is not a function, I would rather shift it right by a tab with a split
(also indent the backslashes, it makes it easier to read).

#define ADIS16607_MOD_CHAN(_type, _mod, _address, _si)		\
	{							\
		.type = (_type),				\
		...
	}

...

> +#define ADIS16607_MOD_CHAN_DELTA(_type, _mod, _address, _si) { \
> +	.type = (_type), \
> +	.modified = 1, \
> +	.channel2 = (_mod), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.address = (_address), \
> +	.scan_index = (_si), \
> +	.scan_type = { \
> +		.sign = 's', \
> +		.realbits = 24, \
> +		.storagebits = 32, \
> +		.endianness = IIO_BE, \
> +	}, \
> +}

Ditto.

...

> +/*
> + * No external clock sync support yet: always run on the internal clock.
> + * Default dec=0 after reset, so period = 1 / clk_freq_mhz.
> + */
> +static int adis16607_config_clk(struct adis16607 *st)
> +{
> +	st->clk_freq_mhz = st->info->int_clk_hz * MILLI;

So, it's milli-hertz then? We have MILLIHZ_PER_HZ.

> +	st->sample_period_ns =
> +		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * MILLI, st->clk_freq_mhz);
> +	return 0;
> +}

Yeah, this magic 1000 should be explained everywhere.

...

> +MODULE_DESCRIPTION("Analog Devices ADIS16607 IMU driver");

Make the text the same as per Kconfig. Whatever wording you choose.

-- 
With Best Regards,
Andy Shevchenko


