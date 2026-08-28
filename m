Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255637BE96;
	Fri, 28 Aug 2026 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903238; cv=none; b=kdoH8pbqhkUmx/gaowBbnJgTfhyEqVn1YHlRaO+UhoQ17v7tkb1FP/Zj3J5zjVSOPXv3WU/WXepT/qQaOc4zQfit3qoB2slNdCZvouc7fQWn0Ual0KkLkvSQYaCZiEHmsds9n5k3BxReUnQPKhB5TWjWiSGoU3q93KfVGuXv1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903238; c=relaxed/simple;
	bh=ltotGOTs2BMOp85uieWLNxHajEwqVVaPPrqp4omhHnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAHR3ezbE6260D36ABMonaR5h8ai2PGUtn5HV4DhvURW8RWJRCPwPhKRc7HIwSUkitGJHlcLV+TUdf2SoO+bC0EUxmEkmbY3m2AB0fBwnOSZ2Ek+sZefyLEF7VB1dQ326FZWp8UcKxOlLh4XUMSHug5E7vl5z/+StH2JQuEDRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSaaUtA8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSaaUtA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787903237; x=1819439237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ltotGOTs2BMOp85uieWLNxHajEwqVVaPPrqp4omhHnE=;
  b=BSaaUtA8M0WyUJ767xCIWi2IEpSi4P/oJNE6AGdY9aT3e+O9E4Z8LgzD
   xlteRlVRz1fK1O0HLxJPP5K6Axgn0uDW/3bRlZOtXCVT6r77WYnConYpv
   1ZVCpSu9uv8JP8kGf+OvfoAKuednZfSBCw7R0VR2FdSZdCOEkNFEXMeD6
   XKkDwk4ZFH0ZL1k57Hjg2F00rFlG9cGwCx8lctZlMKn9+OiCNymXX2IVt
   iJjvfy987jQbDN4t7SYysKXusUPHKaYWo4uAZ6GA5hDL93cZFK6l5ieWM
   nCj3YiFX0JVtI2Pbvul1saGHG23jf69ZWpwUnYgML8OcnQ8nZuDK648++
   w==;
X-CSE-ConnectionGUID: lg2qlb4dTFSe1Y1nJQIqeg==
X-CSE-MsgGUID: ApJIKPq0R4qoddRwMH4ePA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88614747"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88614747"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:47:16 -0700
X-CSE-ConnectionGUID: okIO/AGwQGizEfaecB6fLg==
X-CSE-MsgGUID: /wbvwY1VQNWxEVQRXRJ2Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="263804291"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:47:14 -0700
Date: Fri, 28 Aug 2026 10:47:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Anshul Dalal <anshulusr@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: ltr390: Remove stale TODOs
Message-ID: <apE8_yrAGt__Nl9N@ashevche-desk.local>
References: <apE0dwvpW6Yl8yzz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apE0dwvpW6Yl8yzz@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 12:10:47AM -0700, Chang Yu wrote:
> Remove stale TODOs from ltr390.c. All features have already been
> implemented by Abhash Jha<abhashkumarjha123@gmail.com>'s patches:
> 
> Configurable gain and resoluion: commit 13fad2607dad ("iio: light:

Misspelled 'resolution'.

> ltr390: Add configurable gain and resolution") 

Here is trailing white space. Also you can do it in a way

 [1] Configurable gain and resolution
 [2] Suspend/resume support
 [3] Support for reading the ALS
 [4] Interrupt support

Link: https://git.kernel.org/torvalds/c/13fad2607dad [1]
Link: https://git.kernel.org/torvalds/c/288ce72fb5fc [2]
Link: https://git.kernel.org/torvalds/c/14e0d914a855 [3]
Link: https://git.kernel.org/torvalds/c/7ca4b8957066 [4]

> Suspend/resume support: commit 288ce72fb5fc ("iio: light: ltr390:
> Suspend and Resume support")
> 
> Support for reading the ALS: commit 14e0d914a855 ("iio: light: ltr390:
> Add ALS channel and support for gain and resolution")
> 
> Interrupt support: commit 7ca4b8957066 ("iio: light: ltr390: Interrupts
> and threshold event support")

-- 
With Best Regards,
Andy Shevchenko


