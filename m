Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575797;
	b=nThPa9vMzezsF5iX/7pyOiwwQLM6HPNe0YjfUd7PJEGACGa0FMwpo5XSY6WDxjOBdcQ1
	 KHzlcQeNvaBAygYf/0a9Fs54HjLrlTjT6dZ7Ews0aAKQfaKLXrMiJVfWHaRmjIzi5pbrX
	 +XhtXnqILSPRTUXN0p2QQKkT4DzlMlOFxBR9N7VsHABThpgk4+RBwH07qO2NmTMoyhHA2
	 yB7COit3KXAqkA0FcxBWq2m8x9bm8ahB5X6TWNVGKJ50Rfqfg3tiXcttA7wvxtOh2kqoj
	 3GplhVqcGzwzi/TkmrSnv42xJmokIOx96RBy6h27UzkPn9uRzY5I7VoHWGrrR71cyFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dhe+OwUtPyp9lDIgAXa6HnxDE7Qgi1WH1ldmiGmED74=;
	b=it7X8i/3LM5veqjwFEOllnHddBb229W4bvVMIJB4SgsYestKfcAgRwomo23vEsRIL5ZD
	 +lB4fSTHJKmnWWkJPsFAgINVU169KM2bxYHZHZOWuLLXIpMll8RVX4Y8bJTsS9dfSF7+X
	 cKb4x8BwM7JI3SpM3HkHvjCkLjOg9CTdzGuxmPiaSIxUyDASpqWfgRiTs/H0S0WL26+jC
	 1mQ2ipkmA6JvIB+1xSRBpM0Gb+e1Agw7KOIWXJI4xkTRY8cPk/QS8O0Geq/H6288mtDdt
	 0JvADQ2G2BhFAZFqku3OInpPvyDvvKfyn2XB8Oqy7bGg7WgqyxyJAcvrXsq7YgJqGug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=srjt+DeZ;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2CC606A322
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 09:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A2CC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=srjt+DeZ
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-99061e2171cso158846241.2
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792575796; x=1793180596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dhe+OwUtPyp9lDIgAXa6HnxDE7Qgi1WH1ldmiGmED74=;
        b=srjt+DeZDfQvwdyCu9ry3wmr0HKr+FZ4kA7dbDOp6ht0khn7HeCNM2OdlG1xRsQ0Kd
         lxc8MVn5Ct0LOJVBW+BsQHEtgEN1C7Ox286rsUVGq0jJHiO36gSHKXKJKny2mMLUwIzz
         5yv4UuuXW3yHSKLLIwM8fCpkRTzEOrMh5Ac1r1FWzw8+VcYjCnayVa/z5p6jz3RXXGU0
         iqWfaY939/CB+ZIVFsftv5ay9t2ZfsXbSArDLdKTT7fMjMiJkuqKYvkzjMLSlXfbWCxs
         cffdCFhd81Jp9qg8nUpkly1HyvG35jEVMRaKE9R9isJVF+yiuq0kVJEFcFYLnTYaSkIQ
         5ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575796; x=1793180596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dhe+OwUtPyp9lDIgAXa6HnxDE7Qgi1WH1ldmiGmED74=;
        b=S/mWEL8lZxmfsxJpiD5eCCRKd+Rd2TU+nSSDKjg6V5sKgkNr4m449uRQ8saTH11MpW
         cQ4FP2igXZj9kZz8C2TCL2CMXAnI9IOGkHFWnqilqz2rYUU1VvjbRHlzb4VJwwL3ODvt
         fYcir46VY+cEYw0ALfejSCZfKfU1mmrha3wDhZqXZ7iNYfQ80Kl5ssFnrsfP/3D/e5C8
         0kl/mRiWAMQHbc0vjQGznf5Nt8c038pofwMM25SNJuKmO2XwJISrliXnYv0u9R7TfvzR
         l2sf6sq4btINXL+UrKiLnPgvnC1HuVZK/tN71nTQQAijth73xpY+a3iFDIzEtyUrDZSt
         qAMA==
X-Forwarded-Encrypted: i=1; AKwUvBzaMDcjoDrQ19TKdc++4SiKVS6hf4XIMYJ5rk3MU3os60jwkboEOsYpz4YzOcRiQT+ecgqiRK9NbxM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHKy+sXQfXipgJSVj6rmPNud1BA518CuIKAVWVTKxPSfIoD4P3
	AX5DZBm160VRjcjo00t1g1L+4HTTqdrJgVMhHY2hLX96r5FxkP7WLj/E1vWWCPMG
X-Gm-Gg: AYBFou35hhlqm/Twv+9GlgwJqgkj/TkQutPL8s1C55yCz42nKbHaUQBj49iRZ2JVLzo
	vU50AozK3zUQRTNVCCJRXrrPaVjXkdoCvmBa6hj0h2UpRZOPY2qlrY7wYfgV7jrcwJrOHZv1n2s
	uAFR8Az/luhkyvIqbRa88fmLNfv/RhqF1vub8nlefiB27bqRUr10lAAze0ax4C1rLjK3nsKFstb
	oaaI2b13A87BWa+Kae7AZk3PVWtBMFsH9zVVKkSAfMrxnF7l8J0e/xzbOfwmV9Z7GK1aNAUHKqT
	2clpRyXzpUnOxP3UOuqU2mwvVzp/BFLJC0YctVWXVrYbagBS99P+c7TY++NM7I980KzYT+FuDlU
	6nMChll//Q/Pfi6PZMxD8a3Ja6pNAofxVBlalHso69M8NzyIBccxvJufet4Q0wzKbvsl4gAea8q
	UgujFK5h9ZI4AYjy8EjpQuEu77CCY8RL+dVDqeZ5Jvg00S++/H/v+/6JNtpLNybwWNlhl7SR4/i
	YsBWTx0pctCtZY6wOV39wne+vBuSdItX/WxPQYeNpuDT0YP2jEW+HulNgmWvfe+ET7e5YIiTiPS
	3BiU2uGvQhvrby+PqQLew+7ErKlgWBxln9wmxFMv8jxQ4mxH+nM=
X-Received: by 2002:a05:6102:4187:b0:7cc:776:6c41 with SMTP id ada2fe7eead31-7cc9273dca8mr453540137.22.1792575796124;
        Wed, 21 Oct 2026 02:43:16 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.31.netskope-rdns.com. [158.95.44.31])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc92327896sm2088122137.4.2026.10.21.02.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:43:15 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Wed, 21 Oct 2026 06:43:12 -0300
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v3 1/5] lib: kstrtox: support E notation in
 kstrtoudec64() and kstrtodec64()
Message-ID: <6h2ryn6waf6gcb72wjabfcxwf7fxl5nd74cbew3vixpop5oxrw@xlzrifrya7ux>
References: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
 <20261020-e-notation-v3-1-fd385c0fbf65@analog.com>
 <ath7t0hj12kXGgxs@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ath7t0hj12kXGgxs@ashevche-desk.local>

On 21/10/26 11:45, Andy Shevchenko wrote:
> On Tue, Oct 20, 2026 at 09:26:59AM -0300, Rodrigo Alencar via B4 Relay wrote:
> > 
> > Allow decimal strings to carry an exponent suffix, such as "2.7e10" or
> > "271828e-5", in kstrtoudec64() and kstrtodec64(). The exponent is added
> > to the requested scale to work out how many integer and fractional digits
> > are consumed. A negative effective exponent drops integer digits. Digits
> > beyond the resulting precision are truncated, as before.
> > 
> > The digits are now scanned first and the string termination is checked
> > before any conversion. A missing or malformed exponent ("1e", "1e+")
> > returns -EINVAL. An exponent that overflows when added to the scale, or
> > that makes the result exceed 64 bits, returns -ERANGE.

...

> >  static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> >  {
> > -	unsigned int rv_int, rv_frac;
> > +	const char *s_int, *s_frac;
> > +	int len_int, len_frac;
> > +	unsigned int rv;
> >  	u64 _res = 0;
> > +	int exp = 0;
> > +	int ret;
> >  
> > -	rv_int = _parse_integer(s, 10, &_res);
> > -	if (rv_int & KSTRTOX_OVERFLOW)
> > -		return -ERANGE;
> > -	s += rv_int;
> > +	s_int = s;
> > +	len_int = _skip_digits(&s);
> >  
> >  	if (*s == '.')
> >  		s++; /* skip decimal point */
> 
> So, I know that '.NNN' is valid notation, but is 'NNN.'?

It looks weird, but that is also valid notation.

> 
> > -	rv_frac = _parse_integer(s, 10, &_res, scale, _res);
> > -	if (rv_frac & KSTRTOX_OVERFLOW)
> > +	s_frac = s;
> > +	len_frac = _skip_digits(&s);
> > +
> > +	if (!len_int && !len_frac)
> > +		return -EINVAL;
> > +
> > +	if (*s == 'e' || *s == 'E') { /* E Notation */
> 
> You may use _tolower() helper (yes, the one with a single leading underscore).

ok, so we only check for _tolower(*s) == 'e'

> > +		s++;
> > +		ret = kstrtoint(s, 10, &exp);
> > +		if (ret)
> > +			return ret;
> 
> So, with the above in mind, this may lead to 'NNN.e10' input which I find a bit
> confusing.

might be, but as mentioned, it is considered valid, e.g.:

- python:

	>>> x = 2.e10
	>>> print(x)
	20000000000.0
	>>> y = .5e-3
	>>> print(y)
	0.0005

- c++

	int main()
	{
	    float x = 2.e3;
	    std::cout<<"x = " << x << std::endl;

	    return 0;
	}

	x = 2000

-- 
Kind regards,

Rodrigo Alencar
