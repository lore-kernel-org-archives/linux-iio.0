Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181E38BF70
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776105200; cv=none; b=iVqHRRcKq4dyofu9NsGg+jtXOmmAI3vQzmxpZGT8SR8FjqIPvO76KJIaUwn9t0vPQqGtOyMHYMOJdg2nyDMTQQ9GpVU6KLtl4omrJ6h8L2PTRP5f1yKYkhzaBFY1CsscS9peGBtCMzyL5gtVFlPjZnYcAyaHfNI5KmV2voC/xaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776105200; c=relaxed/simple;
	bh=XRr1M9vTmZ29EvyEnjHBkZWzOSjhIT7zTXExJt+gLEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHoCHEbrVNYzDAncRGqixffw6VixlMzrtomgC5endoDeiq51bUSTIauS2OxtZXDc1pbK6uQ0bdA9Zl2FVjA8N2wyUp/gkICZ9qwQhBHdKVzZw7ZIxdah3N03BcNngKnsr/yIguCmgVy0aaAnzXG5khgzIwGsEVEHm/H6cffp7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLLHRhvb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLLHRhvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F57C2BCB8;
	Mon, 13 Apr 2026 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776105199;
	bh=XRr1M9vTmZ29EvyEnjHBkZWzOSjhIT7zTXExJt+gLEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TLLHRhvb5l7XxzyDH9uiBz1X6zhU8OK8SlcNb7A8ihxAvyF6LrDMdOqmfhKQJfxhD
	 g7OSQjx/bizmvSce6Cqgy0lQkwVmd36q1AsNQ1y5aWnQaq10jK76eP8cNDJtvaCGnz
	 iEbvYn2Tpm/sMvh816SdZp7+TozfOBPio9Fl5OzLwdzwJW1cVFDDjEko02tdVieg+z
	 VDL8MNdenvLeL+25wNAhFuLcX75PE1LenfdcLp3+m1S/Mbt8HNAig//IzyMR+HvFGn
	 TIpbZMPmiNdoRlXVtJgW5EflYKrS/sGnykOP1iL0dccqP7wfFYbm+Tfw2fuNWImKTs
	 00HRKQGaeMvuQ==
Date: Mon, 13 Apr 2026 19:33:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nikhil Gautam <nikhilgtr@gmail.com>, anshulusr@gmail.com,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: dac: mcp4821: add configurable gain support
Message-ID: <20260413193312.2d03d88e@jic23-huawei>
In-Reply-To: <856787c1-76d8-4818-839f-64490a64a990@baylibre.com>
References: <acYb1XOmw1yoyu_4@nik>
	<20260327061802.13043-1-nikhilgtr@gmail.com>
	<45f6a6dc-e027-4616-8cea-9be8d006521a@baylibre.com>
	<d47f93f4-e536-4fd4-a7c0-74d69f50fe55@gmail.com>
	<856787c1-76d8-4818-839f-64490a64a990@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 12 Apr 2026 13:35:45 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/12/26 10:23 AM, Nikhil Gautam wrote:
> > Hi David,
> >=20
> > Thanks a lot for the detailed review and suggestions.
> >=20
> > I understand the issues you pointed out. I will resend the next revision
> > as a new thread instead of replying, to avoid breaking tooling.
> >=20
> > I will also split the unrelated changes into separate patches, starting
> > with moving the state initialization, and handle spelling fixes
> > independently.
> >=20
> > Regarding the gain handling, your suggestion to use an integer value
> > instead of a boolean makes sense. I will update the implementation to
> > store the gain directly and simplify the logic accordingly.
> >  =20
>=20
> To save time, you don't need to comment on things you agree with. It
> makes it hard to find any important parts where you might be asking
> for additional feedback.
>=20
> And trim out irrelevant quoted bits when replying. It saves time too.
>=20
> And please don't top post.
>=20
> >>> +static const int mcp4821_gain_avail[] =3D {1, 2}; =20
> >> The attribute is the scale attribute, not gain, so these need to
> >> be: { MCP4821_VREF_MV, 2 * MCP4821_VREF_MV } combined with...
> >> =20
> >>> =C2=A0 -=C2=A0=C2=A0=C2=A0 return 0;
> >>> +static int mcp4821_read_avail(struct iio_dev *indio_dev,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type, int *leng=
th,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long info)
> >>> +{
> >>> +=C2=A0=C2=A0=C2=A0 switch (info) {
> >>> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SCALE:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *vals =3D mcp4821_gain_av=
ail;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *type =3D IIO_VAL_INT; =20
> >> ... IIO_VAL_FRACTIONAL_LOG2.
> >>
> >> The idea is that the scale_available attribute should return the same
> >> values as the scale attribute. =20
>=20
> Instead, reply inline where the context makes sense like this:
>=20
> > I am thinking to return (2048/4096) Values based on gain selected
> > instead (1/2) Values in scale_available, so that user will have clear p=
icture which gain
> > to be selected, else for (1/2) Values he always has to refer the driver.
> >  =20
>=20
> We have to follow the IIO ABI of what these attribute mean so that all dr=
ivers
> work the same. We can't make up new rules for this driver.
>=20
> For a 12-bit chip, `cat iio\:device0/out_voltage_scale_available` for this
> driver should return `0.5 1` since the scale is either 2048 / (1 << 12)
> or 4096 / (1 << 12).
>=20
> These are exactly the values that must be written to
> `iio\:device0/out_voltage_scale_available` to change the scale. And then
> `cat iio\:device0/out_voltage_scale_available` must read back exactly what
> was written.

out_voltage_scale was intended here I think as _available attributes
are read only.


>=20
>=20

