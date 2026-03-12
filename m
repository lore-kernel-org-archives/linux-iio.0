Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1336D9F8
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308279; cv=none; b=ZaKXqGJa9aP3TPKSXQ8kZmfuk1dYdtq/vQrgKK4nuzMGeaCAV9yKajZ9mBk/dawVW7D3kSu2yJQH90VZlWZq0are01pytz7VKM+6AyXtvzFywK5BizAR8syDA9JpbsBQiaQWG1Dd7Q9VMNLB4HPON2fRuK5HxsTGYDk+34F10wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308279; c=relaxed/simple;
	bh=/7ahq/tu4V1x0yVYbESvuMPSf4JEGPaklCjtZk2Uo4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgsVVoHuEg+pkTjd2TmfHC+IUfDj1HNUfERnMY8zNi8ix0hx0HOJaz9HUBZDOXdwMrJkGzq+ydAI25RVaGg6Lqbd/p+u3sJLi4+BbDoHWLM2ol6EqZxrghhslGZy6cSInUZRgIX/5w1EVFcL90riJeT/J2e0ywQ42yD9pERGMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BN9VcYyk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BN9VcYyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773308273; x=1804844273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/7ahq/tu4V1x0yVYbESvuMPSf4JEGPaklCjtZk2Uo4k=;
  b=BN9VcYykp7iZdbLMw4s5qeC/AzGO1ETSuwIq00qHhjz7xcAwQghVKz6h
   kH2F+++eTq3lsZp5jZf4OHBo5xY48ZhxVHi9vlrMAzeIgYtgNtb4otUnX
   EsBK4MtN7x8RuWiaot4sLYGBQeTnrI2Cq4h1EQyUT1MX1caqlhiyeII82
   aw4Gd666aO2cFINK6xgmny7V/d/lG2gMStOtCuQUeFyfZhJRmg9SkHAVr
   zliMmQ/3N8LdtLJoaNoySVIgE57xGwQlX1GKgLL6pgrlptvKOdDWpMyz1
   gZiKhYkC58B9sBdV3IKXIxLV46ZDPW2gDIKALerhEaUo8EY2t7q+MtgZM
   g==;
X-CSE-ConnectionGUID: G7fOfYCTTTSNra9/o7IlYA==
X-CSE-MsgGUID: 73bXweg8Q56YLgHIt2VoMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="73584991"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="73584991"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:37:52 -0700
X-CSE-ConnectionGUID: 4RusnLJqSmiKrkesZ62Mig==
X-CSE-MsgGUID: OWLVQjBXTRWn8W7HaHPoqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="258668884"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:37:50 -0700
Date: Thu, 12 Mar 2026 11:37:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: twl6030-gpadc: Format block comments
Message-ID: <abKJa0JtgkSF55gF@ashevche-desk.local>
References: <20260312080752.48091-5-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312080752.48091-5-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 12:07:53PM +0400, Giorgi Tchankvetadze wrote:
> Move the trailing "*/" of multi-line block comments to a separate
> line to comply with the kernel comment style.
> 
> This resolves checkpatch warnings:
> 
>   WARNING: Block comments use a trailing */ on a separate line
> 
> No functional change.

...

> -	[3] = { /* ch 3, external, temperature with external diode/general
> -								purpose */
> +	[3] = { /* ch 3, external, temperature with external diode/general purpose */

I don't see the rest, but here it's definitely better to move the comment to be
before of the data entry:

	/* ch 3, external, temperature with external diode/general purpose */
	[3] = {

With that being said, it might require to rearrange the whole set of the
comments in this initialiser array.

-- 
With Best Regards,
Andy Shevchenko


