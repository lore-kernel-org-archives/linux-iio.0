Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C3D37AA97;
	Sat, 18 Jul 2026 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784363965; cv=none; b=utpcZjXOgyXAtYlqRj3mBkLy1HjxbO8knykUaPSxzQEW4QcKh6bWo6TwiI15EHI1c4kq+kDmTEeMVRVRVcFFWMlDu61f5fKRBK2OiTrEEZnp5t4oKA1837NAEYNXHxTKPBcxYXE3ZsNvLMYX1MIChOYh50XAbySMMKqJTQPRPhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784363965; c=relaxed/simple;
	bh=Fs5qnKsmjgj8ks2FUTSHOwz+/RelmIK6uaZet8HIMUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US8EOZyx8IqN16yHoA18048eeiqqFPsoblS+1hMqY2zvPTORAJdIyHzKW3LPpLpUgKGZxLecztK/DmtFk8GGpG61Zq5Xvuh59YJIjOJa21Yy17rLWkFc5iOZTu25QxG4EmH0muwNyBB1Y3+N4VpFHGXwF8NUnQxzdPt0qbLPCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6TH7VEl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6TH7VEl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784363963; x=1815899963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fs5qnKsmjgj8ks2FUTSHOwz+/RelmIK6uaZet8HIMUw=;
  b=F6TH7VElGfS+gHtBQTSx0wu2wXf15VZgCbEsE3Pg9up46xLXb0VtJfet
   2Ow5lCXCHIaA7MAP0T0nJ0xTs1u5aJqsbiRZRHKam2sSAWYbaWQasUAZj
   WKp5CZl4/01YCScSnL82KRiSXiidIoznUwSZXO0xWX826dGs8cL2iPSaa
   H1UHmp1k6TrvZKZI/BlhmAnx5iyZto6u0XPr3Ocs3tbd+gIqgI6W8pQcI
   rPiBYdvt31Ts8FdW6wLj2A68Lptsbary6aauxm8C3Apj21LMiQw543tjW
   PqdLzQqdFnZxPM/mLirBNfCA6M0qrp69infd0EOxxenRJWvAp7IXTuumC
   g==;
X-CSE-ConnectionGUID: r1e7dBA0QM+M5LWVzmYUcw==
X-CSE-MsgGUID: tUINIt0sRFq+EObBaOuUEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85047193"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="85047193"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 01:39:23 -0700
X-CSE-ConnectionGUID: 2o/Bfa78RcqBZ15YQw/cCQ==
X-CSE-MsgGUID: Mo1oI6YJSfakOc+ZnTXIrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="295177238"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 01:39:21 -0700
Date: Sat, 18 Jul 2026 11:39:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ti-ads1015: convert to fully managed
 resources
Message-ID: <als7ttnvC7pIqvJk@ashevche-desk.local>
References: <20260718075016.27750-1-architanant5@gmail.com>
 <20260718075016.27750-4-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718075016.27750-4-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 18, 2026 at 01:20:16PM +0530, Archit Anant wrote:
> Refactor the driver to use devm_ allocations and power
> management, allowing for the complete removal of the
> ads1015_remove()
> 
> Key changes:
> - Use devm_add_action_or_reset() to ensure the ADC is safely powered
> down upon driver removal.
> - Move to devm_pm_runtime_set_active_enabled() to manage the runtime
> PM lifecycle.
> - Update the PM operations to use DEFINE_RUNTIME_DEV_PM_OPS and
> pm_ptr() for modern compiler saftey.
> - Convert iio_device_register() and mutex_init() to their devm_
> variants.
> - Remove the thus obsolete ads1015_remove() function.

...

> +static void ads1015_power_off(void *data)
> +{
> +	struct ads1015_data *st = data;

Unneeded.

> +	/* power down single shot mode */
> +	ads1015_set_conv_mode(st, ADS1015_SINGLESHOT);
> +}

/* power down single shot mode */
static void ads1015_power_off(void *st)
{
	ads1015_set_conv_mode(st, ADS1015_SINGLESHOT);
}

...

> -static const struct dev_pm_ops ads1015_pm_ops = {
> -	SET_RUNTIME_PM_OPS(ads1015_runtime_suspend,
> -			   ads1015_runtime_resume, NULL)
> -};
> +static DEFINE_RUNTIME_DEV_PM_OPS(ads1015_pm_ops,
> +				  ads1015_runtime_suspend,
> +				  ads1015_runtime_resume,
> +				  NULL);


>  	.driver = {
>  		.name = ADS1015_DRV_NAME,
>  		.of_match_table = ads1015_of_match,
> -		.pm = &ads1015_pm_ops,
> +		.pm = pm_ptr(&ads1015_pm_ops),
>  	},

This should be split to a separate change. Before even patch 1.

-- 
With Best Regards,
Andy Shevchenko


