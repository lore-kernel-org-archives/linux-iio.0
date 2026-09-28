Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218723F7AAC;
	Mon, 28 Sep 2026 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584580; cv=none; b=oxl2aYS85uQjEJq55tcJE4Y857RnqCb9rF8hiXI1YHOjMusqa+y7HnBLTJq5amfmhgQpEdrsOb//EEM2eQtS17TE5+YqkpZfc+YZsGJ28rdYItM+jmSWcUQU7+USWxnvPsCI4Q21EX6gl2UUFPLh4YwvPu3gAxLDZ5cOqVeNwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584580; c=relaxed/simple;
	bh=pwLgxTRQaJbAuoKRIW3dy1IbXKeQfhH90VKCp8hXN8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txvh8lIctcLEqD3BJZPB+m+2uf5vF/LxkutorqjVx/0oa0PcHBIjgnzD/U1UTjuKOycJLjo8OBgs+PRaViYcZw+H3dggKmdsjuPB4DN1klH9qZgs5aGmi5tuZIdzo0GtrGB6Vd/gwQAB6n/A3oF37KPJ7HSiEbrTFSBXR3bOy1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFahcXac; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFahcXac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790584576; x=1822120576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pwLgxTRQaJbAuoKRIW3dy1IbXKeQfhH90VKCp8hXN8s=;
  b=nFahcXacqmu+/qjRWvoL4wsV48VfJGJYtDO9r+W4NiRtk481o1taHkYz
   lATsJuryA7eTN1YY/WYysgoa7wCRdBN+rK898S4k5AKvqqkIUtQGKO7xx
   Ek1xVj3CQGRLt/740XpEpTEaUQgwUmf3OLkPrSdOfJPP+6G2Yj7Rn8hsa
   hxH1xOSfI4GFfZQQk0PdreTmLbrgkkn2H3t0GPAzce1Q4g3JhqPEnYFku
   E1wV91nl8bcgyO1JIrezGzde4P3xblO99ZP6lExriBpjpr40ebfcY84QK
   4+kClTd0AeYLzY4qcrQ2Xfk00EoF6s98RhsmgUPk1DMn9DoNwOsN/UG/a
   Q==;
X-CSE-ConnectionGUID: FGtI81RhTy+Utlz7KfFgVA==
X-CSE-MsgGUID: rCG4kHalR4OKgVEHcfYU8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90180917"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90180917"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:36:11 -0700
X-CSE-ConnectionGUID: CuTZjTB9R6CR8m3nW+zr6A==
X-CSE-MsgGUID: 3XwqWEF9QJu/lQ3auDbLLQ==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:36:08 -0700
Date: Mon, 28 Sep 2026 11:36:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
	Kurt Borja <kuurtb@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads112c14: add gpio support
Message-ID: <arom9T0azKX9jV5m@ashevche-desk.local>
References: <20260925-iio-adc-ti-ads112c14-gpio-v1-1-2a2b218ebf3a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-iio-adc-ti-ads112c14-gpio-v1-1-2a2b218ebf3a@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 04:50:47PM -0500, David Lechner (TI) wrote:
> Add support for using the AIN4/GPIO0 to AIN7/GPIO3 pins as GPIOs when
> the gpio-controller property is present.
> 
> Pins that are already used for something else according to the
> devicetree are excluded from the valid GPIO mask. This includes analog
> inputs and excitation current outputs used by channels, REFP/REFN when
> an external reference is used, the /FAULT and /DRDY interrupts and the
> external clock input.
> 
> The per-pin register field macros are replaced with parameterized ones
> so that they can be used with the GPIO offset.

...

> +	DECLARE_BITMAP(gpio_reserved_mask, ADS112C14_NUM_GPIO);

Why not use valid_mask in GPIO chip directly?

...

> +static void ads112c14_reserve_gpio_for_ain(unsigned long *gpio_reserved_mask,
> +					   u32 ain)
> +{
> +	if (ain >= 4 && ain <= 7)
> +		set_bit(ain - 4, gpio_reserved_mask);

Why atomic op is needed?

> +}

...

> +static int ads112c14_gpio_init_valid_mask(struct gpio_chip *gc,
> +					  unsigned long *valid_mask,
> +					  unsigned int ngpios)
> +{
> +	struct iio_dev *indio_dev = gpiochip_get_data(gc);
> +	struct ads112c14_data *data = iio_priv(indio_dev);

> +	bitmap_fill(valid_mask, ngpios);

It's already filled by GPIOLIB, isn't it?

> +	bitmap_andnot(valid_mask, valid_mask, data->gpio_reserved_mask, ngpios);
> +
> +	return 0;
> +}

> +static int ads112c14_gpio_init(struct iio_dev *indio_dev)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +
> +	for (unsigned int i = 0; i < ADS112C14_NUM_GPIO; i++) {
> +		data->gpio_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s:GPIO%u",
> +						     dev_name(&indio_dev->dev), i);
> +		if (!data->gpio_names[i])
> +			return -ENOMEM;

Wondering if you can utilise devm_kasprintf_strarray().

> +	}
> +
> +	data->gc = (struct gpio_chip) {
> +		.owner = THIS_MODULE,
> +		.label = dev_name(dev),
> +		.parent = dev,
> +		.base = -1,
> +		.ngpio = ADS112C14_NUM_GPIO,
> +		.names = data->gpio_names,
> +		.can_sleep = true,
> +		.init_valid_mask = ads112c14_gpio_init_valid_mask,
> +		.get_direction = ads112c14_gpio_get_direction,
> +		.direction_input = ads112c14_gpio_direction_input,
> +		.direction_output = ads112c14_gpio_direction_output,
> +		.get = ads112c14_gpio_get,
> +		.set = ads112c14_gpio_set,
> +	};
> +
> +	return devm_gpiochip_add_data(dev, &data->gc, indio_dev);
> +}

...

>  static int ads112c14_parse_channels(struct iio_dev *indio_dev,
> -				    bool *need_avdd_ref, bool *need_ext_ref)
> +				    bool *need_avdd_ref, bool *need_ext_ref,
> +				    unsigned long *gpio_reserved_mask)
>  {

> +			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[0]);

> +			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[0]);
> +			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[1]);
>  		} else {

> +			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[0]);
> +			if (measurement->iadc_count > 1)
> +				ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[1]);

Can't this be done afterwards at init_valid_mask() stage?

...

>  static int ads112c14_probe(struct i2c_client *client)
>  {
> +	DECLARE_BITMAP(gpio_reserved_mask, ADS112C14_NUM_GPIO);

Hmm... But you have one already in the struct, why another one here?


...

> +	/* FAULT shares a pin with GPIO2. */
> +	if (fwnode_property_match_string(dev_fwnode(dev), "interrupt-names", "fault") >= 0)
> +		set_bit(2, gpio_reserved_mask);

Non-atomic?

...

>  	if (fwnode_property_match_string(dev_fwnode(dev), "interrupt-names", "drdy") >= 0) {
>  		data->drdy_irq = fwnode_irq_get_byname(dev_fwnode(dev), "drdy");
>  		if (data->drdy_irq < 0)
>  			return dev_err_probe(dev, data->drdy_irq,
>  					     "failed to get drdy interrupt\n");
>  
> +		/* DRDY shares a pin with GPIO3. */
> +		set_bit(3, gpio_reserved_mask);

Ditto.


>  		if (clk)
>  			return dev_err_probe(dev, -EINVAL,
>  					     "cannot use both DRDY and CLK - they share the same pin\n");

...

>  	if (clk) {
> +		/* CLK shares a pin with GPIO3. */
> +		set_bit(3, gpio_reserved_mask);

Ditto.

>  		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
> -					 ADS112C14_GPIO_CFG_GPIO3_CFG,
> -					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
> +					 ADS112C14_GPIO_CFG_GPIO_CFG(3),
> +					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO_CFG(3),
>  						    ADS112C14_GPIO_CFG_GPIO_CFG_INPUT));
>  		if (ret)
>  			return ret;

...

> +	if (device_property_read_bool(dev, "gpio-controller")) {
> +		bitmap_copy(data->gpio_reserved_mask, gpio_reserved_mask,
> +			    ADS112C14_NUM_GPIO);
> +
> +		ret = ads112c14_gpio_init(indio_dev);
> +		if (ret)
> +			return ret;
> +	}

This all smells like it should be refactored to nicely have it in one place in init_valid_mask().

-- 
With Best Regards,
Andy Shevchenko


