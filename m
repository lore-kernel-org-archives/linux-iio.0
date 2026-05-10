Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89501175A95;
	Sun, 10 May 2026 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404140; cv=none; b=KRWIxryS3VuBWbqPyBbAt2lcULH67FPQELqsMkOqNse2e71v0JNxTWkl0fcaNt4Vk1AcfvFs4VLwkN2gY9mkgt2GaUd+XPLnURQ3bZ0uzrQiH5HyVFCr2PSMagf63UXDnE4AY99QBFmrvd0E+Tu/5IFmNXSMn1ShSEq4Z3o0cIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404140; c=relaxed/simple;
	bh=84mN0T6jMm1Ojk+D8BKVfuPCYLvU+FVdMNVSf/Uk1UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ41VqrV6yl3f7a2RPmxHZY6nuUNglO8om+IyhO88G8fXopMahSYlIYFpxAeA7CbV5qqbYY2ku/0am2T/ObBVoDE6Ss3SH9Shy8tztilyMr4Kxb3Vdj50SUDtQQdkLfRjnhnYMqXwAcOgr7y31+B0ncLCmTK7MxaeyTJQpGyiCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcuBsF9m; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcuBsF9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778404139; x=1809940139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=84mN0T6jMm1Ojk+D8BKVfuPCYLvU+FVdMNVSf/Uk1UY=;
  b=AcuBsF9maV7VaXIbtvzlE7iZn0oDBReYDsrY4KlfISVCCu+8TXfx2JOl
   Na0dAjeEgAYkO5nk2YSUxVZ8c5dtaOwxhTwWPkEtIV/xVWvyKsXQ7OUCc
   +l5+L9/q528gZSpdgnbbmfF0Ovx+9x3Canb/z3un/pnnzLbwed2RG7MuF
   iaTb9T93LESxfqgbPDELVVCav0tUpdNWy/7ttBLBbyo5ssuRelSc312Gc
   GdMU8kSb/BXz+nTeCd87ypKvXmjiiLMhfdX+bsPhaKvd6u5AMvS6SymFx
   ELLNB7UZ3W096bjDzepGvpSbUm4+EVm/RVKLWaWFZUxibJ9r7z3//ZcMg
   Q==;
X-CSE-ConnectionGUID: lVShRdUxRX6SWTv1Odoxhg==
X-CSE-MsgGUID: JdUUure4R8GEWDOUgVDSnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79172719"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79172719"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 02:08:58 -0700
X-CSE-ConnectionGUID: LMfqQdRQSV+TBvmSqa9ACw==
X-CSE-MsgGUID: d0Y0TQqkSvuci1KutTMw2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237407057"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 02:08:56 -0700
Date: Sun, 10 May 2026 12:08:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, andy@kernel.org,
	giorgitchankvetadze1997@gmail.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: chemical: scd30: make command lookup table const
Message-ID: <agBLJQBOTm2EEVCJ@ashevche-desk.local>
References: <20260510003136.35026-1-sozdayvek@gmail.com>
 <20260510004244.37342-1-sozdayvek@gmail.com>
 <CAKqfh0GWMu5WGfSigJOAredavrezZgmPVN9+qmMZ2aMoVX_jYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0GWMu5WGfSigJOAredavrezZgmPVN9+qmMZ2aMoVX_jYw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 03:04:28AM -0500, Maxwell Doose wrote:
> On Sun, May 10, 2026 at 2:59 AM Stepan Ionichev <sozdayvek@gmail.com> wrote:
> > On Sun, 10 May 2026, Maxwell Doose wrote:
> > > I'm curious, are you having AI do your reviews?
> >
> > English is not my native language, so I use AI to help with phrasing
> > and to learn kernel review style. The technical analysis I do myself
> > -- for this patch I checked via grep that scd30_i2c_cmd_lookup_tbl[]
> > is only read (one read site in scd30_i2c_command() via
> > put_unaligned_be16, no writes), which is what supports the const
> > change being correct.
> 
> Thanks for confirming, just wanted to check since some of the phrasing
> in your review did seem very AI-like.
> 
> > Happy to follow whatever disclosure norm the iio community prefers.
> 
> Typically reviews end up being one-liners (e.g., Reviewed-by: name
> <email>) and that ends up being the whole message, sometimes reviewers
> and maintainers will have inline comments. Obviously you don't have to
> follow those norms but that's just what usually ends up happening.

The good review includes reasoning, and Stepan's is a good one, just needed
clarification, because I haven't got if it's a proposal to have a commit
message changed or summary of the review.

> > Stepan

-- 
With Best Regards,
Andy Shevchenko


