Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD823328E2;
	Mon, 26 Jan 2026 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425272; cv=none; b=B6Odyi2TY71KUO81cpgSZAr0pIf6fqkxTKizhppogEbIyw1rlCJq4e2MYkRNho6tFdI/ynDQK4DIzWaFvj+nAAud4faGLbRHVUoiy+XmNRC4z+hYnGXNeiUHhJZOJWr1TBmUNzbq4h5deknyjMu9TIovTFZf4TyMnETsTT3izo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425272; c=relaxed/simple;
	bh=iQHm0G3MvLIv+Sa8rtsaBwOV4TDuTrxVd0iemlyNd0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqzRNBpNEHtyq/6AyXblK1eNfAAf0r8U5sEc3//CorI95CElm2RNnz9ijwnn60uZ2BNr37lPJPR9eU5TF7USMgxYFEcDlbzAH6DRvyk2VV7Zi22FKn6DfhT5EuM5kMbJpIApEky4kif7vHJZs45/4hnaB6HcRE64emVMTsgltjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbXGARy/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbXGARy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769425270; x=1800961270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iQHm0G3MvLIv+Sa8rtsaBwOV4TDuTrxVd0iemlyNd0Y=;
  b=PbXGARy/goRfjlgwIxlbHn1NX8jUpCEcLQ2kkGIwhuNjJ+qHuBl8yiBO
   UKOhjhtnuIDo6BbU1rEU9DhykeNg5ApoLVpNsDGLuYTgRUZNX7AcTBj+X
   90qXbjgAbGWtuIQ/km68js/wQhFMNLtDkdyNzvgItVqixSpViIp/mPe5b
   gsMgNO1P6swOj/KyZP3BVsgXLKeW2ysv2PSOTdyV/jMgQ08spAIa4WhN9
   BLFnxt3d9shIO0Wp+sPNR9VCWEhqWJXE31rL7ymOf5rQ7j/EpuZz2Nqrk
   3wq24Jy87t3Ctv3SOFlr0EoGAtN+McPH4NcW1kKxVABepPM0yqOKqegLw
   Q==;
X-CSE-ConnectionGUID: m38p1hdqRLuv+A5DPwrF6Q==
X-CSE-MsgGUID: tdF69677TGKVZcDTOpaNAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="82032450"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="82032450"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 03:01:09 -0800
X-CSE-ConnectionGUID: Wpyf4aTAS0mQ4M78pvcVXg==
X-CSE-MsgGUID: CzDgbaF6Rs6W95ROV7/AIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="245260966"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 03:01:04 -0800
Date: Mon, 26 Jan 2026 13:01:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, tools@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <aXdJbidb3DPyRaxB@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
 <aXOKVqxyhQ10l9V4@smile.fi.intel.com>
 <20260126081510.jr8Rp6R7@linutronix.de>
 <aXc5Efu-PlLNCxkk@smile.fi.intel.com>
 <20260126101034.lnGGQmUD@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260126101034.lnGGQmUD@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 11:10:34AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-26 11:51:13 [+0200], Andy Shevchenko wrote:
> > > > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > > > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > > > > Cc: Puranjay Mohan <puranjay@kernel.org>
> > > > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > > > Cc: David Lechner <dlechner@baylibre.com>
> > > > > Cc: "Nuno Sá" <nuno.sa@analog.com>
> > > > > Cc: Andy Shevchenko <andy@kernel.org>
> > > > > Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > > Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > > Cc: Kent Gustavsson <kent@minoris.se>
> > > > > Cc: Gustavo Silva <gustavograzs@gmail.com>
> > > > > Cc: Nishant Malpani <nish.malpani25@gmail.com>
> > > > > Cc: linux-iio@vger.kernel.org
> > > > 
> …
> > I didn't follow. How? What tools do you use?
> 
> b4/ git.

> > > So I have to move them for each submission. Or is there something I am not
> > > aware of?
> > 
> > Make them in the tail of commit messages locally with a delimiter, they will
> > always be present as long as they are in your tree.
> > 
> > I dunno if `b4` manages the Cc lists separately. At least I see no-one using
> > `b4` *and* putting the Cc noise into the commit messages, so I assume it
> > behaves nicely.
> 
> I point is if I move them for one submission,

It will be in your Git tree as a part of the commit message.

What I mean is that your commit message will be like

  $PREFIX: $SUMMARY
  ...blank line...
  $COMMIT_MESSAGE
  ...blank line...
  $TAG
  Signed-off-by: ...
  ---
  Cc: person 1
  Cc: person 2

Just don't reimport them via `git am`.

> I lose it on the next if I update patches in tree and re-export them. 

I don't understand this, sorry. Can you provide a step-by-step example?
Do you mean that you are taking previous version from the list and reapplying
it via `git am`? But shouldn't `b4` take care of that as long as it knows the
Change-ID and it matches?

...

Hmm... The https://b4.docs.kernel.org/en/latest/contributor/prep.html
doesn't clearly tell me if there is a carry-on procedure for the Cc
list between versions.

...

> > > > > +		ret = devm_request_irq(dev, st->irq,
> > > > > +				       iio_trigger_generic_data_rdy_poll,
> > > > > +				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> > > > > +				       indio_dev->name, st->dready_trig);
> > > > >  		if (ret < 0)
> > > > >  			return ret;
> > > > 
> > > > Interestingly that this driver ignores the flags from firmware... Seems to me
> > > > like a bug (not in your patch, obviously). Ditto for other drivers doing similar
> > > > things.
> > > 
> > > If the irq-chip is level or unknown mode on boot up/ default and the
> > > device can only operate as an edge-rising then I don't see why this
> > > should be a bug.
> > 
> > But if FW says use "level", wouldn't this setting override it?
> 
> Yes, it will. It was common to use it pre-device-tree time where this
> information was not configured automatically before ->probe. Now it
> might be missing/wrong in the dt for some of the old devices.
> It might be a left-over which continued to grow and spread.

It may be considered as a bug, especially in the cases when the driver works
only on DT/ACPI platforms.

-- 
With Best Regards,
Andy Shevchenko


