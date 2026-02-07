Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70E2FD7B3;
	Sat,  7 Feb 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770478946; cv=none; b=cMAazffQ6zjWpl00e4FLuRRcOpeyXe/TBbPMZIPZzEGbyiGorB43FzvIZp+GvTVtyyQGxLNcJjMBHwCrN8W+HOgD3ScNr6QSMTIKKjv4qk5kChRJHfZb8yBfiwdaT6AVFPzBK1a7M9eMFxtXHsXhdwkjdLl73i055/L8v3SGFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770478946; c=relaxed/simple;
	bh=DcCrYGs+NtCxLnkMRRtzh7ForvdqfsheWKjbKIbaxvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYSTq1bjyj+55YLJzxnd7WG+FQIkdPZLU6WriSM3u/iknSiwaJwfJzIkg2yNsrGRMTmxI3jph7OjXrp0SQNtUj6RnfTfxHR+K5af3LMSU0rjhSwCoDBgcSlsJqwDKsPEyByiEx1HEpgp7t4Fp8ZXrPTavSg3d0uAdeE9gHmGmA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE/JB17B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE/JB17B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831A5C116D0;
	Sat,  7 Feb 2026 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770478946;
	bh=DcCrYGs+NtCxLnkMRRtzh7ForvdqfsheWKjbKIbaxvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IE/JB17B2dYmz+TXhHlmwELI71ou5SdmlbmJ3fBUFqSUVwU7rVRDjU55p9ve1Rgzu
	 9JKcjlV25SL9LXvQCQDvSC4NuAZC0jL0hQZIRjv7Cx06ofPkIDlIBpki45XpjdpzhT
	 Sr1QysOZ58jGK0oAmgzir1olye+I0oRnqa2ixpO7aj6d2ro74dFYcUJI4v/a3VXUA7
	 +7KB6uwutZvVys2oq79afBquEll5d+VYru+r0SSZurthlNu6wS7as1IH+h3Jw3ESIZ
	 8Z5egWGbUE5ZlMVLRbIyFv0GeeujyKZwJXYr8X1TIa2gwfOjxXM6Zr9A4QWBfEM778
	 +h+PmT7Nn0hLQ==
Date: Sat, 7 Feb 2026 15:42:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Bert Karwatzki 
 <spasswolf@web.de>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jiri Kosina  <jikos@kernel.org>, Thomas Gleixner
  <tglx@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
Message-ID: <20260207154218.2053c98c@jic23-huawei>
In-Reply-To: <0a3433112f0bec3d5bd76c7ae9b6774b455203a6.camel@linux.intel.com>
References: <20260113120541.YVf2vRA3@linutronix.de>
	<20260202232741.13380-1-spasswolf@web.de>
	<20260203083826.1gOzxrwt@linutronix.de>
	<0a3433112f0bec3d5bd76c7ae9b6774b455203a6.camel@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 03 Feb 2026 09:29:25 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Tue, 2026-02-03 at 09:38 +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-02-03 00:27:40 [+0100], Bert Karwatzki wrote: =20
> > >=20
> > > The warning appears because iio_triggered_buffer_setup_ext() (in=20
> > > drivers/iio/buffer/industrialio-triggered-buffer.c) is called with
> > > thread =3D NULL
> > > during the probe of the iio device and calls iio_alloc_pollfunc()
> > > (in drivers/iio/industrialio-trigger.c) with thread =3D NULL and type
> > > =3D IRQF_ONESHOT.
> > >=20
> > > A simple fix could be this:
> > >=20
> > > diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > index 9bf75dee7ff8..40eea3a44724 100644
> > > --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > @@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev
> > > *indio_dev,
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->pollfunc =3D ii=
o_alloc_pollfunc(h,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 threa=
d,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_ONE=
SHOT,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thread ?
> > > IRQF_ONESHOT : 0,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio=
_dev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s_c=
onsumer%d",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio=
_dev->name,
> > >=20
> > >=20
> > > Are there any problems with this? =20
> >=20
> > Urgh. Haven't seen those.
> >=20
> > Looking at all the users of of *iio_triggered_buffer_setup*() the
> > primary handler is either NULL or iio_pollfunc_store_time().=20
> > So IRQF_ONESHOST should work all the time.
> >=20
> > Then there is=20
> > - drivers/iio/adc/vf610_adc.c=20
> > - drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> >=20
> > They use iio_pollfunc_store_time() as primary and have no secondary.
> > This would trigger the warning but not having a secondary handler
> > while
> > returning IRQF_WAKE_THREAD should create a warning of its own.
> > What did I miss?
> >  =20
>=20
> hid-sensor doesn't need a bh handler. This patch can fix.=20
>=20
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 5540e2d28f4a..b2b09b544f43 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -227,6 +227,11 @@ static const struct iio_trigger_ops
> hid_sensor_trigger_ops =3D {
>         .set_trigger_state =3D &hid_sensor_data_rdy_trigger_set_state,
>  };
> =20
> +static irqreturn_t triggered_buffer_handler(int irq, void *p)
> +{
> +        return IRQ_HANDLED;
> +}
> +
>  int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char
> *name,
>                                 struct hid_sensor_common *attrb)
>  {
> @@ -240,7 +245,8 @@ int hid_sensor_setup_trigger(struct iio_dev
> *indio_dev, const char *name,
>                 fifo_attrs =3D NULL;
> =20
>         ret =3D iio_triggered_buffer_setup_ext(indio_dev,
> -                                            &iio_pollfunc_store_time,
> NULL,
> +                                            &iio_pollfunc_store_time,
> +                                            triggered_buffer_handler,
>                                              IIO_BUFFER_DIRECTION_IN,
>                                              NULL, fifo_attrs);
>         if (ret) {
>=20
>=20
> Or add it to industrialio-triggered-buffer.c as a common handler for
> all caller with no bh, whatever Jonathan prefers.

I'm confused about how this works today.  Why do we store a timestamp
in the pollfunc structure that is never used by a bottom half?

If we have an actual top half that doesn't need a bottom half, then the
core code can easily insert a dummy handler, or register something sensible
in the first place.
=20
Jonathan

>=20
>=20
> Thanks,
> Srinivas
>=20
>=20
>=20
> > > Bert Karwatzki =20
> >=20
> > Sebastian =20

