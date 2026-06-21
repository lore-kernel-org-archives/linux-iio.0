Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648D9443;
	Sun, 21 Jun 2026 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782069263; cv=none; b=fs3L24pOoZnf6ydrir4qIMXNDheagh1hSdOkChHfLLzqjQtOmT/lZVkH7zZ3IxB5/a5VvKS/2K5xiECKEz426T57nRqeBl7k9oH+SLZAeSCrhTzu4mJC6jUau5y1y6Hnm9m904suoe0zK4h6rVlSZe1gCp3O1VQPZ8LDyvTWi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782069263; c=relaxed/simple;
	bh=oipEpYA0ZM83N6c4CazoEmIw6zqHbje+BxKzMj6fTs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUeZ+j3eKu7oTjyfRb7bV96QoJ2V1yEoBlVhFY8GCHHhN4pnKNU/ARDGJ8oB0rxTYMNFoK23/+mLM/ZCGkrPE4Z1NY9MXeWJm3ZWjvL7xGNLp2Cud8SamUuse+q17oFddgk+HcTb6ftZoN+A7CWuiAU2J0zZqtGsOWKuTvBXPHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhlSCQLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhlSCQLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE2F1F000E9;
	Sun, 21 Jun 2026 19:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782069262;
	bh=e08XCYPRvvElxG/dZRxidGucYQfMLq4JwZVZcfbGDxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XhlSCQLzS0p6aU9PDruNBQcuy3r8Ksp7+twDXuVYTMaDu7jTjIBX1ENM4fKAQ3In3
	 sNHeCAn51z3fOKvqE9Csxcvi3CSau9Gs+BiLyfTWhChBviin7eAIO+hDuB50FZ8uPh
	 qlvm72KaZA55LWNtgjwLFvTqNruHkj667kkNFriiKx2iu30Urp9Rd4ZowQxJC9lZja
	 txQFpmvjXoRPLVzDXk44DN88dnMBPeKoFkBmEvXewX1udYIjxD+pbzGjdhbHLeEn7q
	 1nqi2zLnuPCt1uLW5ghk+k64vadLl1GPyybE6HKTLhcDwp9q6Gr/xTr+yspD+TIpcY
	 jMqt5YfNG09AA==
Date: Sun, 21 Jun 2026 20:14:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: adc: new ti-ads112c14 driver
Message-ID: <20260621201412.0ce54fa8@jic23-huawei>
In-Reply-To: <9b8d5cfc-e392-45aa-9adc-867c364dd36e@baylibre.com>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
	<DJA1J8D91ESA.2XU7OCVKN7LXU@gmail.com>
	<d3270250-ae18-4c0f-a0fe-e0fdabfce046@baylibre.com>
	<DJANEYYA4QTA.1JBN2L78PNXDD@gmail.com>
	<9b8d5cfc-e392-45aa-9adc-867c364dd36e@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jun 2026 13:16:46 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/16/26 12:26 PM, Kurt Borja wrote:
> > On Tue Jun 16, 2026 at 10:21 AM -05, David Lechner wrote: =20
> >> On 6/15/26 7:18 PM, Kurt Borja wrote: =20
> >>> On Mon Jun 15, 2026 at 4:59 PM -05, David Lechner (TI) wrote: =20
>=20
> ...
>=20
> >>>> All of these chips have in common that they are designed for use with
> >>>> RTDs and thermocouples and so they look very similar to each other in
> >>>> terms of wiring and feature set, even if the register maps are
> >>>> different. They are in the gray area where we could either keep them
> >>>> separate because they are just different enough, or we could do like
> >>>> we've done before with ad_sigma_delta and have a bit of an abstracti=
on
> >>>> layer for the register differences and otherwise try to share as much
> >>>> code as possible. Normally, I would lean towards keeping them separa=
te,
> >>>> but in this case, I'm considering trying to share code because the
> >>>> devicetree bindings for the inputs is complex and is going to be mos=
tly
> >>>> the same across all of these chips. =20
> >>>
> >>> The channel configuration is indeed very similar for the three chips.
> >>> All three have IDAC, BOC and VREF configurations. =20
> >>
> >> Hmm... I forgot to include the burnout current in the DT bindings. Fol=
lowing
> >> the channel =3D "conditions for measurement" pattern that I have set o=
ut here
> >> I guess that would mean that we would need to have the same inputs twi=
ce
> >> when using the burnout. One "channel" would be the one used to do a "p=
recision"
> >> measurement and the other would be the one to do open/short circuit de=
tection.
> >>
> >>
> >>     i2c {
> >>         #address-cells =3D <1>;
> >>         #size-cells =3D <0>;
> >>
> >>         adc@40 {
> >>             compatible =3D "ti,ads112c14";
> >>             reg =3D <0x40>;
> >>
> >>             avdd-supply =3D <&avdd>;
> >>             dvdd-supply =3D <&dvdd>;
> >>
> >>             refp-supply =3D <&avdd>;
> >>
> >>             #address-cells =3D <1>;
> >>             #size-cells =3D <0>;
> >>
> >>             channel@0 {
> >>                 reg =3D <0>;
> >>                 diff-channels =3D <1>, <2>;
> >>                 excitation-channels =3D <0>, <3>;
> >>                 excitation-current-microamp =3D <500>;
> >>                 current-chopping;
> >>                 ti,vref-source =3D <ADS112C14_VREF_SOURCE_EXTERNAL>;
> >>                 label =3D "rtd-precision";
> >>             };
> >>
> >>             channel@1 {
> >>                 reg =3D <0>;
> >>                 diff-channels =3D <1>, <2>;
> >>                 excitation-channels =3D <0>, <3>;
> >>                 excitation-current-microamp =3D <500>;
Maybe use an example with more stuff changing? Do we want same excitation
for burn out? I've no idea.

> >>                 burnout-current-nanoamp =3D <1000>;
> >>                 ti,vref-source =3D <ADS112C14_VREF_SOURCE_EXTERNAL>;
> >>                 label =3D "rtd-diagnostic";
> >>             }; =20
> >=20
> > This would mean we wouldn't be able to use iio_chan_spec .channel and
> > .channel2 to describe inputs because of duplicate sysfs attributes, no?
> >  =20
>=20
> Yes, that is a bit unfortunate. At least there the labels to tell them
> apart. I guess we would just need to use consecutive channel and channel2
> when dynamically allocating the channels to avoid conflict.=20

=46rom a very initial look, maybe do something similar to the folk have
been looking at for the more complex DDS devices where we have lots
of channels that are on the same 'wires'.  Basically add a numbering
scheme to keep them reasonably separate - channel numbers are cheap.
Maybe first channel is 10->1f, second 20-2f etc.  They are differential
so it will get ugly.  Perhaps have a play around and see if there is
a reasonable channel naming scheme for this 'same inputs, different thing
being measured case'

I'm not yet sure I'm convinced that a separate channel model makes sense.
Even less in the DT given these are different settings for one channel.
That doesn't mean we don't split them up in the driver if channels
are the best implementation / ABI to userspace.

Basically nothing actually says diff-channels numbers match the
userspace ABI, so break that link.

>=20
> >>>> This makes things more flexible, but does make the driver a bit more
> >>>> complex. For example, knowing when the current output needs to be
> >>>> enabled or disabled. For now, I have chosen a lazy-enable where they
> >>>> are not turned on until the first measurement is taken that requires
> >>>> them, but then they stay on until another measurement is taken that
> >>>> doesn't require them. This can lead to some oddness with the diagnos=
tic
> >>>> channels that may be measuring something that indirectly requires the
> >>>> current output (i.e. the external reference voltage when it is conne=
cted
> >>>> to a resistor rather than a power supply). This means you need to ta=
ke
> >>>> a measurement that requires the current output to be enabled before =
the
> >>>> diagnostic channels will give accurate readings. =20
> >>>
> >>> This is the same approach I took around the BOC, it feels kinda hacky
> >>> but it makes sense. Just an idea I thought about just now: What if we
> >>> have an additional write-only "_enable" sysfs attribute for these
> >>> channels? =20
> >>
> >> I would not want to make a write-only attribute, we always want to be
> >> able to read back what the current state is. =20
> >=20
> > Yeah, I don't know why I said WO. Reading would be fine too.
> >  =20
> >>
> >> Do you mean an _enable for just the BOC? I think I would do it like I
> >> suggested above instead. =20
> >=20
> > No, no just the BOC. The BOC, IDAC and rest of side effects. Thinking
> > about it some more, it would be a bit redundant but clearer if proper
> > documentation is provided.
> >  =20
> I would be interested to see what Jonathan has to say about this too.
> Generally, his advice has been to avoid attributes that power things
> on and off if we can help it.
>=20
This is again a bit similar to the DDS case, but there we have more than
one on at a time (as controlling different parts of the signal - freq
/ phase / amplitude).  Here we at least avoid that complexity.

I didn't really like that solution but we didn't come up with any other
way to support the complex stuff going on.  Hence I'm not necessarily
suggesting to go that way here.

I think this may be a case of laying out different options in an ABI
doc then reviewing that to make sure we spot corner cases etc.

Thanks,

Jonathan

p.s. Sometimes it feels like the world just keeps getting more complex!


