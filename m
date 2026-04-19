Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AE263C8C;
	Sun, 19 Apr 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615910; cv=none; b=BZyh3PTiI5GWK7c+AgvfO4Hg1MF3rONSFfV6bZR30fjHChUKGRrlSPKKT01vYCevRwL4CPg6gnProTqnv5Agixdp6UsYrxNiLxxrP/Z7AiQm9jKJH9xGC+O4kPZZ3CqRDav+dA6PivyHrb2Ko3kxpaa8NVyCdgHjmZM6IMDjcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615910; c=relaxed/simple;
	bh=BqD04MLN2XQ4C4d7UwmrmRfYmlNilOP3w6ccELCcQg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wia2/JqNaW5oUtm1qg6j6ng3K18nLGu1kngydKjAATs75aWBqL71JNb643fK4mI7y2Hx2NCzF78X6GQ9PW528gHoURrs60V33qVM2nGGCZF9mLeWI009Mmq28IK9KWANkeagpaB++UthwjK/nBdHy7VNJj4wj8B3UaYJDyVz2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIm/sXn7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIm/sXn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2980CC2BCAF;
	Sun, 19 Apr 2026 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776615909;
	bh=BqD04MLN2XQ4C4d7UwmrmRfYmlNilOP3w6ccELCcQg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eIm/sXn7RMk+tPtu+qxhU8sOEXTMFipaNbu2hGbHMjvJiDOn/Pee9QDb+inbBHgOF
	 tHOuduN1yMnZ8gT/eiv6z2aHA3ZzNKADMQI0vhlBz2Fvz9tDi93LOmC62CPtmQKKbD
	 2svUds9iIG0Y0H98pvZL23EW6nN8I2jbLuTeS7qp/AZVtNtqaOX8Ng3x9S5MDkQhS8
	 84fBuoOo+NezrB65qfgkGMyOPYj77m2Ax4AkLuBswgILRWO9NXqY9SD5HvAL3kQdbk
	 t2n/xkSWr/+2PG7XI7UzpOEmbyysDePMQtf+i/lX9Q0C6yYyrbaVetr2LzDuImVogV
	 pHFObjX1goe8Q==
Date: Sun, 19 Apr 2026 17:24:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: tsl2772: add support for Avago
 APDS9900/9901 ALS/Proximity sensor
Message-ID: <20260419172458.375e7897@jic23-huawei>
In-Reply-To: <CAPVz0n048kPMAnGQpOk0_SPtQ+hz=-p6jdyRYPB5d+CD9i7_Cw@mail.gmail.com>
References: <20260419083125.35572-1-clamor95@gmail.com>
	<20260419083125.35572-3-clamor95@gmail.com>
	<20260419143751.11ec0b69@jic23-huawei>
	<CAPVz0n048kPMAnGQpOk0_SPtQ+hz=-p6jdyRYPB5d+CD9i7_Cw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Apr 2026 16:46:25 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BD=D0=B4, 19 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16=
:38 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sun, 19 Apr 2026 11:31:23 +0300
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > The Avago APDS990x has the same register set as the TAOS/AMS TSL2772 =
so =20
> >
> > A Sashiko review comment makes me wonder about one thing below if the
> > register set does match.  Maybe it's a bit more subtle than this
> > patch description suggests?
> > =20
> > > just add the correct bindings and the appropriate LUX table derived f=
rom
> > > the values in the datasheet. Driver was tested on the LG Optimus Vu P=
895.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/iio/light/tsl2772.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > > index c8f15ba95267..8dab34bf00ca 100644
> > > --- a/drivers/iio/light/tsl2772.c
> > > +++ b/drivers/iio/light/tsl2772.c
> > > @@ -127,6 +127,7 @@ enum {
> > >       tmd2672,
> > >       tsl2772,
> > >       tmd2772,
> > > +     apds990x,
> > >       apds9930,
> > >  };
> > >
> > > @@ -221,6 +222,12 @@ static const struct tsl2772_lux tmd2x72_lux_tabl=
e[TSL2772_DEF_LUX_TABLE_SZ] =3D {
> > >       {     0,      0 },
> > >  };
> > >
> > > +static const struct tsl2772_lux apds990x_lux_table[TSL2772_DEF_LUX_T=
ABLE_SZ] =3D {
> > > +     { 52000,  115960 },
> > > +     { 36400,   73840 },
> > > +     {     0,       0 },
> > > +};
> > > +
> > >  static const struct tsl2772_lux apds9930_lux_table[TSL2772_DEF_LUX_T=
ABLE_SZ] =3D {
> > >       { 52000,  96824 },
> > >       { 38792,  67132 },
> > > @@ -238,6 +245,7 @@ static const struct tsl2772_lux *tsl2772_default_=
lux_table_group[] =3D {
> > >       [tmd2672] =3D tmd2x72_lux_table,
> > >       [tsl2772] =3D tsl2x72_lux_table,
> > >       [tmd2772] =3D tmd2x72_lux_table,
> > > +     [apds990x] =3D apds990x_lux_table,
> > >       [apds9930] =3D apds9930_lux_table,
> > >  };
> > >
> > > @@ -289,6 +297,7 @@ static const int tsl2772_int_time_avail[][6] =3D {
> > >       [tmd2672] =3D { 0, 2730, 0, 2730, 0, 699000 },
> > >       [tsl2772] =3D { 0, 2730, 0, 2730, 0, 699000 },
> > >       [tmd2772] =3D { 0, 2730, 0, 2730, 0, 699000 },
> > > +     [apds990x] =3D { 0, 2720, 0, 2720, 0, 696000 },
> > >       [apds9930] =3D { 0, 2730, 0, 2730, 0, 699000 },
> > >  };
> > >
> > > @@ -316,6 +325,7 @@ static const u8 device_channel_config[] =3D {
> > >       [tmd2672] =3D PRX2,
> > >       [tsl2772] =3D ALSPRX2,
> > >       [tmd2772] =3D ALSPRX2,
> > > +     [apds990x] =3D ALSPRX, =20
> >
> > This is different from tsl2772? =20
>=20
> yes, lux table is different and made according to datasheet,
> tsl2772_int_time_avail differs, ALSPRX configuration assumes that
> proximity sensor needs no calibration which is true for apds9900/1
> while tsl2772 needs calibration, device ID is different 0x20/0x29 for
> apds and 0x30 for tsl2772

All makes sense but that means the patch description needs to be
more precise about what elements are compatible, or use vaguer wording
like 'similar to'.

Jonathan

>=20
> > =20
> > >       [apds9930] =3D ALSPRX2,
> > >  }; =20
> > =20
>=20

