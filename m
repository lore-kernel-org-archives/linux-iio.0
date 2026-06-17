Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231E30674D;
	Wed, 17 Jun 2026 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692379; cv=none; b=WKtDJ18efILzbum0kWYlnUOrbzHwB1o9EFUw5iXrwb//2u/zfNm1KHtKpU1CnmoiF1bj0RwXeO3Gi4qwHQ1Wdm+oPwpbYbzqk05r1JDYKh+NZbLfcfcvkI9OqGhBX0AUVsLQgwbEe5rUkNGAb2Nx72sJBf01EOOaPS/oehl+rDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692379; c=relaxed/simple;
	bh=X3winq5qm2HIT6UC0/yxmrF0jTAu33Gl4aE30OAa1oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cx1nVbjJ4QcRWGCGEdc3NBw7nwVV5ycwaUlBJo7N759M1PLbROwYxFdDBokp4xrPU9q/ED2ljiADzotaYGSxGwaCQuJOaH7QsC0AYVxVAfR4OhQKjbHpMEuJD/b5Wpr+7bXJfsKyovrB4hd0ESD1P/yIE6sSTcp3kBGNAWqk1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAlEW2mZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAlEW2mZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781692377; x=1813228377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X3winq5qm2HIT6UC0/yxmrF0jTAu33Gl4aE30OAa1oI=;
  b=kAlEW2mZ3uZngNOBMtaNvhBeyWkA7uhdlSO9KJL000T459Mmv8rJphOs
   76D+hamhhVKLHIoWzEDkbwOzahCRV4UH1lCrVtOKpWI8WnFATq3M6t04E
   s3XVML4tSvItwDI7cHgG/dwTXeKu4KKXrcjUblZk/gGZ1VK5DANfj/N4o
   +zxN+MD962PFEEF9bcVVPkl7EmS9j0u5q4WroC+BG4fA9n2SxhCgYUoqz
   IK3eH3jdhv38N8Yrm2CPRFCpyJYD2w3E6G/aQDFiDiQhor1aEm3RyzMbm
   CUwyOY8oyCRqgJZ+tqSUziZ/OX7WZHNicSY6inVqZXd1Wx4mtk5KsSAFl
   Q==;
X-CSE-ConnectionGUID: VU2zsj0lQC2AxCYJ51w9Ww==
X-CSE-MsgGUID: 29+8XFCgQCmEeh6slDi6mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93594475"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93594475"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:32:57 -0700
X-CSE-ConnectionGUID: leLgKuVYTtSbL+4Q82bKlQ==
X-CSE-MsgGUID: Uko2CTWXRUGLJxZ5qEEMcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="247139272"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:32:53 -0700
Date: Wed, 17 Jun 2026 13:32:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
Message-ID: <ajJ30lHG5lEXri7I@ashevche-desk.local>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-3-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 17, 2026 at 11:00:19AM +0300, Svyatoslav Ryhel wrote:
> Remove driver-specific regmap wrappers in favor of using regmap helpers
> directly.

OK, let's go with this variant.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Some side notes below for the record.

...

>  	struct lm3533_led *led = to_lm3533_led(led_cdev);
>  	unsigned enable;

Oh, besides using the old way of declaring unsigned int, it most likely
just needs to be kstrtobool().

>  	u8 reg;
> -	u8 mask;
> -	u8 val;
>  	int ret;
>  
>  	if (kstrtouint(buf, 0, &enable))
>  		return -EINVAL;

We should unshadow error codes (it may return more than -EINVAL).

>  	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
> -	mask = LM3533_REG_CTRLBANK_BCONF_ALS_EN_MASK;
>  
> -	if (enable)
> -		val = mask;
> -	else
> -		val = 0;
> -

...

> -	if (kstrtou8(buf, 0, &val))
> +	if (kstrtou32(buf, 0, &val))
>  		return -EINVAL;

Like in the previous case we should unshadow error codes.

-- 
With Best Regards,
Andy Shevchenko


