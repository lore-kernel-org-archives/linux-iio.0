Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC67342538;
	Thu, 26 Mar 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552548; cv=none; b=cc83DZtRM8b9PlCwdtvMQWHMVFM0DE3cmyj6+c9QVCeWD1ui3QBnKRWsgve7qsZVYIR0rc8cnmsK266k8wslNl2/nHdHLB3c8RqtejqnZYg3UUWQM2534Ll8utWu4p6onqNs5QPXbASWJcrYzma0aqL7uIXkdrtHSvNUbRLG0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552548; c=relaxed/simple;
	bh=i+Os7mteNmCXHBK6JmIglsPE9gNGB2IINyRSnShmEqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkaQcoHUhTcxoWS/HMs0EJfcLxf+MIkWn0jOthvpwwGvuAhIyCex1fNhmW7/OBtQOArtD0zQnjdu/q2ZbPMXMJre2uxt6UHs3ldJn79We4LfWi30J1xV8SpJon7g8JEfVTRBKqFWKuuwYzuWYP+xSrRxmOh0+08qe3KRgtImJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmdSCln/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmdSCln/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774552548; x=1806088548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i+Os7mteNmCXHBK6JmIglsPE9gNGB2IINyRSnShmEqg=;
  b=YmdSCln/TaRarxMbFiucAIrkZmaXplMdD93vVC0N8rbH+1yak2KwHt08
   ox3XavpabfgYLyfr/FZQQQjGkEIwN4Rfi5aFrWMe6EnGrbNeis/sUDdWz
   WWaAYdDQvCdO+4PLGSNf471ovAoIQXGfRv1rfGREAO/xAoUlOqjDFBGMt
   W1MUFcTgAHqM5NoVrGt4xUeQ4fB5bjt18qY7rWYoUABXr3Dq64nmaBTjR
   7BAAQ4hVDeMar7N1LsiPgWps55C2s5s8OgmSekMmRIUiwbkwwn0oYblyk
   19NvD5CRz8hpy6f2rzEPVr8f71F+rlKFGDlYvKojXKkOFdOiSO9DVnb8K
   w==;
X-CSE-ConnectionGUID: 1nxalpMlQ8uQqQ3PO5O3aQ==
X-CSE-MsgGUID: DmZG3AS6QdmrMqZwdq697w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79222372"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="79222372"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:15:48 -0700
X-CSE-ConnectionGUID: qSg8hMqyRn6wW4vkCnul/g==
X-CSE-MsgGUID: WpKy9vPxQua8D5G7Go/kTQ==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:15:44 -0700
Date: Thu, 26 Mar 2026 21:15:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] iio: adc: ad799x: use devm_iio_device_register
 and drop remove()
Message-ID: <acWF3erQXdxlxGAH@ashevche-desk.local>
References: <20260326180529.19154-1-architanant5@gmail.com>
 <20260326180529.19154-5-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326180529.19154-5-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 11:35:29PM +0530, Archit Anant wrote:
> Convert the driver to use the device-managed versions of
> iio_device_register(), iio_triggered_buffer_setup(), and mutex_init().
> 
> Use devm_add_action_or_reset() to ensure that the VCC and VREF
> regulators are disabled safely and in the correct order during
> driver teardown or probe failure.
> 
> Because all resources (buffer, regulators, IRQs, IIO device, mutex)
> are now fully managed by the devm core, the unwinding order is
> guaranteed to be correct (reverse order of allocation). We can now
> safely remove all manual error handling goto labels in ad799x_probe()
> and delete the ad799x_remove() function entirely.
> 
> This eliminates boilerplate code and prevents potential resource leaks.

...

> -	mutex_init(&st->lock);
> -
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_mutex_init(dev, &st->lock);

Looking at how far from the start of probe this is done, it's prone to problems.
What we need is to decouple this change and move mutex to be enabled before any
interrupts or other async events may happen.

>  	if (ret)
> -		goto error_cleanup_ring;
> -
> -	return 0;
> -
> -error_cleanup_ring:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -error_disable_vref:
> -	if (st->vref)
> -		regulator_disable(st->vref);
> -error_disable_reg:
> -	regulator_disable(st->reg);
> -
> -	return ret;
> -}


-- 
With Best Regards,
Andy Shevchenko


