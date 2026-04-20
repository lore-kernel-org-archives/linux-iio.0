Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE13A1A2B;
	Mon, 20 Apr 2026 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690545; cv=none; b=kPLaOSa4g3v4A3+fu/pjeBCKlTnT1XjPdw1Ahwla+wFgDX8Lgi53OGfasfppZbZmmZuYqYTiABRD8y+C4K7+k5N00KpvWG+G1chgh453FBv6cdM71S6BO5/UzhcSu6fGlFgZXejdKipZi6WrOSBTHaPqSOcHqmPp19va0Qq4Uq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690545; c=relaxed/simple;
	bh=YVHGjHngP0mEcOJWxVXP/5KZC4y0CfaNlP5qmTAxyn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taYFtEROX5dbdm5Vwh7BeLFvg34wFbGBRH/4/N/2OY+znfhIeKi4sBewSBWO7tHdTYwpBgeREPMfPz8O352gHTun95BecwYrhf6eN3pJq7TjYbAu551MYWbdtAqvVEyRz8COqssnQ9TObolBGJDuuxjfucXCaMypIMUrmqIOwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU3YUT+O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU3YUT+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E215DC19425;
	Mon, 20 Apr 2026 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690544;
	bh=YVHGjHngP0mEcOJWxVXP/5KZC4y0CfaNlP5qmTAxyn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KU3YUT+OndMNa28No78St7O9qi6Nj1N8fv42TL7np6nan0uNzSbSTzhGephHkhbkU
	 o+j54MpPthLNPi2uHvtse60TFXhFs6+rvmwuLjqUKbIGm75ul3fiVf4/QJeQJ2rfv6
	 iOLIzL4yQSZ0rQC9fbmJ4DSDAIE6LiDLYuyEXdz1rcW6s5XnYmSu+cQbH0WMnIUg8O
	 06W5SiYCboFbulaBR4E2GQcL1rxD4u/6445piB7/dhz7yVelmgx0tQHwBzxMRJ228Y
	 3ZUxO4w8WLuJBkJ7tVcx1H8QVtY8kNSObIYeAzCk7biGMD5TWb86IFtC0p6C8STwr7
	 e474LfOrNYp1Q==
Date: Mon, 20 Apr 2026 14:08:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3552r: use field_get() for power-down bit
 read
Message-ID: <20260420140857.547b8a42@jic23-huawei>
In-Reply-To: <CAMB+xkaXrRPzywrGeDt2toMDTZSp+Tq6ixa+QR3X3hY1VqA_Cw@mail.gmail.com>
References: <20260411051650.11949-1-piyushpatle228@gmail.com>
	<76eda9d5a2ff1a3a4d21466d78632081dc9a5cd0.camel@gmail.com>
	<CAMB+xkaXrRPzywrGeDt2toMDTZSp+Tq6ixa+QR3X3hY1VqA_Cw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Apr 2026 22:27:29 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> On Sat, Apr 11, 2026 at 7:18=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >
> > On Sat, 2026-04-11 at 10:46 +0530, Piyush Patle wrote: =20
> > > Use field_get() for the per-channel DAC power-down bit instead of an
> > > open-coded mask-and-shift sequence.
> > >
> > > No functional change.
> > >
> > > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > > --- =20
> >
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > =20
> > >  drivers/iio/dac/ad3552r.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> > > index 93c33bc3e1be..f206bba3a701 100644
> > > --- a/drivers/iio/dac/ad3552r.c
> > > +++ b/drivers/iio/dac/ad3552r.c
> > > @@ -167,8 +167,7 @@ static int ad3552r_read_raw(struct iio_dev *indio=
_dev,
> > >               mutex_unlock(&dac->lock);
> > >               if (err < 0)
> > >                       return err;
> > > -             *val =3D !((tmp_val & AD3552R_MASK_CH_DAC_POWERDOWN(ch)=
) >>
> > > -                       __ffs(AD3552R_MASK_CH_DAC_POWERDOWN(ch)));
> > > +             *val =3D !field_get(AD3552R_MASK_CH_DAC_POWERDOWN(ch), =
tmp_val);
> > >               return IIO_VAL_INT;
> > >       case IIO_CHAN_INFO_SCALE:
> > >               *val =3D dac->ch_data[ch].scale_int; =20
>=20
> Hi,
> Gentle ping on this patch.
>=20
> I=E2=80=99d appreciate any feedback whenever you get time, or let me know=
 if I
> should resend/rework anything.

General rule is wait 2 weeks before this sort of email.
You can also check status in patchwork to see if I've gotten to it yet.
https://patchwork.kernel.org/project/linux-iio/list/?

On this particular occasion life got unusually busy so I'm a few weeks
behind and  working backwards through my backlog to catch up.

Applied to the testing branch of iio.git.

Jonathan

>=20
> Regards,
> Piyush
>=20

