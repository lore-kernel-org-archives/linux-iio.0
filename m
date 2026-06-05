Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3330D3F9
	for <linux-iio@vger.kernel.org>; Fri,  5 Jun 2026 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662300; cv=none; b=ZDGzUjNDoRICwNwVvNwjUlTYg2yMJT+nqxzYN6pqAvJLIlso8h4kLPv8MnW/dQfrnxEeRuhq157idoOQLbOkTXnrJevzPXf6a76NG+edJJrUyDZ5WEKDLufLJAmbxzNZySR8rUjA+HEfiquu0bYeyRE+iyziFrdldMXuv2v9Mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662300; c=relaxed/simple;
	bh=efAeJTccyDwjDi9JIG+yajzgq83AFdHTgIqSD0PmrYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B66DiBYgqAPKpdSxwZu5l3XdSFrb9LvgN1Oer1v61Uhyx4CcosAlOEaZew75YgMMb0mvwsTafj6JugQzGExe4K7hYFPBrpz791eAoIn0BrBj6yt2rLQExUsKPtmxOWiJCSxf81Vmm6GlMNuIacIOivTmI4I7IAhERkm6bwaR6JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PEt+lgN7; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PEt+lgN7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DF393C58472;
	Fri,  5 Jun 2026 12:24:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 115EA5FED1;
	Fri,  5 Jun 2026 12:24:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0BF3106A2026;
	Fri,  5 Jun 2026 14:24:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780662294; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=g6JWqQ8K4hb4JKzqWPYkjvjNujlBTcKRowoFnNjWI4M=;
	b=PEt+lgN78xaOrQCMV31uHjorvctWnpxfmfRXlF/q+nnYYrU3zZyOlTHwDWKdcvvPfxeF5S
	iASwtIIkww0TrrPYC8WR88IOy0Alb1bH5VqilZxgqYyn+85RtFue/bFUY17VcFjp8mmlTC
	OIBLYTsB1dkq9O8SPKoiSF+z1+qU/1YRmdbKUX+rp9U2hAN0wcId6V4mik6Jkjdyg9rlpP
	edinrta2g3un7PCEqJm1r3qMNs2wva26JJgTR9xDxPWXBSOZ1tmUklfNJ7mh5X9jMMiNfV
	oait1zy+B4F/daQee0yDuUaL+m9A8uCmgngaj3EhatHH06yoHDjKG/514s5Fmg==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Wil Stark <wil_stark@keysight.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject:
 Re: [PATCH 1/2] dt-bindings: iio: ti,tmp117: add binding for the TMP119
Date: Fri, 05 Jun 2026 14:24:45 +0200
Message-ID: <ft-705oeTSiaftSGNjv94A@bootlin.com>
In-Reply-To: <20260605125332.151b92f8@jic23-huawei>
References:
 <20260605-tmp119-v1-0-349f45f17d12@bootlin.com>
 <20260605-tmp119-v1-1-349f45f17d12@bootlin.com>
 <20260605125332.151b92f8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartCfIPsb9KRKaNwBVFeHLT0Q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPartCfIPsb9KRKaNwBVFeHLT0Q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Date: Fri, 05 Jun 2026 14:24:45 +0200
Message-ID: <ft-705oeTSiaftSGNjv94A@bootlin.com>
In-Reply-To: <20260605125332.151b92f8@jic23-huawei>
MIME-Version: 1.0

Hi Jonathan,

On Friday, 5 June 2026 13:53:32 CEST Jonathan Cameron wrote:
> On Fri, 05 Jun 2026 11:01:35 +0200
> 
> Romain Gantois <romain.gantois@bootlin.com> wrote:
> > The TMP119 has the same register layout as the TMP117, and a better local
> > sensor accuracy.
> 
> Sounds like (and the driver changes pretty much confirm) that this could
> use a fallback compatible to the tmp117.
> 

What do you mean by "fallback compatible" in this case? Do you mean we should 
do something like this in the bindings:

```
enum:
       - ti,tmp116
       - ti,tmp119
const:
       - ti,tmp117
```

But wouldn't this invalidate existing device trees which only have:

`compatible = "ti,tmp116";`

> The second patch then just resolves the print that would happen on older
> kernels using that fallback due to ID mismatch.  That's fine but nice
> if older kernels can work with this part.

Sorry I don't quite understand: since this is a feature patch, I don't expect 
it would get backported onto older kernels. Therefore why would the second 
patch resolve the print happening on older kernels?

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPartCfIPsb9KRKaNwBVFeHLT0Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmoiwA0ACgkQKCYAIARz
eA78uQ//QGpKtiBR5WpK1ybXt7R91LQrBYZFr56WNqES7iwCeGoHmxnHDEde6d6x
QhDvXAXfT1FtL/j5x4R+Al8N1goxFHzXnok0n+Jv02FoK1emIGrnjN1YGcFvB74c
nE7E/jQzMucZICZLcul5dcRYowiLhFGm4ISXMhlXFkKhFOD9CB+A45gagLLIFIxz
ftWWSgShxxGcHv7gM/fKHDwcrLtegHxRI0z/Vt2cYGC+JQZi/Vjj0gDWR12SHbkE
U5/upFzWnS9zN8vhjU6lYy3KCxcHcdDD/UR0gr2wOT87zM8a9dZABHv7+imDWkqs
3KDK/ru8nG2IOn6ioqKqDIiRz/YS/j2MeJgvoXpFnOkTgsbYtLcum6mdAAIvhDMj
MXkb7NIHdCOBIpE4PD7GfZ/XeOEhgAlrG05K+Izcf6kvleaNs9k5Kt2/I31HkXB1
TbQvtvoYOSuiJO4qJTXCuUBo27OpQtDCLPj5lillggpClE6i/dd1NliKzTGlyg5G
2vUJpeRKHoCOOdKrWwv3Den48XdBqRXxWY+bob5+n03HzuZGPxfj3z1hjiKgaYJt
Hib0roJ1cGpvz8rzlvD056iEGq5rTDr6IOUYjnAA1Eg+Qi5oDsLRxQb7Shmh7KA/
Im3AlxcCgbHgtNOzpkXxY40DzkCYYrW97U3ppx4Ap/ggHJTEMGQ=
=M5o0
-----END PGP SIGNATURE-----

--nextPartCfIPsb9KRKaNwBVFeHLT0Q--



