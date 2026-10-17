Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B824CF475;
	Sat, 17 Oct 2026 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280239; cv=none; b=ns3+vSTNp1tPfhzfIg6hlgWI5TXWQPkMGAZV4sBROf4OPgqKD5CoeQiSeU9sE+w3/9DgjiFQ2N0SRpXs9kYZ6amU0fhXNu3+SeAqWWupI8OwVtGiLkhVjt8BGdPjiUU6Nn3rPrMC8OmggNju+hixlLAcFEFEZ0Cd0WsW98rr1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280239; c=relaxed/simple;
	bh=xxQI6dI1NdyeQfHaaWLpPh1NCN9LlkOMhoj8PQCZVqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WU1kqQMg4eK1c1jT1rzXtJpvHB2NGHdMNFWGIES1Kl1wjKQXJmudB1IOyfhhVYVU3Z4T3XabmDiXBye0HMUyD5Lviw8FMu4kHz7pjVFr6IMUzpsEnW2CD3au4/wZgcIuuPP5SYMzBIV0U4i+k6cG7VdtttJwrsKKYpRzmXY/zec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OryF9FAw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OryF9FAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12CE1F000C4;
	Sat, 17 Oct 2026 23:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792280238;
	bh=3LwWqcoHb+vx06J28euZl5DxFMUKTdIO2FS/bS8j2fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OryF9FAwQVKQ72nlt5AzDUrPzHA+9Pa5RHtMgTzNPBJ/mMyaRH+PouWXwSKY3/0HX
	 tXhwzmD94w912YiqO9UNa8oGfOFYGvanWwinwmpncHb1xMr2Mgc8uap4mygZVIwjwL
	 2xRuxJAgDzX8qhconN5qx2q2mClTiomcSnCVHi6NrcTznFxp1gA6n41bD5AzVMKGil
	 k3vTT94PA989GNo9GH8lcJVDAqeiVXKp0FBnv+GFs+gyQfuCAEHGx55cOJwzMRDrl4
	 YptrxKEFFQ8QfzkeRWqLAldcevxtC7vhuXoBX5deZlPq6wDTVl0nu8s2CCrasl2f2b
	 5KLOj7xgaxjTw==
Date: Sun, 18 Oct 2026 00:37:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Joshua Crofts
 <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v2] iio: ccs811: Deassert WAKE GPIO on error paths
Message-ID: <20261018003712.29a2b9e7@jic23-hlaptop>
In-Reply-To: <5d5812be-430d-47f3-9e08-287300284c62@gmail.com>
References: <20261015123023.3417-1-nikhilgtr@gmail.com>
	<20261017214659.5bbebc38@jic23-hlaptop>
	<5d5812be-430d-47f3-9e08-287300284c62@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Oct 2026 02:42:18 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Hi Jonathan,
>=20
> Thanks for the review.
>=20
> >> Ensure the WAKE GPIO is deasserted when status polling fails or
> >> the data-ready timeout expires. Early returns could leave WAKE asserte=
d,
> >> preventing the sensor from returning to its low-power state and
> >> potentially disrupting subsequent I2C transactions. =20
> > I need more on this point to know whether we care if an error
> > means we don't deassert the wake pin.
> >
> > Why would failing to go to sleep break future transactions?
> > I'd kind of assume we'd awaken an already awake device (which sounds
> > idempotent but maybe not?) and carry on from there?
> >
> > Jonathan =20
>=20
> The relevant information is in the CCS811 datasheet (v1-06),
> under =E2=80=9CCCS811 =E2=80=93 Pin Assignment=E2=80=9D (page 4) and =E2=
=80=9CDetailed Description=E2=80=9D=20
> (page 7 onwards).
>=20
> The datasheet specifies that nWAKE is active-low and should be asserted
> before an I=C2=B2C transaction and held low throughout it. It also descri=
bes
> the sleep behavior: when nWAKE is deasserted, the device enters sleep
> mode and ignores I=C2=B2C requests. The timing specifications specify a 5=
0 =C2=B5s
> wake-up time and a minimum 20 =C2=B5s deassertion interval.
>=20
> I agree that the datasheet does not explicitly state that leaving nWAKE
> asserted after an error will cause subsequent transactions to fail.
> My concern is primarily that an early return leaves the device awake
> instead of restoring the intended low-power state.
>=20
> I'll adjust the justification accordingly, rather than claiming that=20
> subsequent
> transactions would necessarily be disrupted.
Given it's an error path and just as likely the attempt to put it
to sleep may also fail, this becomes a possible improvement rather htan
a fix.  I'm not entirely convinced we care about that corner case
but feel free to send it with a description that talks about this
and we'll see what others think.

Thanks,

Jonathan

>=20
> Thanks,
> Nikhil

