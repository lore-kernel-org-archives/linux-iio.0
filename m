Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FB3CA4B6;
	Mon, 11 May 2026 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494491; cv=none; b=AiAcPhfOhFR3fD6EKsXwCTs3BNAya/EK7f4OTU8clP20tH8eF1KNoRfu5ABp+7tsX5uL+dGzsMKQmpaMioerTkEawVNt6224sA+QZ/dbdesK97XpL2zLQol1ULdkxJl2oA+KIs4rvSAIUtu3c7qr0J9mN3faacLuMwUcotOT37k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494491; c=relaxed/simple;
	bh=xuFzErrfu/8X5lQWYpfCAbxb9U4pxUDPcyc1tZ8xgHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdJgA/89WCUEGq6QZIFj+5YLHhZn43Mj0sHn4SEoX8iGJso1TmBTSEbhGLHjzLZE1tid6TElMkhKwk4lSHX3JXpyTjyldJmGE2MjCE/M7bUP1iiWMpUL5kR9lVQgkrBEJ8MdxaM3PsPdCfoaMOPByU3gjyuIzKyPUMBj3zWZZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O19pyKWW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O19pyKWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778494488; x=1810030488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xuFzErrfu/8X5lQWYpfCAbxb9U4pxUDPcyc1tZ8xgHQ=;
  b=O19pyKWWVplhi7pk4dLaNMknlpz0N6kYH254w/KUbHZVGQ4biam00Oo/
   j2n+J/N9aOSPzjaQ6GVrWASSfij1P900AMcWUbtd6REUE5bnscYIF4vMT
   UsApnN4wsO86/GmpBvSe46FZ1772dqN8U5/uGlkv1vp6bYKGYKNxaSXTD
   QTHuDzGalMzbRhwezYLatkJ4ek5MEHVLpZEN1V3xATxPkB0893w6jeW9P
   SWBTSBk8LWCikmjeJ2TxvUIYFJHLo4taYFzUlqcKssY4CPlneGKC5Hbw2
   fm/+UiETcs8AT9gXfKtIOGna5n+Sae5aJ/XRUSV9osxtG7W2rIyAEAAxJ
   w==;
X-CSE-ConnectionGUID: 4V7EmI0sSl6H1fALvR5wtA==
X-CSE-MsgGUID: 7leKv49QRXakaBLm+tuS9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="102041310"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="102041310"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:14:46 -0700
X-CSE-ConnectionGUID: bzjxbCjcQq2v13NLeHUHyA==
X-CSE-MsgGUID: kNLo1zNOQQ+p4/6ZJ9y6sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="241388756"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:14:44 -0700
Date: Mon, 11 May 2026 13:14:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: mike.looijmans@topic.nl
Cc: David Lechner <dlechner@baylibre.com>,
	Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [PATCH v4 2/3] iio: adc: ti-ads1298: Fix incorrect timeout
 comment
Message-ID: <agGsEjB4jqafHhop@ashevche-desk.local>
References: <20260509151959.3475-1-shofiqtest@gmail.com>
 <20260509151959.3475-3-shofiqtest@gmail.com>
 <f6189816-a157-466d-80bc-3f338c13d69b@baylibre.com>
 <agAs4IqohFKFhbhk@ashevche-desk.local>
 <4bb77b6b-8bc0-4970-acf4-6a6ebf9ceab4@topic.nl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bb77b6b-8bc0-4970-acf4-6a6ebf9ceab4@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 07:20:04AM +0200, mike.looijmans@topic.nl wrote:
> On 10-05-2026 08:59, Andy Shevchenko wrote:
> > On Sat, May 09, 2026 at 03:27:35PM -0500, David Lechner wrote:
> > > On 5/9/26 10:19 AM, Md Shofiqul Islam wrote:

...

> > > > -	/* Cannot take longer than 40ms (250Hz) */
> > > > +	/* Cannot take longer than 4ms at the lowest rate (250Hz) */
> > > >   	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
> > > I would say "lowest sample rate" so we know which rate it is talking about.
> > > 
> > > However, there could be latency in the kernel delaying the interrupt from
> > > firing. The kernel latency can be much larger (I've seen 100s of ms on old
> > > single core ARM CPUs). So I think we should mention that in the comment as
> > > well so that no one is tempted to set it to msecs_to_jiffies(5) (or 4). Even
> > > if that works most of the time on a fast machine, we may need the longer
> > > timeout on slower machines.

> > Actually it's not about fast/slow machine, it's about scheduler and load.
> > Even on the fast machine under heavy load the completion (if it's thread
> > based) may take quite a significant time to be delivered. For the hard IRQ
> > based completions it might be much better case, but nowadays it's more of
> > a niche.
> 
> This particular driver uses hard IRQ for delivering the data.

Does it set completion done at the interrupt handler?

> At the common
> sampling rate of 500 Hz, it generates interrupts at 1 kHz (each cycle needs
> one for the chip's data ready signal and one for the SPI controller).

Still, there are cases like PREEMPT_RT and threadirqs that makes this all
threaded.

> Although this particular case is the "single read", so there's indeed more
> scheduling involved.

-- 
With Best Regards,
Andy Shevchenko


