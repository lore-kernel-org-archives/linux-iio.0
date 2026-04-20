Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D040DFBF;
	Mon, 20 Apr 2026 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670010; cv=none; b=smuMbhpCb8FRzSVXR7uFW7XhH3/vOvRGR1nKR91GCQaS3vl9cB0v5GISyEUrQLkAiQ7sAkP3l9D4QcQ15qwdTH+f4aif8CLwQOhqybsDiEo5JEhKLA3cbJEf2hnhfOgMsMoNT/rv0abAV1d3ESFJyhIxcAtRjqKYYGdvw/UHZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670010; c=relaxed/simple;
	bh=BHLoB5la0oSO7Y//mKsL18bavdN5WFq98N2xw7QaRCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0sYMP1boWuSsLhAe+kemZQI4SBGD7Baf+v4mQtReu5zO1gB4dXlBW7coMFKGGA9YMmw4g3+pfujnYOM3s6BBgdzkZ23de1xratZcKvwGgq8m8+mCo1De7yKomLIx6dACLWRC99Jub/R4fz03EnOWZ6LxIG/4xmAaWkN8SwKep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWFN4ePx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWFN4ePx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776670009; x=1808206009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BHLoB5la0oSO7Y//mKsL18bavdN5WFq98N2xw7QaRCE=;
  b=PWFN4ePxA0Y7BnM13dRkV0feLEn/SrCTbFH9jtKmJLJmaBHUmDSIuz14
   fM7GgdqKW+M/+EyRr4iBrTAsdZIdxNUzR08l4QWZ7ytEiupNpm+q/UANc
   xpRTMzhLrpEQfh/KKX6tuqK7BLWaF6XBT/q8q1HeuVXIqcqqQKgZHOGCj
   mEnZwPCAxS3pvdRDG2dHI4bCW0Gcy+njdNxzjTBvOgbSItOH3lvE62dJP
   4TzaYo6CDim/89dIjBdesGa3/MRGw6UzdcCDEdS0CVL42qElonvx0Q62R
   x4GclQMMSeZUBJ+8iR76Oiu5Abiq90EmGynOBtjxsrWzf2OGKUuh2PyV3
   A==;
X-CSE-ConnectionGUID: r7B7Fxw6RIiLnHMVWxouHA==
X-CSE-MsgGUID: U2KFfNZsSTeF0fSBgxbG9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77702991"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="77702991"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 00:26:48 -0700
X-CSE-ConnectionGUID: INwgVck0SpaYmgAFs8edCg==
X-CSE-MsgGUID: +FSETbmNT32ThwRhOpK+kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="230775068"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 00:26:47 -0700
Date: Mon, 20 Apr 2026 10:26:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: srf08: replace sprintf with sysfs_emit
Message-ID: <aeXVB0ZQKOTTWsEH@ashevche-desk.local>
References: <20260418005203.85696-2-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418005203.85696-2-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 07:52:04PM -0500, Maxwell Doose wrote:
> This patch replaces sprintf function calls with sysfs_emit and

sysfs_emit()

> sysfs_emit_at. This removes unsafe functions and makes the driver more

sysfs_emit_at()

> stable and modern, by ensuring that boundary checks take place.

...

> -	return sprintf(buf, "%d.%03d\n", data->range_mm / 1000,
> +	return sysfs_emit(buf, "%d.%03d\n", data->range_mm / 1000,
>  						data->range_mm % 1000);

While at it, we may rewrap it to follow the logical split:

	return sysfs_emit(buf, "%d.%03d\n",
			  data->range_mm / 1000, data->range_mm % 1000);

No need to resend for this. And maybe Jonathan has better idea of this.

-- 
With Best Regards,
Andy Shevchenko


