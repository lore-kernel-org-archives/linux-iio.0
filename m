Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0B23D4105;
	Thu,  7 May 2026 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155935; cv=none; b=D4tjJtgFubhOtdduFMxcVZct1eu+1rnXo0z+0+p7GyvPkS9dvQ/zyaHdueU342BPvKUwk3kensPe48YuXataryHT8lNj7m4x+/YGUdizuGc7k7oW5EWJA9HtmmEyQonPsZ9/9lno1npR6DgQYkSBrnBbmL+I+ixMYJDE749x2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155935; c=relaxed/simple;
	bh=nIu0QmYa608/f4p41hOWdhn6n2tQSSV3GCQn8exYu3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKetQRp44eJHoY/+yWoxzYjsW/EosEwclIRcaGCTkQRbcvxEOuzoXEtO6SHCzeo9840O4suGTyULGP8QFGwGx7XMezP8lvMafEaL+T8KxxJhTEDhk4ezlB/R3IzsB/Ex6DGQgj/Mkz2rjIuESMLCOKMexxadp05IQhE+DSYMqS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3nOGnjR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3nOGnjR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778155932; x=1809691932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nIu0QmYa608/f4p41hOWdhn6n2tQSSV3GCQn8exYu3I=;
  b=b3nOGnjRusyfaf3dX18g5dlvAthWvQ+xlLcDhkqWiPYiX8usVVEbGKvO
   XDlzcDtiSMT9BzoM22Otit2QIhjc5qorum/9AWq7ZihvwGG/Ifz4402vv
   jj0mAu97P6SyI52d3j5eKLoeVh98jPQ8+H5cmSmSj9l/n5mDqC0zYZl5a
   qd8WUrQGEbc54JgZwiOLloVacSCqeploB7+vHYucipW+sKcSD5kiIerFh
   IRucrKyURhzFFfViMunMDucrjVo9i6amFUbjKJaFD3uebVixSpHSMvg29
   I19vVGeqdeFvu96xjib+/7asEKbcTn+p5eoM9wQp/vwMWU8eNPT3K9P2r
   A==;
X-CSE-ConnectionGUID: owiOO9saTwuExDBu9KtrDw==
X-CSE-MsgGUID: /zkV5eOqRBq3K/6YZvIrgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79289816"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="79289816"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 05:11:53 -0700
X-CSE-ConnectionGUID: 073zjjMWRdOcKMcwjWfvuA==
X-CSE-MsgGUID: ewjcX2ulSlm0MzGLs8LQ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="240429404"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.149])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 05:11:52 -0700
Date: Thu, 7 May 2026 15:11:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 14/18] iio: magnetometer: ak8975: switch to using
 managed resources
Message-ID: <afyBhRNuUOsa2dWP@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-14-831b9b5550fc@gmail.com>
 <20260506180925.3fb80edf@jic23-huawei>
 <CALoEA-x0baxV+9-rsN9omJ9GnLw3zp2qmU08RjzWniPOU+uxKw@mail.gmail.com>
 <afxk7mDvc_-IHVDy@ashevche-desk.local>
 <CALoEA-za64VHBpw1Zh5LzvhJtgViwq30xpPb3NGMkuh=0_=HXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-za64VHBpw1Zh5LzvhJtgViwq30xpPb3NGMkuh=0_=HXw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 12:14:30PM +0200, Joshua Crofts wrote:
> On Thu, 7 May 2026 at 12:09, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, May 07, 2026 at 11:19:32AM +0200, Joshua Crofts wrote:
> > > On Wed, 6 May 2026 at 19:09, Jonathan Cameron <jic23@kernel.org> wrote:
> > > > On Tue, 05 May 2026 13:46:10 +0200
> > > > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

...

> > > I'd just add pm_runtime_mark_last_busy() and pm_request_autosuspend() here
> > > to make the device suspend.
> >
> > pm_runtime_put_autosuspend() is exactly doing that in one call. That's what

(Okay, this should be read as "pm_request_autosuspend()".)

> > documentation says about, and that's correct, however it might be not so clear.
> 
> Maybe I didn't look enough, but I couldn't find a definition of
> pm_runtime_put_autosuspend()
> that actually calls mark_last_busy().

Hmm... It's just there.

static inline int pm_runtime_put_autosuspend(struct device *dev)
{
        pm_runtime_mark_last_busy(dev);
        return __pm_runtime_put_autosuspend(dev);
}

Even in pm_request_autosuspend().

> Either way, it wouldn't hurt to add it manually, just to be sure?

Why? the whole point that it's not needed when autosuspend is in use.

-- 
With Best Regards,
Andy Shevchenko


