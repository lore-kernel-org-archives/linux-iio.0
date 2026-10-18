Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1B415F12;
	Sun, 18 Oct 2026 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792346421; cv=none; b=OOV1JN6Bb4rihLUCkx1gv38jI2XOAG8uPx7bEWl//k81kJMq3G0Su8jkfUJD1VwC2LxT+w17U7Nbfn+bCWH2veLy8o+RuXsxkPFI4bOV5Y9CTowSm0yxiCGmF6QshnzlQMeNW77xydyY5ZU8G4cxZHFNxQE19WHB7DL7sloVhD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792346421; c=relaxed/simple;
	bh=HeQaUCu/1IU/VhOXcG6OSbLQac6KBI8Mye0x29OuKZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnLOAi5k+9Rw8VmyimTNhgnMghEuirJGUawByk0e1zcjzSkQhbwbIm9RBUOJdGUNTdcpulg++/V1XHGVCx5fQ8eh+vPteYxGOg3y5PUu1FRb8LhMBrdqYx3f96gnQoNvvrPw8O5YVSRM7fUzoxIx1OuaXonJsqsoJtnM/ogZmHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvDofq5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvDofq5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A821F000C4;
	Sun, 18 Oct 2026 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792346419;
	bh=xcPpfCyvLjPxhYGHaKsHieTyFC2n7PDAu3LvsTZ1LIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KvDofq5/p/qKzCVbDGTjYhJFqP/HuaHYHI7Qlx2btBBSzUYxDXFlWSD5BuDE8yZDi
	 IeB7RP9mVCLGSrd9YkQVZHcEVhpJlNxtSP4WMqlUVeFBxghciwGdwG+0EnBTJe+eJQ
	 tnyzSEqsAplRcaTs3CxFkbo3BfVGsyE6jZrg2AI277FVvtYdwHLDq2ZtVQuRxL8SHF
	 KNTcimzdYkAp2WSKtZ8vK3iSy4EQHvatuVE7TUT10Ptky3ovFohFv2+O78nOH3IXyl
	 jlDc97Km6nGHeQHy1bek2shCyCBGdTTPhQS1HfRkKQMicgs1NZpMjlitIVX5ZgVwzH
	 QlIPwOqtBq2oQ==
Date: Sun, 18 Oct 2026 19:00:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Viral Patel <viral8854@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: magnetometer: tlv493d: fix magnetic field scale
Message-ID: <20261018190013.02036a0b@jic23-hlaptop>
In-Reply-To: <CAFmh=S2mXJLk=V_r_eie3=zDfXXRX+aUba=Kn+5h3PQ9pkwxnQ@mail.gmail.com>
References: <20261014-tlv493d-scale-fix-v1-1-69a722176c06@gmail.com>
	<20261017230910.77d1637b@jic23-hlaptop>
	<CAFmh=S2O7TzFEe5WqH+Te9dQOK5TwAtjB-7GC7uDj7LGS9=w_Q@mail.gmail.com>
	<CAFmh=S2mXJLk=V_r_eie3=zDfXXRX+aUba=Kn+5h3PQ9pkwxnQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Oct 2026 21:29:49 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> LGTM. Good catch. There seem to be miscalculated Gauss scale due to
> multiple conversion factor.
>=20
> Reviewed-by: Dixit Parmar <dixitparmar19@gmail.com>
>=20
Thanks for the fast response!

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> On Sun, Oct 18, 2026 at 9:22=E2=80=AFPM Dixit Parmar <dixitparmar19@gmail=
.com> wrote:
> >
> > This change looks correct, the Gauss scale value seem to be miscalculat=
ed due to multiple conversations and different reference. Good catch.
> >
> > On Sunday, October 18, 2026, Jonathan Cameron <jic23@kernel.org> wrote:=
 =20
> >>
> >> On Wed, 14 Oct 2026 23:07:36 +0530
> >> Viral Patel <viral8854@gmail.com> wrote:
> >> =20
> >> > The TLV493D-A1B6 datasheet specifies a magnetic resolution of
> >> > 98 uT/LSB (0.098 mT/LSB). IIO reports magnetic field in Gauss
> >> > (1 mT =3D 10 G), so the scale should be 0.98 G/LSB.
> >> >
> >> > The driver currently reports 98/1000 =3D 0.098 G/LSB, which
> >> > under-reports the magnetic field by a factor of 10. The comment
> >> > also gives the resolution as 0.0098 mT (9.8 uT), mixing up units.
> >> >
> >> > Correct the scale value and the comment.
> >> >
> >> > Fixes: 106511d280c7 ("iio: magnetometer: add support for Infineon TL=
V493D 3D Magentic sensor")
> >> > Signed-off-by: Viral Patel <viral8854@gmail.com> =20
> >>
> >> I'll give some time for Dixit to take a look at this.
> >>
> >> Thanks,
> >>
> >> Jonathan
> >> =20
> >> > ---
> >> > Found while comparing this driver against the TLE493D-W2B6 register
> >> > map for a new driver I am working on. Compile-tested only; I do not
> >> > have TLV493D-A1B6 hardware.
> >> > ---
> >> >  drivers/iio/magnetometer/tlv493d.c | 6 +++---
> >> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnet=
ometer/tlv493d.c
> >> > index 03415cc2c9b3..234e3ce63ff7 100644
> >> > --- a/drivers/iio/magnetometer/tlv493d.c
> >> > +++ b/drivers/iio/magnetometer/tlv493d.c
> >> > @@ -299,11 +299,11 @@ static int tlv493d_read_raw(struct iio_dev *in=
dio_dev,
> >> >               switch (chan->type) {
> >> >               case IIO_MAGN:
> >> >                       /*
> >> > -                      * Magnetic field scale: 0.0098 mTesla (i.e. 9=
.8 =C2=B5T)
> >> > -                      * Magnetic field in Gauss: mT * 10 =3D 0.098.
> >> > +                      * Magnetic field scale: 0.098 mTesla (i.e. 98=
 =C2=B5T) per LSB.
> >> > +                      * In Gauss (1 mT =3D 10 G): 0.98 G per LSB.
> >> >                        */
> >> >                       *val =3D 98;
> >> > -                     *val2 =3D 1000;
> >> > +                     *val2 =3D 100;
> >> >                       return IIO_VAL_FRACTIONAL;
> >> >               case IIO_TEMP:
> >> >                       /*
> >> >
> >> > ---
> >> > base-commit: ceb05f22e5cdc3f8bd3f7d5dcfc57843942191dd
> >> > change-id: 20261014-tlv493d-scale-fix-5a0b83b52d2a
> >> >
> >> > Best regards, =20
> >> =20
>=20

