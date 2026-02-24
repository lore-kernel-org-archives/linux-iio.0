Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCBB36CE00;
	Tue, 24 Feb 2026 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927127; cv=none; b=KHDDuWSODYxPCWrPpikJCdZL3H7CUcqRY20lU5LdlnbZXlDstblfTB7LtQ5wVxhhoZWbwOTfIPoPP+4DnxE5RQttpm2rrOArEN+LEQl+TwBHQdVM9JvEEoM0B9pbztJj3MD/Vr9w/Xi6yhXDE7Fs0H7tph2itQWpNGMfJkeFFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927127; c=relaxed/simple;
	bh=dQdNO7BjjPYZU8qlGfW9vPJVtXybqbl9IRQNxs5ezgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOhlONjUyj0KXD4zIm+i3JUKVNqJXId4k4bsYmkYbH3S0c+IV2qkUE91jjbe7T0DSGFO2oz4p6eL7QPfGEoFEV5TDnTIZ8JjAUiAyEDfYCCb5D9DxG30ligDI1d0QJsYPLXLvTfuRnlTggn6JYYJGXbq+xY5CG1MIDP8qV02j7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRicIVLA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRicIVLA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771927126; x=1803463126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQdNO7BjjPYZU8qlGfW9vPJVtXybqbl9IRQNxs5ezgU=;
  b=bRicIVLAggsMqBvzlR7YMb6m8T6pw0EU49vlFZnZ9UUjb7m9BJEFLC0P
   v0P3+cHg3upwfR8VEtdfj0GHRy8ediTgquuTOK6hycozWKVewWkCy+M1+
   WbLZ4OUFUfzlFT6NC3Zqx11zWmyPaE3bCMM6CxZsdfhx3H+ZeoY4csT4a
   4VSh/iHLWVQjL982lC3owmgolOeDJcIGfiEIuJx+CB4mq2h/b46YrHBh1
   0p8vjikkZFK/ta1ysT5l0V7Rs18Xn/EZMafJ9+LVg9MkMPUpZXkDTItre
   zZzjshXRsU+KHnr5Bui3o1h9SB37uzz/JrmFdLW8UHOmBoNk6XohdsWK/
   A==;
X-CSE-ConnectionGUID: nyUVm1kYQ+aQ/coEZCoiNw==
X-CSE-MsgGUID: 5gILiaUsStugTbeGUa0ZqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="76798245"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="76798245"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:58:45 -0800
X-CSE-ConnectionGUID: egMxUvQERlyhGvwODnbehw==
X-CSE-MsgGUID: 3s0tWeUWR56RaU3g2/Rw8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220852188"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:58:43 -0800
Date: Tue, 24 Feb 2026 11:58:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: frequency: ad9523: fix checkpatch
Message-ID: <aZ12UH4fPpZ05_ia@smile.fi.intel.com>
References: <20260223215636.18606-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223215636.18606-1-rougueprince47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 03:26:33AM +0530, Bhargav Joshi wrote:

This is v4, what changes did you make?

> Changes in v3:
> -Patch 1: updated macros to use '(x)' instead of 'x'.
> -Patch 2: collected reviewed-by (no code changes).
> -Patch 3: fixed vertical spacing and broken indentation.

Why did not you pick my tags for patches 1 & 3?

> These patches address several checkpatch warnings in the ad9523 driver.
> 
> Patch 1: Updated the macros to properly use their argument x.
> Patch 2: Fixed the multi-line pointer dereferences.
> Patch 3: Updated symbolic permissions to octal (0444/0200).

-- 
With Best Regards,
Andy Shevchenko


