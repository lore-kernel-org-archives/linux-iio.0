Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D173D6CC5;
	Sun, 16 Aug 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786916122; cv=none; b=MzMLF4lJ3b8YA1stgxX1IoKr+RIofVFdMwcjqziL/MS3x700zWmOTUzC9Sm4glINil+kUhYBgpOHVPGcreYfSqAAXeJ26I4bKcGpk2Q8l1Kua7199UWbeui4Hj1ICRwqv8QLqtkZVhmBFrhW/5khs6Fy5u8127mo4YBnnGGcAWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786916122; c=relaxed/simple;
	bh=doRe9pDoxz83Kw9gKKXePlQ8Oq0sR2Jl9ZDI9XBhcgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE8YyoNwxS/rwZj9zybzSWEGMabgmF1jMvjf3caGD1jSI2rOwGeV5n4mqsmrvH5vZo5c2zUl+VtGiqqqR2CoOjN+XWLzJPk2RhHhMlNaTCzTVRBXe4lF/RpPugPtk3ZAEP6H/+fK6qZyTDvaHN0lUlHDFlDlLlSMz/ebolbsXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kMmtFYv4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kMmtFYv4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NMd5U+2sN7asG0sEs5hUQViW9IT3+OUTluZczp87DsQ=; b=kMmtFYv4Vtla8uj1g/UpvDECfW
	EFkGj+YjxlFHoUDo1Dbiks+Ye8pMYVaW5O1U2onIIXTLJvZe8aorncniAZN2fOEay0QOXRPRzWP2q
	wOuSpLOyXe1hz0mcFfWsGMXLeGuDUfxEO8Nz2GRbN2G+WVM0f6ww3q+QvuKE0iypV37s/mOVi6GNj
	UOyS8WnIVVEo5KH1hikaMZoY2opNVLjWqAShzSczkpJPGNjoIWCEx83M5BdvtTteEIYyBDZHGuj7g
	HBy9VIHKOGBzHbtA3dFGidBJ+WvfSUOVn/EQS8VYmsNARDDCvMRueLyfDmjgUOuIohg2iztvTDh52
	ol4ZJx7w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wviVQ-00000008xfA-0dyc;
	Sun, 16 Aug 2026 21:35:00 +0000
Date: Sun, 16 Aug 2026 22:34:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Guru Das Srinagesh <linux@gurudas.dev>
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
Message-ID: <aoItA_ktl04qmhEb@casper.infradead.org>
References: <20260816-minmax-in-range-incl-v2-0-766f737dd6bf@gurudas.dev>
 <20260816-minmax-in-range-incl-v2-1-766f737dd6bf@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816-minmax-in-range-incl-v2-1-766f737dd6bf@gurudas.dev>

On Sun, Aug 16, 2026 at 12:26:20PM -0700, Guru Das Srinagesh wrote:
> +++ b/include/linux/minmax.h
> @@ -299,6 +299,25 @@ static inline bool in_range32(u32 val, u32 start, u32 len)
>  	((sizeof(start) | sizeof(len) | sizeof(val)) <= sizeof(u32) ?	\
>  		in_range32(val, start, len) : in_range64(val, start, len))
>  
> +#define __in_range_inclusive(val, start, end, uval, ustart, uend) ({	\
> +	typeof(val) uval = (val);					\
> +	typeof(start) ustart = (start);					\
> +	typeof(end) uend = (end);					\
> +	uval >= ustart && uval <= uend;					\

By convention, 'end' is used for exclusive ranges while 'max' is used
for inclusive ranges.

Also, this seems completely wrong.  How do you think this is unsigned
comparisons?  I think you'd do better to follow the example of
in_range() much more closely.

ie this is AI slop.  Please learn how C works, and write the code
yourself.  Use the AI to check your work, not do it for you, because it
leads to people wasting their time trying to manipulate you into
manipulating your AI to produce good code.  That's not a good thing.
