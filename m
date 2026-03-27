Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8D3DD52B
	for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608286; cv=none; b=uNY7kPbmR6qxOWtd0lD8IfTmpCKp6raqjVPQy5v90NQolDn93WqUrJF5f/hwQ0DArrsW2dPaRMxx3jdx7NA31Ye0GcSr4SO9M99/1xTvDcKvqLNgyzXQE4DcLwapd/JkVFzshmbs8VXeL4oo9GIwraj1kYWqCb+9KGW0o8wLmHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608286; c=relaxed/simple;
	bh=mezQjQgqtKWQGp4OqQlCmAlOrGB+fkAeEhovEMvvX2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEsfkTGh63Sd3+xFc3lVxExD8WVT+X0c5sb06bzpHjgFYk345YMdxjVN8JUM6joujc58eKI7GRL1tFDuweMK7XbK6Q7kPsBw8QpcRU7C41tY9E+ykrvVb0wAcMNAWuBrS1ApbeZJUK/R3y3iMtVhyShl0TDqonmT/eAs/3fg8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dda1xwTb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dda1xwTb"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so19839715e9.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 03:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774608282; x=1775213082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuyCDrZf8JgnLVWHP4AEX3ucz7Ui9ombrYWiQNzQTD4=;
        b=dda1xwTbNJAbUksfQfvZ85o2n5pRMK5btk/wazDPM6ZkeWHp7EDy5cW81E6yk4/vse
         JfxDqFBLChMZcnU3sADNlXttV68/t5ON5R1M9Bt30B3ydg8rFB4r6kMv95rWZXcjLlPo
         SojQYUAL0yhUT+TWpHN5pf8opp9m7liSbc7VvL38adBSnphH6VTF73uysSzvvmGMCw4R
         Hq2R91yMrwDRCh5i6hsRfY4/1PNyyvq/s5JZgysqQT8pTzhjE8uboRPTLitbAEWaMMZw
         4ULT+GmQzYv3ndNzpeVdFgOoSK2IEFHwnIWRMcKBlEWRr0LlsarCNwlnfTUf6Hb+nK9b
         p03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774608282; x=1775213082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuyCDrZf8JgnLVWHP4AEX3ucz7Ui9ombrYWiQNzQTD4=;
        b=ZHN1NyCDuXA3a2vEmUh7zWpYIk5f77MgCd44N9fhuendN7NXkv3n5gJb8FOnR3szeF
         ciahc99qTniv5q/cgvD06sjC9EF0qvZOCe0vYV62otTggqWccMGwgFAZV10ZcyyhcNq4
         jH4KYsZGnxTfjyzBQ/m0OYXnIxKtJKAkGNcHyg9DEw72uIE0mM92rvycynkpmYyt51CE
         uiKgtIOEt4NdAmXdyNvNWzCzdqc2j7LWm1x6Icq8jWqg/+6xEDNK/cE7v9JvQQv9gVQI
         8WZyj9d+Yi2GebO8G+TM9AAFGnQ2S2fMESt3U7/fXUTSKOlapFsDIFyHKH6UJPXq2tcU
         x3lA==
X-Forwarded-Encrypted: i=1; AJvYcCVM5l/X12tWdFMC21UQ97t0U7/b6fPnuHuODMrpWG5yxlPecYB86Xr3i/sNrmoZ29jMgX6Y8zVhP/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygRHcNHcCgDbaf1h/lbSfBd0WSAy1VGaN1nYAMkwT1WHDSIVD5
	dZU70UixGSCie3fNsbbNKWF7dbb7dKRIjS3pC7NhvAiT2HXFve0bsBSy
X-Gm-Gg: ATEYQzym2ga0Q0sev2a5isocTrFw1zb7WVpfp02rVYIX1/RoqMXFy411bd7Vvf3u3iK
	q6UXOBPp+rDOdDi0D/1zq4o2u4Bm/SzQAE6ToNOMLn0dTTZ3XkyZUHjIKZwYZicSuHq+iw1yuWU
	c9x2CtXrK14OQP4xavdSjPi1l1Cud5B/etOILkLiZFEemG+ri0S4QQKIMMW7H1V29GvlVUkS+rz
	PdlE2GMri6/gxShsYRJY34YLJ0YPCQ4Vx05TnLYCv56a/KzBuMWts63oLWoWruNR210v5YVeEpY
	oRfvJ6m/i+VIvnXFupaUrhvLu0uu8niG7bl2tPGXIPYhxk2Aiv7FzpIVClhNuKvYstohTrRjhQE
	TvVepCghii1w7KpbDbOJgOF/HRZanfOgo9eujd2PY9iTPwZGVyhF0OfkocwuRYj0kZ8fcjei2j8
	s6fnrK489yL0Kgq7PAt7/rE2WGWQoynxAfsk7yrWJUOjCkId5fCp1uR3qFW5JsqoTD
X-Received: by 2002:a05:600c:8b77:b0:486:ffa3:584 with SMTP id 5b1f17b1804b1-48727f17035mr29213475e9.15.1774608281999;
        Fri, 27 Mar 2026 03:44:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872712b3ebsm12365945e9.19.2026.03.27.03.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 03:44:41 -0700 (PDT)
Date: Fri, 27 Mar 2026 10:44:40 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, rodrigo.alencar@analog.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v9 2/9] lib: vsprintf: export simple_strntoull() in a
 safe prototype
Message-ID: <20260327104440.079343c9@pumpkin>
In-Reply-To: <acZLHAT5qJyjKTsp@ashevche-desk.local>
References: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
	<20260320-adf41513-iio-driver-v9-2-132f0d076374@analog.com>
	<acZDneLrIPOmU5ci@pathway.suse.cz>
	<acZLHAT5qJyjKTsp@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 11:17:16 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Mar 27, 2026 at 09:45:17AM +0100, Petr Mladek wrote:
> > On Fri 2026-03-20 16:27:27, Rodrigo Alencar via B4 Relay wrote:  
> 
> ...
> 
> > > +extern ssize_t __must_check simple_strntoull(const char *startp, const char **endp,
> > > +					     unsigned int base, size_t max_chars,
> > > +					     unsigned long long *res);  
> > 
> > Sigh, naming is hard. I personally find it a bit confusing that the
> > name is too similar to the unsafe API.
> > 
> > IMHO, the semantic of the new API is closer to kstrtoull().
> > It just limits the size, so I would call it kstrntoull().  
> 
> It's not. kstrto*() quite strict about the input, this one is actually relaxed
> variant, so I wouldn't mix these two groups.
> 
> > Also I would use int as the return parameter, see below.  
> 
> ...
> 
> TBH, I am skeptical about this approach. My main objection is max_chars
> parameter. If we want to limit the input strictly to the given number of
> characters, we have to copy the string and then just use kstrto*() in a normal
> way. The whole idea of that parameter is to be able to parse the fractional
> part of the float number as 'iiiii.fffff', where 'i' is for integer part, and
> 'f' for the fractional. Since we have *endp, we may simply check that.
> 
> In case if we want to parse only, say, 6 digits and input is longer there are
> a few options (in my personal preferences, the first is the better):
> - consider the input invalid
> - parse it as is up to the maximum and then do ceil() or floor() on top of that
> - copy only necessary amount of the (sub)string and parse that.

Isn't there a bigger problem?
If you want a max of 6 digits you need to correctly parse 3.1 3.159265
3.159256358979 3.0001 3.000159 3.00015926535 3.000100 (etc).
That seems to always require checking the length and then multiply/divide
by 10.

Then there is 'round to even' which rounds these two in opposite directions:
   4.500000000000000000000000000000000000000000000000000
   4.500000000000000000000000000000000000000000000000001

I suspect you really want a completely different function for reading
fractional parts of floating point numbers.
It isn't as though the actual digit conversion is hard.

> 
> The problem with precision is that we need to also consider floor() or ceil()
> and I don't think this should be burden of the library as it's individual
> preference of each of the callers (users). At least for the starter, we will
> see if it's only one approach is used, we may incorporate it into the library
> code.
> 
> The easiest way out is to just consider the input invalid if it overflows the
> given type (s32 or s64).
> 
> But we need to have an agreement what will be the representation of the
> fixed-width float numbers in the kernel? Currently IIO uses
> 	struct float // name is crafted for simplicity
> 	{
> 		int integer;
> 		int fraction;
> 	}
> 
> This parser wants AFAIU to have at the end of the day something like
> 
> 	struct float
> 	{
> 		s64 integer;
> 		s64 fraction;
> 	}
> 
> but also wants to have the fraction part be limited in some cases to s32
> or so:
> 
> 	struct float
> 	{
> 		s64 integer;
> 		s32 fraction; // precision may be lost if input is longer
> 	}

Are those 'fraction' counts of (say) 10^-6 (like times in seconds+usecs)
or true binary values where the value could be treated as a u64 (or u128)
for addition and subtraction.
So parse the latter you don't need to know the length
(and it can be converted the to former by multiplying by 10^6).

	David

> 
> Maybe we want to have kstrtof32() and kstrtof64() for these two cases?
> 
> With that we will always consider the fraction part as 32- or 64-bit,
> imply floor() on the fraction for the sake of simplicity and require
> it to be NUL-terminated with possible trailing '\n'.
> 

