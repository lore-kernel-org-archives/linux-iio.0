Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88049359A6D;
	Tue, 11 Aug 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438595; cv=none; b=QmQx7wagUq3Yn1g9KS6DtAIyFqQjyWSSPNRkAiD3KHziFkOA7lRsZfuR75Fe1SM5qKnA3ozDdEVckvZ71dczKQfAryEX/iL+EVtcNRGWD1oBxkyGcNCeSkLOswoKHalG2T4hBKvqXHeIvpymwyUZCqTXaUqO7FGLqgLo7ZA8PH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438595; c=relaxed/simple;
	bh=AGCnhd6wwGrY3gJTzy3L3KTH3NeEAYKeah6BXyr8eUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwJZJHJdR6Qx2KJWHkgK/hhk0Zny1yZpEyQEFFYt18nCDmtQ267FKUnRlbExfyn7+MVxxIB+3whKQrhwTiifmknqLHkWrUTd/suhyehY1yhyd2HsSaj+Gjn1BE447ErCLVEGZOYrjpYPd/fALri7rkyK6gGVG0oI2ssyKyoC13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kst6LZEJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kst6LZEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786438593; x=1817974593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AGCnhd6wwGrY3gJTzy3L3KTH3NeEAYKeah6BXyr8eUs=;
  b=Kst6LZEJolEeikjK5iOvh/1/KGDPjmyw/CWLSaJf0GNkqXKiTAvWPsDf
   n9BX5ChFLVLPG2UBxO9L20/9P8evFBqNJjtdjEU3eya0cbvfS4v8hde8a
   X9iUrFLYxmnkifshbp/w9j7FBDHBjfTknWcx33WMqQO3qanv+xLVCr1vS
   qmppOq+HgFFFRy/0KJz2RcxRg+tWVoYby841aoGCC37/Oc6o/BNRJt/7c
   Iip/w7EXCdfHGS1n9KlMs268eQ4Lm33iX8Uw9PzF+D5jC22tmnXUqA2xk
   j4x4RN5XJ6SFRWeuzMKAdX5xyB6sFhsMrR0+p7ip3uBw1tGk2sdUGxp8M
   g==;
X-CSE-ConnectionGUID: 8Q5HRv5CSCe5fe9EHQRT0A==
X-CSE-MsgGUID: szTmftoxSJ24Sl8YZDdxDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="87179084"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="87179084"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 01:56:33 -0700
X-CSE-ConnectionGUID: uxtxh5lhQsyG7VizU+ouEQ==
X-CSE-MsgGUID: TiKC8fcwQtuMiwAxUmpO/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="287995772"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 01:56:30 -0700
Date: Tue, 11 Aug 2026 11:56:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, julianbraha@gmail.com
Subject: Re: [PATCH v9 5/6] iio: adc: ltc2378: Add support for LTC2338-18
Message-ID: <anrju2FHVOfS-e6z@ashevche-desk.local>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
 <39f2ff86cf736ff97286d6451fcc45fdba6732f9.1785186980.git.marcelo.schmitt@analog.com>
 <anl_v428aTL6waBK@ashevche-desk.local>
 <anqM43NvcVhhkkWI@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anqM43NvcVhhkkWI@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 11:45:55PM -0300, Marcelo Schmitt wrote:

...

> > > +	/*
> > > +	 * The internal reference buffer amplifies both the internal reference
> > > +	 * and REFIN by a factor of 2.
> > > +	 */
> > > +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> > > +	if (ret == -ENODEV) { /* refin is optional */
> > > +		st->ref_uV = st->info->internal_ref_uV * 2;
> > > +		return 0;
> > > +	}
> > > +
> > > +	if (ret < 0)
> > > +		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> > > +
> > > +	st->ref_uV = ret * 2;
> > > +
> > > +	return 0;
> > 
> > I'm not sure about others' preferences, but I would do it as if-else-if and
> > remove dup return 0.
> > 
> > 	if (ret == -ENODEV) /* refin is optional */
> > 		st->ref_uV = st->info->internal_ref_uV * 2;
> > 	else if (ret < 0)
> > 		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> > 	else
> > 		st->ref_uV = ret * 2;
> > 
> > 	return 0;
> > 
> > It also makes code shorter (in amount of LoC).
> 
> This has already been applied to IIO testing. I do send another version of this
> specific patch if that's okay.

Jonathan can replace it there, as rebase is inevitable anyway. Let's ask his
opinion: Jonathan, do you want a followup that can be folded or a new version
of this patch?

-- 
With Best Regards,
Andy Shevchenko


