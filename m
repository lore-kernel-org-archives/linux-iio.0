Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54F481A9C;
	Fri,  6 Mar 2026 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831570; cv=none; b=qdMbsJ6ny9Xu8n6TRN5UHHZ+O/zenjkAQ8ulsk6zHQiHbSdx2/sz9q87NPhag+dJt+s6iErzNScHpto/aymNkynTPg1O2u5FnUlrkFnw+1QtjetfWbPuqcU3rS9uHmo/ucpKLQpHofDio8NN4AhQe43XvCuhckS/H0hSRiFinyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831570; c=relaxed/simple;
	bh=ekp50pt/6gJjNnL01InaXv0W24vqDd2UVg/FyNG56ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9GDsNOSc6Nx8ydVq4oZhlyue93r/jbaltoqgA6JUTx0T7cMHNJLcNGjKZWfm4LDGtq5HOl9xojtFSzdoMiBdoLfNxMbLUS1EpVNO7IgqQXqLC8QXDRiysDgQFDMFt0m777Tb6oSUjIYeWSASRrBx/KfuMC40mzCk8olAMqUMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgSYigh8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgSYigh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772831568; x=1804367568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ekp50pt/6gJjNnL01InaXv0W24vqDd2UVg/FyNG56ys=;
  b=EgSYigh8J98J8NuOMNgUguswRCF1t6Yc6B/SpJhx7Vfbt2O6yrXod+8C
   6xzSAyzeA1jHgv7Mjo9rKgj/SbAXk9fRTndZEuOaRdUqaKhxycrHm8MAe
   +IbkMkDWi75FYPrjQHQVP+x9FLh/vtzuC2Bixljga+QlqRmu0XV1A1bi4
   /qfdVs+pPKlQ3KhAxQU3x4ahVWfgdpgcVDQ1KsNv1YN+mxfpLPzwPG5+u
   z6Uwy52qun1Z/2SJuurKP5wodcCozzgVYnO2FOp0J2iHsv19qQJ38zH0S
   qtF/VacYvQT4YxEoVHj5P/n5a5hsIU8a6ndZ1zVORCMiAP0FrG2awbG/R
   Q==;
X-CSE-ConnectionGUID: TNJmNg4qS1eUKdtQlIrWqQ==
X-CSE-MsgGUID: YTOD92kVSr2Row100SGKxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="76552709"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="76552709"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 13:12:47 -0800
X-CSE-ConnectionGUID: 34lJSiWuQDK/VYuJtpL12g==
X-CSE-MsgGUID: xKKyWEVNRQKdC4H9epRFbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="215763527"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 13:12:45 -0800
Date: Fri, 6 Mar 2026 23:12:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	puranjay@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: convert to guard(mutex)
Message-ID: <aatDSpZW54mLxjkF@ashevche-desk.local>
References: <20260306202650.61865-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306202650.61865-1-rajveer.chaudhari.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 07, 2026 at 01:56:50AM +0530, Rajveer Chaudhari wrote:
> Replace manual mutex_lock/mutex_unlock pairs with guard(mutex)
> in several IIO drivers. This ensures the mutex is released on
> every return path, preventing missed unlocks on error paths.

...

>  #include <linux/kmod.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
> +#include <linux/cleanup.h>

Move it to the better place to keep more lines ordered.

>  #include <linux/kmod.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
> +#include <linux/cleanup.h>

Ditto.,

-- 
With Best Regards,
Andy Shevchenko


