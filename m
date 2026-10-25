Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792957834;
	b=XqyAxZVcWy3PC+gLa+mbm/WI0aGLlcs/zcngHkzC3CeG50gKgMJGkShTqqML0ef+3D2k
	 uIPpvV0v0y6SBPysY5WR5gDLmsEPBix5kOVUJ3Zn0TXKR14d3vv1lsYMPpghOqh5uxizM
	 ESqUn+rfXMdPH49ydykvF2jkoCs6q3m5Eb6p+UiLPst6WR2aMxSm1zUzi1RF5v8Hm+7Lb
	 7LnMx+efvVUPf+Ekwn7B4RkcGnWkLOcgsZrb9+mopndlsmuZwfmLK+wAgukmjoozsnK78
	 pod3TrTGZyWjwgKBcHBQweTGDsKESC1Mtueid2MjKMrm3qOQ7y3EAqRgKrkjJrbHrYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957834;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=gkId7z4rrADgLQjZjZcyjZrL4xqZXe9u/OW++kS1m38=;
	b=5Q1fNZSA50+xbLVF56u5toswvjyw1ACltay/HhkqfcaAr244jgU7jRBLzOt98CRWjaHV
	 u9SRmzTCSWFUNuRQbrMAM2yNc0h74oxXhpaYYqsFgjGQ8EcwPYaHNCz1YKvsJEeqmaGn7
	 MxB86yGuGRFKQLeKpyXFp1TCyIF5kfnxiPcvCeXXZcjJNfNj0zh2QC0chpE2DZGucp1SS
	 R8zG3CHOHfkUmY0B84s1OrRIHHuVd3Tl/JdGs0qi11vIFTgdCVBhTXyK1n7acmQexT9AC
	 pMOoxOHPmh9EcKGShrs6+9YyGF2PUP/HD2DB5GadkUjJiu9vs4An5gAvkzgBNLhkUTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UnPe0o0c;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A4606A31A;
	Sun, 25 Oct 2026 19:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF6A4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UnPe0o0c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792957832; x=1824493832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+Q7PaslewznwgUcZOwZylKUJ1RQH8/sf0B95GRfvAs=;
  b=UnPe0o0cgWy5J8XumMzqvnSW1YPrQiaUwinnwWzALiMzSqalgBK84u3Z
   BPH0LPl5kVE0SmDuZBa7B7f/dg0eW0Ac6gdZ30/qnxw/M5vCZVY5MO3hh
   YjF0yQ/9OXasJYRkJDlBtpIjgQ4OVLkqDYlu2ZaLcCup/vrFC7x/7Nhg0
   02u+PQNqxdU5G4293uaFZ5Ua1HWVFyez/hpWCvEfoIiU00jjL7jNK8l7h
   cveE2OEFWWmHWj8vBTivYdS449svE/n6CH48PdTzGdGFMWXyF6N1A2LCf
   9nA9hvD5xdDgrrn0VAfAyWYlLpdTSkP+HwAg/3MzaB9cxhxMn++nR4gVV
   Q==;
X-CSE-ConnectionGUID: 0QeIxNYPTHe6+6StcYcduw==
X-CSE-MsgGUID: BNgmBNJoQwKeZdGFdW+Djw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1656117"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1656117"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:50:32 -0700
X-CSE-ConnectionGUID: JMnOV2GhQCu5xJ9GdJ3w/g==
X-CSE-MsgGUID: c98DkQqYSnidhEQpE3S+ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="5922438"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:50:31 -0700
Date: Sun, 25 Oct 2026 21:50:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9360: fix sampling frequency write and
 available range
Message-ID: <at5dhBAtWA5erRpe@ashevche-desk.local>
References: <20261024180149.144609-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261024180149.144609-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 11:31:43PM +0530, Arnav Kapoor wrote:
> GNRL_CTRL1/2 hold the scan period in units of 8192 / FOSC, but
> sx9360_set_samp_freq() computes freq * 8192 / FOSC and mis-scales val2,
> which is in micro units. Any integer frequency then programs a period
> of 0, and fractional parts above ~0.26 Hz overflow the int, writing
> 0x10 to GNRL_CTRL1 outside the SCANPERIOD field.
> 
> Compute FOSC / (freq * 8192), rounded to the closest value, and reject
> frequencies outside the 1..2047 period range.
> 
> The available range doesn't match the limits in the comments next to it
> either: 4 MHz / 8192 is 488.28125 Hz, not 448.28125 Hz,
> 4 MHz / (8192 * 2047) is 0.238535 Hz, and (max - min) / 2047 is
> 0.238419 Hz. Use those values.

...

> static const struct {
>  	int val;
>  	int val2;
>  } sx9360_samp_freq_interval[] = {
> -	{ 0, 281250 },  /* 4MHz / (8192 * 2047) */
> -	{ 0, 281250 },
> -	{ 448, 281250 },  /* 4MHz / 8192 */
> +	{ 0, 238535 },  /* 4MHz / (8192 * 2047) */
> +	{ 0, 238419 },
> +	{ 488, 281250 },  /* 4MHz / 8192 */
>  };

At some point this should be converted to double array of int:s.

...

>  static int sx9360_set_samp_freq(struct sx_common_data *data,
>  				int val, int val2)
>  {
> -	int reg;
> +	unsigned int period;

What's the units for period? Seconds?

> +	u64 freq_uhz;

_uHz

>  	__be16 buf;
>  
> -	reg = val * 8192 / SX9360_FOSC_HZ + val2 * 8192 / (SX9360_FOSC_MHZ);
> -	buf = cpu_to_be16(reg);
> +	if (val < 0 || val2 < 0)
> +		return -EINVAL;
> +
> +	freq_uhz = (u64)val * MICRO + val2;

Read what units.h has for units of Hz.

> +	if (!freq_uhz)
> +		return -EINVAL;
> +
> +	/* The register holds the scan period, in units of 8192 / FOSC. */
> +	period = DIV64_U64_ROUND_CLOSEST((u64)SX9360_FOSC_HZ * MICRO,
> +					 freq_uhz * 8192);

Ditto.

> +	if (!period || period > SX9360_REG_GNRL_SCANPERIOD_MAX)
> +		return -EINVAL;
> +
> +	buf = cpu_to_be16(period);

Missing blank line. Always make guard()() to be standalone in the code.

>  	guard(mutex)(&data->mutex);
>  
>  	return regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,

-- 
With Best Regards,
Andy Shevchenko


