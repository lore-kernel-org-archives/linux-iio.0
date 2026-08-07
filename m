Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129E24369A;
	Fri,  7 Aug 2026 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060948; cv=none; b=MVZaK+0yrm+GuOuS39CWudjaTN/hLhC8qMNQCIXZi+RqpKb6VCztlfI4AdJH2lPRpb0ubwnuvzqrQTDLpIGEC+efR+hKC1B27BnPSJX9XveE0GsNptIWsX20XF0y0AKakiymHHpeZhrrinY4ZDUdxmB3jIGcJuqJ7mEGrYfRu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060948; c=relaxed/simple;
	bh=es/3Rp5Kv8CoLiBfOFFo/p1hSqvIEaneMfjF49har/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyj1JvtfmbBq3lGrQuJZhhg62V6RGufRa0AYgPFitFiHWfy2kani777rHVDyymqWktsxBXvYuRq5bgQJ+w9yIAHAeK4Em/1Ye2j31o3JUafD2a/GOnbUyafOKfbmB0ij1u1sfRTutLuhl3NMovt9QVQax56oSOrW9WAyGfVl534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQiZ55aO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQiZ55aO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786060946; x=1817596946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=es/3Rp5Kv8CoLiBfOFFo/p1hSqvIEaneMfjF49har/o=;
  b=XQiZ55aOxeoe5IqlpzoOvBLHSKHIdNYTv1fWSaZ0hsmqKezFvkLhOiVV
   bXUvDziCa2AKk2kWCOnqvB9AVCm00Q+RLL5ZZpjToo1gvzLaFAeshmSdj
   Ka4OpkNWXZIQorwTQTskRuobylyxhsDmaUv8JtO6JHt91zBhNImRThwDq
   l4tdUm861MCkiwR/2msG9lLstVR+MaPG93lUTMl1Oov++hVggAc62B4W3
   IutEGWu2/BDRG69AhPwclqCYLfh5YMVVf2vFzaflQ0YwyWE2zVtNOu4gj
   46/JKHQNVc1BXs7ZxVd6R7OtJtZZ4yL0Ym0mHxgGhrj0LWIUtfJtZMpvu
   A==;
X-CSE-ConnectionGUID: PF+xRugWQw+XlEKtE2ltvA==
X-CSE-MsgGUID: C0cbY1CzREynySHVQCtmaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="112217474"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="112217474"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 17:02:23 -0700
X-CSE-ConnectionGUID: 0Dh23k81SxC4uoCQNwRJ0w==
X-CSE-MsgGUID: WuSWqERSTqC7KGQkPpxiuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="261730580"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 17:02:17 -0700
Date: Fri, 7 Aug 2026 03:02:15 +0300
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
Subject: Re: [PATCH v2 5/7] gpio: regmap: Add runtime PM and
 read_output_reg_set support
Message-ID: <anUgh6qgESzpRJwa@ashevche-desk.local>
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
 <20260806-ad7768-driver-v2-5-027ac5e2a641@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-ad7768-driver-v2-5-027ac5e2a641@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 06, 2026 at 05:41:24PM +0200, Janani Sunil wrote:
> The new pm_dev field in gpio_regmap_config allows a driver to supply a
> device for runtime PM. All operations call pm_runtime_resume_and_get()
> before accessing the regmap and pm_runtime_put_autosuspend() on return.
> 
> The new read_output_reg_set flag when set, gpio_regmap_get() checks the
> pin direction first and reads from reg_set_base instead of reg_dat_base
> for output pins. Requires both reg_dat_base and reg_set_base to be
> configured.

...

> struct gpio_regmap {

>  	unsigned int reg_clr_base;
>  	unsigned int reg_dir_in_base;
>  	unsigned int reg_dir_out_base;
> +	struct device *pm_dev;
> +	bool read_output_reg_set;
>  	unsigned long *fixed_direction_mask;
>  	unsigned long *fixed_direction_output;

>  }

Have you run `pahole`? Is it okay to put bool there and not after one of
unsigned int:s (just from the given context, it might be even better location)?

...

> +static int gpio_regmap_runtime_get(struct gpio_regmap *gpio)
> +{
> +	if (!gpio->pm_dev)
> +		return 0;
> +
> +	return pm_runtime_resume_and_get(gpio->pm_dev);
> +}
> +
> +static void gpio_regmap_runtime_put(struct gpio_regmap *gpio)
> +{

> +	if (gpio->pm_dev)
> +		pm_runtime_put_autosuspend(gpio->pm_dev);

Same pattern as per above.

> +}

...

> +static int gpio_regmap_get_direction(struct gpio_chip *chip,
> +				     unsigned int offset);

Can this be avoidable?

...

>  	/* ensure we don't spoil any register cache with pin input values */
>  	if (gpio->reg_dat_base == gpio->reg_set_base)
>  		ret = regmap_read_bypassed(gpio->regmap, reg, &val);
>  	else
>  		ret = regmap_read(gpio->regmap, reg, &val);
> -	if (ret)
> -		return ret;
> +	if (!ret)
> +		ret = !!(val & mask);
>  
> -	return !!(val & mask);

You want regmap_test_bits() in one case, and the regular pattern in the other.

> +out_pm:

labels should be marked better to show what will be when goto them.

out_pm_put:

> +	gpio_regmap_runtime_put(gpio);
> +	return ret;

...

> +out_pm:
> +	gpio_regmap_runtime_put(gpio);
>  	return ret;

Ditto.

...

>  	ret = regmap_read(gpio->regmap, reg, &val);
>  	if (ret)
> -		return ret;
> +		goto out_pm;
>  
>  	if (!!(val & mask) ^ invert)
> -		return GPIO_LINE_DIRECTION_OUT;
> +		ret = GPIO_LINE_DIRECTION_OUT;
>  	else
> -		return GPIO_LINE_DIRECTION_IN;
> +		ret = GPIO_LINE_DIRECTION_IN;

Also can be transformed to use regmap_test_bits() (but in a separate change).

...

> struct gpio_regmap_config {

>  	unsigned int reg_clr_base;
>  	unsigned int reg_dir_in_base;
>  	unsigned int reg_dir_out_base;
> +	struct device *pm_dev;
> +	bool read_output_reg_set;
>  	int reg_stride;
>  	int ngpio_per_reg;
>  	struct irq_domain *irq_domain;

`pahole`?

-- 
With Best Regards,
Andy Shevchenko


