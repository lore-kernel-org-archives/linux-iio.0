Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57D2DF13B;
	Sat,  7 Mar 2026 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892604; cv=none; b=R/zqNaSzp3OC1U1i0NJSvuqNTvxHzPFlq5CgpQd/SbRGLWcONpU5g7NZ4llP03ma1bGRw+wkboto3+NkV6KGS9w5wPRJPF/o/d3A5+hQeq/9hW4ZbYYZ1XU1nyNv2jkALih7qnuYvzutOyrxmIJLYzEmIh+84TKpiN+8z342k4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892604; c=relaxed/simple;
	bh=a8kDDcz48rE4vHieknrMWATxIkfDlt2csWmvtrludpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyLLDcuHOD6MbE6comYyY6zwR8oVMe3eQho+Lv6BEhPyQVyY13s2O0SKxWZg9RufkCJK8v+DWhrI/dyXiYf/P2tk33AkomM4rYfb9EmgffbEDTEvMPBqewi4nAyftXPSvrDCK2KB9giaUiUXXvVCmnJfNXfdKOSdTbgXUOcisLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FImFJ6q3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FImFJ6q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F71C19422;
	Sat,  7 Mar 2026 14:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772892603;
	bh=a8kDDcz48rE4vHieknrMWATxIkfDlt2csWmvtrludpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FImFJ6q3nMuC6PFoxiwveqJAdaBxhGHd5GcB0sWNqnZubVzsEjMNh06zZ7fLDiTNq
	 qfxE+BI4AhsOn+XXizn3ZeY80AskzMdlBEuo5x54T2jOcq2KUsGDsrFd8VtNA0DII2
	 bWY43dYMcKgledomVOSp9mOut3QDB+y0CalmrzpYOH8Qmbk7UjWCvvMLlAVUzVTAqQ
	 y+gv1JdLJ8YzIxP3I0QV2G2MjZMZfzt0J0MbIArbPv2bKYGSfow0UBg6mfqKXZGS20
	 qqsqXyahSzZZh2hdJOOqluv+9xXjb0faCigCUCX/VZsk5HvCorE4Vx3B1R5Dwa/Gts
	 jdjHm5xq/pG5Q==
Date: Sat, 7 Mar 2026 14:09:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, David Lechner
 <dlechner@baylibre.com>, rodrigo.alencar@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 0/8] AD9910 Direct Digital Synthesizer
Message-ID: <20260307140953.46db3c19@jic23-huawei>
In-Reply-To: <pohirub7gjqu7xtq5qakkmr3wlek2rgj6kdgltjvir6g4jwgbr@hmjflsplni4o>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
	<a72b2d62-3b91-4789-a1b1-ff1429e80ed5@baylibre.com>
	<2k4ouimpaxjuhnk67qmrues2375zj43ehru7h5as6w6kf7yak3@2ndr72co5trh>
	<bdc973e5-df74-48f2-8884-439b03565940@baylibre.com>
	<9392fea00a9c3b23d1bc9468faa1b3cc20904398.camel@gmail.com>
	<20260301133806.5e706756@jic23-huawei>
	<pohirub7gjqu7xtq5qakkmr3wlek2rgj6kdgltjvir6g4jwgbr@hmjflsplni4o>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2026 10:22:47 +0000
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/03/01 01:38PM, Jonathan Cameron wrote:
> > On Mon, 23 Feb 2026 10:02:00 +0000
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Sun, 2026-02-22 at 14:32 -0600, David Lechner wrote: =20
> > > > On 2/22/26 4:01 AM, Rodrigo Alencar wrote:   =20
> > > > > On 26/02/21 02:16PM, David Lechner wrote:   =20
> > > > > > On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:   =20
> > > > > > > This patch series adds support for the Analog Devices AD9910 =
DDS.
> > > > > > > This is an RFC so that we can agree/discuss on the design tha=
t follows:
> > > > > > >    =20
> > > >=20
> > > > ...
> > > >    =20
> > > > > > > represents a distinct signal path into the DDS accumulator, s=
o the driver
> > > > > > > models them as separate IIO output channels (all IIO_ALTVOLTA=
GE type).   =20
> > > > > >=20
> > > > > > Generally IIO channels represent the physical input/output, not=
 the
> > > > > > internal channels.   =20
> > > > >=20
> > > > > That is part of the reason for this RFC. Dividing those top-level=
 modes
> > > > > into channels allows for better organization, as they can operate=
 together,
> > > > > i.e., phase or scale can be provided by single-tone profile, while
> > > > > frequency is controlled by the digital ramp generator (see Mode P=
riority
> > > > > section in the datasheet). Also, it allows to explore the most of=
 standard
> > > > > ABIs like, scale, frequency, phase, sampling_frequency and enable.
> > > > > Putting everything into a single channel would make things a lot =
messy
> > > > > to interface with.
> > > > >    =20
> > > > > > Ideally we would just have the one channel here with a mode sel=
ection
> > > > > > attribute. Documentation can tell us which modes use which attr=
ibutes.
> > > > > >    =20
> > > > > > > This per-channel separation allows userspace to configure eac=
h mode
> > > > > > > independently through its own set of sysfs attributes, and to
> > > > > > > enable/disable modes individually via IIO_CHAN_INFO_ENABLE, r=
elying on
> > > > > > > the hardware's own mode selection architecture.
> > > > > > >    =20
> > > >=20
> > > > Looking at Table 5 in the datasheet really helped me understand thi=
s better.
> > > > I think this series could benefit from a documentation patch that e=
xplains
> > > > more about how the driver works with some diagrams.
> > > >=20
> > > > So really what we have here are a bunch of digital data generators =
rather
> > > > than a bunch of altvotlage output channels. And the same data chann=
els can be
> > > > mixed and match as the source for up to 3 different components of t=
he output
> > > > (frequency, phase, amplitude) depending on the priority rules defin=
ed in
> > > > Table 5.   =20
> > >=20
> > > More bellow... But note that all of the (or most of it) generators ar=
e going to
> > > be feed into a DAC. Your output is altvoltage but maybe we can treat =
the
> > > internals as voltage. Not sure.
> > >   =20
> > > >=20
> > > > Digital data sources are really more like a buffer in IIO terms tha=
n a
> > > > channel. And before we added the IIO backend stuff, there wasn't re=
ally
> > > > any other digital data source/sink that I am aware of other than bu=
ffers
> > > > (but there are certainly a lot of odd corners of IIO that I haven't=
 explored
> > > > yet, so maybe I missed some).
> > > >=20
> > > > In a recent discussion, the idea of possibly needing a way to provi=
de
> > > > some userspace interface to be able to tweak knobs of an IIO backend
> > > > was also brought up.
> > > >=20
> > > > Putting those ideas together, I'm wondering if we need some new cha=
nnel
> > > > type or even a whole new interface (e.g. a new sysfs directory like=
 buffers
> > > > and events) for managing these digital data sources/sinks that are =
not an
> > > > IIO buffer.
> > > >    =20
> > >=20
> > > But what would be that channel? In the end of the day, we typically h=
ave voltage or
> > > current DACs and a DDS primary function is indeed to generate alterna=
ting waveforms
> > > that you then typically feed into a DAC (and in some cases from the D=
AC into a
> > > power amplifier). So the DDS is just part of the data/signal path. An=
yways, not sure
> > > on the new type and I think we already have the "blocks" in IIO for d=
ealing with this:
> > >=20
> > > . frequency
> > > . phase
> > > . amplitude (raw + scale + offset)
> > >=20
> > > But you're right that maybe it's time to think in a better way to fit=
 them together.=C2=A0
> > > Maybe a new type (as buffers or events) can make sense where the abov=
e are treated as, example, scan
> > > elements. Maybe it's overcomplicating, not sure. It surely needs  dis=
cussion and thinking :).
> > >=20
> > > And spoiler alert, as you might have guessed already, the parallel po=
rt stuff is to be
> > > used with DMA buffers (and IIO backends). At least, that was the plan=
 IIRC. But Rodrigo
> > > can confirm it.
> > >  =20
> > > > I think we've seen enough of these already to know that things like=
 a
> > > > "tone generator" and a "ramp generator" are going to be common and =
could
> > > > share some standard attributes.=20
> > > >    =20
> > >=20
> > > I tend to agree. For example, there already some DACs (with dithering=
) that make use of a similar
> > > interface (but with a custom prefix). Though the end goal is differen=
t, the interface is not that
> > > far off:
> > >=20
> > >=20
> > > https://elixir.bootlin.com/linux/v6.19.3/source/Documentation/ABI/tes=
ting/sysfs-bus-iio-dac-ltc2688
> > >=20
> > > Anyways, I knew this one would be an interesting one for upstream :) =
=20
> >=20
> > For history buffs, we had a bunch of DDS chips in staging at one point =
and never
> > manage to figure out the questions being raised here :(  They are compl=
ex
> > beasts.  Clarity of ABI proposal and documentation is going to be key t=
o driving
> > this series forwards. In a sense the code is the easy part. =20
>=20
> Does that mean that once good documentation is provided, the presented de=
sign can
> be accepted? Even though data generators/sources might not be interpreted=
 as
> altvoltage channels?

I'm not sure yet :(  It's a pretty complex design and we haven't really com=
e to a conclusion
on how to handle this channel 'mixing' case.

If we did go this way, we'd need to figure out a way to describe the mixing=
 part.
So either we describe it as one channel (which is going to be really comple=
x)
or we describe it as multiple channels but add extra ABI to make it clear t=
hey
are mixed into a single 'physical' channel.

Jonathan

>=20

