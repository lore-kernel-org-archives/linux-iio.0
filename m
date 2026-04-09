Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871E42DEA75;
	Thu,  9 Apr 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749833; cv=none; b=DmBTx0MOwU7yXvnjXRtwU84PHxhcO+r6xpN5bRDgdOD0PqlzZhy+lOJp+p9uYyHVrU7hG6WbCLxyN2vCiOjweIvGnqCI2gWH0ApHMaiZdVOblL7mmN6IqdnWe/Mpeg8GJlNqew72Ps8mA9cbJR39ABUTIf9ixXA9cRlfrKu/DX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749833; c=relaxed/simple;
	bh=cYecdj6LuOxiAC0CRJ3gYSfpqo1BczlxPlvH2ObkjlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qly6+cOgYT/Vx4vuT/FkYEugQCT/LyhsBoMlxrSYh4WMjAyyEktUD0VlmJDfdrc41xGx0nq11RkQd1KTecl9bioorSvOs4mJ/XzGhO470c3qdyMDIDnD+VQd7Hw0NRr7PLWOOB/bqTUxt0ry9abSw4PYPn7AU3ukQIN18LwI8oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+oLFilW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+oLFilW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775749831; x=1807285831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cYecdj6LuOxiAC0CRJ3gYSfpqo1BczlxPlvH2ObkjlA=;
  b=O+oLFilWrP2vp1RlKPwvhDfYyMZP/K9MZVkCScurijZ1AdxvHs/4+1/j
   4z8NUUGTtm0qimni8MUrlRDHyL7eeG6rqKdY+d0Bn2Kgj8/r2hbZw9QQ3
   LGS89HQl/UCvF+u+n/6dN81zgSfsJD7TCLdTKFU3I5B2RtpISVD9KoOrU
   VORgRxEg/+iC76nFLLVfp2u50CfI/q2oxL3qHjUQjo7m+/axS8/iLBAjp
   WMVylD8/UI/1euxZqExobZtYNYm9FlJEEDmrj+aKwxL5RMsyTEQF8sM9V
   LXwBoA4eZRnnqT4BjnvaggM/PJ6GpPAV/dn3lmg9Uuq3a6RTVtzmLvT1p
   g==;
X-CSE-ConnectionGUID: szMVlbSgShmMggMBg6M8lQ==
X-CSE-MsgGUID: K8CLJDf7RzW9xG8Gj+WMeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="80648475"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="80648475"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 08:50:30 -0700
X-CSE-ConnectionGUID: KbPk94PKTdq1UfHiayzI4A==
X-CSE-MsgGUID: ld++Qe9WRIigztbN41ZA4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="232847904"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 08:50:26 -0700
Date: Thu, 9 Apr 2026 18:50:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] iio: frequency: ad983x: replace do_div() with
 div64_ul().
Message-ID: <adfKwP1OF1sn7Gem@ashevche-desk.local>
References: <2026040913-spherical-slacks-bc5b@gregkh>
 <20260409150157.1300-1-joshua.crofts1@gmail.com>
 <b37516b6-da77-4496-8514-b14ed0ad76d1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b37516b6-da77-4496-8514-b14ed0ad76d1@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 09, 2026 at 10:39:07AM -0500, David Lechner wrote:
> On 4/9/26 10:01 AM, Joshua Crofts wrote:
> > Coccinelle reported the following in both ad983x drivers:
> > do_div() does a 64-by-32 division, please consider using
> > div64_ul instead.
> > 
> > Fix this by replacing do_div() with div64_ul(), which
> > safely handles 64-bit dividends and unsigned long
> > divisors across all architectures.
> > 
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> > v2:
> 
> Please don't send v2 or later revisions in reply to v1. It breaks
> some workflows. Start a new thread instead.

> >  - resent email with corrected addresses
> 
> Instead of a v2, you can just add a RESEND prefix to the subject line
> in cases like this. But do include an explanation like this when you
> do that.

Nevertheless my comments still applicable to v2. The also Documented
recommendation to avoid sending new versions earlier than 24h.

-- 
With Best Regards,
Andy Shevchenko


