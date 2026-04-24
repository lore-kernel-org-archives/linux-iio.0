Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8937F00F
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017687; cv=none; b=dK2LV/n7eTCS3xM0ecez3X3nOHcNAoj4gREzpO81g4wJLGdGaYDVSCBhC6HEN9Z4GiZha1eVFCsO3Qx8ivIR8dXeKwCarmTige3yGLuydC54Nkq7KLpst/k3zlTfVN8oTVnu3p8TVkkoQCV4NT+z4APtDtmnj35uvVgoolKD/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017687; c=relaxed/simple;
	bh=PvAqjWguAUnofsv0gl/bNQ04prAmC4y/Al9E1OLEjEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ9EqZtmFXO8bubx8SIyfkXaklO8tYh0/GdrSzUhhLycbH7Dh43EPA39DQZiLJxl3aD8O0NP5IC1O1aVfNlwGFtz/DFw+e0vbJySZdiVwai8+LFtS1h7dFCN8C037sUr6Ns4eMv5EJJrlCNNbwZhCT3W2LiOh0DWz0vyH89mi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOn+SM5D; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOn+SM5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777017685; x=1808553685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PvAqjWguAUnofsv0gl/bNQ04prAmC4y/Al9E1OLEjEQ=;
  b=hOn+SM5Dm3ACls96yq/gqsRZwrLwsFqWxazbpvjjvFlWsq4YF27pM9kV
   c6LCIrRKdBPFpCKomH0qEnbLLb9XuCKpWeCujP/B6vaFGF9jZYlS/JS/X
   cIsz+zl0/L0/0oAXF/RQRBNo73ZnvifQnv8mRYj8KYjmVyaW/YyKJmfYM
   OYaq+BaXXfR9MMF0IwYdByN66UWa5AqI0XNUASBgzExFjL0Tgb7Ad2+7j
   HOLEubedjvfgZxrGk+X2Fp0MI5OtSqygl1RamX7YIqinWYYmN2Fw1dCZk
   FSuEJjsdSWDf++CYv88G37uP4Re+QuPxhkQVdl28dIyCYEw1LQ1cHIJ0G
   w==;
X-CSE-ConnectionGUID: 1Bqmy+XxSeKA2su+WqjNyg==
X-CSE-MsgGUID: SgbaYrbrRJawV3HTP1qnIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="80579481"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="80579481"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:01:24 -0700
X-CSE-ConnectionGUID: 8/uIT3hSRjWqumg7BnPeDQ==
X-CSE-MsgGUID: 314xck/cTCiV4j0Z0rKQow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="232797913"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:01:22 -0700
Date: Fri, 24 Apr 2026 11:01:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com, Eduardo Augusto <eduardoaugustoabc@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: adc: mcp320x: sort headers alphabetically
Message-ID: <aesjT6Zo50KS3BaR@ashevche-desk.local>
References: <20260422222553.67660-1-gustavo.pagnotta@ime.usp.br>
 <20260422222553.67660-2-gustavo.pagnotta@ime.usp.br>
 <aepa8jD4uBrtY4WV@ashevche-desk.local>
 <CAD7rJs=gNZoS7=HfhUoi6K0myMQmo-9Wd_-oYcfkX8cAtpBJbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD7rJs=gNZoS7=HfhUoi6K0myMQmo-9Wd_-oYcfkX8cAtpBJbw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 23, 2026 at 05:45:08PM -0300, Gustavo Pagnotta Faria wrote:
> On Thu, Apr 23, 2026 at 20:46:26 +0300, Andy Shevchenko wrote:
> > Is this SoB chain for real? If you want to give credits to mentors or so,
> > it should be done differently.
> 
> Yes, the chain is real. Eduardo, Christian, and I are classmates at the
> University of São Paulo (IME-USP), and we are working on this driver
> together as a group assignment.
> 
> We are doing mob programming on the same machine, which is why we
> included the Co-developed-by tags for everyone involved in the changes.
> They are not my mentors or professors.

A-ha, thanks for elaboration on this. See below how I suggest to address this
case.

> However, I understand that having three authors for such a trivial patch
> (like sorting headers) looks highly unusual. I also realize that, as the
> sender of the patch, my Signed-off-by should have been placed at the
> very bottom of the chain.

We use terms: Author, Committer, Submitter. The latter one is probably what
you are referring to.

> For the upcoming v5, would you prefer me to keep the Co-developed-by
> tags on the main refactoring patch (Patch 2) and leave only my
> Signed-off-by on this trivial header sorting one?

It's up to maintainers. Just put the information in the cover letter to explain
these rather long SoB chains. If maintainer is happy, they will take change as
is, otherwise they will ask for modifications.

-- 
With Best Regards,
Andy Shevchenko


