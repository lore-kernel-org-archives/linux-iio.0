Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9513D3CEB;
	Mon, 31 Aug 2026 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164318; cv=none; b=mUK7xbzq59qIZKHOuriOKI1pL9OBkR8TJduUNauTYAiopDbxNpPL4fnXbpL8hY8ZrKnquuggdntWoYteFSsrj5D5Igv7HnT824h57BJDRlqMz0bHzmT0v/rVricVQxwX7vFUvw7XoOIfqJSSbfnEnsgUYGkUp2XplEgZ3f9gW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164318; c=relaxed/simple;
	bh=CW0y3GMC50f3xERbCKaWuwboYCDhm1mjfqgBlsAIx1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imcX8XxcGIFxwoybHbvyBcdmVjzy5TSgo7uH7Pnjgw+5alxJQ/YT+vUUPG5z2FBnRhU02oiGY561oHngnS7zOQwHKNftKHiqBhjeinAGIO5Vx/raU6cG79v2m6bgf3XYiDakJhtRZfKkjf7cPdEHqBUbd2v8aPO5dKMcIXAsMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCi01Ysg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCi01Ysg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788164316; x=1819700316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CW0y3GMC50f3xERbCKaWuwboYCDhm1mjfqgBlsAIx1Y=;
  b=BCi01YsgnZ0UT6Zpb3sQzH+WsX0EsXSU5z6SqmlU+AFWTCgGiLtiQNt/
   u0xXS/3oHYcCMxg7UOzkI+GwMVzORXJUcl1J/4v23A3rrGKJ+cl+haRLb
   TuFMaoePZKXhX4au+jacI7wqy+euQuwyDViD3mMTB2AQf9S2SjSloRsbj
   UgpWCxahlWlwGz3M69rHo4tF7o6/HZlsNhZGS6e52Gm+gWBQzmVjl0L1G
   8u6XOxDVc5iHs7xYXsNixnXFFECcZFzkfSVXRBZmoFgLycxawv3xjvvRG
   /9hJ1r2vma2lo6TXu97DqjP5SQxqE7FurBpguenhjO1X8dDv9afBephBo
   Q==;
X-CSE-ConnectionGUID: WdR7F+0NRyqAAA45/cNnOQ==
X-CSE-MsgGUID: BnESkLs+R12MGZ5Nrhh93Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92252095"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="92252095"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:18:35 -0700
X-CSE-ConnectionGUID: OXOY43HIQ/6ZT7LXUZPSiw==
X-CSE-MsgGUID: WexrKJwfQDS9neIQCYZW+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="268175789"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:18:31 -0700
Date: Mon, 31 Aug 2026 11:18:28 +0300
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
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v5 09/20] iio: adc: ad7768: Configure channel sampling
 profiles
Message-ID: <apU41FobKLE4c6Mi@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-9-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-ad7768-driver-v5-9-e33ca6f841a2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:30:32PM +0200, Janani Sunil wrote:
> At buffered capture setup, select the fastest compatible power mode for
> the enabled channel rates. Group channels into the two hardware mode
> profiles and program their decimation, mode selection, and data clock.

...

> +static int ad7768_set_lowest_noise_mode(struct ad7768_state *st,
> +					const unsigned long *scan_mask)
> +{
> +	/*
> +	 * The output data rate ranges overlap between the power modes. At a
> +	 * common ODR, the faster mode has lower noise, so prefer the fastest
> +	 * mode that supports every enabled channel.
> +	 */
> +	for (unsigned int mode_idx = ARRAY_SIZE(ad7768_power_modes);
> +	     mode_idx-- > 0;) {

This is rather unusual pattern, better to have this as simple as

	unsigned int mode_idx = ARRAY_SIZE(ad7768_power_modes);

	while (mode_idx --) {

> +		bool supported = true;
> +		unsigned int channel;
> +
> +		for_each_set_bit(channel, scan_mask,
> +				 st->chip_info->num_channels) {
> +			if (!ad7768_find_freq_config(st, mode_idx,
> +						     st->ch_freq[channel])) {
> +				supported = false;
> +				break;
> +			}
> +		}
> +
> +		if (supported)
> +			return ad7768_set_power_mode(st, mode_idx);
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
>  {
> +	unsigned int mode_freq[AD7768_NUM_CHANNEL_MODES] = { };
> +	bool mode_used[AD7768_NUM_CHANNEL_MODES] = { };
>  	struct ad7768_state *st = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
>  	unsigned long channel_mask;
>  	unsigned long standby_mask;
> +	unsigned int max_freq = 0;

Split assignment, also see below.

> +	unsigned int c;
>  	int ret;

...

	max_freq = 0;

> +	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
> +		if (!mode_used[mode])
> +			continue;
> +
> +		ret = ad7768_set_mode_decimation(st, mode_freq[mode], mode);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_clear_bits(st->regmap, AD7768_REG_CH_MODE(mode),
> +					AD7768_CH_MODE_FILTER_TYPE_MSK);
> +		if (ret)
> +			return ret;
> +
> +		max_freq = max(max_freq, mode_freq[mode]);
> +	}
> +
> +	ret = ad7768_set_clk_divs(st, max_freq);
> +	if (ret)
> +		return ret;
> +
> +	return ad7768_sync(st);
> +}

-- 
With Best Regards,
Andy Shevchenko


