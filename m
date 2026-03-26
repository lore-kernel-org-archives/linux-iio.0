Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72F3C13ED;
	Thu, 26 Mar 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520606; cv=none; b=PDcwBBtbTsjm7n9W5kA2tcGQ3pW5iVKuaEvilAh/Z2hwSbzx1kHLTVwRdbgIjQV5syylIppf8Or7Mp/U674CZQTLt4/TEEtOx9HC2sJuS2uFumi9ouXF3CqAFuFJZhI1h2CumKzhNmJ/HWsYlSAsHGQGX0zDpFMne3fsIsEfqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520606; c=relaxed/simple;
	bh=iCRNtHOT/g8Zr0AJbDiYo+ZoJhdC94RGkHtS1nk214c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb9fH9P+2UYtmgfwl9YNmIobgu2Oz7feqv7JjYXh8KdOvS1LuHUTTYvhy9x/wiKxpazOYwpKokWjSmxS/UfroMz030DfJBFvMZUP4JjdKkh+v1MpBMYNxhBYn+uS31UmYpvEfYtRMZMUAspPSz89gs+V5WIMT0To9QR7QRCBg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsYTfCnj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsYTfCnj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520605; x=1806056605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iCRNtHOT/g8Zr0AJbDiYo+ZoJhdC94RGkHtS1nk214c=;
  b=FsYTfCnjOMma3zGlIAESXFRRf460SXaWDdyAMWq5mQE4V5rds39R40di
   eHQDGSYRs2pjdwyFvzuNzF5FdH8/gNNuQ6N/5mq6MQW5uVhwJBAcruG29
   LfqmEM/4yPYGt9eMn8+r8QvyrqXHI2uWvIqvlAxeMPPUk0+GYGPY2UXpC
   7lOK0oAXSowSFBWONIja1DRTtbKzsyQ9wj6vaF9+qwnjexr2LYkiVcvAB
   ZkDt+o9RYCIQJ/YFdy3SKVX5nZia4YYOeHEfQ1RfpynvGZxAFhmESIoqa
   cjUcfu5vsuCzhQPfQpGoxUcHWiblmDcfm9MVwvwGoCenwG0cPjHEa9rzW
   g==;
X-CSE-ConnectionGUID: 2acQW9XOTtWfHUJc4bSCiQ==
X-CSE-MsgGUID: tuXBdgE7TUC1m/F7yRKYlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86652974"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86652974"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:23:25 -0700
X-CSE-ConnectionGUID: rkySkFB5SbGjnSD8Jm3tJQ==
X-CSE-MsgGUID: 0T3i5KeaT+WQvWrEGeQ5Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224986123"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:23:23 -0700
Date: Thu, 26 Mar 2026 12:23:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina2xx) drop unused platform data
Message-ID: <acUJGHrJvWgqHxPw@ashevche-desk.local>
References: <20260326-drop-ina2xx-pdata-v1-1-c159437bb2df@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-drop-ina2xx-pdata-v1-1-c159437bb2df@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 10:30:00AM +0100, Bartosz Golaszewski wrote:
> Nobody defines struct ina2xx_platform_data. Remove platform data support
> from the drivers which still have it (it's effectively dead code) and
> remove the header.

Would be nice to see a follow up to convert to use device properties.
But again, I already asked this Q: why do we have two drivers for the
same part? (Probably not to you, Bart)

Anyways, the change looks great!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


