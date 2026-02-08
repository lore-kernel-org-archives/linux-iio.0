Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443F33D517
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770542104; cv=none; b=C9qBScoeEbTgPfalfPuPk3K8xcwh2HhqeDlVb01gyq0b0MhLUfdiYkieAwxdndZhz9RKUkQwYEfcPJ+oUXE78N8g45UH4B3psffV8ll5f/Ec900HlFw5hVIpe8vSzhYePQcwciFdYLwcBPEMQbU5XK7dE/JwiPt56klDO0w9baQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770542104; c=relaxed/simple;
	bh=07P0GHy06LjBjv72WxbCcNhfOqTwzCff4ji2MZrUdWk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNH2sFzejZkRlsn1LMC8+iF2plV3nmUnKBqy+C//QfJUI88TSSPFLjPj5UjKlTeEwuAPdKXPAI3DvuS9Lqi2t7YITqW4sDOSi07MSKv42Rgosa0hs9Zm4c/zb8JjlEpJmAIwtW3ac0b0GKrWM3YmKpRWs3jU+QlBBwd88oCcexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4/eSa/k; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4/eSa/k"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so23507745e9.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 01:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770542102; x=1771146902; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=07P0GHy06LjBjv72WxbCcNhfOqTwzCff4ji2MZrUdWk=;
        b=Z4/eSa/kl3x/7nqPQiXj5nxNsC4HB3n9kfT7eyF8Ulb47Ez74sZgHjcOi4Ry7LPRe+
         fP3v3/isBjft8s/1OMMuw6ioQKP9rsvqdbBQkh60aIQ3ji7vqgKsq8cLhwPa0GyA9+au
         PJ5NltvG1rqEC9TDQNpb4vlXUC7hfNIIkYAtMYHua/r6GAiJL7v8lL4XmnB0xln60/jt
         m7T8VFU1tV281JBJeE9YS+dc5flAuF9oRrJM3N+/lq1ey+pzN38+nMayc2IXP4vNuGiJ
         eZLzs26j/Od8UGXnbIaosHBwoQJjyS7s82oN7thYWIpLZ4v6O2zzXdigzI+k1AqbnVR1
         kDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770542102; x=1771146902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07P0GHy06LjBjv72WxbCcNhfOqTwzCff4ji2MZrUdWk=;
        b=rQl//ToRJSX77YAGzJvTiAGdfa/He9xGT1U2BK1fhooOK6OzrpL8PnVbGb04HUBnwQ
         3iq+ETARMh58xjqDgi+FkHWJbOZqvT0+mo5n0UVaqnRVw/4KVo/Ks4prqBgp2Lo+Exic
         eogEOExoxMCSN+8I4Dph0h94ej/Cxw+E/vVsoBAqOmyIQQ6AL1DO5UiIPQitu0+qb96C
         fNGfs+eXo6WZ2Yjfb11KT4r8j7VhX50hlfAZwedgf3jVeLBspoyhRmL2Se9NbfFmcG7w
         OZ2/fjPKfgh3SHJF4uVFG24gMemAWF1AN0Hz9wMeD0ugGP+f0PurFyqgGJy+4pVUVwYr
         uPZA==
X-Forwarded-Encrypted: i=1; AJvYcCXSJtwUfE2/+mNBo1CF1D18bwRTcahQ1s3TKHZoyWc3iS8vzh1G1eZeo2AM0b5FFiKoYzR92VAFlGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/SrnN/QVToSnAiKOavvkLZZcmXeptOPNBGqw9v+/Mzyobx9j
	OlC6d8QG92C7D2guRNokmpP5cxdU/35jJLDyoVzi+WWNiJq9j5c7BNfg
X-Gm-Gg: AZuq6aKDfN5bfHQdOs4946NfERUrsTb6N9aBDW6Rf3MN6GdwgghHPXeZpoSpzC2I7zw
	/LIMMw/xsRP/5AYavldLFvuf1Tu7d9DamrAu8SoDDfzHvvXnWiwian5+aP3y9waFW+iTNEpOu0x
	Xs+MWBFn/B1tXT5yvxzgFXp1JsDs9wMcAALx4jZDuuacpA4yA2EFVazZKulWCGfmTdhjnsCH+iu
	n6XOufUvi++K5r5OSHnFi9Opz0OGUiUEx9Ct0dnDMesUnzYastNNyyly63CNeWq7Eg8UEYrs8mH
	xY/iBaDO3YHPo+tZrTc2pQE8NOQdNwxLBnAH+KqRp28ujE//wiqsdm2Mq15KYYa6RRVpYj8elCA
	WBcCLTFceVD12MoV6A4nRgpvrJhMjwD+CiudjHTHWdr0N/neKM3vD/zzNo4L6X9hA6lcBEq6eZi
	aGpu/f91koml1Ia2C7N3d6z+2wKg1ngkntViZqncJeYuah7vh94zdPsWGV3+lQSB1L/P+IDw==
X-Received: by 2002:a05:600c:468b:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-48320229220mr115256145e9.31.1770542102400;
        Sun, 08 Feb 2026 01:15:02 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c0296dsm163879985e9.1.2026.02.08.01.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 01:15:02 -0800 (PST)
Message-ID: <b3571244f058133a7a0f3b5ca6ef7dc377e3fac8.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan	 <olivier.moysan@foss.st.com>, Mark
 Brown <broonie@kernel.org>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Date: Sun, 08 Feb 2026 09:16:06 +0000
In-Reply-To: <20260207-evasive-mastodon-of-apotheosis-e663a1@quoll>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	 <290f35bcbd2f1ee68333ff65f89b54ec7fbb9c53.1770393792.git.antoniu.miclaus@analog.com>
	 <20260207-evasive-mastodon-of-apotheosis-e663a1@quoll>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-02-07 at 11:41 +0100, Krzysztof Kozlowski wrote:
> On Fri, Feb 06, 2026 at 06:07:15PM +0200, Antoniu Miclaus wrote:
> > Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
> > with integrated fully differential amplifiers (FDA).
> >=20
> > The AD4880 has two independent ADC channels, each with its own SPI
> > configuration interface. This requires:
> > - Two entries in reg property for primary and secondary channel chip se=
lects
>=20
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/su=
bmitting-patches.rst#L597
>=20
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings.
>=20
> > - Two io-backends entries for the two data channels
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > Changes in v2:
> > =C2=A0 - Replace custom adi,aux-spi-cs property with standard reg prope=
rty
> > =C2=A0=C2=A0=C2=A0 containing two entries for multi-channel devices
> > =C2=A0 - Add conditional schema validation for reg and io-backends base=
d on
> > =C2=A0=C2=A0=C2=A0 compatible string
> > =C2=A0 - Update example to use reg =3D <0 1> instead of adi,aux-spi-cs
> > =C2=A0 - Add AD4880 datasheet link
> >=20
> > =C2=A0.../bindings/iio/adc/adi,ad4080.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 51 ++++++++++++++++++-
> > =C2=A01 file changed, 49 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> > b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> > index ccd6a0ac1539..7108a91bb0bf 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> > @@ -18,7 +18,11 @@ description: |
> > =C2=A0=C2=A0 service a wide variety of precision, wide bandwidth data a=
cquisition
> > =C2=A0=C2=A0 applications.
> > =C2=A0
> > +=C2=A0 The AD4880 is a dual-channel variant with two independent ADC c=
hannels,
> > +=C2=A0 each with its own SPI configuration interface.
> > +
> > =C2=A0=C2=A0 https://www.analog.com/media/en/technical-documentation/da=
ta-sheets/ad4080.pdf
> > +=C2=A0 https://www.analog.com/media/en/technical-documentation/data-sh=
eets/ad4880.pdf
> > =C2=A0
> > =C2=A0$ref: /schemas/spi/spi-peripheral-props.yaml#
> > =C2=A0
> > @@ -31,9 +35,15 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad4084
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad4086
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad4087
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad4880
> > =C2=A0
> > =C2=A0=C2=A0 reg:
> > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > +=C2=A0=C2=A0=C2=A0 maxItems: 2
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI chip select(s). For single-channel =
devices, one chip select.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For multi-channel devices like AD4880, =
two chip selects are required
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as each channel has its own SPI configu=
ration interface.
> > =C2=A0
> > =C2=A0=C2=A0 spi-max-frequency:
> > =C2=A0=C2=A0=C2=A0=C2=A0 description: Configuration of the SPI bus.
> > @@ -57,7 +67,8 @@ properties:
> > =C2=A0=C2=A0 vrefin-supply: true
> > =C2=A0
> > =C2=A0=C2=A0 io-backends:
> > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > +=C2=A0=C2=A0=C2=A0 maxItems: 2
>=20
> Instead list the items with minItems, so the order is defined.
>=20

Also looks like we now need 'io-backend-names'.

- Nuno S=C3=A1

> >=20
