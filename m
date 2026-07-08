Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A068358389
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501452; cv=none; b=HGUNGJucMl/L4FM2Mr46UkZbBJZUWgNoObZ+FlZP7E1yolDHNEBnXwiAc9eqL3d2EYzuXVFL+QPN5VN13Ynko6hF311pJaLCaEqhcH2+CDM4FhNgrS3NSSMxU61sOyjxQ6kbX4DeGHEtdZugIBbXOXmQRt4ZosVBr3A2tjFZp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501452; c=relaxed/simple;
	bh=0ttgfS7PI7S6E/+kOsmnxTsnPvxIfwYSyy8onWHW/s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsJ1Gccng8H+iQW1jPrMiYdLa9jsgSXyKz3IWDalp1cMQWZJ6i9S9kk/0pZiTwaIRLW/nQr7d8428A3L/UoDeRb2wraYynqvzFgpGjyzioQH0xId4jyeOpQh3vqKUcR9/2jbAm65iQIIZ9kphvHqmk3heId/Ot/tVisN4iP1gPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=L3j5Dv3k; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="L3j5Dv3k"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493c486f012so1608895e9.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2026 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783501449; x=1784106249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0ttgfS7PI7S6E/+kOsmnxTsnPvxIfwYSyy8onWHW/s4=;
        b=L3j5Dv3k9fRjX7AwgCgN6nByvWbpdyA/BXNAZaL72KePHNuh8HxoOnmsqA/lY/oin5
         1W0mKu3Te2JPj4CJ6BCJLOD93gGyns6I6H6+SZ5tFWayr2ybXqbzwgaTDQ3foLMtU/Gz
         qyzZQ00uH5sz99F1YNPmBHydCHi1Wix/qzhUXFywKEjFhTtbpNuUpy6jK/Uth9GGdlc9
         CBwyJAIu2oC1S6UcXK3/s/uUxLzHn5s8uNtPz6T9sP0YhPKRwahpHdmheYVk1o30vn85
         4mJtupsBX/sBjIzPi0Y2/E3+lFDhGMvuiwHboqVL/8WZS8RbuuOcX3BT+Ah+Q+WbQYEW
         KVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783501449; x=1784106249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ttgfS7PI7S6E/+kOsmnxTsnPvxIfwYSyy8onWHW/s4=;
        b=LZh1P0qSBLFtgqyVJNWf9b+xiGPKHED3kV0qExCRQsTfALgh14itFh8wumdOyEmTHI
         68qJ8sCHyFrrXl01MYL5lc7tatLVT897PCNmHtipugw1tmmWjgwQC09gRtrVUtdiFRmo
         g8iyExuuAYNl3AwUsdZLF92Uvq3FOndGfOQCjd8kZWhzsA1uePcgQ1chgQe9DsFVlq5y
         0HYg2ENjYj1PIDzyyapyAO7TER6YoZN9aVOh/NLM4B+oacbJd+vXc1OrSvp4k+X6vqdr
         HJv89Y0Yk7ogTF0cQ1xrh+IevIGwc75m33BBo5diLMuL9X9+u2PSoItn1EcRhk/38AEn
         iB7A==
X-Gm-Message-State: AOJu0YySCJUL+WI88aPom2kkLyPCkLhFXsKhPAn4HUV7oOmCoXnHYi1G
	QXTkEMwqdP0TSB0YyHjMWUhtvkhkzNHfAYIw2rAjWqdSAIx06CQxQ+n8VHkIJBYkSvA=
X-Gm-Gg: AfdE7cktM4ncoWLgRBMqD0ec2dfPZUJ0vgvEdB3eJ7wyS5Hk4hvDQrMFUYVAFHAZSN2
	Djl7iQhqD/qWxHDy59lSXBIpedWFH0pdYAv7JuhmobSxCYKwuZtPvARg+iGoHoRi6sG3A8Hofan
	UvIJMhGCubOxiX6TJ1XYVMM8FWs6Q5HdzcALw/YOZBUam+h7yO/oOqdqZafKm/rKWNts6zlrfOY
	oq6kJqCEC32QV53fI/BxzdCu3TFkKNIpXpRZlRASGoHGCBmov7q0EAsHLtjcQWVn7+c8Nw2XiVC
	EtHDw8nkV5vLZ9FCoVFF0IrivgQUxsjuUOICB6kG+1CorbspcwqleUty7eS5XHUX7MxP6tm8stb
	jIINQz1kHwgt8Ln+xUftN/ClfNhj0nPwo/imvv3mDvbiGNDAWrYVZp/nlxi7piwELC8bd9AK6TN
	IEbNsjycPVY3JtvlYTcQNROMmqR+4RxmfmLE6ljyzHuY09ywPZkMGeO1cpQN80uE/3j+7YudvLD
	8e7
X-Received: by 2002:a05:600c:8119:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-493e686ad70mr14985975e9.14.1783501448658;
        Wed, 08 Jul 2026 02:04:08 -0700 (PDT)
Received: from localhost (p200300f65f47db04930dc5bd4534e1e5.dip0.t-ipconnect.de. [2003:f6:5f47:db04:930d:c5bd:4534:e1e5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493e0f3318dsm111773165e9.3.2026.07.08.02.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:04:07 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:04:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 10/17] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <ak4SSFQZVVh6DuGy@monoceros>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
 <20260707-ad9910-iio-driver-v7-10-a4ec30f63700@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zsfy6shrbu2mdzpn"
Content-Disposition: inline
In-Reply-To: <20260707-ad9910-iio-driver-v7-10-a4ec30f63700@analog.com>


--zsfy6shrbu2mdzpn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 10/17] iio: frequency: ad9910: initial driver
 implementation
MIME-Version: 1.0

Hello,

On Tue, Jul 07, 2026 at 03:04:31PM +0100, Rodrigo Alencar via B4 Relay wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need (if any).

Thanks
Uwe

--zsfy6shrbu2mdzpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpOEoIACgkQj4D7WH0S
/k6KCwf/Vgjpa4Op4HxG6UMD29jr9xEIWuo5E45vasyVBmM8XpQPLy8lof6Ftx5z
hKUALu3RTBas4V+7sxlgbyGcbnq3sn+fG8nq0zuMmYjJ/Yt3M40ysryX0FyOJhBD
nReg2c3lQ7EsVtCcBMpvuPCBq8hb/gzAJ5gW46cP068KzoGgP5Tp31EtZ8W3+Uyv
/7p6nWKibQVKI+yB08a0JQK/A9KbjYfbLR/kJdIn62ypQBOxx5i/w9EQ4a+1qHzI
HorFt9nltPe4VidIEEsFE7pylt1wW2O8crfi83ZvbFtBPUAtG2EOBpVQ2PRPZhFU
mXtkyx5tKMD50sJB81tvJVJzv/vpGw==
=WxHJ
-----END PGP SIGNATURE-----

--zsfy6shrbu2mdzpn--
