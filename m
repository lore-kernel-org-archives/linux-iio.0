Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609638;
	b=2pd+YNWfvpEbBy9iqAkCNNHv3NypAMo4sk+Nn5DxH0MfcWHfMKJ/gvLexuD0cJHZ8lAL
	 G660BMF2uxHT0P7amn47a5niDa172ta2hrNKn7OD+YRAkxibthZ5xrNin/AYxbrNQHgmD
	 TV70Gmt6LCi/gWdzzw9oPRb4wbUqy8s+cCyOoaTfJM1+AqqBrUCjASGmeaCX+HaExRNab
	 1WYzXXkga5CCUoV/Gsb/05wW7cwGZA8/zdy3VTjOhkb7Zkoim4UaxKY3Mqsio6pYa/11T
	 RgtCzNtV7BmsjEZS7ndraa0dcFDGcKBPAs0pZqnWaE0yF8Kl8QnNXMB0VA0FwQ5C/fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609638;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tPh+YBeZlaYR1H948NeSQcCiYdMFP7WZrgT1b9om4LU=;
	b=2ytk13Yo/+nKBh1afWvpZY6D8/hwIQnRw79IQ5uwtdFsiKwGxGvvLa15XAOqjIvH8nzC
	 uxiDv7L3OQO7y2uGDc42wlxCzlMKRtwgRfFMVpwAkLvAvG0veQ5vslo0IMiCrwPT6Cvqc
	 0DsqVAIZy6E8mbITwbe1RWIUY/zcTY34JkFm2LGHt0G7Jg+t9TDnVps9qSL8AaUst/eDF
	 70nR8BHffVSu9SXhkMc0tz8yiAMnN6cVRuhcvIaQI48SVvEjhGanSuOlgp/+04m9JtwXX
	 7TOob3Je9+CuQxkNghW0BD/U1fqrhwkhgo1HcePSAS1kTDxemPrXr9JdUt3dXSmdGGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTlitjPJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756E606A31B;
	Wed, 21 Oct 2026 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTlitjPJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7571F000C1;
	Wed, 21 Oct 2026 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792609637;
	bh=tPh+YBeZlaYR1H948NeSQcCiYdMFP7WZrgT1b9om4LU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RTlitjPJBupZr9X2f9sei2gN3h0lqU5sOVNDjfDT6k5b8EdhILiNKhJFaqlP15t/q
	 ceRjrnCHwn41jiYhLBJOGr1WY0IC0ag8X9V2Gg421yMWegonacevpBvE0pM9+btrq4
	 5nx5ewv3o2tvOe35TyPHvC5kieHtRGoR6ym1CaO9yO/v7vqiZ0G04SEPbL+T3/Hru+
	 ottyKFy4afbR/iuUxZHMyHWESPnYVmRnibdt+cFiV2KSPKn0pM7SReVSPVZYS5w+Z9
	 FVf7KJGykyyaSkgfwT54PwVB9t7HuYiWoTjT+LERP8M9OndJG0G6jUY1jzezCC+loa
	 jSN4BbapRWmQw==
Date: Wed, 21 Oct 2026 20:07:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <radu.sabau@analog.com>
Cc: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Message-ID: <20261021200708.5fc247c0@jic23-hlaptop>
In-Reply-To: <LV9PR03MB841470F3A6677BA505411546F7982@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
	<20261015-adis16607-v3-2-f972d4efee85@analog.com>
	<20261017021141.5b023e60@jic23-hlaptop>
	<LV9PR03MB841470F3A6677BA505411546F7982@LV9PR03MB8414.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2026 08:15:41 +0000
"Sabau, Radu bogdan" <radu.sabau@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, October 17, 2026 4:12 AM =20
>=20
> ...
>=20
> > >
> > > Add device tree bindings for the Analog Devices ADIS16607 Precision
> > > MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
> > > gyroscope, triaxial accelerometer, and temperature sensor, and
> > > communicates over SPI Half-Duplex.
> > >
> > > Two variants are supported: adis16607-2 and adis16607-3. =20
> >=20
> > Say briefly how they are different and hence require their
> > own compatibles. =20
>=20
> Hi Jonathan, thank you for looking at this, as well.
>=20
> The only difference between them is the gyroscope's fixed full-scale
> range: =C2=B1450=C2=B0/s for adis16607-2, =C2=B12000=C2=B0/s for adis1660=
7-3. Everything
> else (accelerometer range, decimation, internal clock, sync modes) is
> identical, and both report the same device ID over SPI, so the driver
> has no way to tell which gyro range is populated at runtime - the
> compatible string is the only source of that information. I'll make
> the commit message say this explicitly.

Good. A one liner to say scales differ in the commit message will do nicely.

>=20
> >=20
> > The hardware rest being a configurable pin is an unusual
> > bit of hardware design given how do we reset the reset pin
> > to issue a reset if the device is hung?
> >  =20
>=20
> I agree the hardware reset being configurable is unusual. GPIO0 is config=
ured
> as reset by default at power-up, so the driver probing at power-up is ok.
> However, to answer your question if the USER_GPIO_CFG register is altered
> by debugfs read or a bug or something else and the device is hung, the tr=
ue
> answer is you can't use hardware reset anymore and the only way out of th=
is
> would be a power-cycle.
>=20
> Perhaps a force write of the RESET_GPIO_MASK before the initial_startup
> would help in case the SPI communication would still be alive, and I guess
> if the SPI communication is broken we would then get an errno code anyway,
> right? I am not sure this is the best solution so I would like to know yo=
ur=20
> thoughts on this.

Yeah. I think try to write it - but only warn if write fails rather
than error out.  Gives us the best chance of recovering from any
problems.

>=20
> > >
> > > The binding exposes optional properties for:
> > >   - An external clock for sync mode (falling back to the internal 8 k=
Hz
> > >     clock when absent)
> > >   - A hardware reset GPIO (active low)
> > > =20
>=20
> ...
>=20
> > > +  reset-gpios:
> > > +    description:
> > > +      Optional GPIO for hardware reset. The line is active low.
> > > +    maxItems: 1 =20
> >=20
> > The datasheet I looked at has 4 gpio pins. You are calling out one
> > as reset.  What happens if we don't have controllable supplies
> > and someone else (firmware for instance) configured GPIO0 to not
> > be reset?
> >=20
> > Anyhow, feels like this isn't a full description.
> >  =20
>=20
> Indeed, this is not a full description. There are a total of 5 gpio pins =
to
> this device and each one has a fixed function, the USER_GPIO_CFG is
> more like an enable/disable register I would say. So RESET is either
> GPIO0 or idle to say so.
>=20
> Would you say that a description like this would be more suitable? :
>=20
> reset-gpios:
>     description:
>       Optional GPIO for hardware reset, active low. Of the device's
>       five GPIO pins, this one is dedicated to the reset function,
>       which can be independently enabled or idled via an on-chip
>       register.
Only talk about this one in this description.
But add the pins with appropriate names for the functions the others
support.  The GPIOX naming is silly given they are only good for
one thing each.  Just make sure to add something in the comment
to refer to what they are called on the datasheet.

Jonathan


>     maxItems: 1
>=20

