Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B733B979;
	Mon, 26 Jan 2026 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439452; cv=none; b=E15BpvOAq70RHYyt/2MPTCkvJnAdUIOcsiEvq5k9Yr1+TxJ1mcN8hJtquaYJe1C5qGUHvS9wCVxLFUnG27E2ajYfwk2PMD28qyV28YGlMQRxnEza1Ua8QobveCaDhXF70NDVSyKerCw7jDA82GAAeoGJzL7XQwxLRvJFJfw3pW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439452; c=relaxed/simple;
	bh=teeEXxbpXFTZGAEZ/KMuzRZF5Hg7sdOSd1BSpr/BPSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOBmvuBwWaSaVH78a3JLZhLkjOwGoDudLUbrLBuVXsFMYbVMvgZ1o2q0goRauskr83BnN+fz/f1SnoiYmpSdhf0dgcxglBqU3gcL6Q2sEsPh5fxgroTvAcvkHE7F8hRsrClS3aEpMcc0/PLIzCjN2KKZ01VB59ySJNiY+eCInVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ct10EN1i; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ct10EN1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769439451; x=1800975451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=teeEXxbpXFTZGAEZ/KMuzRZF5Hg7sdOSd1BSpr/BPSI=;
  b=Ct10EN1i6Vs/UDzGdtKuchabmCStcDfCU5aA4RRjNHcRwR2PSya/yveq
   JVC2SWdfoT/WSV2prOYGTywqQ4/HtRM5RcvD+dN8/0l918iOobZKNX53r
   vsoPjWS5Dc6U1TdiV0Ay9THeozbfSG6as4FMpyX+Kou5Ua3vZC3P1eHDX
   LqN1QmyTLSfQqtZktlyai0ZFsNnwValYU/+FcDVekWuJGPLCjFcpjO9Jv
   wXlMsyo08cz/RxIRBDPPutzhO4iZcS7i/FmcjxJJ+F+0ZNiYLz+LcAkcl
   wal+DOBYQuLiAY1BNhbbq8C6k3KNCBYCYo5rqUpoTw1hMF5U5QUklzaVz
   g==;
X-CSE-ConnectionGUID: fTuR5B6dTjiVmCgj/avc7Q==
X-CSE-MsgGUID: EDWZZ3DUQlieNf0tm8PuoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="80916144"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="80916144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:57:31 -0800
X-CSE-ConnectionGUID: AyVPtL/uTZ6Xa4OnhpERUw==
X-CSE-MsgGUID: J+FC1cvCS0q+GuIINWc33g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="238373155"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:57:27 -0800
Date: Mon, 26 Jan 2026 16:57:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Konstantin Ryabitsev <mricon@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, tools@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
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
Message-ID: <aXeA1AIcOx7yUNaz@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
 <aXOKVqxyhQ10l9V4@smile.fi.intel.com>
 <20260126081510.jr8Rp6R7@linutronix.de>
 <aXc5Efu-PlLNCxkk@smile.fi.intel.com>
 <20260126101034.lnGGQmUD@linutronix.de>
 <aXdJbidb3DPyRaxB@smile.fi.intel.com>
 <20260126-cocky-sawfish-of-variation-c0cedd@lemur>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260126-cocky-sawfish-of-variation-c0cedd@lemur>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 09:29:45AM -0500, Konstantin Ryabitsev wrote:
> On Mon, Jan 26, 2026 at 01:01:02PM +0200, Andy Shevchenko wrote:
> > > I lose it on the next if I update patches in tree and re-export them. 
> > 
> > I don't understand this, sorry. Can you provide a step-by-step example?
> > Do you mean that you are taking previous version from the list and reapplying
> > it via `git am`? But shouldn't `b4` take care of that as long as it knows the
> > Change-ID and it matches?
> 
> That's not the intended workflow -- the series is kept as a branch in your
> local tree and any updates happen to that branch, so any entries in a commit
> falling under "---" will persist across revisions.

Right. I found `b4 trailers` do a really good job to inject collected trailers
into the Git repo without need of any `git reset; b4 am; git am` dances.

> > Hmm... The https://b4.docs.kernel.org/en/latest/contributor/prep.html
> > doesn't clearly tell me if there is a carry-on procedure for the Cc
> > list between versions.
> 
> There isn't any special procedure. ¯\_(ツ)_/¯

What I have i mind is rather the scenario when I see already sent (by somebody
else) patch in the mailing list and I want develop a followup with the same
To/Cc list. So I want `b4 ... --use/restore-to-cc-from-the-mailing-list / lore`
type of functionality.

-- 
With Best Regards,
Andy Shevchenko


