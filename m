Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A12D6E6B;
	Wed,  4 Feb 2026 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770171774; cv=none; b=pz2iaVB2Fojmt72P1k6ZIw8XjBKZ19esvl1mwOO9XYRoA/iPtLyaMz97W486/mpowQ6hs6WHo0zaNeZhtXvmIU2LD6NwTyjaAvM4+PvZ8pXzfaLkM+ZgXw2mkBwTvZHPSNExi7PeQjMc+JkTP9G/2XkAYeMBOamUUFQkLAqESyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770171774; c=relaxed/simple;
	bh=W1Qv3cJEaT/53bWk1neCQ5gXm2O8/b3dzwOV0WYbCQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n78d0C1Xo7kjrMbQSmX7YmN1Mu0OQk9JG4WWVyWgvSbKfwiIn3udd6HGrZovZ0j1WEV4MHIEtfDdsc3KhAzx0SYTzPGtCYAsM8GZjTlsiVwHVRVBv/9hJD58L/F+v+T6bOYUnu3tlTPX3kHd8ocR6w8cU+CsDAPYcLjdnvIRn8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRZsSGZH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRZsSGZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770171773; x=1801707773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W1Qv3cJEaT/53bWk1neCQ5gXm2O8/b3dzwOV0WYbCQE=;
  b=HRZsSGZHfBRLfWnSi3p+UwVpLsXGlPX5rZ83UfHFZR1AqcQ2A4Y9DEMo
   pdNHX615+Du+OZPbpGvd88EnbJfBbelQ+I7RAxn+Eg3NsYd7Jt4HcIwUq
   G4CF6ZQ0bWTrGmJ5c8Wyq/O5bMx8dWKXgUO0Om+YMXyCFdhVTWJRmNHwQ
   lHcqaRJJCodB1t3iZkDqlZ57DK/1HWVewq2CTmSARSjXPODYq0MI7ER61
   FCresi18i2qBCKRg71jnboAHPANnNNUgsAFLHCoos7xN0a83RUNNtTNe9
   vvD3imz2rF4N1PSTTr7jjlq7VXgTJU4aiq4xbKQHkqO1XPX11PilkW6TS
   A==;
X-CSE-ConnectionGUID: K6DIhHN4SP+fGEbgnqQmng==
X-CSE-MsgGUID: 0KueV1/pSxC79COtv3i8nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71390766"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71390766"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 18:22:53 -0800
X-CSE-ConnectionGUID: IpwUHt4JTbSOfJ869rWQUg==
X-CSE-MsgGUID: 0uh3YORjRru28A/8kAW9mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209134871"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 18:22:49 -0800
Date: Wed, 4 Feb 2026 04:22:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 8/9] iio: amplifiers: ad8366: consume enable gpio
Message-ID: <aYKtd_83eiJZ7hsR@smile.fi.intel.com>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
 <20260203-iio-ad8366-update-v3-8-5d5636b5181a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-iio-ad8366-update-v3-8-5d5636b5181a@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 11:24:14AM +0000, Rodrigo Alencar via B4 Relay wrote:

> Some parts may consume enable GPIO to enable serial mode
> (HMC1119's and HMC792A P/S pin) or powerup the device
> (e.g. ADA4961's PWUP pin). Also, add a comment explaining
> that even though chips like HMC271A has a reset gpio, this
> driver previously considered the reset pin for parts that
> don't actually have a reset gpio, so it might have been
> used to enable/power the device.

...

> +	/*
> +	 * Previously, this driver considered the reset gpio for some devices

GPIO

> +	 * that don't actually have a reset pin, which could have been wired
> +	 * up to the enable pin instead, so some users might be relying on this
> +	 * to turn the chip on rather than reset it.
> +	 */
>  	reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(reset_gpio))
>  		return dev_err_probe(&spi->dev, PTR_ERR(reset_gpio),
>  				     "Failed to get reset GPIO\n");

Yeah, this needs to be addressed somewhere in drivers/gpio/gpiolib-of.c.
Because OUT_HIGH for the reset doesn't sound right if the polarity is active high.

> +	enable_gpio = devm_gpiod_get_optional(&spi->dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(enable_gpio))
> +		return dev_err_probe(&spi->dev, PTR_ERR(enable_gpio),
> +				     "Failed to get enable GPIO\n");

-- 
With Best Regards,
Andy Shevchenko


