Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95122765ED;
	Sun,  8 Mar 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772993565; cv=none; b=HuRjRd2iKBK/2NwFN4IiZ8VWdLI9u35uL8tAZx3FfliAFTDU0c6DgWLZVPzaEnXhz57T5ZVyWbEuDRJ4YgXi0YX/5vE3hnPVSwbGe7j05bjHi1Aai/Q+MXwsiBzIjJ+yJwuF84htq1HzpgmVI5J8wCLrsHbNKRsZ351AhnaInmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772993565; c=relaxed/simple;
	bh=BAVK6/WzrAdg2vhQDRiaGen1VnJjqGRGepdevwj41vE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brMRKMGYbONOWEk6d6Dco1LLj+kK+5fHZzWZGehXR/DOC+TTeLDvb8MJx52tXztYSSJzcfexg/QrfjZ4vF2XAFYuBKuiHtqg3RQoAyyURO58Sqf86V/ACuDH2mRUnjgV9nL9t/b0uP6dJciELAirLmHm5zkBORTB9ME2xJoN+jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8aWi1It; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8aWi1It"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C5DC116C6;
	Sun,  8 Mar 2026 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772993565;
	bh=BAVK6/WzrAdg2vhQDRiaGen1VnJjqGRGepdevwj41vE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8aWi1ItDAw3AofUdwN1HxZeFh81ShngEE4Le+nfSXChaWRtrWtluttxM1kdbXq1V
	 wCBzpkOHUy49m7YUQrl6Ec6Nil+1s7soBQY2pCLpzj24cSSR2u4z521nhplCkr1DB2
	 CUESvjQc1svjDZiCRu5pFfLTenZ7rzPsML2ZD2z0bumE5otLbLYHDxMdVL5CYIAWga
	 /AQuYyaHsZshC7tj8YrB75J7yKNxWn39liLLYbAs2WS8e6ROwNbPvti1iBJr+RbVOd
	 MiIIUmSMO0HnuCFFJNzzuW2SsSbAy1waHl8ofn94201PZATsyAIAWjzlnLSc70W5LN
	 E+Q5L04BuL9xw==
Date: Sun, 8 Mar 2026 18:12:34 +0000
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
Message-ID: <20260308181234.2e7ac4b9@jic23-huawei>
In-Reply-To: <42fe94df-ff8c-49d2-9a03-7d00e48eb22b@baylibre.com>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
	<a72b2d62-3b91-4789-a1b1-ff1429e80ed5@baylibre.com>
	<2k4ouimpaxjuhnk67qmrues2375zj43ehru7h5as6w6kf7yak3@2ndr72co5trh>
	<bdc973e5-df74-48f2-8884-439b03565940@baylibre.com>
	<9392fea00a9c3b23d1bc9468faa1b3cc20904398.camel@gmail.com>
	<20260301133806.5e706756@jic23-huawei>
	<pohirub7gjqu7xtq5qakkmr3wlek2rgj6kdgltjvir6g4jwgbr@hmjflsplni4o>
	<20260307140953.46db3c19@jic23-huawei>
	<7cc67826-3a8a-4190-9447-62b7d68e4445@baylibre.com>
	<20260307165816.46a98d34@jic23-huawei>
	<zurbjiq5nqbcid5h6kfworkmhczigirkzsqqsczfkatpg3bbe3@t7ssv76d3t4a>
	<42fe94df-ff8c-49d2-9a03-7d00e48eb22b@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Mar 2026 14:01:14 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 3/7/26 12:54 PM, Rodrigo Alencar wrote:
> > On 26/03/07 04:58PM, Jonathan Cameron wrote: =20
> >> On Sat, 7 Mar 2026 10:50:14 -0600
> >> David Lechner <dlechner@baylibre.com> wrote:
> >> =20
> >>> On 3/7/26 8:09 AM, Jonathan Cameron wrote: =20
> >>>> On Mon, 2 Mar 2026 10:22:47 +0000
> >>>> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> >>>>    =20
> >>>>> On 26/03/01 01:38PM, Jonathan Cameron wrote:   =20
> >>>>>> On Mon, 23 Feb 2026 10:02:00 +0000
> >>>>>> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >>>>>>      =20
> >>>>>>> On Sun, 2026-02-22 at 14:32 -0600, David Lechner wrote:     =20
> >>>>>>>> On 2/22/26 4:01 AM, Rodrigo Alencar wrote:       =20
> >>>>>>>>> On 26/02/21 02:16PM, David Lechner wrote:       =20
> >>>>>>>>>> On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:      =
 =20
> >>>>>>>>>>> This patch series adds support for the Analog Devices AD9910 =
DDS.
> >>>>>>>>>>> This is an RFC so that we can agree/discuss on the design tha=
t follows:
> >>>>>>>>>>>        =20
> >>>>>>>>
> >>>>>>>> ...
> >>>>>>>>        =20
> >>>>>>>>>>> represents a distinct signal path into the DDS accumulator, s=
o the driver
> >>>>>>>>>>> models them as separate IIO output channels (all IIO_ALTVOLTA=
GE type).       =20
> >>>>>>>>>>
> >>>>>>>>>> Generally IIO channels represent the physical input/output, no=
t the
> >>>>>>>>>> internal channels.       =20
> >>>>>>>>>
> >>>>>>>>> That is part of the reason for this RFC. Dividing those top-lev=
el modes
> >>>>>>>>> into channels allows for better organization, as they can opera=
te together,
> >>>>>>>>> i.e., phase or scale can be provided by single-tone profile, wh=
ile
> >>>>>>>>> frequency is controlled by the digital ramp generator (see Mode=
 Priority
> >>>>>>>>> section in the datasheet). Also, it allows to explore the most =
of standard
> >>>>>>>>> ABIs like, scale, frequency, phase, sampling_frequency and enab=
le.
> >>>>>>>>> Putting everything into a single channel would make things a lo=
t messy
> >>>>>>>>> to interface with.
> >>>>>>>>>        =20
> >>>>>>>>>> Ideally we would just have the one channel here with a mode se=
lection
> >>>>>>>>>> attribute. Documentation can tell us which modes use which att=
ributes.
> >>>>>>>>>>        =20
> >>>>>>>>>>> This per-channel separation allows userspace to configure eac=
h mode
> >>>>>>>>>>> independently through its own set of sysfs attributes, and to
> >>>>>>>>>>> enable/disable modes individually via IIO_CHAN_INFO_ENABLE, r=
elying on
> >>>>>>>>>>> the hardware's own mode selection architecture.
> >>>>>>>>>>>        =20
> >>>>>>>>
> >>>>>>>> Looking at Table 5 in the datasheet really helped me understand =
this better.
> >>>>>>>> I think this series could benefit from a documentation patch tha=
t explains
> >>>>>>>> more about how the driver works with some diagrams.
> >>>>>>>>
> >>>>>>>> So really what we have here are a bunch of digital data generato=
rs rather
> >>>>>>>> than a bunch of altvotlage output channels. And the same data ch=
annels can be
> >>>>>>>> mixed and match as the source for up to 3 different components o=
f the output
> >>>>>>>> (frequency, phase, amplitude) depending on the priority rules de=
fined in
> >>>>>>>> Table 5.       =20
> >>>>>>>
> >>>>>>> More bellow... But note that all of the (or most of it) generator=
s are going to
> >>>>>>> be feed into a DAC. Your output is altvoltage but maybe we can tr=
eat the
> >>>>>>> internals as voltage. Not sure.
> >>>>>>>       =20
> >>>>>>>>
> >>>>>>>> Digital data sources are really more like a buffer in IIO terms =
than a
> >>>>>>>> channel. And before we added the IIO backend stuff, there wasn't=
 really
> >>>>>>>> any other digital data source/sink that I am aware of other than=
 buffers
> >>>>>>>> (but there are certainly a lot of odd corners of IIO that I have=
n't explored
> >>>>>>>> yet, so maybe I missed some).
> >>>>>>>>
> >>>>>>>> In a recent discussion, the idea of possibly needing a way to pr=
ovide
> >>>>>>>> some userspace interface to be able to tweak knobs of an IIO bac=
kend
> >>>>>>>> was also brought up.
> >>>>>>>>
> >>>>>>>> Putting those ideas together, I'm wondering if we need some new =
channel
> >>>>>>>> type or even a whole new interface (e.g. a new sysfs directory l=
ike buffers
> >>>>>>>> and events) for managing these digital data sources/sinks that a=
re not an
> >>>>>>>> IIO buffer.
> >>>>>>>>        =20
> >>>>>>>
> >>>>>>> But what would be that channel? In the end of the day, we typical=
ly have voltage or
> >>>>>>> current DACs and a DDS primary function is indeed to generate alt=
ernating waveforms
> >>>>>>> that you then typically feed into a DAC (and in some cases from t=
he DAC into a
> >>>>>>> power amplifier). So the DDS is just part of the data/signal path=
. Anyways, not sure
> >>>>>>> on the new type and I think we already have the "blocks" in IIO f=
or dealing with this:
> >>>>>>>
> >>>>>>> . frequency
> >>>>>>> . phase
> >>>>>>> . amplitude (raw + scale + offset)
> >>>>>>>
> >>>>>>> But you're right that maybe it's time to think in a better way to=
 fit them together.=C2=A0
> >>>>>>> Maybe a new type (as buffers or events) can make sense where the =
above are treated as, example, scan
> >>>>>>> elements. Maybe it's overcomplicating, not sure. It surely needs =
 discussion and thinking :).
> >>>>>>>
> >>>>>>> And spoiler alert, as you might have guessed already, the paralle=
l port stuff is to be
> >>>>>>> used with DMA buffers (and IIO backends). At least, that was the =
plan IIRC. But Rodrigo
> >>>>>>> can confirm it.
> >>>>>>>      =20
> >>>>>>>> I think we've seen enough of these already to know that things l=
ike a
> >>>>>>>> "tone generator" and a "ramp generator" are going to be common a=
nd could
> >>>>>>>> share some standard attributes.=20
> >>>>>>>>        =20
> >>>>>>>
> >>>>>>> I tend to agree. For example, there already some DACs (with dithe=
ring) that make use of a similar
> >>>>>>> interface (but with a custom prefix). Though the end goal is diff=
erent, the interface is not that
> >>>>>>> far off:
> >>>>>>>
> >>>>>>>
> >>>>>>> https://elixir.bootlin.com/linux/v6.19.3/source/Documentation/ABI=
/testing/sysfs-bus-iio-dac-ltc2688
> >>>>>>>
> >>>>>>> Anyways, I knew this one would be an interesting one for upstream=
 :)     =20
> >>>>>>
> >>>>>> For history buffs, we had a bunch of DDS chips in staging at one p=
oint and never
> >>>>>> manage to figure out the questions being raised here :(  They are =
complex
> >>>>>> beasts.  Clarity of ABI proposal and documentation is going to be =
key to driving
> >>>>>> this series forwards. In a sense the code is the easy part.     =20
> >>>>>
> >>>>> Does that mean that once good documentation is provided, the presen=
ted design can
> >>>>> be accepted? Even though data generators/sources might not be inter=
preted as
> >>>>> altvoltage channels?   =20
> >>>>
> >>>> I'm not sure yet :(  It's a pretty complex design and we haven't rea=
lly come to a conclusion
> >>>> on how to handle this channel 'mixing' case.
> >>>>
> >>>> If we did go this way, we'd need to figure out a way to describe the=
 mixing part.
> >>>> So either we describe it as one channel (which is going to be really=
 complex)
> >>>> or we describe it as multiple channels but add extra ABI to make it =
clear they
> >>>> are mixed into a single 'physical' channel.
> >>>>
> >>>> Jonathan
> >>>>    =20
> >>>>>   =20
> >>>>    =20
> >>>
> >>> Some ideas have crossed my mind, like adding new option to the in_/ou=
t_
> >>> prefix for "internal" channels. But I it would take a long time to te=
ach
> >>> existing generic userspace libraries/tools about this.
> >>>
> >>> What has popped into my head just now is that perhaps we could do like
> >>> Rodrigo is proposing here reusing existing channels and standard attr=
ibutes
> >>> as much as possible and add a new "subcomponent_of" attribute to prov=
ide
> >>> the link, similar to "current_trigger" for triggers.
> >>>
> >>> This way, it would still work with existing userspace tools (even if =
it
> >>> looks a bit confusing). And userspace tools could eventually be taught
> >>> to present the channels as a tree-like structure with the main channel
> >>> and subcomponents nested under it.
> >>>
> >>> We would want to spell out up front what all of the anticipated ways =
of
> >>> using it are. For example, I suspect eventually someone will want this
> >>> attribute to be writeable to assign a specific limited resource to a
> >>> specific channel. An I expect that we would eventually see something =
were
> >>> a single subcomponent is shared between multiple physical channels. In
> >>> this case, we would want the value of the "subcomponent_of" attribute=
 to
> >>> be able to be a list. =20
> >>
> >> Something along those lines might work. I'd not thought about the case
> >> of one 'internal' going to multiple 'external'.  Otherwise I was wonde=
ring
> >> if something informal related to labels would work.  We've done that w=
here
> >> we've been associating things like voltage and power measurement from =
a single
> >> pin.  It's rather adhoc though.  Possibly we could roll it into a newer
> >> more general scheme. =20
>=20
> Hmm... in this case, it sounds more flat where there isn't a clear channel
> that would be the "root" of a tree relation.
>=20
> >>
> >> If the association is done as meta data attributes alongside existing
> >> channels then as you say existing tools will kind of work, just need s=
ome
> >> human understanding of what is actually being controlled until they ca=
tch
> >> up with the newer schemes.
> >>
> >> Lots of ways we could actually represent the graphs.  Going to take so=
me
> >> figuring out! =20
> >=20
> > I like the idea of subchannels to create logical tree-structures. It op=
ens
> > up for other possibilities.
> >=20
> > I wonder if the varying channel index would still confuse a user, even
> > with this metadata attribute, like:
> > - out_altvoltage0
> > - out_altvoltage1
> > 	- out_altvoltage1_subcomponent_of =3D out_altvoltage0
> >=20
> > would there be a different way to name the full_postfix in
> > __iio_device_attr_init() that would allow to keep channel index the same
> > (e.g. altvoltage0 for multiple internal sub-channel) and still be
> > compatible with userspace tools? I don't know, something like:
> > - out_altvoltage0
> > - out_altvoltage0_0
> > - out_altvoltage0_1
> > - out_altvoltage0_2
> >=20
> > userspace tools would understand out_altvoltage0_0_frequency as:
> > - direction: out
> > - type: altvoltage
> > - channel idx: 0
> > - attr name: 0_frequency
> >=20
> > and that would be a problem?
> >  =20
>=20
> I have a feeling that could be problematic for existing attribute
> parsers.

Agreed.  This smells like extend_name and that caused all sorts
of annoying problems for the userspace folk.

>=20
> How about using higher numbered channel indexes instead?
>=20
> out_altvoltage100_* =3D physical channel
>=20
> out_altvoltage101_* =3D subcomponent
> out_altvoltage102_* =3D subcomponent
> ...
Have to be careful we don't run out of space for events.
#define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
So we do have 16 bits hence this might work.

I'm not sure we want to make rules around this though.

Jonathan


>=20

