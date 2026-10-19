Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFE4B4058;
	Mon, 19 Oct 2026 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404824; cv=none; b=gQ14W4glhW5bIMgMCceVlAygGE6XgW/gZe0cvT7RbgpZqf0mqH3/6HmgOyzTxhtZ+/2mjZ/fFSPDhapVR7SxO9x7yzyMBmRLlDxWeq4j3mtygD25QCoqt8Y640wy0WSF0cVCS/pDpgnqpiFUaaT+7WjaR5QuUcsnAImDOPCjFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404824; c=relaxed/simple;
	bh=mDoBT6T71xtkQXn3Ye430SHeLWgm6rwvNptl6fiqXmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM82zvjpdIdQZoCaDYwH1wAe9ahp5Twd4V7nh2rA2mwIme1gjZThUiCmEmkdLMcmXsxfgTOAeMWmqto/v0ftP0JgDk8kPxLgp1edDRYIQnxEKwSqerpCuWRG+FVaYPyiCK2gH5xuNWG1pcn0Nsz0QKF2N0OuGC5jXlqdVtj8iGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nl0L76Sr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nl0L76Sr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792404823; x=1823940823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mDoBT6T71xtkQXn3Ye430SHeLWgm6rwvNptl6fiqXmo=;
  b=Nl0L76Srm/qtgje327l9l76Ag9YwTh/T9oO1lzJfNA4RxAtGZfoBbH6T
   NIS4PEZ8PElgz+jCQ/cCzvWk5pbpRBpAGK41E2n72y6p3C0EcwZ+SN2X9
   hY5yT4BbVMIvHlxxcm7iEqAmDuZcDciVBlwXbyAsgYDxCKebw1CtiggJA
   p2+cSUVT0Cy3zANxWj9VrMvPjdlQzIHFnVPfEADMB379GRNam3/BDE9+K
   0rOWd7rDTjdESWl/8ghQEaLihSjHA1MzFlz7KThmS1q6L4oKwKf2Y8n6D
   m7NgR9hZ7Q4axNQGEKzJ4n3udxUX2yc44RXrz8x3/hYavsv+lwYIsmPI3
   A==;
X-CSE-ConnectionGUID: 0e5dPLfPQ5mTnico9BNY1w==
X-CSE-MsgGUID: QKqVTt7PTC69A0fzAwU7vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1098768"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1098768"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:13:42 -0700
X-CSE-ConnectionGUID: F0rC+WWbTGSRP2JaWNZjrw==
X-CSE-MsgGUID: wWfgrnM0RTmRS/pADxOrLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2919063"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:13:39 -0700
Date: Mon, 19 Oct 2026 13:13:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: berringtoni36@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] iio: accel: adxl345: update period cache after
 successful write
Message-ID: <atXtUSkBM0dBG80A@ashevche-desk.local>
References: <20261018-adxl345-period-cache-v2-resend-1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018-adxl345-period-cache-v2-resend-1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 18, 2026 at 09:42:00PM +0800, Wenqiang Zhao via B4 Relay wrote:
> 
> The ADXL345 event-period read path returns st->inact_time_ms. The setters
> for inactivity, free-fall and the ODR-derived default currently update
> this cache before writing TIME_INACT or TIME_FF. If the regmap write
> fails, the sysfs write reports an error but a subsequent read returns
> the requested period even though it was not programmed.
> 
> Update the cached period only after the corresponding regmap write
> succeeds.

...

>  	/* Inactivity time in s */
> -	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +	if (ret)
> +		return ret;
> +
> +	st->inact_time_ms = MILLI * val;

While at it, replace MILLI with MSEC_PER_SEC (from time.h).

> +	return 0;

...

>  static int adxl345_set_inactivity_time(struct adxl345_state *st, u32 val_int)
>  {
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
> +	if (ret)
> +		return ret;
> +
>  	st->inact_time_ms = MILLI * val_int;

Ditto.

> -	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
> +	return 0;
>  }

...

>  static int adxl345_set_freefall_time(struct adxl345_state *st, u32 val_fract)
>  {
> +	int ret;
> +
>  	/*
>  	 * Datasheet max. value is 255 * 5000 us = 1.275000 seconds.
>  	 *
>  	 * Recommended values between 100ms and 350ms (0x14 to 0x46)
>  	 */
> +	ret = regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> +			   DIV_ROUND_CLOSEST(val_fract, 5));
> +	if (ret)
> +		return ret;
> +
>  	st->inact_time_ms = DIV_ROUND_UP(val_fract, MILLI);

Hmm... Okay, since it's three instances and only one you actually touched
perhaps a separate patch.

> -	return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> -			    DIV_ROUND_CLOSEST(val_fract, 5));
> +	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko


