Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D06041CB31;
	Fri, 14 Aug 2026 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696487; cv=none; b=jtBmVHFCtlKcIdOz9k1lCbVkvgvGl7Xh2uTxRYKxJy0yk5gmSzxuQPEPoHXnLlX+1Q6QeL1MZodt4+hZNIlCqYox/UWlQn0581gAEuceIfFHK8xL01HsOFoiqfNjEkavNds2eX9J8Xz0qfmy/G8LxdxVS8LaApJk55+f8Ry1SyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696487; c=relaxed/simple;
	bh=buFWeEW9LvwwOZ3vaSL33shbTFTKRmeLX32d2rQm6Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0opVdshK6wJRecVoabQ5ls0KSwKhQJ1C62XttC8g2pa2lsfSTDBUOtQU+isk83Re1UVSW43SyPTzAdTXYStsDcAZAu8toeEwIGXea3MODMCW33RAAk4w4tXxpmSrzeQ8zY8SmpjLpYLGTdVjBLY2k1QBmqQuUoS3f0z/mrGXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUUVbk6a; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUUVbk6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786696468; x=1818232468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=buFWeEW9LvwwOZ3vaSL33shbTFTKRmeLX32d2rQm6Lg=;
  b=bUUVbk6aWgvbld5s65jSguAnyaaFRGllyoD5gtxWZCROxchOfhSMTkkd
   AOK6aTQ40PV7lGiGr8R3moM7USGkY4GHSDtDPsjerpu6yt4y1fvGZvwQr
   Hmy5ywUc0wV3EZYBxsojLnHbk8QABbjGHwpt2CcSEpmaenyMv1TqeB450
   1K+1jE9B3TX6MRcZYWQaCXL0b5sV/jh91BrYx7tSojIqi58jtpOKQojpG
   3EmAVhwXV+++nh306vjiimc+bA3KpV5PD71gIinlNTr8BUM92vXGovdHO
   0TGdL38ZS5so5+t+9kojw5GJfR2HWEda37yYST06gH6bkjnRiNyzMoZLq
   g==;
X-CSE-ConnectionGUID: OZhSKefdSZ+o8anH1mq8ag==
X-CSE-MsgGUID: 9cJ102/YTdq2foa7aBvQHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="91149444"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="91149444"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:34:22 -0700
X-CSE-ConnectionGUID: UtuaY2aBRLactMlU64MIxA==
X-CSE-MsgGUID: HVvin0m5SkWXZopXr/QPBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="268022352"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:34:16 -0700
Date: Fri, 14 Aug 2026 11:34:13 +0300
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
Subject: Re: [PATCH v3 12/14] gpio: regmap: Add optional runtime PM support
Message-ID: <an7TBThRam_n7hKg@ashevche-desk.local>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
 <20260813-ad7768-driver-v3-12-cb554399ad26@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-ad7768-driver-v3-12-cb554399ad26@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 03:57:05PM +0200, Janani Sunil wrote:
> Some gpio-regmap consumers share their regmap with a parent device that
> may be runtime suspended. GPIO register accesses must resume that device
> first.
> 
> Add an optional pm_dev field and acquire it before register translation
> or access. Release it using runtime autosuspend after each operation.
> Keep the device active across the complete direction-output sequence and
> propagate failure when setting the initial output value.

...

>  static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
>  {
>  	struct gpio_regmap *gpio = gpiochip_get_data(chip);

>  
> -	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +	ret = gpio_regmap_runtime_get(gpio);
>  	if (ret)
>  		return ret;
>  
> +	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +	if (ret)
> +		goto out_pm_put;
> +
>  	/* ensure we don't spoil any register cache with pin input values */
>  	if (gpio->reg_dat_base == gpio->reg_set_base) {
>  		ret = regmap_read_bypassed(gpio->regmap, reg, &val);
>  		if (ret)
> -			return ret;
> +			goto out_pm_put;
>  
> -		return !!(val & mask);
> +		ret = !!(val & mask);
> +	} else {
> +		ret = regmap_test_bits(gpio->regmap, reg, mask);
>  	}
>  
> -	return regmap_test_bits(gpio->regmap, reg, mask);
> +out_pm_put:
> +	gpio_regmap_runtime_put(gpio);
> +	return ret;
>  }

Instead of adding ugly goto:s, I would rather define the guard and acquire and
use in the same way as other PM_RUNTIME_ACQUIRE*() work.

-- 
With Best Regards,
Andy Shevchenko


