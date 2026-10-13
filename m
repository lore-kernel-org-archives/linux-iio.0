Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F6501F45;
	Tue, 13 Oct 2026 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900459; cv=none; b=I7NsYF8rS6/haL75Bot/8QEuYeokNqVpy4cekGfjPxpW00WSD4ThUD7Gfh4s150lMXYOXu7mk3xDZAygVHNM/qi0J4+GO+SlJOnC4ypSQmj04TOosH9rDY+YnSeCsEhKUSWGS5KgPddCIouzkIINRX/ff70Smyi1FFTy17uziac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900459; c=relaxed/simple;
	bh=W88mS6YBE8sTQ1nme8JepyXgE86BvQHetXAgV3IwrYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knCV3TpkbuibH4a3v5z+DnQubNFqRm8SOCfeioEKsyXG59v0Mvl+4GZOTqbYhiXnsJasfiAKF/kRry9jMtFwZoyqgOCx9ZHcJM9SdQ48D9gTg+y7cnV73v0KtdaHRlQcEtPaygpwysxYxXMjwEyVn1hkM24KHiG4C0gnTRGl7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2ogaP+E; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2ogaP+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791900458; x=1823436458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W88mS6YBE8sTQ1nme8JepyXgE86BvQHetXAgV3IwrYI=;
  b=g2ogaP+ExlWuLvDFDfk1Xq4RifkML1d7HkG+F+txTLDwp/O1K2KCWoZO
   CU5jrNQVV0iXGjCBtCc9fc9zZoDZ6403XXf+SGBO2gxeZoQIBMJiQGptW
   m+gaIiHB1A/31kEbr8hefw7l8VFYnSFBU/b7d17ltpIV95YSInqn8iW81
   BWxxKo0/1cCvdlytTlIdta3ealAwW9ShGxzvbnRV6yWVrvX3gzHngOVQ8
   dubioI6AhkpfFPCGlv7J0q1l36dsoiHdRoj+WyVM2MkiD9gSVn+vbwW9M
   ej0Dvf3osbh7P8A0afozo7rO8a3z5vlYQtKsLvbc5vS0FunNoxwG9SXjj
   A==;
X-CSE-ConnectionGUID: X4VICJTTSx2F0pOrKnvOUA==
X-CSE-MsgGUID: MSan89ZXS7eyZmCJ9W1pYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="642338"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="642338"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:07:33 -0700
X-CSE-ConnectionGUID: 6cANfGRZTGmuiPQL/vdfhw==
X-CSE-MsgGUID: XIeAE0B5R32LAOgDkfUP3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1509260"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:07:30 -0700
Date: Tue, 13 Oct 2026 17:07:28 +0300
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
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c14: add gpio support
Message-ID: <as47IMM9rtBCAH0-@ashevche-desk.local>
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
 <20261009-iio-adc-ti-ads112c14-gpio-v2-2-3231a795fa63@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-iio-adc-ti-ads112c14-gpio-v2-2-3231a795fa63@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 09, 2026 at 06:25:52PM -0500, David Lechner (TI) wrote:
> Add support for using the AIN4/GPIO0 to AIN7/GPIO3 pins as GPIOs when
> the gpio-controller property is present.
> 
> Pins that are already used for something else according to the
> devicetree are excluded from the valid GPIO mask. This includes analog
> inputs and excitation current outputs used by channels, REFP/REFN when
> an external reference is used, the /FAULT and /DRDY interrupts and the
> external clock input.

...

> +	for (unsigned int i = 0; i < ADS112C14_NUM_GPIO; i++) {
> +		data->gpio_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s:GPIO%u",
> +						     dev_name(&indio_dev->dev), i);
> +		if (!data->gpio_names[i])
> +			return -ENOMEM;
> +	}

I am sorry, I still didn't get what's wrong with the dash (technically
speaking)? So, this may use devm_kasprintf_strarray().

-- 
With Best Regards,
Andy Shevchenko


