Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B058379EFF
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776671993; cv=none; b=aRAhN4HKMiQaCRXREUq/umZvhpsNFVm/PzIZ4Jt5C3BTU1+M30BeN5VvENm+QiK5n5Ixi6ExUwcUs1y8OYCvHJ8dGNlCVbUGAN8bJXr8t0sERk+SKluGQZ0xNkiJeE3VZJLw2Z9a6s3AZ7Akpodb8iP3p+nLQBecg6G2EXUUEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776671993; c=relaxed/simple;
	bh=GdykDU6dFx8ea/dxwRcmPED7I8z9VrfGfQF2RcwWxTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoBmAy5+aX7VuHJtWDlVjo+Ek7PVmNEmUKi2vCqvFtxJ/yXqxAzxRoYY0p+5fmFrZ2ZZ15sRFrB5YgG5fpJ63l1qPDtZG1zOMPL5KYOU8L9t8fFmAp7xel0Le/Hz/HlppkyDyRuPp9WSDIBjs7zab2HjHweGstdDJCOENFdm5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdWx+gQY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdWx+gQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776671991; x=1808207991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GdykDU6dFx8ea/dxwRcmPED7I8z9VrfGfQF2RcwWxTA=;
  b=OdWx+gQYzhXU9nxqzKMzmF6vh2Z6LRTBwRNGiaesY17d3qEJT6g4RxEY
   Xh/2gZ/6wCoMk4g7P280YI+BJRPewtCtVpwWLrg05mOo8UVQLFQbYShsh
   n2MP7B+54a6sFbSIymuiV453aCeMtTVdab2Nc9YITwEDBrW8wiMrDa0oT
   5EqidPIbyaQwB61lhqP3DvevqCXC2hAVJeKXt+XCRRNWumRWcAQhBkjTq
   yOvAPsNgdu6UxDguUwfCrjV2i3bXYJlWKYtu3jMA8/7VZyu3M+q0L7xQ7
   g6Ad9fQtVFOgpqSySAMm7tkDpDcgwhRW5s7/hT6i8YMS07AbUFmCqvEGo
   A==;
X-CSE-ConnectionGUID: WWTjOW3KQHW7G35eCTAyyA==
X-CSE-MsgGUID: an0SB6riRoGSLnR0J9FvoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="87882070"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="87882070"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 00:59:51 -0700
X-CSE-ConnectionGUID: D2KDncEXSQyC5SdGH7R+TA==
X-CSE-MsgGUID: hI4z1shDTdyll35Ij4ZbNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="262038262"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 00:59:49 -0700
Date: Mon, 20 Apr 2026 10:59:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Luiz Mugnaini <luizmugnaini@usp.br>
Cc: cmo@melexis.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mlx90614: use guard(mutex) for EEPROM
 access locking
Message-ID: <aeXc8o94OiDRFy0b@ashevche-desk.local>
References: <20260418205151.172046-1-luizmugnaini@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418205151.172046-1-luizmugnaini@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 18, 2026 at 05:51:36PM -0300, Luiz Mugnaini wrote:

> Replace mutex_lock()/mutex_unlock() pairs with guard(mutex) from
> cleanup.h for cleaner and safer mutex handling. The lock protects
> EEPROM access across five call sites in mlx90614_read_raw(),
> mlx90614_write_raw(), and mlx90614_sleep().
> 
> In all cases, the code between mutex_unlock() and the end of scope
> is either trivial computation, a return statement, or a call to
> mlx90614_power_put() (which only schedules a deferred autosuspend
> via pm_runtime_put_autosuspend()). The slightly extended lock scope
> is negligible compared to the existing hold times, which include
> EEPROM write cycles with 40ms sleeps.

...

> -		mutex_lock(&data->lock);
> +		guard(mutex)(&data->lock);
>  		ret = i2c_smbus_read_word_data(data->client,
>  					       chip_info->op_eeprom_emissivity);
> -		mutex_unlock(&data->lock);
>  		mlx90614_power_put(data);

How do you sure that the code:
- is not slowed down due to unneeded things in the critical section
- doesn't introduce no deadlocks
?

How did you test this, please?

-- 
With Best Regards,
Andy Shevchenko


