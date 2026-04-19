Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFC62701C4
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616100; cv=pass; b=dsoFDtqLLmQLkvgE7V2Ozd0YmjDlXsA2p9ADlUsIhVKNM4Bgy1Z6mybLMsWSH3v4UQ6X2c1YXbSOGcEck/dA/mGLh7SBSrdzNsKNIavcrz/WBWQZBOm6Jrv83YzOH7rxpY/Cj1+DOzUl1QzFM5ePp/HhHSKkJ2edGCYmI9MdFdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616100; c=relaxed/simple;
	bh=jdJNW8Gs6tt0f1ikn3nADdeoMyZWPfvrZRMH7NFWmLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0VS7zh7s5oDJwfVma14UCnsjnBDP8shbbfIbsSZJWK8gOlCFV22n5FloYAenp9j1FwTvhefzelyC2pUZsfSown0WUxHzLSWTNa/FM/OhGQdNKLaj5ELIklTf6Ittl1qBrWAp+8HWY5mzKaM83Nlh++EEHtLOTnnbo/kvIZs0E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxdQ97PI; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxdQ97PI"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d7605ec91so1977324f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 09:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776616096; cv=none;
        d=google.com; s=arc-20240605;
        b=DdCkxk3IJqgvbRLkT8YpcQd8yO3oqrChIOiPB9id/eJNz3DjoT3rCDVJpguZriI6y+
         R7Pi1cHhDJo4IdFJpwpCueQF67rNf5tKA3de289cOOqb7FCttBuyCjfuwFSp0yRjazhX
         hcWZy+R6vby6XtDmgUsOlTj9Ww+o+3xrlEJQyTOdQkKlWQB4dKyqdfdkqH8s9gJFabwO
         6/c8Dz562i/8Pv+y9MCx/n6GJU8vK7xPZqJMxdeqZTrpwji68cD0ikYT+IN+ZAaDKvh9
         cZMVmR4ac9k2/7rBEM//RvPelP8f9aQPDzGEdF8Fs5O60Pqr3Xw+ccc2DqRmzNUidxfL
         W7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuVgKDGKg/GWQr/2okshQNmsNbwPJ2lpWA8TATeT+q0=;
        fh=OUNcNwRp6kIa6ORonYbIT6vFFjuy2lqrXDs3bk9hyTM=;
        b=OemK/hWrejPue35dIt9vmXEs70aCIkTq8+wXVjP3hAicBpjBKuXGPxK1fcV/QPPnIh
         PXQw9fzbO1Jf6WBcrGjy++aXdbKu9vg+yo77sM5rdGU+t4C+yY47BXDwLe+IuQfuIBps
         e4ZBS2OWTMtPFG6UAhXWT6w9tAWxOylGs14Num+LZYZlkTEFB4sqVLeWAqVobHLviW1/
         6/5UggthTDk+4i78v3F16vKiy+0D2a5LNzaCQQ75LAOvk4WzwPMScSEQvoEyzgIBhXKS
         zCJ4Hplmq0usA4PsrCNyHabOrjbZoI7xYmKvhL3E3EYeKiYbb21dzo1KxFax2AMPc0Ir
         A2yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776616096; x=1777220896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuVgKDGKg/GWQr/2okshQNmsNbwPJ2lpWA8TATeT+q0=;
        b=UxdQ97PIB2xXnOZGr5n1FdOft3w8FaI8KnQ1zDEMV3VE6subuTbjhL45Zd1XPyiVNS
         7Nweizd4jQYDqDqpxQlK6eho80iIAM5JHoxVyAPdYm6S0XGv/EuYrhdrhuRYqjQeDmIK
         y+QQ5GsCz8ekIDvYByaQJwu5auCN+KZDV075R512Mr+kvywz9Xag4PiNUGidNcUr1D0F
         42OT9cMhQdrtjuVMkffHmHXwkKlKDwAua9lTd3FGIm7llgjKw7SwVbP00EPc1E8Fzxb2
         g60qD2r4yY0Twvg3d3SrNQlha0YqQT6/BTe8J7qiVRmvEYZ1MJccCPubkdgK0/JjU2ZS
         3CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776616096; x=1777220896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuVgKDGKg/GWQr/2okshQNmsNbwPJ2lpWA8TATeT+q0=;
        b=QzJLID2bC68nqJPkNrHNKFHC7xOyrlLU1rkhei1Gop/YTT1JEcpKztVBFw+eUQRItX
         lEj83mX7+gX03g7ejDp+PpcB6Bb87beKuhoVbNck6nODss9002iUUFo53xzN9aB1EZFx
         pfQAsJPC3psRjFPa0z/T5S1emGedPK+bFI1lGyRxjqj/YK8amOQVca9Qy1yPm2VMB5N4
         suapQGnZEaCjl4sXS0Xt4Hp2HRgT75qTMVD4cfbKX71XFCZFAEvXLrltCRdKRD2YYq0x
         WG1u2/gjURKXHcczLnkXL2EE0KvJiBbdGzIiwM8dBfoTvdoOsWMsjZwbHZO3Nr+VLBzK
         n9sg==
X-Forwarded-Encrypted: i=1; AFNElJ8ji+CYGhr7tWl9nktRKGOnGkrdnj6rZr+TTujzwlpb5ojMgEn9e5TF7CtETtBvbrpN3BLXHW6Sewk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHyl2S9Ylcpq+FlvHtJqJtmXmZ8iqIo+T+FB83Wl3gHnJlfjsn
	NPKcHkwUD9q1U78wxPueTCtP2wxxpmXG2oiJJ6xvuPNFk98G3lk+irHolDxL0Gvv+xgxALXmXRX
	QhZkCFxT7401PKxoIyU9nJUJ48/j/QjA=
X-Gm-Gg: AeBDies7xgENLv3jGxr4oRZZ1Kpeu4fqewIT4fufYxiz9QqCf7Urwk4NaKkT58qhgDD
	PNtir4FDcyHtNM6ZfB4qLGKkYCLuyLRpB8RHQz4Cadj/LSCd5uLs1Lj2nMegRpIf5Cn/GTqrM84
	E0B5/J+XQ8KXPCES/Xpd9oaqxgCa2rHyR7mn0TZ/y+gQjFASyjwFtOXNmVXZKTRWqEHcFaLhNqL
	lseXqgNsl1M2E1jVKtnVZ9Aa4RVd92VJDMib83ZtUiG/QSoUBSw7naqMdd1hTFzLs+bTJWhdFcH
	ENk269Hvwsr816NdAIU=
X-Received: by 2002:a05:6000:22c5:b0:43b:3d4f:e17a with SMTP id
 ffacd0b85a97d-43fe3e13f82mr15430010f8f.37.1776616096044; Sun, 19 Apr 2026
 09:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419083125.35572-1-clamor95@gmail.com> <20260419083125.35572-3-clamor95@gmail.com>
 <20260419143751.11ec0b69@jic23-huawei> <CAPVz0n048kPMAnGQpOk0_SPtQ+hz=-p6jdyRYPB5d+CD9i7_Cw@mail.gmail.com>
 <20260419172458.375e7897@jic23-huawei>
In-Reply-To: <20260419172458.375e7897@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 19 Apr 2026 19:28:04 +0300
X-Gm-Features: AQROBzCGqzbDYKqmLLkQhvFSXgWrhJTeduhQQUTsJMUXOnlMr8lcd4oYzWI_jvk
Message-ID: <CAPVz0n0YWxfXN1Ty2OOn-2WVEhHjtasbcMhQkn8ZRc=gpFPUCQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: tsl2772: add support for Avago APDS9900/9901
 ALS/Proximity sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 19 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:2=
5 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 19 Apr 2026 16:46:25 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D0=BD=D0=B4, 19 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
16:38 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sun, 19 Apr 2026 11:31:23 +0300
> > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > >
> > > > The Avago APDS990x has the same register set as the TAOS/AMS TSL277=
2 so
> > >
> > > A Sashiko review comment makes me wonder about one thing below if the
> > > register set does match.  Maybe it's a bit more subtle than this
> > > patch description suggests?
> > >
> > > > just add the correct bindings and the appropriate LUX table derived=
 from
> > > > the values in the datasheet. Driver was tested on the LG Optimus Vu=
 P895.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/iio/light/tsl2772.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl277=
2.c
> > > > index c8f15ba95267..8dab34bf00ca 100644
> > > > --- a/drivers/iio/light/tsl2772.c
> > > > +++ b/drivers/iio/light/tsl2772.c
> > > > @@ -127,6 +127,7 @@ enum {
> > > >       tmd2672,
> > > >       tsl2772,
> > > >       tmd2772,
> > > > +     apds990x,
> > > >       apds9930,
> > > >  };
> > > >
> > > > @@ -221,6 +222,12 @@ static const struct tsl2772_lux tmd2x72_lux_ta=
ble[TSL2772_DEF_LUX_TABLE_SZ] =3D {
> > > >       {     0,      0 },
> > > >  };
> > > >
> > > > +static const struct tsl2772_lux apds990x_lux_table[TSL2772_DEF_LUX=
_TABLE_SZ] =3D {
> > > > +     { 52000,  115960 },
> > > > +     { 36400,   73840 },
> > > > +     {     0,       0 },
> > > > +};
> > > > +
> > > >  static const struct tsl2772_lux apds9930_lux_table[TSL2772_DEF_LUX=
_TABLE_SZ] =3D {
> > > >       { 52000,  96824 },
> > > >       { 38792,  67132 },
> > > > @@ -238,6 +245,7 @@ static const struct tsl2772_lux *tsl2772_defaul=
t_lux_table_group[] =3D {
> > > >       [tmd2672] =3D tmd2x72_lux_table,
> > > >       [tsl2772] =3D tsl2x72_lux_table,
> > > >       [tmd2772] =3D tmd2x72_lux_table,
> > > > +     [apds990x] =3D apds990x_lux_table,
> > > >       [apds9930] =3D apds9930_lux_table,
> > > >  };
> > > >
> > > > @@ -289,6 +297,7 @@ static const int tsl2772_int_time_avail[][6] =
=3D {
> > > >       [tmd2672] =3D { 0, 2730, 0, 2730, 0, 699000 },
> > > >       [tsl2772] =3D { 0, 2730, 0, 2730, 0, 699000 },
> > > >       [tmd2772] =3D { 0, 2730, 0, 2730, 0, 699000 },
> > > > +     [apds990x] =3D { 0, 2720, 0, 2720, 0, 696000 },
> > > >       [apds9930] =3D { 0, 2730, 0, 2730, 0, 699000 },
> > > >  };
> > > >
> > > > @@ -316,6 +325,7 @@ static const u8 device_channel_config[] =3D {
> > > >       [tmd2672] =3D PRX2,
> > > >       [tsl2772] =3D ALSPRX2,
> > > >       [tmd2772] =3D ALSPRX2,
> > > > +     [apds990x] =3D ALSPRX,
> > >
> > > This is different from tsl2772?
> >
> > yes, lux table is different and made according to datasheet,
> > tsl2772_int_time_avail differs, ALSPRX configuration assumes that
> > proximity sensor needs no calibration which is true for apds9900/1
> > while tsl2772 needs calibration, device ID is different 0x20/0x29 for
> > apds and 0x30 for tsl2772
>
> All makes sense but that means the patch description needs to be
> more precise about what elements are compatible, or use vaguer wording
> like 'similar to'.
>

Fair, noted.

> Jonathan
>
> >
> > >
> > > >       [apds9930] =3D ALSPRX2,
> > > >  };
> > >
> >
>
