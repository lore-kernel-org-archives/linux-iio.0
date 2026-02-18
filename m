Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A6194C95;
	Wed, 18 Feb 2026 07:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771398608; cv=none; b=p17bkVfBnnkPsMIm1ce7nx7uWyQZUGqSsA0H3IIZ26Hbd+4xtvfSvPXrkh24y0Fq1zcsVwY+3wpCyefs+JWkFMj4mTbiJtxtZPnuYssbo25hn9QB0nTo6P5UtUA1Y06WbRHVWo0g6UHS/7G1Dkur+aOrqQPmN0M1ac6YISVHBig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771398608; c=relaxed/simple;
	bh=The0KleRDhuafabtv8KA3SpElAZrStUsMoo/dw/HD6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBLDVSdmyoDNVN8CGpoBgBHNynmLvscSCI54t+syNurnyjVboMpT184wuIPKqi8ZXs0aEo97CgCgj4WGd13nsbHs8o6cC9jx4sieytFw3MMb87Wms1lqm8Lq1UCji01mFyUBcpQdiCQ07X69Y54SjeUPL9h4A8IvH0fdKkm7WMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/XEfYhb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/XEfYhb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771398607; x=1802934607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=The0KleRDhuafabtv8KA3SpElAZrStUsMoo/dw/HD6c=;
  b=P/XEfYhbE9JNMsCLr3YDIriiNsTU2XcIZ0fwKMLLK3sCF+Q6CN2gkuKc
   rwLRJKNeYo2oC1J2tUHYDa3qXrK0vr45RjU/tQs0wluByGJpKZY92jII5
   b449lS06pawgPCuoWT/is1zK/hh7G4YC5TlqQbHJAWKW0JpANnbKLTBEU
   /lceWOM/k2p4qD0bZwqtKQpYIoHJvDwIntjSqxyBE5E1O1D6meAuEHr97
   Zy0pzwe2CbEnLfgQVRaIrfOY/VG1hJY0bvOtzTIXHw6kOAnwJ9R7Wj7Ft
   YhovUfSp7u9YN9kgZ91W9DHBVdIuOJFYqK9IEY8ToLTkyRNfF6Xenyirg
   w==;
X-CSE-ConnectionGUID: TGnyj1h/TlKacLT+G6/0Zw==
X-CSE-MsgGUID: 2D5kywesSWCZBnV1KYCbXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72648741"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72648741"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 23:10:07 -0800
X-CSE-ConnectionGUID: Je110nv4Tou/m866ktATwQ==
X-CSE-MsgGUID: OFYkSDSrRwGQeyKSIDcPzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="214226193"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.215])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 23:10:05 -0800
Date: Wed, 18 Feb 2026 09:10:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] iio: light: gp2ap020a00f: General cleanup and
Message-ID: <aZVlyiC8WOrYoDWy@smile.fi.intel.com>
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218043728.609659-1-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 17, 2026 at 10:37:19PM -0600, Ethan Tidmore wrote:
> This series performs a general cleanup of the gp2ap020a00f IIO driver.
> 
> It integrates my original work switching to the guard() cleanup handler,
> fixing a signedness warning from Smatch, and cleanups provided by
> Andy Shevchenko [1].

Thanks, my comments below and in patch 1/9.

> v4:
>  - Integrated Andy Shevchenko's 7-patch cleanup series.
>  - Patch 1: Removed redundant 'err' variable and whitespace issues as
>    suggested by Andy.
>  - Patch 2: Added Reviewed-by tag from Andy Shevchenko.

>  - Patch 5: Updated commit message to describe the pre-existing bug fix
>    in gp2ap020a00f_buffer_predisable() where errors could be swallowed.

As I mentioned this perhaps better to split to a separate change as
a prerequisite to the mentioned patch.

> v3:
>  - Addressed initial feedback and simplified locking logic.
> 
> [1] https://lore.kernel.org/all/20260217102318.1354103-1-andriy.shevchenko@linux.intel.com/
> 
> Andy Shevchenko (7):
>   iio: light: gp2ap020a00f: Use correct types for 16-bit LE data
>   iio: light: gp2ap020a00f: Replace custom implementation of min()
>   iio: light: gp2ap020a00f: Return directly from the switch cases
>   iio: light: gp2ap020a00f: Use temporary variable for struct device
>   iio: light: gp2ap020a00f: Explicitly use string literal for driver
>     name
>   iio: light: gp2ap020a00f: Remove trailing comma in termination entry
>   iio: light: gp2ap020a00f: Join some lines of code to be a single line

-- 
With Best Regards,
Andy Shevchenko


