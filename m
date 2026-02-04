Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A915CD7E;
	Wed,  4 Feb 2026 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167762; cv=none; b=AJcpMg/91G6tqwbYEUP671wpDlZbBmBSQ130gMTOkpxnypwFvAZOEnkC2w4SLLnZkADJCkUWWE+WRUyyegD+rQzH30YPep8qUNYr5Ugb80WPxGYS0WmGIo2JBIDMbOfwWDBGQIjezObL4P7HyZeYCx24OleIE589h4/pSkJpoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167762; c=relaxed/simple;
	bh=OIg9LzYoShWXm4erIV62atml3qc5zYZmkx1j/2vlCw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jyaok7HuMLahxZBC6cGbbNXoQrkdXozy1q1G7U5g21NrqMNY4JqWqNO2GvNyUBnhWXt44NuEgD+PrdUC5HE51AoTCpBMETi5BIqG0kJDAAkShN6K2LURJTYxiaxchQaUDy25Tyk3axHRTvdw2lyoXsHkhxLQjJnXeY7LrT9sjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4Xg9SCu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4Xg9SCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770167761; x=1801703761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OIg9LzYoShWXm4erIV62atml3qc5zYZmkx1j/2vlCw8=;
  b=Z4Xg9SCu/IFJP505FiBmV0Xe922ccgP4+ZoLfnYtHKHpS3YH7C1gYhx7
   YEuwpy+Pk2EYHk5mRi4lTcZvp07VdY9eAJVawsUmGkpSXwQadXkCYakBT
   JWC5vX2Jk085ohX+FxRtD7dw5NlripnKGC1wj2d+28GSqQThanPWzUq97
   WxCL7BHPiqfpHZHJUyr1CK+WkVwisNthUFXwmHksTSIgbciiKCB5syO2v
   WpRZlMDxuINOlP7FBrrTKCDnTf+KTuQtjb9py8LZeqgWEesqC7Gm8kXUn
   DuuNSynGMu9jSWo/MB60saRZpJtTyVecXDCd64oD4xObV4/DAPLcMpoZw
   w==;
X-CSE-ConnectionGUID: YAD4kyUgS6aNQfiZ1h+zkA==
X-CSE-MsgGUID: xQWTLo5PT6alLhpk8N3vhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="81982992"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="81982992"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:16:00 -0800
X-CSE-ConnectionGUID: r8pPS+N/RbObAHA6HlEvnw==
X-CSE-MsgGUID: 9dy4soOvSG63jyDkKIOx7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210045787"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:15:58 -0800
Date: Wed, 4 Feb 2026 03:15:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: bmc150_magn: Used guard() for
 mutex protection
Message-ID: <aYKdy_3lSQ0dfRtl@smile.fi.intel.com>
References: <20260204010529.48000-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204010529.48000-1-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 08:05:29PM -0500, Neel Bullywon wrote:
> Replaced the manual mutex lock/unlock calls using guard() to simplify
> the error handling and reduce goto statement usage.
> 
> By using RAII-style cleanup, it ensures the mutex is always released
> when exiting the function, regardless of the return path taken

Missed period.

> This was compiled test only

Ditto.

No need to put this into commit message.

Code wise looks good.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


