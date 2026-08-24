Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E75B39EF20;
	Mon, 24 Aug 2026 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558733; cv=none; b=awB6eiXScczXggOrn7yQQH6vzDCKqqYnHreZBMblWe4lJotu2eWjtSRZHu/IW/SHymMdNCrG1VdPuxgXf6UKtPI2UqLtGGOUtl7Ia9FmoXh7gkOdqxQUqmWXUBQBekrnU7AAily3y+TxLCExKQbsyBrtqzpdIjAtk3jpIrCxc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558733; c=relaxed/simple;
	bh=4oh/8mRps3F9XgDqX8NjSmB9AyEsobz0Ra4YUyp0Pv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccAc5eW15K7MWZNd6bPLVqVXAfOiXKTdiYTVebPGdO0y5VRIDXEHZ8t4ENP2AN6l593YmcAEeQdzxBBDGb9rOh+IexEiErnFdE4ktbcEIcknjIe7MasTOgrGOul0fjSfvApeaL9nqq8JvEIRqiVCGwHwDZ67ufUtivGFqn2BF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcraU5qj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcraU5qj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787558731; x=1819094731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4oh/8mRps3F9XgDqX8NjSmB9AyEsobz0Ra4YUyp0Pv8=;
  b=fcraU5qju2p4voIvEtEEvrolNU1ctVOZAhuNSJBLuqWcz041I4gUFc8g
   CnVBNql3GQnR2Yt8Pg6DTvTfqonGBrWUF5U4DTSRuH00qL25kyNp7YLbU
   eLFrODSl2Xr0v2EoTuJ+A5SK0re5izupkDyhdpCEyKIahIPgFN6XC4uDX
   7DQ0lDV/G/wkezgg5VLQkpZeQ/Wos76XkmIiePgMzIG2HYsFQOJ0hl6R4
   1rppRhISTZBgplntU+A3gSldyxRjheOJcfBrV6XdD4SegjpVHXPlf4xbc
   mQvm3QE/yauOwKdYJqTsAQyZUwwnSPr8JwwcfbnKtYaqgzDsc0oQlca4C
   g==;
X-CSE-ConnectionGUID: EFABZwnHQtCT0SVoYSyNJQ==
X-CSE-MsgGUID: vNkyNtBCSW+NqdSiccg5ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87768366"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87768366"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:05:30 -0700
X-CSE-ConnectionGUID: LfWvfzzUTE+29Pn3Ua9PvQ==
X-CSE-MsgGUID: 8ZudAQ4sQGKS5oMebIz82w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264314168"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:05:24 -0700
Date: Mon, 24 Aug 2026 11:05:22 +0300
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
Subject: Re: [PATCH v4 12/14] gpio: regmap: Add optional runtime PM support
Message-ID: <aov7QpTVLDZ9PEkw@ashevche-desk.local>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-12-bb8fbd06d4eb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-ad7768-driver-v4-12-bb8fbd06d4eb@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 21, 2026 at 04:07:05PM +0200, Janani Sunil wrote:
> Some gpio-regmap consumers share their regmap with a parent device that
> may be runtime suspended. GPIO register accesses must resume that device
> first.
> 
> Add an optional pm_dev field and acquire it before register translation
> or access. Release it using runtime autosuspend after each operation.
> Keep the device active across the complete direction-output sequence and
> propagate failure when setting the initial output value.

> struct gpio_regmap {

>  	unsigned int reg_clr_base;
>  	unsigned int reg_dir_in_base;
>  	unsigned int reg_dir_out_base;

> +	struct device *pm_dev;

Please, move it out of these fields, the below is coupled with reg_dir_*
in some way.

Having this somewhere near to

	struct gpio_chip gpio_chip;

above makes more sense.

>  	unsigned long *fixed_direction_mask;
>  	unsigned long *fixed_direction_output;

>  };

...

> +static int gpio_regmap_runtime_get(struct gpio_regmap *gpio)
> +{
> +	if (!gpio->pm_dev)
> +		return 0;
> +
> +	return pm_runtime_get_active(gpio->pm_dev, RPM_TRANSPARENT);
> +}
> +
> +static void gpio_regmap_runtime_put(struct gpio_regmap *gpio)
> +{
> +	if (!gpio->pm_dev)
> +		return;
> +
> +	pm_runtime_put_autosuspend(gpio->pm_dev);
> +}

> +DEFINE_GUARD(gpio_regmap_runtime, struct gpio_regmap *,
> +	     gpio_regmap_runtime_get(_T), gpio_regmap_runtime_put(_T))

This is not used, it's for guard()() case.

> +DEFINE_GUARD_COND(gpio_regmap_runtime, _try,
> +		  gpio_regmap_runtime_get(_T), _RET == 0)

Yep, but also makes sense to add

#define GPIO_REGMAP_RUNTIME_ACQUIRE(_dev, _var)			\
	ACQUIRE(gpio_regmap_runtime_try, _var)(_dev)

#define GPIO_REGMAP_RUNTIME_ACQUIRE_ERR(_var_ptr)		\
	ACQUIRE_ERR(gpio_regmap_runtime, _var_ptr)

...

> +	chip->can_sleep = config->pm_dev ||
> +			  regmap_might_sleep(config->regmap);

Fits a single line.

...

>   * @ngpio_per_reg:	(Optional) Number of GPIOs per register
>   * @irq_domain:		(Optional) IRQ domain if the controller is
>   *			interrupt-capable
> + * @pm_dev:		(Optional) Device to use for runtime power management.
>   * @reg_mask_xlate:     (Optional) Translates base address and GPIO
>   *			offset to a register/bitmask pair. If not
>   *			given the default gpio_regmap_simple_xlate()

> struct gpio_regmap_config {

>  	int reg_stride;
>  	int ngpio_per_reg;
>  	struct irq_domain *irq_domain;
> +	struct device *pm_dev;
>  	unsigned long *fixed_direction_mask;
>  	unsigned long *fixed_direction_output;

Oh, this needs synchronisation of the ordering of members and kernel-doc
descriptions. Not a problem for you or in your patch series, just let's
try to find the best fit for a new member from day 1.

Like in the above local structure I suggest to put this just after

	struct regmap *regmap;

-- 
With Best Regards,
Andy Shevchenko


