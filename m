Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0733321DE;
	Wed, 22 Jul 2026 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784685538; cv=none; b=RD4k6DoDMIabysCPF8AMcV7WnyNuh2YEDAjRWXPXzygRP1cchIeBQ7stIChev2bVdJjpf5kbM4RfFyHRwwvy3nT+x8cDEDpzqjPoD0wlu/l9meuLSc12bYH1Ma98mPOpeWcvAG3ncq37fGAzfawp+nTIK98SLE2uBb4LO58r7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784685538; c=relaxed/simple;
	bh=y8ADUG0zwzWERapOhBC8AxJsztNtv+4c1xGUAVUDqCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqGteGz/KdY2l+mvkFtoz8TRR8EGji4OWCkWExt1ripmrQcqGqzPneGVYW2wgTeOye9b3IMU5p94v22B4DfRBsTR7+6cDvgqvhSkyaEvEEFpF4nmZ6DRD9yjcbN0tqs+pniPY+ZMPCp2UigF/rBERvxuvGMPQzHioguTAH1FTVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8lMdM9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8lMdM9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5181F000E9;
	Wed, 22 Jul 2026 01:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784685537;
	bh=AQb/xHGBmr272AXohfcNUeqobkwwsITC5O617XIyV5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V8lMdM9MIr8nQlgYIz022pwmtI4Jj8f58AU8zkm+JF6bENKhVfGKxoLqukbJJUIhk
	 aCtVSsAoBsxYuW8uUsoUEki222X+Bh5/4P3TZXa1fHqUosxoLuCW/HkYwKVpOgPvHE
	 GK090ODmrF3hXDO9yM0m1HJGnZiwju/J4Pwf4xYYdyg1XyBEXXoIK9unb2iHUFlfpl
	 lDce47HEH+7mnLckPTTu517Nx29H3mwFsclxKbhIJ2xZowvbpyUTAm+MtInnULvJEX
	 KQvqtDXJECfXEDEne5pwbO+QIwmTiOe7iLH4V5ahEQ6oNE265b2TAqwBnNjPkMyHXQ
	 MIq3+B88/YcQg==
Date: Wed, 22 Jul 2026 02:58:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <jananisunil.dev@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Janani Sunil
 <janani.sunil@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: Add AD7768
Message-ID: <20260722025853.6ca3961d@jic23-huawei>
In-Reply-To: <d159cae0-b11e-49e9-a546-023ed61b900e@gmail.com>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
	<20260709-ad7768-driver-v1-1-44e1194fd96a@analog.com>
	<36df7c4f-82ea-4ed5-a4f9-3a29c75dc99a@baylibre.com>
	<9dd16bb5-7a30-4024-88a7-4a4bf47c35e8@gmail.com>
	<e791f4f9-63dd-40f5-aec4-5b540bcee5ff@baylibre.com>
	<d159cae0-b11e-49e9-a546-023ed61b900e@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jul 2026 10:03:26 +0200
Janani Sunil <jananisunil.dev@gmail.com> wrote:

> On 7/21/26 03:39, David Lechner wrote:
> > On 7/20/26 9:00 AM, Janani Sunil wrote: =20
> >> On 7/9/26 17:43, David Lechner wrote: =20
> >>> On 7/9/26 3:50 AM, Janani Sunil wrote: =20
> >>>> Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8
> >>>> channel) simultaneous sampling ADC
> >>>>
> >>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> >>>> ---
> >>>>  =20
> >>>> +
> >>>> +=C2=A0 adi,power-mode:
> >>>> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/string
> >>>> +=C2=A0=C2=A0=C2=A0 enum:
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - low
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - median
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - fast
> >>>> +=C2=A0=C2=A0=C2=A0 description:
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Power mode selection. =20
> >>> Unless there are pins that control this, it seems like it should
> >>> be left up to the driver to decide how to set this.
> >>>
> >>> In this case, it looks like the power mode also influences sample
> >>> rate which is normally something controlled at runtime. =20
> > Looking at this again, there is also an MCLK divider that influences
> > sample rate, so sampling_frequency to power mode is not
> > straight-forward anyway.
> > =20
> >> Hi David,
> >>
> >> The reason we'd like to retain power mode control is that certain
> >> ODRs are supported across all three power modes (low/median/fast),
> >> and the RMS noise and power consumption differ significantly
> >> between them at the same ODR.
> >>
> >> The higher the power mode, the better the noise performance, but
> >> power consumption nearly doubles for every ~3 dB improvement in
> >> dynamic range. Silently selecting one power mode in the driver
> >> would remove a meaningful hardware tradeoff from the user.
> >>
> >> We'd like to propose the following instead:
> >> - Remove adi,power-mode from the DT as suggested.
> >> - Expose power mode as a per-device sysfs attribute.
> >> - in_voltage<N>_sampling_frequency_available dynamically reflects
> >> only the ODRs valid for the currently selected power mode.
> >>
> >> This keeps the DT clean while still giving the user explicit
> >> control over the noise versus power trade off. Would this approach
> >> be acceptable?
> >>
> >> Thanks,
> >> Jan
> >>
> >> =20
> > Jonathan usually pushes back against userspace power controls. We
> > do have this for accelerometers, but not ADCs currently.
> >
> > If we can't think of anything better, maybe we could use this. It
> > only has low_noise and low_power options though, so the driver
> > would still need to chose the best power mode of the 3 based on the
> > other requested parameters. E.g. always make all sampling_frequency
> > available  and just pick the highest power or lowest power mode
> > that can provide that rate based on the power_mode attribute.
> >
> > I wanted to suggest maybe adding some kind of noise attribute
> > instead, but I'm not sure how we could do that in a way using SI
> > units since the value would depend on so many things (at least
> > V_REF voltage, filter type, temperature and even the physical
> > input). =20
>=20
> We considered the low_power/balanced/low_noise approach, but the
> customers typically use the datasheet alongside the driver and the
> datasheet explicitly uses the terms "low power", "median" and "fast"
> for the three modes. Abstracting them with different names in the
> sysfs attribute would create a confusion- the users would have to
> mentally translate between the two naming conventions. The noise
> attribute would not actually configure anything on a register level-
> it would purely be informational. Furthermore, noise performance is
> not solely determined by the power mode. There are other parameters
> (eg. filter mode) that has a significant impact. A power_mode
> attribute directly configures the hardware register and has a
> deterministic effect on the device.
>=20
> Jonathan, could we keep the power_mode as an attribute in this case?

My really strong resistance to 'mode' type controls is they are
meaningless to general purpose software.  It has no idea how to
set them correctly. The purpose of IIO is to provide general abstractions
and power modes are never that.

Hence we put a lot of effort into mapping them to controls or measures
that have precise meaning.

I can't remember how I got talked into allowing the accelerometer
ones either :(  It was way back in 2013 and we have only one user.
I should shift that ABI doc to a driver specific one so as not tempt
more users.

To give a firmer opinion I guess I'll go read the datasheet at somepoint
but it's not a small one so that may take a little while.  I do see
that there is a recommendation for each power setting to only cover
one range of f_mod.  Maybe that gives us a route to a control that
it at least numerically meaningful (For those who know what effect
the modulator frequency has in a sigma delta modulator! Which
doesn't include me ;()

Any chance we can kick this into the future and get a useful base
driver ready for upstream?  It is a lot easier to have these discussions
when they are the only topic related to a thread.  One path to move
on would be to decide to default (only option for now) to the
best noise option.  Later we can add controls that result in that
initial default changing,

Jonathan



>=20

