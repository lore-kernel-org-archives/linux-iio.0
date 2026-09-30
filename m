Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646DF3A8740;
	Wed, 30 Sep 2026 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761943; cv=none; b=nFJ6knQIMB+mGMywujcDyWSCnxJshbOQNzcMPVywfNkvDXrepu81KNeaJwejeQiY5zJORoq55ulxy6UrxKk9yXVtWwx0EPDTb9KbGNYq1wNbPtF7CgD90VcNldzZIxZilI5oghqXwn/rA5qrufsk+R29aLeP6NlihTQ7wvZLDC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761943; c=relaxed/simple;
	bh=+/77PP6qEFRi8wF3G0+zZ87z5ZwU+mmBW9WQW1qjk2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uma7Hxm2bBhzSZWmLrGxYFEZxBh5DNi+YWjUex/5yzk74PEdeaoZ0wN3CP2w+cndEQfpkJrUdHI+UoEETZuPpDzOoJ4kAi41LvEr0u62QD6QdEWrZN5sXF2n3uhKz+dFlycrtYqoXutIOZxgjZJdSL5DMBB8hfPOzynExZ1OVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ID5HMZZd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ID5HMZZd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790761941; x=1822297941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+/77PP6qEFRi8wF3G0+zZ87z5ZwU+mmBW9WQW1qjk2Y=;
  b=ID5HMZZdeSM6Nz4qzSVEialjm0Fnn0cCJF0S3f7haRQ6aXD+N3aNZUxU
   vTJsRbE88f3QtRsrI2xaJnpO0x/YXVt436pBK5x8k8Ca0FByGFwpGggsJ
   5icDdCJDj0cwgiDU75FTMEFoPJVIz2CseyjMcbB8uQMLxdOuVHtNr9GpM
   byfzm2i5XFSN4if0jY4O7n/RYeLEWq231pnBAajiKHKwKNrhMdY+1cw0V
   AiUS91VXI3QRcs10nCe1Iw4RfVKn1phD7wfCrM6pqstDu6dtlqSMfyIb0
   LQxcrJLWWDx7Aak4MIzwjNWsedsmdpElnxqK1WdzJRf/aBvfz/d+ViGD2
   g==;
X-CSE-ConnectionGUID: Egd4iZk/TJa2RVGEgCymfg==
X-CSE-MsgGUID: BCHJiCN5TcWxS5e6ROAeLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="107881347"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="107881347"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:52:21 -0700
X-CSE-ConnectionGUID: +HDP9pVlTTKrVdcEmOhkwQ==
X-CSE-MsgGUID: HUQw7wO+Qg2E3+7hdzgKiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275685746"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:52:18 -0700
Date: Wed, 30 Sep 2026 12:52:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: cdcp206@gmail.com, Nathan Chancellor <nathan@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: temperature: ltc2983: avoid string comparison for
 leak detector
Message-ID: <arzb0JQxkJAsLsEa@ashevche-desk.local>
References: <20260929-iio-ltc2983-fix-string-compare-v1-1-d67d612d6ddd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-iio-ltc2983-fix-string-compare-v1-1-d67d612d6ddd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 12:38:22PM -0500, Carlos Casadiego via B4 Relay wrote:

+Cc: Nathan

> GCC can determine at compile time that propname cannot match
> "adi,custom-leak-detector" when __ltc2983_custom_sensor_new() is
> inlined for some callers, triggering a -Wstring-compare warning.
> 
> Pass an explicit flag for leak detectors instead of deriving the sensor
> type from the firmware property name. This preserves the existing
> conversion behavior and avoids the constant string comparison.

...

>  __ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwnode_handle *fn,
>  			    const char *propname, const bool is_steinhart,
> -			    const u32 resolution, const bool has_signed)
> +			    const u32 resolution, const bool has_signed,
> +			    const bool is_leak_detector)

Can we get rid of those strange const qualifiers for booleans. What are they for?

...

> -			if ((index % 2) != 0 && !strcmp(propname, "adi,custom-leak-detector"))
> +			if ((index % 2) != 0 && is_leak_detector)
>  				temp = temp * 1000000 + 273150000;

Hmm... I consider that the compiler warning is just a noise which we should
ignore or disable. It's doubtfully useful as if it may prove the always false
or always true cases, it doesn't mean there won't be other cases in the future.
Do we have any discussion on that warning before?

-- 
With Best Regards,
Andy Shevchenko


