Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310A2FBE02;
	Tue, 17 Feb 2026 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319571; cv=none; b=FUYVlp18RJc0Dm931YsgnbTudEm6QywyYqWg00bG6ry5vw56jf5VAH8WWQKf7dYnnqhS3Yy0nAno2bBZEWEK+muWe5pQ8HVyNR0QiIqkCZ/edbCLEiIKe2Ssz3779BXKo6K2L12sXbbbW6n2Hkyf8EEk9B+B/7NKr7Hbdul3D90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319571; c=relaxed/simple;
	bh=l4Xam8yiPLGEHXe461MtcqKJEJ1ddmht3YkH6t4SHls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xgf0x9LNBflZzt5voUgftkN1R6p+KtuOBCuQQmYXRDAowPTGIVBfwg5UoJYZGwmLVtUOLtIxvEfCbnReLW4yFBkn+iZ6AiLwk25O7s272DjbED3wWMtwLtUF6BtDm+JxiK1L3YPQJTk8nrnqnlKAPIkOElPKjWwG+pq+Z491V7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYBU/UVG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYBU/UVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771319570; x=1802855570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l4Xam8yiPLGEHXe461MtcqKJEJ1ddmht3YkH6t4SHls=;
  b=mYBU/UVG6H0UmyiAg8hbBBKtramjvxHdaScIAtujln2FMlI3B+Nw7U9R
   H8PxtmnTEcLj7FDDyPdfkaNCmaqP1HrVPnEIp3m+e0QshhTaCgFTVKds5
   qjhAiKm+QGjL24+x9FSfXB02vJZmKCeqrBcco5nfLbLWbNFL3QdbRiQ5z
   9nbb9YzSbyOiP8Ao5cSnkQlXdEhZi3SpmDa1k23o6dsPZJ1DeEtVjs+vL
   vlNDxxhbjhlXyLEvWltFnwO2FCRu4+wOf1DGQDnKn/Y+0Tutkeo5ldpFa
   2h0zp1TDHgOkMTEq3uBGo3NENoNWWxy+KMpy2BVjO/fMBtntJuKoNljzk
   Q==;
X-CSE-ConnectionGUID: rkmvNjFLTtmOW6q4McTtpw==
X-CSE-MsgGUID: W2+iRm4PSECxUjzC4Hdyeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="71406914"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="71406914"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 01:12:50 -0800
X-CSE-ConnectionGUID: +7/pNaBjTIynQbNEqq2rkQ==
X-CSE-MsgGUID: d1W4MB3ARuGLY2IBk1coUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="236840106"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.124.220.245])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 01:12:48 -0800
Date: Tue, 17 Feb 2026 11:12:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: light: gp2ap020a00f: simplify locking with
 guard()
Message-ID: <aZQxDW4RrzG1d9Je@smile.fi.intel.com>
References: <20260216005317.11763-1-ethantidmore06@gmail.com>
 <20260216005317.11763-2-ethantidmore06@gmail.com>
 <aZLCe_5C8e82EMGO@smile.fi.intel.com>
 <DGGOWGRQGI1C.XSJ585TPVWZA@gmail.com>
 <aZQovkDI3G9-B_Zr@smile.fi.intel.com>
 <DGH464NASHBX.1VI3NRMRY5QX5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGH464NASHBX.1VI3NRMRY5QX5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 17, 2026 at 03:02:48AM -0600, Ethan Tidmore wrote:
> On Tue Feb 17, 2026 at 2:37 AM CST, Andy Shevchenko wrote:
> > On Mon, Feb 16, 2026 at 03:04:55PM -0600, Ethan Tidmore wrote:
> >> On Mon Feb 16, 2026 at 1:08 AM CST, Andy Shevchenko wrote:
> >> > On Sun, Feb 15, 2026 at 06:53:16PM -0600, Ethan Tidmore wrote:

...

> >> >>  	int i, err = 0;
> >> >
> >> > Would you need the err assignment now?
> >> 
> >> I'm not familiar with iio_for_each_active_channel() but, if there's a
> >> chance it could run zero times, then it'd run into if (err) with err
> >> not being initialized?
> >
> > Have you read my other comments? I also mentioned to replace
> >
> > 		err = -ENOMEM;
> >
> > with
> >
> > 		return -ENOMEM;
> 
> Sorry about that, when you asked about the assignment, I thought you meant
> the initialization (err = 0) vs just declaring it (int err), rather than 
> realizing the variable itself is redundant. Will send v4 shortly.

Please, wait a bit. I will send what I have, you will see better what can be done.
But again, do you have an HW to test?

-- 
With Best Regards,
Andy Shevchenko


