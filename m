Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5F3C6A27;
	Fri, 17 Apr 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448219; cv=none; b=HTXEc3VDWYrbYQ/3SwFzTIyDk9i/K47L3iYLkLyVbxEUlLg9C4Aha7uRqhk2Y96QKg1pr2qKe++OIrsF9E0SzMkf05jLZn3VujP5JWUm7ZhNZQJIhxR1GKOBtFH5C5RaLHhqv208BgnImfnj7E0o9rvQiZzEwjblvvn3V7FqACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448219; c=relaxed/simple;
	bh=HvEZi8Qo817rkQnGSXRBdMdoK0w4KRukDFQcJo1ZueQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0hDYGL3NJIWTwjlbECP4TZYyVr9Ql1jSf6ZA4E1dmVIIgbTt6tPQAbR/g7eKWNeks2Rli7GElevBEHnsbAe9RIxwjIu4yB95BLWJMZTOIqdwnQJts2PCHauqzNvl/rc94h+sTI4JDaEBPEQS+kFKt/fAgNJe1Y2QXO6M5q+8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkHAmM+0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkHAmM+0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776448216; x=1807984216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HvEZi8Qo817rkQnGSXRBdMdoK0w4KRukDFQcJo1ZueQ=;
  b=dkHAmM+0h1pBJe8mS7ZPByRrpH87jvJpNTegEfh+sLDN3u7+jVfI6KJ1
   faAbaKFNvKk1o6ZHQL8g0kIL5+04JDuTMJVC+OGAmLAdfZtnr0t08eIFW
   NU48bgHDjGfqXqTqjN68RqBqkCNHeWoXFJGju7cr7TZe+erf2lkqil2mX
   KXq1MyVGEKk95LiBHxzG5/ClIdiQB5bO2dZx67ByZD4IxJVMqe6Y4tvqd
   i5ZAsPe2SjxX/4/K0GuHpbJgzb3Wi32y7H6giJzZ0j+RbpGfPdIOr3rvf
   9QTh7ArKWNqZlADvQE4uznNjskBJ805WwEwGr/EUeK8cH4e85tYh/bOOY
   Q==;
X-CSE-ConnectionGUID: O2kB2AlZS0OKI16LVOAfZA==
X-CSE-MsgGUID: Xr4pKMoPSMWpbONvEmroIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81067210"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="81067210"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 10:50:11 -0700
X-CSE-ConnectionGUID: UvXL30zFRLGMFzm+5uB2xw==
X-CSE-MsgGUID: x1fnnLMRSRaA3ZjcvsH5Lg==
X-ExtLoop1: 1
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 10:50:08 -0700
Date: Fri, 17 Apr 2026 20:50:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iio: frequency: ad9832: remove kernel.h proxy
 header
Message-ID: <aeJyzXXX-2zOgU3A@ashevche-desk.local>
References: <20260417101623.1281-1-joshua.crofts1@gmail.com>
 <20260417101623.1281-2-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417101623.1281-2-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 10:16:22AM +0000, Joshua Crofts wrote:
> Remove kernel.h proxy header and add replacement headers (array_size,
> dev_printk.h, kstrtox, mod_devicetable, mutex, types, asm/byteorder) to

I guess it's better to add .h to all of them.
No need to resend for that. Perhaps Jonathan tweaks it.

> maintain atomicity. Moved asm/div64.h header below generic <linux/*>
> headers. Additionally, add bitops.h for BIT_ULL() macro.
> 
> Audited using the include-what-you-use tool.


-- 
With Best Regards,
Andy Shevchenko


