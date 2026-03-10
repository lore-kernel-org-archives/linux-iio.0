Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981C36D9F9
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142258; cv=none; b=G5Be4bwDxsaQWpRCVjTRb3CEVw3yD2tsw87H4RrgvLA8S7I6ZqBjkxzeIXWQ/c1B57SPK8M8YskMsZO0FYeXsCetmKzSh8mg9ZpfJRxt0kYJaqA+1bHafL1zk7A+0eAr2ytOhuUpGNZ6b8fBvb+YGPrRvrGZkUrq2uY3o1+xQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142258; c=relaxed/simple;
	bh=t/29dTDs0K0l0JbyYm/bLv39xk1/Up9KxJ8JC9zOgOw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B91MsgNF0L7H+5YgOA2ji9FX5pLcxrffbfvyx+GcJjAg+UV03ya4SYHOj/tvHyaV3/9o/2uIoq87RULeyR0W+Yw53N46OGYUG/nntqWzqxgRW5dT40HWa5ii5oGkNmrKXtgvnTir9gfTv3+9a6UMpufXA81vGrfP+9lPXQCz+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI2U5MEj; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI2U5MEj"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899f5d337f7so103076386d6.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773142256; x=1773747056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqIK390eO2wsJV7u11wn01ICkQTgnpyZlp3AO0Ym8Jk=;
        b=cI2U5MEjrI0h/zRa7oQiUuAp9i8ODQXioduIxz2YQSxCwYfcCOun728Kk9WWqsR+O6
         9XcnvAqibSzsnDxS4xlb4ulAjD01+zJJNNyXbFfiB/IhpfOCC+CIk7Lr5sHCROp+x3FD
         8LJjF54Viss37WSPBx4B0ezaW2SVJGpV9AKMEKxVhChftyUArB0BPXSA1v/pKm90r1ry
         7sffgufnRoooiaUWxJJ5L1CGS7iap7EvzwXAAMN5Eby8vo1E8Lc9j71+RGAG5Sm7F5Po
         nRsLd1yRvxfO0Go+RjV5Wcwk6zz3tOhh2vQmB5kIHiGCOttjrQQZkTrtzt2KkCZv4tBh
         HccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773142256; x=1773747056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqIK390eO2wsJV7u11wn01ICkQTgnpyZlp3AO0Ym8Jk=;
        b=w2xmy59/aCcGP6ZZ2TZNotAszgyFOCAl1AyNmIuvuXGkuyH9rXDBOysWXxb9/OzDFD
         k8KE61SZk52+sYDhXDOMwRBP0NDOsvThEuhRDm9vqStITJMAwZsUgL8YiRLN1ASoNh1F
         UqIUHUEPAmX6XemIF/K8jjVC4qL2U/MCGWmWr04fGFsPeCte2V/gofc3wwb/xiMnjtFa
         KOIoxzK4b5fuCE+XXu29DaRA0k8H4Mv9rOuCfZMY6nQ7xn0VIvN39RvrBDGOZzRhTUDg
         yVt4BqmTVXESv8Wasuy3oQDvhsGmogX2QvVc0jOjf5BuPJ5XP4Yoo13dOqw7UfUnYJSb
         0OIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8LFoBFAhLfPmQ7Mrcc3YWHvDxhI7BI24O3/ZRVmltNzzO/WzMhwDY76mr6u9lPEon19fzsMFaG8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz408UJOORT6YjmSn61ITVGAB8hK+ho0bPeBkm34Roq5EpaM+l
	wkL/Ax+yWlKYEXWCihqe+JvOFx9IshWkIYs6YQokysdGueYB8R+4yMNk
X-Gm-Gg: ATEYQzy72rcIo9YoApt+761WHfzh6odG7x5SRuoztJSfdpdR8wPYz6QFjxTrrty9oT0
	PrT3Bh/YBQvWIJK09CSkoaKQ9Qz5VxOkywc183YO4+V61Ca0+4N55OtFh5P3+KY6berZX2OZJtP
	TFU/Q3c4aUla5B2cg3XpvumUUGSqTvaAJfi3Cp926SZIUnv0TrVzfyobKgnq18TAbaR4MzBLjB2
	tqJjrtZYGQfaB4nrW2rj+LwJ6wGPY8E/hFwd8IolgOM9vnwSYxWj/k/VlXqu0MFKoH8FIlrWrJw
	w0YDZVQIUg+hb0vd5GqEZJE0njnr3XsXwHueI6bqzl6FmroBVwMScUwrzOaJlXZsqoFropAmZn9
	24Q1FwHEbQcpsyXk2RupVierj624eJS3wA/WqR1WRxGVWpN850EgxdwR9dnZF9Dz5o4yNkSFDMa
	5goHzBMhjI8XNIgmmUdth6GhxWRnnrzXyGDOCvbrk4lKOPznUbUNFilWpnwttVkf4G4eI47b+/e
	BoTFsEIWol/6ZyjzzjIjk4p74BYn9NNwxdm9pCJB3LwPVaHUEA=
X-Received: by 2002:a05:6214:2421:b0:899:aa05:385c with SMTP id 6a1803df08f44-89a57bead24mr39721226d6.4.1773142255873;
        Tue, 10 Mar 2026 04:30:55 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a31cfcsm18833236d6.13.2026.03.10.04.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:30:55 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 10 Mar 2026 11:30:48 +0000
To: David Laight <david.laight.linux@gmail.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 02/10] lib: kstrtox: add kstrntoull() helper
Message-ID: <lo35u6hrakhlj6bi3wanuyvosdpvm3p773hbuz6pjgljwdjle3@hsvlhffnn2ig>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
 <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
 <20260304101655.620df7ee@pumpkin>
 <6et7t3o6fjiinpkvpsmoxjhp6edn23dgclbulaxg5paccdotgp@amtf33da5dhf>
 <zhjkurpwbuvirh3k4a4c3lfeu5semu4rjszvej4hnx7scjyk2q@v4r7oqexwsjl>
 <20260310105027.08b93187@pumpkin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310105027.08b93187@pumpkin>

On 26/03/10 10:50AM, David Laight wrote:
> On Tue, 10 Mar 2026 09:26:11 +0000
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> 
> > On 26/03/04 11:41AM, Rodrigo Alencar wrote:
> > > On 26/03/04 10:16AM, David Laight wrote:  
> > > > On Tue, 03 Mar 2026 13:27:07 +0000
> > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > >   
> > > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > > 
> > > > > Add kstrntoull() function, which converts a string to an ULL with a max
> > > > > character limit. The function is an alternative integer parsing function
> > > > > that does not require a null-terminated string. It becomes a better option
> > > > > over simple_strtoull() or kstrtoull() when parsing integers from a buffer
> > > > > with custom delimiters without having to create temporary copies.
> > > > > The function is consumed inside the implementation _kstrtoull(),
> > > > > promoting reuse.  
> > > > 
> > > > If you've got custom delimiters use a function that returns a pointer
> > > > to the character that terminated the conversion.
> > > > They save you having to find the delimiter as well as taking a copy.  
> > > 
> > > understood, how about this prototype then:
> > > 
> > > const char __must_check *kstrntoull(const char *s, unsigned int base,
> > > 				    unsigned long long *res, size_t max_chars); 
> > > 
> > > to be used like:
> > > 
> > > 	end = kstrntoull(s, base, &res, INT_MAX);
> > > 	if (IS_ERR(end)) {
> > > 		/* return or handle error */
> > > 		return PTR_ERR(end);
> > > 	}  
> > 
> > Hi David,
> > 
> > Do you have any other feedback? the function prototype can also be changed as
> > follows:
> > 
> > int __must_check *kstrntoull(const char *s, const char **endp, unsigned int base,
> > 			     unsigned long long *res, size_t max_chars);
> > 
> > so that a pointer to the terminated character is passes as a parameter.
> > which one would be the preference?
> > 
> 
> I really don't see why you need to add 'yet another' function for parsing
> integers.
> Having to pre-scan the string for a separator seems just wrong.

there is no pre-scanning, the function stops at a non-digit character or
at the request amount of chars. That behavior is already implemented by
the internal parsing functions. The function is just exposing this.

> The userspace strtoul() family do everything quite nicely apart from
> overflow/limit checking.
> There are a few options for overflow:
> - Ignore it, this used to be what posix/sus allowed for command lines.

That is the whole point why simple_strtoull() is not recommended, being
flagged by checkpatch.

One thing to note is that kstrtoull() does check for overflows, but
it forces you to comply with a termination character. In the case you
have the integer in a string with separators, you would have to create
temporary copies of the string... and that is, in fact, not effective,
because it requires pre-scanning and copying, hence the existance of
simple_strtoull().

But indeed, I could use simple_strtoull(), ignore this and be done
with it.

> - Saturate.
> - Return a pointer to the digit that makes the value too big as the
>   termination character - since the code will typically expect one
>   of ",.:-" this will be a syntax error.

There would not be a  way to do that if granular control of the
parsing is not provided.
 
> It might be worth adding a parameter for the maximum value.
> Then you only need one real function for 32bit and 64bit values.

Not seeing a reason for that, as range limits can be checked after
the parsing. Here we just make sure that the parsed value fits in
64-bits.

> But you also really want the use the function return value for the
> converted number (for all sorts of reasons).

-- 
Kind regards,

Rodrigo Alencar
