Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF68416CF3;
	Tue, 16 Jun 2026 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599450; cv=none; b=R1FM4ZV1xKQgS10+SejNqdLVOAnT1XKavkdR8oB19knoRGyk0nTXgqjyHQqu7OBYVRR9oPW29U0kDzpPnBf6uaUNRpVkCMnE/bWsRpiqOalF2yhrnYUYY5hoItl4zmzI0yx4GWUQjlui/zh05Hd/gPv6gMScb59mJOfbIglUknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599450; c=relaxed/simple;
	bh=FhLngcdhrFatMXOMme+p9YhuKq8ruXJClZ+5lcC0kk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlQUUkSu9ZpjQJkCqpVR1liqVkBf7qqPcVHWU3daFTlUsDa4PJadDUGk7JZzK8+QzJALHHMpTUl8N77gwEFHbUGOTG7C+b7iARrczfcnsZ/yYLyo8NzfNe/5O4i4n88xDyqt66vSG3URH/1hse0lgFfVIszfYa6SjapWlNowHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGbJby70; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGbJby70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781599449; x=1813135449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FhLngcdhrFatMXOMme+p9YhuKq8ruXJClZ+5lcC0kk8=;
  b=KGbJby70E6nJhSuqUoyy7437OqnSneaAQ7P93oZuR0X0B3Ppz8+GsQmh
   +c5mL0rELmEspiultaKHHasJdGh2XB2UJ1iXm+QiH+oujscrrl3ZxAFXA
   9EG6hCmpjPgncPJBsQOiyR1/LMHZlgGnSEUC1pDJW2i4s5IEqPNllyhog
   TR/F8ocfDfduzWtlwj3JHxp+DfwVwGm4o1q1QFH9ZyY7e88U9TtQy4wZO
   c3CjGPdy53sVrhNdXnBP8ruD75lCZqndHW+ZundiK2PF3nq9ubsW0ibBl
   t6OVuPj5dAjQmOlbLYA6A22WD0TwMmZVJyIZUnOSwQNbyW4+2Eh3fG6v3
   g==;
X-CSE-ConnectionGUID: lrQFzzGoQpiv2AI9wg/1rQ==
X-CSE-MsgGUID: zDWftkkaRAiihRUlTl/A5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="81366265"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="81366265"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:44:09 -0700
X-CSE-ConnectionGUID: NYHXuI7eR16VckzlCoHr+A==
X-CSE-MsgGUID: 0cFPfZyGTWyAJC8ibiyTvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="243551804"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:44:07 -0700
Date: Tue, 16 Jun 2026 11:44:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxsd9: Fix runtime PM error handling and
 scoping
Message-ID: <ajEM1ZlIAP7XNHHg@ashevche-desk.local>
References: <20260615200330.33207-1-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615200330.33207-1-birenpandya@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 01:33:30AM +0530, Biren Pandya wrote:
> The kxsd9 driver uses pm_runtime_get_sync() in multiple places without
> checking its return value, which can lead to silent failures. It also
> relies on manual pm_runtime_put_autosuspend() calls in various return
> paths, which is prone to memory leaks if a return path is missed.
> 
> Fix the runtime PM handling by using the new scoped guards and proper
> error checking:
> - In kxsd9_write_raw() and kxsd9_read_raw(), use the scoped
>   PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() macro to safely automate
>   cleanup on function return, while maintaining the behavior of
>   waking up a suspended device via pm_runtime_resume_and_get().
>   This allows us to cleanly remove all manual puts and error gotos.
> - In kxsd9_buffer_preenable(), replace pm_runtime_get_sync() with
>   pm_runtime_resume_and_get() to safely check for errors and handle
>   usage-counter unwinding on failure.
> - In kxsd9_common_remove(), replace pm_runtime_get_sync() with
>   pm_runtime_resume_and_get() and only invoke kxsd9_power_down()
>   if the resume succeeds. This prevents unbalanced regulator disable
>   warnings and bus timeouts if the device is already suspended.

...

> void kxsd9_common_remove(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	iio_device_unregister(indio_dev);
> -	pm_runtime_get_sync(dev);
> -	pm_runtime_put_noidle(dev);
> +
> +	ret = pm_runtime_resume_and_get(dev);
>  	pm_runtime_disable(dev);
> -	kxsd9_power_down(st);

> +	if (ret >= 0) {

Use standard pattern.

> +		kxsd9_power_down(st);
> +		pm_runtime_put_noidle(dev);
> +	}
>  }

-- 
With Best Regards,
Andy Shevchenko


