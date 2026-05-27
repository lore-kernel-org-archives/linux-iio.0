Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6B379EDA;
	Wed, 27 May 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877774; cv=none; b=XGhual5x6gQ80IfONkM6jp5eWsMe2jQLfXXPn3bOQZG9lidDnV8o2SP13nV+LY3q0/TNpETpn9XPxgULhuKWZ7PxgQg662vT3MmEhEeBZjEsCDf42fDbER0Y8AWH68bycWxOLuY8lhh7l5Qj/6ToLADBayg9OFt7nFsFESzUoYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877774; c=relaxed/simple;
	bh=M9xKL+2b0Qsxva1mcAgc3MDLFXPX0LtbRN1p4T2vTEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2uYpdQpa16is0R7Uxg+MUeF9OCz/6d040q/YqKHENpLIjDM6fvYPCMIKXIb7x0ipofH7OqVdFWV7VaBWJ+lQV01CUhgQAL+fdmaJCIe2CJaX9hfUZLtfUyy0eNrZyt93KWcj4ZdwoQjNLlA51JnUbY+wCC/mruqGKeUQt69K8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e48l43D9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e48l43D9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77A31F00A3A;
	Wed, 27 May 2026 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779877772;
	bh=ZSDedjSCkn5KXuYFKR/zV/yAW40rPT++dt1A3rZcHU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e48l43D9am2jb29BOJWKXnz8qFapisRR6bvc/1ZVB+nQE4+ESQD+5oU9F9u5wcQE1
	 XNLhY73cwn1SDi9qSpfUJkerflMJS8N7z98qFXH73hmkUUO+Zebeuv4S8EDjNFfunk
	 PLEhewsBrt6Vp6T8WO3EeuVGthR4L+4WgJi3VMENDb4X71QN09czAQ7H5dgwiZZW6q
	 eqkQlG0mfdPrqIk7c36dIh1HFmmuAo+SY/H5JeYYg3W24gGbwt0cej4DUEQlyegz6q
	 LxJXhdFdZSQ1V8OvchDnUJV9FLPwnPH5XFaPKpNF4GxZjagcPi2QDhSM27Hw/wPABf
	 UFEh4xpbf9SwA==
Date: Wed, 27 May 2026 11:29:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, "open list:IIO
 SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] iio: chemical: scd30: Replace manual locking with
 RAII locking
Message-ID: <20260527112924.465bc273@jic23-huawei>
In-Reply-To: <CAKqfh0ErDrDi++OZiQhJVLujtwKV3vN-zmNZzhz7EfF8wAc-WQ@mail.gmail.com>
References: <20260523182531.10146-2-m32285159@gmail.com>
	<20260526154709.7dfa5f0c@jic23-huawei>
	<CAKqfh0ErDrDi++OZiQhJVLujtwKV3vN-zmNZzhz7EfF8wAc-WQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 May 2026 15:31:10 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Tue, May 26, 2026 at 9:47=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sat, 23 May 2026 13:25:32 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> > =20
> > > scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> > > calls. Replace them with the newer guard(mutex)() for cleaner RAII
> > > patterns and to improve maintainability.
> > >
> > > Add new helper function scd30_trigger_handler_helper_locked() contain=
ing
> > > the critical section for scd30_trigger_handler(). After moving
> > > scd30_trigger_handler()'s critical section into the new helper, tune =
up
> > > control logic to return ret early and not memcpy() if it's an error
> > > condition.
> > >
> > > In addition, small refactor to replace "?:" operator with regular
> > > if/else returns.
> > >
> > > Signed-off-by: Maxwell Doose <m32285159@gmail.com> =20
> > Just some naming things inline.
> >
> > I thought about just changing them and applying but decided
> > I'd rather you took another look to make sure you agree
> > with the suggested changes (and if you do send me a v5)
> >
> > Thanks,
> >
> > Jonathan
> > =20
> > >  static ssize_t calibration_forced_value_store(struct device *dev, st=
ruct device_attribute *attr,
> > > @@ -424,11 +430,13 @@ static ssize_t calibration_forced_value_store(s=
truct device *dev, struct device_
> > >       if (val < SCD30_FRC_MIN_PPM || val > SCD30_FRC_MAX_PPM)
> > >               return -EINVAL;
> > >
> > > -     mutex_lock(&state->lock);
> > > -     ret =3D scd30_command_write(state, CMD_FRC, val);
> > > -     mutex_unlock(&state->lock);
> > > +     guard(mutex)(&state->lock);
> > >
> > > -     return ret ?: len;
> > > +     ret =3D scd30_command_write(state, CMD_FRC, val);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return len;
> > >  }
> > >
> > >  static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
> > > @@ -579,24 +587,36 @@ static irqreturn_t scd30_irq_thread_handler(int=
 irq, void *priv)
> > >       return IRQ_HANDLED;
> > >  }
> > >
> > > +/* Meant ONLY for scd30_trigger_handler() */ =20
> >
> > No need to say this in a comment. The code naming is clear enough. Howe=
ver...
> > =20
>=20
> Agree here with the removal of said comment.
>=20
> > > +static int scd30_trigger_handler_helper_locked(struct iio_dev *indio=
_dev,
> > > +                                            int *scan_data, int arr_=
size) =20
> >
> > Avoid using _locked() in naming.  It isn't clear to readers if that
> > means it is locked already, or will lock..  Also somewhat unnecessary
> > here. We don't need the function name to say why there is a helper.
> > =20
>=20
> Ah...I'm honestly not sure. I know we've decided that _locked was
> appropriate in certain cases, I wonder if that may also be the case
> here. I guess though since I'd have to send a v5 anyways I'll change
> that.
>=20
> >
> > arr_size would normally mean array size - i.e. how many ints
> > there are in scan_data.  Here it is the size of scan_data - probably
> > also make it a size_t
> > =20
>=20
> Hm, perhaps? I definitely agree with size_t, I'm not so sure on
> changing the name. However like I said since I'd likely have to send a
> v5 anyways I'll switch up the naming.

Given people will associate arr_size with ARRAY_SIZE() which on this array
would return the number of ints (so /4), that name definitely needs to chan=
ge.
Exactly what it changes to is a different question!

>=20
> >
> > So this whole thing becomes
> >
> > static int scd30_trigger_handler_helper(struct iio_dev *indio_dev,
> >                                         int *scan_data, size_t scan_dat=
a_size)
> >
> > =20
>=20
> Sounds good.
>=20
> best regards,
> max

