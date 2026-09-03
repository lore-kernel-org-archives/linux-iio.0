Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF23F4116;
	Thu,  3 Sep 2026 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417733; cv=none; b=VqVYDXCbdTlwPprKuNO2W29U8IBfpjV2ts2K9kwmRKDk9k5Ev9SKo6pNCZAt4pGofRJg05s4vDkgETdKpDyHWqwOR2F3g5Q0JvP5BgYQ2NDZJDgtdq+xldW4iYr4bPp+sQg1xnInzmVEAy0Zza4jh4Wtw/2jUnaJX7MYW7ilHEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417733; c=relaxed/simple;
	bh=rKjlUhkG9OUPx5gt60ZDwzbWV37eFgaTykNZ8LQQnLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqMZ9LeXwP3KBSnh6s2xI/ALlP/hOEpaBn4dF4ptITquIcOBUsNe07fvYPedLCyuaJyTmLiiKuv+rmlLqtL+Omgs605fqGDO5Iee1huAbvhoIyZR5NWB5K/a+u3lhKGYs1JhlRCBdFS9whPJNorg/K3PRipiX/phRAIBnAAZB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0Ei2bb3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0Ei2bb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788417730; x=1819953730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rKjlUhkG9OUPx5gt60ZDwzbWV37eFgaTykNZ8LQQnLw=;
  b=d0Ei2bb3JsZRGLVNKHW9W8PyIUcw+AdtGmUY0gfnQhfvIp1B5BgCQFC6
   83SP7dScJrwehllSnq0lSrmrStI5wMJZBY7J0Hv10wSnDG7qHEB+EtGL1
   nSQ7OyjidEj9fxb4s/ADepkLTllDjl7d6eQfvMsqj4HSDjUBvKwLEPGsd
   6+Dv8PjYe5GYuT+YkLEmFBPxte84NYWRxCT5EK1cyRInGjLvo1eG96NY+
   +NkxnWLBKDVs5iv70VHdj0do3qZL7patchccNqGwWEIC0OWmqYhA/MqcV
   SKUaCSqB50i8XxM8G3Ac9PuLzQsfS28y1Qcxk83CulmbSb7Lew5WT7Y0T
   w==;
X-CSE-ConnectionGUID: ZIUhldXOTAqyV6zZu49BjA==
X-CSE-MsgGUID: clI8MelsRBSaVR5Ca0j0RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88912532"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88912532"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:41:32 -0700
X-CSE-ConnectionGUID: JNd4TXHwQjeO72DTSF7faw==
X-CSE-MsgGUID: 0HHHqd5wSLawS2Pmm2GiwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="267870850"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:41:29 -0700
Date: Thu, 3 Sep 2026 09:41:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH] iio: light: apds9306: fix default sampling frequency
 definition
Message-ID: <apkWlzZZIIzVDz4C@ashevche-desk.local>
References: <20260903-apds9306-v1-1-3f892aa4f156@jacques.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-apds9306-v1-1-3f892aa4f156@jacques.com.au>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 03:38:47PM +1000, Tsz Shan Chan wrote:
> APDS9306_SAMP_FREQ_10HZ is defined as 0.
> 
> According to the datasheet (page 11, ALS_MEAS_RATE), bits[2:0] set the

Can you add a Datasheet link? (Or at least the version and name)

> measurement rate:
> - 000: 25ms  (40Hz)
> - 001: 20ms  (20Hz)
> - 010: 100ms (10Hz)
> 
> Change APDS9306_SAMP_FREQ_10HZ from 0 to 2 to write the correct value
> for 10Hz.

> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> 
> Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>

No blank lines in the tag block (at the end of the commit message).

-- 
With Best Regards,
Andy Shevchenko


