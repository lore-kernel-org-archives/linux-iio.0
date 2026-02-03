Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF4396D0C
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110809; cv=none; b=DxFZXS6magpgkxsex0zxzkXg5WID2eovMpo5lYFb+kx/dWMza66m7Y9/dp/T4Ay6fMltdGpRYMgAqIwMv7YLn/RN6BVd7lPj7n6Qr4lE9fnCf8wH6zMjhK3/sKYtVVCdEId5L5WeicjSiBQ1mywnJzU4CYKwU3CH6PchA2AYcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110809; c=relaxed/simple;
	bh=zQIcFhLzEEVfpsSAYKxeP8WFD6JDPzhJjkOH75MBsj0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMoUf5fPRiEbO61O+kUJhfeBho756ToLT8JA1s367MFbB3rt10rC6gF4tpdhcAvpswJOahvRuRKE2fd3OltOEU3tpqx00oSKW//88MkVcAPRzFTsNV0IJybEXuCCgasEfA+Z0SIHaM0aP4vnpgvDryavUCa5AzDYXEqbMv6UO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CszI0hi0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CszI0hi0"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so57333615e9.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 01:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770110806; x=1770715606; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v8u3IwoMOrMqGo+Mwbf89Kdkxv+i1U2HP3cA+C8V8rM=;
        b=CszI0hi0akWQwhlXq1WfZsp9xDZjx8nGupVk2Dhq8140uSJj+SpEOvMaQF4buoj39q
         +Epe8D6iNMt7njDdlXM6L61TRQY7i7lyYppiBynsGbOjHcMy4Z8LSDEFydxsl39CgEKx
         S7a9BYpBUwovngDihUHOhX0u2CqFTFvErppY3ausyYe10ey5cWUjFrwQE6cI0hK4pRed
         knsW7Gxukn1z8C+++pqXpEPRdLgqMMTrLZXXjoR+HW3WBwSZWxQSb4Jxi35i4ZK/Gow1
         vmC+krwiFI3GhGHhA2xqf0u6L0nkFtGbL0dNSqm7HaRBQ7VxrJzdv2xokpgenQwjyhnF
         HrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770110806; x=1770715606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8u3IwoMOrMqGo+Mwbf89Kdkxv+i1U2HP3cA+C8V8rM=;
        b=sArAL3EKcRj6JQZROtzQJFK4kiSFBf/jrKu3X+Y0rRA9wSDQsoIyVxOCHUgwDq9KWo
         Ji0D0tu686vCk8W/dpr/n7lOmVS7oYD3jgd9WGqSnApzGf2RzXePV6XkVzWRV4VP9FK4
         rF9PdMkH9htqkNAN3S6PG9tVL4WLi9Xz6KbqFEvhof/cxeyZkBpN2H3Bq5+FVnpb8d0X
         VRXwldDAvpoZMjcyx76aSeWrDoDx1C2CPVFuIW5Bc0jXkNSIxAfWVjAbaCXPQ76qbFfd
         V9C1WJUIZZqewsnNUVpeZ6VtB/GPiS7XnG3GomGIwO/zyEkggx1ZMF5+T9cRVAiPgLYj
         rtgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/odPS1wAkHpn3vbLb6fuuDHaSc0tjNuRjcOKptsDn6Rb88Xl+/UkvimJ0hX9aXUfmswNlol1lbC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+18bpWzylQXdN3ogcSUla8/wdRgPPE/oE7gs2FT32Wxue7/f
	pmjAmaitjXzidW4QAE7OdD3u4/ADRgdRtr4Xc9+2D5flIbyU5LAhKwW9
X-Gm-Gg: AZuq6aIFO/Z5RoSwUoqTitPw/AjzLqGiSCg6lfQ2AgD1H2PTMXd5otJpLS93D4XrTqs
	KEad8/RzX001lDaiTDFMcUqrnFW+Wk5p2VNKeF7zJTS6N8kSfBRbYakFMEm5fwWWeGXxfB3tp9v
	ow1o/ilRwTF1PoEQRc7DdmJW0fljkHMqdsn2Mr6TTrD9WjoQd3JgF6RqcbwBa0kCC2fTRE0Y2Ss
	gvRvCTTl93brUfeOzKJIOLrZZ5eHZuAYdR6r0thlbqqZ/rZgyVnImugbvHtz4Y0xS9qrkE8XUqG
	R26a+lzBtJdrMPRqGajQ6ekaMJFFFMxF8NvD47jr0tJb1GU4kmJ8sD1ZjmK4PhvM2WNruhZToV9
	S48rkm7Qrf6AviKfaQ1kdyfvd1Mvyb/d/1HQIz81wwW4a135HQyVYcaSPJ5od/4C7OK8LV0OLv7
	IzeHzvCUEveRump7ZW3d3S8nu2qSD/+n9b6Tbv9hoEqEWAEyvjquBSpBFYfzfoWiZRTCa8+7Wcw
	OyR
X-Received: by 2002:a05:600c:3b23:b0:47e:e87f:4bba with SMTP id 5b1f17b1804b1-482db49e871mr191759345e9.29.1770110806001;
        Tue, 03 Feb 2026 01:26:46 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48305129321sm49396195e9.4.2026.02.03.01.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:26:45 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 3 Feb 2026 09:26:37 +0000
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <nzowa6uhnlcllceml2pqjk4so33kl3rf2jwu36eh3znnxug6ub@gfzafmi3m5re>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
 <20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
 <eb1d9b939f95888739ce4a70f516cec07393c6df.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb1d9b939f95888739ce4a70f516cec07393c6df.camel@gmail.com>

On 26/02/02 09:57AM, Nuno Sá wrote:
> On Fri, 2026-01-30 at 10:06 +0000, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> > to parse numbers from a string.
> > A helper function __iio_str_to_fixpoint64() replaces
> > __iio_str_to_fixpoint() implementation, extending its usage for
> > 64-bit fixed-point parsing.

...

> >  /**
> >   * __iio_str_to_fixpoint() - Parse a fixed-point number from a string
> >   * @str: The string to parse
> > @@ -895,63 +1026,43 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
> >  static int __iio_str_to_fixpoint(const char *str, int fract_mult,
> >  				 int *integer, int *fract, bool scale_db)
> >  {
> > -	int i = 0, f = 0;
> > -	bool integer_part = true, negative = false;
> > +	s64 integer64, fract64;
> > +	int ret;
> >  
> > -	if (fract_mult == 0) {
> > -		*fract = 0;
> > +	ret = __iio_str_to_fixpoint64(str, fract_mult, &integer64, &fract64,
> > +				      scale_db);
> > +	if (ret)
> > +		return ret;
> 
> I know it feels tempting to do the above while adding the 64bit variant. But isn't the
> overflow safety also an issue on the 32bit variant? IMO, we should first have a patch
> adding the overflow safety with a Fixes tag and then add 64bit support.

I think handling 64-bit support after taclking the overflow issue
would require changes on top of previous ones, which might get a messy
commit history, no? Mostly because the 64-bit variant of the function
is being used inside the 32-bit one. Also, the added auxiliary function
that implements the overflow check parses u64, which allowed for the
removal of the while loop in the __iio_str_to_fixpoint() implementation.
 
>  
> >  
> > -		return kstrtoint(str, 0, integer);
> > -	}
> > +	if (integer64 < INT_MIN || integer64 > UINT_MAX ||
> > +	    fract64 < INT_MIN || fract64 > UINT_MAX)
> > +		return -ERANGE;
> >  
> > -	if (str[0] == '-') {
> > -		negative = true;
> > -		str++;
> > -	} else if (str[0] == '+') {
> > -		str++;
> > -	}
> > -
> > -	while (*str) {
> > -		if ('0' <= *str && *str <= '9') {
> > -			if (integer_part) {
> > -				i = i * 10 + *str - '0';
> > -			} else {
> > -				f += fract_mult * (*str - '0');
> > -				fract_mult /= 10;
> > -			}
> > -		} else if (*str == '\n') {
> > -			if (*(str + 1) == '\0')
> > -				break;
> > -			return -EINVAL;
> > -		} else if (!strncmp(str, " dB", sizeof(" dB") - 1) && scale_db) {
> > -			/* Ignore the dB suffix */
> > -			str += sizeof(" dB") - 1;
> > -			continue;
> > -		} else if (!strncmp(str, "dB", sizeof("dB") - 1) && scale_db) {
> > -			/* Ignore the dB suffix */
> > -			str += sizeof("dB") - 1;
> > -			continue;
> > -		} else if (*str == '.' && integer_part) {
> > -			integer_part = false;
> > -		} else {
> > -			return -EINVAL;
> > -		}
> > -		str++;
> > -	}
> > -
> > -	if (negative) {
> > -		if (i)
> > -			i = -i;
> > -		else
> > -			f = -f;
> > -	}
> > -
> > -	*integer = i;
> > -	*fract = f;
> > +	*integer = integer64;
> > +	*fract = fract64;
> 
> Hmmm, aren't we truncating the values? They are still int pointers...

Yes, truncation happens here. integer64 and fract64 are range checked
before this assignment.
 
-- 
Kind regards,

Rodrigo Alencar
