Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693381CD1E4;
	Sun,  1 Mar 2026 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772372297; cv=none; b=YWDvguVXCnm8z1BQM3R/tw48o6xkF0Aqy4xV9lW3Gllj2L04/hlteKGhjhAs0qRnZkkV0pi2jKJfzT0/e3CAIwViHJRw5dVaf3o+JsO48A7vSvYHb4XvJ7RFAH4QaEZK14f6YpDdvpg1Nk0E6aG8xCNFXP3fNq7E8bVkIRt71A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772372297; c=relaxed/simple;
	bh=NUZn7+RAjq13eKxiv+DR0KFxNowIwap+6p5q8pf4yNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GG4w5FI39Y2AUwPezi25yjjBZKFkeZe0U39tu3zXLus1lOpt66fHMnotAJpR1ddJQd5wjm3lwJCXMSUFrKaKV1Z7csqW1ToGDTjF+32GtYXoMQiv0FsMyS/y/SEF9St0D8VnfInAx1Bal2LRaj+zAL/RnGeWppP1R1WDpE9N2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFfBvq5I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFfBvq5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A15C116C6;
	Sun,  1 Mar 2026 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772372297;
	bh=NUZn7+RAjq13eKxiv+DR0KFxNowIwap+6p5q8pf4yNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MFfBvq5IHcLWi6eoUmcJ2JD2FM3wUGlK/KhpAd0zuzSicgvkyBlOBpvDpyRiVcmxP
	 qkQ7Skv633kOkI3pp0KcBVsixO+ObjOrYwloX57LdFRMZMssJmOjwGfzrmrmAIaT1z
	 jr+mMecJdngvV+GBX8UvtF4SzIrHb955XoewMHA7cKcrXbC0C3fn7V5kqrnH2I1BGJ
	 GT2Oft7Fxhejrn46LtUpmtr1+ZT5/cgucxVlnm1e3cooOcemvHnHUESmeBeznWk4Kh
	 D/ak+V5fxxJ8gt+TrzvPsmI6LTMMWqkLm2H7qID4++8J3BIwC6aAPi0xXaBWnz7P/q
	 96WBHNzgdjoUg==
Date: Sun, 1 Mar 2026 13:38:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Rodrigo Alencar 
 <455.rodrigo.alencar@gmail.com>, rodrigo.alencar@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich	 <Michael.Hennerich@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 0/8] AD9910 Direct Digital Synthesizer
Message-ID: <20260301133806.5e706756@jic23-huawei>
In-Reply-To: <9392fea00a9c3b23d1bc9468faa1b3cc20904398.camel@gmail.com>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
	<a72b2d62-3b91-4789-a1b1-ff1429e80ed5@baylibre.com>
	<2k4ouimpaxjuhnk67qmrues2375zj43ehru7h5as6w6kf7yak3@2ndr72co5trh>
	<bdc973e5-df74-48f2-8884-439b03565940@baylibre.com>
	<9392fea00a9c3b23d1bc9468faa1b3cc20904398.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Feb 2026 10:02:00 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2026-02-22 at 14:32 -0600, David Lechner wrote:
> > On 2/22/26 4:01 AM, Rodrigo Alencar wrote: =20
> > > On 26/02/21 02:16PM, David Lechner wrote: =20
> > > > On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote: =20
> > > > > This patch series adds support for the Analog Devices AD9910 DDS.
> > > > > This is an RFC so that we can agree/discuss on the design that fo=
llows:
> > > > >  =20
> >=20
> > ...
> >  =20
> > > > > represents a distinct signal path into the DDS accumulator, so th=
e driver
> > > > > models them as separate IIO output channels (all IIO_ALTVOLTAGE t=
ype). =20
> > > >=20
> > > > Generally IIO channels represent the physical input/output, not the
> > > > internal channels. =20
> > >=20
> > > That is part of the reason for this RFC. Dividing those top-level mod=
es
> > > into channels allows for better organization, as they can operate tog=
ether,
> > > i.e., phase or scale can be provided by single-tone profile, while
> > > frequency is controlled by the digital ramp generator (see Mode Prior=
ity
> > > section in the datasheet). Also, it allows to explore the most of sta=
ndard
> > > ABIs like, scale, frequency, phase, sampling_frequency and enable.
> > > Putting everything into a single channel would make things a lot messy
> > > to interface with.
> > >  =20
> > > > Ideally we would just have the one channel here with a mode selecti=
on
> > > > attribute. Documentation can tell us which modes use which attribut=
es.
> > > >  =20
> > > > > This per-channel separation allows userspace to configure each mo=
de
> > > > > independently through its own set of sysfs attributes, and to
> > > > > enable/disable modes individually via IIO_CHAN_INFO_ENABLE, relyi=
ng on
> > > > > the hardware's own mode selection architecture.
> > > > >  =20
> >=20
> > Looking at Table 5 in the datasheet really helped me understand this be=
tter.
> > I think this series could benefit from a documentation patch that expla=
ins
> > more about how the driver works with some diagrams.
> >=20
> > So really what we have here are a bunch of digital data generators rath=
er
> > than a bunch of altvotlage output channels. And the same data channels =
can be
> > mixed and match as the source for up to 3 different components of the o=
utput
> > (frequency, phase, amplitude) depending on the priority rules defined in
> > Table 5. =20
>=20
> More bellow... But note that all of the (or most of it) generators are go=
ing to
> be feed into a DAC. Your output is altvoltage but maybe we can treat the
> internals as voltage. Not sure.
> =20
> >=20
> > Digital data sources are really more like a buffer in IIO terms than a
> > channel. And before we added the IIO backend stuff, there wasn't really
> > any other digital data source/sink that I am aware of other than buffers
> > (but there are certainly a lot of odd corners of IIO that I haven't exp=
lored
> > yet, so maybe I missed some).
> >=20
> > In a recent discussion, the idea of possibly needing a way to provide
> > some userspace interface to be able to tweak knobs of an IIO backend
> > was also brought up.
> >=20
> > Putting those ideas together, I'm wondering if we need some new channel
> > type or even a whole new interface (e.g. a new sysfs directory like buf=
fers
> > and events) for managing these digital data sources/sinks that are not =
an
> > IIO buffer.
> >  =20
>=20
> But what would be that channel? In the end of the day, we typically have =
voltage or
> current DACs and a DDS primary function is indeed to generate alternating=
 waveforms
> that you then typically feed into a DAC (and in some cases from the DAC i=
nto a
> power amplifier). So the DDS is just part of the data/signal path. Anyway=
s, not sure
> on the new type and I think we already have the "blocks" in IIO for deali=
ng with this:
>=20
> . frequency
> . phase
> . amplitude (raw + scale + offset)
>=20
> But you're right that maybe it's time to think in a better way to fit the=
m together.=C2=A0
> Maybe a new type (as buffers or events) can make sense where the above ar=
e treated as, example, scan
> elements. Maybe it's overcomplicating, not sure. It surely needs  discuss=
ion and thinking :).
>=20
> And spoiler alert, as you might have guessed already, the parallel port s=
tuff is to be
> used with DMA buffers (and IIO backends). At least, that was the plan IIR=
C. But Rodrigo
> can confirm it.
>=20
> > I think we've seen enough of these already to know that things like a
> > "tone generator" and a "ramp generator" are going to be common and could
> > share some standard attributes.=20
> >  =20
>=20
> I tend to agree. For example, there already some DACs (with dithering) th=
at make use of a similar
> interface (but with a custom prefix). Though the end goal is different, t=
he interface is not that
> far off:
>=20
>=20
> https://elixir.bootlin.com/linux/v6.19.3/source/Documentation/ABI/testing=
/sysfs-bus-iio-dac-ltc2688
>=20
> Anyways, I knew this one would be an interesting one for upstream :)

For history buffs, we had a bunch of DDS chips in staging at one point and =
never
manage to figure out the questions being raised here :(  They are complex
beasts.  Clarity of ABI proposal and documentation is going to be key to dr=
iving
this series forwards. In a sense the code is the easy part.

Jonathan

>=20
> - Nuno S=C3=A1
>=20

