Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724035;
	b=B1MNAr8DbKdKf6OEFI9Brl2ITbOwDPzjPhuwlVE9LruJe3uR3fwRzMH1yo7rTDkTgQC7
	 35ddl91C3wyIAwaybk48an4+iYHoAEfRumFwKW6Mbd+qFSxetEXxl1SdQqZnIriKWC1yd
	 2Y5QL1dZnxI5OrXw80w5iqngpzrlWKzd83c20lTjcu4hTP+BeHFMOzNSUYNEqGaCmXcra
	 gFNlLFzzdjoSx32jKyzIsLkbcvuOhyccMI4GoA2LNywdO3qYBtDW7g81F/wC/Vbbt9I6k
	 N+AWS3R2LVnQjP8pivD3wgDavf90y3HwMzQqxuPxHW2dntuV22S4iNuYqhBVSpaxmgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724035;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=mT7TZ0FUCCUANAgy9s/XjzUla/BtYqWWRagNddVobtI=;
	b=dDYjCehdJZuqMLe3pi6A4FlE4aUP7l++ShEWnv/dQdCixzUo3DRQ0b6lK0CtR2xt47Wh
	 AlwNn+y8sVRhYu18JmKdOcmEruYUBOBGFUPEtli5p3VmRUUhc6iaKXxIicyljqnHFmzot
	 XDzGmcW39oUBt/BLk5ZB8vWFgUK5FupV63HQF4DfwyVBXnO6Zeyu0uvQc5a5yDcodaF0F
	 yiSXYrxymlSYidwUcCbDMGuVNIgNajVExCeSenHmPDhCkJ9ZhyPko7pGY2adZ8IAMj/b6
	 8aBQw76WukslDfkqyhNl0d6x75aYk+QDYIr2dA6lRyymLgvM/PF7wD5dl257iDctBQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bWdmCmTN;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D6606A326;
	Tue,  3 Nov 2026 16:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 073D6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bWdmCmTN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793724034; x=1825260034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GP1Vlyn5DEnxo5q57ExouLKCMPexN2mDZ1r1fELUUds=;
  b=bWdmCmTNBjI8TTdZ8OYXPSuozEy77O9qwfgTwTbgHUBt8bGQEBqZ+59s
   cMp89vYOYqa4VFXEnhIWVqQ9kwex6edvQLyBiqqFfOm+Kho9XaCocBbuM
   SbLCmrxoxGp74V+aqNE7QOFKhGWuri5iOsny0xTRAr2ffCoxDu+eSFZWZ
   5kwb4JSdrZ9oED2RirHS9TKAK8XrLfwxmRD/yHgZfXboKoHldhuNOFmLM
   LdeEDXL7lG+wy8X6NgEEXcuXeRcFsLg/HALv/pwL+gnjV3S2jYVdPXdSU
   MEwxr2C/Z/vDWBFJ1kolOlcLFkWpZKp7NkVQerqsZPTO9vL6xYA2BkyqW
   A==;
X-CSE-ConnectionGUID: FuPnPUbyQ/WvPWFRr7Wwmw==
X-CSE-MsgGUID: lUtbjDLHRQy/Dx0Dkv0ZmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2350407"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2350407"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:40:33 -0800
X-CSE-ConnectionGUID: atw797tEQmaaOmT6XSE/dA==
X-CSE-MsgGUID: +gROCG8TQGCMpSvXDRtK2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6375593"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:40:29 -0800
Date: Tue, 3 Nov 2026 18:40:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marius Cristea <marius.cristea@microchip.com>
Subject: Re: [PATCH v5 5/5] iio: adc: add support for PAC1711
Message-ID: <auoOe1W7kbO8I2d-@ashevche-desk.local>
References: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
 <20261103-pac1711-v5-5-71c20101a52e@microchip.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-pac1711-v5-5-71c20101a52e@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 04:37:15PM +0200, Ariana Lazar wrote:
> This is the iio driver for Microchip PAC1711, PAC1721, PAC1811 and
> PAC1821 single-channel power monitors with accumulator. The PAC1711 and
> PAC1721 devices use 12-bit resolution for voltage and current measurements
> and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
> resolution and use 32 bits for power calculations. The 56-bit accumulator
> register accumulates power (energy) or current (Coulomb counter).
> 
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
> PAC1721 and PAC1821.

...

> +config PAC1711
> +	tristate "Microchip Technology PAC1711 driver"

Align this text with the Summary at the top comment and MODULE_DESCRIPTION()
that all three read the same (or quite similar, like the same with or without
word "driver").

> +	depends on I2C
> +	help
> +	  Say yes here to build support for Microchip Technology's PAC1711,
> +	  PAC1721, PAC1811 and PAC1821 Single-Channel Power Monitors with
> +	  Accumulator.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pac1711.

...

> + * IIO driver for PAC1711 Single-Channel DC Power/Energy Monitor

^^^ See above.

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>

> +#include <linux/device.h>

I failed to see how it's used/ dev_printk.h, yes, but the rest of device.h?

> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/jiffies.h>
> +#include <linux/kstrtox.h>
> +#include <linux/module.h>
> +#include <linux/math64.h>
> +#include <linux/mutex.h>
> +#include <linux/overflow.h>
> +#include <linux/property.h>

+ time.h // for MSEC_PER_SEC

> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +#include <linux/workqueue.h>

+ blank line.

> +#include <asm/byteorder.h>
> +
> +#include <linux/iio/iio.h>

...

> +#define PAC1711_VOLTAGE_MILLIVOLTS_MAX	(42 * MILLI)
> +#define PAC1721_VOLTAGE_MILLIVOLTS_MAX	(9 * MILLI)

#define PAC1711_VOLTAGE_mV_MAX	(42 * MILLI)
#define PAC1721_VOLTAGE_mV_MAX	(9 * MILLI)

...

> +/* Full FSR power is multiplied by 10^9 to ensure precise scale calculation. */
> +#define PAC1711_PRODUCT_VOLTAGE_PV_FSR	(4200ULL * NANO)
> +#define PAC1721_PRODUCT_VOLTAGE_PV_FSR	(900ULL * NANO)

_pV (I assume picovolts is in mind?) Note, this also the same as above with
just a multiplier. Why do we need them separately (or independent)?

...

> +/* PAC1711/PAC1811 VBUS FSR: 42V and 21V */
> +#define PAC1711_VBUS_FSR_UV		(42 * MICRO)
> +#define PAC1711_VBUS_FSR_HALF_UV	(21 * MICRO)

> +/* PAC1721/PAC1821 VBUS FSR: 9V and 4.5V */
> +#define PAC1721_VBUS_FSR_UV		(9 * MICRO)
> +#define PAC1721_VBUS_FSR_HALF_UV	(4500 * MILLI)
> +
> +/* VSENSE FSR: 100mV and 50mV */
> +#define PAC1711_VSENSE_FSR_UV		(100 * MILLI)
> +#define PAC1711_VSENSE_FSR_HALF_UV	(50 * MILLI)

_UV ==> _uV

...

> +#define PAC1711_ACC_ENERGY_STR		"energy"
> +#define PAC1711_ACC_CHARGE_STR		"charge"

One-time use, kill the macro, it's visible from the below.

> +static const char * const pac1711_acc_sources[] = {
> +	[PAC1711_ACCMODE_VPOWER] = PAC1711_ACC_ENERGY_STR,
> +	[PAC1711_ACCMODE_VSENSE] = PAC1711_ACC_CHARGE_STR,
> +};

...

> +static const int pac1711_vbus_range_tbl[2][3][2] = {
> +	[PAC1711_VOLTAGE_RANGE_IDX] = {
> +		[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, PAC1711_VBUS_FSR_UV },
> +		[PAC1711_FULL_RANGE_BIPOLAR]  = { -(int)PAC1711_VBUS_FSR_UV, PAC1711_VBUS_FSR_UV },
> +		[PAC1711_HALF_RANGE_BIPOLAR]  = { -(int)PAC1711_VBUS_FSR_HALF_UV,
> +						  PAC1711_VBUS_FSR_HALF_UV },
> +	},
> +	[PAC1721_VOLTAGE_RANGE_IDX] = {
> +		[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, PAC1721_VBUS_FSR_UV },
> +		[PAC1711_FULL_RANGE_BIPOLAR]  = { -(int)PAC1721_VBUS_FSR_UV, PAC1721_VBUS_FSR_UV },
> +		[PAC1711_HALF_RANGE_BIPOLAR]  = { -(int)PAC1721_VBUS_FSR_HALF_UV,
> +						  PAC1721_VBUS_FSR_HALF_UV },

There is an indentation issue, also no need to format '=' on the same column.

		[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, PAC1721_VBUS_FSR_uV },
		// alternatively
		[PAC1711_FULL_RANGE_UNIPOLAR] = {
			0,
			PAC1721_VBUS_FSR_uV,
		},
		[PAC1711_FULL_RANGE_BIPOLAR]  = {
			-(int)PAC1721_VBUS_FSR_uV,
			PAC1721_VBUS_FSR_uV,
		},
		[PAC1711_HALF_RANGE_BIPOLAR]  = {
			-(int)PAC1721_VBUS_FSR_HALF_uV,
			PAC1721_VBUS_FSR_HALF_uV,
		},

> +	},
> +};

...and so on...

...

> +enum {
> +	PAC1711_SAMP_8192SPS = 0,
> +	PAC1711_SAMP_4096SPS = 1,
> +	PAC1711_SAMP_1024SPS = 2,
> +	PAC1711_SAMP_256SPS = 3,
> +	PAC1711_SAMP_64SPS = 4,
> +	PAC1711_SAMP_8SPS = 5,
> +};

This enum is not directly used in HW, but okay, it might make code robust with
the explicit assignments.

...

> +struct pac1711_features {
> +	u64 voltage_pv_fsr;
> +	int voltage_millivolts_max;
> +	const char *name;
> +	u8 voltage_range_idx;
> +	bool has_16bit_resolution;

Run `pahole` and act accordingly. Same for other data types where the order
is not strict.

> +};

...

> +static int pac1711_send_refresh(struct pac1711_chip_info *info, u32 wait_time)
> +{
> +	struct i2c_client *client = info->client;
> +	int ret;
> +
> +	/* Writing a REFRESH or a REFRESH_V command */
> +	ret = i2c_smbus_write_byte(client, PAC1711_REFRESH_REG_ADDR);
> +	if (ret) {
> +		dev_err(&client->dev, "%s - cannot send Refresh cmd (0x%02X)\n",
> +			__func__, PAC1711_REFRESH_REG_ADDR);

__func__ means that the message itself is poorly written (not enough uniqueness
to understand from what flow point it comes. Ditto for all __func__ uses, revisit
all the messages and make them more precise if required and drop __func__.

> +		return ret;
> +	}
> +
> +	/* Register data retrieval timestamp */
> +	info->chip_reg_data.jiffies_tstamp = jiffies;
> +
> +	/* Wait till the data is available */
> +	fsleep(wait_time);
> +
> +	return 0;
> +}

...

> +	/* Read the ctrl/status registers for this snapshot */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_ACT_REG_ADDR,
> +					    sizeof(val_be16), (u8 *)&val_be16);
> +	if (ret != sizeof(val_be16)) {
> +		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
> +			__func__, PAC1711_CTRL_ACT_REG_ADDR);
> +		return ret < 0 ? ret : -EIO;
> +	}

No nested branches, it's harder to follow. (Here and elsewhere.)

...

> +static int pac1711_reg_snapshot(struct pac1711_chip_info *info, bool *refreshed)
> +{
> +	u32 wait_time;

Units?

> +	int ret;
> +
> +	guard(mutex)(&info->lock);
> +
> +	/* No hardware refresh is needed */
> +	if (refreshed)
> +		*refreshed = false;
> +
> +	/* Return early if the minimum polling time hasn't elapsed */
> +	if (!time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
> +			msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS)))
> +		return 0;
> +
> +	wait_time = (1024 * 1000) / pac1711_samp_rate_map_tbl[info->sample_rate_idx];

Depending on the above, 1000 can be replaced with named multiplier.
Same for elsewhere magic 1000.

> +	/* A hardware refresh will happen */
> +	ret = pac1711_reg_snapshot_locked(info, wait_time);
> +	if (!ret && refreshed)

No. use the regular pattern

	if (ret)
		return ret;

	if (refreshed)
		...

	return 0;

> +		*refreshed = true;
> +
> +	return ret;
> +}

...

> +	if (!ret)
> +		info->enable_acc = val;

Why two times to check ret?

> +	if (ret)
> +		dev_err(dev, "failed to reset accumulator: %d\n", ret);
> +
> +	return ret;

...

> +		guard(mutex)(&info->lock);

+ blank line.

> +		shunt = info->shunt;
> +
> +		switch (chan->address) {
> +		case PAC1711_VBUS_REG_ADDR:
> +			*val = info->features->voltage_millivolts_max;
> +			*val2 = (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR) ? 15 : 16;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case PAC1711_VSENSE_REG_ADDR:
> +			/*
> +			 * Currents - scale for mA - depends on the channel's shunt value
> +			 * (100mV * 1000000) / (2^16 * shunt(uohm))
> +			 */
> +			*val = 1526;
> +			*val2 = shunt;
> +
> +			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +				*val = *val << 1;

				*val *= 2;

> +
> +			return IIO_VAL_FRACTIONAL;
> +		case PAC1711_VPOWER_REG_ADDR:
> +		case PAC1711_VACC_REG_ADDR:
> +			if (chan->type == IIO_CHARGE) {
> +				/*
> +				 * Coulomb counter scale:
> +				 * 16-bit resolution: (100mV * NANO) / 2^16
> +				 * 12-bit resolution: (100mV * NANO) / 2^12
> +				 */
> +				u64 ref = info->features->has_16bit_resolution ?
> +						  1525878906250ULL : 24414062500000ULL;

Split definition and assignment.

> +				if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +					ref = ref << 1;

					ref *= 2;

> +				ref = div_u64(ref, shunt);
> +				*val2 = do_div(ref, 1 * NANO);
> +				*val = ref;
> +
> +				return IIO_VAL_INT_PLUS_NANO;
> +			}
> +
> +			/*
> +			 * Power - uW - it will use the combined scale
> +			 * for current and voltage
> +			 * current(mA) * voltage(mV) = power (uW)
> +			 */
> +			tmp = info->features->voltage_pv_fsr;
> +			do_div(tmp, shunt);
> +
> +			if (chan->type == IIO_ENERGY)
> +				*val2 = info->features->has_16bit_resolution ? 32 : 24;
> +			else
> +				*val2 = 32;
> +
> +			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +				*val2 -= 1;
> +
> +			if (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +				*val2 -= 1;
> +
> +			shift = fls64(tmp) - 31;
> +			if (shift > 0) {
> +				tmp >>= shift;
> +				*val2 -= shift;
> +			}
> +
> +			*val = (int)tmp;

Why casting?

> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}

...

Basically the last 2/3rd I sparsely checked. It's unbelievably that v5 of
the series has tons of small style issues. Also the driver length is too big,
can you split this to a few, smaller ones?

-- 
With Best Regards,
Andy Shevchenko


