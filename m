Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984C86329;
	Fri, 22 May 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470998; cv=none; b=XgzJXyZCEio+f3T4aPO0GdIp/v7HPedrTUDUhQbZ5Naqrpt6cFsMpRu5pkI/9mbaDFqTXRuAjScgZChy7tyerK3UTdh2deI09dHOwDul2oAEvnNi9TP7Mqxx6mWme2fBEvCemBjU6PaCVwd1j/GDgELwfOxd8cxPAva5FsXft84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470998; c=relaxed/simple;
	bh=C4pL1eQYn4eAe/dn5Zsx5NzodSX0epsL9Vju+JGL4mU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=El5A1I+may04ki/r17gS1H4sHOQXN7QNo0r2XZYuOYf0cgfaQwKgePlF6O3kHDJbrmGqaPon/fuL0VN9UxWI69N9Kwpw3wVUOX3/Fe6M0lm8sC9as0lYzHOdsTJNt4MrLe5IMw/sCmWj9MsW9bgy+Q2QrLGcU5FmbV8xcjb2Ap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+erwD3b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+erwD3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA1F1F000E9;
	Fri, 22 May 2026 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470996;
	bh=ryDUxABe5sFRqyt5lFeDIMMAPK7eUvolmNXVlQCRxgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L+erwD3bzDhUhwK+xADDiQ9cf767wq1wn9HCVtZnEIMadr7rjya8nTWU/BMA3Rzcv
	 AXeN8ycti4ccYMMnHFJo+ExhC2ekg8VbzAbmMZ/QurOsAyfE4vnhXgs7TIe0zWwoJP
	 zyUpnLTWF2wOz0eS10hDmyVgHAzLEmPQ9FIqO5QjidQL+kG+oxEog9yb8y/l8TuViY
	 6vI/WQjETNUSzef6JM0IHOC0gm4XsqzZk75Up1vuipGYvVkx2PwLBMBK/Ecu9klqWc
	 26jPEXJJBZkp1JQkoHLwgEPLr4U28BQaNOgsmFFokj3P3iuKmRyYBj16b02/FvAJW0
	 VrLuxRe/DRwvA==
Date: Fri, 22 May 2026 18:29:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, "open list:IIO
 SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] iio: imu: kmx61: Use guard(mutex)() over manual
 locking
Message-ID: <20260522182948.7b2e3fff@jic23-huawei>
In-Reply-To: <CAKqfh0FE+gvh+Mfn=f-9c2XVYg8uekru908ye6fzQoFoXrpGVA@mail.gmail.com>
References: <20260521223044.61410-1-m32285159@gmail.com>
	<20260522134603.07d31cbd@jic23-huawei>
	<CAKqfh0FE+gvh+Mfn=f-9c2XVYg8uekru908ye6fzQoFoXrpGVA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 May 2026 10:38:09 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Fri, May 22, 2026 at 7:46=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Thu, 21 May 2026 17:30:43 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> > =20
> > > Include linux/cleanup.h to take advantage of new macros.
> > >
> > > Replace manual mutex_lock() and mutex_unlock() calls across the file
> > > with guard(mutex)() and scoped_guard() where appropriate to simplify
> > > error paths and eliminate manual locking calls.
> > >
> > > Add new helper function kmx61_read_for_each_active_channel() to mitig=
ate
> > > certain style issues and to prevent notifying that the IRQ is finished
> > > whilst holding the lock.
> > >
> > > Update certain returns, and add default case to return -EINVAL in
> > > kmx61_read_raw().
> > >
> > > Remove now-redundant gotos and ret variables, as the new RAII macros
> > > make them unneeded. =20
> >
> > A few remaining things inline.  I'll tweak whilst applying.
> >
> > Tweaked as:
> > diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> > index 52a6e044e1e5..b8a8297b39af 100644
> > --- a/drivers/iio/imu/kmx61.c
> > +++ b/drivers/iio/imu/kmx61.c
> > @@ -827,15 +827,17 @@ static int kmx61_read_raw(struct iio_dev *indio_d=
ev,
> >                 default:
> >                         return -EINVAL;
> >                 }
> > -       case IIO_CHAN_INFO_SAMP_FREQ:
> > +       case IIO_CHAN_INFO_SAMP_FREQ: {
> >                 if (chan->type !=3D IIO_ACCEL && chan->type !=3D IIO_MA=
GN)
> >                         return -EINVAL;
> >
> > -               scoped_guard(mutex, &data->lock)
> > -                       ret =3D kmx61_get_odr(data, val, val2, chan->ad=
dress);
> > +               guard(mutex)(&data->lock);
> > +
> > +               ret =3D kmx61_get_odr(data, val, val2, chan->address);
> >                 if (ret)
> >                         return -EINVAL;
> >                 return IIO_VAL_INT_PLUS_MICRO;
> > +       }
> >         default:
> >                 return -EINVAL;
> >         }
> > @@ -1178,8 +1180,6 @@ static irqreturn_t kmx61_data_rdy_trig_poll(int i=
rq, void *private)
> >   * @indio_dev: IIO Device struct to read from
> >   * @buffer: Destination buffer to write to, the array must be of at le=
ast size 8
> >   *
> > - * Intended only for use in kmx61_trigger_handler().
> > - *
> >   * Return:
> >   * 0 on success,
> >   */
> >
> > See below for why.

I failed to say I've applied it with those tweaks.

> > > @@ -834,41 +831,40 @@ static int kmx61_read_raw(struct iio_dev *indio=
_dev,
> > >               if (chan->type !=3D IIO_ACCEL && chan->type !=3D IIO_MA=
GN)
> > >                       return -EINVAL;
> > >
> > > -             mutex_lock(&data->lock);
> > > -             ret =3D kmx61_get_odr(data, val, val2, chan->address);
> > > -             mutex_unlock(&data->lock);
> > > +             scoped_guard(mutex, &data->lock)
> > > +                     ret =3D kmx61_get_odr(data, val, val2, chan->ad=
dress); =20
> >
> > Why is this one a scoped_guard()?  Seems like it would be more consiste=
nt
> > if it was done like the one above with {} and guard()
> > =20
>=20
> I'm guessing you're talking about the {} in the switch-case. I guess
> it's likely because the guard()() in that specific case goes for the
> whole scope of the case, whereas we only need to hold the lock for
> this call (I tend to keep section length as close as possible when
> doing these things, and typically I'd use scoped_guard() for a single
> call).

	case IIO_CHAN_INFO_SAMP_FREQ:
		if (chan->type !=3D IIO_ACCEL && chan->type !=3D IIO_MAGN)
			return -EINVAL;

		mutex_lock(&data->lock);
		ret =3D kmx61_get_odr(data, val, val2, chan->address);
		mutex_unlock(&data->lock);
		if (ret)
			return -EINVAL;
		return IIO_VAL_INT_PLUS_MICRO;

Is the block in question.  Given nothing else happens after this point,
other than returning.  I'd always favour guard as it keeps the error
check at same level as the source of the error.


>=20
> > =20
> > >               if (ret)
> > >                       return -EINVAL; =20
> > Unconnected to this patch but why are we eating the error code from kmx=
61_get_odr()?
> > In practice makes no difference as -EINVAL is the only error returned.
> >
> > Still nice to do
> >                 if (ret)
> >                         return ret;
> > so we don't need to go check that.
> > I'd be fine with you sneaking this in this patch with a brief not in th=
e commit
> > message if you want to. Or can leave for another day.
> > =20
>=20
> Seems like a better idea to do this in a separate patch, perhaps where
> we refresh some of the returns/control paths in the file. But at the
> same time not opposed to sneaking this in if I end up touching that
> function in a different patch.

Sure.
>=20
> > =20
> > >               return IIO_VAL_INT_PLUS_MICRO;
> > > +     default:
> > > +             return -EINVAL;
> > >       }
> > > -     return -EINVAL;
> > >  }
> > > =20

> > =20

