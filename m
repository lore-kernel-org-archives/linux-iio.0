Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87934FF4D
	for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629995; cv=none; b=UmQc2a97VhdSy/x/UmJXEZzlx8FV2izUcK3gB8ZXagierrDRkxvKuEP4L4o2XLE39y8KJPBKvLgpZFpeQWsQm5B6c6426ZBhgr01pTumvV9exeecy5AsQYjMuE3MzOt6iVUbu8fFO0z3bjekSrMip3eZ0cLu9doAolnY0eeb52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629995; c=relaxed/simple;
	bh=nmnNOSZra5VKM8rRDPTT6EwSxDFRxMABF7GuoB2jK3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EF5ywKjEhStOafxiqV2Sqsj95mufOB2cf066CC+7zik0frqC2jVp1TSE4N+i18oeZ8s2Fn8CIRw0qjqSAY3nxV/j56DoZAWSVlqBLFw0M2C/JzgqWRnqp1i1U12cr3lez630bXBUaXz6262o41wI0rdybWsHUFFC1BS0B8sE0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X3qCbJPR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X3qCbJPR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so17675595e9.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774629992; x=1775234792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmnNOSZra5VKM8rRDPTT6EwSxDFRxMABF7GuoB2jK3A=;
        b=X3qCbJPRTd7xbL8qvOAhh5t2Vm89DA/HzK3ek9oBYqvAwJUPNCGTFVTN1aMv4sirfV
         24R5BFyO2MlgU3v3mspvTkzF5SfBWsfZSbxwqOmh4YDwvhfpR03qhO7U0Gk/ODtmGabw
         RMm83677nQpXhimbI5ingMvYkUoEx2cNGUYha54X7UR3zxFkMiujrBKFNNKlvJtmiKQU
         ek9RCjm6wKg6BM7i1Sfdiea0tqahMZy9E+MZxsPyE/ZyCIfVU+efH1cWOglUZmp2y55E
         IqCzgVtLs8ZKkhNV7OqnFtcOSRUPRfiSpBxhrKHQt/j3f7oB657w05WeDca3MPtZiwKt
         OUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774629992; x=1775234792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmnNOSZra5VKM8rRDPTT6EwSxDFRxMABF7GuoB2jK3A=;
        b=hO+BbY605WB7urBh4GPd1h5YY6wQSzg7k67rtwtqIcVIedFWCD5XUqkYQnCFXTrPkb
         hElho5nZnw2sfsKwWwVqm/w29uXEBZjJFWWQHUhBU9wyBn85jp9EAaT8x/6J3pRvsjoB
         67Cq4CNpTB3YYRmWoC2qZuOr/KYWx5MkSQWqHgreVV2qmL8iRadp740V4advjktaIg6+
         9my8v4zkQHmj+fy3HKVfgXaZwNxwAgMQdSC55ZBb1ex0gpPcPIdLrjBK/nNrwVae5bZi
         lj2QqZN5txpQnFLvwsUB1tKC8dDNRyQhbCxHw19NhDE3o63wwxXZoq4b9A34J5gcitix
         wRvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1YbK29ToThX1rmSjDCJjEgdIwGoYH6ehbdkfhnYtavkeKfTZR1k/jE/JyqgG1vhQPPYqo4zxX89M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtwxsHEdVH4MS9S3KE3FM7spb3d1asiHl/FFXgdEDLqAZszsWx
	fLkDH/WL23XZboQ3ovU9onc8cmxx/pz4d3erRYk29m3jG1ptHXKtdLg6jwBWFFOPaLU=
X-Gm-Gg: ATEYQzwG7sZYYHjEKPjxiUCktFtTtAF0WKvjuMSzwBa4yp0AKD9boM1eyBv33sYuDdk
	HjJFLA3er/r02fwSqbBHVnacpGv9CKDolFetojTiBFc257tVj3funzUAydT2dBrCK94ANh3YzB0
	OPJsepTll6fmZf409VMOEBttlNxeDD0F6tQIQUCgk2QsL0Rz6BVnM6TdgvsEGGgjcZf6oo8+gPv
	7hgFnU4kdpGpMU8Gn6bmoRDiD/+2jQusicBY1gUThuu/uSCaNOCo7NMjPHNu8KPU9/FSvA6YYYO
	DH1T5D27q+9yNb+3Cvf83CmH9pwiypVvXJq7LOIZxEQBJ+ib/07xtzZN4Vivp/9U1UfGVsvKigP
	lDbUanb3HkJ2Iqg+d5v3yQbqDhacfrpHkOWylrA9igouuGFjXw4zKnGJI/aPjS+KeA4C+vWqipf
	9PW9ghQhkMIlpAjUki3TCCZw==
X-Received: by 2002:a05:600c:1d1e:b0:486:ffa3:55f with SMTP id 5b1f17b1804b1-48727f069eemr56959445e9.27.1774629991836;
        Fri, 27 Mar 2026 09:46:31 -0700 (PDT)
Received: from localhost ([212.133.41.47])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48725eae727sm38380005e9.2.2026.03.27.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:46:30 -0700 (PDT)
Date: Fri, 27 Mar 2026 17:46:29 +0100
From: "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"magnus.damm" <magnus.damm@gmail.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: timer: renesas,rz-mtu3: Use #pwm-cells = <3>
Message-ID: <acax6VgK2hM2bjel@monoceros>
References: <20250527205823.377785-2-u.kleine-koenig@baylibre.com>
 <TYRPR01MB1561945B6057A2ABFCF25C6788549A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tqo3pkbr3kw3htxb"
Content-Disposition: inline
In-Reply-To: <TYRPR01MB1561945B6057A2ABFCF25C6788549A@TYRPR01MB15619.jpnprd01.prod.outlook.com>


--tqo3pkbr3kw3htxb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: timer: renesas,rz-mtu3: Use #pwm-cells = <3>
MIME-Version: 1.0

Hello,

On Wed, Mar 25, 2026 at 01:24:40PM +0000, Cosmin-Gabriel Tanislav wrote:
> Sorry for replying to an old patch, but the context is relevant to my
> question.
>=20
> I'm working on adding MTU3 support for a new platform, Renesas RZ/T2H.
>=20
> From this patch, it is clear that new platforms should use
> #pwm-cells =3D <3>; as <2> is deprecated.
>=20
> What I would like to clarify is whether existing platforms are also
> expected to be migrated from #pwm-cells =3D <2> to #pwm-cells =3D <3>.
>=20
> My understanding is that changing the provider to #pwm-cells =3D <3> would
> break existing consumers that still specify only two cells in their PWM
> specifiers, since those references would then fail the checks inside
> of_phandle_iterator_next().

The conversion doesn't break dtbs, because in a single dtb consumer and
PWM device are consistent. So from my POV updating is fine.

> There are no existing consumers in-tree, but there might be out-of-tree
> ones that depend on #pwm-cells =3D <2>;.

That might happen for out-of-tree dts files that include the SoC's
=2Edtsi. IMHO it's ok to break these.

> If we're okay with the ABI breakage I can proceed with the changes for
> existing platforms too.

The reason that made me stop continuing the conversion myself is the
somewhat stuck discussion at
https://patchwork.ozlabs.org/project/linux-pwm/patch/crk42dsypmbyqk7avldghj=
q32vslmalfmmouwxzgtdci4agfhz@rkbmxj5z22fx/
=2E

Best regards
Uwe

--tqo3pkbr3kw3htxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnGtGAACgkQj4D7WH0S
/k4B7QgAkrjyiqIOxfTYLU37jtZHVvglcPCSu+AxXEZvPLhgJIbGOX2Whlv8Itm3
TjMQW1kSHf86Ml8+Us0r1Gfg0xtdpWTCLXoG9X8SwNRHo5Bs5kPE2BjE3jnimbUz
N2e1EyuC1MlRRm3Qth4APLqn1O/qGM+LhTqJpWzRt3hakH6sZbulAjYgIaZ3c3hW
ZziSJpkddseN2oiIX0G1x4c51+sw2IMsZd7slkc+6gZvXAV9PFrzm47cp6lm655j
D4mnnifOPJ0IQY+mgj73yl4KBOyhYejTnRS8WuyUxySXomY4wy9hnYNE9SdWzj70
br7SBGxmv4WPfuvCiMGrtBmIkObrpA==
=a9Lm
-----END PGP SIGNATURE-----

--tqo3pkbr3kw3htxb--
