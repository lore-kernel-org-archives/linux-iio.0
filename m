Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59A48C8BD;
	Tue,  5 May 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999363; cv=none; b=ga8cAEobIcr61Ry87Gq7yRgiv4qsjm08M191UsKZmMC1Rs1jNEptOG8gOj6ONfFsNtpK4Etgy74KwK+gBLCTs8Gf+9vjL91/0M70hZ9t/ktBDW6DS1s3ALcXs0Up0rDo3WYZbAZAp59thQ1ioD6uVHZ+6G8u01z2MRVgTBE79e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999363; c=relaxed/simple;
	bh=j5ysOc6zV4I9/lqIB0/kKQe/KsuyrTSbKhL3XC3llEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShMze9ChhvexubMa7ItELZTP8SsP8ej+bxIs39cIFQGsjC979JLrgrn8zl4bN673NR4Y6hQmbQzx9nIx58vdsCwa63Ai6xDiawS1leofcY+JrCsQuLpJ0TIfK/152Nqe3QYOCqFr6yNOlTQ7kUUfbh4mzXMcI2rjwJYFdDA2QYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8LjI1N6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8LjI1N6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FEEC2BCB4;
	Tue,  5 May 2026 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777999363;
	bh=j5ysOc6zV4I9/lqIB0/kKQe/KsuyrTSbKhL3XC3llEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J8LjI1N6VWmKbHH3fj98uYgF/OcqSe/2BWVQPE/hxE/Ayo8bIq/q3OX7xo0vOrY4R
	 a7W0TAnwIqBHUFgPlCZ2U8jYC+69rv5HyHK89AKPJJYbbDvjOAOgYHCXpU78J63UXC
	 7FOywL1Zwj2NyC8gagrRFuQE/fFHRruh0TIm1hLRG6MGaWfkzw62XxSvVJMUCYkfWe
	 aWK8yQZU85MD+a9TwgjG18ojlQnYVXsCnVe2pwg1sY5jXCR+ZDhjey/Oib0/CAFnGr
	 8WxqiYjWBxXzzgNqBUjbArqg7K3yOFmEyY1YGCIz8dLHo4oMjpKirxsCUIZp3yQr1T
	 mZFgosUKsFkgA==
Date: Tue, 5 May 2026 17:42:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v10 05/11] iio: core: add decimal value formatting into
 64-bit value
Message-ID: <20260505174230.5a5020fb@jic23-huawei>
In-Reply-To: <keeskqikjulxcgc36zpzzvqw2osvm437hlchgcuovh5gkvmdr3@ishisbiujrrn>
References: <20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com>
	<20260415-adf41513-iio-driver-v10-5-df61046d5457@analog.com>
	<keeskqikjulxcgc36zpzzvqw2osvm437hlchgcuovh5gkvmdr3@ishisbiujrrn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 May 2026 11:42:38 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/04/15 10:51AM, Rodrigo Alencar wrote:
> > Create new format types for iio values (IIO_VAL_DECIMAL64_*), which
> > defines the representation of fixed decimal point values into a single
> > 64-bit number. This new format increases the range of represented values,
> > allowing for integer parts greater than 2^32, as bits are not "wasted"
> > in the fractional part, which can be seen in IIO_VAL_INT_PLUS_MICRO and
> > IIO_VAL_INT_PLUS_NANO. Helper macros are created to compose and decompose
> > 64-bit decimals into integer values used in IIO formatting interfaces,
> > which creates consistency and avoid error-prone manual assignments when
> > using wordpart macros. When doing the parsing, kstrtodec64() is used with
> > the scale defined by the specific decimal format type.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> 
> ...
> 
> > --- a/include/linux/iio/types.h
> > +++ b/include/linux/iio/types.h
> > @@ -7,6 +7,7 @@
> >  #ifndef _IIO_TYPES_H_
> >  #define _IIO_TYPES_H_
> >  
> > +#include <linux/wordpart.h>
> >  #include <uapi/linux/iio/types.h>
> >  
> >  enum iio_event_info {
> > @@ -34,6 +35,38 @@ enum iio_event_info {
> >  #define IIO_VAL_FRACTIONAL_LOG2 11
> >  #define IIO_VAL_CHAR 12
> >  
> > +#define IIO_VAL_DECIMAL64_BASE		100
> > +#define IIO_VAL_DECIMAL64_MILLI		(IIO_VAL_DECIMAL64_BASE + 3)
> > +#define IIO_VAL_DECIMAL64_MICRO		(IIO_VAL_DECIMAL64_BASE + 6)
> > +#define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
> > +#define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
> > +
> > +#define iio_val_s64_compose(_val0, _val1)				\
> > +	({ (s64)((((u64)(_val1)) << 32) | (u32)(_val0)); })
> > +
> > +#define iio_val_s64_from_array(_vals)					\
> > +	({								\
> > +		const int *_arr = (const int *)(_vals);			\
> > +		s64 _dec64 = iio_val_s64_compose(_arr[0], _arr[1]);	\
> > +									\
> > +		_dec64;							\
> > +	})
> > +
> > +#define iio_val_s64_decompose(_dec64, _val0, _val1)			\
> > +	do {								\
> > +		s64 _tmp64 = (s64)(_dec64);				\
> > +									\
> > +		*(_val0) = lower_32_bits(_tmp64);			\
> > +		*(_val1) = upper_32_bits(_tmp64);			\
> > +	} while (0)
> > +
> > +#define iio_val_s64_array_populate(_dec64, _vals)			\
> > +	do {								\
> > +		int *_arr = (int *)(_vals);				\
> > +									\
> > +		iio_val_s64_decompose((_dec64), &_arr[0], &_arr[1]);	\
> > +	} while (0)  
> 
> Hi Jonathan,
> 
> Are those macros ok? in terms of where they are declared or whether they
> should be static inline functions? any preferences?

My preference would be for static inline functions rather than macros given
all the types are known here.

> 
> > +
> >  enum iio_available_type {
> >  	IIO_AVAIL_LIST,
> >  	IIO_AVAIL_RANGE,
> > 
> > -- 
> > 2.43.0
> >   
> 

