Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FACB481AA2;
	Tue, 12 May 2026 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572851; cv=none; b=I/n/4tz1OLU8jNkyV1sjgpMQxBrJ4kBNk7Cv62LrCZbo9LnqDg2H12uTTGUJDDYfRqTUQTmPj35nd7ltkOnqZMbnsXyApEGNYgr3pLZSowEv3J02P4xStA0PA8d48HSoBML/ABLCYZNlnq5/aXvtGCOJ6u1BcxBqZBYOyJkx8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572851; c=relaxed/simple;
	bh=t65LqyR1I5DNHIgXinDnJqubf54SXY6VgVDe18ogD/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF5G4TOhP6rxGiLNpk2BG4u49yvq2JE7qgVUuBUxIYlBObtugDWTHL3hSAitfIpDY8RNFiizbs9T/sGpqBQTN/ohNS9dQBYbQ5FIrNyLHcbvN0+dxbUll69sEwFjCPi6VfBJ9xbEGzOPkQRbJ0OsGR5ps/sVxNoDQwQUqgXYnpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LauUdSpH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LauUdSpH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778572849; x=1810108849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t65LqyR1I5DNHIgXinDnJqubf54SXY6VgVDe18ogD/4=;
  b=LauUdSpHp4qM8nBYG1gYVIxSuMZVF/dPUPwar6rrAaW5vNNudftNQ/c+
   rUL4eXfVYozaVVWDTO2KxZPvGEPXjBw5YUMHFiqGaGoK3cfqBeT2ualTP
   HrdG3Fso+nC4LSpITUzZczNm+pYag1z22DfIkWQjxyAhhaL6ItGK7RWEY
   OovF4YVgstv6jyN+nHscALXYAxTS+zyx7yrlMilQ6rYsHSCQ6BjB0kSef
   J94NN3B0ajtVgeLaI3tOYPNnH92qTCdcnjveM9hrAjMIVKo7KaoHZAiRM
   eBNP8w4TvKaYwWJQMCZCKCE48QsRZAuPbytDGphy+iU5gVSeqh810DHcN
   w==;
X-CSE-ConnectionGUID: c7IZ6kA+SueW3xgHxPbhRw==
X-CSE-MsgGUID: 8m8nvsljQ9iEHL/2bLq2HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90173245"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90173245"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:00:48 -0700
X-CSE-ConnectionGUID: X93n770DQBqPk/KCrbXu7A==
X-CSE-MsgGUID: eP+XI8/QS6+zxdCzmQ+WlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231302275"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:00:47 -0700
Date: Tue, 12 May 2026 11:00:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mapping file for include-what-you-use tool
Message-ID: <agLeLDtXxfFHSjJj@ashevche-desk.local>
References: <20260512073505.1310-1-joshua.crofts1@gmail.com>
 <CALoEA-x8XVqx+S9Kue7VsocO1Ca1wQS10nt=COF-pGOQ_qa_jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-x8XVqx+S9Kue7VsocO1Ca1wQS10nt=COF-pGOQ_qa_jQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 09:36:57AM +0200, Joshua Crofts wrote:
> On Tue, 12 May 2026 at 09:35, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >
> > As promised, I'm sending my IWYU mapping file, based on Jonathan's
> > version with a few additional tweaks by me.
> >
> > Other than adding support for more assembly file business, I've also
> > experimented with individual symbol definition (see BIT() and GENMASK()
> > in the following file) - this is to prevent issues such as the tool
> > wanting you to include <linux/bits.h> when you already have
> > <linux/bitops.h> in the source file (I agree, doing this symbol by
> > symbol is tedious, but BIT() and GENMASK() are symbols that especially
> > do this, and they're included in most, if not all drivers).
> >
> > Feel free to improve this file and pass it on. I wouldn't really fully
> > rely on IWYU as even with the mapping file the results can be weird,
> > but it definitely serves as a good starting point when doing driver
> > cleanup.
> >
> > I'm making this patch an RFC - this is not intended for merging.
> 
> Annnd I forgot to add the RFC tag... Either way, the above still stands.

Thanks for sharing anyways!

-- 
With Best Regards,
Andy Shevchenko


