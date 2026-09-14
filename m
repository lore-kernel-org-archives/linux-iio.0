Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9232B989;
	Mon, 14 Sep 2026 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372826; cv=none; b=dk1wT1QNbxMRZKw36+WW5IYXhGvxpzOOLTIMKf/RdVtZh9cUdhCvADD1GT4olkr5WZ7AJwx7s85pqlmJX7G5NwX3ZAYcQg8GX3eqFEt+m1zEYCI6JM268h0EoLeiZo5ZcrW14RzB3FiTDL4dXHxJ85CnTuitzJiOzC5jMHj+MmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372826; c=relaxed/simple;
	bh=9Sn76LLDRFARz/KCNhJyCKv/7XWJMa9IVHapNKGw/TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqOAHp7AQAgldZdVvvdCKCVC+TrQ10QWaY53LZM5UtEIUlSuMnoTY0zGKmHK7VlCR+c3vOCGgQpGTUeW/TYJ5MLAHhWXQuFXS6uFYz5ucs+LxfPZxC8U4zVYGtYJVPya8KusQRWQUhwHrOXNbNdFBCjlcl4Ppt/mggTbcONYYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwrudPih; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwrudPih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789372825; x=1820908825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Sn76LLDRFARz/KCNhJyCKv/7XWJMa9IVHapNKGw/TU=;
  b=FwrudPihN7K2/klcJdseH+q3SdFLz7Hr1F8+frQN5iOZszV/TX29UggH
   byzorJmUYZIBiIQ7+C6etvxc7mzk6Y4SYZCbQrIPW1xUJyIwONZnjK6+F
   95yY1+sTPY7d+fhwFcEL+zd5gPWACiL9I35DU8GcuhvHT4mKhprkHV2fa
   +w1XbYTBrOo8JzcpmbMgDR1ZXZo6mGx/eKggylXbh9oMMvklm+dkYny/v
   AWIg88kAfF5GoArAPoOhPMUA/+CFwd9n5n1bj2/HiP/SbZSgWqvQEkD9H
   MuHWtnbZ66HfFsEIP/tTjCpu/xdT45sBYoEx1HzRDLWlo9Q6fYueYcj1S
   A==;
X-CSE-ConnectionGUID: qMe4vhmKRcmhpiO2nyGvRg==
X-CSE-MsgGUID: S7Rzx+4+SimYc/7TOFc1vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="107095139"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="107095139"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:00:24 -0700
X-CSE-ConnectionGUID: F8Dbi8XtTzmsChUlk8/s5g==
X-CSE-MsgGUID: LB7HtylyQcCR9f2GSz/REw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="271160132"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:00:20 -0700
Date: Mon, 14 Sep 2026 11:00:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <aqepkmQS_p6K1Bd6@ashevche-desk.local>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
 <20260912013912.51887-3-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912013912.51887-3-marcus.yu.56@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 06:39:12PM -0700, Chang Yu wrote:
> Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> 
> The AS7343 is a 14-channel spectral sensor featuring 11 visible
> channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> flicker detection channel.
> 
> The driver exposes 12 spectral channels (11 visible light and 1
> near-infrared) via sysfs. Runtime PM is implemented to stop
> measurements when the device is suspended or torn down. Power is
> never cut (PON=1 always) to preserve register values.
> 
> Future patches will add configurable gain and integration time,
> interrupt support, buffered reads, VIS channel, and flicker
> detection.

...

> +/*
> + * Support for AMS AS7343 14-channel multi-spectral sensor.
> + * (7-bit I2C slave address 0x39)
> + *
> + * Based on the work of:
> + *   Christian Eggers <ceggers@arri.de> (AS73211 driver)
> + *
> + * Copyright (c) 2026 Chang Yu <marcus.yu.56@gmail.com>
> + *
> + * Datasheets:

Why plural?

> + *   https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> + *
> + * TODO:
> + *   - Autosuspend
> + *   - Support for configurable gain and integration time
> + *   - Interrupt support
> + *   - Add support for reading the VIS channel
> + *   - Flicker detection
> + */

...

> +#define AS7343_ID				0x5a

> +/* AS7343 config registers */
> +#define AS7343_ENABLE				0x80

> +#define AS7343_ATIME				0x81

> +#define AS7343_ASTEP				0xd4


> +#define AS7343_CFG0				0xbf
> +
> +#define AS7343_CFG1				0xc6

> +#define AS7343_CFG20				0xd6

> +#define AS7343_CONTROL				0xfa
> +
> +/* AS7343 status registers */
> +#define AS7343_STATUS2				0x90
> +#define AS7343_STATUS3				0x91
> +#define AS7343_STATUS				0x93
> +#define AS7343_ASTATUS				0x94
> +#define AS7343_STATUS5				0xbb
> +#define AS7343_STATUS4				0xbc
> +#define AS7343_FD_STATUS			0xe3
> +
> +/* AS7343 spectral data registers */
> +#define AS7343_DATA_FZ		0x95
> +#define AS7343_DATA_FY		0x97
> +#define AS7343_DATA_FXL		0x99
> +#define AS7343_DATA_NIR		0x9b
> +#define AS7343_DATA_F2		0xa1
> +#define AS7343_DATA_F3		0xa3
> +#define AS7343_DATA_F4		0xa5
> +#define AS7343_DATA_F6		0xa7
> +#define AS7343_DATA_F1		0xad
> +#define AS7343_DATA_F7		0xaf
> +#define AS7343_DATA_F8		0xb1
> +#define AS7343_DATA_F5		0xb3
> +#define AS7343_DATA_FD_L	0xb7
> +#define AS7343_DATA_FD_H	0xb8

> +/* AS7343 FIFO buffer data registers */
> +#define AS7343_FIFO_LVL		0xfd
> +#define AS7343_FDATA_L		0xfe
> +#define AS7343_FDATA_H		0xff

Please, keep indentation for the registers the same. Also would be nice to have
them sorted by offset.

...

> +static int as7343_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct as7343_data *data = iio_priv(indio_dev);
> +	unsigned int unused;
> +	struct regmap *map;
> +	struct device *dev;
> +	__le16 result;
> +	int ret;

> +	map = data->regmap;
> +	dev = regmap_get_device(map);

Assign them directly in the definition block above.

> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		/* Wait until integration time passes for all 3 cycles. */
> +		msleep(160);
> +
> +		/*
> +		 * Reading ASTATUS latches all data registers to this read.
> +		 * We don't care about the returned saturation/gain status for
> +		 * now.
> +		 */
> +		guard(mutex)(&data->mutex);

Blank line. Always make guard()() to be visible (by grouping it separately
from the other pieces of code).

> +		ret = regmap_read(map, AS7343_ASTATUS, &unused);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_bulk_read(map, chan->address,
> +				       &result, sizeof(result));
> +		if (ret)
> +			return ret;
> +
> +		*val = le16_to_cpu(result);
> +		return IIO_VAL_INT;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int as7343_setup_device(struct device *dev, struct as7343_data *data)
> +{
> +	struct regmap *map = data->regmap;
> +	unsigned int val;
> +	__le16 step;
> +	int ret;
> +
> +	/* Power on */
> +	ret = regmap_set_bits(map, AS7343_ENABLE, AS7343_ENABLE_PON);
> +	if (ret)
> +		return ret;
> +
> +	/* Need to set REG_BANK to 1 before we can access ID */
> +	ret = regmap_set_bits(map, AS7343_CFG0, AS7343_CFG0_REG_BANK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(map, AS7343_ID, &val);
> +	if (ret)
> +		return ret;

> +	if (val != 0x81)
> +		dev_info(dev, "Unknown device ID: %x\n", val);

Wouldn't be better to define 0x81 with meaningful name?

> +	ret = regmap_clear_bits(map, AS7343_CFG0, AS7343_CFG0_REG_BANK);
> +	if (ret)
> +		return ret;
> +
> +	/* Configure the SMUX to readout all channels */
> +	ret = regmap_update_bits(map, AS7343_CFG20, AS7343_CFG20_AUTO_SMUX,
> +				 FIELD_PREP(AS7343_CFG20_AUTO_SMUX,
> +					    AS7343_CFG20_AUTO_SMUX_READOUT_ALL));
> +	if (ret)
> +		return ret;
> +
> +	/* Set 50.1ms integration time and x256 gain for now */
> +	step = cpu_to_le16(AS7343_ASTEP_VAL);
> +	ret = regmap_bulk_write(map, AS7343_ASTEP, &step, sizeof(step));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(map, AS7343_ATIME, AS7343_ATIME_VAL);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(map, AS7343_CFG1, AS7343_CFG1_AGAIN,
> +				  FIELD_PREP(AS7343_CFG1_AGAIN,
> +					     AS7343_CFG1_AGAIN_X256));
> +}

...

> +static int as7343_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct as7343_data *data = iio_priv(indio_dev);
> +	struct regmap *map = data->regmap;

> +	return regmap_clear_bits(map, AS7343_ENABLE, AS7343_ENABLE_SP_EN);

Can this mess up the raw read? If so, also needs a mutex to be held.

> +}
> +
> +static int as7343_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct as7343_data *data = iio_priv(indio_dev);
> +	struct regmap *map = data->regmap;
> +
> +	return regmap_set_bits(map, AS7343_ENABLE, AS7343_ENABLE_SP_EN);
> +}

Same Q.

...

> +static void as7343_suspend_action(void *data)
> +{
> +	struct device *dev = data;

Unneeded casting, can name parameter 'dev' above.

> +	as7343_suspend(dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


