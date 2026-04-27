Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71339B4BB;
	Mon, 27 Apr 2026 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278532; cv=none; b=jbMsw041cDxG6TqikqFNJkQGbfqrfbF9I8Fcr//8elcEDSDt+o0JbaF0ksMCA5ID/hTHgfGSDjPZIinHMahVHg9gZppcU1lvvlBDnaV3bbgS30bY0HgQUGzjIOHXxMaWcGyPRk1x1FL3QH1Rhba6RAABG+5F/Xf9KgQTi8uQX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278532; c=relaxed/simple;
	bh=20V3v6nFBWSSNLfpFhB14D51DIKo6+DeNELINMLa7Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4xoETA77ktQ2ypi5xuwfyClQ5gtFtCLXzxwjrydgU4djWU8c1tBJ/bnBad5WpSBQremlC8gaMSINsPijejH1xAZzslEeNFvijdo2zON3lYfmZ0BwftsMvkFAJCD7H0OZDxuTAqB6DPNeeqhjyJXwvANcUOAOzvhnCji904ETn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwkrGSbh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwkrGSbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777278531; x=1808814531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=20V3v6nFBWSSNLfpFhB14D51DIKo6+DeNELINMLa7Yo=;
  b=DwkrGSbhjwwEBf2xSKf2nG9v9hVvtiSUB2YwmqYnKIspOHknmoExW5UQ
   gOC/MaX/KywF38xTv7Uuwi0VIvQZ5kBmr3XmDifqYJ3XAsB6P3/N+y1FM
   oVsmlQWmwQ9HD9BNQwP3uCxddF5GlmB0wjzmu1Tmb8YPy58FY2NIo6wTD
   TAvYRKkcN8IUKvYfTmGtn3PXG+2dOVY3fRVmgOG/A1ev88W725WU+5F87
   0SN1Nh98jid4fLI4YpQGaY+ElnXhM4IbkARICaoAbZwP47ccidPRb8+0N
   yQbyc5107UyNT67uOMPGUojBUlNIgDTQrjPNKkTXIChTsxqK6LG8z+dOQ
   w==;
X-CSE-ConnectionGUID: 0p3p1JYaSx6ENffG21IHXA==
X-CSE-MsgGUID: lDomTcuESiKwK7gejJyD8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="65693143"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="65693143"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:28:50 -0700
X-CSE-ConnectionGUID: yU2xPZEESGyHfQhXuRB6bA==
X-CSE-MsgGUID: Jnx4AE6QQee9YHJgfAqjLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="237533893"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:28:48 -0700
Date: Mon, 27 Apr 2026 11:28:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] iio: imu: inv_mpu6050: fix unbalanced
 regulator_disable calls, when probe fails
Message-ID: <ae8ePcYPMziqhcWV@ashevche-desk.local>
References: <20260426112334.3938774-1-andrej.skvortzov@gmail.com>
 <20260426112334.3938774-2-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260426112334.3938774-2-andrej.skvortzov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 26, 2026 at 02:23:32PM +0300, Andrey Skvortsov wrote:
> During a probe functions after all regulators are enabled, runtime pm
> is enabled. Before probe function finishes, runtime pm triggers and
> disables vddio regulator. When probe function fails after that,
> inv_mpu_core_disable_regulator_action tries to disable already

Please, use () when we refer to the functions or callbacks:
 — func()
 — .callback()

> disabled by runtime pm vddio regulator causing following backtrace:

PM

>   inv-mpu6050-i2c 1-0068: trigger probe fail -19
>   WARNING: drivers/regulator/core.c:3244 at _regulator_disable+0x2ac/0x600
>   Call trace:
>    _regulator_disable+0x2ac/0x600 (P)
>    regulator_disable+0xac/0x148
>    inv_mpu_core_disable_regulator_vddio_action+0x3c/0xb0 [inv_mpu6050]
>    devm_action_release+0x4c/0x88
>    release_nodes+0xd8/0x178
>    devres_release_group+0x214/0x3c8
>    i2c_device_probe+0x6fc/0x9b0
>   ...
>   inv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -5
> 
> vddio state is handled in two places: pm_runtime and
> inv_mpu_core_disable_regulator_vddio_action devm action.
> inv_mpu_core_disable_regulator_vddio_action has to check, whether
> regulator is disabled by pm_runtime already. But this information is
> available only after pm_runtime state is initialized by
> pm_runtime_set_active during a probe. So
> inv_mpu_core_disable_regulator_vddio_action has to be called only
> after pm_runtime is properly initialized. To handle cases, when probe
> fails before pm_runtime is enabled, explicitly disable regulators
> in error paths.

As per previous comments.

...

> +	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_action,
> +					  st);

I would go with a single line despite being long.


> +	if (result)
> +		return dev_err_probe(dev, result,
> +				     "Failed to setup regulator cleanup action\n");

-- 
With Best Regards,
Andy Shevchenko


