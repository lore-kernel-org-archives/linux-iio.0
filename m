Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931343EFD15;
	Tue, 24 Mar 2026 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352662; cv=none; b=emkvEpgA5T2yXC1PXsEzl+u3rEhNdZDA2MBOwXns5I3Yr6eB+kfTQNZ7wzs6pcHlLujbNgi8yGFrUCdw3pK6ZlJSLE6hgD+yh76k5A/kKK87NrXoODBsH80M6Orqnjy5RRwKR9xv5hlWfpg2xEHRWIoQ1ny0wsSYFdXRIK6qpRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352662; c=relaxed/simple;
	bh=k9DZWatkmZZCRzO4Q1crRJIAYiKRxp17KjSEY2NefVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3scpNiqwyxZr+HLY5IBObTFpG+MGpimjrYDauVKA2j3aiQPs88DQV7X7SeXhrODkjmmuYZ2cTb8gRLL9bjAhLnzXj0MRwt/Fx2SwVinXe96ZNs2KXFW/uBWSmCUhqhKpiYzMxWXIwIsRsxblahhL1r65qmfAB3gUhEIRCRJw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eulUqmPv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eulUqmPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774352656; x=1805888656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k9DZWatkmZZCRzO4Q1crRJIAYiKRxp17KjSEY2NefVE=;
  b=eulUqmPvook7MmGShUcMlpoIJRZwlves8F/jUL3QPhwD+pq3wtZe1Lsy
   O1K+P/fYwf1Oe273IniW9XaU2JeYpobdnYlOlxYLbryfaXRqThCK88Jbc
   2p0ODFg4wqM8WQLfgIq9ykU+5iiC3mjpYvV8+k7s9R1PUs97qLHylax7u
   6lLUMIm1J45XEQecSNTM7ni5j97UKxNB+0EVISgtyniYdTfK2GDAPPF6S
   qE9wl2DagUq0hh6g8F9X+bK0h1OK3z2sibl6xTjlC19iE26BDmd15u3D0
   0iej51Dh9njz8HdqFTesEZdfxSpp6oPJE2vrYRaQEXkzWWcEXJvvQCWsR
   w==;
X-CSE-ConnectionGUID: va3H9ZgkQr6e7w2YspBk1g==
X-CSE-MsgGUID: zW1xiYtKRhCjGhtaXJHkwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="85673588"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="85673588"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:44:15 -0700
X-CSE-ConnectionGUID: g//h4VOERrWyR1pxFNFJ9g==
X-CSE-MsgGUID: kQTf8kipSlalaE6fvd/YUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224297643"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:44:13 -0700
Date: Tue, 24 Mar 2026 13:44:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: frequency: adf4350: replace TODO with NOTE in
 adf4350_set_freq()
Message-ID: <acJ5Cx8iPv5WwyTi@ashevche-desk.local>
References: <20260323233316.40047-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323233316.40047-1-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 07:33:16PM -0400, Neel Bullywon wrote:
> Replace the TODO comment in adf4350_set_freq() with a NOTE explaining
> that a constant-time approach using fls_long() was attempted but deemed
> more complex without meaningful benefit for initialization code.

Good enough, thanks,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


