Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2522E1B87C9;
	Fri, 24 Apr 2026 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021651; cv=none; b=Df22yBM8ROeHpizRbm7JhMq5f4MtsrKULgvqhlrThbdLH6bjd2y2SwxJgwrAD6QJ6wWh3unAO7cN7K5y/b2hk4FY7xCCQMUryTC2OpADkGLZXfc5TEAcIzYlx2mniHw+/FxzsyKoHJSlD3zvxG/MfDnKVdzKTK+hItxYGWqtq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021651; c=relaxed/simple;
	bh=MUNL0fRFpI+O2QyIrpnm4R2vGLqSU0OLtoILgcREJ+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN7Y57+UkltYfHPz7W1AySkjeMiUe7PlpfmaFMNeTJaSCYOf4RzEaIS6k4BRsdP2+WLt1VjMINa9vC3uJW4X70nDN2nJQ8K193UQBy3FBp5Y8TqJ0qB6fSJSVqs9RsJ152E2GSL6Zts/cdiQCggKU73SsW79oef8n5UV4lM8WSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aajk4jTf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aajk4jTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777021651; x=1808557651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MUNL0fRFpI+O2QyIrpnm4R2vGLqSU0OLtoILgcREJ+o=;
  b=aajk4jTfPEdDJYaAm8Fv7BatLt9CNLtpEUyDPGBJgx6YpJG8XS0KrRTi
   H1pek7oRusvfrhWJ2ZEKaI1pk8GwWRvp1lZXZkZQzhiweOF5fjh2eZPfE
   lirQg1bZeclTtr6eBaee6SIGL8tDL2nCgG0LEf+Kh1ek4rtKIaSeB8LM1
   wSRJ8UcdmMBvgLd7vLstfYwfW/xUsWaIYy0eJFq5NV3SH9fRW/Cmdfz2Q
   772tWYhTgrjumz04CvH0YuTIpDap/UBewahSuClSuGs31bkx8I4NGbttC
   kwUJcY10S0e8nCwcSsHLtG3D9XzUoKhK/4TdofkuJ033l7ZUHct2u8Hkk
   Q==;
X-CSE-ConnectionGUID: Eh7icIbyQ4CpC7oNXF13sA==
X-CSE-MsgGUID: DNR1sMKxRLKzOX/x4KBBuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81606341"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="81606341"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:07:30 -0700
X-CSE-ConnectionGUID: E4RD5JxHS4O8AeAEIRCgyA==
X-CSE-MsgGUID: 2aFUg38JSumPFUh40WmrBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="271026694"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:07:27 -0700
Date: Fri, 24 Apr 2026 12:07:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7138: explicitly include <linux/slab.h>
Message-ID: <aesyzOMUl2Iyjgjz@ashevche-desk.local>
References: <20260424081809.61841-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424081809.61841-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 12:18:10PM +0400, Giorgi Tchankvetadze wrote:
> ti-ads7138.c uses kmalloc() and kfree(), which are provided by
> linux/slab.h, but does not include that header directly.
> The driver currently gets these declarations through linux/i2c.h.
> Include linux/slab.h explicitly instead of relying on the transitive
> include.

If you want to make it real patch, please convert it to follow IWYU.
What you are saying is basically comes from kernel.h (yeah, i2c.h happens
earlier, but the kernel.h is PITA currently).

WRT to the kmalloc() use, wouldn't it be simply better to use
i2c_master_send_dmasafe() and kill that kmalloc() dance in the driver?

-- 
With Best Regards,
Andy Shevchenko


