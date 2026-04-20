Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBAC3CF04B
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716795; cv=none; b=PM7LKb9zfSuv0wdia6XKYL/SxIj/pCWns3aNyQU5h6VzXsIsPUt3CCXRJi5mYv2plHttfQLqKD67G5JQ2nSgXLzuDFvo/oQ18LXXUvSEjQCeVp7VMP5iQlNwdYi7/RW4hDGaBYZXYW1DxujBNE43GGMdeLDdoqSSQ8vQa4L1Dh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716795; c=relaxed/simple;
	bh=EMf0tP7UdDBcUltCHR6fOX3hr5dcrrfJvWCIRQFmFA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJRarRXv0ZF/sY0yD7+a7CfE4OIZSTRwo/vrdbveF5uNwxgFyDZG/y6/8zQd+hJ3rYPP1DV9InG4X/7VEUZPyrcgPfdN8PUB/lb6KkRWdEUQ+sbmtrAQRKH7AWYMSClRaLNgx2pPYfcvBlO67DX4oFNMApD1//jhVNpunwSt3EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnHTprB4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnHTprB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776716794; x=1808252794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EMf0tP7UdDBcUltCHR6fOX3hr5dcrrfJvWCIRQFmFA4=;
  b=YnHTprB4bkPDJ8OG68bGH9lgMPlwR3DCHza6vIfuVE3v2/E1pIgrYICX
   j1QS8dVuk3uJXvt1L5qKK8FihVKvl+oRMDAzzlxM3KUZpHrW3Hs3t18FZ
   iSWSxZ9H9x6KiX464Y4qI56wyiHcneHkA7dGDmAwgTgyIaqbNKv1oxUVA
   Jpi1MJGv1MLTXCWHMf1nG0FjzJC7yMTbi03JCvFUiAa25TJKDKz5ABxsN
   EQ1Csr3zoWmXgIy1whwTrqlCi3gQVyyeqtNm5XXDccVZMaVCioZ+yxiWI
   377/gJEX77V3+iwlq5POSyigra7+OoStwdDO9rVPkUvidxNVouURf3sDc
   Q==;
X-CSE-ConnectionGUID: e5z1MXTqRQi6RFv1qKQ/IA==
X-CSE-MsgGUID: /NW+EOCnRxmDZd7lOuIPyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="76807400"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="76807400"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:26:33 -0700
X-CSE-ConnectionGUID: M5ah8r7pSUatut23HRegXg==
X-CSE-MsgGUID: Rdg81gkjTtSU/R470c0GhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="227480662"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:26:31 -0700
Date: Mon, 20 Apr 2026 23:26:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Raffael Raiel Trindade <raffaelraiel@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Kim Carvalho <kim.ca@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: vcnl4000: use lock guard()
Message-ID: <aeaL9ZvMEFF2OK0n@ashevche-desk.local>
References: <20260420200047.102159-1-raffaelraiel@usp.br>
 <aeaKP2vARF-Bv1-2@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeaKP2vARF-Bv1-2@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 11:19:11PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 20, 2026 at 04:59:33PM -0300, Raffael Raiel Trindade wrote:
> 
> > Use guard() for handling mutex lock instead of manually locking and
> > unlocking. Remove gotos in error handling logic. This prevents forgotten
> > locks on early exits.

...

> >  	regval = (ret & ~VCNL4040_PS_CONF2_PS_IT) |
> >  	    FIELD_PREP(VCNL4040_PS_CONF2_PS_IT, index);
> 
> Side note: This can be simplified with FIELD_MODIFY().

To be clear, the patch LGTM, the above is a material for another if you
wish/have time to do so.

-- 
With Best Regards,
Andy Shevchenko


