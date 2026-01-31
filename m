Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAC340DB1;
	Sat, 31 Jan 2026 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885300; cv=none; b=U9bqdNjTA99UMA5Bbl7iZdyR80tZTTn5j5TYyXA9qasQFelnBlEg7K+eUpsf+mPnXHXa1dyX9q1UR8X4AYI6z4mYqoKQHDXLul+wJ7ecqd2t5cWTJLDlyqOXN9XnDyfKDNBa2Oo5GC8BrxlRruAUrDXvIzs5DaMwovoOQO5B4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885300; c=relaxed/simple;
	bh=mZSU3phl76pEV6Vf27IrIqd4GEVz4oDi039S8tJTBPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+XKqR2AU7xSBPLu1gVQ6V1LPD0O55gg1w45c4QQ9EjZ7fKVV4H3839myzJMp45+0YMcI2mOTwK10UZhYeX5Vb1F8fIhTZg94knrYHbwhzAbbLlORgp7q4rm5QMvUS9qKG5s0jLjilOP9yaUsaJ3PVomOZEDwiIle0YIykWqGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqSn1p4m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqSn1p4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50E2C4CEF1;
	Sat, 31 Jan 2026 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769885300;
	bh=mZSU3phl76pEV6Vf27IrIqd4GEVz4oDi039S8tJTBPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jqSn1p4m/OdI1uulD9lA9ZoyNBsX3+auZ3J3p/dL5+JI/U+UBkIK98843j4P4p+Ax
	 PfQIm/uYwn9WStZ0msfAgJGRvQ6riN5ts+/seiI0yzypIojhWIXWg9yXGAEOzZ6hL+
	 HLuI3Sm5dFjUDZ+elAo7sgOBwvC/3iQfYpfqhfOKfB8v2izAis0gX2ObSHUN4DuMTz
	 ZArh2T/Sp6EzcUqzEmFIh7RqteIYMOWrGmlu9BhBnqGwpTlWIMVojhbvW4LDfUWTlp
	 idzPvqzv3aq7QaxYXKustN6lakY34SaC2d96pFZrrm3am7Lcm96NyISW0QF6znCq38
	 5SSmWA+BcnRGA==
Date: Sat, 31 Jan 2026 18:48:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
 nuno.sa@analog.com, andy@kernel.org
Subject: Re: [RFC PATCH v1 0/9] iio: Expand IIO event interface for
 real-world unit handling
Message-ID: <20260131184811.1e86ffa0@jic23-huawei>
In-Reply-To: <95b13260-0564-445d-bff7-b3b54fa15005@baylibre.com>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
	<4a04fa3f-c056-4443-a55a-e8622feb1c2a@baylibre.com>
	<2f9e7172885c5dd20be198f013283c6ec0513ef1.camel@gmail.com>
	<95b13260-0564-445d-bff7-b3b54fa15005@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Jan 2026 11:43:03 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/21/26 3:33 AM, Nuno S=C3=A1 wrote:
> > On Sun, 2026-01-18 at 14:33 -0600, David Lechner wrote: =20
> >> On 1/18/26 12:18 PM, Marcelo Schmitt wrote: =20
> >>> This patch set adjusts and complements the IIO event ABI docs making =
them
> >>> coherent with the fact that not all threshold value attributes had a =
_raw/_input
> >>> indicator set in their names. In addition that, the latter patches on=
 this
> >>> series update the IIO event infrastructure to actually enable drivers=
 to provide
> >>> _input threshold value attributes. =20
> >> =20
> >=20
> > ...=20
> >  =20
> >>
> >> Just throwing out an idea here without thinking about it too much...
> >>
> >> Instead of adding a new field/parameter for units, could we extend
> >> enum iio_event_info to add IIO_EV_INFO_VALUE_RAW and IIO_EV_INFO_VALUE=
_INPUT
> >> (and same for HYSTERESIS). Really, the units only make sense for these
> >> two info types anyway.
> >> =20
> >=20
> > Makes sense to me.  Or we can just document that the old value is _INPU=
T? Or just make
> > it the same value in the enum.
> >=20
> > - Nuno S=C3=A1 =20
>=20
> I don't think that works since IIO_EV_INFO_VALUE could be _RAW or _INPUT
> depending on the driver. And another point was that this should also
> control the _raw or _input in the attribute name, and we can't change the
> existing attribute names.
>=20

Fully agree with David here.  To fix this up we need new ABI, with
the old ABI remaining in place (including for new drivers) where the
raw or processed nature of event values is derived from whether they have
_raw or _input (and hopefully not the horrible case of both!)

The new drivers keeping this bit is the only place I might be flexible
if it is a real problem.  I'd still strongly prefer devices to match
the channel presentation for these but if there is a really tricky
corner case for a particular part then 'maybe' we can relax it.  Upshot
is that it won't work with standard userspace code that is old.

Not the first time we've had to add new ABI and keep the old
(whilst telling people not to use it)
The multiple buffers stuff is a good example.=20

Jonathan
