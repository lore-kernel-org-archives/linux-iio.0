Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67FC21CA02
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185764; cv=none; b=fTTDX3v8v/eRFoxu06eJ+kke2KRJUQ2MM7+nqyDEh3pa6BKYuTMJsONlwAyrzOijTalxq0jHR3cSB8YKDd7bcKXeXUIpnYY58IRG13jKiaklREenfgzGE3kDIBvs6WZLoKClGUH0eq+4F5dVxkWo9QMhTBwAq42rxPqbvSVWqBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185764; c=relaxed/simple;
	bh=9YwhNfvZiLBwgVJs7QNPvVaPoJadnja3rLe542TkwUU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sd0UfG+VsQgz236I1weabY27l56zW5y1sAu+aaL9hWN2YpB1whXu815htrje8gbVudpHc8i5/qqfXf495XBWCvswrSXxUPbJhcMMQG8StbsqPZfkMjGWOKSbyqIZBrCWB9I25WhasMw4w6PX03DuHL+7KoiVZE6qb/kVhEZU5lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEM7JZ5H; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEM7JZ5H"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso20618705e9.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185760; x=1769790560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUjaNwHvZaKSJy0kSWJZn5UqUMy6W277olMvwpuE7w4=;
        b=EEM7JZ5HNAgRsPim0gUfrEfE5RO+IaUX/1XdB7+NcX/vQlGxXTuf69Esh4M/9PAMYO
         1F1EPRBkgf6USVLPrcLe0FJN7dVMB8kznxaISNvdLs9OWfhjVtMRd9EW+TwzMQKnDVw6
         Z4o++TmkTH0DftUN7eI2cfmLYc+xb+lXY+iLveU9QTT0co2h6Iwp1BLOwVZutP8e1fA/
         U+l/obxJ0QfV5Ryf3V+Gpj5o0OVT+zTxAxcmGFkng7X2kjnalr2IyBIgsh8LK49GeSwE
         G8BcsxNBow8xJurLKGcSu/GkMPdDvsUH2zS7Ar9fmi+VpQ4akJffSazNsS9ybVHxZns6
         ZE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185760; x=1769790560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUjaNwHvZaKSJy0kSWJZn5UqUMy6W277olMvwpuE7w4=;
        b=AYvcoSZ13gXzR42jb/iodZIWIeEGbkJUqqoWBztSzbUvfktODh95saeuA6h2tVHO8W
         XVkIDZCq/yBj0qJuhC/gSyiixzCkm+D/8Ch1i7ldB+9UEQ/u0jgc/gkPGGcikoB7sGO2
         lHNgKgl9a870iP3brcbBlrYwjXLzyupG1xRGdWsVEf/21X/0LxwEUZD+otYAvrTC3JtD
         VeNCQSWPlFqKrgnqhuVOmX/OG8j2PQTKRbVZ4cfuodA2v2UivvDeiI3NUfNTYSYY3uiD
         k/FpwFwQJDc/8xGNGUVTd7zoAf/skzrRQzmeTC7jdfTWVNasxHz8OyBHBBgdt9Va5OyG
         8E/A==
X-Forwarded-Encrypted: i=1; AJvYcCWWH5x4YdEFzeOI11vRziJ5eh+OdVUNlr5IMX017qYP7EWfEgYRBsKrg6DYxm8PZV6ECv9hLvEcLZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/HOV79tyzyd3ID+z7+YseZIHt0ZixbtBCeI9L+b0R1hJyf+6
	u0+Rb99idKbVHNLYIvdCbgLEwVFFn42GLf9724uoPw4vqUl5dhPcgztv
X-Gm-Gg: AZuq6aJWrRiV7QJyIXmLRoUfqggRPraaYVxj38Dh81ppAA88T7g2qwyEYWLnehkH7cD
	FhoRzN6/bj2+iH+j/MAf5ppNylEv5moF97XgLY+HwXoYpVr0KMAN0M3nZSLs6WtBr2r7VZkOMG/
	eG4LjraZfzCfvA6/UN0nMKlQwSF5Il1p9/scXqfYR/LLeqalz01loJLiT6+CJurrY8RYpJqc7JH
	sRtZZS/RTm0hymE/AqXId4wdL46jAxL5Mhl6rPM8Gs3M8890rauMMApF7xXAtkluYlFhbkJL2Kk
	Dgx7WXt7M6RiXZEqBr7I/z6L/8+Xg6Z1IACQMja5zjaYMlIfgt2JoTChQF3FkIAImixd7S/yxqH
	qSxmH+jOWWr3P+QiAUQkk9bJykjmhyUiNSxpryMyMmSvbqfMui63CCMG04Hw0VYIiKragqFEZQF
	+JuLQ8x0m2dTikOYxdWfKRzY5Y9GvMDIgDgYlscImoq3xhk7z6g/cR2Xkp3HNGyToWef23+GWOP
	XfO
X-Received: by 2002:a05:600c:138b:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-4804c9afa76mr59925245e9.21.1769185760013;
        Fri, 23 Jan 2026 08:29:20 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d3fda30sm29151825e9.1.2026.01.23.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:29:19 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 23 Jan 2026 16:29:12 +0000
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <mhjhwxulliyoitb2be3altyfcis5ir2vgndslxopy3fhvhgpf3@r6lmjnrpmpoa>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
 <3rtccxcqpxkwq54jjbl7l6rq3xm3ibsnlh5s7hiymo4okir7dg@ky43houswpjg>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3rtccxcqpxkwq54jjbl7l6rq3xm3ibsnlh5s7hiymo4okir7dg@ky43houswpjg>

On 26/01/23 04:14PM, Rodrigo Alencar wrote:
> On 26/01/23 03:53PM, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> > to parse numbers from a string.
> > A helper function __iio_str_to_fixpoint64() replaces
> > __iio_str_to_fixpoint() implementation, extending its usage for
> > 64-bit fixed-point parsing.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> ...
> > +static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
> > +				   s64 *integer, s64 *fract, bool scale_db)
> > +{
> > +	u64 i = 0, f = 0;
> > +	char *end;
> > +	int digit_count, precision = ffs(fract_mult);
> 
> I've just noted that I should have used ffs64() here. 

The idea here is that powers of 10 are a bunch of 2 and 5 factors,
so the index of first non-zero bit (from lsb to msb) is the amount of
precision we are interested in. This is used down bellow because
simple_strtoull() does not stop at your will, so we need to adjust
the precision after the fractional part parsing.
simple_strntoull() would come to fix this with max_chars parameter,
but it is not function that is exposed.

Apparently the most correct would be:

(fract_mult)? __ffs64(fract_mult) + 1 : 0;

However, ffs() still works, because we would not have more than 20 digits
when parsing u64.

Kind regards,

Rodrigo Alencar
