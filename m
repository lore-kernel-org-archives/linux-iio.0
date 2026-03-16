Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1D393DCB;
	Mon, 16 Mar 2026 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669149; cv=none; b=hSwIZuP2MixTbcHFb/w3iQIl9f5nSlJQDCmyaGo4f66dgeSGumovCN3zU/VElIXI5kj1hcgkFiH3e+fgAxkEt0Qr1+b73FJvUa9OJ8J53UF8ShklzQGZxnzNjQgbG6+ekDKxlLUc1fIIJEVp9DdvYtBX9qfgu1xS8M1r4v51gVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669149; c=relaxed/simple;
	bh=8QUYEMnHt6BDDyZgni7G8Kbd9EJ43VRsFRy7ZN3J0l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llLYc2IHVYEG7cYPJ+CGxE7N6cAyBEWFac/C+ZF65cmqCKlhetwzf+DsiLVnoE0PnutPy8sgp50/r2pe6BtMtHz9xElLJ4u0g/+nnH6zenyUadEGcguWuc1KRkAh0ZErKh4A8Q4Db4ZNbguCsrDuHG6ohUaDYXlPCSInfnjSk4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QShMDUqZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QShMDUqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773669147; x=1805205147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8QUYEMnHt6BDDyZgni7G8Kbd9EJ43VRsFRy7ZN3J0l4=;
  b=QShMDUqZkdiTLVORNy/e5O/tr5Awq6czG1AHiDhtaWOZbhfaz8sXAkEX
   Ji7AnluFRnPKklueH5llti5EcXxDmh69sI/3KnrWTt/2PH01iSYD4DDQq
   n+Iiyv93noddlFgydgsqlkhYdFDoq+R6zkH+IYil9p44uSuCXVthjd0MC
   hAxbApDlvKpXV9CTQ3sd0y3hYnybSiWUJ3MmDyp6aqQPXt/5VXcuoI44o
   WGsljW0WPAaqmNOjlW0odSx5vrP5z8qa1rsvY4gFwtnmpV8hso8sB9ono
   Jc7PHbh3fLjW4Eqi0zwWmjoYcftNwuYfiS+keXbj7lsNk1nPq+6MrB5ao
   A==;
X-CSE-ConnectionGUID: v9py32ZIQpqnEKAWQkDfrQ==
X-CSE-MsgGUID: dB4XCrCsTA6WH4XZ7L5vnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="78579549"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="78579549"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 06:52:26 -0700
X-CSE-ConnectionGUID: uln2+18WTD+1zDyAZsGsjg==
X-CSE-MsgGUID: U4UNeStpRyuz4xdA0MeTLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217749183"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 06:52:24 -0700
Date: Mon, 16 Mar 2026 15:52:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: as73211: remove duplicate zero init of
 scan.chan[3]
Message-ID: <abgLFt_-OehTEWgb@ashevche-desk.local>
References: <20260315-iio-light-ad73211-remove-dup-zero-init-v1-1-4785c876ed92@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315-iio-light-ad73211-remove-dup-zero-init-v1-1-4785c876ed92@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 15, 2026 at 02:21:51PM -0500, David Lechner wrote:
> Remove setting scan.chan[3] to zero. Since commit 433b99e92294 ("iio:
> light: as73211: Ensure buffer holes are zeroed"), the entire scan struct
> is zeroed before being filled with data, so this is redundant.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)

>  				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));

Side note: the above looks like a room to improve.

-- 
With Best Regards,
Andy Shevchenko


