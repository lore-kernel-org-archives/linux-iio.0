Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984E3388E4D;
	Mon, 20 Apr 2026 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678754; cv=none; b=Yb7OQAJrRZz+4Zb057qw/MfcHQxFzA1756epDYxZ/LhRl/NwBZfu0vLdRGW0d7R9vaLr3pT9fNx7QH1M4p37mbbFusnuHfK3MQBAxeg+de2ONbhEO4ikaZ1iuTFMHl/LIS4GWmBFXVH3iG6ruMVxdMJWhZ8/mZhzQpqi+Q28B1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678754; c=relaxed/simple;
	bh=uG3DZW685RLKotR8zheylICGcw0NyF8noOCWBPkNoBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M49MZMHcVlPHk8p/yaq4/3/uZW5k5uo8R251XbzOvTIKvpEYGlaySdf+NrYeTaqQ2AolHq3cYS83GT2AICSZXaUb+BuOgCiK5lIbr5s4DX1OPmBf2B1y+sIdVEa+tL2aWhKIG4w5JOpJ6Nr9D9VdDs+LYwfTuBK5sGh9/ZOhM4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeRe48eU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeRe48eU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776678752; x=1808214752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uG3DZW685RLKotR8zheylICGcw0NyF8noOCWBPkNoBI=;
  b=QeRe48eUzXvXsr9gLbQO8d9q1VJuwAkZK5wQrJZPHMAoInGvO8rGp1Ve
   60k9yJ6jrFUce7NBvuUR7NjAtbbGn0ag02T0GSLqz8HpZ/2sZg4WCM5XP
   9piTGSd9zOq8nhLc75tQ1XtwEHIprFK7F3c5PhtKDDcVJeqa5p9wLaQ1s
   sUIKzRv09DsMTS0vM7aWSdBVXxgehaHjwHMDXoYakrU4z6Y+081Y2SdvK
   u15nCRrO/ShL3krx8eBtthVM6OGUtuDXPFcWPg7mSPQ/jUKKLm3/FsAvt
   k2pf/m3JADRPEIJPvMQnG/vlV+R7S6J8eUWjlOZvcIWFzJN3clDVAQ9+5
   w==;
X-CSE-ConnectionGUID: GrV0Ri7gQj+y0A/ZLR155g==
X-CSE-MsgGUID: 2bd4cHLKSfy8ocEvNDIjFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="76617796"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="76617796"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:52:32 -0700
X-CSE-ConnectionGUID: xycqq26ER4uOgYhazoCc5A==
X-CSE-MsgGUID: 47bgJpcuRo+rONUoE20d3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="236058851"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:52:27 -0700
Date: Mon, 20 Apr 2026 12:52:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, andy@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, krzk+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, me@brighamcampbell.com,
	nuno.sa@analog.com, robh@kernel.org, skhan@linuxfoundation.org,
	Hardik Phalet <hardik.phalet@gmail.com>
Subject: Re: [PATCH v3 5/5] iio: magnetometer: qmc5883p: add PM support
Message-ID: <aeX3WUioap2KQCOp@ashevche-desk.local>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
 <20260420-qmc5883p-driver-v3-5-da1e97088f8b@pm.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260420-qmc5883p-driver-v3-5-da1e97088f8b@pm.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 19, 2026 at 10:33:06PM +0000, Hardik Phalet wrote:
> Add runtime PM with a 2 s autosuspend delay. Per datasheet §6.2.1
> the chip continuously samples in MODE_NORMAL; putting it into
> MODE_SUSPEND when idle drops current from up to 1180 uA to ~22 uA
> (datasheet Table 2).
> 
> Wrap qmc5883p_get_measure() and qmc5883p_write_raw() with
> pm_runtime_resume_and_get() / pm_runtime_put_autosuspend(), converting
> early returns to a goto so the put is always paired.
> 
> System sleep is delegated to the runtime callbacks via
> SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume).
> 
> A devm action is registered before devm_pm_runtime_enable() so that
> LIFO teardown on unbind runs pm_runtime_disable() first (freezing PM
> state) and then suspends the hardware via MODE_SUSPEND.

...

> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret < 0)
> +		return ret;

Don't you want to use PM_RUNTIME_ACQUIRE_AUTOSUSPEND()?

...

>  	guard(mutex)(&data->mutex);
>  
> -	ret = regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
> +	ret = pm_runtime_resume_and_get(data->dev);
>  	if (ret)
>  		return ret;
>  
> +	ret = regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
> +	if (ret)
> +		goto out;

No way, please, read what is written in the top of cleanup.h, also use
the advice I gave above.

> +out:
> +	pm_runtime_put_autosuspend(data->dev);
>  	return ret;
>  }

...

> +static const struct dev_pm_ops qmc5883p_dev_pm_ops = {
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +		RUNTIME_PM_OPS(qmc5883p_runtime_suspend,
> +			       qmc5883p_runtime_resume, NULL)

Besides broken indentation, use proper macro from DEFINE_PM_*() family:
DEFINE_RUNTIME_DEV_PM_OPS().

> +};

-- 
With Best Regards,
Andy Shevchenko


