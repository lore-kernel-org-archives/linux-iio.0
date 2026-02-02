Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1221CC59
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028389; cv=none; b=NIZVPvVPr/q2IXoOO9UsJqEyj09RU2oQ+zIjoE2ggqE6YKbgJ7B67M6qS1hAPrFtrTNs1EkWSv71J+QcIJ7T2tUayyOBODuaSvlE7P3J3/PPx7fuC1HBVWZixlU6SSrbVOxab75zb6Ff0TMFHJqIpLIQrFZ6Q4tvRA3TZpmFllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028389; c=relaxed/simple;
	bh=DM2VRKUPokmdre5IPttTy6qbwBHVuiiOks6itZZnwBs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V8BClPxIzMPV3OB3glouno+NK5EQcM/YQ1hf8uibq3nTEGbfErIcNSbOLYEbDIPFMlI2/w1olqhi2rTDQBTmaGo3reJWUz5isL5/MHc24VPHTxG/NGu8s84Hf9erh9q/sMT2Pi+r/YfmZ/YPSB0oaSMi6qKbVgk+LpAM8V+x7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtEMIXcz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtEMIXcz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806f9e61f9so21309925e9.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 02:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770028387; x=1770633187; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dn+DKTLq3TUfgg0k8XN0MShRi13GAK4oCUvSnj3CWEo=;
        b=JtEMIXczczCczreemscV0s4XequO/ju/BqlkKDE1i/HWGwb72APUgbFHVB/g0+TifK
         6TCLo4YDH2fOgPK637cN3OtYPsswo4FM22Etd26HC725o5yx5eaXpmkZiIHvgnzN46Rf
         5CzvPAtEA7cvmLT/wPQMCBTkxFTO0F+6sz+HtgdDOgWOLKnMDSokxrUC8M+mZGq150+p
         +itH2k4xDG6vjRgxecxZvxYLM3Gb8tS5cg1CGU2J6GQLlq0Qg7+1wHP+gPgQnOFdZU83
         /aU2nVo7uTUCqAeQxU5hTEnXjCG2Zgb+DipvEu5+c4p/XM/ukf/r7LbfZ8yL4UziWzUr
         QbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028387; x=1770633187;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn+DKTLq3TUfgg0k8XN0MShRi13GAK4oCUvSnj3CWEo=;
        b=DwVGSDYtMUX9IX9N6hJ8cBXhADomzKnQxzgKVzqI+OttJYROXmpnJf51LmX9mHH0u/
         g3geswIJFX+xEG8Z12alWqklqRzefKgubviTYOq/fAAKo0L8St3U+fpo+BxecfhpkpWe
         7IjIxYt0Ek7Q3nLrv4t6c9sctUpMYhpmjejBy/LjAiomq+azTaYLv3vnXvL6yU/6dv1W
         6GCyW6u3hNHlGpIbVwZ7rDrgwYMM0N924II47uBcJsvQCG+uCYg4zvf9Ro7b7PGma6Zc
         4JlaFM5VcavwzX7f+YSzsiD+I4j4JrrDNsEKgTaOkQQhB3e+KLlN/fKT/cvLBHM1b52y
         7vYQ==
X-Gm-Message-State: AOJu0YzcXLr3RGl1i5EfgO8pVEJ8POQlGlgVaGoHYGNnFI48EaAsBSSR
	r3Yr1w5Iuz7G5Uqb9jFa8hdAk+SDV3Z+yDeaqbIpvZdejigGu6NYVerV
X-Gm-Gg: AZuq6aKmu4+CGxWFhxcoxvaXXm/3dGeWEH2+Ti5A4xLdjkXOmt4yHhWPsEbx4/76Zfy
	4CgOJvSrG3HfU8SHXk/dalaPbkD6gTvFnE1zIKFePMD6jaaJF5bM0h89uKQQWdrQXqwH1pWAMaR
	/XGssRIjK4tnaBzJLA7vXXjzlO2uT/6P5P5kF571rFI1RCPpQ59AJEkMyroI5kNnGnpZwkzeC51
	C5ha52nW62zYZVa1bFaIKonSvIgpPfrqIgWAnUGsitkC38ySXz9SwhZPFb8EeKlILCNiQaOn1nZ
	RgOuxDrZBcgnOa0Hbk8SoEb2ebgS9mG61yAhdgpLdk2ja1uq6neKfKRcDrLV+fIVGjE4KeljtB5
	j5RMnKb1TBa5mRCvtkjw+UBjT099d3K1KDBhx9RMmdxdUkO+xF+oxvSuOddnOmdCDntWYhcGPWk
	tBN84rrdPYMo8yOxlld/c=
X-Received: by 2002:a05:600c:3e1b:b0:480:32da:f33e with SMTP id 5b1f17b1804b1-482db47ce18mr140996085e9.17.1770028386734;
        Mon, 02 Feb 2026 02:33:06 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bfb59asm429745315e9.7.2026.02.02.02.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:33:06 -0800 (PST)
Message-ID: <1bb1a96bf00a518747b5d82c1c623e5d202c6417.camel@gmail.com>
Subject: Re: [PATCH v5 3/4] iio: dac: adi-axi-dac: define supported
 iio-backend capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 10:33:49 +0000
In-Reply-To: <20260130-b4-ad9467-optional-backend-v5-3-7da803ba7326@vaisala.com>
References: 
	<20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
	 <20260130-b4-ad9467-optional-backend-v5-3-7da803ba7326@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-30 at 09:17 +0000, Tomas Melin wrote:
> Backends support buffering capability so advertise it while registering
> in case a frontend makes checks for it.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/adi-axi-dac.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index 0d525272a8a8..cd06cd4587af 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -869,11 +869,13 @@ static const struct iio_backend_ops axi_ad3552r_ops=
 =3D {
> =C2=A0static const struct iio_backend_info axi_dac_generic =3D {
> =C2=A0	.name =3D "axi-dac",
> =C2=A0	.ops =3D &axi_dac_generic_ops,
> +	.caps =3D IIO_BACKEND_CAP_BUFFERING,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct iio_backend_info axi_ad3552r =3D {
> =C2=A0	.name =3D "axi-ad3552r",
> =C2=A0	.ops =3D &axi_ad3552r_ops,
> +	.caps =3D IIO_BACKEND_CAP_BUFFERING,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct regmap_config axi_dac_regmap_config =3D {
