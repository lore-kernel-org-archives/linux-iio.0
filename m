Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE93ACA66;
	Fri,  6 Mar 2026 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807956; cv=none; b=s8bFF+1W7RqG3ElBQf2kczCYdi2jAm7EiWaCfdQGkHrDnaaToP1SENqdPoF6fbYtKYqjeQk+pU2Mm8MCemrQWduocL5NDKcKNvtCbYg2HeBxIS0g3Kt/hB9E+0a4EbE2Lzmr0g6yXQjNL4V9BsyltoLZNH5nKRft67jmQt+3SAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807956; c=relaxed/simple;
	bh=RvIr1bv4JzGGnQbI64pXM40ONViqWztGeEODEcBy2jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwSjZMUU+fpIpqUoml1DWyiQP54bUWJB42qNXfjKerUcdkPzm/OqD4S5+i3aLPM+U2QUFOnu+bWsYu5GAfixF6rJsIFIk7M09qA483QOIzG8mcLAAU6iI+RJ9B/M9QAmzObEdiigdhgw8yr1EDEHiv9TFMQvXC1PIlS4QwV+p8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffgNsRis; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffgNsRis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772807955; x=1804343955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RvIr1bv4JzGGnQbI64pXM40ONViqWztGeEODEcBy2jM=;
  b=ffgNsRisQKo9pr6CTm7J7tU8YCrBZfHpg6tMKvS6wYN+0O9/cjC8aPZ8
   n0mRg1TjtAgPv+dhPha/TIsooD1qgPCFnMI5v+S8uxYxJMRuJce23O2zl
   vEs1vUmbtLRuwTSkWUdlo8+eAxdjsE9W6iVr0lP0aEZqsnrXVnLHfvwbu
   GveAfqw4kp16qz+KUQy1VHK7GCdFmCVJh7HnInZp7tA5qfTwRJybwKduD
   TOMRCx7pzI2VXM2Vh+fPakWk5YMI/8ummXGwb7PMgH7hHdTdl8jtLzrm+
   y/vRq8WM5qtXrbq5ZMkHk5BOgI88d6ZlD1PKr4LTmkivC0EohhWZlk2YR
   w==;
X-CSE-ConnectionGUID: oJ13nXJGQ3iiaiRyFg9oLg==
X-CSE-MsgGUID: mrBkskjvRmuc/dI4vBC3rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73962712"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73962712"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:39:14 -0800
X-CSE-ConnectionGUID: BNRUhAbSRqSm5FFmpEVGVw==
X-CSE-MsgGUID: utXx3yj0RgeEDC+SzBiS6Q==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:39:12 -0800
Date: Fri, 6 Mar 2026 16:39:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: frequency: ad9523: add dev variable
Message-ID: <aarnDSzQHIrfmSen@ashevche-desk.local>
References: <20260306102504.42395-1-antoniu.miclaus@analog.com>
 <20260306102504.42395-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306102504.42395-4-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 06, 2026 at 12:24:47PM +0200, Antoniu Miclaus wrote:
> Introduce a local struct device variable in ad9523_probe() to simplify
> subsequent conversions and improve code readability.

...

>  static int ad9523_probe(struct spi_device *spi)
>  {
> -	struct ad9523_platform_data *pdata = dev_get_platdata(&spi->dev);
> +	struct device *dev = &spi->dev;
> +	struct ad9523_platform_data *pdata = dev_get_platdata(dev);

It's always better to split assignment and definition when the result is going
to be validated. It makes code robust against potential changes in
between that might alter that variable / value.

	struct ad9523_platform_data *pdata;

>  	struct iio_dev *indio_dev;
>  	struct ad9523_state *st;
>  	int ret;

	pdata = dev_get_platdata(dev);

>  	if (!pdata) {
> -		dev_err(&spi->dev, "no platform data?\n");
> +		dev_err(dev, "no platform data?\n");

This line can be updated in the second patch altogether.

>  		return -EINVAL;
>  	}

...

> -	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> +	st->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>  		GPIOD_OUT_LOW);
>  	if (IS_ERR(st->reset_gpio))
>  		return PTR_ERR(st->reset_gpio);

Side note: The material to move to reset-gpio driver instead (I think we have
tons of the IIO drivers with the same).

-- 
With Best Regards,
Andy Shevchenko


