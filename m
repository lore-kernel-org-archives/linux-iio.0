Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D53AA1B6;
	Tue,  7 Apr 2026 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565787; cv=none; b=hBaxZv9biXXpXRwCNPQnEOUiBMzWDvBTSAkI31xdkK4ZYZ5Z03k2x/y8S54s4a4sntcJzrk2mg7k+BZafjF3QBCXM3sG3sVIF2/GYUr9W5r8/NB3/eOMsjHlMF1O/k/R0X1gmn9btkPU6eS1K4aRL44ivBl2vLREzypb+mKHyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565787; c=relaxed/simple;
	bh=DlrDqLdbDDE3CTEf3b9RkBTGL1z8gnFojR+H8MFtTqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcDWmFrsDmUqJEduWRuOjB2ZQo+8cFHfwYFBw2jvTYAQe2n+8r7NkpPrDXHsDBUJ0MdFKcvwTC0noyErhenEEMPbzgPUrGhD+3jGWCx7TuRvI/qfnzzYKDhXYKv/asWXZySG5//WxThrwKTPtK5icTP0MGMRCuomoEUokAymnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7QJx8WE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7QJx8WE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775565787; x=1807101787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DlrDqLdbDDE3CTEf3b9RkBTGL1z8gnFojR+H8MFtTqw=;
  b=c7QJx8WEgszc22b0yvQdfqGtjmJsDeXWi0nAoExrNsmcyN2B/jv/OYO9
   JS7ACLyoA+/Z1tG1aOGrYtkberUtnUn40My0XO1DRh6zgQzkzY1kp5PlO
   qUTIsSKypCEa9GX//eIIId4mK0+JqHwOS0wPhp3nORHxevhaYwcJ1KgRv
   Xwm+Pde0CLUN2lwi0hOGnrr+vAHvbPsLjpHfHlZX4qVLSkNb4Bd5qOs4T
   SoswZbb6PCEkF2+NRbhW7tFX+5IUDIVHle84L1NAGQluzVG3lHyIPbHwl
   LCb0+c3em+f+a6sSZ8pFjlTwD7G2w2neAff7e6wPQfEnoBZ/NxDvDN5Ea
   Q==;
X-CSE-ConnectionGUID: XwKVaE2iTbGv2KgZqJ0NVg==
X-CSE-MsgGUID: m9oykNXOROyK4YSx64olSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80385928"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="80385928"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:43:03 -0700
X-CSE-ConnectionGUID: 1PhVyMlXSh2EqfEEd8GURA==
X-CSE-MsgGUID: 1FHUMBdOSWWoQCck4HlUOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="266139015"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:43:00 -0700
Date: Tue, 7 Apr 2026 15:42:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] iio: ssp_sensors: use devm APIs for mutex and IRQ
 resources
Message-ID: <adT70UcWq5EuMwx2@ashevche-desk.local>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
 <20260406080852.2727453-5-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406080852.2727453-5-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 06, 2026 at 01:38:51PM +0530, Sanjay Chitroda wrote:

> Convert mutex initialization and IRQ registration to use devm-managed
> helpers, tying their lifetime to the device.
> 
> This removes the need for explicit cleanup in the error and remove
> paths, as the resources are automatically released on probe failure
> or device unbind.

...

> -	mutex_init(&data->comm_lock);
> +	ret = devm_mutex_init(&spi->dev, &data->comm_lock);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Failed to init comm_lock mutex\n");

The message is not needed here.

> +		goto err_setup_spi;

This is half-baked solution. When devm is in use there is shouldn't be goto.
after it.

> +	}

...

> -	ret = request_threaded_irq(data->spi->irq, NULL,
> -				   ssp_irq_thread_fn,
> -				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				   "SSP_Int", data);
> +	ret = devm_request_threaded_irq(&spi->dev, data->spi->irq, NULL,
> +					ssp_irq_thread_fn,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"SSP_Int", data);
>  	if (ret < 0) {

>  		dev_err(&spi->dev, "Irq request fail\n");

Now you should also remove this dup message. devm APIs in IRQ core print
a message for you.

> -		goto err_setup_irq;
> +		goto err_setup_spi;
>  	}

-- 
With Best Regards,
Andy Shevchenko


