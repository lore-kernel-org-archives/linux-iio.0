Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6B3B47C3;
	Mon, 31 Aug 2026 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165191; cv=none; b=At4wiM7gtva7x/9KtSK1LrI1x02J09vIWJPQA52l88GPao2c3NMnD90YlsNQIOK53wU3/07rSrGV+UfzFiBgSTgycoy1a/EjtO2F5JfEcDMk+JVQnK53sJDwt7fzGxF6Hy5gR6sNPDXDW6cJULl1jhOfQ8ZJaeLRWXOyMLcMFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165191; c=relaxed/simple;
	bh=Uq4241EsA0PKRZZAWyvoZUDsLxH7MI06dMLaEaBQlTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7ektFaqM7JJsgHCU9jhWzHIpb0lFwbnnLblcYkKmcXr+pQLkSkoZljumEVFwUu/CjAdvglJitAwr8gbwcoZ6ocp4PbULOz//RmkA/s02xS4wMkeoICPusD09A/6l9aKHafQY4iD1PixYtNXSD6b+RuSXDYO5HXXuRqTLWFNS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8I2RJnE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8I2RJnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788165190; x=1819701190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uq4241EsA0PKRZZAWyvoZUDsLxH7MI06dMLaEaBQlTI=;
  b=U8I2RJnEsRbacMymh6BVsLhwZUxRD9Yw24qGtNp6yotbPbOSczIACWEa
   dIhB32G6BgL48aW7qPsRY3/A5Udnpnqav64yhXUZKlQOstdl00ZzCKJ2F
   aDqRmcEYSQ/+edCCalT4coD/NqxyvWVkdvznMMDVXRD6DpnFtX5otsqpw
   JurAGXtYShkv7S5OEp+UwxdEdsHuGszhiCrX6DBkD4dmphtddjuk7oEaq
   z+dfd5AdSRKkyuPshiJ7QvcOl6ZtULWMrlPPsWy1AYjnYYkgtpBr75ILA
   iElpBBOjYfUivbel2LkPqXbvIRESzUdwEgh5B765oY5GegqN7YOjPuq3t
   A==;
X-CSE-ConnectionGUID: R994BBOoRb2YMoa76DwYZQ==
X-CSE-MsgGUID: 69zTD9mFR+CkSFWChRkSTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88616444"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88616444"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:33:09 -0700
X-CSE-ConnectionGUID: JaLojC+ZS/eT2NkbectFIg==
X-CSE-MsgGUID: S/iTBAxITFu4OdrqVMOkeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="298648034"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 01:33:03 -0700
Date: Mon, 31 Aug 2026 11:33:01 +0300
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
Subject: Re: [PATCH v5 16/20] iio: adc: ad7768: Register GPIO auxiliary device
Message-ID: <apU8PRtI8HoC_waj@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-16-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-ad7768-driver-v5-16-e33ca6f841a2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:30:39PM +0200, Janani Sunil wrote:
> Register an auxiliary device when the AD7768 is described as a GPIO
> controller. This allows the GPIO driver to share the parent regmap and
> runtime power-management state.

...

> +static int ad7768_gpio_adev_init(struct ad7768_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct auxiliary_device *adev;
> +	int id;
> +
> +	if (!device_property_read_bool(dev, "gpio-controller"))
> +		return 0;
> +
> +	st->gpio_valid_mask = GENMASK(AD7768_NUM_GPIOS - 1, 0);

Can we use the one that is in the GPIOLIB (associated with struct gpio_chip)
instead?

> +	if (st->clock_source != AD7768_CLOCK_SOURCE_MCLK)
> +		st->gpio_valid_mask &= ~BIT(4);
> +
> +	/*
> +	 * Use the SPI bus number and chip select to derive a stable per-device
> +	 * ID.
> +	 */
> +	id = (spi->controller->bus_num << 8) | spi_get_chipselect(spi, 0);
> +	adev = __devm_auxiliary_device_create(dev, KBUILD_MODNAME, "gpio",
> +					      &st->gpio_valid_mask, id);
> +	if (!adev)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to create GPIO auxiliary device\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


