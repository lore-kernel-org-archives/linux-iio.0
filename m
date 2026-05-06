Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA4C3E8C64;
	Wed,  6 May 2026 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060547; cv=none; b=KQYltFBrzQLiIusjWk6+9X9z+BOrkBNAUFum9J6W93PuBwMoUqsMXdX0idiC+4i55JHboR3s4jmCmy+TvY4qc6H/JW49Ppcr0kSn2rWACurKJGFEIgeCBMPvzPmeO6YjjXlI3QCGQJcnnfLwSakJ+9UbI/7ZwKwLi0Fj9gU+AxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060547; c=relaxed/simple;
	bh=TL7i49cvb5LSr2zEXeSqq8BMIrmUS/Qhu595n5hHVqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXU2188NcojmX/GeQIuEex06EJxUvdMbXSZvU6Zk5BK0HlKOhnXMCTo9BkshshxZsPfBuVTd0JY/wiBL9pSQBxO2XbphciSgVIBc5xZkfG+YmUyU+HliQeuptXAuh2EQLLd+7EhyD4Kcgb8IptKkwvh8kDYtjlky3lVVSrGUueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2+KzDEe; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2+KzDEe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778060547; x=1809596547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TL7i49cvb5LSr2zEXeSqq8BMIrmUS/Qhu595n5hHVqI=;
  b=W2+KzDEeiixzzd+UqRFM9c/9mv591SQbmvShFwt5dHtWryafLSIlrNn8
   k2VYpfedXYWGoUHARWOJv3cuLMyerLpHEeRMWZju678mVIrbTgRlt3Rt3
   5cving07oD1+ez9kELmsEPhLEFok0Lhb8L70kkhsKbJTkP4Mim79wuJ4N
   1TwqgKM4UBF+iictjztrUKGdB5JniIEp0JnbIFTUXPyQbF1Y4pngXpJ/h
   s7bITzQbigN6z5znQDu2MTtCoy8oygt1/Zla9iv5oLOiKN+KvHMjLmyRn
   5Yhwt5oF0G1k3S7+S/xpuoZgoB3PEtkhrGVympZjCFiOM5P9KEjuIwr3s
   g==;
X-CSE-ConnectionGUID: GtkMY/WwQpaREfg6Thw6Fg==
X-CSE-MsgGUID: uoAjizJYTi+SQm9bB/deuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="101658445"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="101658445"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:42:25 -0700
X-CSE-ConnectionGUID: 8w9DFDCiT4yKYQ2pVNe84w==
X-CSE-MsgGUID: IZ897ijiQ7m7rxNREL62Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="232999387"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:42:21 -0700
Date: Wed, 6 May 2026 12:42:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com, martink@posteo.de,
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] iio: accel: mma8452: use pm_ptr() and direct
 runtime PM calls
Message-ID: <afsM-77LW_jfP6d4@ashevche-desk.local>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
 <20260505174640.3998281-9-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505174640.3998281-9-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 11:16:38PM +0530, Sanjay Chitroda wrote:

> Use pm_ptr() together with DEFINE_RUNTIME_DEV_PM_OPS() so the PM ops
> pointer is automatically handled when CONFIG_PM is enabled or disabled.
> 
> Switch to direct PM runtime calls and drop
> mma8452_set_runtime_pm_state() wrapper, which is no longer needed.
> This follows modern kernel power-management conventions.

...

> static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,

>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;

> +

Stray blank line.

>  	int reg, ret;
>  
> -	ret = mma8452_set_runtime_pm_state(data->client, state);
> -	if (ret)
> +	if (state)
> +		ret = pm_runtime_resume_and_get(dev);
> +	else
> +		ret = pm_runtime_put_autosuspend(dev);

Hmm... Do we care about autosuspend returned value? What is its meaning?

> +	if (ret < 0)
>  		return ret;

...

> +static DEFINE_RUNTIME_DEV_PM_OPS(mma8452_pm_ops, mma8452_runtime_suspend,
> +				 mma8452_runtime_resume, NULL);

Use logical split

static DEFINE_RUNTIME_DEV_PM_OPS(mma8452_pm_ops,
				 mma8452_runtime_suspend, mma8452_runtime_resume, NULL);

OR

static DEFINE_RUNTIME_DEV_PM_OPS(mma8452_pm_ops,
				 mma8452_runtime_suspend,
				 mma8452_runtime_resume,
				 NULL);

-- 
With Best Regards,
Andy Shevchenko


