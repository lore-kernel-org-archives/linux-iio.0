Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2736B07C;
	Tue, 24 Feb 2026 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927182; cv=none; b=b7gzQOnfnVK2VMqKaeI+dmChlYnP0HjB3kgJj1njDDHAcU+Uth4m9DZgMUtH+dnQUtf8C5+UVRDRSBzYxf2WKvopdWP6U0ZpvtzWpe/6Jmlo6sRfITT6IFY/2kDzm2274fiskrCf/GKyBQvxhNhX65wBqR3eW1x9uYYibcMMmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927182; c=relaxed/simple;
	bh=7EX+ilAyhtKr7jTMfyusxgczEbiCYUeWVHcCI7ArMRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFX/N30Vp/rLenUBrw7gR97z+SBmM38xjJfBs+s++mRnYdSlFp4+km8P/1hZuPgXc8sTtFYbPBf0INgLL/4SeLx64zCoZHgBZbHFSv6BDakXmbhdDdCe74h8uYWPfxBpfpiwiohYReKee6BF2QE/MGnYYKmXMfjyo0M0JOjEaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lg0HRHCD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lg0HRHCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771927181; x=1803463181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7EX+ilAyhtKr7jTMfyusxgczEbiCYUeWVHcCI7ArMRY=;
  b=lg0HRHCDGlXzP0VHHPStQ98PQsuOuE1FlHREIX62Ho7zz2lVPtkP0J67
   DvC72iEqLz2mrDqe1MhcJpfIkN0AwZzYKEf05c1ckUZUGMSnpUR39dMmg
   yoyjRdoXth7t9kOq5Wn6kAVlHz6eDOz/NZLiDbWz6Iaz1f+Yt7VRoUR/O
   lE6S6llwzJesHyqxrdmQMFw54mlkRfJiZQNy9uQwOQsZiA4ZhcFpx8Jfk
   Dh58RgFGoSkrLD+IxsACnBRijsaZFgnShWy6bA95UZY2uajj5R6tA/DkY
   SWRpmt/Bs171CBqURSocJt9hDXh8u2IrH/6wNA24AIWc4FQYNn13tQ9dK
   Q==;
X-CSE-ConnectionGUID: tRDQt2SVSXutO46NoXmLOw==
X-CSE-MsgGUID: labjY3OOR1KqUxM1xA3ZnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="76547633"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="76547633"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:59:41 -0800
X-CSE-ConnectionGUID: whawzx0dT8OK7jTbd2RJlg==
X-CSE-MsgGUID: 7UDfAdJdRv+3kiT53ZsOjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253585571"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:59:39 -0800
Date: Tue, 24 Feb 2026 11:59:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: frequency: ad9523: fix implicit variable
 usage in macros
Message-ID: <aZ12iATxw_V7ZmYf@smile.fi.intel.com>
References: <20260223215636.18606-1-rougueprince47@gmail.com>
 <20260223215636.18606-2-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223215636.18606-2-rougueprince47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 03:26:34AM +0530, Bhargav Joshi wrote:
> macros AD9523_CLK_DIST_DIV_PHASE_REV(x) and
> AD9523_CLK_DIST_DIV_REV(x) implicitly relied on variable
> named 'ret' instead of using passed argument '(x)'.
> 
> Update the macros to explicitly
> use the argument '(x)' for their operations.
> 
> This also resolves the following checkpatch.pl warning:
> WARNING: Argument '(x)' is not used in function-like macro

Same problem as in v3 stays. Really, go to v3 review and address all comments,
or explain why not.

-- 
With Best Regards,
Andy Shevchenko


