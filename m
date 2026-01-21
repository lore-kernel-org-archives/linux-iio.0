Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC8362129;
	Wed, 21 Jan 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985647; cv=none; b=RLXoyU2QXmkvN1NGYJa0/Fo84T8zLvEFZB7p9jlqf8LedpQuz5knGt9012jOhxLbw5tbL+8aTdBl2LE+PrLMIqvVaABEN88KPjMMquTXvt4XtAA+LrvyQnauDJ3WM8ok8r1MTWNabWZfuyDKM6IjlQoCj6sf4bmvg9Cr3o+y/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985647; c=relaxed/simple;
	bh=Rx94yPtyx8GCTIfo2G6plM7lsWnY25H54RGIWj4Vkxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErquUZRJgFG58YN4MeuoSRdiJXZGx2WAPfMFJkHfU2wYcubzVee+iNuzgs3AV1swPr6+8GmFlX28tJgrtVeUND1DGY1Du4tXVq5uWZpWFZMI+swNxZaRVk3lAA/p1H6ilYelsucReF28YpNnb9wUOUh8Uod32HmrHy9OGnF5DS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZa92+JC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZa92+JC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768985646; x=1800521646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rx94yPtyx8GCTIfo2G6plM7lsWnY25H54RGIWj4Vkxo=;
  b=kZa92+JCWm/GcHnwbDquLia/2g4FxgORt2fChEROZB6E3JcMGnB8Y2Nm
   IuNGZKfjjs70hIR1qddH4QdfbNSq/qGdModlggD8o+dLSJbQ7E1QKrF2v
   5N7Mej7+Eo6rU2Id8dHMzNBEHjsLWddZlumWHT67LDnYY7lRNeEg5xlWH
   qOUNPx/1aCmC8MGCBFdMjsSUTphoxxk/Df8yl9hpEqub+AQdAmP/Vf+eJ
   IbK/BgmqNElahDmuxntneYFWe5ITExgR//7ZV86POj5Aa2iVcbu7Z9Jna
   CYgUTcBmxmE6+oeSkJ5KiJHdaAAarftZ/wG96BYZIxgjGy9gcoK1S8y/z
   g==;
X-CSE-ConnectionGUID: RQateGlASCu2PV4eff7/jw==
X-CSE-MsgGUID: aC81xMIjSkSN8iHlRlGWlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70262558"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70262558"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:54:05 -0800
X-CSE-ConnectionGUID: t2vm3NWRTPysfQKGZoz3GA==
X-CSE-MsgGUID: JYPyL8QzRv6erEaHM9AwbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206808371"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:54:02 -0800
Date: Wed, 21 Jan 2026 10:54:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] iio: proximity: rfd77402: Reorder header includes
Message-ID: <aXCUKMcCyYBf4ZdJ@smile.fi.intel.com>
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
 <20260121-b4-rfd77402_v5-v6-1-5b944d0605dd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-b4-rfd77402_v5-v6-1-5b944d0605dd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 21, 2026 at 02:05:41AM +0530, Shrikant Raskar via B4 Relay wrote:

> Reorder header includes to follow kernel include
> ordering conventions.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


