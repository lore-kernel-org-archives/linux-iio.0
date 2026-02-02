Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4C35B631
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028343; cv=none; b=DATI38gewUsApX3dk3C/A8N1iwPAP9613EXQ4ukLJgGghpfsJJcbYpo7fhldYD6czpGdPnrvdNtzA49QesC0Bd2r6pIIA63wbA3fatZ8gQcBJZ1DliALFbY0ccUQ1KBXb+6+95zOoPy9FCVnXJlG8IcwGdNld3YkFB23E5TalMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028343; c=relaxed/simple;
	bh=/bm/PFuNStpdgHLyuH7K1THdnVz/qvJlt68GMFCEU34=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYMan9LUWcxFgsg0tra9ONP39EhaGN7Ir7EKJC5gtiIvRfK6H6cWE8Mbr7/iDLWsGDbsTioa2IWXfP+I/qMp/y5X7YcZrwfK0LLKsJ45gd189Wekv4nLFftZKGYobQvuVAoG8FThVO3tW8VI6qlOlRV2tycqKMLGaLfbEh7vpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6WNnbrn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6WNnbrn"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fbc544b09so3972003f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 02:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770028339; x=1770633139; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lJ1U/CUHddZhq9GJQVy38JymXe0uWN4SgP7fr72nYbY=;
        b=U6WNnbrnvlMD8T0qTnzCRhB4zoJ0d6LDi8bep6VVRpl8960l4KRS6CTaoQWKDyUPid
         ck77PEmozWKUDwvBH5UgLJfD4XrmtMpXRrORzu0LQ5yPrAAfV6Z514qB8jNSjKKe7C5k
         3R81DLt1xbvW5VPEv/PTAAWuodIc7n+M+knx60oBFs1HX6G8BNFBh+NjNGBMoXpwuZqA
         ZJ+Vj8fpe6M+Wrg3euR2gayPRfS8kmI62S5Ig3Za3LLj1W617X6ZBPuAzSCSxOXGqKdX
         czaDFEz4jAFUvbzM/e0Hd7XPVM2rvq1SH5wvhCxDGUP8G77ZtmfTqB83KJfGQOfkGalW
         sxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028339; x=1770633139;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ1U/CUHddZhq9GJQVy38JymXe0uWN4SgP7fr72nYbY=;
        b=rBqTv0k7th+4JaYnXAdfHS/7mAebA8nAkjum4PGqDXelmVI74BhB12xDewhWhOW3Ak
         w9HOeG37RZUWgHmnAeJ3N0Y4cQduzMcVtBxeqB/XCbi8MYVtHMxIk4Wou7w3GJoouvw1
         ThBjtjc8C0KK9CVw1M/s3BSphCh0WBigwOWIuzVqMRxsDnoizUI9T58+Y2DHzSliVuSp
         VtwukhLtiEZKJuNN8sI4eAr0YjtE4rWTaz1bAZi0MhvlN7JQLPds30cKgLOaAS9O/zqU
         ZsOhIrMEdr/vB28MORGu5EjMkjyawQBCzDQ4Wrz8V/wfIj8nKHToepm0D/8TM8O2Nj3I
         ie0A==
X-Gm-Message-State: AOJu0YzEq/RHTtA3T3s6/vzIrcjm9WP0aTC6vg5GMAU6u9UMv2NGzqtc
	7D7xnpvYGYH5L1TyxDspVctwNM+37Hdtgw9GvUzxHWRPTMc7hTl8lQZg
X-Gm-Gg: AZuq6aL46GU7mqG7rMzaGihXVa2+rzMC/KpxbC8J4dwah/bjB2t5kEMppBwHJnnXZbB
	xT591izQzKrAunJLOvaklrUx+Bzbxl7p95j/rcV3co8RJCXvDvmTP0OIjfIYHb47ow5QR9BUIkV
	R6Km96OnzAwd+cuRwDRMNdEJZcrSGb/+LZkpCoym8ebnW05fwPZk1oPN/+tkpkzxdscjMG8KwNc
	1BO/RJZQc5gpi3bBQXxHyVL2yST3mUU4+zhRRJVj2OyRd2RSi8FrWzXKiK5UWVts0f76U91HDII
	eFI9ubUh/W2r6/DfOyUOxPPSSxmZv1N/2thH6ekm4eSTVpO8MiJWZ/3lo+3JkiDs4FvRnArSHwm
	PIKC0rvxcIsb/Sev2sw6uFeBkmd4e4wBLeAzH6u5+zPcXjV1h/nLBXYqwEni4AdDxbyDXAQfg1x
	pEwxMksaYDtYcsy8IcfHo=
X-Received: by 2002:a05:6000:1a8f:b0:430:f68f:ee97 with SMTP id ffacd0b85a97d-435f3aa7800mr16478916f8f.40.1770028338857;
        Mon, 02 Feb 2026 02:32:18 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4762sm41146213f8f.6.2026.02.02.02.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:32:18 -0800 (PST)
Message-ID: <1cf2ab1c16abe7288744e46395c8272d8cedb704.camel@gmail.com>
Subject: Re: [PATCH v5 2/4] iio: adc: adi-axi-adc: define supported
 iio-backend capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 10:33:01 +0000
In-Reply-To: <20260130-b4-ad9467-optional-backend-v5-2-7da803ba7326@vaisala.com>
References: 
	<20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
	 <20260130-b4-ad9467-optional-backend-v5-2-7da803ba7326@vaisala.com>
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
> axi-adc and axi-ad485x backend variants provide calibration support,
> whereas the axi-ad408x does not. Set accordingly.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/adi-axi-adc.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index 14fa4238c2b9..133aa6f43a38 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -626,6 +626,7 @@ static const struct iio_backend_ops adi_axi_adc_ops =
=3D {
> =C2=A0static const struct iio_backend_info adi_axi_adc_generic =3D {
> =C2=A0	.name =3D "axi-adc",
> =C2=A0	.ops =3D &adi_axi_adc_ops,
> +	.caps =3D IIO_BACKEND_CAP_CALIBRATION | IIO_BACKEND_CAP_BUFFERING,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct iio_backend_ops adi_ad485x_ops =3D {
> @@ -650,6 +651,7 @@ static const struct iio_backend_ops adi_ad485x_ops =
=3D {
> =C2=A0static const struct iio_backend_info axi_ad485x =3D {
> =C2=A0	.name =3D "axi-ad485x",
> =C2=A0	.ops =3D &adi_ad485x_ops,
> +	.caps =3D IIO_BACKEND_CAP_CALIBRATION | IIO_BACKEND_CAP_BUFFERING,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct iio_backend_ops adi_ad408x_ops =3D {
> @@ -670,6 +672,7 @@ static const struct iio_backend_ops adi_ad408x_ops =
=3D {
> =C2=A0static const struct iio_backend_info axi_ad408x =3D {
> =C2=A0	.name =3D "axi-ad408x",
> =C2=A0	.ops =3D &adi_ad408x_ops,
> +	.caps =3D IIO_BACKEND_CAP_BUFFERING,
> =C2=A0};
> =C2=A0
> =C2=A0static int adi_axi_adc_probe(struct platform_device *pdev)
