Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A82E7375;
	Sun,  6 Sep 2026 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788683698; cv=none; b=nvHdSyKMUoBcwfdADEe6tBwEnNgJrtNSsiNznWqgX/4AMuj2thhdSHa2EJ12FalhtKPQXBEVt7yq71Doa/ZAdc8KvltKLha6Sy4PiZmlPoWQvueN7DRQRANhihs0eaEFKmnKJb4iNVr882PClBv2rXGlEANxXwdIxU835eqz2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788683698; c=relaxed/simple;
	bh=x6dz9PU/6swl7WNblCof3wH0ID9O2ca6k6Gplp3y81k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDn9JPrUnALeyPt85Yk3F3ouo1X5NHVENSWUQUi4FyBBEF1njoe+4ziuiU7Mbqj8l2tzBzaXPitEyDRCtnEfVeESzlSzi74Vvm3TWOQ+JLUHdDRZNJ1SRLt2aX87xVI7KuRmv2giSlLYF+PXhSZN3xyNHK7cPDwCe7vemnTRYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqMMOAlT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqMMOAlT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788683696; x=1820219696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x6dz9PU/6swl7WNblCof3wH0ID9O2ca6k6Gplp3y81k=;
  b=nqMMOAlTTORBBi4uHhRbvXnrC6KxSzzC9P2pFUHzejMLO8Kf/0h8Jw+Y
   XOB7FgDv5RWMbu2FEfndImh9Hp9BBh47XW/Y+LUX0Clm2nlqToTGwCAmi
   M+dyrqOu3VpONLWgT/ZtdhfhwxGbQhRfPzNi/9fQmq6iGB1jj8RgnMEXy
   mLE60qgY1Bc+Gm6mBUCvwwnwqC94NBUszNv9hGzuaZ+mTTRPOY9EKlmt5
   /QBj2f2yhKAgOdPGG4Qj1v5HmbkxK9IyypZWs0gNoAn9Q/wnGivrWxmMb
   FCTmi9LsiwG6kfFxF6yLz5IANS3JvDVDO5j3x3u3zkwgMSyZOTOIHDX4s
   A==;
X-CSE-ConnectionGUID: iLPbVnNqQz60GXPVlXVj5A==
X-CSE-MsgGUID: mEWUKPK/R+SsqOzQBz4SsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11897"; a="91632887"
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="91632887"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 01:34:55 -0700
X-CSE-ConnectionGUID: AMqm6FQbTZyNgWN+sCjm8A==
X-CSE-MsgGUID: 8Du60nT3Sqyvdh7ARG3Bag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="272381931"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.140])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 01:34:50 -0700
Date: Sun, 6 Sep 2026 11:34:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v6 05/17] iio: adc: Add AD7768 and AD7768-4 core support
Message-ID: <ap0lp5THO64olugK@ashevche-desk.local>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
 <20260904-ad7768-driver-v6-5-e4378f946bfb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-ad7768-driver-v6-5-e4378f946bfb@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 04:14:57PM +0200, Janani Sunil wrote:
> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
> Configure supplies, clock and reset, use a custom regmap bus for the SPI
> protocol, and parse the enabled channels and input buffer settings from
> devicetree.
> 
> Connect the converter to an IIO backend for buffered capture with CRC,
> provide a fixed safe wideband sampling configuration and add runtime
> power management.

...

> +#define   AD7768_INTERFACE_CFG_DCLK_DIV_MSK		GENMASK(1, 0)
> +#define     AD7768_INTERFACE_CFG_DCLK_DIV(x)		(4 - ffs(x))

This looks suspicious, do you mean fls() / ilog2()? because ffs() while it may
work, it gets the first set LSB. Also what if 'x' is too high? I guess you can
rework the only user of that to avoid even ffs()/fls()/ilog2().

...

> +#define   AD7768_PREBUF_POS_EN(ch)			BIT((ch) * 2)

Perhaps + 0?

#define   AD7768_PREBUF_POS_EN(ch)			BIT((ch) * 2 + 0)

This will be consistent with the below.

> +#define   AD7768_PREBUF_NEG_EN(ch)			BIT(((ch) * 2) + 1)

Too many parentheses.

...

> +#define AD7768_REG_OFFSET(ch)	(AD7768_REG_OFFSET_BASE + (3 * (ch)))
> +#define AD7768_REG_GAIN(ch)	(AD7768_REG_GAIN_BASE + (3 * (ch)))
> +#define AD7768_REG_PHASE(ch)	(AD7768_REG_PHASE_BASE + (ch))
> +#define __AD7768_4_REG_MAP(ch)	((ch) < 2 ? (ch) : ((ch) + 2))

(ch) in parentheses make no sense here as it will be evaluated twice. If there
is an expression it might lead to a wrong numbers. Either you need more complex
macro to make evaluation happen once, or just be sure no caller uses an
expression in the parameter in which case the parentheses are not required.
With that being said, the other macros against (ch) also can be reconsidered.

...

> +struct ad7768_chip_info {

> +	const char *name;
> +	unsigned int num_channels;
> +	const struct regmap_config *regmap_config;
> +	const unsigned int *available_datalines;
> +	unsigned int num_datalines;
> +	const u8 *chan_map;
> +	u8 prebuf_split;

Even if `pahole` is okay with the layout, I would suggest this one instead

	const char *name;
	const struct regmap_config *regmap_config;
	const unsigned int *available_datalines;
	unsigned int num_datalines;
	unsigned int num_channels;
	const u8 *chan_map;
	u8 prebuf_split;

> +};

...

> +	return (val >> st->chip_info->prebuf_split) &
> +	       GENMASK(st->chip_info->prebuf_split - 1, 0);

Can it use field_get()?

...

> +static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned long channel_mask;
> +	unsigned long standby_mask;
> +	int ret;
> +
> +	channel_mask = ad7768_all_standby_mask(st);
> +	standby_mask = channel_mask & ~*scan_mask;
> +
> +	/*
> +	 * Crystal excitation requires channel 4 on AD7768 or channel 2 on
> +	 * AD7768-4 to remain active.
> +	 */
> +	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
> +		__clear_bit(st->chip_info->num_channels / 2, &standby_mask);
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
> +				 channel_mask, standby_mask);
> +	if (ret)
> +		return ret;
> +
> +	for (unsigned int c = 0; c < st->chip_info->num_channels; c++) {

c --> ch?

> +		if (test_bit(c, scan_mask))
> +			ret = iio_backend_chan_enable(st->back, c);
> +		else
> +			ret = iio_backend_chan_disable(st->back, c);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

...

> +	/*
> +	 * DCLK(min) is ODR * channels per DOUTx * 32. With fast mode
> +	 * (fMOD = MCLK / 4) and x64 decimation, this gives:
> +	 * MCLK / DCLK = 8 * data lines / channels.
> +	 */
> +	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
> +	dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV(dclk_div);

So, this one is (4 - ffs(dclk_div)). If num_channels == 1, this will always give 0.
If num_channels == 2, this might give 0, 8, ... Since ffs(0) implementation is defined
to return 0, this will return... 0! So, tell me how this code may return
anything than 0?

-- 
With Best Regards,
Andy Shevchenko


