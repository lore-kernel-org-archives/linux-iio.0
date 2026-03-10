Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2999434A765;
	Tue, 10 Mar 2026 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170186; cv=none; b=jtvI2shg/UZrXLfmQBKb6OInMy07O8DclWJAX2v0ScZ5lIhxy+Lm3zo5xL2NjKd2Vk4xpfMii6I/laKLp8DB7K4Ezhky7x/rmTFvFBqLTYK0RTGoUzILdBfwmFHZxyX8YxGD4SbY7AK1yZS1o0qhIzNMJ7m3iWTCsYydGFCtZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170186; c=relaxed/simple;
	bh=NnPa4ewL5eEZPjlZWsIN3hJ1ai/T5y2qV0vW/U8QHgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HURiVksHZJH8bFbP4ZTSsZEYayXtz7O64RBMRy0LeM2ix0c6tBIiu01RhAu18yAS4q1YOMHsI0cWON2M43HHFVQe4D5BDqurPzEsWKfUvPVO0ncO8TQXmoT52T9l1BSZ2W4HSXFqZVjwUBrUlqlmkjnyxg9yN+Uaa0T894yab6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJ8uDyjv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJ8uDyjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773170183; x=1804706183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NnPa4ewL5eEZPjlZWsIN3hJ1ai/T5y2qV0vW/U8QHgA=;
  b=FJ8uDyjva4gS1F56fbvTtY9Vk+jk6+dKp9Q0InLFS9S+esVdvVwnSANd
   zSrluM3sYcCktc7SawRpHj/neXLEXmc5i6/i7pDjWcHDSWFQSKZx3aeKi
   Sof7ApeKWwH9cA1sfkvoSgdUNQ2ZRn79aHZVWvZxkkyopbJJTNe8kFu8C
   uZV3vbh0dtwTEkpruY2xD1zo7E5Qme80rDYgHJEHiJhccrqAM0YlC3riv
   ox1V+8PF3kItxCaz2cYMf9cVf+FNtiflk/Jml0H3lmQIriclbq3rczaAA
   Q/wMZadwdEz0Mza9zMhGIVyf4RKkR0J7tRLVO0dDiPTbTJxYP2Cp8s4aB
   g==;
X-CSE-ConnectionGUID: yfzxI6TgT1qqZGb2iOepAw==
X-CSE-MsgGUID: feEBwj2KRbKPc9oRDvwvSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61801889"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="61801889"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:16:22 -0700
X-CSE-ConnectionGUID: YHhMJRxVTgmc/M4o5eYzhg==
X-CSE-MsgGUID: tcF+rLaeQ3CMyqAoNf2tcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="215560766"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:16:19 -0700
Date: Tue, 10 Mar 2026 21:16:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: dac: ad5504: fix scale via
 output-range-microvolt
Message-ID: <abBuAZTSeTjRhyZY@ashevche-desk.local>
References: <20260310174835.24209-1-0rayn.dev@gmail.com>
 <20260310174835.24209-5-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310174835.24209-5-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 10, 2026 at 05:48:34PM +0000, Taha Ed-Dafili wrote:
> The AD5504 full-scale range is hardware-determined by the
> R_SEL pin (0-30V or 0-60V). Previously, the driver incorrectly used the
> VCC regulator voltage to calculate the scale.
> 
> Update the probe function to read the standard "output-range-microvolt"
> property as a two-element array to determine the correct full-scale range.
> Use the MILLI macro for clearer millivolt assignments and simplify the
> probe logic using a local device pointer.

...

>  static int ad5504_probe(struct spi_device *spi)
>  {
> -	const struct ad5504_platform_data *pdata = dev_get_platdata(&spi->dev);
> +	struct device *dev = &spi->dev;
> +	const struct ad5504_platform_data *pdata = dev_get_platdata(dev);
>  	struct iio_dev *indio_dev;
>  	struct ad5504_state *st;
>  	int ret;
> +	u32 range[2];

Preserve the reversed xmas tree order.

> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));

Unrelated change. This should be split into another patch that makes use
of it here and there.

I have a déjà vu about these comments...

>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
>  
> -	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
> -	if (ret < 0 && ret != -ENODEV)
> +	ret = devm_regulator_get_enable(dev, "vcc");
> +	if (ret)
>  		return ret;

> -	if (ret == -ENODEV) {

Why remove this condition?

This might break use of the driver on ACPI systems.

> -		if (pdata->vref_mv)
> -			st->vref_mv = pdata->vref_mv;
> -		else
> -			dev_warn(&spi->dev, "reference voltage unspecified\n");
> -	} else {
> -		st->vref_mv = ret / 1000;
> -	}
> +
> +	st->vref_mv = 60 * MILLI;
> +	ret = device_property_read_u32_array(dev, "output-range-microvolt",
> +					     range, 2);

ARRAY_SIZE()
(will require array_size.h)

> +	if (!ret && range[1] == 30 * MICRO)
> +		st->vref_mv = 30 * MILLI;

This looks unusual and hard to follow. It also misses the validation
of the min of the range.

> +	if (pdata && pdata->vref_mv)
> +		st->vref_mv = pdata->vref_mv;

No, pdata should go.

>  
>  	st->spi = spi;
>  	indio_dev->name = spi_get_device_id(st->spi)->name;

...

>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	if (spi->irq) {
> -		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> -					   NULL,
> -					   &ad5504_event_handler,
> -					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -					   spi_get_device_id(st->spi)->name,
> -					   indio_dev);
> +		ret = devm_request_threaded_irq(dev, spi->irq,
> +						NULL,
> +						&ad5504_event_handler,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						spi_get_device_id(st->spi)->name,
> +						indio_dev);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	return devm_iio_device_register(&spi->dev, indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }

Unrelated changes.

-- 
With Best Regards,
Andy Shevchenko


