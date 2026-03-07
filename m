Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28642236F0;
	Sat,  7 Mar 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772902706; cv=none; b=YKSYnbobbws2VRGulBJj+ptH09A9aVKpqRWERzLfQoBYqFoxKYYKaQmAbMRU2tbYIoJQ4NZ1poPC8VR+qh1vEApp7WnuroYz9kHP/YE2rU9nmdZ44injjfXnFu1SveDeXvn60oNm68idZ0aJnJzedJRy39BB0ndtSL4E8eAz8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772902706; c=relaxed/simple;
	bh=Js1Wc42rVCAVYida6FGcEIieDrHnZARgWO9fGHu79xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lP/s5vXVkOHap3z6lyuOuqikXd2eHMvJ0clxjud0g3A25IxjywjMnJdYzaVYY0WKUiLUbs0Zaw12vxbv9uWo0lmRJtATAkuCcg25uUIK4k5Wp8pFdaI4sUiNh8K6DWwzJ1eLvh0OQv5IXNsNBx4FgzizfNu/nsC+n8p935+nnhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbSYpUaa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbSYpUaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BF0C19422;
	Sat,  7 Mar 2026 16:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772902706;
	bh=Js1Wc42rVCAVYida6FGcEIieDrHnZARgWO9fGHu79xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AbSYpUaaj0SVUl8tXBzzJsM8ihyke25ey5D03THHBXmJR3EP902/YrSAjUcoJfOAy
	 UVJNiTG6yHP8tb/cZ8Kb7aP/iYg2NdufLTbBZN5JvW1qhf37ry7LW4sQXxe0pmHVmd
	 UC29OKOLSwxvAM/cDTh3esLH8+eJxJPkmbSP9rnJYHqz28RfO0V3wr4Tfx8myZAIyQ
	 bM4SAzzcYw73h6Y5Lui8+R0glcPzUxCswn7444UmebmK2PcyWrkSUVQPAOsshQuU9h
	 sfoWbVe5vh7+YoNubcx7UJ6c7yKpTJ9jwGlBhM7jCizdI/e2XmrpgIJxzSWFa9BqiT
	 7ipUKIwgM5mgQ==
Date: Sat, 7 Mar 2026 16:58:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, rodrigo.alencar@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 0/8] AD9910 Direct Digital Synthesizer
Message-ID: <20260307165816.46a98d34@jic23-huawei>
In-Reply-To: <7cc67826-3a8a-4190-9447-62b7d68e4445@baylibre.com>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
	<a72b2d62-3b91-4789-a1b1-ff1429e80ed5@baylibre.com>
	<2k4ouimpaxjuhnk67qmrues2375zj43ehru7h5as6w6kf7yak3@2ndr72co5trh>
	<bdc973e5-df74-48f2-8884-439b03565940@baylibre.com>
	<9392fea00a9c3b23d1bc9468faa1b3cc20904398.camel@gmail.com>
	<20260301133806.5e706756@jic23-huawei>
	<pohirub7gjqu7xtq5qakkmr3wlek2rgj6kdgltjvir6g4jwgbr@hmjflsplni4o>
	<20260307140953.46db3c19@jic23-huawei>
	<7cc67826-3a8a-4190-9447-62b7d68e4445@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Mar 2026 10:50:14 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 3/7/26 8:09 AM, Jonathan Cameron wrote:
> > On Mon, 2 Mar 2026 10:22:47 +0000
> > Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> >  =20
> >> On 26/03/01 01:38PM, Jonathan Cameron wrote: =20
> >>> On Mon, 23 Feb 2026 10:02:00 +0000
> >>> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >>>    =20
> >>>> On Sun, 2026-02-22 at 14:32 -0600, David Lechner wrote:   =20
> >>>>> On 2/22/26 4:01 AM, Rodrigo Alencar wrote:     =20
> >>>>>> On 26/02/21 02:16PM, David Lechner wrote:     =20
> >>>>>>> On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:     =20
> >>>>>>>> This patch series adds support for the Analog Devices AD9910 DDS.
> >>>>>>>> This is an RFC so that we can agree/discuss on the design that f=
ollows:
> >>>>>>>>      =20
> >>>>>
> >>>>> ...
> >>>>>      =20
> >>>>>>>> represents a distinct signal path into the DDS accumulator, so t=
he driver
> >>>>>>>> models them as separate IIO output channels (all IIO_ALTVOLTAGE =
type).     =20
> >>>>>>>
> >>>>>>> Generally IIO channels represent the physical input/output, not t=
he
> >>>>>>> internal channels.     =20
> >>>>>>
> >>>>>> That is part of the reason for this RFC. Dividing those top-level =
modes
> >>>>>> into channels allows for better organization, as they can operate =
together,
> >>>>>> i.e., phase or scale can be provided by single-tone profile, while
> >>>>>> frequency is controlled by the digital ramp generator (see Mode Pr=
iority
> >>>>>> section in the datasheet). Also, it allows to explore the most of =
standard
> >>>>>> ABIs like, scale, frequency, phase, sampling_frequency and enable.
> >>>>>> Putting everything into a single channel would make things a lot m=
essy
> >>>>>> to interface with.
> >>>>>>      =20
> >>>>>>> Ideally we would just have the one channel here with a mode selec=
tion
> >>>>>>> attribute. Documentation can tell us which modes use which attrib=
utes.
> >>>>>>>      =20
> >>>>>>>> This per-channel separation allows userspace to configure each m=
ode
> >>>>>>>> independently through its own set of sysfs attributes, and to
> >>>>>>>> enable/disable modes individually via IIO_CHAN_INFO_ENABLE, rely=
ing on
> >>>>>>>> the hardware's own mode selection architecture.
> >>>>>>>>      =20
> >>>>>
> >>>>> Looking at Table 5 in the datasheet really helped me understand thi=
s better.
> >>>>> I think this series could benefit from a documentation patch that e=
xplains
> >>>>> more about how the driver works with some diagrams.
> >>>>>
> >>>>> So really what we have here are a bunch of digital data generators =
rather
> >>>>> than a bunch of altvotlage output channels. And the same data chann=
els can be
> >>>>> mixed and match as the source for up to 3 different components of t=
he output
> >>>>> (frequency, phase, amplitude) depending on the priority rules defin=
ed in
> >>>>> Table 5.     =20
> >>>>
> >>>> More bellow... But note that all of the (or most of it) generators a=
re going to
> >>>> be feed into a DAC. Your output is altvoltage but maybe we can treat=
 the
> >>>> internals as voltage. Not sure.
> >>>>     =20
> >>>>>
> >>>>> Digital data sources are really more like a buffer in IIO terms tha=
n a
> >>>>> channel. And before we added the IIO backend stuff, there wasn't re=
ally
> >>>>> any other digital data source/sink that I am aware of other than bu=
ffers
> >>>>> (but there are certainly a lot of odd corners of IIO that I haven't=
 explored
> >>>>> yet, so maybe I missed some).
> >>>>>
> >>>>> In a recent discussion, the idea of possibly needing a way to provi=
de
> >>>>> some userspace interface to be able to tweak knobs of an IIO backend
> >>>>> was also brought up.
> >>>>>
> >>>>> Putting those ideas together, I'm wondering if we need some new cha=
nnel
> >>>>> type or even a whole new interface (e.g. a new sysfs directory like=
 buffers
> >>>>> and events) for managing these digital data sources/sinks that are =
not an
> >>>>> IIO buffer.
> >>>>>      =20
> >>>>
> >>>> But what would be that channel? In the end of the day, we typically =
have voltage or
> >>>> current DACs and a DDS primary function is indeed to generate altern=
ating waveforms
> >>>> that you then typically feed into a DAC (and in some cases from the =
DAC into a
> >>>> power amplifier). So the DDS is just part of the data/signal path. A=
nyways, not sure
> >>>> on the new type and I think we already have the "blocks" in IIO for =
dealing with this:
> >>>>
> >>>> . frequency
> >>>> . phase
> >>>> . amplitude (raw + scale + offset)
> >>>>
> >>>> But you're right that maybe it's time to think in a better way to fi=
t them together.=C2=A0
> >>>> Maybe a new type (as buffers or events) can make sense where the abo=
ve are treated as, example, scan
> >>>> elements. Maybe it's overcomplicating, not sure. It surely needs  di=
scussion and thinking :).
> >>>>
> >>>> And spoiler alert, as you might have guessed already, the parallel p=
ort stuff is to be
> >>>> used with DMA buffers (and IIO backends). At least, that was the pla=
n IIRC. But Rodrigo
> >>>> can confirm it.
> >>>>    =20
> >>>>> I think we've seen enough of these already to know that things like=
 a
> >>>>> "tone generator" and a "ramp generator" are going to be common and =
could
> >>>>> share some standard attributes.=20
> >>>>>      =20
> >>>>
> >>>> I tend to agree. For example, there already some DACs (with ditherin=
g) that make use of a similar
> >>>> interface (but with a custom prefix). Though the end goal is differe=
nt, the interface is not that
> >>>> far off:
> >>>>
> >>>>
> >>>> https://elixir.bootlin.com/linux/v6.19.3/source/Documentation/ABI/te=
sting/sysfs-bus-iio-dac-ltc2688
> >>>>
> >>>> Anyways, I knew this one would be an interesting one for upstream :)=
   =20
> >>>
> >>> For history buffs, we had a bunch of DDS chips in staging at one poin=
t and never
> >>> manage to figure out the questions being raised here :(  They are com=
plex
> >>> beasts.  Clarity of ABI proposal and documentation is going to be key=
 to driving
> >>> this series forwards. In a sense the code is the easy part.   =20
> >>
> >> Does that mean that once good documentation is provided, the presented=
 design can
> >> be accepted? Even though data generators/sources might not be interpre=
ted as
> >> altvoltage channels? =20
> >=20
> > I'm not sure yet :(  It's a pretty complex design and we haven't really=
 come to a conclusion
> > on how to handle this channel 'mixing' case.
> >=20
> > If we did go this way, we'd need to figure out a way to describe the mi=
xing part.
> > So either we describe it as one channel (which is going to be really co=
mplex)
> > or we describe it as multiple channels but add extra ABI to make it cle=
ar they
> > are mixed into a single 'physical' channel.
> >=20
> > Jonathan
> >  =20
> >> =20
> >  =20
>=20
> Some ideas have crossed my mind, like adding new option to the in_/out_
> prefix for "internal" channels. But I it would take a long time to teach
> existing generic userspace libraries/tools about this.
>=20
> What has popped into my head just now is that perhaps we could do like
> Rodrigo is proposing here reusing existing channels and standard attribut=
es
> as much as possible and add a new "subcomponent_of" attribute to provide
> the link, similar to "current_trigger" for triggers.
>=20
> This way, it would still work with existing userspace tools (even if it
> looks a bit confusing). And userspace tools could eventually be taught
> to present the channels as a tree-like structure with the main channel
> and subcomponents nested under it.
>=20
> We would want to spell out up front what all of the anticipated ways of
> using it are. For example, I suspect eventually someone will want this
> attribute to be writeable to assign a specific limited resource to a
> specific channel. An I expect that we would eventually see something were
> a single subcomponent is shared between multiple physical channels. In
> this case, we would want the value of the "subcomponent_of" attribute to
> be able to be a list.

Something along those lines might work. I'd not thought about the case
of one 'internal' going to multiple 'external'.  Otherwise I was wondering
if something informal related to labels would work.  We've done that where
we've been associating things like voltage and power measurement from a sin=
gle
pin.  It's rather adhoc though.  Possibly we could roll it into a newer
more general scheme.

If the association is done as meta data attributes alongside existing
channels then as you say existing tools will kind of work, just need some
human understanding of what is actually being controlled until they catch
up with the newer schemes.

Lots of ways we could actually represent the graphs.  Going to take some
figuring out!

J


