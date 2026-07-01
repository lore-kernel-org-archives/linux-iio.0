Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3525A391E60;
	Wed,  1 Jul 2026 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932388; cv=none; b=jOBy8u3jstcPN8+4aLgeE2kzkqjmUI5X+/H8SxQB2QvPVrv1sd0dx03Ekq9vI0NCXqQ1aj84E5vYbpTW+lL2WW3wjYYa+aq8DSqoCtREsDHLEM//r7mVrPbWT11fI1SFfjOwhan56iSFndkgY1ISRcLRZODNS52xQcApc+CgFLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932388; c=relaxed/simple;
	bh=yklfWqOqL9Uq4ypm/D5sV+nIIGrT1MkSU8003SPXEBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5ZkRQxueJiiDymPegAiU1gSl1lwLvbbl5mOC5zFQbpDSghTerPGZgW7nyBufFOwhrGRrn2rIcM302wPa1kmB1vT5M2BcydiZizOhIR8LuvICxgSDS6ofms8nIgMuCATREuGOW3SIC19HhfahSZIsDgDzz5Whj9arXa5+WCHRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQlV4Y78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQlV4Y78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CE21F000E9;
	Wed,  1 Jul 2026 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782932386;
	bh=ojdFluGbUEWv9myk7UFalmzFrH056GayllzlbsuXXJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RQlV4Y78Diy75mdPyo1eXXrWscV7LPpkF/u09uPUxy/XRsf5gWF1zOJEMMCWKNZrm
	 rjYjs0tEyiWZ1BFUN+Mfw1IYd3MdTUMSulrsMeYBjgOkieYu064fFY8jbWrIf6aA6q
	 Z3ARC44gduoFbcTJvzGhA0VK22sFlVg4gUqv2oDSWvEQeTGK1vJPXjl21if3s/DlzC
	 bRkKgLEAuPys+G/nm64LCMrb/CIy3nfPGvrmfhC6s208D8ezP5jXJ663uKRNOzkgcy
	 yO08sx00WSiw6yeR8YrzkTysc8wAGJczNa1wEyQh+3paNXM7pmNuvVo/qKTh4qxzed
	 zPKljNYf1I7hA==
Date: Wed, 1 Jul 2026 19:59:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Kittisak Boonmapa  <goorock.goopop@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, joshua.crofts1@gmail.com
Subject: Re: [PATCH] iio: hid-sensors: Fix poll_value sign check before
 msleep_interruptible
Message-ID: <20260701195941.32bc60e7@jic23-huawei>
In-Reply-To: <9975d6ea1a0afb3dd0cdebc050512c368a2b9c05.camel@linux.intel.com>
References: <20260701154319.23497-1-goorock.goopop@gmail.com>
	<20260701184707.5165a903@jic23-huawei>
	<9975d6ea1a0afb3dd0cdebc050512c368a2b9c05.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 01 Jul 2026 10:59:00 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Wed, 2026-07-01 at 18:47 +0100, Jonathan Cameron wrote:
> > On Wed,=C2=A0 1 Jul 2026 22:43:19 +0700
> > Kittisak Boonmapa <goorock.goopop@gmail.com> wrote:
> >  =20
> > > hid_sensor_read_poll_value() returns -EINVAL when the HID
> > > descriptor
> > > does not contain a Report Interval feature field.
> > >=20
> > > _hid_sensor_power_state() currently treats any non-zero value as a
> > > valid delay and passes it to msleep_interruptible(). Since
> > > msleep_interruptible() takes an unsigned int, negative values are
> > > converted into very large delays.
> > >=20
> > > Only sleep when poll_value is positive.
> > >=20
> > > Fixes: 5d9854eaea77 ("iio: hid-sensor: Store restore poll and
> > > hysteresis on S3")
> > > Closes:
> > > https://lore.kernel.org/linux-iio/CAPr6G1qLDrgHvCNsVxj7xHxYUKkAkyo87H=
q3Lfyoj3RaZ2v4dg@mail.gmail.com/
> > > Reported-by: Kittisak Boonmapa <goorock.goopop@gmail.com>
> > > Assisted-by: Anthropic:Claude Sonnet 4.6
> > > Signed-off-by: Kittisak Boonmapa <goorock.goopop@gmail.com>
> > >  =20
> > Bug looks to be correct, but fix it by returning much earlier.
> > If that function is returning an error something is very wrong and
> > we should fail at that point, not just skip a sleep later.
> >  =20
> Even if the report interval is not specified, but it has power state,
> so returning early will fail to set power state.
>=20

Ah. Fair enough.  In that case as below, explicitly catch the error
and put a default in place rather than relying on an error code in
a variable that isn't obviously going to contain one.

Jonathan

>=20
> Thanks,
> Srinivas
>=20
>=20
> > > ---
> > > The bug was discovered while implementing a custom USB HID Sensor
> > > (Accelerometer 3D, HID Usage 0x200073) on a Seeed XIAO nRF52840
> > > Sense
> > > for use with the Linux IIO subsystem and iio-sensor-proxy.
> > >=20
> > > The device intentionally omitted the Report Interval feature from
> > > its
> > > HID descriptor. This causes hid_sensor_read_poll_value() to return
> > > -EINVAL, which is then treated as a non-zero delay by
> > > _hid_sensor_power_state() and passed directly to
> > > msleep_interruptible(). Since msleep_interruptible() takes an
> > > unsigned int, the negative value is converted into an unintended
> > > sleep of approximately 49.7 days.
> > >  =20
> >=20
> > For this non implemented feature, we need to explicitly handle the
> > error and if seen put an appropriate replacement value in place.
> > That may well be zero. I'm not sure!=C2=A0 Setting such a 'default'
> > value provides a place to add a comment on why we are doing so.
> >=20
> > Jonathan
> >  =20
> > > The issue was reproduced consistently on a Steam Deck LCD running
> > > Bazzite (Linux 6.17.x), and disappeared completely after adding the
> > > Report Interval feature to the HID descriptor, confirming the root
> > > cause.
> > >=20
> > > This patch changes the condition to sleep only when poll_value is
> > > strictly positive, avoiding unintended delays while preserving the
> > > existing behavior for valid poll intervals.
> > >=20
> > > =C2=A0drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > index 417c4ab8c1b2..20099614bb27 100644
> > > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > @@ -143,7 +143,7 @@ static int _hid_sensor_power_state(struct
> > > hid_sensor_common *st, bool state)
> > > =C2=A0	sensor_hub_get_feature(st->hsdev, st- =20
> > > >power_state.report_id, =20
> > > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->power_state.index,
> > > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(state_val), &sta=
te_val);
> > > -	if (state && poll_value)
> > > +	if (state && poll_value > 0)
> > > =C2=A0		msleep_interruptible(poll_value * 2);
> > > =C2=A0
> > > =C2=A0	return 0; =20

