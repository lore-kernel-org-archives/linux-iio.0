Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266609;
	b=xbYKBENNgzc/bmTqg0LKT3r/bCrYCw+qE4y82vD/eP4jkoXonKHodU/XDYCO2VUi/wdK
	 Z7F8M0/6rIenCvdVfC4levSUaSareKRhNU4nI1VVZfOuSuIepJ93aIaliCV+HmsvJeL+U
	 NVL2luXbKxirauagqgONMkcwFc8oGds8VssmT2RTjuVQuSTTOcIovxkgaIed3ERpmxKhl
	 USB8QuDEW2PMZu1Ss52ToBQWkY9kjuzfF//K/dS/ZnJzNXH0Q/vGA8kxCZQU2yPTQsYo3
	 S7qyeyIsScbaZOmvIrG3EvnuZgNZnZ9w4UWd1bc/4SahjXwOLkUe4apzJOCwrPYNAtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266609;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=e48Nzbt7T7vOsDzpRwzz0Hu8bipDj10FGiC6Sxdi1sY=;
	b=i2xlrwAWp/K0hyJgz6KpyT/Bb02fS9YJn6iafnMs+1Nig/LDiLh4MeKsW56OaK8SXfa6
	 BCSX08wgrzYNwxTLedOa7h99ssWZiZ3l/qT4ROqyqskExseCJ9uNKkweT6I91ig0RTBef
	 bQSJ2uPvfDckWIPAlMve29PiDFjN9cgThAg+dPtsmcXR5jbdwBFaPGlxMSHjuhkpMKt6B
	 5CI7k58DYyN1hKbI9hkDVzdjVENMX3jRqA0OrECroCdMTqrusSecGLbeKNSTj6Yc1q/Ix
	 87wX+JURtXj4UaxrSlqPts/16IIN5pLUGA/rMMlqQxnlzz1T80DjjmuvyKPD+sLPKpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dq0NYGHA;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2096606A330;
	Mon,  9 Nov 2026 23:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2096606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dq0NYGHA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794266609; x=1825802609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m6P+ds4Bbd1GKkcp8yY0sONyxOaaxZa2C99Yj8FwDus=;
  b=Dq0NYGHAK1iPyxsG7O4jZM0y6b9ZyyYUJQvvoG672eNvWbJsywtka64I
   NrcQApTAl6QRK+tZ/Zatbx21ejH5AoxF+9HkADj//h7yoTaoz51GZJQVF
   vj/HlYzTxl2MuJ+DeXmIoM08vixBdXiIsaRublVSP2baET3lBEzTDZoNr
   9qXDMln61l6qR8b+SZf3tUBMIIJcLqBMMU0Jz17RPVSXzq90OND9WQqQJ
   FXK3vcomFIFZxT2lyWkexgJjBNKdzv6l7Y4B6cuHuvRwltWuUanjxNLCQ
   qIsCZYwszQoNZ25K2dgtNOep8JsMf0ntzavIQoxjjD1HHfqcYVILBwVsJ
   w==;
X-CSE-ConnectionGUID: WKTDsA00QOypYlEGIa4cwg==
X-CSE-MsgGUID: +eHJXsBaR2G5vuRmKeUQUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2990874"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2990874"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:23:29 -0800
X-CSE-ConnectionGUID: dQSypIkGR3eJtkqx53WGJQ==
X-CSE-MsgGUID: kWadeLQRRxK2HX51fQdeGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8129706"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:23:26 -0800
Date: Tue, 10 Nov 2026 01:23:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: phucduc.bui@gmail.com
Cc: wbg@kernel.org, David Lechner <david@lechnology.com>, andy@kernel.org,
	dlechner@baylibre.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, m32285159@gmail.com,
	nuno.sa@analog.com, sozdayvek@gmail.com
Subject: Re: [PATCH v4 1/2] counter: ti-eqep: Fix runtime PM leak on probe
 failure
Message-ID: <avJV68gHL_jvZ6dZ@ashevche-desk.local>
References: <20261109084342.51865-1-phucduc.bui@gmail.com>
 <20261109084342.51865-2-phucduc.bui@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109084342.51865-2-phucduc.bui@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 03:43:41PM +0700, phucduc.bui@gmail.com wrote:

> ti_eqep_probe() enables runtime PM and takes a usage reference manually,
> then returns directly via dev_err_probe() if devm_clk_get_enabled()
> fails, leaking both.
> 
> Manual cleanup via goto would mix managed and unmanaged resources,
> which leads to the wrong release order. Instead, use
> devm_pm_runtime_enable() and pm_runtime_resume_and_get() with a devm
> action for the put, so every probe error path unwinds in the correct
> reverse order. As a side effect, a runtime resume failure now aborts
> the probe instead of being ignored.
> 
> ti_eqep_remove() no longer needs to touch runtime PM. While at it,
> report counter_add() failures with dev_err_probe().

I'm confused. Why the PM runtime is used (and announced) in this driver at all?
Do we have upper layer (like a bus driver) disable power before handing over to
the device driver?

TL;DR: what's the point in runtime PM here?

-- 
With Best Regards,
Andy Shevchenko


