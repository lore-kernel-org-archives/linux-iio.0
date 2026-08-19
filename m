Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318793D25CC;
	Wed, 19 Aug 2026 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165690; cv=none; b=hDvXLICdt+whSRk6dFLEaPa0RGq25MG//w8e7H4Q+BhQYrLlAo3QZ80BGYJM8hlD66Xzd5HA+Cwj3yqIQQCj9HtIXVvxd+c731+GF59/hKKhSo+n0/52mhaY9Z+nN52prT6dkI9kL8xrrGVlho3W/ui1rsPZXD+czeG+/Z4o8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165690; c=relaxed/simple;
	bh=L2HETGloR8xkRUrykD/AGK4iRmBt7ju1G2PpIEsfYFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro/vbWX/jaC5uEhuShMZmWmxoJljjyx5XpDJ8r09jQrfcbz4SIkI2Wgp+A7P1mR9r4L+S1iOlbR9SROXeNpT2reSYf83/mchIS5POr340jbOEVJUjsZ630nkGfOsmTsp3SzC0wVSed1OKCtpkQuRfbHWw7DcV70I88LpuUAuCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwW5Y3WL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwW5Y3WL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787165688; x=1818701688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L2HETGloR8xkRUrykD/AGK4iRmBt7ju1G2PpIEsfYFc=;
  b=BwW5Y3WLZodUQxDm8XdTqHBc6rvicOzuvImcfpk3qFUuOuyCD530NFNF
   kvCtk9jEkrwR37WKjZm7qQOWPLegxqpwU1si/X22TVwaBy8jLFPGwRfW4
   2lhlc9vFas2zhP1HU3GjzKSUPFWicA9z56EDcQUxDmwI1QkJICIo8tQ55
   PnbE1p3aDAGysY6EMtsKoHdL5UWRnxFJcCFeiHsocaXeFfsIb37vJqgdt
   Yb9MNmioNQWloTBWzkV439/QqscJYIqYZJdxnGsR50NJB49oZJ1DaLfJm
   PSFYmyGuxvfMdffdALULwBDIwKSCRVR6ui0i7IO4gyRzumBzLzFmYR6t/
   A==;
X-CSE-ConnectionGUID: Z5EY0QIhSwWH/QjbB7XrGQ==
X-CSE-MsgGUID: f+3Hn1XPR6i0z5gmfuGWUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87899295"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87899295"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 11:54:47 -0700
X-CSE-ConnectionGUID: r4ngswyoTI2+ZPslZh3lVQ==
X-CSE-MsgGUID: SY4u6cXNRguFj/u0FNBHpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="259482720"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 11:54:44 -0700
Date: Wed, 19 Aug 2026 21:54:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <aoX78syq62cEs3hi@ashevche-desk.local>
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
 <20260818-veml6031x00-v7-4-2b0de0f20edf@gmail.com>
 <aoRltgy0AYZ_Vcum@ashevche-desk.local>
 <DKS790BEXVON.1FP9LQUPNTYDE@gmail.com>
 <aoU0JSmv7FWGW_Ms@ashevche-desk.local>
 <DKT4WS5CVP2V.2FWDOOOHIL3XS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKT4WS5CVP2V.2FWDOOOHIL3XS@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 08:33:30PM +0200, Javier Carrasco wrote:
> On Wed Aug 19, 2026 at 6:42 AM CEST, Andy Shevchenko wrote:
> > On Tue, Aug 18, 2026 at 06:10:51PM +0200, Javier Carrasco wrote:
> >> On Tue Aug 18, 2026 at 4:01 PM CEST, Andy Shevchenko wrote:

...

> >> >> +	ret = pm_runtime_get_if_active(dev);
> >> >> +	if (ret <= 0)
> >> >
> >> > < 0 seems too much to me. If there is disabled runtime PM (and supposedly
> >> > device is always on) this prevents from getting events.
> >>
> >> I am not sure if I get this. A reference is unconditionally acquired
> >> when events are enabled as well as in buffer_preenable, and also in the
> >> probe before interrupts are enabled. Runtime PM should be active at this
> >> point. If not, the interrupt should not come from the device, even if it
> >> was on (e.g. before autosuspend kicks in). But maybe I am missing
> >>  something?
> >
> > The device maybe in these states here:
> > - powered off (by runtime PM) ret == 0
> > - powered on (by some previous activity) ret > 0
> > - always on (PM is disabled by user space, for example) ret < 0
> >
> > Are you telling that the third case is impossible? (Note that autosuspend in
> > this case is irrelevant.)
> 
> I followed the execution paths and the third case seems to be impossible.

Thanks for checking this!

> Setting power/control to "on" calls pm_runtime_forbid()[1], which sets
> runtime_auto to false and increments the usage counter. Note that it does
> not update disable_depth, which is the variable that pm_runtime_disable()
> updates and what pm_runtime_get_if_active() checks to return -EINVAL if
> runtime PM is disabled. Therefore, pm_runtime_get_if_active() should
> return a positive value under this configuration.

Would it be possible to have negative value at all from
pm_runtime_get_if_active() here?

-- 
With Best Regards,
Andy Shevchenko


