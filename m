Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7460525B0AE;
	Tue, 21 Jul 2026 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632374; cv=none; b=La56TXEXeUKl0WivleOFcvWTGHx0QhEZ9Zlw4krONXEZNkgIY2Ircl2knQQnPsp38fLQLyX3883YMbYx0dntRmxECkIUxUSWFr0/TiYODWdOpTgu1o6r3wzFwf1NF05VF9J9jvIT3Ve0Jl5e7xQ3CIk1sC5pdqKbRxvN8+2rz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632374; c=relaxed/simple;
	bh=Xm/Hm+3nwuPKjzj4WA9wOjtF0RcBCfUwzKdBFgvg37E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC7F+ANrX/bJH0heOSe3ZVG5NSa4btQR3tw+cDCtTr31zv3hiIk05Ni0eLxGhiAexis3k7W+ZU8P8RwtqJ/I+1c/yuWY6caS4lfr8mRi5VMUNs4UVZ+g3K6iTRx75BeJ+6nAu8uJPFIJvg5Hr3sb6FCpup7Cc8ztmMqZ8vJhITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvhrND+m; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvhrND+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784632372; x=1816168372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xm/Hm+3nwuPKjzj4WA9wOjtF0RcBCfUwzKdBFgvg37E=;
  b=NvhrND+mUSL3y2mpUDv8HwHAHAHRfT4eh4Fu2mWyiUg6a8xIKpymW6YL
   N5U9oO4/uKjd+xM93RmfkrWa3fFREwfAcfid31U13eYE310nEb8ec8kla
   5eCPCuHokriM1GEtyuYYTLb/WRLSwZslUUmXqMTkv8RUNjDsWZwl2PTga
   JWE9CLdnZlhZEsQx2n+aQBvxLWiKHyzQc0WgjzETRoJBAvWDN0kp4SMJk
   GNNi7PYc8A70ppYt7WOrX4B1a5WFLGZq9augn/KZEX2tGcpQgY2WR04en
   molxV8aNYnJXdCPFerUrHgtHHmyOzRNxCRfmoaasY7kNwIg/2OxQK/9Jx
   w==;
X-CSE-ConnectionGUID: spZ72DLpTDS0Jq12K+4B4g==
X-CSE-MsgGUID: ViwtpgoHQXOP1wftZDming==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="108018100"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="108018100"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 04:12:51 -0700
X-CSE-ConnectionGUID: GvlV50S8QuGN9ZC1XfUQ4Q==
X-CSE-MsgGUID: yk4tfUqSTD2+TjwrzevM+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="256530377"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 04:12:47 -0700
Date: Tue, 21 Jul 2026 14:12:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: linusw@kernel.org, mwalle@kernel.org, brgl@kernel.org,
	tychang@realtek.com, wbg@kernel.org,
	mathieu.dubois-briand@bootlin.com, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, jic23@kernel.org, andy@kernel.org,
	u.kleine-koenig@baylibre.com, dakr@kernel.org, bhelgaas@google.com,
	o-takashi@sakamocchi.jp, dlechner@baylibre.com,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org, cy.huang@realtek.com,
	james.tai@realtek.com
Subject: Re: [PATCH v6 8/8] gpio: realtek: Add driver for Realtek DHC RTD1625
 SoC
Message-ID: <al9ULO_55RlDQxgl@ashevche-desk.local>
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-9-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721065802.689530-9-eleanor.lin@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 02:58:02PM +0800, Yu-Chun Lin wrote:

> Add support for the GPIO controller found on Realtek DHC RTD1625 SoCs.
> 
> Unlike the existing Realtek GPIO driver (drivers/gpio/gpio-rtd.c),
> which manages pins via shared bank registers, the RTD1625 introduces
> a per-pin register architecture. Each GPIO line now has its own
> dedicated 32-bit control register to manage configuration independently,
> including direction, output value, input value, interrupt enable, and
> debounce. Therefore, this distinct hardware design requires a separate
> driver.
> 
> The RTD1625 GPIO controller has a hardware quirk where both 'assert'
> and 'de-assert' interrupts are fired simultaneously on any edge toggle.
> The driver works around this quirk to correctly handle edge interrupts.
> 
> Interrupt support is optional for this device, matching the dt-bindings.
> If the interrupts property is not provided, the driver simply skips IRQ
> initialization and operates purely as a basic GPIO controller.

...

> +struct rtd1625_gpio_info {
> +	unsigned int num_gpios;

Do you need this? Isn't it available via struct gpio_chip?

> +	unsigned int irq_type_support;
> +	unsigned int base_offset;
> +	unsigned int gpa_offset;
> +	unsigned int gpda_offset;
> +	unsigned int level_offset;
> +	unsigned int write_en_all;
> +};

...

> +static int rtd1625_reg_mask_xlate(struct gpio_regmap *gpio, enum gpio_regmap_operation op,
> +				  unsigned int base, unsigned int offset, unsigned int *reg,
> +				  unsigned int *mask)
> +{
> +	/* Each GPIO has its own dedicated 32-bit register */
> +	*reg = base + offset * 4;
> +
> +	switch (op) {
> +	case GPIO_REGMAP_IN:
> +		*mask = RTD1625_GPIO_IN;
> +		break;
> +
> +	case GPIO_REGMAP_OUT:
> +		*mask = RTD1625_GPIO_OUT;
> +		break;
> +
> +	case GPIO_REGMAP_SET_OP:
> +		*mask = RTD1625_GPIO_OUT;
> +		break;
> +
> +	case GPIO_REGMAP_GET_OP:
> +	case GPIO_REGMAP_GET_DIR_OP:
> +	case GPIO_REGMAP_SET_DIR_OP:
> +		*mask = RTD1625_GPIO_DIR;
> +		break;
> +
> +	default:
> +		return -ENOTSUPP;
> +	}

> +
> +	return 0;

Just spread this to each case by replacing break:s.

> +}
> +
> +static int rtd1625_value_xlate(struct gpio_regmap *gpio,
> +			       enum gpio_regmap_operation op,
> +			       unsigned int base, unsigned int offset,
> +			       unsigned int reg, unsigned int *mask,
> +			       unsigned int *val)
> +{
> +	switch (op) {
> +	case GPIO_REGMAP_SET_OP:
> +		*val |= RTD1625_GPIO_WREN(RTD1625_GPIO_OUT);
> +		*mask |= RTD1625_GPIO_WREN(RTD1625_GPIO_OUT);
> +		break;
> +
> +	case GPIO_REGMAP_SET_DIR_OP:
> +		*val |= RTD1625_GPIO_WREN(RTD1625_GPIO_DIR);
> +		*mask |= RTD1625_GPIO_WREN(RTD1625_GPIO_DIR);
> +		break;
> +
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;

Ditto.

> +}

...

> +static int rtd1625_gpio_set_debounce(struct gpio_chip *chip, unsigned int offset,
> +				     unsigned int debounce)
> +{
> +	struct rtd1625_gpio *data = gpiochip_get_data(chip);
> +	u8 deb_val;
> +	u32 val;
> +	int ret;
> +
> +	switch (debounce) {
> +	case 1:
> +		deb_val = RTD1625_GPIO_DEBOUNCE_1US;
> +		break;
> +	case 10:
> +		deb_val = RTD1625_GPIO_DEBOUNCE_10US;
> +		break;
> +	case 100:
> +		deb_val = RTD1625_GPIO_DEBOUNCE_100US;
> +		break;
> +	case 1000:
> +		deb_val = RTD1625_GPIO_DEBOUNCE_1MS;
> +		break;
> +	case 10000:
> +		deb_val = RTD1625_GPIO_DEBOUNCE_10MS;
> +		break;
> +	case 20000:
> +		deb_val = RTD1625_GPIO_DEBOUNCE_20MS;
> +		break;
> +	case 30000:
> +		deb_val = RTD1625_GPIO_DEBOUNCE_30MS;
> +		break;
> +	case 50000:
> +		deb_val = RTD1625_GPIO_DEBOUNCE_50MS;
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}

> +	val = FIELD_PREP(RTD1625_GPIO_DEBOUNCE, deb_val) | RTD1625_GPIO_DEBOUNCE_WREN;
> +
> +	scoped_guard(raw_spinlock_irqsave, &data->lock)
> +		ret = regmap_write(data->regmap, data->info->base_offset + GPIO_CONTROL(offset),
> +				   val);
> +
> +	return ret;

guard()() is fine here.

	val = FIELD_PREP(RTD1625_GPIO_DEBOUNCE, deb_val) | RTD1625_GPIO_DEBOUNCE_WREN;

	guard(raw_spinlock_irqsave)(&data->lock);

	return regmap_write(data->regmap, data->info->base_offset + GPIO_CONTROL(offset), val);

> +}

...

> +static int rtd1625_gpio_irq_set_level_type(struct irq_data *d, bool level)
> +{
> +	u32 val = RTD1625_GPIO_WREN(RTD1625_GPIO_LEVEL_INT_DP);
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +	struct rtd1625_gpio *data;
> +	int ret;
> +
> +	data = irq_data_get_irq_chip_data(d);
> +	if (!(data->info->irq_type_support & IRQ_TYPE_LEVEL_MASK))
> +		return -EINVAL;
> +
> +	if (level)
> +		val |= RTD1625_GPIO_LEVEL_INT_DP;

> +	scoped_guard(raw_spinlock_irqsave, &data->lock)
> +		ret = regmap_write(data->regmap, data->info->base_offset + GPIO_CONTROL(hwirq), val);
> +
> +	if (ret)
> +		return ret;

Better to move it inside the scoped_guard() loop.

> +	irq_set_handler_locked(d, handle_level_irq);
> +
> +	return 0;
> +}

...

> +static int rtd1625_gpio_setup_irq(struct platform_device *pdev, struct rtd1625_gpio *data)
> +{
> +	unsigned int num_irqs;
> +	int irq;
> +
> +	irq = platform_get_irq_optional(pdev, 0);

Perhaps a comment to explain that IRQ is (fully) optional?

> +	if (irq == -ENXIO)
> +		return 0;
> +	if (irq < 0)
> +		return irq;
> +
> +	num_irqs = (data->info->irq_type_support & IRQ_TYPE_LEVEL_MASK) ? 3 : 2;
> +
> +	for (unsigned int i = 0; i < num_irqs; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0)
> +			return irq;
> +
> +		data->irqs[i] = irq;
> +		irq_set_chained_handler_and_data(data->irqs[i], rtd1625_gpio_irq_handle, data);
> +	}
> +
> +	return 0;
> +}

...

> +static int rtd1625_gpio_probe(struct platform_device *pdev)
> +{
> +	struct gpio_regmap_config config = {};
> +	struct device *dev = &pdev->dev;
> +	struct gpio_regmap *gpio_reg;
> +	struct rtd1625_gpio *data;
> +	void __iomem *irq_base;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->info = device_get_match_data(dev);
> +	if (!data->info)
> +		return -EINVAL;

-ENODATA

> +	irq_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(irq_base))
> +		return PTR_ERR(irq_base);
> +
> +	data->regmap = devm_regmap_init_mmio(dev, irq_base, &rtd1625_gpio_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	raw_spin_lock_init(&data->lock);
> +	platform_set_drvdata(pdev, data);
> +
> +	data->save_regs = devm_kcalloc(dev, data->info->num_gpios, sizeof(*data->save_regs),
> +				       GFP_KERNEL);
> +	if (!data->save_regs)
> +		return -ENOMEM;
> +
> +	config.parent = dev;
> +	config.regmap = data->regmap;
> +	config.ngpio = data->info->num_gpios;
> +	config.reg_dat_base = data->info->base_offset;
> +	config.reg_set_base = data->info->base_offset;
> +	config.reg_dir_out_base = data->info->base_offset;
> +
> +	config.reg_mask_xlate = rtd1625_reg_mask_xlate;
> +	config.set_config = rtd1625_gpio_set_config;
> +	config.value_xlate = rtd1625_value_xlate;
> +
> +	data->domain = irq_domain_create_linear(dev_fwnode(dev),
> +						data->info->num_gpios,
> +						&rtd1625_gpio_irq_domain_ops,
> +						data);
> +	if (!data->domain)
> +		return -ENOMEM;


devm_irq_domain_instantiate()

> +	ret = devm_add_action_or_reset(dev, (void (*)(void *))irq_domain_remove, data->domain);
> +	if (ret)
> +		return ret;
> +
> +	ret = rtd1625_gpio_setup_irq(pdev, data);
> +	if (ret)
> +		return ret;
> +
> +	config.irq_domain = data->domain;
> +	config.drvdata = data;
> +
> +	gpio_reg = devm_gpio_regmap_register(dev, &config);
> +	if (IS_ERR(gpio_reg))
> +		return PTR_ERR(gpio_reg);
> +
> +	data->gpio_reg = gpio_reg;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


