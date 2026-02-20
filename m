Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D533554F
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581852; cv=none; b=eIBbfptG7cdXYwMYUayG28hWx6ckCTaz6GTSufNy2eaIMuPY8G4r4gmRWXHGg0qd7s3v5o0NCYhqeeJLFzVv8mV6hKZ2GrXRIclIXH78OGX9GChwTEAWRWAC/o/OLQT/UF7oiXKeoYhcRfa2uzApjJdIn4uMM9+mEXO0Ep0+u5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581852; c=relaxed/simple;
	bh=kTreZf2G/97kGIQp4wKr1mOla33C1fYbtBD8CfkTbUk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DpkJhg3OEvtyABMQN4Qp+ioCN95ZUhDHl3AqLcLyqn1lM1T08GF8vrQ561rzpYSHy5JEicSsqTYeZNx2aandsWy9Z+OiiDLabJxS+ZCoeAinTv2RGcmL1eU0OUOCZviox/ixpo8N8SufPNAWQ4RpfyaF4JLuxTK75obUGMprMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU0sfIsh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU0sfIsh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4376de3f128so1249494f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771581850; x=1772186650; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ec7rjtcrNRVfu8jxhe2PQ7sdVPGB1y7/JEmMOhmbg8I=;
        b=IU0sfIsh62dFAVswfBGjyWSyrU+NEeG8yLzJjfZHTnlJ63xR1PH2t2CETkSKr/VZbZ
         ug/9sqICP2773UJ5XDgSBU3xVTg7nzTH8wckDQmhpQdyrAHgc0TC5jKARb3916xGVhLz
         iGQaXBzfLsjfybX/XV0C1T/B3SGn+RU//V7EYsW/a1RmCk9h1hfUJ/Wl6x6raQknIFF3
         iYq35PWqWfrYSm/c94kyaLGVrRTqqxt3a1FRUNk9WYUgXt2PyuMX+SDcXqt5TxYVR7gy
         57qOzV/o0z6qVUUWdNc43Wq4SqVch2TykSg2Ngccfvb90HlmHdV5Rrz+wKYDuTJb6qIl
         I+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771581850; x=1772186650;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec7rjtcrNRVfu8jxhe2PQ7sdVPGB1y7/JEmMOhmbg8I=;
        b=SD4MEDLTWN1+kiq0C5mM6vj3smZmz7C3mn9a1i11dJYLhGabiEpY8eMhtxV+InQ2xb
         SME3AqHuGM5TDyebByBVtSjJEAAyMN6BbxeDmp+Cl/YwTAHrCXj/BAyYGxwQTvwr/p8v
         yGecAKIY4mZz6NdmMUYeRDN07SIH0KYaGbRjtj5Yjzppfo12gctIKso+ocBzKBVEWEq5
         QXoGsOgU6NUcFsFk/6i2HuRnpjcFjSuFH+ALf+FMmMoo8ZO4Y3KCwglS2BwWFu9JoUMO
         zvAuMDqVC4yDMviBsCPegYUEXSY2yU89n9URHlaco24flJcPg9M3d/cM+sRWgpmMLutO
         D2kA==
X-Forwarded-Encrypted: i=1; AJvYcCWjZfUdyH6T4PWMUpuMxssCz2/4eJgrupdJBicomr7t4AfJ9mrz5qHXImQZlJRoHjoswTusNaII9Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUuhHXkkEPVJTsyM9CsFmtJKbfl7vpxq+Gxp/RYSOvGQR7GOg
	3U9n84hMPHQr9AczlzIrDAHC8Q/bqhDTeiD0nq3NXPHCYVHgfGaS5+fi8gDw8g==
X-Gm-Gg: AZuq6aIAmAbr7nHm2gGoVNgQtzWza8a6IMq/HfEDS/YxfHifzaT9/LheIVNtFyo/sw6
	+QYRmRnxXFX8xRx2cKFcFMVHIQcbhSgiSKe/mgQtDdIwqDsYgk1bn1SFd8Uw5bLAXDBhT0NOReE
	rQBYmia4lzZuwWtf/mzXmrZihx7w/TC5YmthmAccbWs3eZnWX9G2w0e5g8xZ2nbpzbq8C8/d30M
	hASip4f2iwNYfUO4unyPDynOAwtqEHbM2ua0o38YD3oHpa42k65zaSmXIVturojbElbOSG19mie
	qAbeKe9FI0cIys22SXnSNMbbBTzqME3xS+GdFWOCeKqhGqT/CQ6bu8z+dQRnMJYirj67ctK+4LD
	unDbQOocNhp/uTd9jGOJmWKg9B/WrXJggUgeur17Is68TumBoB1A8r6IG1D1q/wC8QwK1OBHMPW
	TJ+LEMN78rs/+v3ZbZemHUXMGFSLvsCCo=
X-Received: by 2002:a5d:5d83:0:b0:436:3707:2bf0 with SMTP id ffacd0b85a97d-4379db98594mr36063010f8f.35.1771581849452;
        Fri, 20 Feb 2026 02:04:09 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc85csm54159523f8f.22.2026.02.20.02.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 02:04:09 -0800 (PST)
Message-ID: <c59c19d923d369eac2a0a46405e13e41836591c2.camel@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7191: Don't check for specific
 errors when parsing properties
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alisa-Dariana Roman
	 <alisadariana@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>,  Jonathan Cameron	 <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Date: Fri, 20 Feb 2026 10:04:52 +0000
In-Reply-To: <20260219143936.2276366-1-andriy.shevchenko@linux.intel.com>
References: <20260219143936.2276366-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-19 at 15:39 +0100, Andy Shevchenko wrote:
> Instead of checking for the specific error codes (that can be considered
> a layering violation to some extent) check for the property existence fir=
st
> and then either parse it, or apply a default value.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Not really sure how I feel about this one. Checking for specific errors is =
a very common
pattern and this change just makes it we check for the property presence tw=
ice. That said,
this makes it more "future proof" (though I find it very unlikely for ret v=
alue o change).

Anyways, even if we choose to go down this route, I don't see much benefit =
in starting
converting the drivers with the pattern below (which should be a considerab=
le number).

- Nuno S=C3=A1
=20
> =C2=A0drivers/iio/adc/ad7191.c | 63 +++++++++++++++++++++----------------=
---
> =C2=A01 file changed, 33 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7191.c b/drivers/iio/adc/ad7191.c
> index d9cd903ffdd2..51ec199fb06f 100644
> --- a/drivers/iio/adc/ad7191.c
> +++ b/drivers/iio/adc/ad7191.c
> @@ -154,27 +154,18 @@ static int ad7191_config_setup(struct iio_dev *indi=
o_dev)
> =C2=A0	const u32 gain[4] =3D { 1, 8, 64, 128 };
> =C2=A0	static u32 scale_buffer[4][2];
> =C2=A0	int odr_value, odr_index =3D 0, pga_value, pga_index =3D 0, i, ret=
;
> +	const char *propname;
> =C2=A0	u64 scale_uv;
> =C2=A0
> =C2=A0	st->samp_freq_index =3D 0;
> =C2=A0	st->scale_index =3D 0;
> =C2=A0
> -	ret =3D device_property_read_u32(dev, "adi,odr-value", &odr_value);
> -	if (ret && ret !=3D -EINVAL)
> -		return dev_err_probe(dev, ret, "Failed to get odr value.\n");
> +	propname =3D "adi,odr-value";
> +	if (device_property_present(dev, propname)) {
> +		ret =3D device_property_read_u32(dev, propname, &odr_value);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to get %s.\n", propname);
> =C2=A0
> -	if (ret =3D=3D -EINVAL) {
> -		st->odr_gpios =3D devm_gpiod_get_array(dev, "odr", GPIOD_OUT_LOW);
> -		if (IS_ERR(st->odr_gpios))
> -			return dev_err_probe(dev, PTR_ERR(st->odr_gpios),
> -					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get odr gpios.\n");
> -
> -		if (st->odr_gpios->ndescs !=3D 2)
> -			return dev_err_probe(dev, -EINVAL, "Expected 2 odr gpio pins.\n");
> -
> -		st->samp_freq_avail =3D samp_freq;
> -		st->samp_freq_avail_size =3D ARRAY_SIZE(samp_freq);
> -	} else {
> =C2=A0		for (i =3D 0; i < ARRAY_SIZE(samp_freq); i++) {
> =C2=A0			if (odr_value !=3D samp_freq[i])
> =C2=A0				continue;
> @@ -186,6 +177,17 @@ static int ad7191_config_setup(struct iio_dev *indio=
_dev)
> =C2=A0		st->samp_freq_avail_size =3D 1;
> =C2=A0
> =C2=A0		st->odr_gpios =3D NULL;
> +	} else {
> +		st->odr_gpios =3D devm_gpiod_get_array(dev, "odr", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->odr_gpios))
> +			return dev_err_probe(dev, PTR_ERR(st->odr_gpios),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get odr gpios.\n");
> +
> +		if (st->odr_gpios->ndescs !=3D 2)
> +			return dev_err_probe(dev, -EINVAL, "Expected 2 odr gpio pins.\n");
> +
> +		st->samp_freq_avail =3D samp_freq;
> +		st->samp_freq_avail_size =3D ARRAY_SIZE(samp_freq);
> =C2=A0	}
> =C2=A0
> =C2=A0	mutex_lock(&st->lock);
> @@ -200,22 +202,12 @@ static int ad7191_config_setup(struct iio_dev *indi=
o_dev)
> =C2=A0
> =C2=A0	mutex_unlock(&st->lock);
> =C2=A0
> -	ret =3D device_property_read_u32(dev, "adi,pga-value", &pga_value);
> -	if (ret && ret !=3D -EINVAL)
> -		return dev_err_probe(dev, ret, "Failed to get pga value.\n");
> +	propname =3D "adi,pga-value";
> +	if (device_property_present(dev, propname)) {
> +		ret =3D device_property_read_u32(dev, propname, &pga_value);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to get %s.\n", propname);
> =C2=A0
> -	if (ret =3D=3D -EINVAL) {
> -		st->pga_gpios =3D devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
> -		if (IS_ERR(st->pga_gpios))
> -			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
> -					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get pga gpios.\n");
> -
> -		if (st->pga_gpios->ndescs !=3D 2)
> -			return dev_err_probe(dev, -EINVAL, "Expected 2 pga gpio pins.\n");
> -
> -		st->scale_avail =3D scale_buffer;
> -		st->scale_avail_size =3D ARRAY_SIZE(scale_buffer);
> -	} else {
> =C2=A0		for (i =3D 0; i < ARRAY_SIZE(gain); i++) {
> =C2=A0			if (pga_value !=3D gain[i])
> =C2=A0				continue;
> @@ -227,6 +219,17 @@ static int ad7191_config_setup(struct iio_dev *indio=
_dev)
> =C2=A0		st->scale_avail_size =3D 1;
> =C2=A0
> =C2=A0		st->pga_gpios =3D NULL;
> +	} else {
> +		st->pga_gpios =3D devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->pga_gpios))
> +			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get pga gpios.\n");
> +
> +		if (st->pga_gpios->ndescs !=3D 2)
> +			return dev_err_probe(dev, -EINVAL, "Expected 2 pga gpio pins.\n");
> +
> +		st->scale_avail =3D scale_buffer;
> +		st->scale_avail_size =3D ARRAY_SIZE(scale_buffer);
> =C2=A0	}
> =C2=A0
> =C2=A0	st->temp_gpio =3D devm_gpiod_get(dev, "temp", GPIOD_OUT_LOW);
