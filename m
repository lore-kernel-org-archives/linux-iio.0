Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011233EDE4D;
	Fri, 11 Sep 2026 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114678; cv=none; b=SKXt7zqO6ivMAYBOG+nYOBrTD6Xb+01DJBZ4YXLf87h6xD1N0FVD5odjrDXdcgj+a9A/4cKR7DpunDhL4D2EX8hyv3bI4VfXFcUL5QlS2GPsofye3eR+6AomgT1FSHQ68sZq5S0SmxTUNmw/V8vLHgkR/frkJGv3L7YQ7OUfuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114678; c=relaxed/simple;
	bh=WZHMjb20+W4xFwOZ8JRAqDKu4IPBUcK2Cj9TC41u53Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EArH0KWJrnjI9m7QChE5LiPL350bbEnRNYDJlYsmOBsOWTfTGpOUDZgOlsRvPna6i8PpPycdZN24NJ118mT7bDnF5YitN0eH1JzAezONBzm0/JJqbTpfTB2r8o2bBHucxagEiBwrdVCS2TyOde+SxYpIfqkBx7rYWXeZ5sYVva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2K0RRgf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2K0RRgf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789114677; x=1820650677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WZHMjb20+W4xFwOZ8JRAqDKu4IPBUcK2Cj9TC41u53Q=;
  b=h2K0RRgfEvHdly6fVvouxIjKZduJXJydCmBa4ZjSzPpmSJsMO/j2TRaG
   FO+JMlul69iliHoOfOUIXjD56J71gDizeAvhjBuFskjKf+BTEBQKX77r6
   MHVRm9OVKgfwe/P9oQ7LNpOdBDQpyd4rCf3wVHhequCAHyOuM9xyIj8FP
   sbja2RP3vJdj/y5rbZ5v0AwDoCcuYAPDemMp25+7b+FpOj2E37UliwFoh
   Wi0LGB8eQZz9E/dg0gvccu+Q9hX64qaQ0psG2zca+J5AKuxbJSS5kHXgi
   oL2AxZe8zcgUOR9n313lIhIHCrIpyvOu/TVQ9vbl8ogrk0CDoVe1tDrf+
   g==;
X-CSE-ConnectionGUID: uTTXpkrfQ6Gqehg1xotmXQ==
X-CSE-MsgGUID: FFkb3VLrR/GpDVhEAyV6eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100739529"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="100739529"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:17:56 -0700
X-CSE-ConnectionGUID: WI3y7o50TLONHoFHS6tneQ==
X-CSE-MsgGUID: lKWLOOSETLWONAu+zfVVUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="271383434"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:17:51 -0700
Date: Fri, 11 Sep 2026 11:17:48 +0300
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
Subject: Re: [PATCH v7 08/17] iio: adc: ad7768: Derive output data rates
Message-ID: <aqO5LMbBHhgrcn78@ashevche-desk.local>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
 <20260910-ad7768-driver-v7-8-7f70b07627e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-ad7768-driver-v7-8-7f70b07627e1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 07:36:26PM +0200, Janani Sunil wrote:
> Derive valid output data rates from the master clock, power mode and
> decimation ratio.
> 
> Replace the fixed x64 decimation and open-coded DCLK divider in
> ad7768_configure_capture() with the derived default output rate and the
> new decimation and clock-divider helpers. Select the maximum rate
> supported by the configured data interface for the initial capture
> configuration.

...

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
> +	if (dclk > mclk)
> +		return -EINVAL;
> +
> +	dclk_div = DIV_ROUND_CLOSEST(mclk, dclk);
> +
> +	/* Set the divider to the next-lowest supported power of two. */
> +	dclk_div = rounddown_pow_of_two(min(dclk_div, AD7768_MAX_DCLK_DIV));
> +
> +	switch (dclk_div) {
> +	case 1:
> +		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_1;
> +		break;
> +	case 2:
> +		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_2;
> +		break;
> +	case 4:
> +		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_4;
> +		break;
> +	case 8:
> +		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_8;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
> +				  AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
> +				  FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
> +					     dclk_div_reg));

(Some of) this code is moved in the same series! Please, make sure it's not got
-+ in this patch. This can be achieved, exempli gratia, by creating a helper to
begin with at the proper location from the start.

-- 
With Best Regards,
Andy Shevchenko


