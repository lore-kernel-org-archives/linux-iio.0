Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2862BE03B;
	Mon, 23 Feb 2026 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835238; cv=none; b=aY4pCZwA3rzpG6+ghW/6AnsLtsQ4eqPDswTFwlVbtVlP0tg4TvVqA/hYoNhAvgLz1DqW++f8/ZNGOyYOdIjDCHcRX67XdR2zr8IrRVyEXexSi1c4uLVHhmdSMQxcDZaZw8XXcpJiFjhccahCsFLPaWUyXN7hjV54ySBtjYFEmxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835238; c=relaxed/simple;
	bh=LsmI424WiJJA2tfV9e6vCQTv/dfgCX03rEax+429jcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocYgoO0DJP5chGtD032HQXS6u6EXWCNmB0tzcdhsrwYzbAXifA27nEYYtzx8N+qUT/S7fHwEoxtkXLN8BMZD5vbBl+3u2+tuRToXoQ1/vIbuL6it7zIPIz4cBggdxsCcFezdrZlCatqox/kJlm0M6NmR4FK/koR7FITYIIv1+m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPz9xOXv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPz9xOXv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771835235; x=1803371235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LsmI424WiJJA2tfV9e6vCQTv/dfgCX03rEax+429jcg=;
  b=XPz9xOXvaeobyMVQrhkElGecmX2CfCTv97LTP9wLsgP09T28gv+D7+0Z
   AV4R2fbqQ7Vd0CcgqBgMW5o2Ae9e2j8PaATLu4Wnnxu7+a/H/gkRwnGX8
   Rkkx3QcAWWRpb+WVLP5a+9ri6rQMikLgLUfviK+GuD4+2WlCCn5V00Qg6
   QGLQoBxLse8pcV5ZGWxwWm1jAFEi/YwdkvzTUy/Z0IR48j6NFh8APOH5Z
   O0hnsbi5IkK49n98zYNg5iLzpAKIkerPyeOHlIbCW7M+6etcT4T5TBRMx
   yLXTk9BulnRE03B59/UWdKi/hSt5OFjTb7TPFc6Iq5Fwt1Z2LXooF55HH
   w==;
X-CSE-ConnectionGUID: gUWuc6L9TzmEkd+N3da8og==
X-CSE-MsgGUID: cfo856C/RpGOaqlNBF3uxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="90229990"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="90229990"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:27:14 -0800
X-CSE-ConnectionGUID: yntxmJtzTXmUsr+wU8s/XA==
X-CSE-MsgGUID: fcNdBibITBSqiQ0ES6bxJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="253208434"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:27:12 -0800
Date: Mon, 23 Feb 2026 10:27:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 3/8] iio: frequency: ad9910: add simple parallel port
 mode support
Message-ID: <aZwPXRadocNL9rQs@smile.fi.intel.com>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <20260220-ad9910-iio-driver-v1-3-3b264aa48a10@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-ad9910-iio-driver-v1-3-3b264aa48a10@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 04:46:07PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Add parallel port channel with frequency scale, frequency offset, phase
> offset, and amplitude offset extended attributes for configuring the
> parallel data path.

...

> +	case AD9910_PP_FREQ_SCALE:
> +		if (val32 > BIT(15) || !is_power_of_2(val32))
> +			return -EINVAL;


> +		val32 = FIELD_PREP(AD9910_CFR2_FM_GAIN_MSK, ilog2(val32));

My gut feelings here that this can be simplified to avoid some checks,
or make it more like an expression.

In any case this is an edge between code readability and the size of
the generated binary object.

> +		ret = ad9910_reg32_update(st, AD9910_REG_CFR2,
> +					  AD9910_CFR2_FM_GAIN_MSK,
> +					  val32, true);
> +		break;

...

> +static ssize_t ad9910_pp_attrs_read(struct iio_dev *indio_dev,
> +				    uintptr_t private,

Hmm... Is it a requirement to have uintptr_t? Linus was clear that this is
the type that shouldn't be used in the kernel. unsigned long does the same.

Jonathan, is there any plans to get rid of uintptr_t in IIO?

> +				    const struct iio_chan_spec *chan,
> +				    char *buf)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	int vals[2];
> +	u32 tmp32;
> +	u64 tmp64;

> +	guard(mutex)(&st->lock);

I don't see the need to have vals assignment followed by iio_format_value()
call be under the lock. OTOH, I understand that this makes code simple...

> +	switch (private) {
> +	case AD9910_PP_FREQ_OFFSET:
> +		tmp64 = (u64)st->reg[AD9910_REG_FTW].val32 * st->data.sysclk_freq_hz;
> +		vals[0] = upper_32_bits(tmp64);
> +		vals[1] = upper_32_bits((u64)lower_32_bits(tmp64) * MICRO);
> +		break;
> +	case AD9910_PP_PHASE_OFFSET:
> +		tmp32 = FIELD_GET(AD9910_POW_PP_LSB_MSK,
> +				  st->reg[AD9910_REG_POW].val16);
> +		tmp32 = (tmp32 * AD9910_MAX_PHASE_MICRORAD) >> 16;
> +		vals[0] = tmp32 / MICRO;
> +		vals[1] = tmp32 % MICRO;
> +		break;
> +	case AD9910_PP_AMP_OFFSET:
> +		tmp32 = FIELD_GET(AD9910_ASF_SCALE_FACTOR_PP_LSB_MSK,
> +				  st->reg[AD9910_REG_ASF].val32);
> +		vals[0] = 0;
> +		vals[1] = (u64)tmp32 * MICRO >> 14;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(vals), vals);
> +}

...

> +static ssize_t ad9910_pp_attrs_write(struct iio_dev *indio_dev,
> +				     uintptr_t private,
> +				     const struct iio_chan_spec *chan,
> +				     const char *buf, size_t len)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	int val, val2;
> +	u32 tmp32;
> +	int ret;
> +
> +	ret = iio_str_to_fixpoint(buf, MICRO / 10, &val, &val2);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (private) {
> +	case AD9910_PP_FREQ_OFFSET:
> +		if (val < 0 || val >= st->data.sysclk_freq_hz / 2)

in_range() ?

> +			return -EINVAL;
> +
> +		tmp32 = ad9910_rational_scale((u64)val * MICRO + val2, BIT_ULL(32),
> +					      (u64)MICRO * st->data.sysclk_freq_hz);
> +		ret = ad9910_reg32_write(st, AD9910_REG_FTW, tmp32, true);
> +		break;
> +	case AD9910_PP_PHASE_OFFSET:
> +		if (val != 0 || val2 < 0 || val2 >= (AD9910_MAX_PHASE_MICRORAD >> 8))

		if (val)
			return -EINVAL;

		if (!in_range(val2, ...))

> +			return -EINVAL;

?

> +		tmp32 = DIV_ROUND_CLOSEST((u32)val2 << 16, AD9910_MAX_PHASE_MICRORAD);
> +		tmp32 = min(tmp32, AD9910_POW_PP_LSB_MAX);
> +		tmp32 = FIELD_PREP(AD9910_POW_PP_LSB_MSK, tmp32);
> +		ret = ad9910_reg16_update(st, AD9910_REG_POW,
> +					  AD9910_POW_PP_LSB_MSK,
> +					  tmp32, true);
> +		break;
> +	case AD9910_PP_AMP_OFFSET:
> +		if (val != 0 || val2 < 0 || val2 >= (MICRO >> 8))
> +			return -EINVAL;
> +
> +		tmp32 = DIV_ROUND_CLOSEST((u32)val2 << 14, MICRO);
> +		tmp32 = min(tmp32, AD9910_ASF_PP_LSB_MAX);
> +		tmp32 = FIELD_PREP(AD9910_ASF_SCALE_FACTOR_PP_LSB_MSK, tmp32);
> +		ret = ad9910_reg32_update(st, AD9910_REG_ASF,
> +					  AD9910_ASF_SCALE_FACTOR_PP_LSB_MSK,
> +					  tmp32, true);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret ?: len;
> +}

...

> +static const struct iio_chan_spec_ext_info ad9910_pp_ext_info[] = {
> +	AD9910_EXT_INFO("frequency_scale", AD9910_PP_FREQ_SCALE, IIO_SEPARATE),
> +	AD9910_PP_EXT_INFO("frequency_offset", AD9910_PP_FREQ_OFFSET),
> +	AD9910_PP_EXT_INFO("phase_offset", AD9910_PP_PHASE_OFFSET),
> +	AD9910_PP_EXT_INFO("scale_offset", AD9910_PP_AMP_OFFSET),
> +	{ },

Please, use IIO accepted style for terminator entry.
(Yes, for the consistency's sake it might require another cleanup patch.)

> +};

...

> +		val = val ? 1 : 0;

Replaces this...

> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PARALLEL_PORT:
> +			tmp32 = FIELD_PREP(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK, val);

...by  !!val here.

> +			return ad9910_reg32_update(st, AD9910_REG_CFR2,
> +						   AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
> +						   tmp32, true);

-- 
With Best Regards,
Andy Shevchenko


