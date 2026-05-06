Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C13EFD19;
	Wed,  6 May 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082210; cv=none; b=H1Ep9WPGHVmNZiTlHUPfl+88DENHdcAPUe5dg4QUoy1HHfK4XIhVmt337a0wGloGDCUqipaSnWVn/qrwsS+5jjBq9UdKNChVfU200nnZnDpv2qBVKOdUMma5980bj2n2KHEuCT+mVj/F/p1mabag9z+yOh2fkDpdxc0iDQdyf0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082210; c=relaxed/simple;
	bh=lAnmlbxCoMdogJ/+cu9F6g3ISiCktY/OyTnG9A/BXec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AET+SozIiXsLXQM/+4RB5xoKPP3bd6rPdMcaWQKIN1DWeC6sJCPT+imp4SZqj9jufbJzksFLCRP26A4btujXZuMeiUq2UXpe/bJmP4mOw1O2tXbDTR4/9v0QSJdzfzyJMl2tazudMLeE17tzW/XA/ukDLrAGJ1XKs/JLQ+dXLNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKVk6ZpL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKVk6ZpL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778082209; x=1809618209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lAnmlbxCoMdogJ/+cu9F6g3ISiCktY/OyTnG9A/BXec=;
  b=QKVk6ZpLP1DhQB3AACLrk58E9xSBcMOPmKOIqO8ig6Sn2SbAmaIUXe8x
   rxkdxWlkdEk2pJhm8TtbFS816Xa3A5DjW/mJGf0489WO+hQ9KJxUheICa
   wsfbZLOORwtZkN0BbjFGvdIoYUyk34IotEGh0itZZC6oLI51Z0yW2PPWz
   8zN6FQwzU3m2e+IYMNRFcmg6f3ufDn4zrcGn5OXEYXXSXMAIPMj9uQRgh
   5WpWsQE6O/z43ibn8VJkf9Pp80ylZSxTvMYBlH7iwSvt7v2RzC24+SkMP
   +YxTn32Ai2cepYiPWKQXMr7pbdhw9vMbyQ70G6FGDmIaUNO1XB22T++qe
   w==;
X-CSE-ConnectionGUID: 7S5pR2XhQK+xQsaRP/tTPA==
X-CSE-MsgGUID: RkLgB2T1S3CBMtSNHa66qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78166815"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78166815"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 08:43:28 -0700
X-CSE-ConnectionGUID: RufDSelWTuSv3LgoW1AiwA==
X-CSE-MsgGUID: PiPs+CMdTrStKd8JH0aCpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="233532913"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 08:43:26 -0700
Date: Wed, 6 May 2026 18:43:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: humidity: ens210: Fix missing I2C functionality
 checks
Message-ID: <afthm7L0j8VZdkUk@ashevche-desk.local>
References: <20260505174943.94093-1-salah.triki@gmail.com>
 <afr-KvM756ZAn2hh@ashevche-desk.local>
 <afr-UujhzuwZWzhT@ashevche-desk.local>
 <CAKqfh0E+4WUBsMHH0Rj1UH0MFdGo7E1crmHzJ+E6c0XXz3qvCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0E+4WUBsMHH0Rj1UH0MFdGo7E1crmHzJ+E6c0XXz3qvCw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 10:02:29AM -0500, Maxwell Doose wrote:
> On Wed, May 6, 2026 at 3:40 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, May 06, 2026 at 11:39:11AM +0300, Andy Shevchenko wrote:
> > > On Tue, May 05, 2026 at 06:49:43PM +0100, Salah Triki wrote:

...

> > > > +                           !i2c_check_functionality(client->adapter,
> > > > +                                   I2C_FUNC_SMBUS_EMUL)) {
> > >
> > > This one is now wrong.
> >
> > I meant this *indentation* is now wrong.
> 
> Did something happen to that when I sent the email? Or maybe I'm just
> going insane...

Sounds like latter one? :-)

> slightly confused,

In short this is `if (foo(A) && foo(B))`, and foo should be indented on the
same column while their parameters on different but still same. In your example
the foo(B) is indented as A parameter on previous call instead of indenting as
foo(...).

-- 
With Best Regards,
Andy Shevchenko


