Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB5343D8F
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446526; cv=none; b=YYIwcjIRW3dPYD5JdF3BWiD1tpE/D3AKAHbtgEZaltsiarlVV78zCyyEFwxYZHSq2WIy8KrwqXGJwef0Pcc0xGEwfeaMi0+IEpfRsZccMop/BXopQCdHVY5x+iIUxkAuRfgiu4jzdbPpJrKhjGFrkMTK2VimtmPxenjat8tQZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446526; c=relaxed/simple;
	bh=rtDgVvG79SUCWzCaoQOfUDO1NplihBERrUqYdXin8Yw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ9/K3IyX5hEEkKeHVC45TTFuRuCbFci08SmCDJKrGNt0ifGw0m5b4vai3YFkYyI+NALu4L4jUvdylBzkJYQPy23IjDKn8FQW5CFynmnpRAek6jC1ydV02N9kR/Pl/wH5DSnisALtGJh+8RZUG2hk+bFbjmrRwK7qrXmMxKx4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0Erv/eU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0Erv/eU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee9817a35so36215515e9.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769446523; x=1770051323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rc+FUrxKc4cUAoTTGJRU58P89nBONYHsM5Js7trUOgI=;
        b=Z0Erv/eUvMHVs1d/MEDVa+e2EfxT3uYF+eaxPuJWRWMSXluuPyiijRXAf1LtQmpNt3
         oEXPKFXjQ/j5fp2OofmiKGyEOcdtTQTV7KwKUZ0oKLFU4zBljQfOWIrBdHwoLZLupqJS
         DonRUMdTbFevCA2/1t5Z+xeyHwPywPUnj+z9uvad93eXzNqKpMWzbswT86Cz61gFzymK
         kQiNl5VM3iyfK0X7JNluJjai2Gr1uMSWpxvUMpO3xZp1fz0gY0ubXJxCERSk6c4g7hUX
         j/yjlwupvB6/S2K/HyntkIKlwEXzw8dFuDFe189aLAyaDboPEV6N9TcFmp7SAJQB5R8b
         9bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446523; x=1770051323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rc+FUrxKc4cUAoTTGJRU58P89nBONYHsM5Js7trUOgI=;
        b=EsvuLjJX5l6k/8h0CllP3B5wptUXENth09IFeBDDTf+zks7XjY+aUvBKQbsZ2HLaJU
         BXWZOfWMMnok0A/REhhqv5rqgSzqbxaXgUaaxBNyds7a6ZgFv/uo6o55h1TVkbvRCu9D
         YfVu7NIXHvOWZSyNKXN1WV9cfcgwBEyyubKO4vUVrzCvjLIvsOKOYGO9asiLaFPbLXf9
         HdvA9x/B5lIXqG4ibEEh20r8pWWRG2zc7VlGbH9leraxJqJjesWG9wIBXSNKujyvS3FA
         mIfKaXxzSuUdwOVGF5fEQleA1dATQQ827qNPRXVOYFjKrLRrewKuBsMQKrxdlDsBSLaW
         Z7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV53XmVhLx5LeD2NFLp0aNDylY63pDYMH897O5roHyh9o9w6cTJ2kJHBdcT0lcr+ajuJCs8k+0sGNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bf8+S4sIqlPluXpxir0MeZPsS9gTQi+A+azkhduw/LPnsWIC
	QDACrhGSO7HSlUO/Vb23pummyA63OQFwsQmNHvgaAe0BpKLHiTfElm3W
X-Gm-Gg: AZuq6aIh7vcxrKyRwr6YjdY6rbAT6qfQKeIgoCRRHOJtb+JFEiWi89vg1SnKJ+/O+T3
	3iFRL/pmAFcB0rbPuvYYejgGhjLPNy/k9iGbMWAnHIuRaW5a6eSzDeYkW0lajm2Xa4iCBMNrHQE
	KPJwjEdkVI1bbRXBbGnOYNLLfwCqQ/A0xFtMW03IvoHIZkC/AgjCNa6ioi3zR2vUZF7JBSyCvFk
	6u+ThnYQvY/D2deruPbAE8tqOjBwUFJDRBWbIkoUP3iUsib/kUk8dTGH4xmTQk1onInyLDI5PkQ
	N6iYsL5Ph9szbZPfOc+BwxqxShxp7Du3NFolCT2/gY/ZPAjq9uAdsDUn6XSSiRI0gTY68Srvuus
	NiRZkC5eCeRa7KTspqe5g8KZwKyjdlVDFIQsxwC77qpIa8BRml4p8GOsN+g1c6s3vcevpVnONDF
	036JACyzM6w11Z0t6eFwd2F+C2bplchf7JvCTf33mYiooJVSWPGQxAWejcT+UZdlhQmHKNQOAEF
	G9b
X-Received: by 2002:a05:600c:4e56:b0:47b:deb9:15fb with SMTP id 5b1f17b1804b1-480628348c6mr42537495e9.33.1769446523357;
        Mon, 26 Jan 2026 08:55:23 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bfb59asm1306595e9.7.2026.01.26.08.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:55:22 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 26 Jan 2026 16:55:13 +0000
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
Message-ID: <anhtxco52jz2ktmxlittsjuvfqybwrwgy76bjhni3j5dzx2rh2@hpzf3sfwe7hf>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
 <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
 <byitgzjli5gsq5v66topve7ip3inkk2udwhuihjdp6bknnkmos@tv226l7tek7s>
 <aXdtpkL5QUhhB_hh@smile.fi.intel.com>
 <ty6hptfh65k2rkqo6c6mg5z6vismuvyqsu3emvqarr2rbhpvcz@kn6tzjk5xi2o>
 <aXd_0uNVm8c_Fhwd@smile.fi.intel.com>
 <n2ms3esyxlegqibu4nluut3x4c4bkjxt5xrcd4gw35xxb2tipb@a2v73y25kroc>
 <shsikp7hinoxzj7pzxopvmvgpaak4dioekh4tyvns4kv6xp46f@z5vgnisqskco>
 <aXeRQ4AXmn1SxoNa@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXeRQ4AXmn1SxoNa@smile.fi.intel.com>

On 26/01/26 06:07PM, Andy Shevchenko wrote:
> On Mon, Jan 26, 2026 at 03:30:44PM +0000, Rodrigo Alencar wrote:
> > On 26/01/26 03:20PM, Rodrigo Alencar wrote:
> > > On 26/01/26 04:53PM, Andy Shevchenko wrote:
> > > > On Mon, Jan 26, 2026 at 02:26:20PM +0000, Rodrigo Alencar wrote:
> 
> ...
> 
> > > > Why? Can you elaborate how checking amount of digits is different to
> > > > check_mul_overflow()?
> > > 
> > > consider U64_MAX = 18_446_744_073_709_551_615 as the limit:
> > > - 19_000_000_000_000_000_000 contains the same amount of digits but overflows.
> > > - 18_446_744_073_710_000_000 contains the same amount of digits but overflows.
> > > 
> > > to catch those cases, we need to check for the overflow, everytime we read a
> > > character and accumulate:
> > > 
> > > u64 acc;
> > > 
> > > while(isdigit(*str))
> > > 	if (check_mul_overflow(acc, 10, &acc) ||
> > > 	    check_add_overflow(acc, *str - '0', &acc))
> > > 		return -EOVERFLOW;
> > > 
> > > *res = acc;
> > > 
> > > acc can get weird results if not checked. 
> > 
> > Thinking about it again, that check could be done only in the last step
> > (20th for u64)
> 
> Does kstrto*() also perform only last check? I think they do for each
> iteration.

It does the following:

...
		if (unlikely(res & (~0ull << 60))) {
			if (res > div_u64(ULLONG_MAX - val, base))
				rv |= KSTRTOX_OVERFLOW;
		}
...

so overflow is checked when either one of the 4 MSbits are set.

for now, I am thinking of something like:

static ssize_t iio_safe_strtou64(const char *str, const char **endp,
				 size_t max_chars, u64 *result)
{
	u64 digit, acc = 0;
	size_t idx = 0;

	while (isdigit(*str) && idx < max_chars) {
		digit = *str - '0';
		if (unlikely(idx > 19)) {
			if (check_mul_overflow(acc, 10, &acc) ||
			    check_add_overflow(acc, digit, &acc))
				return -EOVERFLOW;
		} else {
			acc = acc * 10 + digit;
		}
		str++;
		idx++;
	}

	*endp = str;
	*result = acc;
	return idx;
}

which would help the truncation when parsing the fractional part
with max_chars, avoiding a div64_u64() to adjust precision:

...
	digit_count = iio_safe_strtou64(str, &end, SIZE_MAX, &i);
	if (digit_count < 0)
		return digit_count;

	if (precision && *end == '.') {
		str = end + 1;
		digit_count = iio_safe_strtou64(str, &end, precision, &f);
		if (digit_count < 0)
			return digit_count;

		if (digit_count < precision) /* scale up */
			f *= int_pow(10, precision - digit_count);

		while (isdigit(*end)) /* truncate */
			end++;
	}
...

but I understand you would not like this approach, because it does not use
simple_strtoull() or kstrtoull(). Problem is simple_strtoull() is not
overflow-safe and kstrtoull() does not allow to track a pointer to end
of the string.

Given that the current implementation of iio_str_to_fixpoint() is not using
simple_strtoull() I am not seeing an issue with this approach.

Kind regards,

Rodrigo Alencar
