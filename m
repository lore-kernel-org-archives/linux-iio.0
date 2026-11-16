Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831659;
	b=wMkHmWuRCKjuIb4HBZBn8KRqgpJb6418batOC+l4EIL8973DP22mxrsif/gqlsgfOU6O
	 oIhxZHT8Gu0kpTd3YJq5rEQ0Fy2CntUTtE/1lX0Crxigo9HAp1NBLVcCvaM2xCiDnIlrA
	 Bdfz7Q57uuA/P68YHoqn0pyfX76AO+fi4LTGpQElyII+liMzsv4bpsWcdwar08x/dvJc2
	 uq/8r55JX3HX0iH3TkAY4Ef4XRk4SJx7cz8c9TX6sgu3xlpzsLYJhdD+kGgWi1/fYHy3k
	 8QpGkG9ADzZBVgKn2PUuSF1N/ec9BO/GPseLpzO7S1wrpWKM0qLmmkJsAGkm+myWSQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831659;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=UCBtW4WNXnijqY2UrX0YzgH6qhTWYBzMablcvNyvWSo=;
	b=suVcwk05JDUdTYvYw8BhTuLRMES431mbOoZciT0axXyfeCQLBfXKNEV7NjL4u2+ZDwBD
	 zJs0Wi0Tw6/zH+ecS8xUhKn623nG1rk9s9VyY0XRZmWJ0ktVLdzG2LAIX3oXexa3h2A+2
	 rUNo34jJLR+LUkgv6ExQd1TL8TBCJDYGU8xQ73WI2tBXU7SaUe1NdwY480z+hPLuWzTP+
	 jrlx3ng1ZdGh4OzbEEB5bf2Iyr3Mbrl5FFoYl+SRGFJCU2ZCz3331/R9LEd86Rbl0VuId
	 1wpanW7V3nhlElxV6lCARJdwq4dPXhbOKJ6L1H0EJpuVQ6rHCHE1oVYNes973jsqRRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bIwZ6Z8t;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6416B606A31C;
	Mon, 16 Nov 2026 12:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6416B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bIwZ6Z8t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794831658; x=1826367658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LMUfc6CH4MdDWm++pSdc8W4CjzPaIvkyeQVQxQQL2lM=;
  b=bIwZ6Z8ttydv3vodUnApQIhfI4SLR9mZjVQPuPqrJux7yLao7s/dKd+p
   epJ30LAvXWZjvKDDjOc3JIqsXccovST85UYYw8wuWNwkeTA/BXo3NEgPO
   eOOanIDhEcMtxlXUEmaCfn/os89WS2wUUsGQAgEd6p6o7Fgcz+cfsu4mt
   yTNrv8dM5BqkQ3/rs3ofq1i/EcpBgK3Y8ZYDKzeTSN1lnd8Go6B7ioQQ8
   VShBnmMBunEQK5174PNn0/5x6iepgOTV9ceBJS3GVRc/xssyTZbcl/Cfx
   bqKhzch4ygg7+1wOlxPGs8iWRVD9+tIAdUesSdxJGJ/0P89Lb+02BPNyG
   g==;
X-CSE-ConnectionGUID: nxDnBDzmQU+gWGH0FbAb1A==
X-CSE-MsgGUID: 3jdzR2K+SLGoeqYHYqmFMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3562558"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3562558"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 04:20:57 -0800
X-CSE-ConnectionGUID: Q2b1Ky2PT+65bCPaveAyQw==
X-CSE-MsgGUID: XbqK+JAZRmCF4Ok0bvgUdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="11321924"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 04:20:52 -0800
Date: Mon, 16 Nov 2026 14:20:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshat Chandra <notmissinge@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, andy@kernel.org,
	Lukasz Kulga <lukasz.kulga@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: chemical: Add support for Sensirion SGP41
Message-ID: <avr1IgExD8Rmt4eP@ashevche-desk.local>
References: <20261115055941.362185-1-notmissinge@gmail.com>
 <20261115055941.362185-3-notmissinge@gmail.com>
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
In-Reply-To: <20261115055941.362185-3-notmissinge@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 15, 2026 at 11:29:40AM +0530, Akshat Chandra wrote:
> Add a driver for the Sensirion SGP41 VOC and NOx gas sensor,
> connected over I2C.
> 
> Expose raw VOC and NOx signals as resistance channels and
> allow userspace to write temperature and relative humidity
> compensation values.
> 
> Run sensor conditioning lazily before the first raw measurement.
> Calculate an estimated VOC index and leave NOx-index calculation
> to userspace.

...

> +config SENSIRION_SGP41
> +	tristate "Sensirion SGP41 gas sensor"

Make sure this text is the same or quite similar to what is used in the top
comment and MODULE_DESCRIPTION().

> +	depends on I2C
> +	select CRC8
> +	help
> +	  Say Y here to build I2C interface to support Sensirion SGP41 gas
> +	  sensor
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called sgp41.

...

> +/*
> + * sgp41 - Support for Sensirion SGP41 Gas Sensor

Avoid mentioning name file in the file.

> + * Copyright (C) 2026 Akshat Chandra <notmissinge@gmail.com>
> + *
> + * I2C slave address: 0x59
> + *
> + * Datasheet can be found here:
> + * https://www.sensirion.com/file/datasheet_sgp41
> + *
> + * There are two functionalities supported:
> + *
> + * 1) read raw logarithmic resistance value from sensor
> + *    --> useful to pass it to the algorithm of the sensor vendor for
> + *    measuring deteriorations and improvements of air quality.
> + *    The values can be read from the in_resistance_voc_raw and
> + *    in_resistance_nox_raw.
> + *
> + * 2) calculate an estimated VOC index (0 - 500) and expose it through
> + *    the in_concentration_voc_input attribute.
> + *
> + *    The VOC index is calculated using the raw VOC resistance and a
> + *    configurable calibration bias, exposed through
> + *    in_resistance_voc_calibbias (default 30000).
> + *
> + * The driver does not calculate a NOx index.
> + *
> + * Conditioning runs before the first raw measurement, once per second
> + * for a total of 10 seconds.
> + *
> + * Compensation values for relative humidity and temperature can be
> + * configured through the corresponding output attributes.
> + *
> + * The sensor heater is turned off when the device is removed.
> + */
> +
> +#include<linux/cleanup.h>

Wrong indentation. Also note that you are supposed to follow IWYU principle,
for instance bits.h is absent.

> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>

...

> +struct sgp41_data {

> +	struct device *dev;
> +	struct i2c_client *client;

One of them is redundant.

> +	int rht;
> +	int temp;
> +
> +	int voc_calibbias;
> +
> +	struct mutex lock; /* Protects sensor state and I2C transaction.*/
> +	bool conditioned;
> +	u8 condition_count; /*Counter for conditioning_cmd sent.*/

All over the file you have an issues with indentation.

> +};

...

> +struct sgp41_tg_measure {
> +	u8 command[2];

Is it really 2 independent bytes?

> +	__be16 rht_ticks;
> +	u8 rht_crc;
> +	__be16 temp_ticks;
> +	u8 temp_crc;

This...

> +} __packed;
> +
> +struct sgp41_tg_result {
> +	__be16 voc_res_ticks;
> +	u8 voc_res_crc;
> +	__be16 nox_res_ticks;
> +	u8 nox_res_crc;
> +} __packed;

...and this are the same. Why not to abstract?

// find better names
struct sgp41_result {
	__be16 a_ticks;
	u8 a_crc;
	__be16 b_ticks;
	u8 b_crc;
} __packed;

struct sgp41_tg_measure {
	u8 command[2];
	struct sgp41_result tg;
} __packed;

struct sgp41_tg_result {
	struct sgp41_result tg;
} __packed;

(note, I don't know which approach is better, just a question)?

...

> +static u32 sgp41_exp(int exp, u32 power, u32 rounds)
> +{
> +	u32 x, y, xp;
> +	u32 factorial, divider, xmax;
> +	int sign = 1;
> +	u32 i;
> +
> +	if (exp == 0) {
> +		return 1 << power;
> +	} else if (exp < 0) {
> +		sign = -1;
> +		exp *= -1;
> +	}
> +
> +	xmax = 0x7FFFFFFF / exp;
> +	x = exp;
> +	xp = 1;
> +	factorial = 1;
> +	y = 1 << power;
> +	divider = 0;
> +
> +	for (i = 1; i <= rounds; i++) {
> +		xp *= x;
> +		factorial *= i;
> +		y += (xp >> divider) / factorial;
> +		divider += power;
> +		/* divide when next multiplication would overflow */
> +		if (xp >= xmax) {
> +			xp >>= power;
> +			divider -= power;
> +		}
> +	}
> +
> +	if (sign == -1)
> +		return (1 << (power * 2)) / y;
> +	else
> +		return y;
> +}

This really requires to get some comments to explain the math behind. Also we
have intlog10(), rational_best_approximation(), and other nice math-related
helpers. Can you check if anything may help you with this?

...

> +static void temp_rht_payload(struct sgp41_data *data,
> +			     struct sgp41_tg_measure *tg)
> +{
> +	s64 ticks;
> +	u16 ticks16;
> +
> +	ticks = div_s64((s64)data->rht * 65535, 100000);
> +	ticks16 = (u16)clamp_t(s64, ticks, 0, 65535);
> +	tg->rht_ticks = cpu_to_be16(ticks16);
> +	tg->rht_crc = crc8(sgp41_crc8_table, (u8 *)&tg->rht_ticks, 2,
> +			   SGP41_CRC8_INIT);
> +
> +	ticks = div_s64((s64)(data->temp + 45000) * 65535, 175000);
> +	ticks16 = (u16)clamp_t(s64, ticks, 0, 65535);

No _t variant. And why do you need a casting after that?

> +	tg->temp_ticks = cpu_to_be16(ticks16);
> +	tg->temp_crc = crc8(sgp41_crc8_table, (u8 *)&tg->temp_ticks, 2,
> +			    SGP41_CRC8_INIT);
> +}

...

> +static int sgp41_calc_voc(struct sgp41_data *data, u16 voc_raw, int *voc)
> +{
> +	int x;
> +	u32 exp = 0;
> +	int voc_calibbias;
> +
> +	/* we calculate as a multiple of 16384 (2^14) */
> +	scoped_guard(mutex, &data->lock)
> +		voc_calibbias = data->voc_calibbias;
> +
> +	x = ((int)voc_raw - voc_calibbias) * 106;

Any type (signed or unsigned) shorter than int will be promoted to *signed*
int, no need to have this casting.

> +		/* voc = 500 / (1 + e^x) */
> +	exp = sgp41_exp(x, SGP41_CALC_POWER, 18);

Also look at nexp_u32() and sgp40 driver, perhaps we need to extract something
nice to math library?

> +	*voc = 500 * ((1 << (SGP41_CALC_POWER * 2)) / ((1 << SGP41_CALC_POWER) + exp));
> +
> +	dev_dbg(data->dev, "voc_raw: %d voc_calibbias: %d x: %d exp: %u voc: %d\n",
> +		voc_raw, data->voc_calibbias, x, exp, *voc);
> +
> +	return 0;
> +}

...

> +static int sgp41_run_conditioning(struct sgp41_data *data)
> +{
> +	struct sgp41_tg_measure tg = {
> +		.command = { 0x26, 0x12 },
> +	};
> +	int i;

Why signed?

> +	int ret;

> +	for (i = 0; i < SGP41_COND_ITERATIONS; i++) {

i is not used outside, hence

	for (unsigned int i = 0; i < SGP41_COND_ITERATIONS; i++) {

> +		if (data->condition_count!= i)
> +			i = data->condition_count;
> +
> +		temp_rht_payload(data, &tg);
> +		ret = i2c_master_send(data->client, (const char *)&tg,
> +				      sizeof(tg));
> +		if (ret != sizeof(tg)) {
> +			dev_warn(data->dev,
> +				 "i2c_master_send ret: %d sizeof: %zu\n",
> +				 ret, sizeof(tg));
> +			return ret < 0 ? ret : -EIO;
> +		}

Unnest the conditionals.

> +		data->condition_count++;
> +		msleep(50);

> +		if (i != SGP41_COND_ITERATIONS - 1)
> +			msleep(950);

This is invariant to the loop, also, why so long? Each sleep (especially this
long) must be explained.

> +	}
> +
> +	data->conditioned = true;
> +
> +	return 0;
> +}

...

> +		switch (chan->channel2) {
> +		case IIO_MOD_VOC:
> +			ret = sgp41_measure_raw(data, &voc_raw, &nox_raw);
> +			if (ret)
> +				return ret;
> +
> +			ret = sgp41_calc_voc(data, voc_raw, &voc);
> +			if (ret)
> +				return ret;

> +			*val = voc / (1 << SGP41_CALC_POWER);

			*val = voc >> SGP41_CALC_POWER;

> +		/*
> +		 * calculation should fit into integer, where:
> +		 * voc <= (500 * 2^SGP41_CALC_POWER) = 8192000
> +		 * (with SGP41_CALC_POWER = 14)
> +		 */
> +		*val2 = ((voc % (1 << SGP41_CALC_POWER)) * 244) /
> +			(1 << (SGP41_CALC_POWER - 12));
> +		dev_dbg(data->dev, "voc: %d val: %d.%06d\n",
> +			voc, *val, *val2);
> +		return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}

How many AI agents wrote this all crap?

...

I stop it here, this driver needs much more work. Please, don't rush, take your
time to make it shiny first.

-- 
With Best Regards,
Andy Shevchenko


