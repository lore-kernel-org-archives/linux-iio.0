Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF333891F
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769441452; cv=none; b=h6wrKJ/OEUtB8+IkI1VwO2uufQEvRSE7N50XT1j56hfHWk2reOxcKDZf8IDJqV94m9xR1BxnGkrypiNfAFbQkHYPclNREkI8mJza1xthb1xFGll9vRB7Wm/fLXyUZg6XCeS2qku7QcYz+fkgCrplZCTNVyQCL65PMJ8kosY9JDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769441452; c=relaxed/simple;
	bh=MvvziUr4xaQ+5ePGg8faDANvROblVFNwXkByQwc0oPo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3/TaufglVlS/CC7KxGop8lMuJttaKowYKQs5HDXMh94kaJOS6s39tlMjbGhjyPttc0JxX4JSFnZroZMdbcM4SDautO2AttqxZ3VVsg38ohDlHLwf7axlqloYxxariXk3G8QS7U5Jt1IpSgxQPlrODD1ljMobw2g6OWTBqOd3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHhhfVIA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHhhfVIA"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8715a4d9fdso574525166b.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 07:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769441449; x=1770046249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/RN6DWG0RynJN5xF49LNlsi86bwuZ6LK/+l0lViTxg=;
        b=cHhhfVIAs2L85kEWhAi45tuk/0f7amS6jwIn2Ui5HTjzT7l7NajhQq7KB413FD5wdC
         HsCtf8eqiidsc+EdKDGyLnJEFR3iw9oSCg+4AkPNCdGgSTp1Lxv5Ikc6UoUMzZc+p8VY
         wOMQaJvM4YSAesQdOPvG0tJRBuhwIDdUa2j59Z5NWUE3lFFEQlOjAXAOCmLGJf6YW34O
         2PGCrFgkyl4K+JVVKg0SqFt0Xr7z9VccuSGToLotLBGSLKDviQnJnP24CAQY+q2kq8xg
         L3sr1NW6PASbkHUq8takkStOCHJi4f/33xn9GSNPK5APpAYA5xeVJWCyMOa/WcpC27vM
         WSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769441449; x=1770046249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/RN6DWG0RynJN5xF49LNlsi86bwuZ6LK/+l0lViTxg=;
        b=gME10SkSVe5JNG/rWMOx7A+m22hAQcUMwjnmKxHhm483bxzuABLSWZm6WCtzt0Kt3C
         8rdsBexhWal9aGlP1qJ5MybdPEhq4Dk9VTWxqgft0ozZrqsSv0FoQ8pMcW4FJRmMxUoJ
         jy4w01dmv90O8+uG+xXPi2pOx/GfJaHSW2OlpNFIdpqtmmTZ4QwP6GjXLzwwR9kl2wI/
         VxdMgsNPqYDkD/xOItsaT+9/S2OtCqxImvqHKQDwUZnmtiZVeVd7p38QyBfztearmJkn
         k70LpwjjaFpKOEVMs+JtX5V8Wbyy8sXhaYXKZIvDzoKgCM+rTEQEULa1lDukrk51NCQr
         LBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnl1PioJYNoG9KpwpRBKVHkSYeIslT67QeDZhsLARzPqqQQy0ItHwi/hCHKB+IJq3WqyPmTZLuPdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTc8+mbGuyY9u+47QUaQvdgmeLjpVfROYomY2M0LAsxF9fkXBu
	BN9Ggbl/q6K1Fdb5ybCB/Z8wpkay3t2KZT6umnwJTEhkqhV6wODyR12K
X-Gm-Gg: AZuq6aLefZRA0O1lcKbr9MUVT7+0UiNGkFKReK7rxG4Lkvqh8B202hOCjn3uVbBiUqJ
	JyPQnyqDnRLbGpO6vgnhgqETKcM6KRu2eFYGcsJKjFZ6VL5Vf79rfUmfM8GBqqx9EXIRpyFJ3TN
	AxioNd4Fk2MeRLrAkQnwhUDTE/CwHcXRM3UEEzwPISrDMKRoanGf6NCkhXDkxAv+hMSaFW+Z4WR
	P0KLONrBi18zCmCyKMgy96iWt6TCB7KMKC9O2FVtNSEuDFAmhKJnot2vLr9ghmdYoEvOj/8ntZ7
	ccmFTalsoH05qWHxesYJNBHYSHv9P3es3/zYWgKMDSKLFgKXnQiHI0a0i9x5yfON7ipESO/zueu
	0qL/ATVrRiCY4f/gS5HlzpjOB7LfwCFNtcPEfz8362yPwMYjxfgdIsRrOzanRSE5ehrryGvCSYr
	gQMTHG5qoLJ254yRZy2aZIvEHlLK7v0dkPqL0CpxyJ8mb57bgrz8QzeiZSqP7nYeIsog1VBQVlP
	CA2
X-Received: by 2002:a17:907:9618:b0:b87:1fe6:f223 with SMTP id a640c23a62f3a-b8d0a739f51mr338158666b.6.1769441448930;
        Mon, 26 Jan 2026 07:30:48 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b75dbe6sm642381766b.50.2026.01.26.07.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 07:30:48 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 26 Jan 2026 15:30:44 +0000
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <shsikp7hinoxzj7pzxopvmvgpaak4dioekh4tyvns4kv6xp46f@z5vgnisqskco>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
 <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
 <byitgzjli5gsq5v66topve7ip3inkk2udwhuihjdp6bknnkmos@tv226l7tek7s>
 <aXdtpkL5QUhhB_hh@smile.fi.intel.com>
 <ty6hptfh65k2rkqo6c6mg5z6vismuvyqsu3emvqarr2rbhpvcz@kn6tzjk5xi2o>
 <aXd_0uNVm8c_Fhwd@smile.fi.intel.com>
 <n2ms3esyxlegqibu4nluut3x4c4bkjxt5xrcd4gw35xxb2tipb@a2v73y25kroc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2ms3esyxlegqibu4nluut3x4c4bkjxt5xrcd4gw35xxb2tipb@a2v73y25kroc>

On 26/01/26 03:20PM, Rodrigo Alencar wrote:
> On 26/01/26 04:53PM, Andy Shevchenko wrote:
> > On Mon, Jan 26, 2026 at 02:26:20PM +0000, Rodrigo Alencar wrote:
> > > On 26/01/26 03:35PM, Andy Shevchenko wrote:
> > > > On Mon, Jan 26, 2026 at 12:42:53PM +0000, Rodrigo Alencar wrote:
> > > > > On 26/01/26 01:49PM, Andy Shevchenko wrote:
> > > > > > On Fri, Jan 23, 2026 at 03:53:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > 
> > ...
> > 
> > > > > > > +static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
> > > > > > > +				   s64 *integer, s64 *fract, bool scale_db)
> > > > > > > +{
> > > > > > > +	u64 i = 0, f = 0;
> > > > > > > +	char *end;
> > > > > > > +	int digit_count, precision = ffs(fract_mult);
> > > > > > > +	bool negative = false;
> > > > > > > +
> > > > > > > +	if (str[0] == '-') {
> > > > > > > +		negative = true;
> > > > > > > +		str++;
> > > > > > > +	} else if (str[0] == '+') {
> > > > > > > +		str++;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	i = simple_strtoull(str, &end, 10);
> > > > > > > +	digit_count = end - str;
> > > > > > > +	if (digit_count > 20)
> > > > > > > +		return -EINVAL;
> > > > > > 
> > > > > > Not really. If we are talking about decimal (only) cases we need to also count
> > > > > > leading 0:s.
> > > > > > 
> > > > > > 0000000000000000000000000000000025 is still 25, no overflow.
> > > > > > 
> > > > > > That's why I recommend to have a helper, maybe for now locally here, like
> > > > > > 
> > > > > > int safe_strtoull(..., unsigned long long *res)
> > > > > > {
> > > > > > 	...
> > > > > > }
> > > > > 
> > > > > Are you suggesting to not use simple_strtoull then?
> > > > 
> > > > Nope, I suggest to do an additional step before checking for the range.
> > > 
> > > You mean, conditionally skip leading 0's when parsing the integer part?
> > > e.g.
> > > 
> > > /*function entry and arg check */
> > > while(*str == '\0')
> > > 	str++;
> > > /* then call simple_strtoull() */
> > 
> > Not skipping, but counting them.
> > 
> > > simple_strtoull() is not overflow-safe,
> > 
> > Yes, I know. That's why all these additional checks are required,
> > 
> > > as it does not use
> > > check_mul_overflow() or check_add_overflow(), only checking the
> > > amount of digits is not enough.
> > 
> > Why? Can you elaborate how checking amount of digits is different to
> > check_mul_overflow()?
> 
> consider U64_MAX = 18_446_744_073_709_551_615 as the limit:
> - 19_000_000_000_000_000_000 contains the same amount of digits but overflows.
> - 18_446_744_073_710_000_000 contains the same amount of digits but overflows.
> 
> to catch those cases, we need to check for the overflow, everytime we read a
> character and accumulate:
> 
> u64 acc;
> 
> while(isdigit(*str))
> 	if (check_mul_overflow(acc, 10, &acc) ||
> 	    check_add_overflow(acc, *str - '0', &acc))
> 		return -EOVERFLOW;
> 
> *res = acc;
> 
> acc can get weird results if not checked. 

Thinking about it again, that check could be done only in the last step
(20th for u64)

Kind regards,

Rodrigo Alencar
