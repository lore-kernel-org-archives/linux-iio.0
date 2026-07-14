Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE2346A04;
	Tue, 14 Jul 2026 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033080; cv=none; b=Z2pG3i2Qi5ol03Duc+xjwJN8wjvaMHfg4pLtcNussVGRVD12CajfNCmVUmEEmSPGWHKpSiUbI+ydZ0d+uIqqf6LT9kT94SyrKcHQWAaTLKQf9plwhgIWze1oXi6hn1XeZtptRwdDvoR8twEcmhMrjcazDw0NUNNPa2S2QUZ4EJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033080; c=relaxed/simple;
	bh=DBCpIgkm+uC1TEfWY8cnMXNqdiQfZbdHYG5U5BXLvQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gib/SeZH/pRYifZNdfMkLmG/0WU+x9GULd6FsfSKtofeE4ktgKvS85geoklvsO4wYvQ4FqngMNAjfDufVC77GGruX0GfDWd0djUVRfYuKPq5HdQSUg8E01paJzein0slunLVTvXY+lnz1zbe9N7GsTLLMuAWOZaFFU1Sy9RbXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxL91Pt8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxL91Pt8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784033078; x=1815569078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DBCpIgkm+uC1TEfWY8cnMXNqdiQfZbdHYG5U5BXLvQs=;
  b=HxL91Pt8hKAVNkPwcK8zSKQFn2MFfD2NTizwyAUcGmPDVjfKTVmGJcfA
   1Jj8Q47RPishxpTmYOg7h+EETtKQfwuzAp2dTFcnj4awTl5n4B98hAdLr
   6pVcIdfJghzIWaR0uxZBOqD7X/zVObD8LBPJsw5Q0mXPTw3pKGlChMPiy
   eUsakdwvRSeBFXStyqP8XOVCRja4hPVZg3djMnA/UCr2N0/jNUgPnaQKC
   w3mR+ZGI/FRWQBGoQWTuRVUXmmeqnp0Bqo2YRAXlb3fTimb7OKvZEk66l
   n15XLNlcvqFzVvR/oi6sY/JfAeSoJ4n8LsMBCM1dUnmkQqjCBQ4voLSR8
   A==;
X-CSE-ConnectionGUID: PlmK/6HqQK20YldnPtXfew==
X-CSE-MsgGUID: FH+xztjgQcSPA5FC8Gkwjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="83774388"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="83774388"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 05:44:38 -0700
X-CSE-ConnectionGUID: hibczF8HTwau1OL0VfGXWQ==
X-CSE-MsgGUID: 6t9EGivBRKWw86T8JgpBXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254099840"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 05:44:36 -0700
Date: Tue, 14 Jul 2026 15:44:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: light: opt4001: Fixes from code review
Message-ID: <alYvMZgCu5uLXodL@ashevche-desk.local>
References: <20260714113134.3445-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714113134.3445-1-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 05:01:30PM +0530, Nikhil Gautam wrote:
> Hi,
> 
> This series fixes a number of issues found while reviewing the opt4001
> driver. All of them date back to the initial submission of the driver
> in commit 9a9608418292 ("iio: light: Add support for TI OPT4001 light
> sensor").
> 
> Patch 1 fixes the power down path, which read the device ID register
> instead of the control register in a read-modify-write, corrupting the
> CTRL configuration on the way to power down.
> 
> Patch 2 fixes an incompatible pointer type passed as the remainder
> argument to div_u64_rem(). No functional impact.
> 
> Patch 3 makes opt4001_write_raw() reject integration time writes with
> a non-zero integer (seconds) part, which were previously accepted
> silently based on the microseconds part alone.
> 
> Patch 4 fixes reversed GENMASK() arguments in the (currently unused)
> fault count mask definition and adds the _MASK suffix for consistency.

LGTM now, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


