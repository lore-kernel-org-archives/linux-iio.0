Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769256;
	b=0QY6MEttJQWceaqaLX9t0txBuCeTo7vWsDmb85FyYzFTnR+R7aM43+x9AjrWsvFzxqeh
	 MjkA/XUNLd86aFcs6+6d/ti0zffGlxfFyT9hbkwSJK21O1iambWKX4aH6FMTIeF77Jb6T
	 3/EWT59TiMrWlc1hegg/MjMf9udskdDA1JGOMgkjfV8KE1B8ehQL/DIZ2UygLl6IXbUCU
	 llIcx9kOiDPnZ22KDoVwqcxzK6cjsNqZMtKjLRLeNP1VXm/v58wCVDreo+XzosmThOpDE
	 mAl9hJlAKlPqDOnXM3NtCrMf7Ntp4wG/WzGyyiaR5N+FT/IuHCbz4E28Ud957NTHP+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hFWAeWghUobS1SNh2HR/z8yfcl8Q4/5YjOR9+nLiaM8=;
	b=tApBrd4LUqIQbCuwZiapzu9pXXnYY4HG3r6Kxk0/UQ/5DzbtwJpkYhoORAlamgCL5/DL
	 agOMmgwfsnw94uNpviu06v3TqhQPjmDIB/D3ifgE8+BCyC4L9MKa/UaI2rvKL6yG73Xgd
	 7QvwxDDIktI/dsZXQtoht8nms/IWqFXoGMBiMyItT/F4Cn2lsadyS4/QU5FB8GQ++/ydJ
	 Ahu8rTDn01eMNBGmp0U5vNBjYQH9LsAASzJwg0z2sQ5apSMG7qyiEC26AzmmYwIvosbl9
	 PnRyuLmpV5j94CJoI76MmbCn3E4ZN6fIIC/50BHWSCFPCEsRGjQYMaMsXnunWmSY0NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YRrEPwAX;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70B606A31E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 08:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E70B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YRrEPwAX
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so71131695e9.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 00:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795769255; x=1796374055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hFWAeWghUobS1SNh2HR/z8yfcl8Q4/5YjOR9+nLiaM8=;
        b=YRrEPwAXoqI5gP2IIQzDF7IMwF6mWmENF8YM+9EnjV7JeOQc93bnq1e8N27XjttZpF
         a1i0rHxiGEfrDBBvSq57VnSzKmbzUUcSTReIV6FSiAgxPanu+MLDwhJ68UsZNZ2KJHcT
         pzdxnynl3I3SfzEc5EtEyduv3QSvo5fQfoy4f3Pedo3Ah1wpXyeggYJINAWChbDw4zd5
         P7ob5ikcmiawzqcJrtlKQV6Rlx77LGgmdaC8rd88mSNvGD1rzhYjHuZ63Viagq6Dj9eO
         EDcHXwMJCLTUAb4UpkwMwcMxzdvujnZcbsu8+4oAHCht3UbCAZ5HZ1BIGIwFPYc8Q2Ui
         ZVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769255; x=1796374055;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFWAeWghUobS1SNh2HR/z8yfcl8Q4/5YjOR9+nLiaM8=;
        b=JrhnBndC4b9JTg3eqVgAKBF9u25mQrUjS4kWvKxiqkGysgX5kYFkjC8bpFXUoGLkv/
         IcZDSySgE/V1ARuPCFhLOMfHRNZZ9JjiTuG/6dBXlielSeRbEpY/sbgMTgFZe2eD6wp4
         i8Cgxorj1qdlBSbUPr1ittiH6GBIedhN5kYNaL3yh9sYsB6fskeaiCCneak/IxoA7VYb
         /6oZwW6vdvcGKGrCmc4X5rvA1PtNZg7o76XEb5kPHkc06FoK5HZmHSkt+CzmztxSkkX4
         u2vYoZFkbbizEc9InasD/GHqOQRsFc1sdPm4GiiA1RAjeU9M+NvA6rKMeItvz272B+WV
         UUyQ==
X-Forwarded-Encrypted: i=1; AL+hErF+G/WwnzDpn8hZrYQjaG2bXvxY8bOeGIf3VVs7LvOCHjCeZV4HfnHzSyF44mP85jPG8WU7MkGwOCs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ceuP/ULlekdIAFC1TEaBCiGJYeXBOEDQ2Z86QrwfxNtxGoa7V
	j05SLvq+7T7jgpEmkxjlA11gXAiiHf2FyFL2SmxVFUKaH9dMj5iVwsrezu+5mr4HwKE=
X-Gm-Gg: AZFdTZd9f4FJTXxjQ2SBK6Cq9+iHXoblbWkuO3v+isqbTz7KcJWsjXic00u/ui8q5e/
	3mGdbR3FwSczeAU32gto4jXHKbj2sLnE+vkiWSudxmmc7ZXnJNcTLAARImwQ5ZxddLYXW9SrI/f
	5RFA10DDoXGay4k2lQu/awARPPRmZiBwBl0sZu4MT7RR5a0+3EJePcp5/q0xACbjdoM+TzlnkIv
	3N4LCcT9D5FX/kVNCg5UQrwOlEliHTdf7xcyRpLeRHHcLJDVV7T4f+ooIdeelLey9RE0GOkFlp0
	qECpTHvhdSAq3JS1046E92P4nnwKCVYYBTGd+ZEdKUKz8Oz2Hs7ukB5uNOl5m4u7oQff7u538ML
	YN4DXPhDsSAwrhiucpzNUGX6VC1GMWwYNJtDdNSmsaM7yRi0bt3lDCUhkl+rjKikk3/QpgFqsHR
	sJFjjnxd4asaavKR7E1tpe7Gvar8iSizxCqcrOSqlLyLvo6KZVMYBRsq1utxWAScg1ZJYm5xqSA
	mkTrj995HsNBQ5jO+VOEhtsLB3YCs9TWc8fdlYCDKq5z/ItOh0CjD4xrBY8+nehI43eu9Js32zQ
	jht2CbX2ZxV0WjBr0JIAjriB3bFrxX7XIl6D3gBwMjrviGOxMRVaOumkS3X5piq6dZ3yozbqMaS
	ajNbf8jVBZFKWJGx0
X-Received: by 2002:a05:600c:4e0d:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4bb88922a67mr460696165e9.31.1795769254732;
        Fri, 27 Nov 2026 00:47:34 -0800 (PST)
Received: from localhost (p200300f65f19a90496f529fbcf0b312d.dip0.t-ipconnect.de. [2003:f6:5f19:a904:96f5:29fb:cf0b:312d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884a3a3dsm662489995e9.10.2026.11.27.00.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:47:33 -0800 (PST)
Date: Fri, 27 Nov 2026 09:47:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Romain TISSERAND <romain.tisserand@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 2/4] iio: adc: Add the Miyoo A30 analog stick MCU
Message-ID: <awlCneo6rrSJPgky@monoceros>
References: <20261127012612.1589039-1-romain.tisserand@gmail.com>
 <20261127012612.1589039-3-romain.tisserand@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kmxikfi6vr3vqamf"
Content-Disposition: inline
In-Reply-To: <20261127012612.1589039-3-romain.tisserand@gmail.com>


--kmxikfi6vr3vqamf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/4] iio: adc: Add the Miyoo A30 analog stick MCU
MIME-Version: 1.0

Hello Romain,

On Fri, Nov 27, 2026 at 02:26:10AM +0100, Romain TISSERAND wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/serdev.h>

Please rely on <linux/serdev.h> to provide struct of_device_id and drop
the include for <linux/mod_devicetable.h>. The latter pulls in several
more header files that are not needed and that introduce build
dependencies that are not needed.

Same for patch #4 with <linux/i2c.h> providing i2c_device_id and
of_device_id.

There is no need to Cc: me for new revisions of this patch set.

Best regards
Uwe

--kmxikfi6vr3vqamf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsJQ6EACgkQj4D7WH0S
/k7MsQgAmXkeM4wMAFcot67XUVVbBIBHe14nNZchUfh2WmvpAi0XpKPNzsTIHhjj
/GUImj+kXS7eSvVQxGljXF5pczIDQsuen39afEPHvvhSyg6oxGFTEXp7SfEeuHAD
vg+2SwwGvurRKj5+owpBWNRDeCDTZnwZratfLSZdfT9kL4xjk49xBptg1K/Ev1GK
oz7iX7B2LJSQr71EV4/vWigA10VXxR6nsgBwhKbQmBLv3jBGoiU6UQdZ/O/BewLM
kvwT7M6MH34lt3X1gC97PXjO4XwqYOdg4tQG9eDWqJ4kh4TUCIKB03AzOEGJ8n82
VMq7sXMm64yM6YZAUq6tCbzxKjFNag==
=yo0y
-----END PGP SIGNATURE-----

--kmxikfi6vr3vqamf--
