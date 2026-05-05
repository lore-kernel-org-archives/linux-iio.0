Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0631363099;
	Tue,  5 May 2026 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965708; cv=none; b=j3zCbC8+bVzOiBQG5oHD/UcsySDHjo8ff8DWUqdZig2LFnmv4YrjinJ8M+bWpxV4OVEMMB47VaPEprwJFUSm2HY7P65SVIzHYZTf6A31KHMy6ERam8Jl0Q4DH5sYzNbfLOlmw6ZJk8SKhom69WRNKQTRbkpvZW4XP7urfrQMDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965708; c=relaxed/simple;
	bh=cRnFj5rbUkuURgzl0BKqvhur0tEhZJJFzzgVL1cPfMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmfZaJR05RJGEsATe5LpTTDO3657oXMfCZYEBye47aOL6gEVVuTIrZKJJMsKSzD4IljTdFMWKQ5loBDY7QKKqo4HD/5BDNoM1X82tvjhmX7yv9grGYwQc34ugTqUoQuKXEZaMLEEI3UO6RDt36Yd2CsHSVJCQFuM9VXtnJLCa14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZrI8b3Zy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrI8b3Zy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777965705; x=1809501705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cRnFj5rbUkuURgzl0BKqvhur0tEhZJJFzzgVL1cPfMs=;
  b=ZrI8b3Zy+1KD0fNTQbDZC6VbAHZNDcU8rTqdVeAllM/LLotjh/xEMRuc
   BndFPrgIVY7PIN3ok5iHhgFsEVzWykiYB4op50emJXK3OVwXXqrDsoxqg
   dLFlc2JXzhGJD+dRuMgGvFdDzx/+0K8RzmuRaB7MPQph5YRikvPm5lldr
   JDgqMWcuL7XUHf3yvPvtXtG/rddNITkLBdj5qdB/lrEc1KEUVA9vgAPcJ
   rMWCARNw/BkqLoe4VaDKcir5LaA+2Jlw50cVxVZZjDgWPxij1i7AZaYJ3
   PAVSVsY7T2DPyD8NC+6HWnP4jVTJNnFGFM1NFByCPzhn4Yw1pLBRFzkW9
   w==;
X-CSE-ConnectionGUID: m113Abc7SWa8KRwgHXCbJA==
X-CSE-MsgGUID: RDM5pcwqSwOqbXbrc2hrQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82696890"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="82696890"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:21:43 -0700
X-CSE-ConnectionGUID: um29lgLWTfmKMvraeVyEHA==
X-CSE-MsgGUID: a5jvQLCTSUmTmuSewV5e8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="235990798"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:21:42 -0700
Date: Tue, 5 May 2026 10:21:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/17] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Message-ID: <afmag-hFCs8u6jN7@ashevche-desk.local>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-6-a291c2a7c71a@gmail.com>
 <20260504160606.07f87f10@jic23-huawei>
 <afl404iaPbSsK5XF@ashevche-desk.local>
 <CALoEA-xkOVvGqwWdHMS3HbJSCrSbyBd4GQ2CkczkT9Tn-xO_bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-xkOVvGqwWdHMS3HbJSCrSbyBd4GQ2CkczkT9Tn-xO_bw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 09:07:30AM +0200, Joshua Crofts wrote:
> On Tue, 5 May 2026 at 06:58, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, May 04, 2026 at 04:06:06PM +0100, Jonathan Cameron wrote:
> > > On Mon, 04 May 2026 11:48:18 +0200
> > > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

...

> > > One question inline on whether it is a good idea to be paranoid about
> > > gpiod_get_value() potentially returning < 0 to indicate an error.
> > > Right now that is treated as success.
> >
> > > > +   ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,
> > > > +                            AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> > > > +                            AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
> > > > +   if (ret)
> > > > +           return ret;
> > >
> > > Should we check val as well?   It might be negative if gpiod_get_value()
> > > returned an error..  Obviously the original code didn't so this would be an
> > > improvement rather than maintaining what that was doing.
> >
> > I agree that this would be a good addition, but since it's a behavioural change
> > I think the separate patch should be made (perhaps after readx_*() conversion
> > as it makes it easier to do).
> 
> Good point, val should definitely be checked. Will send a fix this afternoon.

It's better to integrate it into the series either as a fix (should be first in
the series) or as just an improvement after readx_*() conversion patch.

-- 
With Best Regards,
Andy Shevchenko


