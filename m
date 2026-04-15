Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8833DED1;
	Wed, 15 Apr 2026 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247740; cv=none; b=Oo4CQlGSnpNdpeu4C+3USLm4KoFbeaeqry8IW1/UYJ7L3sd2gyFCnEtq30E+zblcfQ76VTN8F2ibLjp4hNwOgnzD27frErZ2aq02LCCvaZNHMtGMTeDxZSRa7zlxsV4FolXcmrHo2Eckw63YUFK3pQqoYeBeRt6net+4Zv4dFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247740; c=relaxed/simple;
	bh=u8eDtMq1tpj6NkUIau/oOyIa8NYnSPNKJgbgSs0RYQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSwDxRy6Ha0wOR3TemKEnD+kHS3UvOh4hyI+vKml8009fyUDyr+5m/eP6HgdXr4QakMFVV46x29WZfSpKm4x35HByNHKuyiPfLgAwLRxTfG4S9TWjyE1yopnwZ7B4CGKOKF1vEtz/AoPKPK9crmiAwOZkEcdCrqmvoNrdIGIkhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y10B3Wey; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y10B3Wey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776247738; x=1807783738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u8eDtMq1tpj6NkUIau/oOyIa8NYnSPNKJgbgSs0RYQ0=;
  b=Y10B3WeyKWI2txQbsgCmTr2siCrAizr/xTBoqb4bRJILJ+/edcHDwGSb
   lyJwzbh5wpsgAKqpQDKjVnMXaReRzsDGftR/Rt9VaXUtYY2+3jzS/qh5N
   02KIDD/xiYAPFaBXw4ymvGJHJxCwyGP6Cgq7o2OnXJYPuCgPGX48adxwE
   CChSDszbvYzmhEgYarsuf3uW95gXYiUEt5BnMh24CkvVFueM8wWHj/1fE
   W6+Fh9DM9jOgMTVcPr/lEVRJcvCN4d2kIZuEB+XJifkFstvIhBQ8sGFcC
   res2BkEmEPwqeh5vTfUEc+a2vInRm9L4Cj1n4XtC4nGjlsTMkQRX5JxN6
   Q==;
X-CSE-ConnectionGUID: d1dSEuoMSRezOCJMYP32+Q==
X-CSE-MsgGUID: 2Pl3rQcmRdK/JktD+mLi/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88600525"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88600525"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:08:57 -0700
X-CSE-ConnectionGUID: 5fisCkPrTdOv6ev0b/zF9w==
X-CSE-MsgGUID: T+r8UZYgTs6VA3oO3oimfw==
X-ExtLoop1: 1
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:08:54 -0700
Date: Wed, 15 Apr 2026 13:08:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: frequency: ad9832: remove kernel.h proxy
 header.
Message-ID: <ad9jtH1YgA6N6FYg@ashevche-desk.local>
References: <20260415080812.1284-1-joshua.crofts1@gmail.com>
 <20260415080812.1284-2-joshua.crofts1@gmail.com>
 <ad9SzwJDwRNldv_z@ashevche-desk.local>
 <CALoEA-xy6WApV+ZUavnEipTKiAezYkXMwiE++TjtHuxkVdR1mw@mail.gmail.com>
 <ad9jThxf6PINFFmo@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad9jThxf6PINFFmo@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 01:07:16PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 15, 2026 at 11:53:44AM +0200, Joshua Crofts wrote:
> > On Wed, 15 Apr 2026 at 10:56, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > > Checked with IWYU.
> > >
> > > We have a (recently new) tag: Assisted-by or so. Can we use it here?
> 
> > BTW, I thought that the Assisted-by tag only applied to AI coding assistants,
> > per the documentation.
> 
> Mainly for that, but it's not limited to. Coccinelle is not an AI tool, yet
> you may found it in the tag. Ex.: 8aa9fd0350b8 ("parisc: update outdated
> comments for renamed ccio_alloc_consistent()").

Ah, all of them have the first one an AI... Perhaps you are right.

-- 
With Best Regards,
Andy Shevchenko


