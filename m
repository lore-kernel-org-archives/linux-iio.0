Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2537238B7DD;
	Mon, 20 Apr 2026 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678208; cv=none; b=Kik/xWad4LRKcQiBbT0xiyVoqZPNHR6jLP+1mr0BgADPc4+WKHmNeWr4+JX+5sQfPaxs6TtUSrtlf1ubIyvQ1S/cvzqB6sgKWLBWON7T9Zs471zxi34TqYWo/uQqg7hCBxz1TyhYAeSQNXXiS6dkJ3B3ci7o0F/FjVMbvTfqQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678208; c=relaxed/simple;
	bh=BpMgsKWyJck+HL1pK+cC8xJCz2lWEjLyWJwWlwA5iGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgLPmtgMSQ2C2W3WOnKHhkJrog46GY4HFTmzmCOeQRBXmRdYG8vITsrfqRlQgyzmx3ZAvFu1qmU5Lk8IlqZERBXmmIxTYa0HNp5im2z5/zvdCqjbhi4RRY91nVeKIXkQWU1ZRT2bRa/JeAs3WNXMhjAdmDV73Ek6v3AVRUgbxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neGxoms1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neGxoms1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776678207; x=1808214207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BpMgsKWyJck+HL1pK+cC8xJCz2lWEjLyWJwWlwA5iGs=;
  b=neGxoms1dn6tg32giZ5Ha2PHECD4fPmsRB2d6kd7utEJJEZ/KJ7LV1rf
   3fqyZ41654S754qJB1b5UbfEJ4cmtHBoaJJwERcgHel3jasaE7Z/P6QCA
   TSftlpu3BeWl62MRQeOzsYWIYAirDY2JyQdVW+zzRAUStvSDemEQAIIyN
   AWUUBogYvwNSLeZWsXpal1uNs6S8WtkeMXjMXa7OC5wfKxLxoyMa2RUNA
   oFRiFK2N7Z5FO+ezU415lqFxiK2ZSTkq4fi8EvpuWaqeFgNdZze+8wQ5R
   xlWqFhg3/EMpEP3otF9kF09/Ch/jZ8okwX5nNWwBmBL6tmTIRvpmeA/s/
   A==;
X-CSE-ConnectionGUID: RPJMY59GSoqHiQb2qJMAEw==
X-CSE-MsgGUID: iM3Pf6GeSEyeF9LNZDI9sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77715385"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="77715385"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:43:26 -0700
X-CSE-ConnectionGUID: nhV8dbwtTauN+vdNTR+++g==
X-CSE-MsgGUID: u1UTzVYGSlmypuiIgkuyYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="231964082"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:43:22 -0700
Date: Mon, 20 Apr 2026 12:43:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, andy@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, krzk+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, me@brighamcampbell.com,
	nuno.sa@analog.com, robh@kernel.org, skhan@linuxfoundation.org,
	Hardik Phalet <hardik.phalet@gmail.com>
Subject: Re: [PATCH v3 3/5] iio: magnetometer: add driver for QST QMC5883P
Message-ID: <aeX1OFBYnjodEAge@ashevche-desk.local>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
 <20260420-qmc5883p-driver-v3-3-da1e97088f8b@pm.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260420-qmc5883p-driver-v3-3-da1e97088f8b@pm.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 19, 2026 at 10:32:43PM +0000, Hardik Phalet wrote:
> Add an IIO driver for the QST QMC5883P, a 3-axis anisotropic
> magneto-resistive (AMR) magnetometer with a 16-bit ADC, communicating
> over I2C. There is no existing upstream driver for this device.
> 
> The driver supports:
>  - Raw magnetic field readings on X, Y and Z axes
>  - Four full-scale ranges (+/-2 G, +/-8 G, +/-12 G, +/-30 G) selectable
>    via IIO_CHAN_INFO_SCALE
>  - Output data rate configurable via IIO_CHAN_INFO_SAMP_FREQ (10, 50,
>    100, 200 Hz)
>  - vdd-supply regulator management
> 
> Regmap with an rbtree cache is used throughout. CTRL_1 and CTRL_2 bit
> fields are accessed via regmap_field to avoid read-modify-write races.
> The STATUS register is marked precious so regmap never reads it
> speculatively and clears the DRDY/OVFL bits unexpectedly.
> 
> The probe-time init sequence is: soft reset, wait 300 us for POR
> completion, deassert reset, then drop the register cache so subsequent
> RMW writes read fresh values from the device. After reset the chip is in
> MODE_SUSPEND per datasheet §6.2.4, and is left there; the first
> userspace access will wake it via runtime PM (added in a follow-up
> patch).
> 
> Cleanup is fully devm-managed via devm_regulator_get_enable() and
> devm_iio_device_register().
> 
> Oversampling ratio and runtime PM are added in follow-up patches.

...

> +/*
> + * qmc5883p.c - QMC5883P magnetometer driver

Do not add filename inside file. It makes often become an outdated (missed to
change) if the driver is renamed.

> + * Copyright 2026 Hardik Phalet <hardik.phalet@pm.me>
> + *
> + * TODO: add triggered buffer support, PM, OSR, DSR

> + *

Drop this blank line.

> + */

...

> +#include <linux/array_size.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/units.h>
> +#include <linux/unaligned.h>

Follow IWYU. Missing cleanup.h, types.h, maybe more, I haven't carefully checked.

...

> +#define QMC5883P_REG_CHIP_ID 0x00

It's better to read when it's a tab before value.

...

> +#define QMC5883P_DRDY_POLL_US 1000

(1 * USEC_PER_MSEC)

from time.h which gives better readability of what the units of the value.
Since it's used only once in the code, drop it, see below.

...

> +enum qmc5883p_channels {
> +	AXIS_X = 0,

Why? Is it Linux enum or HW-driven one? If the latter, you have to assign all
of them explicitly, otherwise it doesn't matter, no assignment is needed.

> +	AXIS_Y,
> +	AXIS_Z,
> +};

...

> +static const struct reg_field qmc5883p_rf_osr =
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 4, 5);
> +static const struct reg_field qmc5883p_rf_odr =
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 2, 3);
> +static const struct reg_field qmc5883p_rf_mode =
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 0, 1);
> +static const struct reg_field qmc5883p_rf_rng =
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 2, 3);
> +static const struct reg_field qmc5883p_rf_sftrst =
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 7, 7);
> +static const struct reg_field qmc5883p_rf_chip_id =
> +	REG_FIELD(QMC5883P_REG_CHIP_ID, 0, 7);

I would make these to be one-liners.

...

> +static int qmc5883p_get_measure(struct qmc5883p_data *data, s16 *x, s16 *y,
> +				s16 *z)

Do a logical split.

static int qmc5883p_get_measure(struct qmc5883p_data *data,
				s16 *x, s16 *y, s16 *z)

> +{
> +	int ret;
> +	u8 reg_data[6];
> +	unsigned int status;
> +
> +	/*
> +	 * Poll the status register until DRDY is set or timeout.
> +	 * Read the whole register in one shot so that OVFL is captured from
> +	 * the same read: reading 0x09 clears both DRDY and OVFL, so a second
> +	 * read would always see OVFL=0.
> +	 * At ODR=10Hz one period is 100ms; use 150ms as a safe upper bound.
> +	 */
> +	ret = regmap_read_poll_timeout(data->regmap, QMC5883P_REG_STATUS,
> +				       status, status & QMC5883P_STATUS_DRDY,
> +				       QMC5883P_DRDY_POLL_US,
> +				       150 * (MICRO / MILLI));

MICRO/MILLI is used for µV to mV conversion (as we don't have it defined), but
here we have the constants in time.h (somewhere down).

				       1 * USEC_PER_MSEC, 150 * USEC_PER_MSEC);

> +	if (ret)
> +		return ret;
> +
> +	if (status & QMC5883P_STATUS_OVFL) {
> +		dev_warn_ratelimited(data->dev,
> +			"data overflow, consider reducing field range\n");
> +		ret = -ERANGE;

EOVERFLOW ? (ERANGE is fine, but the proposed might be slightly better...
or worse :-)

> +		return ret;
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, QMC5883P_REG_X_LSB, reg_data,
> +			       ARRAY_SIZE(reg_data));

They are u8, sizeof() will suffice. Note, ARRAY_SIZE() may lead to interesting
bugs in some cases.

> +	if (ret)
> +		return ret;
> +
> +	*x = (s16)get_unaligned_le16(&reg_data[0]);
> +	*y = (s16)get_unaligned_le16(&reg_data[2]);
> +	*z = (s16)get_unaligned_le16(&reg_data[4]);

Why not defining the reg_data properly from the start?

	__le16 reg_data[3];

?

> +	return ret;
> +}

...

> +static int qmc5883p_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan, int *val,
> +			     int *val2, long mask)
> +{

> +	s16 x, y, z;

Don't we have some struct for this? In any case you can define...

struct ...3d {
	s16 x;
	s16 y;
	s16 z;
};

> +	struct qmc5883p_data *data = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int regval;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = qmc5883p_get_measure(data, &x, &y, &z);

...and use it here.

> +		if (ret < 0)
> +			return ret;
> +		switch (chan->address) {
> +		case AXIS_X:
> +			*val = x;
> +			break;
> +		case AXIS_Y:
> +			*val = y;
> +			break;
> +		case AXIS_Z:
> +			*val = z;
> +			break;
> +		}
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regmap_field_read(data->rf.rng, &regval);
> +		if (ret < 0)

All these ' < 0' parts, are they needed / required?

> +			return ret;
> +		*val = qmc5883p_scale[regval][0];
> +		*val2 = qmc5883p_scale[regval][1];
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_field_read(data->rf.odr, &regval);
> +		if (ret < 0)
> +			return ret;
> +		*val = qmc5883p_odr[regval];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int qmc5883p_write_scale(struct qmc5883p_data *data, int val, int val2)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(qmc5883p_scale); i++) {

	for (unsigned int i = 0; i < ARRAY_SIZE(qmc5883p_scale); i++) {


> +		if (qmc5883p_scale[i][0] == val && qmc5883p_scale[i][1] == val2)
> +			return regmap_field_write(data->rf.rng, i);
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int qmc5883p_write_odr(struct qmc5883p_data *data, int val)

As per above.

...

> +static int qmc5883p_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct qmc5883p_data *data = iio_priv(indio_dev);
> +	int ret, restore;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	ret = regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = qmc5883p_write_odr(data, val);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = qmc5883p_write_scale(data, val, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	restore = regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);

> +	if (restore && !ret)
> +		ret = restore;
> +
> +	return ret;

Why not simply do this

	if (ret)
		return ret;

	return restore;

?

> +}

...

> +static int qmc5883p_rf_init(struct qmc5883p_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = data->dev;

Don't keep duplicates, either regmap from dev or dev from regmap may be
retrieved using the respective APIs.

> +	struct qmc5883p_rf *rf = &data->rf;
> +
> +	rf->osr = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_osr);
> +	if (IS_ERR(rf->osr))
> +		return PTR_ERR(rf->osr);
> +
> +	rf->odr = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_odr);
> +	if (IS_ERR(rf->odr))
> +		return PTR_ERR(rf->odr);
> +
> +	rf->mode = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_mode);
> +	if (IS_ERR(rf->mode))
> +		return PTR_ERR(rf->mode);
> +
> +	rf->rng = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_rng);
> +	if (IS_ERR(rf->rng))
> +		return PTR_ERR(rf->rng);
> +
> +	rf->sftrst = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_sftrst);
> +	if (IS_ERR(rf->sftrst))
> +		return PTR_ERR(rf->sftrst);
> +
> +	rf->chip_id = devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_chip_id);
> +	if (IS_ERR(rf->chip_id))
> +		return PTR_ERR(rf->chip_id);
> +
> +	return 0;
> +}

...

> +static int qmc5883p_read_chip_id(struct qmc5883p_data *data)
> +{
> +	int ret, regval;

Why regval is signed? regmap API uses unsigned int all over the places...

> +	ret = regmap_field_read(data->rf.chip_id, &regval);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "failed to read chip ID\n");

Single line.

> +
> +	if (regval != QMC5883P_CHIP_ID)
> +		dev_info(data->dev, "unexpected chip ID %#x, expected %#x\n",
> +			regval, QMC5883P_CHIP_ID);
> +
> +	return 0;
> +}

...

> +#define QMC5883P_CHAN(ch)                                                 \
> +	{                                                                 \
> +		.type = IIO_MAGN,                                         \
> +		.channel2 = IIO_MOD_##ch,                                 \
> +		.modified = 1,                                            \
> +		.address = AXIS_##ch,                                     \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |            \
> +				      BIT(IIO_CHAN_INFO_SCALE),           \

The style of this is different to the below, I would follow below one.

		.info_mask_separate =						\
			BIT(IIO_CHAN_INFO_RAW) |            \
			BIT(IIO_CHAN_INFO_SCALE),           \

> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.info_mask_shared_by_type_available =                     \
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),                     \
> +	}

The  \ are indented with spaces! Please, use tabs.

...

> +static int qmc5883p_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct qmc5883p_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &qmc5883p_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "regmap initialization failed\n");
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->dev = dev;
> +	data->regmap = regmap;

> +	mutex_init(&data->mutex);

devm_mutex_init()

> +	ret = qmc5883p_rf_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to initialize regmap fields\n");
> +
> +	indio_dev->name = "qmc5883p";
> +	indio_dev->info = &qmc5883p_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = qmc5883p_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(qmc5883p_channels);
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to initialize vdd regulator\n");
> +
> +	/* Datasheet specifies up to 50 ms supply ramp + 250 us POR time. */
> +	fsleep(50 * (MICRO / MILLI) + 250);

USEC_PER_MSEC

> +
> +	ret = qmc5883p_read_chip_id(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = qmc5883p_chip_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize chip\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

...

> +static const struct i2c_device_id qmc5883p_id[] = {
> +	{ "qmc5883p", 0 },

Drop ', 0' part.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


