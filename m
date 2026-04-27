Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C5C8EB;
	Mon, 27 Apr 2026 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277835; cv=none; b=eGOYhx/xfPdqqy7qhrUf7FNNIVaUeYSpobM9Y9Kq5ipKiJgGGuY8Yl7UdnXcWD+CHo8KHN2c+KKGI2boB0uJ6CInpVwKyO6xg8QSC7s5vdFHVsGRQyw06JWVz3dRsMvoxGzqPUeWDLjo6wRtXIGFAMNpd96Bs1LgGhJT3oIgWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277835; c=relaxed/simple;
	bh=NryZ7oBsUKLd4LUmI5L5HMr1FHa2CoLv5TPfkgjwZJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdkoKQjeGvIQNyNMMnNN7dZyVKNkdm+6m/xk6J+82cJrUcGc5P4KUnFvPK3CvPLH3jgWmg/dUr4GC0x3HLf/v5JI3MFvKHKclIBdzkjhlYCzrl3qbaF6ijKYX79m3rY7nj5pNopJNEroze7t8Yfy576b9V6vlHK5F8bn9o5JTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIvjPu2n; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIvjPu2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777277834; x=1808813834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NryZ7oBsUKLd4LUmI5L5HMr1FHa2CoLv5TPfkgjwZJE=;
  b=DIvjPu2n5nNuIwMArJtWrOCcmZAwI52f0orLTW9s2eOSbhLtjZHZqVzq
   xXCOQrvHvv+fhHD+833Mf5qKP8ODTZFH+sq//g0hYHAAcsLDUL9zk9XkL
   IO6ivDUpReumN/WBXHdH/Vj6k/1bXC79iFVu9I9SeUJ3aof6Hr/XNXnRD
   G3XTMLXhYnyZZVzIXeeKD04luQV6lh6TR4uwSDg/Lk16kHlQzETwBZLQO
   pie6N6t7R6HgJ5glcPFI9NmEQ/NF467EufCtiURaIm7qT7WiYbow9OimY
   Dq7CPa/0c9n1pjprLMylUlr8buh362e1d5McdCKpLvUz38kD+Z/8JlmYa
   g==;
X-CSE-ConnectionGUID: /Lxkg6/OR5CeOMsL/poskw==
X-CSE-MsgGUID: sJQkyGZcRCWEjrKXrYviWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78075489"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78075489"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:17:14 -0700
X-CSE-ConnectionGUID: dPj5jWkYSk6W+7hv/VQZ5w==
X-CSE-MsgGUID: 41EXPT4mTdOzk51coXA9Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="232691415"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:17:11 -0700
Date: Mon, 27 Apr 2026 11:17:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, mingo@kernel.org, christophe.jaillet@wanadoo.fr,
	nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
	kyungmin.park@samsung.com, k.wrona@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/9] iio: ssp_sensors: Drop duplicated wdt timer and
 work cleanup
Message-ID: <ae8bhC34KE4-Kguw@ashevche-desk.local>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
 <20260426091710.3722035-7-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426091710.3722035-7-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 26, 2026 at 02:47:07PM +0530, Sanjay Chitroda wrote:

> The SSP remove path cleans up the watchdog timer and associated work
> both via ssp_disable_wdt_timer() and through explicit timer and work
> teardown.
> 
> ssp_disable_wdt_timer() already performs a synchronous teardown of the
> watchdog timer and watchdog work, guaranteeing that no timer callbacks
> or watchdog work can be running or requeued once it returns.
> 
> In addition, the remove path disables interrupts and frees IRQ handler
> using ssp_disable_mcu() and free_irq(). The refresh work is also
> cancelled, preventing wdt_timer being re-armed before teardown. This
> ensures that no new refresh or watchdog activity can be triggered from
> the IRQ thread and refresh workqueue.
> 
> As a result, the additional timer and work cancellation is redundant
> and does not provide additional ordering or race protection. Remove the
> duplicated cleanup and rely on the centralized watchdog disable helper.

Nice...

...

>  	ssp_disable_mcu(data);
> -	ssp_disable_wdt_timer(data);
> -

...but this is left unexplained. The commit message as I read it relies on the
fact of this call to be present here and not being moved below.

>  	ssp_clean_pending_list(data);
>  
>  	free_irq(data->spi->irq, data);
>  	cancel_delayed_work_sync(&data->work_refresh);
>  
> -	timer_delete_sync(&data->wdt_timer);
> -	cancel_work_sync(&data->work_wdt);
> +	ssp_disable_wdt_timer(data);

Now it's still possible that watchdog will fire and we might have a callback
run while the IRQs are already being disabled. Which means that if WDT callback
needs the HW to be able to generate IRQs, it won't happen.

Note, that IRQ can be still fired in between ssp_disable_mcu() and free_irq().
Only the latter call makes sure you want see any IRQs from HW.

>  	mutex_destroy(&data->comm_lock);
>  	mutex_destroy(&data->pending_lock);

-- 
With Best Regards,
Andy Shevchenko


