Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112B3AE191
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131790; cv=none; b=tS9AN2jVJLoUtE10lNQWJZi62pVaZwb/WzOXFyLi9vBhBV6N8IcREjN/EvbBlzpOKsjp7ZDTLMW/5w4yJYP2nLkuL3g88dNOZPkU5nmnXk00Ga+MHOaT29vHMGjn4WU+c1rvgFWAtj4OetMDYvAFKxWLrHVdSGCIapzhwLC+W1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131790; c=relaxed/simple;
	bh=arloWMJjSQk/z3V1qKriEkmPefoLbYTG9watIdS6zqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx4/Ordhc+mOaW6FNEkeA60NuvbqbIuiHWZhEvjF3vLTshm5U5SVPVz5tNop55QbQs7iex+o7ZE5CvehfLeYiDUEC9nPwZLBSa4NqyT8OWmr1RZ0Pm7gTPZaJhXVhUqTbjjyxdAisHqIMcMp3l78S/IQaYLLOG5SDGqQlSSpr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVLKtfil; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVLKtfil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784131788; x=1815667788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=arloWMJjSQk/z3V1qKriEkmPefoLbYTG9watIdS6zqo=;
  b=jVLKtfilwON3f3SMlE/o+L0N0rUml4YyRwqYyZEfQYiYJlv+kua2GrjA
   T8sQAQIqI6pFpWJiV3hp9UndPkNLJ20MRRRchnoZLUqLgImjTf8y/cKau
   80m5DWOFckvAe+FojRwBVyeC51DctcsAMIQTNN4Iq1CFu1QhCAW8Erzd3
   /XJM9vzVEu+q60/uc89TRTgdDn45W6EenKzsyWTySAqdzdcGC+i5Oc5oG
   Br9mLXHYIPiYiLm43Li/c8Dr+7aapYIVXWVRUaZ2ghobcSICESzf6isOQ
   vZJiCu8TzjBXjbVIwiVYw3Gmi4dy+qDvjFZKs5KEJ3/OmVQskABUmSuvH
   A==;
X-CSE-ConnectionGUID: CprRrU+MTaKwMajevK5E7w==
X-CSE-MsgGUID: S0/5i6KQQXeXtZDqGIlQ3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96290598"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="96290598"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:09:47 -0700
X-CSE-ConnectionGUID: MOj+1bAARGKngfOqzWko9A==
X-CSE-MsgGUID: 5lphl4gzSI+XDHax+FucHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="256278304"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:09:45 -0700
Date: Wed, 15 Jul 2026 19:09:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <alewxmtqJmEkRfVm@ashevche-desk.local>
References: <20260715-iio-dma-cyclic-v2-1-268a3a28ff84@analog.com>
 <aleX0UD96t12s44k@ashevche-desk.local>
 <56f7bzba56atwu4qvgxpm4p7k347m4oqqdy3336rsy7xi3e7oq@jzoj2jtu3qu7>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56f7bzba56atwu4qvgxpm4p7k347m4oqqdy3336rsy7xi3e7oq@jzoj2jtu3qu7>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 05:13:32PM +0200, Nuno Sá wrote:
> On Wed, Jul 15, 2026 at 05:23:13PM +0300, Andy Shevchenko wrote:
> > On Wed, Jul 15, 2026 at 01:24:53PM +0200, Nuno Sá via B4 Relay wrote:

...

> > >  static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > >  					     struct iio_dma_buffer_block *block)
> > 
> > > +		if (block->cyclic)
> > > +			flags = DMA_PREP_REPEAT;
> > > +		else
> > > +			flags = DMA_PREP_INTERRUPT;
> > > +
> > > +		/*
> > > +		 * A new transfer may need to end an already active cyclic transfer
> > > +		 * before it can run, so always set the EOT flag.
> > > +		 */
> > >  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> > >  							 vecs, nents, dma_dir,
> > > -							 DMA_PREP_INTERRUPT);
> > > +							 flags | DMA_PREP_LOAD_EOT);
> > 
> > Logically I would expect this to be a separate line with the above comment.
> 
> Hmm I can agree to some extent. I guess it makes sense, yes. OTOH, it´s close
> enough to be clear what's happening.

Close, but not enough in my opinion. This currently is spread over pure flags
manipulation and API calls.

> Anyways, can spin v3 if you feel
> strong about it (will anyways wait for Jonathan to take a look to make
> sure this the only pending concern).

Not so strong, but lean towards my version. Let's wait for his review and
decide if it will be tweaked whilst applying or next version.

> > 		/*
> > 		 * ...comment...
> > 		 */
> > 		flags |= DMA_PREP_LOAD_EOT;
> > 		...
> > 							flags);
> > 
> > >  		kfree(vecs);

-- 
With Best Regards,
Andy Shevchenko


