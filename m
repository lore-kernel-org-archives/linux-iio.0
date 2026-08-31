Received: from out-93wp-a26.jellyfish.systems (out-93wp-a26.jellyfish.systems [104.207.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BAD3002B3
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195262; cv=none; b=W+FkrMR05jOhAWo6OuhNZ2Wk8r4chdqIhE5oHtXjrAVytcVbpQQpLHqnXJ/wSzaxGXqO+BZpn7vGUl1AORBG3jRmE6S2IfGc2Ck2g/DPM+ZVPKQ+BbGEfLAxR1FXiM7AguRsEtx9O5UBbDtw2N1VaaDcc2IidfxF04zoFduuOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195262; c=relaxed/simple;
	bh=wdTdnReRXzd1Bguen18saCTDuAQZ/WVSXNcwUqBab68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbFwUF2eC9+Bhq1wGRlWLSMGFOe2ru5hXxS0rv+Uiph356K+0TaIKVQMdHI9ByKNewgPCwHWeC6WTOUWlzbz5WCpcotkwsv0Rimmg+T/jwk1Au7V3BSxni5o0TpU0e9CMwkrma0kvhHJ5C1IXeIE+spw6EZn9ebWziu1KQbHvFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=jIJmGax+; arc=none smtp.client-ip=104.207.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="jIJmGax+"
Received: from gurudas.dev (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hYZKv0gfHz8sWl;
	Mon, 31 Aug 2026 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1788193987;
	bh=NRWTITtTFLdH6TRywQKTgnp9wFhHDExYCTpgGwqJ2A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIJmGax+QYRE+/8nZw/hkr80yjJ12UTsFr3k9Pxm0PK6gdGiaWhsKtQMDpFBO+cUx
	 LRyZuTUyxao6SB7l8752N6hE5gaV9hPSkH9mBAWy/IZ8y0iWuwl4MK/QAZCCry/lIo
	 vwCWO7dt4672ChZy5zmYP2fcVnZd9NfljvP5Hb04FNjkwLNnPcytVuSWnRcHkBUi8T
	 ycBigyrTp28H6qL2BNlpxrmUppPXcvEJ5idutsKEvmbA0kF9zCbQ/8S3lshcFzYwby
	 TxM70XFKc1/BLXdVWkpZSahcyG9AuhALing0hUNX4657aJAGoCECHg54hZ2CixGHLT
	 Rb5gnrL7WrICw==
Date: Mon, 31 Aug 2026 09:33:05 -0700
From: Guru Das Srinagesh <linux@gurudas.dev>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gustavo Silva <gustavograzs@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] minmax: Add in_range_inclusive() for inclusive
 range checks
Message-ID: <apWswZ8jUhOMqqLl@gurudas.dev>
References: <20260816-minmax-in-range-incl-v2-0-766f737dd6bf@gurudas.dev>
 <20260816-minmax-in-range-incl-v2-1-766f737dd6bf@gurudas.dev>
 <aoLBC2TBbwfZke-5@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoLBC2TBbwfZke-5@ashevche-desk.local>
X-Envelope-From: linux@gurudas.dev

On Mon, Aug 17, 2026 at 11:06:35AM +0300, Andy Shevchenko wrote:
> On Sun, Aug 16, 2026 at 12:26:20PM -0700, Guru Das Srinagesh wrote:
> > in_range(val, start, len) takes a start and a length, i.e. a half-open
> > range. Callers that instead have an inclusive [start, end] bound have
> > no ready helper to reach for and either hand-roll the comparison or
> > convert it to in_range()'s (start, len) form themselves.
> > 
> > Add in_range_inclusive(val, start, end) as a direct comparison rather
> > than a wrapper around in_range(): computing len as end - start + 1 and
> > forwarding it to in_range() subverts in_range()'s 32-bit/64-bit dispatch
> > for sub-32-bit types via integer promotion, and overflows to 0 when @end
> > is the type's maximum value, silently rejecting every input instead of
> > accepting all of them.
> > 
> > val, start and end are each assigned to a __UNIQUE_ID()-generated
> > temporary before use, matching the __cmp_once()/__cmp_once_unique()
> > pattern: each argument is evaluated exactly once, and the temporary
> > can't be shadowed by a caller's own same-named local variable.
> 
> No new code to lib/ without test cases.
> NAK (until the test cases are not provided).

Done, added KUnit test cases to v3.

> > +/**
> > + * in_range_inclusive - Determine if a value lies within an inclusive range.
> > + * @val: Value to test.
> > + * @start: First value in range.
> > + * @end: Last value in range.
> > + *
> > + * @val, @start and @end are each evaluated exactly once.
> 
> This misses the return section (yes, this is not obvious, but needs to add it)

Done, added return section to v3 kernel-doc.

> > + */
> > +#define in_range_inclusive(val, start, end)				\
> > +	__in_range_inclusive(val, start, end, __UNIQUE_ID(val_),	\
> > +			     __UNIQUE_ID(start_), __UNIQUE_ID(end_))
> 
> Do you know what __UNIQUE_ID() does and how it will affect the preprocessed
> size? It may or may not be needed depending on the (current) use cases.

Sorry, __UNIQUE_ID() has been dropped in v3 as v3 follows in_range() more closely and
does not need any temporary variables.
