Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB4409132;
	Tue, 26 May 2026 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819521; cv=none; b=ivMdO5vg2FCa/TAr3tOC3BidXH6MhOgPgp87NWks0mytrotjF8lW4BmBHXQu66tGdGYVldMp1cePXMTQNKBWOaUq8u+t8COmPASfonoM5ZV/gzs60sQ0VqyG3kY2xxgdqQB7lzZm99IW2r5PxzERAmciOZOyhV860HXsvT/Bse8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819521; c=relaxed/simple;
	bh=lla5FRfyhmkMp078NQSjFk/vQOnLimwjww9Ci3EcHNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlZX7QAinGkkzXEAFi6M403Ou0zys/T6WP0wF7tAKGXiuWLxWi1xU7IMCD4gxfUi+6KutsTuEMlRNbEK+OH89xhhCVZwqeFCHr4peA0c78frihBKbgB8xV6AV1jQvMjPfaZS/ieg/2wjsVbNkMuZ0RBLAoiJd3tIJu0khoOYeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evKSI+IU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evKSI+IU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A621F000E9;
	Tue, 26 May 2026 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779819519;
	bh=mBspxUDEXqQq3OMklqIqv9yLfvyTO8Fx9yoidAXxlgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=evKSI+IUS/R6usE7I/HEGYKUMkKHgfLAR/ngFnPQxrQTqV7eSgfai3mMS+AMiBzEa
	 5XWp2DtgzasP///NIJkTfyNLPvUbMaB4uvHhqXwizKmGni5jETqZXnQ8UM59b8WJlv
	 LNbCixzYnNNoxOrybKIuHD7WjPJyMW7W7KLDf/wwZXnAs0p4H33GkgAOKmo2Hc44nn
	 i3If7H5tronp7Hq3EjCa9rlyj9w2oeIbdfZn5rxUPukdUfjrgnLGLM/QWLQBykzKiH
	 pbfypKoJphyAHXJcMpv/BtMO5Kai4wEJbW0p2CjgsUPSTWP5bP4A0BhlEWRSbTK/6I
	 4ux5LMyYEW25A==
Date: Tue, 26 May 2026 19:18:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Dan Carpenter <error27@gmail.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix uninitialized data ni
 ad3552r_hs_write_data_source()
Message-ID: <20260526191831.3bf33c0e@jic23-huawei>
In-Reply-To: <CAKqfh0ErCJV9yV0kbgmvpRYzD5sFEaUxTrXxDKVVeEA8m3WhRQ@mail.gmail.com>
References: <ahP3IjYJ87bNc1De@stanley.mountain>
	<CAKqfh0ErCJV9yV0kbgmvpRYzD5sFEaUxTrXxDKVVeEA8m3WhRQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 May 2026 08:21:51 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Hi Dan,
>=20
> On Mon, May 25, 2026 at 2:16=E2=80=AFAM Dan Carpenter <error27@gmail.com>=
 wrote:
> >
> > If the *ppos value is non-zero then the simple_write_to_buffer() functi=
on
> > won't initialized the start of the buf[] buffer.  Non-zero values for
> > *ppos won't work here generally, so just test for them and return -EINV=
AL
> > at the start of the function.
> > =20
>=20
> Please see my other email, you're also returning -ENOSPC instead of
> -EINVAL here...
>=20
Good spot. Tweaked whilst applying.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks

Jonathan
> >
> > Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ra=
mp")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> >  drivers/iio/dac/ad3552r-hs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > index a9578afa7015..6bc64f53bce9 100644
> > --- a/drivers/iio/dac/ad3552r-hs.c
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -549,7 +549,7 @@ static ssize_t ad3552r_hs_write_data_source(struct =
file *f,
> >
> >         guard(mutex)(&st->lock);
> >
> > -       if (count >=3D sizeof(buf))
> > +       if (*ppos !=3D 0 || count >=3D sizeof(buf))
> >                 return -ENOSPC;
> > =20
>=20
> See above comment.
>=20
> best regards,
> max
>=20
>=20
>=20
> >         ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user=
buf,
> > --
> > 2.53.0
> >
> > =20

