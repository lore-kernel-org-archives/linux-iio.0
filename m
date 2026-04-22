Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247E370D5D
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843004; cv=none; b=uvC/9H6Vryfz4AmHu9/CTA7u0XDS7Yci7E60pQGwHAoQQMZ7/RmZSwDHkUeBUyWbmY1dgidtGRkkM9Qal0wCODBmnRvNppzcLHclNqaff58BTcW1z0+Nscw0OS0jQkyTm8bwn92ZiaCvnEhXPs8H14cgdc7gsdWYL3tLTCasr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843004; c=relaxed/simple;
	bh=MHUsP1z4L1I8pLqpKYLpIZH/GHDTwWTJRKJ2zbnHLVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4Og0BAX64Wvw+acrAadlQSJYge2SJahNKVM7HuxmKdZZUvqgZQpqoTWg4wIhmeOqW8rPBObQRestqyzxHzLsqGLZLj92Fc3klJU3plT6qv3615hN24wUmjsm3Uo4oi+rqAmNDjcI85ZYdU91E8EGecx5OTP0stwsas7CqSJsRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgSEuyYE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgSEuyYE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776843003; x=1808379003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MHUsP1z4L1I8pLqpKYLpIZH/GHDTwWTJRKJ2zbnHLVY=;
  b=WgSEuyYEol4whM6BJxBkVzRQrlKkO887PigFg4JoRhJ/0KJnUJxq8Q2M
   eoAq6Kfry6BIA0cxkQnnUFNdvKB/rZbSCfgP98SigfesC7Sq668jqYCua
   7QOKH/gvwU6zjJlFF0EuwEp548hihvM1JGcm042efS+L4rbBUef349s2a
   B5cqK4yyrz/vrD8PTGwE7VHpuVf4RJSdv7e0vHpWuKG9K6+FNLQVPDu71
   j6wLmJGkJBWDlKtgG1mDkxrBQzkR1F3KHZ0oG6mgIGqypNCTCUggrIeuC
   SL921dYofyJPZLLYy4ZtedVrSCAMmpWTls2XwWcJp5PXz1uHM54/4fo/A
   g==;
X-CSE-ConnectionGUID: A58zTcEkTZS1xW22foqC0A==
X-CSE-MsgGUID: 4fjedGkAQGWo5EmBJPM+bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88091870"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88091870"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:30:02 -0700
X-CSE-ConnectionGUID: nB6802IJStK4Gz9dGG4zNA==
X-CSE-MsgGUID: +jN3GZQiQduDmGY+z9HYMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232573713"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:30:00 -0700
Date: Wed, 22 Apr 2026 10:29:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: lauraarakaki <lauraarakaki23@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tsys02d: Use guard(mutex) in
 tsys02d_write_raw()
Message-ID: <aeh49pjtFDNpgqCJ@ashevche-desk.local>
References: <20260421154007.1114389-1-lauraarakaki23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421154007.1114389-1-lauraarakaki23@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 12:40:01PM -0300, lauraarakaki wrote:
> Replace the manual mutex_lock()/mutex_unlock() pair in
> tsys02d_write_raw() with guard(mutex)() from the scope-based
> cleanup helpers (include/linux/cleanup.h).
> 
> The previous code stored the return value of
> ms_sensors_write_resolution() in a local variable solely to
> bridge the gap between the manual mutex_unlock() call and the
> return statement. Using guard(mutex)() removes the need for
> both the intermediate variable and the explicit unlock call,
> since the mutex is released automatically when the function
> goes out of scope.
> 
> No functional change intended.

> Signed-off-by: lauraarakaki <lauraarakaki23@gmail.com>

Read documentation, you need to use real name (as in documents).

> ---
>  
> +#include <linux/cleanup.h>
>  #include <linux/init.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>

Preferable to get a prerequisite that sorts headers alphabetically and
(optionally) another patch to move to follow IWYU principle.

...

Now the most important point of this review. All of the above you may
get by helping in reviewing the patches in Linux IIO mailing list
(lore.kernel.org/linux-iio).

TL;DR: I will be glad to see a newcomer to participate in the reviewing
first.

-- 
With Best Regards,
Andy Shevchenko


