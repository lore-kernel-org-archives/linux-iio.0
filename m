Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBF3090FF
	for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774179903; cv=none; b=OGUFcVYXMb30edCrLfMou4+yfam0pMun12q2lKlMyev8c5rVwm9vsPxdsQe313WQRjCTEzdBJQ3PQIdSKlLHZQrch/xdbGyMQglSta0tx9kGzOv7Sj+fls7UT8vikEzg5TttEoSzj4vkZ5lCO2BB+JeKp0YEhSucW0EIG+Qs8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774179903; c=relaxed/simple;
	bh=GWqTE4UFLXo+YLpyun/phZl2r22sqihTgYY0eJRgC/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPNaoJFROyykxZOjwSh4S/Sy+Jg9XqEvj36YOmI6gwo3344obRKAg5uEaOW3mt9VzFgT3eszyyyQvR06/cZvABR6nOs9gTpyaoDl3PARe0mg8JuAk7kKrEwZWqKCU19azo23rfS2fATN77Oo1grWKKDZ6JZcCAq4DvY5IK/KiQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4wFzjR2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4wFzjR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6CAC19424;
	Sun, 22 Mar 2026 11:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774179903;
	bh=GWqTE4UFLXo+YLpyun/phZl2r22sqihTgYY0eJRgC/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N4wFzjR2Jn9Qe1n3XR2PMNxYd0PcS56l1NwIoScwfsoNiM7VvJRP/gi4gex3QFcr+
	 GEERRH9Sq3Az4C82GmVRkI/y+fdHUu+M7kF5iXF+FllN/T2GtllflotbBN8A09xh/H
	 oodxileMOWwMPjrXWPuWe/wXZF6R0vQ4DNe/Q2NoZWk9CvfFBSkLhC68ZeGtc47Hqo
	 huLq9iWUv3f6liztlWqnWG4yAq0+IVTBJGwQMxZl1cw/52BrxcDqrrPU2kr/+rMsNR
	 wYbCjPNP92/LwKaNElnZbs2tfxxERMb5DqSaMJNMzUMfCmpaywBdz4kP6V4Uo4qdYV
	 FgXlxI/VjaVPw==
Date: Sun, 22 Mar 2026 11:44:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andrej Valek <andrej.v@skyrain.eu>, linux-iio@vger.kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, puranjay@kernel.org,
 jonathan.cameron@huawei.com
Subject: Re: [PATCH] iio: accel: fix ADXL355 temperature signature value
Message-ID: <20260322114454.09af2aa4@jic23-huawei>
In-Reply-To: <16d93b99-00a0-4cc3-909f-26aba8082af6@baylibre.com>
References: <20260313092413.35912-1-andy@skyrain.eu>
	<a2e56b5c-ef76-4a6a-9ffc-e8fe259a7153@baylibre.com>
	<25c766b7-d66a-4638-9995-b5936ca87b7a@skyrain.eu>
	<16d93b99-00a0-4cc3-909f-26aba8082af6@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Mar 2026 11:18:18 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/15/26 10:35 AM, Andrej Valek wrote:
> > Ah, I see, I described it wrongly.
> >=20
> > On 14.03.2026 21:22, David Lechner wrote: =20
> >> On 3/13/26 4:24 AM, Andrej Valek wrote: =20
> >>> From: "Valek Andrej <andrej.v@skyrain.eu>"
> >>>
> >>> Temperature was wrongly represented as 12-bit signature, confirmed by=
 DS. =20
> >> signature =3D=3D signed integer? =20
> > Correct, temperature is wrongly represented as signed 12-bit number, wh=
ile it has to be unsigned. =20
> >>
> >> DS =3D=3D datasheet? =20
> > Yes =20
> >> =20
> >>> Even if the temperature is negative, the value in the register stays
> >>> unsigned. =20
> >> And IIO_CHAN_INFO_OFFSET will be negative. =20
> > Not sure what do you mean by this. I can only say, that output type was=
 "be:s12/16>>0" and should be "be:u12/16>>0". So when some upper layer want=
ed to represent the number it "overflowed", while the bits have been masked=
. =20
>=20
> Mostly I was talking to myself on this point. No action is needed here.
>=20
> >> =20
> >>> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
> >>> ---
> >>> =C2=A0 drivers/iio/accel/adxl355_core.c | 2 +-
> >>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adx=
l355_core.c
> >>> index 1c1d64d5cbcb2..8f90c58f41008 100644
> >>> --- a/drivers/iio/accel/adxl355_core.c
> >>> +++ b/drivers/iio/accel/adxl355_core.c
> >>> @@ -745,7 +745,7 @@ static const struct iio_chan_spec adxl355_channel=
s[] =3D {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(I=
IO_CHAN_INFO_OFFSET),
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .scan_index =
=3D 3,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .scan_type =3D=
 {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
sign =3D 's',
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
sign =3D 'u',
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .realbits =3D 12,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .storagebits =3D 16,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .endianness =3D IIO_BE, =20
> >>
> >> =20
> > Conclusion =3D Should I send a new version with "fixed" description? =20
>=20
> Sometimes, for small tweaks, Jonathan will just fix it while applying the
> patch. So wait for for his feedback.
>=20
> You can also see the status of the patch in patchwork at [1]. If the State
> changes to "Changes requested", then you know a new version is expected.
> Right now, it says "New" which means he hasn't looked at it or made a
> decision yet.
>=20
>=20
> [1]: https://patchwork.kernel.org/project/linux-iio/patch/20260313092413.=
35912-1-andy@skyrain.eu/

Busy few weeks. Catching up now.

This also needs a fixes tag to indicate how far back we should be looking
to backport it.

Looks like it was all the way so I've added one.
Fixes: 12ed27863ea3 ("iio: accel: Add driver support for ADXL355")

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan


>=20
> >=20
> > BR,
> > Andy =20
>=20
>=20

