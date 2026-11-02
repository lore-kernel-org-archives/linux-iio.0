Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651754;
	b=EdxtSwcpDh/9gSBqWb63B6FHxcB4EIvmbaFewV4hPShKrR1EvuTBJFWhf2KUMP6DKzC1
	 ClQR7stOgOxf8qU8wo6qbGomLanqksIMM5SdQtApIwIkRNJ1PUvJg2r4KHt0XTNN1Dx2j
	 lZ5oG4s0G+CgNMthNDbzwOEU9Lk83DUIClYGFyBBOpYd+qswxMfg8rk0jGBkc4IqYMX6e
	 AkkkGTkv3DRzPkCABMoxCBJgE0u97rzng8Wgj3FG63dTzkrnOaN7Zn5MrJ5x8opjK6IPS
	 DcFiI21jIdERtOLlY4iX6lIrth7a6We8+C1EBeAHAJTx1FnRqC6MYErGxuu6qirUZUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651754;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dvVO2rNpJvTNuu02lcc9yj9nd8ebw6GqxP0aGvMJCMc=;
	b=o3kuTa8j8IxvNIyTCV9o/vyMYclA6uGD0UVAnF1Cg+HE+C1tjapu8nzxvinDa+UeDhYA
	 m2eCJWbgJ0ljhnzAZvqDtButlo7dNR/IHxHqjLDH5w7dfIXWLX0mHxm5KBakU73aNi0T7
	 E4dwQT31H4heB5zKP0zmCoSQaZvjnQXhWhYLoPS6k9iQXlr0QiwdFpYf3DHHzj24xAW9g
	 xV+6o1BlGpAdoos2CEJYC2AL1lBXWc6Ssi+gGiTEcFWOUY/QaNmF1NJ74HvVuleqxEnN7
	 zu/qb4aMh0cHyaHj+TcRDSPUSc8C+ewUqdTSIAc/PVEoXyzpS4uP/FqeFXDiotUYZXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdfZspls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45C606A326;
	Mon,  2 Nov 2026 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdfZspls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA13A1F00A16;
	Mon,  2 Nov 2026 20:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793651753;
	bh=dvVO2rNpJvTNuu02lcc9yj9nd8ebw6GqxP0aGvMJCMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hdfZsplsPzWIBETGNzE+dm1RLl33QZCz1ghJ6tDoX7zt6yOYKwwO6E9RAvfbxsSHE
	 WgHS42fPuH3ls3qLWGbiYhXVPGx3zFtkd0DdnqaMjLSVGg5uqgb4I38CfM3t4kGiN1
	 ipKt36zcPi8DRGOaXVA0CikoClsoDEeVs/C1CUpdK4TsmxhEVs5rl3HSdMxiTcRjQu
	 xoIVKpJ85AvU4gxWydUL8y+6v2fb3LY1aCnSS0kCma/8XO/1AXANoHowGID4qXsC4f
	 t6FOKOH8zBc+T9vWJyLMN4agBmP2MDGSJnwtk7ADmjzdm4nQNIUPkFM19OQvelfs+D
	 mp7nOinjfSjag==
Date: Mon, 2 Nov 2026 20:35:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: sergiu.cuciurean@analog.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add lltc,ltc2387
Message-ID: <20261102-pursuant-collide-4246c955efef@spud>
References: <20261030-scientist-puzzle-ab2c668b6e27@spud>
 <20261102081110.63080-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RY2oGnwwwn5GkflT"
Content-Disposition: inline
In-Reply-To: <20261102081110.63080-1-Nicolae-daniel.Deaconescu@analog.com>

--RY2oGnwwwn5GkflT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 10:11:10AM +0200, Nicolae-Daniel Deaconescu wrote:
> On Fri, 30 Oct 2026 20:50:11 +0000, Conor Dooley wrote:
> > On Fri, Oct 30, 2026 at 02:02:05PM +0200, Nicolae-Daniel Deaconescu wro=
te:
> > > On Tue, Oct 27, 2026 at 18:28:34 +0000, Conor Dooley wrote:
> > > > Why are we getting new devices with linear vendor prefixes?
> > >
> > > I'll fix this in v2. The binding file will be adi,ltc2387.yaml.
> > > The -x4 compatibles will also be dropped, because they described
> > > four devices sharing one AXI ADC.
> >
> > Please retain more context than this, it's not enough to just have what
> > you're replying to. I see so many patches that I will have completely
> > forgotten what you're doing by the time I get to the next day.
>=20
> My bad, I'll keep more relevant info in my responses from now on.
>=20
> > > > Hmm, ltc2387-16 does not appear to have these signals?
> > > > Well, it has "cnv" but "cnv" has "sample clock" as the input name s=
o is
> > > > the clocks property above and pwm-clock can be used if the provider=
 is a
> > > > pwm?
> > >
> > > The LTC2387-16 datasheet has these pins: CNV+/CNV- (pins 27/28), which
> > > is the conversion-start input; CLK+/CLK- (pins 23/24), which is an
> > > externally applied clock that shifts out the result; and DCO+/DCO-,
> > > the echoed clock. There is no clk_gate pin.
> >
> > Then there should not be a clk_gate pwm for this device.
> >
> > > The part needs a burst of 8 CLK pulses per conversion in one-lane mode
> > > (4 in two-lane), starting t_FIRSTCLK =3D 65 ns after CNV and ending
> > > within t_LASTCLK =3D 49 ns of the next CNV. So the CLK input cannot r=
un
> > > freely: the clk_gate PWM gates the host clock into that burst. [...]
> > > The clocks property is the reference clock the PWM generator runs
> > > from, and the driver needs its rate to compute the waveforms.
> >
> > Then you've got a "layering" violation of some kind here. If this clock
> > is consumed by the PWM generator, it should be an input to the pwm
> > generator not this adc.
>=20
> It IS an input to the PWM generator, The ADC node references the same
> clock only because the driver has to know its rate to compute the CNV
> and CLK waveforms in clock cycles. adi,ad7625.yaml does the same.

Then modify the PWM API to get the information that you need, you should
not be constructing fake relationships in your devicetree to work around
limitations of some subsystem's interface. If you need the information
=66rom a PWM provider for what the minimum period or duty cycle step it can
provide is so that you can use the waveform API correctly, then add that.
I took a quick look at the code you've added and it looks like it'd just
fall over as soon as someone used a PWM provider with a mandatory
divider?

Trevor got lucky that I didn't ask these questions about the ad7625, you
did not.

> > The second pwm should then just be called "clk", because that's the
> > input(s) that it represents.
>=20
> I'll rename it to "clk" in v2 and reword the pwms description. ad7625
> uses the name clk_gate for the same signal.
>=20
> > I want to see what the dts you have for a complete setup of this device
> > looks like, including the backend and pwm generator.
>=20
> This is an ADAQ23878 on a Zedboard, two-lane, with the AXI ADC backend,
> the DMA it uses, and the AXI PWM generator. The 120 MHz ext_clk is what
> the HDL provides to the PWM generator. Supplies are fixed regulators here;
> VS- is 0 V.
>=20
> / {
> 	vdd_5v: regulator-vdd-5v {
> 		compatible =3D "regulator-fixed";
> 		regulator-name =3D "vdd-5v";
> 		regulator-min-microvolt =3D <5000000>;
> 		regulator-max-microvolt =3D <5000000>;
> 		regulator-always-on;
> 	};
>=20
> 	vio_2v5: regulator-vio-2v5 {
> 		compatible =3D "regulator-fixed";
> 		regulator-name =3D "vio-2v5";
> 		regulator-min-microvolt =3D <2500000>;
> 		regulator-max-microvolt =3D <2500000>;
> 		regulator-always-on;
> 	};
>=20
> 	vs_p: regulator-vs-p {
> 		compatible =3D "regulator-fixed";
> 		regulator-name =3D "vs-p";
> 		regulator-min-microvolt =3D <5000000>;
> 		regulator-max-microvolt =3D <5000000>;
> 		regulator-always-on;
> 	};
>=20
> 	vs_n: regulator-vs-n {
> 		compatible =3D "regulator-fixed";
> 		regulator-name =3D "vs-n";
> 		regulator-min-microvolt =3D <0>;
> 		regulator-max-microvolt =3D <0>;
> 		regulator-always-on;
> 	};
>=20
> 	vref: regulator-vref {
> 		compatible =3D "regulator-fixed";
> 		regulator-name =3D "vref-4v096";
> 		regulator-min-microvolt =3D <4096000>;
> 		regulator-max-microvolt =3D <4096000>;
> 		regulator-always-on;
> 	};
>=20
> 	clocks {
> 		ext_clk: clock@0 {
> 			#clock-cells =3D <0>;
> 			compatible =3D "fixed-clock";
> 			clock-frequency =3D <120000000>;
> 		};
> 	};
> };
>=20
> &fpga_axi {
> 	rx_dma: dma-controller@44a30000 {
> 		compatible =3D "adi,axi-dmac-1.00.a";
> 		reg =3D <0x44a30000 0x1000>;
> 		#dma-cells =3D <1>;
> 		interrupts =3D <0 57 IRQ_TYPE_LEVEL_HIGH>;
> 		clocks =3D <&clkc 15>;
> 	};
>=20
> 	axi_adc: adc@44a00000 {
> 		compatible =3D "adi,axi-adc-10.0.a";
> 		reg =3D <0x44a00000 0x10000>;
> 		dmas =3D <&rx_dma 0>;
> 		dma-names =3D "rx";
> 		clocks =3D <&clkc 15>;
> 		#io-backend-cells =3D <0>;
> 	};
>=20
> 	axi_pwm_gen: pwm@44a60000 {
> 		compatible =3D "adi,axi-pwmgen-2.00.a";
> 		reg =3D <0x44a60000 0x1000>;
> 		#pwm-cells =3D <3>;
> 		clocks =3D <&clkc 15>, <&ext_clk>;
> 		clock-names =3D "axi", "ext";
> 	};
>=20
> 	adc@0 {
> 		compatible =3D "adi,adaq23878";
> 		clocks =3D <&ext_clk>;
> 		io-backends =3D <&axi_adc>;
> 		pwms =3D <&axi_pwm_gen 0 0 0>, <&axi_pwm_gen 1 0 0>;
> 		pwm-names =3D "cnv", "clk";
> 		vdd-supply =3D <&vdd_5v>;
> 		vio-supply =3D <&vio_2v5>;
> 		vref-supply =3D <&vref>;
> 		vs-n-supply =3D <&vs_n>;
> 		vs-p-supply =3D <&vs_p>;
>=20
> 		adi,gain-milli =3D /bits/ 16 <870>;
> 		adi,use-two-lanes;
> 	};
> };
>=20
> One more thing, on the cover letter Andy asked whether this should be
> done in an existing driver with per-compatible chip data instead.

Dunno, don't care. How the drivers are written has nothing to with me :)

Cheers,
Conor.

--RY2oGnwwwn5GkflT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauj0JAAKCRB4tDGHoIJi
0luKAQCR7NOOLzEZxK+88wBVi3I3guik+ZdYa1djbktQp85UlQEAqPRERobzPurB
BYQdqJLzZj8eUCOik998InmtwzMqbgs=
=kvR3
-----END PGP SIGNATURE-----

--RY2oGnwwwn5GkflT--
