Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8580E55A
	for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624635; cv=none; b=OOk74Sx1WdGa6Ry2FAKJKykEF/DgvTxIfbbz5Cf6ObWDacpTrXI9ic9ME3UCW70yvtf49do/+pnWRUeFU8faQ5gx1p4kq62gTe/TVAIFoVzBKNOqCOMQXj2j6MA/VBUJxAp/28TrgUmBg+I5WgsMtfGcU/u5gqtEhtcxv+ZTwdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624635; c=relaxed/simple;
	bh=YhMY8m8lhMloOdkQJ/lFVmybXo6krCBolUEHpLOX6vo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJpu36ov8VpbaZ19d7c9f2Z88TDjHbmiNeXnpTWhkVpKbDlmDgPOxGWQ0u0lqWaHRvSKJKayadixUumXzybdBbcON1DMehF/m8tvwCIzpf+00+SjO9aKVl62Q8HsvCIVCzZC9lebj2swAjC49dzEoQce6zNGDSwK1zH36Et1Dew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuRefvmF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuRefvmF"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9382e59c0eso365318266b.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774624632; x=1775229432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gUuubS1+3njuAPGTqHH6+3IW1O4jcFu6Ae6+Wh76UDs=;
        b=MuRefvmFC6lNyhIodxUchXClrn0ez7PkcDlif1BIOAfrYLV/eHpg9yLMaWtKEoVJHE
         ed1KhaDxJlQ99qqLcmccZYgLEIcetf67o4wUc/7rQXFK5RhKdjyG95DjhbxUAYZQaqaQ
         DgcDCaHOZ+90dntL42/U4TiMlQF0XT3/LeHFrYBLErOu0T3n8LsSBjJlQARSA+dcVNQF
         1vtTjJYJ4DIIeEh7lZQ2Ie0LE9nrJwu4omDzLY4Rpy5NHBzmtMGvuXgeYLxuOyp73okp
         34qpzljvLv3ajr+sd9/4yyJFl4mjE5AigmnMJmApbs5wYLMeWbrLjDREkrQK4885wZUF
         FizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774624632; x=1775229432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUuubS1+3njuAPGTqHH6+3IW1O4jcFu6Ae6+Wh76UDs=;
        b=ERx4lBqL44fOhMerid6vzC7U5aP71NY6k3vsRHxGAZ65YnL1QBi7/sKcNlcIxgeS9C
         jiQsKqnjoQMxRjduY4p0PQzU9IrCbxDHPP4Vi1oEEV2E2okfCtmeJ4GewOXps2GQoXTw
         m2F+R55xYcNMWaUP10rnu4EaBb7I7NPI8XWkBCJqKxt6OcULzaC2n6LMHlrN6JlJQKxh
         C/Eqx6EHqAbs6DOXrgcblHU7htj59zvHI7edpL07FiELSPVl6cVnTgKJ2xgY/KB0MVxu
         EToZuapH1y8teg69Mm/LPLOgLAAuuyvdRlLZoB6eM4uedbFTNB6gSxifRkYomWfoBkLE
         vg1g==
X-Forwarded-Encrypted: i=1; AJvYcCXeU24bI/ReJmFxPdLoRQGD32YfqMtoNgBcU9HHrvgTfKPO7msKJRJH01c/UDFJLdL6SR64g2jyvCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1t255b9D7JQiKNgwW4IMBJRLAAMZRMsf6+mux8WWGHQ11N7jo
	zVT59zNkar/M7OXRuX54XMmIggEGZpRFjGD4MzauFC4SHlQfTORGF+WZ
X-Gm-Gg: ATEYQzxroPT9F4x+EhX1A7BZ2xEoI0V6y8RcS0OwRrBHnm3PgYKBhC2bBp/8zcEGdwd
	R9SEdN8WDS5qmGNe7kpCM2OtsdLoFfrhmSz251HDUYiCL89TkccledC5fH2zp95vulHzMQOdslr
	s1rfM9LICsCAyGx3ApRzW/fRl6eHmYR66wGUvzlCf/JIPahsBpRqhwLHe0RjlbX74srqdp3WuzW
	3CAmTuEfMNY6OAAZ9GJ9wCSOFdsc52VjWoDPpD1fXtjS1T68ITF/bkRNXkppakmEsCTLCTpYMLK
	mC1RQx0RUaiYn53CJRd8Jw/zmp4J1ECGAfw4dUr2QE8gf4Gl2IfhBGTMkFQqY+b1kXefyOEHCO1
	wgeSqNcuDlKZGiZnXlem0y/4GiANw++P+IdvhMfWou+uK9p0gPCgSTirOccrupqj6dqeVYu3HdC
	KWyVXiWKDQtLiUBTcDJuxwiUySw1fLyA7WjAMwcL0TBcqhgu4JVnXY8pdAEeWK+iV6vfMs2HTpu
	ci0incNPVN9Ne972wG6nHOG4mTJU4738bhDym9gD0kQ/ftLTm8=
X-Received: by 2002:a17:907:944c:b0:b98:45fc:241d with SMTP id a640c23a62f3a-b9b507b0b37mr184899266b.37.1774624631951;
        Fri, 27 Mar 2026 08:17:11 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b20219193sm265402866b.9.2026.03.27.08.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 08:17:11 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 27 Mar 2026 15:17:05 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, rodrigo.alencar@analog.com, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v9 2/9] lib: vsprintf: export simple_strntoull() in a
 safe prototype
Message-ID: <x34d7jz7be4ommjh6efx5mcq5pbpellykwuyrqayr4ske3lywf@wh46mu3anmcz>
References: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
 <20260320-adf41513-iio-driver-v9-2-132f0d076374@analog.com>
 <acZDneLrIPOmU5ci@pathway.suse.cz>
 <acZLHAT5qJyjKTsp@ashevche-desk.local>
 <4uijfg4efzaapu3esobez55hfwqzszwagpeb4lxej2ybmifu76@s3c57fmnsme6>
 <acZaGUV0MwuHNDru@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acZaGUV0MwuHNDru@ashevche-desk.local>

On 26/03/27 12:21PM, Andy Shevchenko wrote:
> On Fri, Mar 27, 2026 at 10:11:56AM +0000, Rodrigo Alencar wrote:
> > On 26/03/27 11:17AM, Andy Shevchenko wrote:
> > > On Fri, Mar 27, 2026 at 09:45:17AM +0100, Petr Mladek wrote:
> > > > On Fri 2026-03-20 16:27:27, Rodrigo Alencar via B4 Relay wrote:
> 
> ...
> 
> > > > > +extern ssize_t __must_check simple_strntoull(const char *startp, const char **endp,
> > > > > +					     unsigned int base, size_t max_chars,
> > > > > +					     unsigned long long *res);
> > > > 
> > > > Sigh, naming is hard. I personally find it a bit confusing that the
> > > > name is too similar to the unsafe API.
> > > > 
> > > > IMHO, the semantic of the new API is closer to kstrtoull().
> > > > It just limits the size, so I would call it kstrntoull().
> > > 
> > > It's not. kstrto*() quite strict about the input, this one is actually relaxed
> > > variant, so I wouldn't mix these two groups.
> > > 
> > > > Also I would use int as the return parameter, see below.
> 
> ...
> 
> > > TBH, I am skeptical about this approach. My main objection is max_chars
> > > parameter. If we want to limit the input strictly to the given number of
> > > characters, we have to copy the string and then just use kstrto*() in a normal
> > > way. The whole idea of that parameter is to be able to parse the fractional
> > > part of the float number as 'iiiii.fffff', where 'i' is for integer part, and
> > > 'f' for the fractional. Since we have *endp, we may simply check that.
> > 
> > A max_chars would not be only useful for that. It can prevent out-of-bounds
> > reads when the input isn't NUL-terminated (like buffers, file chunks,
> > network packets, memory-mapped data, ....). Even if there is a NUL later in
> > memory, a regular strtoull() function may consume characters that are outside
> > the field one intends to parse.
> 
> Okay, but is it the current case or just an attempt to solve the problem that
> doesn't exist (yet)?

The current case can be seen as such. Copying the string and use regular ksrto*()
requires an unecessary scan of string from the user side, which is something that
_parse_integer_limit() already does, mostly because it checks for digits and stops
at any non-digit character. In the IIO case, we also want control over the consumed
characters because there are weird terminations like "dB", so having an implementation
like this ends up with a cleaner sequence of steps. 

> > > In case if we want to parse only, say, 6 digits and input is longer there are
> > > a few options (in my personal preferences, the first is the better):
> > > - consider the input invalid
> > > - parse it as is up to the maximum and then do ceil() or floor() on top of that
> > > - copy only necessary amount of the (sub)string and parse that.
> > 
> > Yes, my use case is the fixed point parsing, but I suppose we are implementing
> > things here for reuse.
> 
> Yes, I'm full for reuse, but I want to have it balanced between complexity,
> existing use cases and possible reuse in the future.

Not seeing complexity here as in this case I am just exposing something
that already exists! No need for a completely different implementation.
I just want to get an agreement on the naming and interface prototype.

Bringing back the discussion again just because I suppose Petr havent even
seen the v8 of this patch series. If kstrtox.h is the right place for this,
kstrntoull() sounds like ideal. Specially because simple_strto*() is already
labeled as unsafe and kstrnto*() != kstrto*().

> > Also, the default behavior of the previous fixed point
> > parsing in IIO is flooring the result, which leads to the same result as
> > ignoring further digits.
> 
> Correct, I also lean to implying floor() (as you can read below).
> 
> > > The problem with precision is that we need to also consider floor() or ceil()
> > > and I don't think this should be burden of the library as it's individual
> > > preference of each of the callers (users). At least for the starter, we will
> > > see if it's only one approach is used, we may incorporate it into the library
> > > code.
> > > 
> > > The easiest way out is to just consider the input invalid if it overflows the
> > > given type (s32 or s64).
> > > 
> > > But we need to have an agreement what will be the representation of the
> > > fixed-width float numbers in the kernel? Currently IIO uses
> > > 	struct float // name is crafted for simplicity
> > > 	{
> > > 		int integer;
> > > 		int fraction;
> > > 	}
> > 
> > Yes, but to represent things like that, an assumption is made to the precision that
> > "fraction" carries.
> 
> Correct.
> 
> > > This parser wants AFAIU to have at the end of the day something like
> > > 
> > > 	struct float
> > > 	{
> > > 		s64 integer;
> > > 		s64 fraction;
> > > 	}
> > > 
> > > but also wants to have the fraction part be limited in some cases to s32
> > > or so:
> > > 
> > > 	struct float
> > > 	{
> > > 		s64 integer;
> > > 		s32 fraction; // precision may be lost if input is longer
> > > 	}
> > > 
> > > Maybe we want to have kstrtof32() and kstrtof64() for these two cases?
> > > 
> > > With that we will always consider the fraction part as 32- or 64-bit,
> > > imply floor() on the fraction for the sake of simplicity and require
> > > it to be NUL-terminated with possible trailing '\n'.
> > 
> > I think this is a good idea, but calling it float or fixed point itself
> > is a bit confusing as float often refers to the IEEE 754 standard and
> > fixed point types is often expressed in Q-format.
> 
> Yeah... I am lack of better naming.

decimals is the name, but they are often represented as:

	DECIMAL = INT * 10^X + FRAC

in a single 64-bit number, which would be fine for my end use case.
However IIO decimal fixed point parsing is out there for quite some time a
lot of drivers use that. The interface often relies on breaking parsed values
into an integer array (for standard attributes int val and int val2 are expected).

-- 
Kind regards,

Rodrigo Alencar
