Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D921A682E;
	Mon, 24 Aug 2026 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555446; cv=none; b=Oemj//tebwYyCGXHYS+0Eh8zgpsoM+XzG9RZr8e+k9N+SG5Fs04G3l1RjHyvrAGLZMLzv/Q7HT0rum6C+uBNY5pC4j78d1Z4ia4T0zAI+jf4d0/NJo3T0KWimbEX7ja44s+if9m+8olgOTe4tSb9nSsnh8Mq5X7o+zJqRoFd7Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555446; c=relaxed/simple;
	bh=fpHciuKFxrDpGxi6XvkP47uMh6llOLS6pWUt/AwpxnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To2R82QWsAe126wkfUOxFh4OqcBX9Ln404PUTw1dp/8anEBPrVOEnWeK+880m9D1Jy+ukTomGzUW4OBGGD9xr/qQEssBwa2JEEwQYTdbSWBqCwpOVCidb1tFizF2Bsg6qK/zBDslEXUtoGjaUfUXsqtcqNWhgRwhM4Qs8b8liEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVDEpAmq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVDEpAmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787555444; x=1819091444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fpHciuKFxrDpGxi6XvkP47uMh6llOLS6pWUt/AwpxnY=;
  b=bVDEpAmqd7XH4QoinEENwQ2KPGOycyoVzm9rEPxpUk0ouLvQnahLGlVF
   6ljyAUtLS2SBAtU0ytFskK4N2pLRjLZchmpb8yiHB20fjagcHRRQbyBYa
   8NiIYI3wxzb9KhoAXFGSiIJX2sUV1FddfGIfvdMVq2lZJZVCSFlHRPJnK
   G1va1DCaRBwdD3wZwyb3Jt76IDc0ujpRy7d10Iu9W3zb3rAAxT5S1tgJF
   yrbNPC5oSQodiSCOAaGkbJRVjfmj58HfiN9X8AuoL3FI+dyeDYuDxaICB
   xh9GF1caNsVqOr1seBo35pQTYfpqCxULUR34grIXI/xEY2W2iKVQyp9md
   A==;
X-CSE-ConnectionGUID: jlev98B3QA+rR6QRoLW2GA==
X-CSE-MsgGUID: 8WNufDBDRZKNQuGeQdkGJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87867517"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87867517"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:10:43 -0700
X-CSE-ConnectionGUID: 81PysIvMRLSoj0YxzKm4bg==
X-CSE-MsgGUID: 931OPkOORtWThlWmswNCJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="265143916"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:10:37 -0700
Date: Mon, 24 Aug 2026 10:10:35 +0300
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
Subject: Re: [PATCH v4 08/14] iio: adc: ad7768: Add per-channel conversion
 delay
Message-ID: <aovua1sy4sm6RmSt@ashevche-desk.local>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-8-bb8fbd06d4eb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-ad7768-driver-v4-8-bb8fbd06d4eb@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 21, 2026 at 04:07:01PM +0200, Janani Sunil wrote:
> Expose the per-channel synchronization phase offset through the IIO
> conversion-delay attribute.
> 
> Derive the delay resolution from MCLK, power mode and decimation rate.
> Validate the requested delay and program the corresponding phase
> register when applying the active channel configuration.

...

> +static int ad7768_get_convdelay_params(struct ad7768_state *st, unsigned int ch,
> +				       struct ad7768_convdelay_params *params)
> +{
> +	struct ad7768_freq_config f_cfg;
> +	unsigned int dec_rate;
> +	unsigned int mclk_div;
> +	unsigned int mult;
> +	u64 mclk;
> +	int ret;
> +
> +	ret = ad7768_get_freq_cfg(st, st->ch_freq[ch], &f_cfg);
> +	if (ret)
> +		return ret;
> +
> +	dec_rate = ad7768_dec_rate[f_cfg.dec_rate];
> +	switch (dec_rate) {
> +	case 32:
> +		params->shift = 3;
> +		params->max_raw = 31;
> +		mult = 1;
> +		break;
> +	case 64:
> +		params->shift = 2;
> +		params->max_raw = 63;
> +		mult = 1;
> +		break;
> +	case 128:
> +		params->shift = 1;
> +		params->max_raw = 127;
> +		mult = 1;
> +		break;
> +	case 256:
> +		params->shift = 0;
> +		params->max_raw = 255;
> +		mult = 1;
> +		break;
> +	case 512:
> +		params->shift = 0;
> +		params->max_raw = 255;
> +		mult = 2;
> +		break;
> +	case 1024:
> +		params->shift = 0;
> +		params->max_raw = 255;
> +		mult = 4;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

So, this is just a bit twiddling of the dec_rate.

Can be written like

	/* Optional, perhaps shouldn't appear */
	if (!dec_rate)
		return -EINVAL;

	/* Same? What does table allow to have? */
	if (!is_power_of_two(dec_rate))
		return -EINVAL;

	mult = ilog2(dec_rate);
	if (mult > 10) {
		return -EINVAL;
	} else if (mult > 8) {
		params->shift = 0;
		params->max_raw = 255;
		mult = BIT(mult - 8);
	} else if (mult > 5) {
		params->shift = 8 - mult;
		params->max_raw = dec_rate - 1;
		mult = 1;
	} else {
		return -EINVAL;
	}

TBH, I don't know which looks easier to read. It all depends on what datasheet
says about these parameters and multiplier and what the table allows to have.

> +	mclk = clk_get_rate(st->mclk);
> +	if (!mclk)
> +		return -EINVAL;
> +
> +	mclk_div = ad7768_power_modes[st->power_mode_idx].mclk_div;
> +	params->step_ps = DIV_ROUND_CLOSEST_ULL((u64)mult * PSEC_PER_SEC *
> +						mclk_div, mclk);
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


