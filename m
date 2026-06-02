Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A531987D;
	Tue,  2 Jun 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423569; cv=none; b=G32jvrSJIBMNhwwV4Y3cYx6At3RYS+FPieWKgQhcs2VDY0M17EAQ01jeE9SSlMxPmUDSUeO5AZuy4GYgGzOtDhwmNDcHqp55taLBMLJcUyanJh2b4XI+Oewkbh2crz/+4540A1iNsjBo8k0vj+r4LU1LuhKQKcNRVe/tQfL78dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423569; c=relaxed/simple;
	bh=ddHWYaFD2jClEEVhIlWR1vW+rCcxWgxbUdMnw+H0Ol8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBhyFqsEeLQ+QGVvNexyqx0RcGSqkep+/nstb6pzuiFtKZvqyWP49Oe6vitkr4SDnVz8ZY/7ATaDIJ8IGwI+p+tE8ThTpbe4/BLk09AnRwCEnFwfkCtQXGiRXkwBFF2gmdZvpevM56KJWJ4iKUW4lZ78Qb3wabuw3/vVEJ34X8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPAsIQBc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPAsIQBc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780423568; x=1811959568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ddHWYaFD2jClEEVhIlWR1vW+rCcxWgxbUdMnw+H0Ol8=;
  b=kPAsIQBcHT+lKEIvrn47C4psdUPc/suGuARcnLbWdXEa1DraqsYbhQLQ
   q2Bsr7ggkuEnNV8ES9C31qDvyYt4tzvKcSVPJLDfPQHuMtxt68RvW1R8L
   epEYm4RN8RPNUUvO3x53fc0q6w7abDSGT+NUv6wvp9rnL5mu2PMtIwMAU
   Z82eRpcUqgyMrXV6MulGKSRGrgihDpU8fijUpRl7iBAqte/E47Vhe4Qmo
   FQsV6LuHRi1CitTw5q+t5p712z1PT3Uqi2bcj+NoJA2YrHP01OatQ8e6o
   VpELrDttnZpcKfrU4IdX983r1yPJEB1b4WObeDvHA9MjtoKfCYMcKhAYr
   g==;
X-CSE-ConnectionGUID: seeZrwlNQdyRX4VM841EGg==
X-CSE-MsgGUID: xzh+387rTAKiMgH0I1dQ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="106666544"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="106666544"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:06:07 -0700
X-CSE-ConnectionGUID: NXygdP9FRQemgGYOHheRwg==
X-CSE-MsgGUID: Ba5l1Q+ET82LhnhVjgtt7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="237629640"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:06:06 -0700
Date: Tue, 2 Jun 2026 21:06:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxwell Doose <m32285159@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: ens210: remove compiler warning workaround
Message-ID: <ah8bi2hsftoGQG4i@ashevche-desk.local>
References: <20260521-iio-humidity-ens210-remove-hack-v1-1-9528ac1b384b@baylibre.com>
 <CAKqfh0Gwon4X2aCoDSNNBg7wXnKfbh69kj1R2HopKv=jHwfL-g@mail.gmail.com>
 <20260522133717.32772423@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522133717.32772423@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 22, 2026 at 01:37:17PM +0100, Jonathan Cameron wrote:
> On Fri, 22 May 2026 00:25:08 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
> > On Thu, May 21, 2026 at 8:26 PM David Lechner <dlechner@baylibre.com> wrote:

...

> > > -       case IIO_CHAN_INFO_RAW:
> > > -               scoped_guard(mutex, &data->lock) {
> > > -                       ret = ens210_get_measurement(
> > > -                               indio_dev, channel->type == IIO_TEMP, val);
> > > -                       if (ret)
> > > -                               return ret;
> > > -                       return IIO_VAL_INT;
> > > -               }

> > > -               return -EINVAL; /* compiler warning workaround */

We may just drop this return statement, but in this case some people may be
confused. In addition the patch fixes the indentation of the function
parameters, which is good on itself.

> > > +       case IIO_CHAN_INFO_RAW: {
> > > +               guard(mutex)(&data->lock);
> > > +
> > > +               ret = ens210_get_measurement(indio_dev, channel->type == IIO_TEMP,
> > > +                                            val);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               return IIO_VAL_INT;
> > > +       }

> > I'm questioning how that initial commit got merged at all, they
> > could've just used guard()() with {} (the kind of thing to make me
> > want to take a look at this file even further!). Visually looks good
> > to me but will follow-up later with rb if it all checks out.
> 
> The guard stuff was fairly new at the time so we were still working out what
> patterns make sense. Took a little while for consensus to emerge!
> 
> Anyhow patch is obviously correct and a cleanup so applied to the testing
> branch of iio.git.  Happy to add tags etc for next few days
> (or drop it if I'm missing something!)

Taking the above into consideration,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


