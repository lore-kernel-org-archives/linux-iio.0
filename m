Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36EC30DEB2;
	Thu, 11 Jun 2026 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205543; cv=none; b=uapY4wl62LaC4Mqa7loit8pROb83jJkz89GHLgZaiPOpU/1q0JbtoGB/C81keYT0Yj88l5z/afjNI9FL1vBkfGV5kHC4YvKX1yk4IVJ90PC4QqQDpyqEcDG50mvCNazbhXS4nmluNIqb5ThwUuHnNauIFCgdJ9znm4rA1cuBNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205543; c=relaxed/simple;
	bh=5nxcyfEk13pHgk0As9EfYqkxvLW36vPzzkocZwEQJbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmL3SlO5JjyO/kAitwfSTqM+4cE7zoasmaisITHoy9FoFvfPvh0G5X/3ltR0zrcFkuhYxfXsvz7L7rn7ES0ttEuv2sepqxSvzKwl6kHUyeWCmqxiyeTRrL+HkcbStANYYJJS2xtsDwmBIqOjBXD/UhiQ7tWlczBe6fPIl/Sz55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htOpT3Ds; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htOpT3Ds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781205542; x=1812741542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5nxcyfEk13pHgk0As9EfYqkxvLW36vPzzkocZwEQJbo=;
  b=htOpT3DsoVUJBwKpVl/bjrtdWLKmSFz/y8CZ9vpL3DPwjKXEcXOOq+Vj
   5/Z+ycdDYwlLjQhLhVs+X25vXQueTm/eELXrexRygy5Y1NL1K/QJaSclO
   6dCxholGX/8Jtn9EZKbui/A2a04xqBzOVTmttWdBJGAVdFOroacnrp/x4
   bkan2KIx2TsT3dD5ZNjnER6a/Vx6G/15HFIXnvhlh8ypxw1WoDySXc+0n
   CKFeCn3Q6ZEyJ7Os0wBQhKn2Qzn9EDREXzufMCrzp8Bi4FFBWkUlQrTHZ
   vlvOuksZ9rmtGqYawepX7PPO+PsUymKEviF0agiMaF5mDle9uFcJrLRRJ
   Q==;
X-CSE-ConnectionGUID: VWbvhnOfSNuli9sXf+e81A==
X-CSE-MsgGUID: UIfhqqWKTDmJJljU0vH5sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85871577"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="85871577"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:19:01 -0700
X-CSE-ConnectionGUID: e1a9XoP2SCq+YIQZ/Mj9mQ==
X-CSE-MsgGUID: w0uxETYaTOeXm3bJ6k89GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="245697181"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:18:58 -0700
Date: Thu, 11 Jun 2026 22:18:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: Re: [PATCH v4 4/4] iio: flow: add Sensirion SLF3S liquid flow sensor
 driver
Message-ID: <aisKH1Gu0HvRtX3N@ashevche-desk.local>
References: <20260611132700.671322-1-wafgo01@gmail.com>
 <20260611132700.671322-5-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611132700.671322-5-wafgo01@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 03:27:00PM +0200, Wadim Mueller wrote:
> Add a driver for the Sensirion SLF3S family of digital
> liquid-flow sensors on I2C.  Currently supported variants are
> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B; they share the same
> register map and differ only in flow-scale factor and calibrated
> measurement range.  The variant (and therefore the scale) is
> auto-detected from the product-information register at probe time;
> a sensor reporting an unknown sub-type falls back to the variant
> named in the device tree, as promised by the fallback compatible.
> 
> Each measurement frame returns a 16-bit signed flow value, a
> 16-bit signed temperature reading and a status word, each
> protected by a CRC-8 byte.  The driver exposes the flow rate as
> IIO_VOLUMEFLOW and the temperature as IIO_TEMP via the standard
> IIO read_raw / read_scale interface.
> 
> The volume-flow scale is reported in m^3/s.  As the per-LSB scale
> is on the order of 1e-12 m^3/s, it is emitted as a 64-bit
> fixed-point value with femto (1e-15) resolution
> (IIO_VAL_DECIMAL64_FEMTO) so the small SI value keeps full
> precision.  This relies on the IIO_VAL_DECIMAL64_FEMTO format type
> added earlier in this series, which extends the IIO_VAL_DECIMAL64
> core formatting introduced by Rodrigo Alencar's ADF41513 series.
> 
> The active calibration medium can be switched at runtime between
> the factory-calibrated water and isopropyl-alcohol modes via the
> in_volumeflow_medium sysfs attribute; the sensor starts in water
> mode after probe.
> 
> The sensor has no low-power state of its own, so system suspend
> stops the measurement and disables the vdd supply; resume powers
> the sensor back up, waits out the power-up time and restarts the
> measurement with the previously active medium, following the
> scd30/scd4x precedent.
> 
> This driver also creates the drivers/iio/flow/ subdirectory and
> the corresponding Kconfig/Makefile glue.

...

> +#include <linux/array_size.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>

Should be err.h // PTR_ERR(), et cetera

> +#include <linux/i2c.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>

...

> +/**
> + * struct slf3s_variant - per-variant calibration constants
> + * @sub_type:	product-info sub-type byte returned by the sensor
> + * @name:	name reported via @iio_dev.name
> + * @scale_num:	flow scale numerator (l/s per LSB)
> + * @scale_den:	flow scale denominator (l/s per LSB)
> + */
> +struct slf3s_variant {
> +	u8 sub_type;
> +	const char *name;

> +	int scale_num;
> +	int scale_den;

	struct s32_fract scale;

> +};

...

> +static const struct slf3s_variant slf3s_variants[] = {
> +	[0] = {
> +		.sub_type	= 0x03,
> +		.name		= "slf3s-0600f",
> +		.scale_num	= 1,
> +		.scale_den	= 600 * MICRO,
> +	},
> +	[1] = {
> +		.sub_type	= 0x02,
> +		.name		= "slf3s-1300f",
> +		.scale_num	= 1,
> +		.scale_den	= 30 * MICRO,
> +	},
> +	[2] = {
> +		.sub_type	= 0x05,
> +		.name		= "slf3s-4000b",
> +		.scale_num	= 1,
> +		.scale_den	= 1920 * MILLI,
> +	},

Either split this to per HW structures, or introduce a enum for having these be
robust against any indices shuffling. The plain numbers are semantic-less, easy
to mess up with them.

> +};

...

> +/**
> + * struct slf3s_data - per-device state
> + * @client:	I2C client this instance is bound to
> + * @vdd:	supply regulator, disabled while suspended
> + * @variant:	pointer into @slf3s_variants for the detected device
> + * @medium:	currently active calibration medium
> + * @lock:	serialises the multi-step command/response exchanges
> + * @crc_table:	pre-computed CRC-8 lookup table for SLF3S_CRC8_POLY
> + */
> +struct slf3s_data {
> +	struct i2c_client *client;
> +	struct regulator *vdd;
> +	const struct slf3s_variant *variant;
> +	enum slf3s_medium medium;
> +	struct mutex lock; /* serialises command/response exchanges */
> +	u8 crc_table[CRC8_TABLE_SIZE];

Does `pahole` agree with the layout?

> +};
> +
> +static int slf3s_send_cmd(struct i2c_client *client, const u8 cmd[at_least 2])

Hmm... Do we really need to be overprotective here?

> +{
> +	int ret = i2c_master_send(client, cmd, 2);
> +
> +	if (ret == 2)

In long-term this is hard to maintain. The preferred way is to decouple the
assignment and the definition as the value is getting validated in the code.

> +		return 0;
> +
> +	return ret < 0 ? ret : -EIO;

The usual pattern is to check for errors first

	if (ret < 0)
		return ret;
	if (ret != 2)
		return -EIO;
	return 0;

> +}

...

> +static int slf3s_read_sample(struct slf3s_data *sf, int *flow, int *temp)
> +{
> +	/*
> +	 * A measurement frame is flow, temperature and a signaling-flags
> +	 * word, each followed by a CRC byte.  Only flow and temperature are
> +	 * used, so the read is stopped after their two words (6 bytes).
> +	 */
> +	u8 buf[6];
> +	int ret;
> +
> +	ret = i2c_master_recv(sf->client, buf, ARRAY_SIZE(buf));

sizeof() will do the job.

> +	if (ret < 0)
> +		return ret;
> +	if (ret != ARRAY_SIZE(buf))

Ditto.

> +		return -EIO;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(buf); i += 3) {

Ditto.

> +		if (!slf3s_crc_valid(sf, &buf[i]))
> +			return -EIO;
> +	}
> +
> +	*flow = sign_extend32(get_unaligned_be16(&buf[0]), 15);
> +	*temp = sign_extend32(get_unaligned_be16(&buf[3]), 15);
> +
> +	return 0;
> +}

...

> +static int slf3s_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, int *val,
> +			  int *val2, long mask)
> +{
> +	struct slf3s_data *sf = iio_priv(indio_dev);
> +	int flow, temp, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &sf->lock)
> +			ret = slf3s_read_sample(sf, &flow, &temp);
> +		if (ret)
> +			return ret;
> +
> +		*val = (chan->type == IIO_VOLUMEFLOW) ? flow : temp;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_VOLUMEFLOW) {
> +			/*
> +			 * scale_num/scale_den is the flow per LSB in l/s, but
> +			 * IIO reports volume flow in m^3/s (1 l = 1e-3 m^3).
> +			 * These values are tiny (~1.67e-12 m^3/s for the
> +			 * SLF3S-0600F), so emit a 64-bit fixed-point value with
> +			 * femto (1e-15) resolution to preserve precision.
> +			 * Converting l/s to m^3/s (/ MILLI) and scaling to femto
> +			 * (* FEMTO) leaves a net * (FEMTO / MILLI) factor.
> +			 */
> +			const struct slf3s_variant *v = sf->variant;
> +			s64 num = (s64)v->scale_num * FEMTO / MILLI;

Since the FEMTO and MILLI are of the same base, there might be better to use
them in parentheses. Can you check if that affects code generation? (I hope
compiler is smart enough to prove the above and basically simply multiply the
scale_num.)

> +			s64 scale = DIV_S64_ROUND_CLOSEST(num, v->scale_den);
> +
> +			iio_val_s64_decompose(scale, val, val2);
> +
> +			return IIO_VAL_DECIMAL64_FEMTO;
> +		}
> +		/* Temperature LSB = 1/200 degC; IIO_TEMP wants milli-degC. */
> +		*val = 1000 / 200;

MILLIDEGREE_PER_DEGREE ?

> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


