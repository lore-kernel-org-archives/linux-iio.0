Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C90438038;
	Mon, 24 Aug 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585151; cv=none; b=VmUD1hZaZxUWQyuVWBY0n4SXyJWTGRwW1QuXlzCR4J706YLh8utBvcU9LUoaSLKHhst5OMHOuB0ud/QfWEvXSkbVWZ9MAM+cLl27wPETx9eyMteyUyWcExLvYFlGHu1ljTedX1Pzi68pUr05wnKNTdH/RfwX4VaSmbdXX7MNQyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585151; c=relaxed/simple;
	bh=w/cVUr4QpKdW6U6eAeB2AalafN4EKwjQaV9ud/UeP/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsYhLw6P6jUreDL7a2vbLpPxCqliTA/JUP03uW4Buy8fRIIXRi8Vs4iiDFI5vMhw3tdu9iBW6c6+Vnl1425jMRkeqSR2AeB9vxPjN94c9LEW98rMCnXwUXazJFdkXPNtyoj82j7wWbmCV+SF8FOjHTkqklVQfSayimlc4eUYmDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHHi+bL/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHHi+bL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787585145; x=1819121145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w/cVUr4QpKdW6U6eAeB2AalafN4EKwjQaV9ud/UeP/E=;
  b=FHHi+bL/D7pYtngZhaQv5JrvVmnqXyzjxq2kHXvBPzoC52H4zjfI+Aq3
   v1wq3F0qgMeQQ16BsTi7FO1yjsJIC2kPuFUbpgaoekMsaIYNELUEV0fvQ
   K3o/2XID3fRSDXscA1Qu4F8zsxbQSi1jmQ8YIUWIAYfX4ElFOd3K2dyY9
   HjxyI1AAkxq2EnTeIC7qzHTBSJzp8keue2fhSM9q7A0MtD+KCJ3LXRj/z
   gWHNoSc3NJ21PUiE4z0wZkIUhnMvoC4/ISwu3u9jy7Q0TEfTVro1UxZuj
   vgCQ4zmIHy2xT6j+eRrATM9WALGlL9vC2ARYNyDLVefPydLwQwoESN2C7
   Q==;
X-CSE-ConnectionGUID: 2FEFQKWaRgeIPexA6NCPfw==
X-CSE-MsgGUID: qpGdvAdoS6mZkSnyLyR8UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99201984"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="99201984"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:25:41 -0700
X-CSE-ConnectionGUID: uNn4nHmZSbihmXxoPb9f5A==
X-CSE-MsgGUID: 1eDtlvscRE2o7kW5qSs44w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="270824777"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:25:39 -0700
Date: Mon, 24 Aug 2026 18:25:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Rishab Madhugiri <rishab.madhugiri@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: Avoid BUG() on invalid clock types
Message-ID: <aoxicO-nya_zp9Aj@ashevche-desk.local>
References: <20260823222502.30764-1-rishab.madhugiri@gmail.com>
 <aowVI_n7s0VAmN3D@ashevche-desk.local>
 <20260824120503.00003500@gmail.com>
 <aoxZq7sc4ndMG-V8@ashevche-desk.local>
 <CALoEA-w8RMArm=STmnaGJJdyHpR7V-58uFz4m9U74aDe+QJe6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-w8RMArm=STmnaGJJdyHpR7V-58uFz4m9U74aDe+QJe6Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 05:06:24PM +0200, Joshua Crofts wrote:
> On Mon, 24 Aug 2026 at 16:48, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Mon, Aug 24, 2026 at 12:05:03PM +0200, Joshua Crofts wrote:
> > > On Mon, 24 Aug 2026 12:55:47 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > On Sun, Aug 23, 2026 at 10:25:02PM +0000, Rishab Madhugiri wrote:
> > > > > Replace deprecated use of BUG() in default switch cases of
> > > > > iio_get_time_ns() and current_timestamp_clock_show() with
> > > > > WARN_ONCE() and return correct fallback or error codes.
> > > >
> > > > Why?!
> > >
> > > Because BUG() and BUG_ON() shouldn't be used anymore, no? Linus himself
> > > said that he hates the macros.
> >
> > Why? Please, study the case. As for the above change, there are two questions
> > (at least):
> > - Why BUG() is deprecated? Where is it stated?
> 
> https://docs.kernel.org/process/deprecated.html?hl=en-GB#bug-and-bug-on

Thanks for sharing! So, this is a missing point in the commit message.

> > - What will WARN*() gain us here? (Note some specific kernel command line
> >   parameter that may convert WARN to BUG)
> 
> As Jonathan mentioned earlier, the original BUG() was there to prevent the
> compiler from complaining that all possible values weren't handled. So BUG()
> or WARN*() here is a placeholder. Just removing the BUG() call should be
> valid since it's impossible to hit(?)

Yeah, I was participated in several cases where the compiler made something
strange when BUG() was absent (basically no reachable point which BUG()
represents). Do we have no issues (anymore?) with the compiler with WARN*()?

-- 
With Best Regards,
Andy Shevchenko


