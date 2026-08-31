Received: from out-93wp-a27.jellyfish.systems (out-93wp-a27.jellyfish.systems [104.207.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD335386C17
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195059; cv=none; b=OHLgMF0wE2LYj7ace3T/zRkL+ye4y1kBD2OHUJxWTsxa2954WMKnOKicDfWGIhG8IgtiTtWbVOCECLuTISgyZV1g66NakY/1zP6zysOYp/D8+6Y4nKQMfLGfdq09nq0qsdBi+pyxZkqUNUpTqROaO0P7EAX9njfM7TIzFzyQZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195059; c=relaxed/simple;
	bh=gl0/SCu64bz3iEgZlakHvuwIqurKmNqW/AgWgajhtMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wa4TvK3DYh5gaGtz8A7SqKBdqney9LJTOfw2Wj9GN+/ggy/i+Pj8isK6wYJFV6x1IDJdLhKR2stJH1s+MBwSVne3VZD4gz2eUtmSRP2TxysJaO2z1yhhr7+JaWbpVv5lnOFaSk+iz5qt9Z+/jtoWKZcqzY1QC0AJKvfhAam8mKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=eABI9QuZ; arc=none smtp.client-ip=104.207.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="eABI9QuZ"
Received: from gurudas.dev (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hYZGF3bTPz8sXD;
	Mon, 31 Aug 2026 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1788193797;
	bh=G/cJ7AF6I/QA5U7RnOSBpR0OZgRn9Fa2wLsVsq4RM7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eABI9QuZXGlSaL8p2OoAE0nJSBQMXmJ+nMhJpEpdHLXYOQz5aLzOmUurasPvwMwCu
	 cFB2TTtUqj6K03nAc2t1R35MOk+6oE3qFTLdjQsQi4sgJ4+T01fjQ5bpeKN48db1iB
	 a/vTVUOaoCou2RNbSTQy7kreJIenDdZUHT38DEMKL+OJJGcnHktbu600lqPdBgd3vn
	 hGZbb5PIVarewbFL54LnFMaae/CXwiPVULA8CKnk1jt7l/fMmUXzaY/v8mc9lanREj
	 aXH4L+4erk6/KrNQAS8npvwFvp1cyOsBtdKUiZGRDACXo/7ZA3ye9IgcuPMKN5JQ0n
	 OWFQEeppn7QTA==
Date: Mon, 31 Aug 2026 09:29:56 -0700
From: Guru Das Srinagesh <linux@gurudas.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gustavo Silva <gustavograzs@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] minmax: Add in_range_inclusive() for inclusive
 range checks
Message-ID: <apWsBDT6tdpW6lUU@gurudas.dev>
References: <20260816-minmax-in-range-incl-v2-0-766f737dd6bf@gurudas.dev>
 <20260816-minmax-in-range-incl-v2-1-766f737dd6bf@gurudas.dev>
 <aoItA_ktl04qmhEb@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoItA_ktl04qmhEb@casper.infradead.org>
X-Envelope-From: linux@gurudas.dev

On Sun, Aug 16, 2026 at 10:34:59PM +0100, Matthew Wilcox wrote:
> On Sun, Aug 16, 2026 at 12:26:20PM -0700, Guru Das Srinagesh wrote:
> > +++ b/include/linux/minmax.h
> > @@ -299,6 +299,25 @@ static inline bool in_range32(u32 val, u32 start, u32 len)
> >  	((sizeof(start) | sizeof(len) | sizeof(val)) <= sizeof(u32) ?	\
> >  		in_range32(val, start, len) : in_range64(val, start, len))
> >  
> > +#define __in_range_inclusive(val, start, end, uval, ustart, uend) ({	\
> > +	typeof(val) uval = (val);					\
> > +	typeof(start) ustart = (start);					\
> > +	typeof(end) uend = (end);					\
> > +	uval >= ustart && uval <= uend;					\
> 
> By convention, 'end' is used for exclusive ranges while 'max' is used
> for inclusive ranges.

Changed to use 'min' and 'max' instead.

> Also, this seems completely wrong.  How do you think this is unsigned
> comparisons?  I think you'd do better to follow the example of
> in_range() much more closely.

Done - v3 now follows in_range() closely.
