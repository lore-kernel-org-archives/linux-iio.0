Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35CB1F2380;
	Wed, 13 May 2026 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706115; cv=none; b=cZk5tIetu4Cedv17YFc//AR6x0qcltyrw1d2iHlXqwAdtNTpfF63hhxVN6gwn3R+Vgam+/m6KfBmFLp/zIO7K/ZM+mAqS4qAu2PYUux+JsPmh33uZfKPgg0fhYJkdvjHHhVAzSjJdTkOdI9aorma5di5jQNOBrryuaew2LGBTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706115; c=relaxed/simple;
	bh=zMCbaORT6xUeb259rppjUN2BQFDDYZqv4dSV64W+coQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMiAA5V8ouP6op8TZsK4pJ5wGhktsUl5lGwSxpibQa4se7LAJgFgkmIbpQOkpgoRDPS8hI87j8V7Jd1HsesEkH0EgmytwpyTKgWIS5btHKNht4BHiiS2A67K2Jl4BiIZISN0+NZbscPXuDQGQGYOJM4nARH1u3z3PV9cRbAl5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQvJG4gb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQvJG4gb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778706115; x=1810242115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zMCbaORT6xUeb259rppjUN2BQFDDYZqv4dSV64W+coQ=;
  b=NQvJG4gbcx+dLQrXTw+j/MuzdG+BmZ5SSvpPRJBT/QlmqrvN1/07OLol
   1753zKcw5ZdiXcBlPZtve5ih0nZnWMS6YTJd45JWdtrzfPXSm7Y90Phi/
   K/yrz3AVt2iRArXrLaWxorf6i+6GtWO0Y5zNgdgh+rvWdG++GVyXadaLh
   +caqeJLgnXyADz+zElkGxCSLWMJrOwBTrdIDZaz4g88YusSF4wXwYhm4s
   5lqqpSqDSi9zmMVpePnyK1tWgeHQaqREoyfEOx8N4JPzidRs2F9HJzwQr
   yc0LRFZICWjwn8OaHxi/1kAo2nBGi4QDYgFtOg1NHxvDj9nd1riwQzPAt
   w==;
X-CSE-ConnectionGUID: N+V0NQnBSiuXTlkVhcHAZw==
X-CSE-MsgGUID: D+fXqdoyRm2uoobUICWhaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79625993"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79625993"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 14:01:54 -0700
X-CSE-ConnectionGUID: VQJCWWMxQoi3npGyGi+SBA==
X-CSE-MsgGUID: 5veV9v3GR5+T3+wzi6S0CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="276292747"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 14:01:51 -0700
Date: Thu, 14 May 2026 00:01:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, songqiang1304521@gmail.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: vl53l0x: notify trigger and clear IRQ on
 error paths
Message-ID: <agTmvRc__VChBPLt@ashevche-desk.local>
References: <20260513193119.17884-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513193119.17884-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 14, 2026 at 12:31:19AM +0500, Stepan Ionichev wrote:
> vl53l0x_trigger_handler() returns directly on the I2C read failure
> paths without calling iio_trigger_notify_done() or
> vl53l0x_clear_irq():

> 	ret = i2c_smbus_read_i2c_block_data(...);
> 	if (ret < 0)
> 		return ret;
> 	else if (ret != 12)
> 		return -EREMOTEIO;

Unneeded citation of the code which is visible from the change.

> A single transient i2c_smbus_read_i2c_block_data() failure (negative
> errno or a short read) therefore leaves two pieces of state behind:
> 
>   - iio_trigger_notify_done() never decrements the trigger's use_count,
>     so iio_trigger_poll_nested() silently drops further dispatches
>     (see industrialio-trigger.c, the !atomic_read(&trig->use_count)
>     guard);
>   - vl53l0x_clear_irq() never writes SYSTEM_INTERRUPT_CLEAR, so the
>     chip keeps the DRDY interrupt asserted.
> 
> The sensor's buffer mode stays wedged from then on, recoverable only
> by re-binding the driver. The sibling driver vl53l1x-i2c.c handles
> exactly the same case correctly by jumping to a "notify_and_clear_irq"
> label that always calls both helpers; mirror that here.
> 
> The bogus negative-int return value cast to irqreturn_t also goes
> away as a side effect.

...

> -	else if (ret != 12)
> -		return -EREMOTEIO;
> +	if (ret < 0 || ret != 12)
> +		goto done;

While this magic 12 is in the original code, perhaps a patch on top to make it
use sizeof() instead.

-- 
With Best Regards,
Andy Shevchenko


