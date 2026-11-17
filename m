Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934263;
	b=Ed/momU7PgTIto65E6RwwqREr8ZG86ILxaeyOfHMuYK/T+A+ul3+hCU9SRJhTk74nWAS
	 AT8P3vJhnWzBLQC+4Xvs1pj8xWCmwqaaS+q6eHIAlZKmPMuct8lLNKgXLR4mvU++UH0f8
	 4RywKO8gLsdwOlnEMvh2Abz6DBfRME++WJyFveAB6SL3tsEPsv1GDVsKBajpRr/j1Fte+
	 Qsv+YAtEsEyd/YAGa6kOZ25CyyeM3o5seNZpWDaX/WGUW4GA/urfI1Tg5628ScDUIp0LH
	 7tA4hDJk0z1Zj3WpkvnDc5i6HShcdDuvtl6jtbHsfvAF3i2hUm3xUQOc+wyxjFDEUfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934263;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=9zOO5rAdZD5bgN+m83G9k8CmEqp9m+/UuZhzOcs9Gjc=;
	b=WWrimjMs8FByj0dJfFeuiivVfytvs4SvBJlP6mP/XtlPbfJSCRVtVNp+FhrHdk6zu9CH
	 eKwq+NOT2+yHWKWL3UI4ouh3VR/sl7cBDr7qStXoN7O3lwI+aXcoau/7lRG7euNYja1U4
	 Lhij83TrVEmn2syqIS3Blw91ZVsKKhvtQ5sda6F3DCyCbVvRoV9R6iGp9TID6eEUup6Id
	 L8m0JBQCROmuSSFKbIu1CzA/2kZfbvLUI8/RgFfA7cflNtFPqmLJSSRgOrI3zob5he7G/
	 8vLbyFfz8k7U5L3nHpQlw2Xny3sPkormUY+cu+vvsx/4qlM4s1AiuLDMZPQpLulTpBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LnZfU0ID;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D80606A31C;
	Tue, 17 Nov 2026 16:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D80606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LnZfU0ID
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794934262; x=1826470262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oo2HLD57CgDs74O09Fghy16vcY7J9AgvHbmS51v8TSw=;
  b=LnZfU0ID6/cLl01vSRfJvV5LuhtkvJAiYEpYQ0M2865zT48PsSdcdj9d
   P+MsmT9/pru+1DhQ+jUXL8EKU7rZKN5HYg8jxlXT2Ltb1lpzYnQPqS2J3
   AaTUctKbtHryS48it30pE7bAk04QHizD4VPlm8izN7mOZ/LVuQ3sI/zMu
   0QJ5zWGEwwc7jZyZ8MNL86nztvDdyl10qJoIK7uKxFVIbvxZ+rW4DBBMc
   8qZEe6uHMSWHWyFQ3/GPOJbLSD2TnI8/MGNki6Bpekib0dCR3rSV4sNSH
   AUhOj51OF5M27X1ZJr9kNwshDc0NKfwyeLLpKvA4MCr7Izz27EvEBlPWG
   A==;
X-CSE-ConnectionGUID: ou6TTQC1QKGa2VddEfsO+Q==
X-CSE-MsgGUID: 7425SbxSRM2KRFUiJZejkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3755780"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3755780"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:51:01 -0800
X-CSE-ConnectionGUID: 6tM/lD3oRAq3KwdQab2P1g==
X-CSE-MsgGUID: 4zP3eVtsQQeWnvSFsHSBjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9790442"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:50:56 -0800
Date: Tue, 17 Nov 2026 18:50:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com, amin.gattout@gmail.com,
	antoniu.miclaus@analog.com, gregkh@linuxfoundation.org,
	mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: adc: at91_adc: use local struct device
 pointer in probe
Message-ID: <avyF7vllhuE-cJA0@ashevche-desk.local>
References: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
 <20261117140510.391907-3-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117140510.391907-3-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 04:05:09PM +0200, Abdelnasser Hussein wrote:
> Introduce a local struct device pointer in at91_adc_probe() and use it
> in place of &pdev->dev and &idev->dev throughout the function.As a
> result, messages previously logged against the IIO device are now
> printed using the platform device being probed.
> 
> switch devm_iio_device_alloc() to use sizeof(*st) instead of
> spelling out the full private structure type.

...

> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;

Before doing this, switch to device_property_*() / fwnode_property_*() APIs
first.

...

> -	st->caps = of_device_get_match_data(&pdev->dev);
> +	st->caps = of_device_get_match_data(dev);

In a separate patch (perhaps in the first one in this block, convert this
to use device_get_match_data() and add an error check (for now until we able
the driver_override case to address differently.

>  	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
>  
>  	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop))
> -		return dev_err_probe(&idev->dev, -EINVAL,
> +		return dev_err_probe(dev, -EINVAL,
>  				     "Missing adc-channels-used property in the DT.\n");
>  	st->channels_mask = prop;
>  
>  	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
>  
>  	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop))
> -		return dev_err_probe(&idev->dev, -EINVAL,
> +		return dev_err_probe(dev, -EINVAL,
>  				     "Missing adc-startup-time property in the DT.\n");
>  	st->startup_time = prop;

...

>  	if (st->caps->has_tsmr)
> -		ret = devm_request_irq(&pdev->dev, st->irq,
> +		ret = devm_request_irq(dev, st->irq,
>  				       at91_adc_9x5_interrupt, 0,
> -				       pdev->dev.driver->name, idev);
> +				       dev->driver->name, idev);
>  	else
> -		ret = devm_request_irq(&pdev->dev, st->irq,
> +		ret = devm_request_irq(dev, st->irq,
>  				       at91_adc_rl_interrupt, 0,
> -				       pdev->dev.driver->name, idev);
> +				       dev->driver->name, idev);
>  	if (ret)

> -		return dev_err_probe(&pdev->dev, ret,
> +		return dev_err_probe(dev, ret,
>  				     "Failed to allocate IRQ.\n");

In a separate patch, before this one drop this dup message. It's printed
by the devm_request_irq().

...

>  	adc_clk_khz = adc_clk / 1000;

At some point better to use HZ_PER_KHZ instead of odd 1000.

-- 
With Best Regards,
Andy Shevchenko


