Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213383B637A;
	Mon, 17 Aug 2026 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951773; cv=none; b=ARiaREWVPW4pVJ53Rsb3mb0TdOiMGQuxEVdN1gZwO20GeCTqwTGSbRGhDzwYApWUA7Gu+YHkkSgBbURj2ndJJNiAzM+gJYXrsJv12SlvBWyjGH/YSa8h7k2JYhByQRUYtfrk0Zh/YtSHfnbm/LLCVn+jZm1HwLcyvppcwagwEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951773; c=relaxed/simple;
	bh=ERrUjOHtu1UCKQFjgcBjCobVtYwpLjjWeCHEg+VOkg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTse+gOyMpyrOefQQueVYD/x1j50LOM8sRqx2Ktst2FeEXTgW3BPa+OGkzNcLLSNKQ0cjKzrrZxGyA9gyf4H0hsfpVVcTxotfXPhSX4bcR+Qd85bQBNdE0ehhJXbP8D8YldTBli2sLV42vw2SF9dV6e9t9+2EfcWyJ1X0uaW3xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7JZOxci; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7JZOxci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786951772; x=1818487772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ERrUjOHtu1UCKQFjgcBjCobVtYwpLjjWeCHEg+VOkg4=;
  b=T7JZOxcidCIgFOyQPI7bVdpSwvgUsiUwHzQBPUFt/JNk5/gNfuXIuHaP
   dRk4fU9HIDORGOT4guFxLtK9TJMJKQIFwLAB0Ed+jR0tYBiDTXgIeYNJ8
   SBfodp+Bm0O0Po/04bHNnReWtWbcs1GvwQ1RvfshFuSZBtqoJFKK4wO/u
   NEYbq8MWye27mE6WloNxYkNnjQ2RjGfuz89cLxkEv50FNlxXwOtItfADU
   cpOMYRyVCgeDQKS2WmFF+4QLpN9SGg98zoQoXBhgLL9wXQHY4bF3Urk+C
   oedhXtX3SoWlXo+TeJ3np4iUSuxpap08gyKcIlhwsazN50eJFgu+VdYNy
   w==;
X-CSE-ConnectionGUID: PrH9HobBR/2Sxlm6w/Qh2w==
X-CSE-MsgGUID: Y6VbROkpRp+I8X9MDTlH1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98784430"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98784430"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:29:31 -0700
X-CSE-ConnectionGUID: AffLdwSvSp6oY73wqKi4zw==
X-CSE-MsgGUID: 2CDMbeV/QseeH8Alt3UR4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="260620164"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:29:26 -0700
Date: Mon, 17 Aug 2026 10:29:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix runtime PM leak on trigger errors
Message-ID: <aoK4VOdjFchVJWn0@ashevche-desk.local>
References: <20260814134111.1387580-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814134111.1387580-1-ruoyuw560@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 09:41:11PM +0800, Ruoyu Wang wrote:
> The first user of the MPU-3050 data-ready trigger takes a runtime PM
> reference before configuring the FIFO, sample engine and interrupt. If
> any of those operations fails, iio_trigger_attach_poll_func() tears down
> its IRQ resources without calling set_trigger_state(false). The buffer
> error path then releases only its preenable reference, leaving the
> trigger's reference held and preventing runtime suspend.
> 
> Use pm_runtime_resume_and_get() so a resume failure does not leave a
> usage count behind. Route later setup failures through a common unwind
> that clears hw_irq_trigger and drops the trigger's reference. Successful
> enable and disable behavior is unchanged.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.

Why not using the respective PM_RUNTIME_ACQUIRE*() macros?

-- 
With Best Regards,
Andy Shevchenko


