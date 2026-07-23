Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E63E5573;
	Thu, 23 Jul 2026 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784846950; cv=none; b=YD4+pTHSmR65SBNCYX35AZWDw6Vjpi7EGag1Acggm4M4HCwsWcY6gE9fNXJlvH0/OcwkmbOSgNRS+5h5hSsi3kUO7TpflxhlIc5NL0JEZhn14mw5tgS43ZYkjf+UZEE0VnkIPV+qUvWiXj09/91SVVkmbyHe2yBXDQvSdR6QIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784846950; c=relaxed/simple;
	bh=0OmuGYPb/+BRuRltsV/v6bVuEb5WdqJCk9QfWrGzNIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnuZhrjOLN4rUjxPjEwcI6jZ3qdltnBT6jEcPSwDtaefmTRmQcta7xFKdEiqIYAJ9x158pCsFSLYj2H0OIwhtQSRN7jqm3+M6EHow6/C1pNemavlsLlftmWOi4/uVlrLDhB7bHTjEP05PBni/jdMMd5oTYc8ftW08tOXlu6r4hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7xxEt5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7xxEt5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617DB1F000E9;
	Thu, 23 Jul 2026 22:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784846942;
	bh=+wyg8rUT9xMLQcFyWWuXmyA+TPbyp721ZYGcC0CFUI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C7xxEt5aS25huuJy6ltNctmdtaTILhWoP8GeeWfew/OfkOBlz/cIGOMC4lLY5iUaH
	 m59eA+TNnlU2GG5c8445JrD5qtLWJ1Lk4nnIdgzRFbV6zDZx3btdqsdAHiTy+GPXc3
	 tjxWPu3zAPzwHWoHDpcwmGcK/sErj0fuboMkfHnHkjOGdhadG0Q2mKT7NYgRQbpHMA
	 TLCGg133yKcdtJzhLotLKA0mDuQlafrkoIHsvF9QDlGp5A09eVofskr2pl9wDw5/Jl
	 64m6+5A8QjjePUp8mleOt2BjVUF88lsVngXeuesCPj223KLq7DhtyW7m8hyNS6bfCI
	 MhdalQyRbDpvw==
Date: Thu, 23 Jul 2026 23:48:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Janani Sunil <jananisunil.dev@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Janani Sunil <janani.sunil@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: Add AD7768
Message-ID: <20260723234855.10f6cc9e@jic23-huawei>
In-Reply-To: <amHLZK46lxqSZIC8@nsa>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
	<20260709-ad7768-driver-v1-1-44e1194fd96a@analog.com>
	<36df7c4f-82ea-4ed5-a4f9-3a29c75dc99a@baylibre.com>
	<9dd16bb5-7a30-4024-88a7-4a4bf47c35e8@gmail.com>
	<e791f4f9-63dd-40f5-aec4-5b540bcee5ff@baylibre.com>
	<d159cae0-b11e-49e9-a546-023ed61b900e@gmail.com>
	<20260722025853.6ca3961d@jic23-huawei>
	<amHLZK46lxqSZIC8@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2026 09:15:08 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, Jul 22, 2026 at 02:58:53AM +0100, Jonathan Cameron wrote:
> > On Tue, 21 Jul 2026 10:03:26 +0200
> > Janani Sunil <jananisunil.dev@gmail.com> wrote:
> >  =20
> > > On 7/21/26 03:39, David Lechner wrote: =20
> > > > On 7/20/26 9:00 AM, Janani Sunil wrote:   =20
> > > >> On 7/9/26 17:43, David Lechner wrote:   =20
> > > >>> On 7/9/26 3:50 AM, Janani Sunil wrote:   =20
> > > >>>> Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8
> > > >>>> channel) simultaneous sampling ADC
> > > >>>>
> > > >>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > >>>> ---
> > > >>>>  =20
> > > >>>> +
> > > >>>> +=C2=A0 adi,power-mode:
> > > >>>> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/string
> > > >>>> +=C2=A0=C2=A0=C2=A0 enum:
> > > >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - low
> > > >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - median
> > > >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - fast
> > > >>>> +=C2=A0=C2=A0=C2=A0 description:
> > > >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Power mode selection.   =20
> > > >>> Unless there are pins that control this, it seems like it should
> > > >>> be left up to the driver to decide how to set this.
> > > >>>
> > > >>> In this case, it looks like the power mode also influences sample
> > > >>> rate which is normally something controlled at runtime.   =20
> > > > Looking at this again, there is also an MCLK divider that influences
> > > > sample rate, so sampling_frequency to power mode is not
> > > > straight-forward anyway.
> > > >   =20
> > > >> Hi David,
> > > >>
> > > >> The reason we'd like to retain power mode control is that certain
> > > >> ODRs are supported across all three power modes (low/median/fast),
> > > >> and the RMS noise and power consumption differ significantly
> > > >> between them at the same ODR.
> > > >>
> > > >> The higher the power mode, the better the noise performance, but
> > > >> power consumption nearly doubles for every ~3 dB improvement in
> > > >> dynamic range. Silently selecting one power mode in the driver
> > > >> would remove a meaningful hardware tradeoff from the user.
> > > >>
> > > >> We'd like to propose the following instead:
> > > >> - Remove adi,power-mode from the DT as suggested.
> > > >> - Expose power mode as a per-device sysfs attribute.
> > > >> - in_voltage<N>_sampling_frequency_available dynamically reflects
> > > >> only the ODRs valid for the currently selected power mode.
> > > >>
> > > >> This keeps the DT clean while still giving the user explicit
> > > >> control over the noise versus power trade off. Would this approach
> > > >> be acceptable?
> > > >>
> > > >> Thanks,
> > > >> Jan
> > > >>
> > > >>   =20
> > > > Jonathan usually pushes back against userspace power controls. We
> > > > do have this for accelerometers, but not ADCs currently.
> > > >
> > > > If we can't think of anything better, maybe we could use this. It
> > > > only has low_noise and low_power options though, so the driver
> > > > would still need to chose the best power mode of the 3 based on the
> > > > other requested parameters. E.g. always make all sampling_frequency
> > > > available  and just pick the highest power or lowest power mode
> > > > that can provide that rate based on the power_mode attribute.
> > > >
> > > > I wanted to suggest maybe adding some kind of noise attribute
> > > > instead, but I'm not sure how we could do that in a way using SI
> > > > units since the value would depend on so many things (at least
> > > > V_REF voltage, filter type, temperature and even the physical
> > > > input).   =20
> > >=20
> > > We considered the low_power/balanced/low_noise approach, but the
> > > customers typically use the datasheet alongside the driver and the
> > > datasheet explicitly uses the terms "low power", "median" and "fast"
> > > for the three modes. Abstracting them with different names in the
> > > sysfs attribute would create a confusion- the users would have to
> > > mentally translate between the two naming conventions. The noise
> > > attribute would not actually configure anything on a register level-
> > > it would purely be informational. Furthermore, noise performance is
> > > not solely determined by the power mode. There are other parameters
> > > (eg. filter mode) that has a significant impact. A power_mode
> > > attribute directly configures the hardware register and has a
> > > deterministic effect on the device.
> > >=20
> > > Jonathan, could we keep the power_mode as an attribute in this case? =
=20
> >=20
> > My really strong resistance to 'mode' type controls is they are
> > meaningless to general purpose software.  It has no idea how to
> > set them correctly. The purpose of IIO is to provide general abstractio=
ns
> > and power modes are never that.
> >  =20
>=20
> Unfortunately lot's of apps engineers for these parts just like to
> control it all and don't care about generic interfaces (given typically
> these the devices are the only ones they care). So we also have some pain
> trying to explain all of the advantages :).

Good thing they have to play by our rules if they want to have it
upstream and not ship the driver to very possible customer ;)

>=20
> > Hence we put a lot of effort into mapping them to controls or measures
> > that have precise meaning.
> >=20
> > I can't remember how I got talked into allowing the accelerometer
> > ones either :(  It was way back in 2013 and we have only one user.
> > I should shift that ABI doc to a driver specific one so as not tempt
> > more users.
> >=20
> > To give a firmer opinion I guess I'll go read the datasheet at somepoint
> > but it's not a small one so that may take a little while.  I do see
> > that there is a recommendation for each power setting to only cover
> > one range of f_mod.  Maybe that gives us a route to a control that
> > it at least numerically meaningful (For those who know what effect
> > the modulator frequency has in a sigma delta modulator! Which
> > doesn't include me ;()
> >=20
> > Any chance we can kick this into the future and get a useful base
> > driver ready for upstream? =20

However we go with this I'd like to keep it separate from initial driver
merge.  Then we can have a focused discussion around a follow up patch.

>It is a lot easier to have these discussions
> > when they are the only topic related to a thread.  One path to move
> > on would be to decide to default (only option for now) to the
> > best noise option.  Later we can add controls that result in that
> > initial default changing, =20
>=20
> Yeah, those were my internal 2 cents. Not sure if this is exactly what
> you're proposing but what also came to my mind was to have a RMS lookup
> table (same as in DS) and for the overlapping frequencies, just go with
> the one with better RMS figure. My assumptions is that most users will
> prefer that. If not else better comes, we can have a driver argument to
> override the prefered mode (same way we do for some ADIS IMU devices).
> And yes, I know module arguments are not very encouraged...

Yeah, for other cases a bit like this we've always assumed they want
minimum noise for a given set of parameters but that isn't quite always
the case when power consumption matters on the platform.=20

The IMU low rate allow thing (I guess that is what you mean) is perhaps
a little similar as you suggest.  It is an intentional override of
datasheet recommendations.  I'm not against doing that here, but definitely
as a follow up patch where the reasons are laid out clearly.

>=20
> Or given this also looks like a system level decision (I don't think this
> is something one wants to change at runtime) maybe DT (acting as an overr=
ide)
> would not be off the table.

This is a rare case where I'd not do it in the initial DT patch.=20
One of the exceptions to the document all stuff in bindings is when
we don't know how to do it yet.  I think that applies here.

Jonathan

>=20
> - Nuno S=C3=A1
>=20
> >=20
> > Jonathan
> >=20
> >=20
> >  =20
> > >  =20
> >  =20
>=20

