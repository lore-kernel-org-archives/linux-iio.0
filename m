Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF4369207;
	Mon, 18 May 2026 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117786; cv=none; b=CUQ0w9WXFL5q++xCFh1JkfwdP8xJHTxbppkhpBSg2BpCsfu98y4pXAr5J3DM47yMZ8252Lj9cymqpM6UgP2jNQBNVeiy8/xSDYnyA7JqPLiZLnGCRgRQB+ISBJh9fnw0UxAoTL5WzyY2umYo+OiCL0bi8KgQAtkk6jPjw3/UGoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117786; c=relaxed/simple;
	bh=aq0UkCEXprCMK+CtegirzfRLoakQzi3EHVOuoVOTzis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUGMMkOrlSILyKbV9XmGC7nCbQGhAAsGwQfRuIaJdJEezHPup1qxgLJAI14dOvwjdIS5JSlnSTOnyRqSKyCekKxnsa75AIijSj8pRYr4TDZ68osBT75UTFO5KaZtjN9XGbitJRyXuDX1xA0xYXIOjIz89fbZ9stofV4xrjCAQXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUlOP9nd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUlOP9nd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7A9C2BCB7;
	Mon, 18 May 2026 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779117785;
	bh=aq0UkCEXprCMK+CtegirzfRLoakQzi3EHVOuoVOTzis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KUlOP9ndavVfFcDpIj53R1+pv++pWvemA+6ELJ6N7NpQLaxR2XN8XB66DramV+YiO
	 mztahSNZbcaaUm1UKitljLnVUP+FbtbGEK5AU2GAdfl2pVZUEZKQa0pNtTplnpGS7E
	 c8eJ2iZBOvKj3CUDEN2V4+VfQi9fFmyJ9VrkrfuMRucM3U8qSEOnBiS5MW6gTfZG4X
	 c/g8Wulb3Jtj+yiqXc9zgBas3ee67Cs2uIlqdHc8paByWz+X+p78d4Rm/U92oQvOrf
	 kPb5n8cwEpWWAq0Obu2pabOG44843sJkiq7+G9otywym9J+0BuARUNAgnSeg5ST6YG
	 cr+ybY6J2D50g==
Date: Mon, 18 May 2026 16:22:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: light: veml6030: fix channel type when
 pushing events
Message-ID: <20260518162255.107faee8@jic23-huawei>
In-Reply-To: <2a0c777d-05ef-4721-b8ed-88297630ea94@baylibre.com>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
	<20260513-veml6031x00-v2-2-4703ca661a1d@gmail.com>
	<9bb6db05-43c7-4bdf-88b0-b92525ad5cc9@gmail.com>
	<2a0c777d-05ef-4721-b8ed-88297630ea94@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2026 09:48:39 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/18/26 8:12 AM, Matti Vaittinen wrote:
> > On 13/05/2026 07:49, Javier Carrasco wrote: =20
> >> The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
> >> Use the correct channel type.
> >> This bug was introduced in the first version of the driver.
> >>
> >> When at it, fix minor checkpatch code style warning (alignment).
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >> ---
> >> =C2=A0 drivers/iio/light/veml6030.c | 8 +++++---
> >> =C2=A0 1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030=
.c
> >> index 745cf3ad7092..855f052b60c2 100644
> >> --- a/drivers/iio/light/veml6030.c
> >> +++ b/drivers/iio/light/veml6030.c
> >> @@ -871,9 +871,11 @@ static irqreturn_t veml6030_event_handler(int irq=
, void *private)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 evtdir =3D IIO_=
EV_DIR_FALLING;
> >> =C2=A0 -=C2=A0=C2=A0=C2=A0 iio_push_event(indio_dev, IIO_UNMOD_EVENT_C=
ODE(IIO_INTENSITY,
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, IIO_EV_TYPE_THRESH, evtdir=
),
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> >> +=C2=A0=C2=A0=C2=A0 iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO=
_LIGHT,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_EV_TYPE_THRESH,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 evtdir),
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ii=
o_get_time_ns(indio_dev));
> >> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED;
> >> =C2=A0 }
> >> =20
> >=20
> > Is this change reflected to the user-space? If so, is it safe? We shoul=
dn't break the ABI, right? =20
>=20
> On things like this, we will sometime risk breaking userspace in hopes
> that no one was actually depending on it. If no one notices that we
> broke it, did we really break it?

If it's a bug we often just break ABI compatibility anyway.  If we get a re=
port
we'll make it spit out both events (and someone doesn't handle an extra one
we point them at the docs - that hopefully exist ;) - that say you must han=
dle
ones you don't expect).

J
>=20
> >=20
> >=20
> > Yours,
> > =C2=A0=C2=A0=C2=A0=C2=A0-- Matti
> >=20
> > ---
> > Matti Vaittinen
> > Linux kernel developer at ROHM Semiconductors
> > Oulu Finland
> >=20
> > ~~ When things go utterly wrong vim users can always type :help! ~~ =20
>=20

