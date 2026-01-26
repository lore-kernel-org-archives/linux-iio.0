Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE5D32AAC7;
	Mon, 26 Jan 2026 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420699; cv=none; b=ut/35r+uf+GF72bnUEptdu6Q/0hDG65pJeQr2OEWmOZJYPn6CpafMtDfE71hWAjRkQGsW1lecSi/loLbku5jsHsZ/3JMoJAdU2xNvWxQaGuzNNkjmCrp62nCHZVK0ofAieq/wXRygmC8S8TEkNvwnc2sQBb2wTZDmoucQJ4Akro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420699; c=relaxed/simple;
	bh=E9NYO6dEC81bdCeH3KNCpyXUWxFTYmBKVrFhBjMXBRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiS/y5xV9vqyMCefah2dVOpJq/h2CJM2tiSG3pU8pAl2G4rTOGanR322bwDn2tdgxjz1L+UiV3HQA1sMeGJVzhLlMu2k2l3NYUZDW2Yo0FmiBcDhSxzL5T2/BYJPKFfaNvXxubHtCn9EWtTjVe8NZO8rBFTe71Cpo95GJm4vOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeHBgEEW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeHBgEEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769420698; x=1800956698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E9NYO6dEC81bdCeH3KNCpyXUWxFTYmBKVrFhBjMXBRU=;
  b=LeHBgEEWeb9124ozWmeWz7++nfzl6W3nvsGTl9y81OB12eeYvng4TN1+
   jCklmGP5ja/FDcvLPUU9aVofby2vHw5g3vfidzpWcQeLKOsYOYZaw1quX
   Ut6GtWBPWvGSqTWKeFGeJxwecId+yERSXo/t08KYr05ZkrjwcT4Twcem2
   0VET/+dhvZDZNdXa35bP9dP55JEM3klufZbHt9U6v0siGkHdWhdwnKRno
   jBw0vKEXg0HZCO4ZbX+zjOD8CMmKBNLu2zGdc4QbiXWkJSFzMD8Y9Slnf
   jfob4v8RDXjeS3zWuybXwoSB4x32zMp9CawQJBSViiYpX8iWvBNJI0mnq
   A==;
X-CSE-ConnectionGUID: nSgKtcYGQOGY53o2BYqcnA==
X-CSE-MsgGUID: bsqjK0owQmiuDUnJ33nP5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70638708"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="70638708"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:44:57 -0800
X-CSE-ConnectionGUID: Q8xxuXHrT5WillH1pLhkKA==
X-CSE-MsgGUID: FAwTdLF5QJSrcAlBEfkEvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="211730735"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:44:55 -0800
Date: Mon, 26 Jan 2026 11:44:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shrikant <raskar.shree97@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] iio: proximity: rfd77402: Use kernel helper for
 result polling
Message-ID: <aXc3lPNFF18ygeow@smile.fi.intel.com>
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
 <20260121-b4-rfd77402_v5-v6-2-5b944d0605dd@gmail.com>
 <aXCWz6O2CdU_Sp8r@smile.fi.intel.com>
 <CAHc1_P5hY6-z5s0J4SW_2GMER+NP4NsqoVVVaYFUg_gRi=31JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc1_P5hY6-z5s0J4SW_2GMER+NP4NsqoVVVaYFUg_gRi=31JQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jan 24, 2026 at 10:26:04PM +0530, Shrikant wrote:

...

> > > +                              10 * USEC_PER_MSEC,
> > > +                              10 * 10 * USEC_PER_MSEC,
> >
> > This makes sleeps shorter by 2. Why?
> I have considered the timeout values from the RFD77402 datasheet.
> The timeout values mentioned in section 3.1.1 Single Measure are as below:
> 1. Every Status Check = 10ms
> 2. Whole Flow = 100 ms

So, you should do this in a separate change explaining this.

-- 
With Best Regards,
Andy Shevchenko


