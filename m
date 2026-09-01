Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E9459AE7;
	Tue,  1 Sep 2026 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247583; cv=none; b=cmhE1pkLVAkBvBPd8R/QMc6zfzCQLF8nGhmiuPGIZbM7cx3scSuowizauYaGYBlCkpy9sZFFeTqeb6tdMjgcTfFnPcdoqhS05z2Rvx8exZFv/LFjz4l7ewCdJ7CWgcVnwcc5J5IvrI49vuzZfDWiJ3j3Pf8lN8WFttbqYXfxWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247583; c=relaxed/simple;
	bh=EwIsSFY3q/WAiY9nK30tfN5vrStahLiod1NHBcco1wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfanqViGdpQOm5HPPHsBbgB+vs3lnP1fjOeVS07XWfgAmWI0JT8u4mdLFXK2dKPwHfQA/+jaeFXrQ63ySATBM/ZJKBqtFVLSlq5OkRWY81wmv0L3mknoBVsnFEpAm5skfkHva7pCXCpGwmHAcmtZ+6CCfmn/j4uc9PbRWzGerI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIQMf1gu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIQMf1gu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788247581; x=1819783581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EwIsSFY3q/WAiY9nK30tfN5vrStahLiod1NHBcco1wU=;
  b=cIQMf1guX/R+R6BebmQWPEGPoM69TpwbsxEExujVqVXbCkkMxAbb0Q/i
   Uj79WNhhkfhek101MGMVDwkqCG2DBuM/pD4blHuENfQ8FMjaliXRjim+G
   kkMLV3ALX1p4QPUWhGhly6CAjPubsUdVSjgVSNMD0/PKdMyNfKDU0S15H
   g3/S98O/PSHbz8em47OZA3ZrTblGNjG0UX943RzOXZGutzjHlkGM7xY/Z
   ctN+00Fbt/Sjyi2LwIPD0ilvfhSR4u01DczEnCck4dJhxHgr6m339gw3O
   YM2qwrBoJv4X62RebdsP2d5VIv88Zpe2nV/nW/jQOZJxPGrjGtvF+kb9k
   g==;
X-CSE-ConnectionGUID: bg6KMZtwQN+JhH4AxRQQ3g==
X-CSE-MsgGUID: xSIb/gykSlSjsy8N4KXWmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="106188389"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="106188389"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:26:20 -0700
X-CSE-ConnectionGUID: fYzqBpndSQq4tz87HZ48oQ==
X-CSE-MsgGUID: bWglQduETW2tJqOoa9pqeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="269597994"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:26:18 -0700
Date: Tue, 1 Sep 2026 10:26:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gustavo Silva <gustavograzs@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/3] minmax: Add in_range_inclusive() for inclusive
 range checks
Message-ID: <apZ-FxfpHTso57XR@ashevche-desk.local>
References: <20260831-minmax-in-range-incl-v3-0-30444a2fd2a5@gurudas.dev>
 <20260831-minmax-in-range-incl-v3-1-30444a2fd2a5@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-minmax-in-range-incl-v3-1-30444a2fd2a5@gurudas.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 09:26:28AM -0700, Guru Das Srinagesh wrote:
> Extend the logic in in_range() to support checking for an inclusive
> range [min, max].
> 
> The condition in the check is derived as follows, starting from the
> in_range() macro with len = (max - min + 1):
> 
>     (val - min) <  (max - min + 1) // overflows for [0, U32/U64_MAX]
>     (val - min) <= (max - min)     // no overflow
> 
> The behaviour of the macro from the signedness perspective is documented
> in the kernel-doc and in the in_range_inclusive KUnit test suite.

...

> +/**
> + * in_range_inclusive - Determine if a value lies within an inclusive range.
> + * @val: Value to test.

> + * @min: First value in range.
> + * @max: Last value in range.

We have macros named min() and max(), since this is a macro as well it might
give an interesting outcome when two collide. Suggestion is to rename the
parameters to avoid potential collisions.

> + * This checks if a value lies within the closed range of [@min, @max]. Note that
> + * "range" refers to values counting up from @min with wraparound at
> + * unsigned-datatype max if encountered, continuing on till @max is reached.
> + *
> + * This macro is not a drop-in replacement for "if (val >= min && val <= max)".
> + * Unsigned arithmetic determines what the 'true' range exactly is depending on
> + * whether @min <= @max holds, and in which reading (signed vs unsigned) as follows::
> + *
> + *     Valid in reading   Example    'True' range is
> + *     Both readings      [5, 10]     interval as written in either reading
> + *     Signed only        [-10, 5]    signed interval
> + *     Unsigned only      [5, -10]    unsigned interval
> + *     Neither reading    [-5, -10]   neither; all values except [unsigned(-9), unsigned(-6)]
> + *
> + * The last two cases provide "surprising" results and are to be used carefully, if
> + * at all. Further, if @max = @min - 1, every @val is in range.
> + *
> + * Return: true or false as described above.
> + */

Imagine something like in_range_inclusive(value, min(A, B), max(C, D)) case
which I consider plausible to happen (in some form).

-- 
With Best Regards,
Andy Shevchenko


