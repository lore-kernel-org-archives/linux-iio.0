Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91553EB7E8;
	Wed, 22 Apr 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863791; cv=none; b=s74QUD4LZEyeY1qTBtnQWXRbjLloZPYMuP2bWH7ljRsXVOp63xyclavISs0IW4QV240XWs5016cVdch4OtM5uw8uA1BTgS+BxFQZct9gVXswEkpggPxFdpXfpoCoLCalbacZoBZ9BYUEzrOuh1txlae0qKQdoWZwo4QFeXG0RjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863791; c=relaxed/simple;
	bh=wiIjrmcktkrvvGCbgDTyj+CcNrw7dra9Q6dtVdyfipU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhVN2fXWdm2Ew9YZHeozKVA4Dnxlul9rskalJXf+t8W9OvJALx14ocwhuPPZfEsA1coatxf1EJlPoxmXSpgAzM6WI8Up+l7b8d0nLgs2H0Y5y5PFdYt3UIvZhvNojxE6KY7E6XKG2n9VPDjI+AVo0uKR1N1+25tkeLz9Wi6sQ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQiFLgqx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQiFLgqx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776863789; x=1808399789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wiIjrmcktkrvvGCbgDTyj+CcNrw7dra9Q6dtVdyfipU=;
  b=lQiFLgqxhpLs6FJN8Ilo+/KrO+VvE01boyruREZVSxOEFxmeuTg+6LXA
   5fcmLRnt3UCtwA5EHfnEUWzccoYBgcnU1zW7Gqo7Ni9v63pYE3ZEZUjTW
   gw5x7nn8aVe9IRk0DSXVHEgwRhjcl6UOdwsi/nDSHeNlsCPIvG9dhfDUF
   Yft9QicKfd2vsg7UJHEQOYOrBeL/VYKvGZOwanypXgtDlFunOh1HMAUQ1
   NuR6y+hpvGjGv8SoDz85uMYqWzTQhz+2F0TrXBsv9XNyUIxHc2VlC9D1P
   Ym6tHvgqhNODFBjPuMhpfQwzPPNDks8I5l7zeiyakjXA8n5k6a99TnKF3
   A==;
X-CSE-ConnectionGUID: /I3jUqEIR6CE9zOAewb1mw==
X-CSE-MsgGUID: 9LgQZUhTTRiOnG+ZMOCEbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="65350309"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="65350309"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 06:16:29 -0700
X-CSE-ConnectionGUID: NvUPB1U4RP+C5JAOo0MXlg==
X-CSE-MsgGUID: lmh2Lii1S1CiSR3tMWJSLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="270454556"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 06:16:28 -0700
Date: Wed, 22 Apr 2026 16:16:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iio: magnetometer: ak8975: modernize and cleanup
 driver
Message-ID: <aejKKKD4JdxIzlk0@ashevche-desk.local>
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422112207.1313-1-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 11:22:01AM +0000, Joshua Crofts wrote:
> This series modernizes and cleans up the ak8975 driver, migrating to
> more modern kernel APIs and cleaning up legacy code.
> 
> Changes include:
>  - replacing usleep_range() with fsleep() for optimization
>  - migrating to iopoll macros for better device polling
>  - removing unused headers and adding new ones
>  - checkpatch.pl fixes

5 out of 6 are good, one needs a bit more as it's a new patch in this version.
Also, wait a bit I'll send a couple more that you may incorporate in your
series. Btw, are you familiar with `b4` tool? If not, good time to start
playing with it.

-- 
With Best Regards,
Andy Shevchenko


