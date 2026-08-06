Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54649504E;
	Thu,  6 Aug 2026 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059860; cv=none; b=Wd7GNpuC6T4AMfmPbLajPXPBQ6+1Qrr+bnMHHQLshVLWmqGpIDwm2ohqfOSP8dum9zfq2JbUv76jzH3IdFSGKv1BjRaR5o831bzfwMlJrNDE52L3stNNjOLamKmHgiXmlNzJysfF3VKESkTpZIDGShmw6QAbT5VaNhdbjEZYz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059860; c=relaxed/simple;
	bh=l2+DY/+zfm6kc8T511ebTpdJYLnOb77/Vrd25+t/IAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl4GC6zIRcVwtsGcSVz71O2BP35xFyo2ydMJ5s4MHNJshcWrmMzZ3kRjT7NCGtaC1cOP13mVTDaelK9oDCKE5H6ttXdIQKZRUUlVb9MLSUmDnlHmVIdBsU20fRAsSu4m4SLxJ8yXh4RvxsMfPOhBqZOGKML3FaR9mWcIDtyqgCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3vijAnz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3vijAnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786059857; x=1817595857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l2+DY/+zfm6kc8T511ebTpdJYLnOb77/Vrd25+t/IAI=;
  b=g3vijAnz/zrcxK9AyTU5rbd77JYs6olo9H00fDwtqv0qenBX59Bv3Xk0
   4ni4sRJsqJVir4HzzjAsbG6vfEhfSouqDco+MAEkYInJJHgkFJmuGpeGf
   /SffpySiUa5adL98Hr01rujjpYGEHTdCLvO4eTcEuiQIdpVpeXRcgsMMR
   qTgtfbbyBEQhXIf4GrwNqC+r23ltstFZOygGMcLqUqNNx3x+I2B+SCUpn
   xqI+qwpDeTEYOMnzaJ1qcZlpIiZmWhUmAdhCPIGmM4oEualPQQ70AefEx
   BHaDjebEF3gngBgvLv9kywTwv/HxUuYcdGE4XAFCQAOVz81Q7c/JpmiLc
   w==;
X-CSE-ConnectionGUID: kaorRZ35QRGfXRxhgTZIRQ==
X-CSE-MsgGUID: qEVUL4Q+Q9+vHt+9cUPDZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86874195"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86874195"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 16:44:16 -0700
X-CSE-ConnectionGUID: 6qSmh78FTvG1M+9UW4jjzg==
X-CSE-MsgGUID: H617RV3XQOqFholnuMijRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="262301863"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 16:44:10 -0700
Date: Fri, 7 Aug 2026 02:44:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: linusw@kernel.org, mwalle@kernel.org, brgl@kernel.org,
	tychang@realtek.com, wbg@kernel.org,
	mathieu.dubois-briand@bootlin.com, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, jic23@kernel.org, andy@kernel.org,
	o-takashi@sakamocchi.jp, u.kleine-koenig@baylibre.com,
	dakr@kernel.org, bhelgaas@google.com, dlechner@baylibre.com,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org, cy.huang@realtek.com,
	james.tai@realtek.com, stanley_chang@realtek.com
Subject: Re: [PATCH v8 9/9] gpio: realtek: Add driver for Realtek DHC RTD1625
 SoC
Message-ID: <anUcSPcJjJkLh0Z-@ashevche-desk.local>
References: <20260726125209.140307-1-eleanor.lin@realtek.com>
 <20260726125209.140307-10-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726125209.140307-10-eleanor.lin@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 26, 2026 at 08:52:00PM +0800, Yu-Chun Lin wrote:

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

I see this is already applied, but consider the below as a material to follow up.

...

> +static int rtd1625_reg_mask_xlate(struct gpio_regmap *gpio, enum gpio_regmap_operation op,
> +				  unsigned int base, unsigned int offset, unsigned int *reg,
> +				  unsigned int *mask)
> +{
> +	/* Each GPIO has its own dedicated 32-bit register */
> +	struct rtd1625_gpio *data = gpio_regmap_get_drvdata(gpio);
> +	int val = 0, ret = 0;

ret assignment is redundant.

> +	*reg = base + offset * 4;
> +
> +	switch (op) {
> +	case GPIO_REGMAP_SET_OP:
> +		*mask = RTD1625_GPIO_OUT;
> +		return 0;
> +
> +	case GPIO_REGMAP_GET_OP:
> +		ret = regmap_read(data->regmap, *reg, &val);
> +		if (ret)
> +			return ret;
> +
> +		if (val & RTD1625_GPIO_DIR)
> +			*mask = RTD1625_GPIO_OUT;
> +		else
> +			*mask = RTD1625_GPIO_IN;
> +		return 0;
> +
> +	case GPIO_REGMAP_GET_DIR_OP:
> +	case GPIO_REGMAP_SET_DIR_OP:
> +		*mask = RTD1625_GPIO_DIR;
> +		return 0;
> +
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}

...

> +static void rtd1625_gpio_irq_handle(struct irq_desc *desc)
> +{
> +	unsigned int (*get_reg_offset)(struct rtd1625_gpio *gpio, unsigned int offset);
> +	struct rtd1625_gpio *data = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned int irq = irq_desc_get_irq(desc);
> +	struct irq_domain *domain = data->domain;
> +	unsigned int reg_offset, i, j, val;
> +	irq_hw_number_t hwirq;
> +	unsigned long status;
> +	u32 irq_type;
> +	int ret;
> +
> +	if (irq == data->irqs[RTD1625_IRQ_ASSERT])
> +		get_reg_offset = &rtd1625_gpio_gpa_offset;
> +	else if (irq == data->irqs[RTD1625_IRQ_DEASSERT])
> +		get_reg_offset = &rtd1625_gpio_gpda_offset;
> +	else if (irq == data->irqs[RTD1625_IRQ_LEVEL])
> +		get_reg_offset = &rtd1625_gpio_level_offset;
> +	else
> +		return;
> +
> +	chained_irq_enter(chip, desc);

> +	for (i = 0; i < data->info->num_gpios; i += 32) {

Can be

	for (unsigned int i = 0; i < data->info->num_gpios; i += 32) {

> +		reg_offset = get_reg_offset(data, i);
> +		ret = regmap_read(data->regmap, reg_offset, &val);
> +		if (ret) {
> +			pr_err_ratelimited("Failed to read IRQ status for GPIO %u: %d\n", i, ret);

You have a device, use dev_err_ratelimited().

> +			continue;
> +		}
> +
> +		status = val;
> +
> +		/*
> +		 * Hardware quirk: The controller fires both "assert" and "de-assert"
> +		 * interrupts simultaneously on any edge toggle.
> +		 * We must pre-clear edge interrupts here. If we drop an unwanted
> +		 * de-assert interrupt below, it will never reach the IRQ core
> +		 * (generic_handle_domain_irq), meaning ->irq_ack() won't be called.
> +		 * Failing to clear it here leads to an interrupt storm.
> +		 */
> +		if (irq != data->irqs[RTD1625_IRQ_LEVEL]) {
> +			ret = regmap_write(data->regmap, reg_offset, status);
> +			if (ret)
> +				pr_err_ratelimited("Failed to clear edge IRQ for GPIO %u: %d\n",
> +						   i, ret);

As per above.

> +		}
> +
> +		for_each_set_bit(j, &status, 32) {
> +			hwirq = i + j;
> +			irq_type = irq_get_trigger_type(irq_find_mapping(domain, hwirq));
> +
> +			/*
> +			 * Filter out the hardware-forced de-assert interrupt unless
> +			 * the user explicitly requested IRQ_TYPE_EDGE_BOTH.
> +			 */
> +			if (irq == data->irqs[RTD1625_IRQ_DEASSERT] &&
> +			    irq_type != IRQ_TYPE_EDGE_BOTH)
> +				continue;
> +
> +			generic_handle_domain_irq(domain, hwirq);

This calls again the irq_find_mapping() (okay, its equivalent) beneath. Using
same IRQ descriptor that you get from above and call handle_irq_desc().

> +		}

		for_each_set_bit(j, &status, 32) {
			irq_hw_number_t hwirq = i + j;
			unsigned int girq;
			struct irq_desc *gdesc = __irq_resolve_mapping(domain, hwirq, &girq);

			/*
			 * Filter out the hardware-forced de-assert interrupt unless
			 * the user explicitly requested IRQ_TYPE_EDGE_BOTH.
			 */
			if (irq == data->irqs[RTD1625_IRQ_DEASSERT] &&
			    irq_get_trigger_type(girq) != IRQ_TYPE_EDGE_BOTH)
				continue;

			handle_irq_desc(gdesc);
		}

However, it uses some kind of "protected" (in terms of OOP) function call,
perhaps the duplication is not a problem as the original (your code) uses
public APIs.

In any case, consider moving the hwirq definition inside the for-loop.

> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}

...

> +static int rtd1625_gpio_setup_irq(struct platform_device *pdev, struct rtd1625_gpio *data)
> +{
> +	unsigned int num_irqs;
> +	int irq;
> +
> +	/* IRQ is optional; operate as basic GPIO if absent */
> +	irq = platform_get_irq_optional(pdev, 0);
> +	if (irq == -ENXIO)
> +		return 0;
> +	if (irq < 0)
> +		return irq;
> +
> +	num_irqs = (data->info->irq_type_support & IRQ_TYPE_LEVEL_MASK) ? 3 : 2;

> +

Unneeded blank line as these two (assignment and a for-loop) are coupled together.

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

> +static const struct rtd1625_gpio_info rtd1625_isom_gpio_info = {
> +	.num_gpios        = 4,
> +	.irq_type_support = IRQ_TYPE_EDGE_BOTH | IRQ_TYPE_LEVEL_LOW |
> +			    IRQ_TYPE_LEVEL_HIGH,

	.irq_type_support = IRQ_TYPE_DEFAULT,

> +	.base_offset      = 0x20,
> +	.gpa_offset       = 0x00,
> +	.gpda_offset      = 0x04,
> +	.level_offset     = 0x18,
> +	.write_en_all     = RTD1625_ISOM_GPIO_WREN_ALL,
> +};

-- 
With Best Regards,
Andy Shevchenko


