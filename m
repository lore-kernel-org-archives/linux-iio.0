Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C32E11D2;
	Sun, 26 Apr 2026 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777200511; cv=none; b=rDHaEc8g3859/3Xs+wYViNOSQ2Cpz/CYjsuuAxhQiG+vEv0qCFsTrRco31fPbgAwT32rzOqBLnpYFKCgiubXv6UuhnmBE/tmxHTi8f3A1pmokPED+0VV+wpJbc3hvq/r2oprt7p0VxUPn1ozBb9vRHr4zGL5o6+OYyrua+kNAlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777200511; c=relaxed/simple;
	bh=/Fu+y3SMKEyVtO6DjohJMWL1vxCvN/MNCumNGm+V/z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVse1Ye7vI6i1H+eH23nY7sngmwplRnnFVPDLTEZZjlAqvHz6jD2HtJaFbzRthHGH5rqDKz6bCuGBnTyDJMm6fz93i3fZBJfBGviq0giGu7AWW+77VZO3jbisLmvhV/ZN6WpVlb02so07r7pbbhugH9LH/G/f6grzfWVFkyUWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qsl3yX1K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qsl3yX1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B581CC2BCAF;
	Sun, 26 Apr 2026 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777200511;
	bh=/Fu+y3SMKEyVtO6DjohJMWL1vxCvN/MNCumNGm+V/z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qsl3yX1KHT7zKH771RkKCD+vzFDVlqihQM/x2E18ziK58ByI08XhIJj2blGcHYsR6
	 +sHLBIqvL9A49QqEQyd4MOpUi8PjGnfat/NFScwqAwuL8tAaEpdsC+nwO5FoSaE5/q
	 AOunKCZ7kgzSl98kNBCAarY6ySnscazlyorJ30YPY6hsy7mNiYUfuRkw3rgzHJ+2of
	 gSFFFAEyRPC6dPyiZx1kp9Rpo4OL30VBn9S/3BajaYJpaiBAqCZCe0xOVM1SQXxYn1
	 cKQ8tU/KoZLGWvtI+zPSFqfl27342SFmS8NhjfbA5yPPgO3AI306PHJaA3qBw1Yxxa
	 L7sn+OINdV8Ng==
Date: Sun, 26 Apr 2026 11:48:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Aldo Conte <aldocontelk@gmail.com>, linux-iio@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC] iio: light: tcs3472: implementing wait time TODO
Message-ID: <20260426114823.2badc4ed@jic23-huawei>
In-Reply-To: <4bff0c2c-f054-4098-a299-8030078f9b2c@baylibre.com>
References: <73d2183e-dffe-4ae4-9312-c544e0079f3a@gmail.com>
	<46fd475f-8d54-4419-a195-d66c947fcc1b@baylibre.com>
	<3d4a4dbd-6618-4b63-ade1-d68155bac3ac@gmail.com>
	<4bff0c2c-f054-4098-a299-8030078f9b2c@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 25 Apr 2026 18:11:23 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/25/26 2:00 PM, Aldo Conte wrote:
> > On 4/25/26 18:49, David Lechner wrote: =20
> >> On 4/25/26 11:28 AM, Aldo Conte wrote: =20
> >>> Hi all,
> >>>
> >>> I'd like to resolve the wait time TODO in tcs3472.c. =20
> >>
> >> Do you actually have this hardware to test it?
> >>
> >> What is the application that needs to make use of this feature?
> >> =20
> > I'm currently participating in the 2026 linux kernel mentorship program=
. I don't really have an application that would use this feature, but in an=
y case, I have the hardware (Adafruit TCS34725 breakout board to test with =
a Raspberry Pi 3B) to test everything out. =20
>=20
> Do you have a logic analyzer or oscilloscope too? Having a tool like that
> is important to be able to see that the timing of the signals on the hard=
ware
> are matching what we have requested.
>=20
> I guess if not, there is the gpio-sloppy-logic-analyzer in the kernel. :-)
> Real tools are of course much nicer.
>=20
> >=20
> > As part of this experience, I'm focusing on =E2=80=9Clight=E2=80=9D and=
, while looking through the TODO, i noticed this and wanted to explore it f=
urther.
> >=20
> >  =20
> >>>
> >>> The TCS3472 has a WTIME register and WEN bit that insert a low-power =
=20
> >>
> >> What about WLONG?
> >> =20
> >>> wait state between RGBC cycles. The register is already defined in th=
e driver but never used.
> >>> I noticed that tsl2772.c enables wait with a fixed default and no
> >>> userspace control. However, I think exposing the wait time to
> >>> userspace would be more useful to tune the power/responsiveness trade=
off. =20
> >>
> >> I assume this would affect the effective sample rate? =20
> > yes =20
> >> =20
> >>>
> >>> My plan would be to expose it via an ext_info attribute in
> >>> microseconds, following the same convention as integration_time.
> >>> Does that sound acceptable, or would you prefer a simpler approach
> >>> with just a fixed default like tsl2772? =20
> >>
> >> So perhaps we could just use the standard sampling_frequency attribute=
? =20
> >=20
> > Just want to make sure I understand the sampling_frequency approach
> > correctly before implementing.
> >=20
> > The total cycle time of the chip is:
> >=20
> > =C2=A0 cycle =3D wait_time + rgbc_init + integration_time
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D (256 - WTIME) * 2.4ms + =
2.4ms + (256 - ATIME) * 2.4ms
> >=20
> > So sampling_frequency =3D 1 / cycle.
> >=20
> > On a write, the driver would keep ATIME fixed (since the user
> > controls it independently via integration_time) and solve for WTIME:
> >=20
> > =C2=A0 wait_time =3D (1 / requested_freq) - 2.4ms - atime_duration
> > =C2=A0 WTIME =3D 256 - (wait_time / 2.4ms)
> >=20
> > For very low frequencies where the wait exceeds 614 ms, the driver
> > would automatically enable WLONG in the CONFIG register to extend
> > the step from 2.4 ms to 28.8 ms.
> >=20
> > But i wanto to clear my self this: changing integration_time would impl=
icitly change
> > the effective sampling_frequency since both contribute to the cycle
> > time. Is that acceptable, or should the driver recalculate WTIME
> > when ATIME changes to maintain the current sampling_frequency? =20
>=20
> This sounds like the right way to do it. It is normal for changing one
> attribute to affect another attribute like this, so that is not a problem.
>=20
> Either way of handling WTIME is acceptable, but I think that recalculating
> WTIME to keep as close as possible to requested_freq when ATIME changes is
> more user-friendly.

Agreed - given it is fairly easy in this case the user friendly route is
the way to go even though the approach of one ABI element modifying the
value of another is allowed we don't need to use that flexibility much
here except at the boundaries where say increasing integration time
means we can't meet a previous sampling_frequency target and hence have
to increase it.

>=20
> >  =20
> >>>
> >>> I also plan a following patch converting the driver to devm. =20
> >>
> >> Would be better to do this first before adding new features.
> >> =20
> > ok i could bring it up in the series assuming instead that the WTIME ne=
w feature is actually wanted, since I don't have a real-world application. =
=20
>=20
> If it would require a custom attribute, I would say wait until we really
> need it. But this sounds fairly straight-forward, so I would say go for i=
t.
> You never know who might want to make use of that feature. :-)

So if I follow this correctly it is only useful if some sort of continuous =
sampling
is going on. E.g. events?  If so that's fine as I assume it trades off
power usage against responsiveness to light level changes and that's a reas=
onable
thing to want to control.

>=20
> >>>
> >>> Thanks,
> >>> Aldo
> >>> =20
> >> =20
> >  =20
>=20

