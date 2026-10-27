Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096616;
	b=VszNpl3JBPPV+zmAWc46GJtVGM0yt0oBAOTfQ2ndux1jXS3v3jIsMWdNc+vFdTfknGXL
	 7KVJtWb4n6Uk9WJNTFMElMA72pCNymFFHQYGPakKFfJexlbPZKSVr8d9GTqwsTY7KSgBW
	 g6vb3AUHZwT+ymKuyboVJTkIbH7vV9e3iuuAj2yJ2HprmojCYioFgtpBmjgMX8rzf2hPe
	 krqXSB5HrV3UFCX7Q2wwJDdSA3oXnMTU5OQwU6ujdBPaNzoo9FtXyQy7I3QI2qTzuiIH7
	 aTNNXz7FTmfsVcX3c9OiUIAi+zNZrTCuB63KUX8ha2rCZE3IYYsCRKMo0eWStRQToOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ixn5H3vAXnv2/MEaB41gzMYUz43Hp2KGMaNZl/QjLfc=;
	b=1ZvlxDQWQij+lX9qFiwp6E3O+Lu5C2ASQJ6zy0l6Or+vZfc81A6aA29T4F0bT6tneAlD
	 4UH6g9Jxzn5M2EzHXsB7zzCo43Np0LIvQ3ASCDFvCDKFl3/0girRaO3cWumz0UFsdTFxm
	 wtcllcjTfMYnT3wNbriTmC3uGMQOZfrEcagBrzba5EIYQgqxWjcsJXxshlgPubyy8VyDG
	 rdeJspmLs1P2YSslKHIH7NXL7to6AWfCSUIybzKLy0mgam0nDahhK+lgWFwHdy3tewc7w
	 q+DKkRabFl4AFIaGdk1ZlVajE+jDdugyC6fYACtc/ahGf2Tyq7BTMXY8BdHyH+l66vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G61uIgdJ;
	arc=none smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE91606A31B
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 10:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBE91606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G61uIgdJ
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so2827860241.2
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793096615; x=1793701415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ixn5H3vAXnv2/MEaB41gzMYUz43Hp2KGMaNZl/QjLfc=;
        b=G61uIgdJAgWLvqaN2anYk11h/HE/uUT/8PX5ugyGROleumnHYAcBvYCnQOuNdajm1T
         XoNoLK06iA44AhBPaNufTWmguWHz82MkXCdHawxr/E4w43k8eVptMyxbRTY64sK9krFA
         BnTkHBJSy2mz+fPluxCnwjmP2Bfbp9wlqc5By2fxmB0f8BHnbIByqE33842q20YuzyWz
         +nS888b1AG8Osk8RGyXuicv2vjWpXXIPyRE+8oa9dBgW47y4gqpkud8c72nHr5g7MT+0
         5hpxtPRYT7/rPHetn+RUcjk034Kv4EACdVZS3WosBo/w3ybC0TcB5o4fkwY1Iw2+hRhm
         yN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096615; x=1793701415;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixn5H3vAXnv2/MEaB41gzMYUz43Hp2KGMaNZl/QjLfc=;
        b=i9JTy8fHuYSeXadhV1Kt2yfVKzey8oq20B9dO+jfjkgAzpIOmlaTOzaW/EfiH+GO12
         +vBF+h//S7u+YT6tOS1WTbkM41uNCzs9WtCrcY6x3eRBJQrYJP60YyfOnxKIz+q3pSPy
         YrKueSCpfHrzRtzEqEClMFTMqb6qP+I293D8zCiQ39S5GqGlJxWOS5DYQRzWQp3/0c6D
         AVQ4f8LQ4wCc6K/QuiG56+WMCKj86R0ebwaTRoBNI3H4O7z6qPA+2TT4ygjtrlgU1uOR
         CjXfauTutizS+5+NToTLyAgNeIggFc19pX6HvtZUKqgepc87b0QbmyWZIk0zfcE/7UXt
         Va3A==
X-Forwarded-Encrypted: i=1; AKwUvByKjMtOoAYL0C/q4temXJcVsGUi4oItI879IdKNtV/kvGedYWmF5Y4vsbH1DtzadfSW/rZbekeb8P4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnjBlYIOXK5oW4vx6rTPkHC5m7/aw4FmofOsn7BQ/pXdeWvdux
	v9BavlBtZ8FxB4tXj1AxEIZdTkgeCdjbXUrlE3y8FLr1+R369/+rkh/u
X-Gm-Gg: AYBFou0Y9UCvRalfNy0UHmKPoRZpE/vkuhfRb88aWWSnwGtk+z1nh6wS4cE9yxOVC+5
	v37oAuMpbqmU6yn5pFAe8aBReHcGw8x22k0rUZxQ9jAUapdCN9nkZBWou9T+qzxBbHCAn0QjaF6
	09QwBkVujUFQuO8iHd2t7T9pWtYd72XgCDSN5au2c74p+P4CweM5aw0f4UPibtXagr4j2vZw/Gs
	KOzH5L1n8Ww6HfAe2R6Ls3thyOQs8nT4Eg84Bg7DOl6tHPvhkWiMX2xKsWdiPBJ1bTMEsXaivvD
	6iFC2FnUEIbNk5woAXgrU23XLZ70t7LXkMPlzzKL887xlCgfhsbfGfdKgK0M9Z/RwEBG069RpnQ
	JPCr2uyEweTLxDbmD4+vlsVVbqYP2Zh8SBi0zG2WxTIArG1TSbDz6vuBmz87NxpG3wSm+nSzcOc
	IO15mOPLyix6KOJwRvp4nJ/uQpomf0RuoJ87Zp8kfVDH8jGVw9itdWs5bgScBrVGWiQTrgFDluj
	SHXNiN5ybHi5H74sVXQDtMjZBHdQLtr7jDEfltxc4Uyg3AwDsGPowOBncXm+XYoaqaZo3N7LQSa
	D8YL/jusdxadtxPaG9jbkbxIwt4P9hf+u5yjO3GTUsb2JFxJSxU=
X-Received: by 2002:a05:6102:3e8e:b0:7bc:1de3:39b0 with SMTP id ada2fe7eead31-7ce5cdf6628mr3450597137.32.1793096614648;
        Tue, 27 Oct 2026 03:23:34 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.31.netskope-rdns.com. [158.95.44.31])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3bc3816sm1983763137.3.2026.10.27.03.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:23:34 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Tue, 27 Oct 2026 07:23:26 -0300
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 1/6] lib: kstrtox: support E notation in
 kstrtoudec64() and kstrtodec64()
Message-ID: <c7lsphh64wm7572rt2dt27ar2fo3w7v3a7jjmahhkyzttp22rk@o7jufy545hfm>
References: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
 <20261026-e-notation-v4-1-a366a6d14d57@analog.com>
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
In-Reply-To: <20261026-e-notation-v4-1-a366a6d14d57@analog.com>

On 26/10/26 08:54, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Allow decimal strings to carry an exponent suffix, such as "2.7e10" or
> "271828e-5", in kstrtoudec64() and kstrtodec64(). The exponent is added
> to the requested scale to work out how many integer and fractional digits
> are consumed. A negative effective exponent drops integer digits.
> 
> The digits are now scanned first and the string termination is checked
> before any conversion. A missing or malformed exponent ("1e", "1e+")
> returns -EINVAL. An exponent that overflows when added to the scale, or
> that makes the result exceed 64 bits, returns -ERANGE.

...

>  static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
>  {
> -	unsigned int rv_int, rv_frac;
> +	const char *s_int, *s_frac;
> +	int len_int, len_frac;
> +	unsigned int rv;
>  	u64 _res = 0;
> +	int exp = 0;
> +	int ret;
>  
> -	rv_int = _parse_integer(s, 10, &_res);
> -	if (rv_int & KSTRTOX_OVERFLOW)
> -		return -ERANGE;
> -	s += rv_int;
> +	s_int = s;
> +	len_int = skip_digits(&s);
>  
>  	if (*s == '.')
>  		s++; /* skip decimal point */
>  
> -	rv_frac = _parse_integer(s, 10, &_res, scale, _res);

previous implementation required scale >= 0.

> -	if (rv_frac & KSTRTOX_OVERFLOW)
> -		return -ERANGE;
> -	s += rv_frac;
> +	s_frac = s;
> +	len_frac = skip_digits(&s);
>  
> -	/*
> -	 * Check input beyond rv_int and rv_frac to cover cases like ".5" with
> -	 * scale 0, which is considered a valid input, being parsed as 0.
> -	 */
> -	if (!rv_int && !rv_frac && !isdigit(*s))
> +	if (!len_int && !len_frac)
>  		return -EINVAL;
>  
> -	while (isdigit(*s)) /* truncate digits */
> +	if (_tolower(*s) == 'e') { /* E Notation */
>  		s++;
> +		ret = kstrtoint(s, 10, &exp);
> +		if (ret)
> +			return ret;
> +	} else { /* verify termination */
> +		if (*s == '\n')
> +			s++;
> +		if (*s)
> +			return -EINVAL;
> +	}
>  
> -	if (*s == '\n')
> -		s++;
> -	if (*s)
> -		return -EINVAL;
> +	if (check_add_overflow(exp, (int)scale, &exp))

I was wondering, and I figured that the 'scale' parameter can be made
as a signed int. This E notation implementation allows for that as
the scale now folds into the exponent value. A negative scale would 
make sense to allow the representation of values greater than 2^64,
still limitted to the 64-bit precision, i.e., 10^24 would fit 64-bit with
a scale of -6, which would have least significant digits ignored. The code
is ready as is, that would be an small change on a interface internal to
the kernel that wont change consumers code. More test cases would be added.

Although the absolute value of scale needs to be reasonable, the int casting
here is also not ok. big unsigned integers here might lead to negative values
without warning.

> +		return -ERANGE;
> +
> +	if (exp < 0) {
> +		len_int = max(len_int + exp, 0);
> +		exp = 0;
> +	}
> +
> +	rv = _parse_integer(s_int, 10, &_res, len_int);
> +	if (rv & KSTRTOX_OVERFLOW)
> +		return -ERANGE;
> +
> +	rv = _parse_integer(s_frac, 10, &_res, exp, _res);
> +	if (rv & KSTRTOX_OVERFLOW)
> +		return -ERANGE;
>  
> -	if (_res && ((scale - rv_frac) > 19 /* log10(2^64) = 19.26 */ ||
> -		     check_mul_overflow(_res, int_pow(10, scale - rv_frac), &_res)))
> +	exp -= rv;
> +	if (_res && (exp > 19 /* log10(2^64) = 19.26 */ ||
> +		     check_mul_overflow(_res, int_pow(10, exp), &_res)))
>  		return -ERANGE;
>  
>  	*res = _res;

-- 
Kind regards,

Rodrigo Alencar
