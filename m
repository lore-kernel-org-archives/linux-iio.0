Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD840B6F9;
	Fri, 22 May 2026 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453457; cv=none; b=Easp9wVuWrxAAyPPpW0jmouK3/Yuc8a5PCFjN+IeDgoMK0MBOCpXvdMzs2eYUjf+d6Uu5UsXEk3znyEEIIoLR61W5/XIgZrJQ/uYXNxtCtPy50HjPgGNzTKjErUm4/yMGRqXB8hbyy6nobDqWzSwmAK0MOBRIKjvfY4nPe5dQFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453457; c=relaxed/simple;
	bh=kyZLM8mX+6fCKQR3e9HXxZJV9mzcyLquP37oVSsMXxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehFeEcUPTzMhnO35jSe3bjl5o671pYkKLuZZcunOZTqEEIAzjnAKV3WtCBWdoeizzWajNGsaIGFs+5d7DFPoKCufAp8Au8x3RExTAvvqzxtVoi5oIdgE0y9hMZhsHhSA5029PwD9RyYry0yvO8wmtQG1OJk8vZE7T/PWWJ8FnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVCJEQNk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVCJEQNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BA41F00A3D;
	Fri, 22 May 2026 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453445;
	bh=ZBa76dVyp6A/Ye0EBnSGPY0gOoXHjp/hgN/7v21MD4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WVCJEQNkpBTByY7kg/1Xd/a3wqxEocyQ5QrXc6OnuIgGl/RiaBVjjjyJWsAuLebVC
	 ChwBLnaNE2CjFvl/1ShAQDHwyQGtYkxVixf0UuVj5Z6ik+1dCXopLLqHtK2cvmFcfW
	 HsIEwkJw4Djex5klox+a5NGGanltVwKXWIqw8umqGT87C7Qvb58zcmc0rqkXyYuUoy
	 pFCgYQj8D/9GI4HzB827vAIcN2WVw4/V4BkCpY5cf0q1DP9V9CH539Toa1V//MXBJs
	 POhdJTE7F9W5O+dwzklcrHs8zxrRiF+HD5b09pA/xGkspAsK4QV/qmD3jN+LfrBmG6
	 pxvZjlyHeVQpA==
Date: Fri, 22 May 2026 13:37:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: ens210: remove compiler warning
 workaround
Message-ID: <20260522133717.32772423@jic23-huawei>
In-Reply-To: <CAKqfh0Gwon4X2aCoDSNNBg7wXnKfbh69kj1R2HopKv=jHwfL-g@mail.gmail.com>
References: <20260521-iio-humidity-ens210-remove-hack-v1-1-9528ac1b384b@baylibre.com>
	<CAKqfh0Gwon4X2aCoDSNNBg7wXnKfbh69kj1R2HopKv=jHwfL-g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 May 2026 00:25:08 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Hi David,
>=20
> On Thu, May 21, 2026 at 8:26=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > Rewrite IIO_CHAN_INFO_RAW case to avoid needing to add unreachable code
> > to work around a compiler warning.
> >
> > When scoped_guard() was first introduced, compilers could not see when
> > it returned unconditionally from inside the hidden for loop. This has
> > since been fixed in the macro definition. So removing the `return
> > -EINVAL` should be enough. Still, we can improve readability, decrease
> > indentation and avoid the hidden for loop by rewriting the case without
> > scoped_guard().
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/iio/humidity/ens210.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens21=
0.c
> > index 22ad208e6aa6..49543fc389bf 100644
> > --- a/drivers/iio/humidity/ens210.c
> > +++ b/drivers/iio/humidity/ens210.c
> > @@ -149,15 +149,16 @@ static int ens210_read_raw(struct iio_dev *indio_=
dev,
> >         int ret;
> >
> >         switch (mask) {
> > -       case IIO_CHAN_INFO_RAW:
> > -               scoped_guard(mutex, &data->lock) {
> > -                       ret =3D ens210_get_measurement(
> > -                               indio_dev, channel->type =3D=3D IIO_TEM=
P, val);
> > -                       if (ret)
> > -                               return ret;
> > -                       return IIO_VAL_INT;
> > -               }
> > -               return -EINVAL; /* compiler warning workaround */
> > +       case IIO_CHAN_INFO_RAW: {
> > +               guard(mutex)(&data->lock);
> > +
> > +               ret =3D ens210_get_measurement(indio_dev, channel->type=
 =3D=3D IIO_TEMP,
> > +                                            val);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               return IIO_VAL_INT;
> > +       }
> >         case IIO_CHAN_INFO_SCALE:
> >                 if (channel->type =3D=3D IIO_TEMP) {
> >                         *val =3D 15;
> > =20
>=20
> I'm questioning how that initial commit got merged at all, they
> could've just used guard()() with {} (the kind of thing to make me
> want to take a look at this file even further!). Visually looks good
> to me but will follow-up later with rb if it all checks out.

The guard stuff was fairly new at the time so we were still working out what
patterns make sense. Took a little while for consensus to emerge!

Anyhow patch is obviously correct and a cleanup so applied to the testing
branch of iio.git.  Happy to add tags etc for next few days
(or drop it if I'm missing something!)

Jonathan

>=20
> best regards,
> max
>=20
>=20
> > ---
> > base-commit: e1a29334a9c043defe7a9363fa76d399d3fdfbec
> > change-id: 20260521-iio-humidity-ens210-remove-hack-7c5a6496547c
> >
> > Best regards,
> > --
> > David Lechner <dlechner@baylibre.com>
> >
> > =20
>=20

