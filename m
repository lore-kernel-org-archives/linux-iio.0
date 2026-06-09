Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D134041D;
	Tue,  9 Jun 2026 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016107; cv=none; b=XK7UNEqg5i7ZePrQvJf4sudNIN4zYcJhJaIXZRqwPwjB4rG6IIZ+PDNrsZHNrvIUIc4nr8WrNHmbn23fPdFg+sIzFoytsRF+zx8G0mw/vOOL/y9vwnpG14MCSlbiV+bmpp/HmtIexBTRplEYrPTmqOcT8tbUuw9JmHJcNgCQfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016107; c=relaxed/simple;
	bh=UaweEX+2ns42+g5IcchtUj6qMalDOI+s7SuOAeYzZxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpAtHoapIsk3DaKoePCxkwGiOWUTZpDIhCcn8K5h3VZ6ocRCU+g3Np0bC/j2/Mg0WK6CG3sa/OXmVQHDgf7RyYCj8aH50vU5aI9IVE4MjVy66ijV4w41iE/Q0YRXkFeGFNr1FNnWWp+J6UPM0YpGp2nHfXtF13VZsPunh9ItnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7m2qobz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7m2qobz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781016106; x=1812552106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UaweEX+2ns42+g5IcchtUj6qMalDOI+s7SuOAeYzZxQ=;
  b=R7m2qobz6fzSxNAxSKLjnx+3s2cV9XaJmryZk4u0UeJysish2sO/qk/R
   p0eHftVi8pMZ0e4sPfkaFQaK8jKWsJUpcxuDrk+OMZ/CBV9a+lliyGoHx
   xQHADPNWNAiO4pDBObut4+GzdMKgQsJoAXm/GhhBKOSn7SLvpmj2Bc2NZ
   IHXFxYJiM280jQYBR9xUB55BBdVj1tG6y+cbzjBu6WcrcnxNGsq74tveW
   h9J9gO/Mn3EVL28uaL1Ngp5CPUCuSY9ZR5ixr5NwBEVd4tcTlABo07KrC
   P2/rDBOHP50ZTnuhHhYeKdkgK2TM4UoZD3sc1pflCd5qXoFoYxREegY2f
   Q==;
X-CSE-ConnectionGUID: H8lTzF12ThGlAH9Ooz77pA==
X-CSE-MsgGUID: Q+UlVqPyRE20OQ0auNy2Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99354613"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="99354613"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:41:45 -0700
X-CSE-ConnectionGUID: PWNey+8zSVSbTHb9Z7VQKQ==
X-CSE-MsgGUID: WbeyK22IRkyLpGvC4ZFWsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="250805078"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:41:43 -0700
Date: Tue, 9 Jun 2026 17:41:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4] iio: tcs3472: implement wait time and sampling
 frequency
Message-ID: <aigmJD2r96nCu2dg@ashevche-desk.local>
References: <20260607112713.299968-1-aldocontelk@gmail.com>
 <aie2Y96Oylb5EEtM@ashevche-desk.local>
 <55020e69-ffe2-4d40-bdac-e6649693ebb7@gmail.com>
 <aigD0vmVJvKbtONg@ashevche-desk.local>
 <dd8129c5-fe15-465e-8203-103be3d0c9c0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd8129c5-fe15-465e-8203-103be3d0c9c0@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 03:36:03PM +0200, Aldo Conte wrote:
> On 09/06/26 14:15, Andy Shevchenko wrote:
> > On Tue, Jun 09, 2026 at 12:27:52PM +0200, Aldo Conte wrote:

...

> > > case IIO_EV_INFO_PERIOD:
> > > 		period = tcs3472_cycle_time_us(data) *
> > > 			tcs3472_intr_pers[data->apers];
> > > 		*val = period / USEC_PER_SEC;
> > > 		*val2 = period % USEC_PER_SEC;
> > 
> > Again, use HZ-based multiplier, see above.
> 
> Here i do not understand why MICROHZ_PER_HZ is better.
> In the previous case, we were indeed referring to the denominator of the
> calculation, which was actually a frequency, so MICROHZ_PER_HZ is indeed
> correct.
> But in this case, we are calculating the integer and fractional parts of a
> period, so I think this would be fine.
> Tell me where I’m going wrong.

Hmm... I think you are right and I stand corrected.

> > > 		return IIO_VAL_INT_PLUS_MICRO;
> > > 
> > > write becomes:
> > > 
> > > case IIO_EV_INFO_PERIOD:{
> > > 		unsigned int cycle_us;
> > > 
> > > 		period = val * USEC_PER_SEC + val2;
> > 
> > And again, use HZ-based multiplier, see above.
> 
> as above...

...

> > > 		for (i = 1; i < ARRAY_SIZE(tcs3472_intr_pers) - 1; i++) {
> > > 			if (period <= cycle_us * tcs3472_intr_pers[i])
> > > 				break;
> > > 		}
> > 
> > do {} while () seems better choice here (and do it in reverse order?).
> 
> Could you suggest the do {} while {} form, which seems better? Because I
> think it is already comprehensible.

OK, it's not do {} while

		i = ARRAY_SIZE(tcs3472_intr_pers);
		while (i--) {
			if (period > cycle_us * tcs3472_intr_pers[i])
				break;
		}

if I am not mistaken... OTOH, the for-loop is in the original code, perhaps
better to leave this approach and change separately if needed.

-- 
With Best Regards,
Andy Shevchenko


