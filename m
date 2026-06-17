Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE03AFD1C;
	Wed, 17 Jun 2026 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680386; cv=none; b=CTfj4UdnG8op+tfjZ68XMTs9xvsJl1O5pUhaAkaBFJu1Wm/Hr29zbBn4qrXCl31JP4Zokd41gzIo4kuiM1//ygYzhqwhI7jmJyfMOi5zK7X9PhpfEAdrzo+iZUJPzWL8w0oH2d48ubL3VQrCHFWQW5FzaSo/cDfmLQb01c/b1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680386; c=relaxed/simple;
	bh=byjlApISYCoUJClb2dCbusFXcH8UZ2cSYTyjTY+s+Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsaTjy7ZIMiJPZ9G81TcB81AFeimyIaGI+hL59rn9cjJ0zuURbnVxaSnKW1jR8wrKRlpt4v8LLI/X3DxEfJp+RZLXoLPkXq2a38jc++fppMxhSUKfgWlZV38C+Z8wGVgzZFb/HvxhvYtKbBGD1mgobG64g7YHGSmVhyh0geWYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2Ehy875; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2Ehy875"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781680385; x=1813216385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=byjlApISYCoUJClb2dCbusFXcH8UZ2cSYTyjTY+s+Hw=;
  b=f2Ehy875yoYnxKBi6ThXanA9ThVYagJFcBuCL6ZtjalzQl/rx6wB02D2
   xVCSnbsq+V6MgjBoGKGXvg0oxC3A0IOMp6Ij4lhCrIQxyfEvfVbT52sSg
   iDTF8XZ1DbaTxPqi1oHwEs1WofyilcSXn0F0f5/6oSoiTeV0IKAkKUilF
   ygrdld/K0vDw0PWG9nAgFr84RTBhma3EpkZb30r8Oi/igPjMaeKgBV5E+
   uE+TDU8QnJDvwE9P1ykBKSW6URMwKDBvmjeOVKPvmiT3r/o2iwgCl14uf
   nnlsWRQCkUghoiRdFLsqHDMRz9POVS4RxUFe7M9ySbh/VhRQ7VqDUioDY
   g==;
X-CSE-ConnectionGUID: 0DK/Lt8xSjaItTK75vCdHw==
X-CSE-MsgGUID: FOfVQRkWTSW8FqLNuQXW4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="86394749"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="86394749"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:13:05 -0700
X-CSE-ConnectionGUID: 0FtOj8LDTUCg5i68qQTuSA==
X-CSE-MsgGUID: rh+V/FMYTVyKO82ohoZS4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="245613371"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:13:02 -0700
Date: Wed, 17 Jun 2026 10:13:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: magnetometer: add driver for QST QMC5883L
 Sensor
Message-ID: <ajJI_KK0eLXeHK0A@ashevche-desk.local>
References: <20260616114942.37241-1-siratul.islam@linux.dev>
 <20260616114942.37241-4-siratul.islam@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616114942.37241-4-siratul.islam@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 05:49:39PM +0600, Siratul Islam wrote:
> Add driver for the QST QMC5883L 3-Axis Magnetic Sensor
> connected via i2c.

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/time.h>

+ types.h

> +#include <linux/iio/iio.h>
> +
> +#include <asm/byteorder.h>

Better to put generic headers before more custom ones

linux/*.h
...blank line...
asm/*.h
...blank line...
linux/iio/*.h

...

> +enum qmc5883l_chan {
> +	QMC5883L_AXIS_X,
> +	QMC5883L_AXIS_Y,
> +	QMC5883L_AXIS_Z

Leave trailing comma, it's not a dedicated terminator.

> +};

...

> +static int qmc5883l_take_measurement(struct iio_dev *indio_dev, int index,
> +				     int *val)
> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);

With

	struct regmap *map = data->regmap;

the below will be shorter.

> +	unsigned int status;
> +	__le16 buf[3];
> +	int ret;
> +
> +	guard(mutex) (&data->mutex);
> +
> +	/* 50ms headroom over the slowest ODR (10Hz) */
> +	ret = regmap_read_poll_timeout(data->regmap,
> +				       QMC5883L_REG_STATUS1,

	ret = regmap_read_poll_timeout(map, QMC5883L_REG_STATUS1,

> +				       status, (status & QMC5883L_STATUS_DRDY),
> +				       2 * USEC_PER_MSEC, 150 * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, QMC5883L_REG_X_LSB, buf,
> +			       sizeof(buf));

	ret = regmap_bulk_read(map, QMC5883L_REG_X_LSB, buf, sizeof(buf));

> +	if (ret)
> +		return ret;
> +
> +	if (status & QMC5883L_STATUS_OVL)
> +		return -ERANGE;
> +
> +	*val = (s16)le16_to_cpu(buf[index]);

While casting works, sign_extend32() is more explicit, but I leave it up to you
and others to decide.

> +
> +	return 0;
> +}

...

> +static int qmc5883l_init(struct qmc5883l_data *data)
> +{
> +	struct regmap *regmap = data->regmap;

Name it 'map'.

> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(regmap, QMC5883L_REG_ID, &reg);
> +	if (ret)
> +		return ret;
> +
> +	/* Not failing because rev 1.0 had this register reserved */
> +	if (reg != QMC5883L_CHIP_ID)
> +		dev_warn(regmap_get_device(regmap),
> +			 "Unknown chip id: 0x%02x, continuing\n", reg);
> +
> +	ret = regmap_write(regmap, QMC5883L_REG_CTRL2, QMC5883L_SOFT_RESET);
> +	if (ret)
> +		return ret;

Ideally this should have a comment with a reference to the datasheet where this
delay is specified. Otherwise a comment why this exact value has been chosen.

> +	fsleep(QMC5883L_PORT_US);
> +
> +	/* DRDY pin no used in this version of the driver */
> +	ret = regmap_write(regmap, QMC5883L_REG_CTRL2, QMC5883L_INT_DISABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, QMC5883L_REG_SET_RESET, QMC5883L_SET_RESET_VAL);
> +	if (ret)
> +		return ret;
> +
> +	data->odr = QMC5883L_ODR_50HZ;
> +	data->range = QMC5883L_RNG_2G;
> +	data->osr = QMC5883L_OSR_64;
> +
> +	return regmap_write(regmap, QMC5883L_REG_CTRL1,
> +			    FIELD_PREP(QMC5883L_MODE_MASK, QMC5883L_MODE_CONT) |
> +			    FIELD_PREP(QMC5883L_ODR_MASK, data->odr) |
> +			    FIELD_PREP(QMC5883L_RNG_MASK, data->range) |
> +			    FIELD_PREP(QMC5883L_OSR_MASK, data->osr));
> +}

...

> +static const struct regmap_config qmc5883l_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = QMC5883L_REG_ID,
> +	.cache_type = REGCACHE_MAPLE,
> +	.volatile_reg = qmc5883l_volatile_reg,
> +	.writeable_reg = qmc5883l_writable_reg

Leave trailing comma, it's not a dedicated terminator.

> +};

...

> +static const struct iio_chan_spec qmc5883l_channels[] = {
> +	QMC5883L_CHANNEL(X),
> +	QMC5883L_CHANNEL(Y),
> +	QMC5883L_CHANNEL(Z)

Ditto.

> +};

...

> +static int qmc5883l_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct qmc5883l_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;

Call it 'map'.

> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &qmc5883l_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "regmap initialization failed\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable VDD regulator\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vddio");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable VDDIO regulator\n");
> +
> +	fsleep(QMC5883L_PORT_US);
> +
> +	data = iio_priv(indio_dev);
> +	data->regmap = regmap;
> +
> +	ret = devm_mutex_init(dev, &data->mutex);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "qmc5883l";
> +	indio_dev->info = &qmc5883l_info;
> +	indio_dev->channels = qmc5883l_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(qmc5883l_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = qmc5883l_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "qmc5883l init failed\n");
> +
> +	ret = devm_add_action_or_reset(dev, qmc5883l_power_down_action, data);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

...

> +static struct i2c_driver qmc5883l_driver = {
> +	.driver = {
> +		.name = "qmc5883l",
> +		.of_match_table = qmc5883l_match,
> +	},
> +	.id_table = qmc5883l_id,
> +	.probe = qmc5883l_probe

Leave a trailing comma.

> +};

-- 
With Best Regards,
Andy Shevchenko


