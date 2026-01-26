Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BA33D6E8
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437592; cv=none; b=DLkqj6K0IXrHKBlFeb3Srvzm5zcetwMTZw81XhBMXySZVNcKmVEyRWdIn109k4F5LOJYcyCvP/2PLlEuP4LYgiimrosB+/3JgQ3YkRpXez+eXkPkrUdw+okFIEPYNHklayV2g5NAMPCvDD7bb+VEppAN3rCUYlp0NupYC+IznQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437592; c=relaxed/simple;
	bh=xcQ1KHADsvCxonwjQYEr0+LsPyIEGsxcz7IdXN2xHoI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfzE8xxny+oS2AugGEFH1dlKNhze2CVtCPYexKt0DvAit05UuzO/5wTACgiCFyY0PLBU9v/wIw6UIwHPwTwFaw5BYlFRFAwHw+JPIC84CpnNAU5xLli9CXEBMJGmnyxmvAh1MDYXTmkCNPT8SMaxbQpZj1uhSbNiNRQzN9OoWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzHGVfxd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzHGVfxd"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so7937429a12.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 06:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769437589; x=1770042389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQfEhIs4nzCG/cpXL/L2bih36CfKuvFVEF2Nlki8CuY=;
        b=JzHGVfxd91cB9qHDp6ECpotg6e1gMMdJI/dx90bQpTmvK73biWTXac7PGJbrTwkyDa
         3LF/VI0pscEL6uv9hSzdSWFTqXqlRxHH62VD9vXySMjQ64xbGyf3ZNS55rxvHRo9eb+e
         cvLaOwsd4FbzS58UNwrEnlKpGymr1gZurkiLeJyr8862kAjvgnXQq2Ngrq3g8SmZfeg1
         TQhx3yq2TQOQl6BqJkW9fyAKzzjO0RU+xxx+hSL4c2HRWnsaY2YFLTN6Oz0Dd/vOZy7e
         bC7nK2EzRuQkHW8voALiZ2FxpylquUhyj6wF622bHf785eloSZvccsASe25J/Cr7x/Ti
         IbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769437589; x=1770042389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQfEhIs4nzCG/cpXL/L2bih36CfKuvFVEF2Nlki8CuY=;
        b=b1llHCvbh9q4rl+zFHFgSgXiwO2J3UAPTDClTvJfNeZgormhsU/p1t1QH8Czxv4MqH
         tLbqYcA97Y5kZ43yCtL5rGWux9kvh7eL+YXSRnaIZx4SGsBwhnJRRlhgw7e51/iS8CMw
         EMih0bfTbE2sDFNO7yaQ6GrPexrGVOVA7+G3LRzHHVfQeipkgSXxoMk//dw3DACWbIFI
         hqo4i3xBD76EUz7uj00Lyc8mfutH8J3stNUF2IcK1R+VADMjzXCBoImbjMVc8I4UMeaK
         Skri8J0/2aGmEfDZIsX4hSCOCOePaiT4k+DfSOSiq7H2GLXxz6bt2Aoa2U+beMf4d0As
         B6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW8A9ZltKj9P6lgciKqhdG8lKuaQ1Ej3RIQY1+OubDBn0gHqyYnKASABwI7J+9YfEU46oSVmImruD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDd6agH8VYKU0GHuKWl+WWrbfI4a73lpSztO/s+G0grKrxNzeo
	mnBXa2NIDPuTUi4FnyYsiHHUY++lLdIvLWFYNhE0wIA1XintiNAc+9xq
X-Gm-Gg: AZuq6aLS3KkTbf+vFfzMSHsJnJqjvD2Y7XoPT+DKjpTjwQOUsBr6HuObvaYlyxX7uwN
	stK6uV7AaMPkR2DoRcMdT45ZXyhv16CqR1C4zBv6cMsRMb27bbU71y6LgZlTW8QqGSbIvZgCfs2
	QafEVO6H/ZqyHCYATWv/ftJB06LbvLxEtg8saQUz99gaXglhxdLP94MmZyakRK3Y2fcNsbzoh77
	PQcg2bQJSSOOspr71dmNTBGrFgo5e5NiSDjQGNaHjfZ7JHkht8R1zMDxPuVQCf6FL1y/Y2zSoPr
	Rq2c7+Pli2OTdiDc/MotFbY2nE6SfL2DpvTH4EPYHpgBI3JHXIMJhV7/0s34ytQOUjSjuNT2ajC
	+nI2hCkm80i9U1JFc3kOlRqk2xsxicYbb8AcS+T/vaHD8cBVjKQTwic5VQ2uUQuHZM8C9m3splY
	yKu3W9uRegx9x/GG9UM42PwFaNLTrJg1RAp9Wo7vMooyuNKG13Lc8thvFa5sm3/2NQ3DUTfHS0R
	3S8
X-Received: by 2002:a05:6402:35ce:b0:64b:6e20:c92e with SMTP id 4fb4d7f45d1cf-658706b8ba8mr2823359a12.10.1769437589051;
        Mon, 26 Jan 2026 06:26:29 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b3eac76sm4997626a12.13.2026.01.26.06.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 06:26:28 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 26 Jan 2026 14:26:20 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <ty6hptfh65k2rkqo6c6mg5z6vismuvyqsu3emvqarr2rbhpvcz@kn6tzjk5xi2o>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
 <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
 <byitgzjli5gsq5v66topve7ip3inkk2udwhuihjdp6bknnkmos@tv226l7tek7s>
 <aXdtpkL5QUhhB_hh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXdtpkL5QUhhB_hh@smile.fi.intel.com>

On 26/01/26 03:35PM, Andy Shevchenko wrote:
> On Mon, Jan 26, 2026 at 12:42:53PM +0000, Rodrigo Alencar wrote:
> > On 26/01/26 01:49PM, Andy Shevchenko wrote:
> > > On Fri, Jan 23, 2026 at 03:53:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> ...
> 
> > > > +static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
> > > > +				   s64 *integer, s64 *fract, bool scale_db)
> > > > +{
> > > > +	u64 i = 0, f = 0;
> > > > +	char *end;
> > > > +	int digit_count, precision = ffs(fract_mult);
> > > > +	bool negative = false;
> > > > +
> > > > +	if (str[0] == '-') {
> > > > +		negative = true;
> > > > +		str++;
> > > > +	} else if (str[0] == '+') {
> > > > +		str++;
> > > > +	}
> > > > +
> > > > +	i = simple_strtoull(str, &end, 10);
> > > > +	digit_count = end - str;
> > > > +	if (digit_count > 20)
> > > > +		return -EINVAL;
> > > 
> > > Not really. If we are talking about decimal (only) cases we need to also count
> > > leading 0:s.
> > > 
> > > 0000000000000000000000000000000025 is still 25, no overflow.
> > > 
> > > That's why I recommend to have a helper, maybe for now locally here, like
> > > 
> > > int safe_strtoull(..., unsigned long long *res)
> > > {
> > > 	...
> > > }
> > 
> > Are you suggesting to not use simple_strtoull then?
> 
> Nope, I suggest to do an additional step before checking for the range.

You mean, conditionally skip leading 0's when parsing the integer part?
e.g.

/*function entry and arg check */
while(*str == '\0')
	str++;
/* then call simple_strtoull() */

simple_strtoull() is not overflow-safe, as it does not use
check_mul_overflow() or check_add_overflow(), only checking the
amount of digits is not enough. Previous implementation of fixpoint
parsing didn't care about that. 

> 
> > Understood, leading zeros can be ignored only when parsing the integer 
> > part. Also, would be nice to have truncation of the fractional part
> > while doing the parsing. How about:
> > 
> > static int iio_safe_strtoull(const char *str, const char **end,
> > 			     size_t max_chars, u64 *res)
> 
> > - max_chars = 0: ignores leading 0's and process all digits
> > - max_chars > 0: process only initial max_chars digits and ignores the rest
> 
> I'm not sure why we would need that. It should parse the whole line until the
> first invalid character or overflow.

"process all digits" and "ignores the rest" would be for digits only, so it
would stop until the first invalid character is found. I suppose proper
overflow check is implemented with check_mul_overflow() and check_add_overflow(),
while iterating over the characters and accumulating the value.

Kind regards,

Rodrigo Alencar
