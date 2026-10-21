Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608736;
	b=h/HR7M68fAURZII3dR/m9Y3bclBvkXCiy/szkJqdILsYIVpdCP4mpGpmSr2Wydv4Qqmy
	 j3JwbqFNjZPsXCqfiLdnOGqStlTkNV4ThyKpbOHRqNwlbNTAVEutD7eoHUeInzxbYgstb
	 a8mm10y+PTcA9Xw91J7OmilFNvsfkTZBQdZrfEV4WClAhfvc16LiGu8UdmQmMZzBofIKF
	 EADuMP7IPT/fvQ/UA71Rtw++QVA4ABA7WVqGPe2bhAsVzah6IWlh6qTQfVLm0oOay37LU
	 xLQLG6wSJof2muSoI3v+31snRZIRfMiUdGKt2lOSM/C/AIuDDZCwTB+uXwqfM0qOK0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608736;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jB5ppw5g9XuIbpZjbjR+yU7oJ0n5SnIINV0oIiTpcHw=;
	b=lp1t4by97HXOusaEFJH2McSPMgxtIuTSkJ9Fuehvgz3mzeMD/NVlyu5JXUFuuRVRbknx
	 bZtCHtMC/bJ2JYYGV1CoGBqoiA2+WhW6oBcbq7KGgNxlgBP3Z+PNJg7qY4Y/9Zi+ETgvb
	 gEVJwInISks1gwge4Ml5MZLKENH5Aut80rycoBEIPdpYEEDQRps0mJ+EO+cUIQyk94cXi
	 hk46d0cETTYjQrb5j6/zqysXmRtx9BV6P4GwhxdHd5M8H25ohrb+MZByK67YU6tanRe76
	 vEudg0ye8sH2Wvh/+hy8pvzHLe+wZnJuxVEPkLXSiCN2jLaObzqhCTyIn2RFt6mt+hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPmvHM3e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE6606A319;
	Wed, 21 Oct 2026 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPmvHM3e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AB31F000C1;
	Wed, 21 Oct 2026 18:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608735;
	bh=jB5ppw5g9XuIbpZjbjR+yU7oJ0n5SnIINV0oIiTpcHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jPmvHM3eImgzIMZaSjwTv9tD1f/19cRnVKWV8A6JUkh/PHtskj3ZkDgUhk0lwXi1T
	 C+W/0ey85qnU8irGdLkBHYEkoOGLwKFk6u0HsKT4vLpNst1/76/4wAdt/C5w6srlJ4
	 ZGetUJWaKsOB2/Hv2cFF+RYSx8fG+Ey6jZWx7bJXckH8wVuSMf5+Jz2NR2vJGsgEk4
	 qDsG/+UHHbmV3ZD8n48VqUFEDu1ZJubo6Sb4kO13WmX3wKfA19MybiMpyauNML/TT7
	 vjMnf2HmLGdS8jQ3TjbKhpPawrfcppUd8G5jbUZ94BcQODPvNyyuF3pnfbDC7bHxU7
	 UkcLFbBO18nIg==
Date: Wed, 21 Oct 2026 19:52:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Ariana.Lazar@microchip.com>
Cc: <dlechner@baylibre.com>, <linux@roeck-us.net>,
 <linux-hwmon@vger.kernel.org>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <linux-kernel@vger.kernel.org>, <andy@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/3] iio: adc: add support for PAC1711
Message-ID: <20261021195208.1693a46a@jic23-hlaptop>
In-Reply-To: <514e3ba1e9dd5f49afddf5c81ed6b9c38329102c.camel@microchip.com>
References: <20261007-pac1711-v4-0-6ef34d7a7947@microchip.com>
	<20261007-pac1711-v4-3-6ef34d7a7947@microchip.com>
	<20261018202704.4ac77274@jic23-hlaptop>
	<514e3ba1e9dd5f49afddf5c81ed6b9c38329102c.camel@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D (u32)info- =20
> > > >chip_reg_data.acc_val; =20
> >=20
> > Could use lower_32_bits / upper_32_bits.
> > Maybe we should just have a helper for this given it is
> > becoming rather more common.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_fill_val_int_64(info- =20
> > >chip_reg_data.acc_val, val, val2); =20
> >=20
> > I don't mind if you want to leave that a follow up for someone else
> > to do though. =20
>=20
>=20
> About this, would you prefer me to add iio_fill_val_int_64() as a
> precursor patch in this series, with PAC1711 as its first user? Or
> should I use lower_32_bits() and upper_32_bits() in the driver
> implementation and leave the generic helper for a separate follow-up
> series?

Prefer the helper - but not a strong preference.



>=20
> > >=20
> > >=20
> > > +
> > > +static int pac1711_parse_fw(struct i2c_client *client, struct
> > > pac1711_chip_info *info)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &client->dev;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 const char *acc_mode;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D device_property_read_u32(dev, "shun=
t-resistor-micro-
> > > ohms", &info->shunt);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return dev_err_probe(dev, ret, "Shunt resistor
> > > property error\n");
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!info->shunt)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return dev_err_probe(dev, -EINVAL, "Invalid value for
> > > shunt resistor\n");
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pac1711_init_vbus_vsense_ranges(inf=
o, true);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pac1711_init_vbus_vsense_ranges(inf=
o, false);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (device_property_present(dev, "microchip=
,accumulation-
> > > source")) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D device_property_read_string(dev,
> > > "microchip,accumulation-source", &acc_mode);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe=
(dev, ret, "Cannot read
> > > accumulation-source\n");
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!strcmp(acc_mode, PAC1711_ACC_ENERGY_STR))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->accumulation_m=
ode =3D
> > > PAC1711_ACCMODE_VPOWER;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 else if (!strcmp(acc_mode, PAC1711_ACC_CHARGE_STR))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->accumulation_m=
ode =3D
> > > PAC1711_ACCMODE_VSENSE; =20
> >=20
> > Can we use fwnode_property_match_property_string() for this?
> > Could add a device variant for that to make it simpler still.
> >=20
> >  =20
>=20
> Regarding this comment, I was wondering if
> device_property_match_property_string() is the function you want me to
> use in the driver implementation instead of strcmp():
>=20
> https://elixir.bootlin.com/linux/v7.3-rc7/C/ident/device_property_match_p=
roperty_string
Huh. I wonder why my search didn't find that.  Indeed!

Jonathan


>=20
>=20
>=20
>=20
> Best regards,
> Ariana
>=20

