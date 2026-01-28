Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05B374181;
	Wed, 28 Jan 2026 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632918; cv=none; b=oXPINfY4vyg2TSN5/AJ1af+NeivFmY+9CN8FgzYFpJ8bO70h9GPb5S5X2SIfOoXcu0mtUyJYqGNkJZfQ0PH3Z9zbcO+0zP/WXVsZXQB6HMJWBXrsdDKWFrltzhS1fnL8Z7afpICy1vmg7cRyvvmOR5DjrFVZ2B0FWi8qakxmSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632918; c=relaxed/simple;
	bh=aTa1SasjcPNJSAIlQsD9DBRD5K5I8eNTV1zMMP9SvCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPpNXK33z4jnnz/ArXL/cDPGJiERmiqRIjQM7HvNQ4zVbTZM2YivSuzupYdsMRPQKYW3iNzlnzrOwtBp46Uh9ykjyxhd0qJDWGzxUK6U7p3Pvgcj6oQspiBAImxoRSyPf704DCA8lTl8R65uQbWDABlEdrrSDwyR2Fg4rVCfOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxEctUUL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxEctUUL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769632915; x=1801168915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aTa1SasjcPNJSAIlQsD9DBRD5K5I8eNTV1zMMP9SvCI=;
  b=cxEctUUL92vMbKIisoNflzQmroz20JGwn2Fg+gjxQjMrprb/ZXkZzUal
   wMCyP4s6XwAje12u6C3DicfMVBMszBINBJ3GpeuwfN5PVt2WM07U3F6d/
   m54TyjHJwjZnAc1LQDssBKUiWizzwCUNM2sbFMTSrg0UixP+NiNGCVoUY
   dY8ILavu/Yy6aq5iGZ1ATIglrzMCctlFl7b8yIm9zIx+Xr773E2ZIBPnB
   ctO7tJJ4E3fNQ4jnNt3hrbEIg1gU5BIUWKHFCFctV+x5HNW95P93TlvdK
   XZVg51jeRLhDLpJcU68+I4CXJmMc9GvaKgQ7FpqVqrtQLsW21SB71YvaW
   A==;
X-CSE-ConnectionGUID: ulYxGprOSUSNL9z+HA8o8Q==
X-CSE-MsgGUID: l6NjqWDxQfax9dMLz0xi8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="88276629"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="88276629"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 12:41:55 -0800
X-CSE-ConnectionGUID: 9Rfx/LX7RT6yGVQaWFhJPQ==
X-CSE-MsgGUID: GEufbCaPQTCfkQT5VwRgkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208268279"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 12:41:53 -0800
Date: Wed, 28 Jan 2026 22:41:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: buffer: buffer_impl.h: fix kernel-doc warnings
Message-ID: <aXp0j3DLvzRCM_XA@smile.fi.intel.com>
References: <20260128200721.540666-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128200721.540666-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 12:07:20PM -0800, Randy Dunlap wrote:
> Resolve all kernel-doc warnings in buffer_impl.h:
> 
> Warning: include/linux/iio/buffer_impl.h:172 struct member 'direction' not described in 'iio_buffer'
> Warning: include/linux/iio/buffer_impl.h:184 No description found for return value of 'iio_update_buffers'
> 
> Also correct one typo (word order switch) and remove one stray space
> in a kernel-doc comment.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


