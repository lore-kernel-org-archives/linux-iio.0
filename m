Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D24A0C;
	Wed, 15 Apr 2026 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243415; cv=none; b=LK2+qtUC5pml8mFT0LCDbZ1+7173fzBl/kwQ6zz1seGaYE0UJfAbxE+vib6cZul0gqn0LiIh7XGmL1P2kmH536nTjU+cJC+y8n8PEoR2IEAEe9kJiPwOVQBkoMHFe3IEoIPZPNlnW7s2fr6eMQ85Rp7bMUULJFJ8qyrNXowpcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243415; c=relaxed/simple;
	bh=ehH+LmjqjPgRYjKYnF+HBlpwIk49Rdm9XwnmjO6KXS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDcyr8SyWE2GSKUgfRRPGONqDJ7RLbFJYS1XPBKrgxLrFxJKXika5+3H/UVk84eR9IGctUgUIW5cXQSvwcfgnIMZEHAj2vpCDmiTEA12Abh/nBwsWkCX53qZFJ9d0Jrj6U0Upm1TNyUl9zaa6IZgW3CswnnCddBSCwLpNKL1eSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7qYIC3j; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7qYIC3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776243413; x=1807779413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ehH+LmjqjPgRYjKYnF+HBlpwIk49Rdm9XwnmjO6KXS0=;
  b=d7qYIC3jUgETCNpDcy3QHg2O1o7WdSDP72F5Eh8erSOhVGkZ+Pw4gtRY
   JI4bgiImysh2cEiIVeTYvLe3nMnp0fnPKyriJPsEMK05zK67Ilv8N2aWO
   KD8z4p5dZtiuF4NRk6et+XOwtLOsk9KpHfyZwy2UYs3tClEbQNO3cxuyb
   NwbNER14rlvf/QM6fNiouG4fDRkqJEQhL4BYdLc0tqd+CvL/un3Ovixtf
   PQoKmwi5Pi8JPuOoeO3WwtevfxSsDWmiKXsy2ZEAjLbYsRFmbt/5E+tiD
   Md9qqoPOS2gm1huZPfBZNtyg1ypDF/OYsBDU9Ed9cK62x8V8FZmSXmWBD
   w==;
X-CSE-ConnectionGUID: LXUx4JSFTF2eYsOd32oWZA==
X-CSE-MsgGUID: 6UvykegESKCZ6WmxHjUnDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="87916760"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87916760"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:56:52 -0700
X-CSE-ConnectionGUID: dSwkjlxyRJyU5XpJ0MaqlA==
X-CSE-MsgGUID: 8LdS7FG4TnSu2hxl9PnN/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="223860937"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:56:49 -0700
Date: Wed, 15 Apr 2026 11:56:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: frequency: ad9832: remove kernel.h proxy
 header.
Message-ID: <ad9SzwJDwRNldv_z@ashevche-desk.local>
References: <20260415080812.1284-1-joshua.crofts1@gmail.com>
 <20260415080812.1284-2-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415080812.1284-2-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 08:08:11AM +0000, Joshua Crofts wrote:

Drop the period at the end of Subject.

> Remove kernel.h proxy header and add bitops.h for
> better dependency control and code clarity. Also
> removed slab.h and moved asm header below generic
> linux headers.

I wonder if we need to elaborate a bit on 'linux' word as usually we refer to
the project as Linux. Maybe write it as '<linux/*>' (without quotes)?

> Checked with IWYU.

We have a (recently new) tag: Assisted-by or so. Can we use it here?

Otherwise LGTM, so after addressing the above:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


