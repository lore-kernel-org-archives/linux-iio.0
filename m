Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADDD3FCB14;
	Thu, 30 Apr 2026 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777549676; cv=none; b=Y1Kmiwpej/+3yVagJ7WzBskx58lu1/63Hw9sIpHrZc35DxVJClswcyZGkwP9K22aqrejbHaBDCwLpyV9ZVEZEphSJkJFKyeGSVuaIyLX2EOY6+8JStUKIldZ4Sk5ilG93gT6GdBHsB8C2y3Cp+nO6FMDUBR+xZ2Fewm+B1YlKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777549676; c=relaxed/simple;
	bh=GMirh7+8LPJL+fmMJcmBROeIbnBWk28VA9ZXhgfBIxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4vI6Ft39XyrROMsm7VuIor44ZE2yf4/gFf5tWU0ot5wsOGoGhDJerYlBEBaqPTl6I/SRm6mhbXxf7lUx5QYLdDudrd/Pay9KlYCLvUCrmqfblCeQ0sA+7hkJwBM9cauDVBz3/bfC1STa/owOODGJ8eq2rArE3oBeyMK+mu3OcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtJcHdaH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtJcHdaH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777549674; x=1809085674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GMirh7+8LPJL+fmMJcmBROeIbnBWk28VA9ZXhgfBIxw=;
  b=KtJcHdaHg3cPJJG2w3k8K+WWU6QjeVo/fsiRBAky3neiv9ikjqdaILmn
   HLuFgn0VudqQe5TzTFvKB1Br/57317dIaN9k8YcGOUo0wvQ/0KpBponbP
   fkRIUJ/pByLmzf+uzRMDDR8MlIsY1/xCeTzwVWV1EEZwbxkXZEXaWyuHm
   x3yjxR8ffi63n3lZlWlrvQzMzod2v7YSgz+PzzBmph8rLTWZER4NyJWMv
   rkObvD1wqKuo5UVtHUDi8gkaIHsyzB0/EbnbGk95Uvrx0P7rlCrAld/Mn
   uSZCArN6PgRAUXJWkj7k8TbtDmZAjrIe/pOA7SqOm22I9ufRPjAWi+QNt
   g==;
X-CSE-ConnectionGUID: 0MKZG1kjSXSNiXc6fQfWeg==
X-CSE-MsgGUID: y7lKWHtcSJaAyDq0Obmt9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78419041"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78419041"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 04:47:52 -0700
X-CSE-ConnectionGUID: 9QFzmfoMSNmd3kC5dKh+jA==
X-CSE-MsgGUID: 4+P1tc6CSyuOCG01IBWmWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="236341886"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.42])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 04:47:50 -0700
Date: Thu, 30 Apr 2026 14:47:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 06/13] iio: dac: ad5686: refactor include headers
Message-ID: <afNBY6dQ5Nw-EZcH@ashevche-desk.local>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-6-bb8f1cbd68e1@analog.com>
 <afIRG2S94JEn3Oqd@ashevche-desk.local>
 <CALoEA-yBU_pwiOFQx89-Gcgmtz_KtuxJJvph7uKPHKJNihDS8Q@mail.gmail.com>
 <afJLlpsU17Pmp0uH@ashevche-desk.local>
 <CALoEA-wvYvZr7ixC4UOh98mZAas1vbOe5CXT89DOy3e7xTmJ_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wvYvZr7ixC4UOh98mZAas1vbOe5CXT89DOy3e7xTmJ_g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 30, 2026 at 11:18:42AM +0200, Joshua Crofts wrote:
> On Wed, 29 Apr 2026 at 20:19, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Apr 29, 2026 at 04:38:02PM +0200, Joshua Crofts wrote:
> > > On Wed, 29 Apr 2026 at 16:14, Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > I haven't checked this deeply, but I hope at some point we will have
> > > > more or less usable state of `iwyu` tool that may do this automatically.
> > > > At least current result looks better than the original.
> > > >
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > >
> > > I did find a "filter" file of sorts for IWYU that Jonathan had on the
> > > mailing list.
> > > It does a good job of omitting reports of very low level headers but at the
> > > same time IWYU still tells you to include things like <linux/stddef.h> and
> > > remove anything <asm/*>  from your includes. Perhaps it needs more
> > > tweaking?
> >
> > You need to check that manually and then decide if we need more amendments
> > either in the patch or in the `iwyu` "filter" file or in both. In case of
> > filter file changes, please share them to Jonathan and mailing list, so other
> > people can adjust their work in case they use the tool.
> 
> I have made some changes, so I'll send an update where people can get the file.
> Also I've noticed that there is a /tools/iio/ directory in the repo,
> perhaps we could
> add it there so people don't have to search lore?

Perhaps, but it should be approved by Jonathan. Sounds good to me,
nevertheless.

-- 
With Best Regards,
Andy Shevchenko


