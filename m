Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B5212FAD;
	Mon, 24 Aug 2026 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553823; cv=none; b=ihYSh1Srb2d5fFemfjOi8jlz+Q35aZW9Nhgc6TmtQRnAteeag20ZGVi85t89ycp5EU4uHGAtQmI4IeYPyXOvfhJEdMkcZxbGjlM+uCv9iNmOb8lzwwV8DHM4VSfC/Dr0hvq0dqbVDnhXe9XN9e2GVSDlYQGjX5Pi9TP/Vfuk3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553823; c=relaxed/simple;
	bh=H/fQcrk7c3SnAmeYuIsx7bdCGnHpk5GYqdoF0xGSUP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckS+gah/B0kOCqquQ6Sb2gAbTW3NiklcAHk2RhbupEj5aL4ihUArkL9Cwhd7solb62aqFyDH1k11euHAxzhq4MJs5HAVcgNmV0MvuITNLHeqyuvByHniJkWZUzb0/Si9OKCabrcqUkiyDpVmS5PsqThoZeJioQLg+ZgucdLV7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1laeqe5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1laeqe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787553821; x=1819089821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H/fQcrk7c3SnAmeYuIsx7bdCGnHpk5GYqdoF0xGSUP4=;
  b=U1laeqe5AW1/vKVLHQytSWJ9RtJ5eLJT+yWhUAM6zTSfjcXTRjEJtcU4
   uqOJnSphEinhRdVsDobSt0+5Rv/34NlzENL2RhjtXY7lzyRs05CPf9OYZ
   2O5c2DkK3OxMivWXJL37ghEbR0S/noS3e+axk714Zl8AsUN35szUdCBel
   9YjnoGyC/O4Il0FoVLWpy6QJMOORs76VvV4equ+R8FziyGykurgXn8804
   rS7s6tLYjXl9HADQ0myzE4Rq1rOKxpHELgrb6qK6MQbB/0qth9TdA1BLL
   fQakHbQjUQkJyc/UHFpg61M9hTsQvGPJ3wBV1tOJ506ec5fKKzgr23CRF
   Q==;
X-CSE-ConnectionGUID: kPl1JY9IT4uRuih6PVBCfg==
X-CSE-MsgGUID: pV0MaYNhRiCutylN12anZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98670350"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98670350"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 23:43:40 -0700
X-CSE-ConnectionGUID: JT0yDN/HRaOrhrDbjvyvyA==
X-CSE-MsgGUID: S5fBD4wRRu6pxlHZJ0of3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="262633266"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 23:43:35 -0700
Date: Mon, 24 Aug 2026 09:43:33 +0300
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
Subject: Re: [PATCH v4 06/14] iio: adc: ad7768: Add configurable sampling
 modes
Message-ID: <aovoFUBRRpZZPILZ@ashevche-desk.local>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-6-bb8fbd06d4eb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-ad7768-driver-v4-6-bb8fbd06d4eb@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 21, 2026 at 04:06:59PM +0200, Janani Sunil wrote:
> Derive the available output data rates from MCLK and expose per-channel
> sampling frequency and filter controls.
> 
> Select the fastest compatible power mode for the enabled channels and
> map matching sampling frequency and filter combinations onto the two
> hardware channel profiles. Configure the data clock divider and wait for
> the selected filters to settle before capture.

...

> -static int ad7768_configure_capture(struct ad7768_state *st)
> +static int ad7768_set_power_mode(struct ad7768_state *st, unsigned int mode)
>  {
> -	unsigned int dclk_div_reg;
> -	unsigned int mode_config;
> -	unsigned int dclk_div;
> +	unsigned int mode_idx;
>  	int ret;

> +	for (mode_idx = 0; mode_idx < ARRAY_SIZE(ad7768_power_modes);
> +	     mode_idx++) {

I would dare to put these on a single line.

> +		if (ad7768_power_modes[mode_idx].mode == mode)
> +			break;
> +	}
> +
> +	if (mode_idx == ARRAY_SIZE(ad7768_power_modes))
> +		return -EINVAL;

But this whole piece looks quite similar to
ad7768_freq_supported_in_any_mode(). Can that be refactored to cover
this and that cases?

...

> -static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
> -				   const unsigned long *scan_mask)
> +static bool ad7768_freq_supported(const struct ad7768_state *st,
> +				  unsigned int mode_idx, unsigned int freq)

Can you try to make the patch changes cleaner in terms what is put where,
so we will see less of such a mess in the diff? Perhaps it will require
to split series even more.

> +{
> +	for (unsigned int i = 0;
> +	     i < st->avail_freq[mode_idx].n_freqs; i++) {

A single line.

> +		if (freq == st->avail_freq[mode_idx].freq_cfg[i].freq_hz)
> +			return true;
> +	}
> +
> +	return false;
> +}

...

> +		mask = ad7768_channel_mode_mask(st, c);
> +		ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE_SEL,
> +					 mask, mode ? mask : 0);
> +		if (ret)
> +			return ret;

assign_bits()?

...

> +	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES;
> +	     mode++) {

One line.

> +		unsigned int filter_config;
> +
> +		if (!mode_used[mode])
> +			continue;
> +
> +		ret = ad7768_set_mode_decimation(st, mode_freq[mode], mode);
> +		if (ret)
> +			return ret;
> +
> +		filter_config = FIELD_PREP(AD7768_CH_MODE_FILTER_TYPE_MSK,
> +					   mode_filter[mode]);
> +		ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(mode),
> +					 AD7768_CH_MODE_FILTER_TYPE_MSK,
> +					 filter_config);
> +		if (ret)
> +			return ret;
> +
> +		max_freq = max(max_freq, mode_freq[mode]);
> +	}

...

> +	/*
> +	 * Start in fast mode; capture setup may select another
> +	 * compatible mode.
> +	 */
> +	scoped_guard(mutex, &st->lock) {
> +		ret = ad7768_set_power_mode(st,
> +					    AD7768_POWER_MODE_POWER_MODE_FAST);
> +	}

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set power mode\n");

Move this inside the {}.

>  static int ad7768_reset(struct ad7768_state *st)

...

Maybe it's only me, but this is completely unreviewable change (at least
by a human being). Please, refactor, split this to 5+ patches or so and
make each of them more or less reviewable.

-- 
With Best Regards,
Andy Shevchenko


