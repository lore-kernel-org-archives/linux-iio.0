Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7333803CB;
	Thu, 26 Mar 2026 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552361; cv=none; b=AuJViol10prmLoXbnvoRkxTXaDj6GQWYrJ66Iogmw8y64uKHj2eH++4mxtRwDOPDJtdNwGgsGgSD/cCQseZj1Vbb3oZ+7a9o2PxFwkx5YgrSdT1liDetwac5aSYhpWm6KF8NI5Uex9P7PWrLnPr2Lv9m/XRqyWhTPvAStZl3JEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552361; c=relaxed/simple;
	bh=wkSmQureu7dXR/CT4mNpG2IpIss5q8gMK3NBxFJH8lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBrSazJlKssftIpBXaF0hKXhuXbGLyx6WaafBJPcKY6fs+b+emxEY3+5rhL/BYqqYyg+bsn5XlCdHxiL1G8p5Q6phhpSxotYTgOMpW7UJRk1HOUEDm2vkeSRkFZNTb7+ciF7rsKZ2XKylFLPcXHb2xh+PrEAVrACeMKDYvKBjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTf5zAMh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTf5zAMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774552360; x=1806088360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wkSmQureu7dXR/CT4mNpG2IpIss5q8gMK3NBxFJH8lI=;
  b=cTf5zAMh0td0PGvzh0DcP6Aos0jTUWToz2pFhiFXFdMFxo3+SbYoo42z
   YAIH7lD4GIwY2UWzXB9q0vIHB2IHDSZ53GuMX0NFy9BEg8OUewgA2qZ4g
   aFm4WoU/+9XU6ZDCXO6vTBA0CHTJOCWwdacgNLu4DT+nkgicsnY/zO2kE
   bAj1E5EJ8RCAMKVCybqwuUR1fjxJBAEPOBSGtI7/vYEc0C8c17FShTThc
   /72S9YNEXQ5ASxMTaOagxoNrg02n3vY5dN5JRWsDfM7ZEUXz62pWvzoEJ
   Rd8vySTthCpAB6bIZ8QQua3NV0YvB4ja4/LSN2ICaAY3GxmyuWs2WctrM
   Q==;
X-CSE-ConnectionGUID: EnOD3siGQR+RUeHd0kpWhg==
X-CSE-MsgGUID: uXGGjafnQf2gm3WkxW6/nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75737424"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75737424"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:12:39 -0700
X-CSE-ConnectionGUID: KMr5MMuFSLCI+k8D50C4HA==
X-CSE-MsgGUID: 2sTqgR8ERxSez5MRbgxO+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="220689122"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:12:38 -0700
Date: Thu, 26 Mar 2026 21:12:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] iio: adc: ad799x: cache regulator voltages during
 probe
Message-ID: <acWFI9KMN8Qtouuq@ashevche-desk.local>
References: <20260326180529.19154-1-architanant5@gmail.com>
 <20260326180529.19154-4-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326180529.19154-4-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 11:35:28PM +0530, Archit Anant wrote:
> Since the reference voltage for this ADC is not expected to
> change at runtime, determine the active reference voltage (either VREF
> or VCC) during probe() and cache it in a single variable in the state
> structure.
> 
> This improves the performance of ad799x_read_raw() and removes the
> dependency on the regulator pointers during fast-path reads.

...

>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/bitops.h>
> +#include <linux/units.h>

Can we have a prerequisite patch that sorts headers?

-- 
With Best Regards,
Andy Shevchenko


