Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F02DB7B8;
	Mon, 31 Aug 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163789; cv=none; b=XpUk4s49QS39KXPzxazHFkOnU0gE/3l6AUWRNnr5c3I1LaTUOEqV27DA3C1lL1BJwhG9ELt3maDnfu7oi3FuOKEOY96baTMtqErGg3izpE2CdQPRASnUFki+9oEcdAoZ3dFSr0BpUQslJDrBoeQPmzC/p/ZiVsrjE2EsBEFjvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163789; c=relaxed/simple;
	bh=EXnz4UJb8ZmHDgh2E82zE8nu9XWep7z0mFdwx/EeODQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTh/5QqP4LPerSx00ISmITfrQqdvfjel8fIpsD7fxxUK/DcVwV+9c9sV7WHZIw1329R1e/WwQcZ4wxsFQMwRPgOZM9yjsl5NjpOQkq/6CdPDY3/6lKrp6CCO1I+mSJC+uLXuT/BIl4AFfdM+Y+mK0grzOkv9KlpSsLjQclzpMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXGzmDqW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXGzmDqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788163788; x=1819699788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EXnz4UJb8ZmHDgh2E82zE8nu9XWep7z0mFdwx/EeODQ=;
  b=mXGzmDqWZKfFbWnmtUdjvm7cTtGmqZMVUQ1SFYtbGFs4dMOMjizs/76a
   oihlWipxY5c9vi6s2rIIlQ5EysvXKrc5WVqa5flc80NeCQvtgNCcqL5hl
   HbVhzmkVvOljZmKs6ofsHeHYvHRjvf3peiyav7v2dSGtj8VenabId1IcY
   bc/mxCo6n8GJmNiLXfXRT5OzKoZbU+fRU7y0rG78AWEvvLaiqmNbTTMWr
   gd9Oaivcy/ajPPQWA1VaJQhO9qvaOegzzAwzb1390w2BOoxXHrg5YchRt
   t1rHuiLwhO9N9vvrZYC86DZYQTAkVHlWnIALtaoVPpw8GsM2v/uHkOIAh
   Q==;
X-CSE-ConnectionGUID: XpdmVuxxRXOwVlcfeRnPVw==
X-CSE-MsgGUID: 8euqMg7xS7WEkT7iSYkmJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="98901128"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="98901128"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:09:47 -0700
X-CSE-ConnectionGUID: 1Esp0D5mSj+Yq0GhUveGNg==
X-CSE-MsgGUID: couaheZHSjaD6OCfTDrStA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="272526641"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:09:41 -0700
Date: Mon, 31 Aug 2026 11:09:38 +0300
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
Subject: Re: [PATCH v5 08/20] iio: adc: ad7768: Derive output data rates
Message-ID: <apU2wvlPtlZtxhPF@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-8-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-ad7768-driver-v5-8-e33ca6f841a2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:30:31PM +0200, Janani Sunil wrote:
> Derive valid output data rates from the master clock, power mode and
> decimation ratio.
> 
> Replace the fixed x64 decimation and open-coded DCLK divider in
> ad7768_configure_capture() with the derived default output rate and the
> new decimation and clock-divider helpers. Select the maximum rate
> supported by the configured data interface for the initial capture
> configuration.

...

> +static int ad7768_set_clk_divs(struct ad7768_state *st, unsigned int freq)
> +{
> +	const struct ad7768_freq_config *freq_cfg;
> +	unsigned int mclk, dclk, dclk_div;
> +	unsigned int chan_per_doutx;
> +	unsigned int dclk_div_reg;
> +
> +	freq_cfg = ad7768_find_freq_config(st, st->power_mode_idx, freq);
> +	if (!freq_cfg)
> +		return -EINVAL;
> +
> +	mclk = clk_get_rate(st->mclk);
> +	chan_per_doutx = st->chip_info->num_channels / st->datalines;
> +	if (!chan_per_doutx)
> +		return -EINVAL;
> +
> +	dclk = freq_cfg->freq_hz * AD7768_SAMPLE_SIZE * chan_per_doutx;
> +	if (!dclk || dclk > mclk)
> +		return -EINVAL;

SAMPLE_SIZE must not be 0, the chan_per_doutx is checked above, so this check
is about freq_hz, do we need it? If yes, make it better written

	freq_cfg = ad7768_find_freq_config(st, st->power_mode_idx, freq);
	if (!freq_cfg)
		return -EINVAL;
	// Do we really need this?
	if (!freq_cfg->freq_hz)
		return -EINVAL;
	...
	dclk = freq_cfg->freq_hz * AD7768_SAMPLE_SIZE * chan_per_doutx;
	if (dclk > mclk)
		return -EINVAL;

> +	/* Set the divider to the next-lowest supported power of two. */
> +	dclk_div = DIV_ROUND_CLOSEST(mclk, dclk);
> +	if (dclk_div > AD7768_MAX_DCLK_DIV)
> +		dclk_div = AD7768_MAX_DCLK_DIV;
> +	else
> +		dclk_div = rounddown_pow_of_two(dclk_div);

It's okay as is, but just to show that this can be shorten to

	dclk_div = DIV_ROUND_CLOSEST(mclk, dclk);

	/* Set the divider to the next-lowest supported power of two. */
	dclk_div = rounddown_pow_of_two(min(dclk_div, AD7768_MAX_DCLK_DIV));

> +	dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV(dclk_div);
> +
> +	return regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
> +				  AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
> +				  FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
> +					     dclk_div_reg));
> +}

...

> +static void ad7768_set_available_sampling_freqs(struct ad7768_state *st)
> +{

	unsigned int n_power_modes = ARRAY_SIZE(ad7768_power_modes);

> +	unsigned int mclk = clk_get_rate(st->mclk);
> +
> +	for (unsigned int mode_idx = 0;
> +	     mode_idx < ARRAY_SIZE(ad7768_power_modes); mode_idx++) {

	for (unsigned int mode_idx = 0; mode_idx < n_power_modes); mode_idx++) {

> +		struct ad7768_avail_freq *avail_freq;
> +
> +		avail_freq = &st->avail_freq[mode_idx];

> +		for (unsigned int dec = ARRAY_SIZE(ad7768_dec_rate); dec > 0;
> +		     dec--) {

Leave this on a single line, it's okay to have it slightly bigger. However,
taking into account the below I would rather do it differently, id est

		unsigned int dec = ARRAY_SIZE(ad7768_dec_rate);
		struct ad7768_avail_freq *avail_freq;
		...
		while (dec--) {

> +			struct ad7768_freq_config *freq_cfg;
> +
> +			freq_cfg = &avail_freq->freq_cfg[avail_freq->n_freqs++];
> +			freq_cfg->dec_rate = dec - 1;

			freq_cfg->dec_rate = dec;

> +			freq_cfg->freq_hz = mclk /
> +				(ad7768_dec_rate[dec - 1] *
> +				 ad7768_power_modes[mode_idx].mclk_div);

This style is not good, better to take longer lines, but split on logical
boundaries. I also would go with a temporary variable

			// can be shortened to 'd' if you wish
			unsigned int div = ad7768_power_modes[mode_idx].mclk_div;
			...

			freq_cfg->freq_hz = mclk / (ad7768_dec_rate[dec] * div);
> +		}
> +	}
> +
> +	/* One DOUT line cannot carry the AD7768 fast-mode x32 output rate. */
> +	if (st->datalines == 1 &&
> +	    st->chip_info->num_channels == AD7768_MAX_CHANNEL)

> +		st->avail_freq[ARRAY_SIZE(ad7768_power_modes) - 1].n_freqs--;

		st->avail_freq[n_power_modes - 1].n_freqs--;

> +}

-- 
With Best Regards,
Andy Shevchenko


