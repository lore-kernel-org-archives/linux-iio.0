Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293F38F954;
	Fri,  5 Jun 2026 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682220; cv=none; b=kO4qoaZg6nrA7lSn2occYbJ/X3oua9HfKZgQEMbtgCXNFxAE9d5OTMOFw59D1/lXtZRglRRkBYmq/wIsy8oMjc0WO8Xv9/9t7LKKgT9vXJv4OJC9lurRI1rRmj50G2E7MgmVVh02Tz0UVHnh/tD5Ldi86rrU6loczGsh15l0rsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682220; c=relaxed/simple;
	bh=Z0gEEKZY1qOmJlpkrv9qF4fblwDo7YPaxiWd0mjtJ1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQfolbq17Gw7KdF2BfetyvwUbY+6rEoGjfJFw8n1TjaOUyAUHNJzGgZNpLQPEyoLYSlU7IhaeuA1hcpr8u8KHyoVMy1WRAQ/cCT6xLvUbFzAMB8+0peeyV5jfhuis/D4Hlk/Jcj8StcT3xLn6dEGiqBuUOYQc9iSW0uXplIqiiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGtN3QCz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGtN3QCz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780682218; x=1812218218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z0gEEKZY1qOmJlpkrv9qF4fblwDo7YPaxiWd0mjtJ1c=;
  b=IGtN3QCzAs/RhXOtYhk+KgT3P6Ce8sviSqSpI8Ce12QTu9QhAavf1SbN
   P2JJPdEmv+Pq4K92zar2FMR0xeF3mGWrtvSX8/mPfSqWytc/J8OPwsqh9
   ISFEX9hY4azWoYfROwFidYN1A/FyVrBYErrZKimKCVeCR+pciUZrTBX0v
   0m/1tKsGe6/ROd3DxmxUhsyyN4su6uvz8cyGDial4FVMWKFhh+F9iwR3/
   zFGE1458141HB2wTmueUITxU5rnPPdsWfoLqJNEI3Q7pZY/TayX6a/IKu
   gVedexpafeE4UCsBq7TT5Wsoy1hZQfgWLJ/mxMFbyn4MIy5QvEflQsVK6
   w==;
X-CSE-ConnectionGUID: VRcDg/bbS0+BHru3MhNgIA==
X-CSE-MsgGUID: fjFMuAJbRcmZjy/HThn68Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="84097819"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="84097819"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:56:57 -0700
X-CSE-ConnectionGUID: C8jNhh5TQwmmA/PUCEFisg==
X-CSE-MsgGUID: 6RKowWkrR8WCGLchdR2pTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="240719808"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:56:54 -0700
Date: Fri, 5 Jun 2026 20:56:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, sozdayvek@gmail.com
Subject: Re: [PATCH v3] iio: accel: bmc150: use guard(mutex) for mutex
 handling
Message-ID: <aiMN5N8LJ_m1rdUa@ashevche-desk.local>
References: <20260525110130.61284-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525110130.61284-1-grondon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 25, 2026 at 12:01:27PM +0100, Gabriel Rondon wrote:
> Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex)
> and scoped_guard() from cleanup.h. This simplifies error paths by
> removing the need for explicit unlock calls before returning.
> 
> Most converted functions hold the lock for their entire body, so
> guard(mutex) applies directly. bmc150_accel_trigger_handler() only
> holds the lock around a single register read, so scoped_guard() is
> used there to keep the lock scope unchanged.

The last paragraph is matter of the comment block or cover letter
(but currently it's a single patch, however with the below it becomes
 a series).

...

>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>

Please, add a preparatory patch to sort headers alphabetically first.

-- 
With Best Regards,
Andy Shevchenko


