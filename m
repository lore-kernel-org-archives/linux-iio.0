Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D522282F35;
	Wed, 13 May 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677901; cv=none; b=YIpTtePMQ6NU2H98wYYf8C65N3cloQ0hWSfeAZkKL31ogfU1Ylhal9q2UWXy9T90IObkPS1BmmvxIdUtK/8bFNIP5shvB43ncur/pavncAte06+fcA/LORdE9CK3DJRysfZv5CnBUvH76FAbZGaiFAejWa6I4rUOAKUigSGdKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677901; c=relaxed/simple;
	bh=fDH8V65ohRlFxgkC2lS062ZtAhSL8HoizkD5jXgPnZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9m91sD6yKVdnilXDjwf1TyfwUVP/Lhf4Sa4fwrl9+pKmarxYunFHq5KOZXrV9xL4NhIi8Ev+Vx4K2qiIvmUdrFxzVcOic63km+FpEIp9YlO7FNsJvABeEPlD4w1QPU+hifh3AH6z9CsSs/Y3Yb+7m33TmNbljXvHcSx7yHymTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe5LYspr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe5LYspr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8056C2BCB7;
	Wed, 13 May 2026 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778677901;
	bh=fDH8V65ohRlFxgkC2lS062ZtAhSL8HoizkD5jXgPnZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pe5LYspryHjMmmxKtIQW9k7VZLfOzWFa/O2Krlwn8ekDEoFunz7mKH1Ki0CJOrf57
	 ToG6bW5h9uB2ZIKPtxKVmNqMarRLwY2hu+B4hPNogRBnMqhC8J6BWJHd9cF5kPngNl
	 wHtyK3gp+H/iYc2VOKlWsYx4XXSzPauxhDAUGOmbJl66u+5We3C2XsLoN1Fq+nhjTk
	 9fgCeXWThoiMTQZvwIOs5hDVPiY49qL0cvlPgAm8m4DDI8FLHKiCnduO9eo/v4AtDh
	 XCaerIbVeLKdA5bg5A3dn37pZmK/5PPI9ByeyyuSDU+niKQfFHsVxRPEgDlnuAeHVi
	 IU7jlyzolsebg==
Date: Wed, 13 May 2026 14:11:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: kmx61: Fix TOCTOU race condition
Message-ID: <20260513141132.27341fe7@jic23-huawei>
In-Reply-To: <CAKqfh0GPx8D-eGfoDw0epa8mN7fQGD-hpm9sZfimPKcj_RR3QA@mail.gmail.com>
References: <20260512120356.40839-1-m32285159@gmail.com>
	<DIGSQPV2STJK.2S7C67L7I0RTJ@gmail.com>
	<CAHp75VdxUR0jdW2-k5SVGC22OK07VxHK2ORtVdSdniPWdcniPA@mail.gmail.com>
	<CAKqfh0FyELOpgB1W+_nv4a1G1tuSjnVxbEFrUeR2+KCT2Q=-Ug@mail.gmail.com>
	<20260512181040.7578fbd0@jic23-huawei>
	<CAKqfh0GPx8D-eGfoDw0epa8mN7fQGD-hpm9sZfimPKcj_RR3QA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 12:37:56 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Tue, May 12, 2026 at 12:10=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Tue, 12 May 2026 10:30:42 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> > =20
> > > On Tue, May 12, 2026 at 10:25=E2=80=AFAM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote: =20
> > > >
> > > > On Tue, May 12, 2026 at 6:17=E2=80=AFPM Maxwell Doose <m32285159@gm=
ail.com> wrote: =20
> > > > >
> > > > > On Tue May 12, 2026 at 7:03 AM CDT, Maxwell Doose wrote: =20
> > > > > > A Time-of-check to Time-of-use race condition is present in
> > > > > > kmx61_write_event_config(). Move the mutex_lock() call above it=
 to fix
> > > > > > it. =20
> > > >
> > > > I think you want to elaborate a bit more on this. Id est explain why
> > > > ev_enable_state needs to be protected. Not everybody is willing to =
go
> > > > to some site to read some AI reports and interpreted them.
> > > > =20
> > >
> > > Can do that for v2. I believe that it needs to be protected since
> > > later we set ev_enable_state to false (basically right after). Could
> > > be wrong of course, but Jonathan did confirm the TOCTOU. =20
> >
> > I'd talk more about how we'd get a race.  If two calls enter the functi=
on
> > at the same time (which is easy to do) they may both pass this check be=
fore
> > getting to the lock.  Therefore we end up with at best pointless repeat=
ed
> > work, at worst a reference or similar count issue. You'd need to look c=
losely
> > at what is protected to be sure whether it benign waste of time or a re=
al
> > bug.
> > =20
>=20
> Well, since we're accessing the shared state via kmx61_get_data (by
> the way of iio_priv), we could check that value, pass the check, and
> then have the value change before we acquire the lock. TOCTOU race,
> no? If data->ev_enable_state is false then becomes true after we check
> the value but before we get the lock, then ev_enable_state changes to
> whatever the input variable state is. Anyways, just saying that this
> is certainly a bug. Would coming across it be common? Probably not,
> likely one of the much rarer ones, but still worth fixing.

It's not a bug if for instance two racing value sets result
in any random one of them being written.  That happens even with the
locking. It is only a bug if letting both of them write results
in something overflowing.  Some writes in cases like this are idempotent
- e.g. turning something on that is already on has no affect.

My guess would be that the power state transition could happen twice
in the enable direction resulting in +2 rather than +1 resulting in
a reference counter that may never go back to 0.

Let's look at the code and the various state combinations.
Ignore motion_trig_on for now.

state =3D=3D true and data->enable_state =3D=3D false

static int kmx61_write_event_config(struct iio_dev *indio_dev,
				    const struct iio_chan_spec *chan,
				    enum iio_event_type type,
				    enum iio_event_direction dir,
				    bool state)
{
	struct kmx61_data *data =3D kmx61_get_data(indio_dev);
	int ret =3D 0;

	if (state && data->ev_enable_state)
// Both threads pass this check
		return 0;

// Threads serialized in next section
	mutex_lock(&data->lock);

//ignore for simplicity - though I'm far from convinced this
//is right either for the state =3D=3D false path when
//motion_trig_on =3D=3D true - I think the runtime pm counters
// will not be decremented whereas they were incremented
// on the state =3D=3D true, motion_trig_on =3D true path.
//	if (!state && data->motion_trig_on) {
//		data->ev_enable_state =3D false;
//		goto err_unlock;
//	}


//Next bit runs twice and in there we pm_runtime_resume_and_get()
//which will run twice for the same thing being enabled - hence the +2
//reference count mentioned above.
	ret =3D kmx61_set_power_state(data, state, KMX61_ACC);
	if (ret < 0)
		goto err_unlock;

	ret =3D kmx61_setup_any_motion_interrupt(data, state);
	if (ret < 0) {
		kmx61_set_power_state(data, false, KMX61_ACC);
		goto err_unlock;
	}

	data->ev_enable_state =3D state;

err_unlock:
	mutex_unlock(&data->lock);

	return ret;
}

Anyhow, looks like a nest of race conditions.  If you don't mind
could you take a look more generally at the state machines in here
and see if we have more bugs to close?  That will also help you
describe why this particular fix is right.

Jonathan

>=20
> best regards,
> max
>=20
>=20
>=20
>=20
> > Jonathan
> > =20
> > >
> > > best regards,
> > > max
> > >
> > >
> > > =20
> > > > =20
> > > > > Reported-by: sashiko <sashiko-bot@kernel.org>
> > > > > Closes: https://sashiko.dev/#/patchset/20260507223337.48437-1-m32=
285159%40gmail.com =20
> > > >
> > > >
> > > > --
> > > > With Best Regards,
> > > > Andy Shevchenko =20
> > =20

