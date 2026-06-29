Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0CB4611C4
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751152; cv=none; b=W+xhyiIqxpR19YqwVx0+/P9XJVvj2c+8D1rccT+/ATvkG4yaRnw6q1wKLzHjYbvr0HDkURpCu6V1aAoEAsYbF5VUzzhIa3sCeYUyjNjnd2zgPRRx1Cxdtg7iV6bsDUVcvZDfaMHUkRdKTPEutuhbZm5dIgnm/a3Ht6WWmutPOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751152; c=relaxed/simple;
	bh=3ZoGd3AfsTPxPw9/6NgLFPi8Q6drJsAQbcgA6zDr9Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbbFGTz9IhAcmhLpNHJvDZxZdkzNBKd0S6Apw6EB07ZtpVyt9Ds1NiclI1xleZ+MN+XRy4Vu1ih9RJCT68/K23dnllDrdYIKdwm1SDNnJKAKEuqqcfLB9P2JLola5b3x31xie23zBR0kmRt7uGlh2PcjGUVqi96i/sMsXUv0e14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3q1YHSy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3q1YHSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782751151; x=1814287151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ZoGd3AfsTPxPw9/6NgLFPi8Q6drJsAQbcgA6zDr9Fo=;
  b=D3q1YHSygTgfF4y8qAxEdsov32NfFDO7BOYTNd9p2f3Xeqd0hVrUWX5M
   Pw2XhXVKSbthrmLIgW94WvHXZFZSFzxNM0jjc0qdTWLQN2mGwMxkh4pPh
   LSq75AXs212MQ0ZI/v+b2xz2Qr3nNH+qzFrjHCx/FpqQHpcnvsdz7hw89
   VTL7LGPyZuXLaxDY5nQEP1+KTGm/ihT++Krx2PYy3F2ao/DqH3MpGBYgR
   PddqmKxJiHPX52J/Gowq6ylPQ8RJTfcR9dSavH5pW9bi4ILD8DXQD47yC
   i6aZa2FqxHSzWPRbfCHjYPhcZcCjvclm4JBqbwGNXbI+Rub5uS5PEp7o5
   g==;
X-CSE-ConnectionGUID: 86EiaOwETw6TjaEesg/h6Q==
X-CSE-MsgGUID: oEiOAak3T+iVT2hNsOmSQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="100994901"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="100994901"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:39:10 -0700
X-CSE-ConnectionGUID: 70E1cP35StaynrUUa+cqwg==
X-CSE-MsgGUID: c3sy8ygTQzWCZ+kMpwv62g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250307621"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:39:08 -0700
Date: Mon, 29 Jun 2026 19:39:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: dac: m62332: Clean up header includes
Message-ID: <akKfqWoHmEVUmfQ2@ashevche-desk.local>
References: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
 <20260628034811.152946-3-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628034811.152946-3-erick.henrique.rodrigues@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 28, 2026 at 12:48:10AM -0300, Erick Henrique wrote:
> Follow the IWYU principle: include specific headers for the symbols
> used in this file and drop the unused slab.h. Add array_size.h, bits.h,
> mutex.h, pm.h and types.h for symbols that were previously pulled in
> only indirectly, and add mod_devicetable.h for the device ID table.
> This prepares the driver for the guard(mutex) conversion that follows.

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>

> +#include <linux/device.h>

And this is for..?

I can assume one wants to convert the driver to use dev_get_drvdata() perhaps?

>  #include <linux/err.h>
>  #include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/types.h>

-- 
With Best Regards,
Andy Shevchenko


