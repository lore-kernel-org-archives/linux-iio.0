Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462753;
	b=PulNv+yoZ4Uw9nidSrYMGV3ICNKyn6nHXJ8TgwSxlcu9fGd/8B/jaN60WGoNmo/P4q5O
	 qflafuHdVydOrtrcBVt9FurWU30i9svtl4kA8TvE7f2Q5AdeR6mksN59rQvvpcm+CSChY
	 XDfY2E9GtnjCT8ZQBTrZC3vjnGC/cbQn0F4pJ504W5K3IS6ANxon9T5JDIEnH9YLnw0n/
	 QHpXgTfj1lC8CdJ5dzcUgvONJmrlU5D9m7c5uBvpNaRAFrVp9pu2x1379G1+yEExaWQ+D
	 4ryPG4Za5PIEopbDeoiJA5XrsW3c6bIQKBuA40HQYU9nAvxlfsI2g6Qsg8sru68TYbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462753;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=34EGKTnLY/HPChbZIP1a/E1PkPQAWEmn990CfdJx9aY=;
	b=cBhX4y4ZuQAlGQXXWI20KR4xeicmdycnZ8YiSPfT3PMISTFVmY474/6c7LqHyY9Ztgfo
	 M86n2Usp5oR8xcudTPUJGHyymA6XrrSAIrzeRV14ZISY2g10GyOaViSunbaFju5m9xLIk
	 H9wjvcm565GXW4Ghd14lSSjZ8nn5J2vKSDQ5SHripRkh7s6Xmprm/FR8CudAncuoiPG6o
	 x2MpLP/BcchVpFn9FPPBOG2/U3luW+YqgOwyrrigsXP5UhHX3U1T2v0kFYFk0iGfWsz97
	 j9/rRyKWv81H8HoR3LUOOUbz33SeNmtjtiueAGiiM/aQIgOy65MefHJHrYcZ5f+aJiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oc0c7b7d;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E061606A31E;
	Mon, 23 Nov 2026 19:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E061606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oc0c7b7d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795462754; x=1826998754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A6ZVYci0gc9CY9yLPxh4/WLRqZrpG0U44J2uCbx7vF0=;
  b=Oc0c7b7dVO/VGOt2j9dnhWcQ23PRX33QfgtGoyJvmQsnMhhNfGOGnpx2
   6QkLjjYx3sNOvvOjViL8jfNiGwBz6vcTfF4Nbzs7npV/XcUFoIcd+Ds8+
   iU1bvXCtowgWY2FiD3RjGXMWTZIoZDMN/NGxJIM6ENaepFUOVTcAOvnF+
   zvvsMNxdptqm3eJ7kus+ckxe7HyMy0Lxkqb32JoLc2kgJahel5/D63D0x
   29fC52rt6gAfhUoR/s3AbhmG8BVwNK7wFQrmVHKX8eQKU/o4cs5S0tffX
   4wm/+cyOMlviSQEUqsvUZFtCCzp4cj4lijKD+G0+E2oUfP5yYsi+cl0ho
   g==;
X-CSE-ConnectionGUID: jVt91fXzTm+nxfW/Dyf+xg==
X-CSE-MsgGUID: s4Ulm2pgQASkEjw31fhOuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4177432"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4177432"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:39:12 -0800
X-CSE-ConnectionGUID: J2UXgM7bSFCGRuiqiCNmbA==
X-CSE-MsgGUID: 6SwAljXXQHWlUDab4x1lmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11545568"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:39:02 -0800
Date: Mon, 23 Nov 2026 21:39:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH v7 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <awSWVMMYN2xsDH7u@ashevche-desk.local>
References: <20261123-topic-sm8x50-iio-max34417-adc-v7-0-d8f87edc5086@linaro.org>
 <20261123-topic-sm8x50-iio-max34417-adc-v7-3-d8f87edc5086@linaro.org>
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
In-Reply-To: <20261123-topic-sm8x50-iio-max34417-adc-v7-3-d8f87edc5086@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 06:47:46PM +0100, Neil Armstrong wrote:
> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver support
> getting the channels voltage, average power, accumulated average
> power and energy over an I2C/SMBUS serial interface.
> 
> The MAX34417 datasheet only specified on how to calculate the
> accumulated average power, but with the Sample Per Second rate
> we can easily get accumulated Energy in Joules.
> 
> By default the IIO driver only supports single-shot Voltage
> and Power sensing, but the accumulation can be enabled by
> enabling the Energy IIO channel which then enables the
> Continuous Accumulation Mode.
> 
> The counter is common to all channels, so when reading a single
> channel we will copy all accumulators to registers, so in order
> to permit reading individual channels we must accumulate the
> other channels in the driver when Continuous Accumulation Mode
> is enabled.

...

> +#define MAX34417_MIN_RSENSE_UOHM		(1 * MILLI)
> +#define MAX34417_MAX_RSENSE_UOHM		(100 * MILLI)
> +#define MAX34417_DEFAULT_RSENSE_UOHM		(1 * MILLI)

Oh, it's micro, but you use MILLI. Also even in macros we nowadays want to see
the unit as defined in SI.

#define MAX34417_MIN_RSENSE_uOhm		(1 * (MICRO / MILLI))
#define MAX34417_MAX_RSENSE_uOhm		(100 * (MICRO / MILLI))
#define MAX34417_DEFAULT_RSENSE_uOhm		(1 * (MICRO / MILLI))

Alternatively add another patch to start Ohm multipliers in units.h

#define MICROOHM_PER_MILLIOHM		1000

I will Ack it.

...

> +struct max34417_data {
> +	struct iio_dev *indio_dev;

Useless. You have it already available when calling the function that uses it.

> +	struct regmap *regmap;
> +	struct mutex lock;
> +	u32 input_correction[MAX34417_CHANNEL_COUNT];
> +	const char *input_label[MAX34417_CHANNEL_COUNT];
> +	s64 acc_power[MAX34417_CHANNEL_COUNT];
> +	s64 acc_count;
> +	bool overflow;
> +	ktime_t last_update;
> +	bool cam_mode;

Are the booleans protected by the same lock? If not, just group them, it closes
the gap, if yes, group and possibly make a bitfield, then they will occupy only
a single byte.

> +};

...

> +static int max34417_read_energy(struct max34417_data *max34417,
> +			       const struct iio_chan_spec *chan,
> +			       int *val, int *val2)
> +{
> +	struct regmap *map = max34417->regmap;
> +	s64 acc_power;
> +	s64 delta_us;
> +	int rc;
> +
> +	if (max34417->cam_mode && max34417->overflow)
> +		return -EOVERFLOW;
> +
> +	/* Sleep up to 1msec to make sure we have a measurement cycle done */

ms or millisecond

> +	delta_us = ktime_us_delta(ktime_get(), max34417->last_update);
> +	if (delta_us >= 0 && delta_us < (1 * USEC_PER_MSEC))
> +		fsleep((1 * USEC_PER_MSEC) - delta_us);
> +
> +	/* Move the data to the SMBus registers */
> +	rc = regmap_write(map, MAX34417_UPDATE_REG, 1);
> +	if (rc)
> +		return rc;
> +
> +	/* Save the timestamp for the next read */
> +	max34417->last_update = ktime_get();
> +
> +	/* Retrieve all channels to avoid missing data for other channels */
> +	rc = max34417_save_accumulators(max34417);
> +	if (rc)
> +		return rc;
> +
> +	/* Get current channel power */
> +	acc_power = max34417->acc_power[chan->channel];
> +
> +	iio_val_s64_decompose(acc_power, val, val2);
> +
> +	return IIO_VAL_INT_64;
> +}

-- 
With Best Regards,
Andy Shevchenko


