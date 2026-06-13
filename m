Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC23D669F;
	Sat, 13 Jun 2026 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350410; cv=none; b=WCb7Mf0Jr6+/Ng5RtM7aEDor1tBrqYIrZgEXOr3KAKdWwLnbZZI3AkthNTG9klh9LATQoFwpPV1+7SWX21aBaq6fhHnR4igr8clmRo5cFC7w353AAFC/Cim83UkGdBIYiWOV2NIDw6m/K4KjZSl81UE5Mrl/DUPCE0QS+n61AV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350410; c=relaxed/simple;
	bh=5DLdwinVmJ4WpPd1rD4v/tLhYnpT2RF787mdkmNgRNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7y3N9zL/I3bTyppMU1Vp1O/JgjRmgCEj2HYGpcdlC1MSLMb6YRwJqTzutqUkOtPRr1s2B50UxuqbprTFoU+qlKgVszbCNZuWwTjW0IAxRXQ+xh5OlT7oOMRMwqP+6PuZecU9012lj2a/BpixmPo/KIiaokjVO8Yn4OtuhkLR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISOPU/Pp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISOPU/Pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5CF1F000E9;
	Sat, 13 Jun 2026 11:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781350409;
	bh=TzNCwLkzUyI1Uaj52fEv3z4XObBcUfOjY144YtiLoTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ISOPU/PpcN8du00Mg6j4cEu9xcVSGKTivIW3p+8644hcBAvNyBEC+KkSvPwRkcoA7
	 FvcyibM2XcxgDzHHpNkydgU5GuPz8im5caw5X5xV5rMe+IwFusNKdn/kcrBt4vyIBz
	 bvgqY7XGaG+Dw2g2Fxw/VkjRortXQaaCCnX8myf9VnBiqAWooOwwUhL5I0YLSSeVPc
	 GhGksS4+bAe/Po6eLvq1aS23dnO2zQtJkv1y6y9nfKeoVQDIKQFkvARfvbmgeAsoT/
	 8c3DSBakcxWpmn6u+HS1z713p9raDs1qt0O2yZX0FwkudW59EU4gpP/46N9U5jxEoc
	 Gju4aSmzakIXQ==
Date: Sat, 13 Jun 2026 12:33:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sirat <email@sirat.me>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: magnetometer: add driver for QST QMC5883L
 Sensor
Message-ID: <20260613123321.1b276686@jic23-huawei>
In-Reply-To: <CANn+LWJoSiCY8cTBNZd9w0H-b-D6C7rH2j8QmB57eTKO0g-x_A@mail.gmail.com>
References: <20260612124557.13750-1-email@sirat.me>
	<20260612124557.13750-4-email@sirat.me>
	<20260612180235.3e505c66@jic23-huawei>
	<CANn+LWJoSiCY8cTBNZd9w0H-b-D6C7rH2j8QmB57eTKO0g-x_A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jun 2026 14:47:25 +0600
Sirat <email@sirat.me> wrote:

> On Fri, Jun 12, 2026 at 11:02=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Fri, 12 Jun 2026 18:45:27 +0600
> > Siratul Islam <email@sirat.me> wrote:
> > =20
> > > Add driver for the QST QMC5883L 3-Axis Magnetic Sensor
> > > connected via i2c.
> > >
> > > Signed-off-by: Siratul Islam <email@sirat.me> =20
> >
> > Trying to avoid repeating stuff Joshua already covered.
> > Various comments inline.
> >
> > Thanks,
> >
> > Jonathan
> > =20
> > > diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnet=
ometer/qmc5883l.c
> > > new file mode 100644
> > > index 000000000000..055e51570635
> > > --- /dev/null
> > > +++ b/drivers/iio/magnetometer/qmc5883l.c =20
> ...
> > > +#define QMC5883L_OSR_512     FIELD_PREP_CONST(QMC5883L_OSR_MASK, 0x0=
0)
> > > +#define QMC5883L_OSR_256     FIELD_PREP_CONST(QMC5883L_OSR_MASK, 0x0=
1)
> > > +#define QMC5883L_OSR_128     FIELD_PREP_CONST(QMC5883L_OSR_MASK, 0x0=
2)
> > > +#define QMC5883L_OSR_64              FIELD_PREP_CONST(QMC5883L_OSR_M=
ASK, 0x03) =20
> > These are used for matching - normally we'd add defines for the filed v=
alue and
> > then use FIELD_GET() to extract it for matching.
> > e.g.
> > #define QMC5883L_OSR_512                0x0
> > #define QMC5883L_OSR_256                0x1
> > rather these.
> > =20
> I thought using _CONST would be better for compile time checks and not
> needing to use FIELD_GET everywhere. The values 0x01, 0x02 don't have
> a lot of meaning in a vacuum. But of course you would have more
> experience about it and I'd love to know why we shouldn't use=20

It is mainly about readability at the point of use.=20

			ret =3D regmap_update_bits(data->regmap,
						 QMC5883L_OSR_MASK,
						 FIELD_PREP(QMC5883L_OSR_MASK, osr));

makes it clear to the reader that it is a field assignment and that correct
adjustment of bits has been applied (shifting, masking etc)

			ret =3D regmap_update_bits(data->regmap,
						 QMC5883L_REG_CTRL1,
						 QMC5883L_OSR_MASK, osr);=20

means that to check that the right field is being assigned we have to go
find where osr is set and up to the defines just to check that everything
is as expected.

+ the other strong argument is convention. Certainly in IIO and perhaps
more generally we all field values are the content of the field, not the
shifted variant.

As you note, the compile time checks are lost, but I'm not sure they
bring a lot of value in this particular case where it's copy typed stuff
from the datasheet.

> > > + =20
> ...
>=20
> > > +static const int qmc5883l_rng_avail[] =3D {
> > > +     0, QMC5883L_SCALE_2G,   /* 2G */ =20
> >
> > I'm not sure the defines really help. Perhaps push the value down here
> > and then look it up from this array when matching.
> > =20
> But then the array will be serving more than 1 purpose? kind of like a
> side effect I think.

The array is of the value that are available - so using them to say 'this
one' to me seems fine.  If you were to do the common trick of having those =
as a
2d array (needs a cast for read_avail) then
static const int qmc5883l_rng_avail[][2] =3D { // or [2][2] if you prefer
	[QMC5883L_RNG_2G] =3D { 0, 83333 },
	[QMC5883L_RNG_8G] =3D { 0, 333333 },
};

At the other place it is looked up it becomes something like:
	*val =3D qmc5773l_rng_avail[data->range][0]
	*val2 =3D qmc5773l_rng_avail[data->range][1];

possibly rename it to
static const int qmc5883l_scales[2][];

as it is not used both to express what is available and for use
as a lookup.  It was always the available scales rather than ranges
anyway.


> > =20
> ...
> > > +
> > > +     /* DRDY pin no used in this version of the driver */
> > > +     ret =3D regmap_write(data->regmap, QMC5883L_REG_CTRL2,
> > > +                        QMC5883L_INT_DISABLE); =20
> > I don't mind if these sorts of cases go a little over 80 chars as somet=
imes
> > it helps readability.
> > =20
> I try to disable clang-format for cases like this. It's an oversight on m=
y side.
> >
> > Does it really reset with interrupts on?  That's odd.  Mind you the
> > INT_ENB sounds like it would be an enable but as you have named it here
> > it is actually a disable so all bets are off when it comes to sensible =
;)
> > =20
> The datasheet says "The interrupt can be disabled by set 0AH[0] =3D 1"
> which I took as it's enabled by default.
> I explicitly disable it just to be safe.

That's fair enough, if very odd given that's a typical path to annoying
races.  Might be worth just testing the hardware to check the default

> > =20
> ...
> > > +static const struct of_device_id qmc5883l_match[] =3D {
> > > +     { .compatible =3D "qstcorp,qmc5883l" },
> > > +     { }, =20
> >
> > As below, no comma.
> > =20
> I did it so that clang-format doesn't wrap it all in 1 line. I forgot
> to remove the comma before sending the patch. Sorry.
> > > +}; =20
> > =20
>=20
> Thanks
> Sirat

