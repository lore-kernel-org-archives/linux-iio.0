Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA83EEBB;
	Sat, 25 Apr 2026 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777131619; cv=none; b=s90I5m8Mn7KIY0UejyqHMWxPLtG9XprffY+UCNbIeiqkrUflyoT/dDVcPOCSLO5cuA++34LewS+YiFgQ+EWlB8Ka279C8eCtTLs3mZj3anCl2wTCoo3G3ty1wg3t9E5zuQU0ksU2KngN5KoDUXLDrfS50lBBYHD94Y0kILu4QOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777131619; c=relaxed/simple;
	bh=VzTg/Xy1t4oLKHrGQj6YqVosIbUPBj9J66CgenmVdEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0BWv1xPbZhmsFAcwzVx9oY1rP8hmUGqTS6L1z4vB7eCqzmIlw7yfqVCYvebOO8NyTeyJ4XMz6MCjw4onz4MPhr5n7xjXHR3FhGAXxwbXLK1V/GOvk6+DlCjczjSzxCF4o512taMDvexEPAyY0ZNX39aSp6nEZK1T0JzNl1Megs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L851jsn8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L851jsn8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776E4C2BCB0;
	Sat, 25 Apr 2026 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777131618;
	bh=VzTg/Xy1t4oLKHrGQj6YqVosIbUPBj9J66CgenmVdEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L851jsn8pOZSp/E2hqdDJS0/YrI/bFbBSM4bvvOO8jx5WPYuKqxHjZazAyKgUwljg
	 NMi9UYlBiOdgJgLDiAceIBo8HX82AxMLsF7V1POsmNSqSdcZmvGw/EcC7kIPGCM8TP
	 gnxsyyvPkY42v0xeffrEVGmRVF1Fn3J3Aq22iUBvRndHldtEYtk+B0DdyGFxTmfa87
	 c1mzDIm0vVD26tTV9Wrv4ockpGBXfXOACJ41gMOqv5yxv202ZNKTmkLs4hr+bvPcuR
	 aymw8rmfPJq4q2SJ+9T6vaAcvlP+qvUD3bsuwNDlFllXwBDHyzte+f5EYvptmj7GC2
	 rqe8edXzjKHMg==
Date: Sat, 25 Apr 2026 16:40:06 +0100
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
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, David
 Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v10 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <20260425164006.17b75faf@jic23-huawei>
In-Reply-To: <mhfgedq2t5lqtu6535ahdmpbvib2xzp2hmyt7ezflnf52r56jh@ze6tee7vpij3>
References: <20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com>
	<20260415-adf41513-iio-driver-v10-2-df61046d5457@analog.com>
	<mhfgedq2t5lqtu6535ahdmpbvib2xzp2hmyt7ezflnf52r56jh@ze6tee7vpij3>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 09:36:20 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/04/15 10:51AM, Rodrigo Alencar wrote:
> > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > precision). After the decimal point, digits beyond the specified scale
> > are ignored.  
> 
> ...
> 
> > +static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> > +{
> > +	u64 _res = 0, _frac = 0;
> > +	unsigned int rv;
> > +
> > +	if (scale > 19) /* log10(2^64) = 19.26 */
> > +		return -EINVAL;
> > +
> > +	if (*s != '.') {
> > +		rv = _parse_integer(s, 10, &_res);
> > +		if (rv & KSTRTOX_OVERFLOW)
> > +			return -ERANGE;
> > +		if (rv == 0)
> > +			return -EINVAL;
> > +		s += rv;
> > +	}
> > +
> > +	if (*s == '.' && scale) {
> > +		s++; /* skip decimal point */
> > +		rv = _parse_integer_limit(s, 10, &_frac, scale);
> > +		if (rv & KSTRTOX_OVERFLOW)
> > +			return -ERANGE;
> > +		if (rv == 0)
> > +			return -EINVAL;
> > +		s += rv;
> > +		if (rv < scale)
> > +			_frac *= int_pow(10, scale - rv);
> > +		while (isdigit(*s)) /* truncate */
> > +			s++;
> > +	}
> > +
> > +	if (*s == '\n')
> > +		s++;
> > +	if (*s)
> > +		return -EINVAL;
> > +
> > +	if (check_mul_overflow(_res, int_pow(10, scale), &_res) ||
> > +	    check_add_overflow(_res, _frac, &_res))
> > +		return -ERANGE;
> > +
> > +	*res = _res;
> > +	return 0;
> > +}  
> 
> I have an alternative (slightly more complex) implementation of this function
> that handles E notation. I find this particularly handy when writting big
> values like 25 GHz when the ABI is defined in Hz, so instead of writing
> 25000000000, one can just use 25e9, or 2.5e10. I found that my python code
> was printing big floating point values or really small ones using E notation
> and that was giving me -EINVAL, so I had to adjust formatting when generating
> the string input to the file. No big deal, and we would not need this here,
> but if maintainers find this useful I could add it into a v11 of this series.
> 

I'd rather we didn't slow this one down. However I'm waiting on some tags
on this patch from folk who are more familiar with these parsers than
I am.  Given discussion, Andy or David Laight perhaps?
+CC David - please make sure to include folk who have been active
in discussion of earlier versions to decrease chance they miss the new
one.

Maybe start a discussion about whether adding e notation as a separate
thread after this has merged?

Jonathan


