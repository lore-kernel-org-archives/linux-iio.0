Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63E22259F;
	Tue, 27 Jan 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511106; cv=none; b=DsgZr6tlX0mUd0NdLna9iZSoHZ/eNSmtcJysxD9xsKDhCG+VFIy9qYDfP6CzhNmkAbtUVnByOmDpHNIzXuV2+P5w6zV8JDO6Z0NXSQo2Rafa4EYMrN7KrbVYq5iWNReWKa6iSRZCzDKeg6xchf+qz95lcmOwCXJ6U6sTGt8Z3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511106; c=relaxed/simple;
	bh=ljqmwRc2tYNxotdkL9n9m9ypMnz2jmSmOYIg+mlkRg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjUqVZE8ds8rWO7A/XPTCYxHw89+5FTBjXR9s/UQ6leHyQp65O7M6u8Qvf0NKsA5X+TD2v0mVsEjIK47RfdKXZBihNs6gPt0mg0L5vUg7jEf1jfd3RVCQbH/wfOkaBLNpSms8yuyK7CtspfYu5iAs0spQPJMzfxCK1+qfyxnnjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlTpy36m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlTpy36m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769511104; x=1801047104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ljqmwRc2tYNxotdkL9n9m9ypMnz2jmSmOYIg+mlkRg8=;
  b=hlTpy36m1wQXe6KeEFmQBLfZR+fT0UyelBG126GCe+NqQBYpSYswIdTn
   YaqKFbTSZG2lwuAnHpUYMLnA64eIDHP76kMyhR32IXC7v/lqXcOkvPbqG
   sYlRfMV7YwhIdkXXS3XXzPPY9X/68YDUIB0CrqZPoH8YPgkq+TtCCoKz3
   TxBOLIyFcN0BzegihN5EZww2hIY27/tUEMGRkpxHUzTY8ea1EahTmAIZ2
   keyniqVFMExMBoJCBu4C4d8hs3xWp5wDsn1PeiRv8dyH91fMGegW3lS5H
   0z2TUepO4ZSl2sYrQtlfikTAGqqFuL1NGdNGlX/cf5RlsgR+Czu2wBuYx
   w==;
X-CSE-ConnectionGUID: 7wbCByiLQaqF0Pu8A8XV9g==
X-CSE-MsgGUID: 1SOeLfXdTOaEZ1FMLLqJ+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="96166989"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="96166989"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:51:41 -0800
X-CSE-ConnectionGUID: 2OpoyD9oRFCIuYl9/d0W1g==
X-CSE-MsgGUID: PyxEpHwDRuqtKLHeHX3EAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207739664"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:51:37 -0800
Date: Tue, 27 Jan 2026 12:51:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 6/8] iio: dac: ds4424: fix -128 rejection and refactor
 raw access
Message-ID: <aXiYty1gFMcmC4lT@smile.fi.intel.com>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-7-o.rempel@pengutronix.de>
 <aXiWkF04r7FkLPRx@smile.fi.intel.com>
 <aXiYIYd08vFfLoIQ@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXiYIYd08vFfLoIQ@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 11:49:05AM +0100, Oleksij Rempel wrote:
> On Tue, Jan 27, 2026 at 12:42:24PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 27, 2026 at 07:09:37AM +0100, Oleksij Rempel wrote:

...

> > > +		/*
> > > +		 * Currents exiting the IC (Source) are positive.
> > > +		 * Canonicalize 0 to sink; datasheet treats sign as don't-care.
> > > +		 */
> > > +		if (val > 0)
> > > +			abs_val |= DS4424_DAC_SOURCE;
> > 
> > Hmm... Maybe 0 should be excluded as invalid?
> 
> 0 is valid value for no current flow (power off). The direction bit
> DS4424_DAC_SOURCE  will just make no difference if value is 0.

Perhaps elaborate this in the comment above?

-- 
With Best Regards,
Andy Shevchenko


