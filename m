Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68C3C6A2B;
	Fri, 24 Apr 2026 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033318; cv=none; b=lT/9JeX2qMfBMP5+kG9+WaSTNv31gOjZKzlKgZG1vOTJWt7SBVwsk5b2dDFlo1hrRXRaMUo11eWuaFKB9pcl86yYgDPcKxAVknJgKBs2xHPFYKZYRvuXbhBYVuZ5pI5r2/WKtJ3hmZaoX5pZ9AprdoOi99ygdr4WdUUr7F2kWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033318; c=relaxed/simple;
	bh=O0C1+D+c5s76j7er/ncHDcIHnKTNDMbgtllEWQlHPO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2g9NXRqRac9U8P6AznZktX/IMIIXQD2uoQKtU7hfE3EeBlFBHrkGlbWm5BVHAwXTJI3e3fwxrPErKPEUfIOO5kjs/7DxXLO/uSXrX9zp5i0Yivg+gXl36bJep/TaDclh7vVz5luoD0lIdWK67C+fuxjA0Hr15ts49N9CNAB1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsEK0/BW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsEK0/BW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D378DC2BCB5;
	Fri, 24 Apr 2026 12:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777033318;
	bh=O0C1+D+c5s76j7er/ncHDcIHnKTNDMbgtllEWQlHPO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GsEK0/BWNo6h8gpUenqiNprqpw8Endo5YZM0iluqXM3vj4mvOYkKhgbcTHOp3P1w1
	 bRh9NmtVarRr5SZifWpKs3PqRCc/WzotMVtipGD+MJw2bv1n+UReeP7wCVa6FolyvE
	 OcaNhL7yfZ1RQ4vK+VkzINdhbtwnS2QQBb3nxFleItZZEMuEiNsmNpLuF1Lhh+Dvon
	 0KHouxdCGtuM+cJ9uNSB3Y7nxWmS47RM2SaWJ4lHf33jq5brri/XrzmTug6Puxxl8t
	 g1j/zwI2eJbM7G0OglgJzMiVF8u6gY/uJd0eZC9vt0Xa1d/yvdzeB7oKj4zHWwHi0T
	 gn1Ky0pQzj9Cg==
Date: Fri, 24 Apr 2026 13:21:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, ak@it-klinger.de,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: avia-hx711: add
 avia,hx710b compatible
Message-ID: <20260424132148.69e63bbe@jic23-huawei>
In-Reply-To: <CAMB+xkZ_FypL9_pYiE9nEoyaGxzc7_vdAzb-FgKEeXok0_fi1w@mail.gmail.com>
References: <20260419174654.683692-1-piyushpatle228@gmail.com>
	<20260419174654.683692-2-piyushpatle228@gmail.com>
	<20260421-heavy-amigurumi-badger-c7ef9f@quoll>
	<CAMB+xkZ_FypL9_pYiE9nEoyaGxzc7_vdAzb-FgKEeXok0_fi1w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Apr 2026 11:32:56 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> On Tue, Apr 21, 2026 at 1:53=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On Sun, Apr 19, 2026 at 11:16:39PM +0530, Piyush Patle wrote: =20
> > >  description: |
> > > -  Bit-banging driver using two GPIOs:
> > > -  - sck-gpio gives a clock to the sensor with 24 cycles for data ret=
rieval
> > > -    and up to 3 cycles for selection of the input channel and gain f=
or the
> > > -    next measurement
> > > -  - dout-gpio is the sensor data the sensor responds to the clock
> > > +  The HX711 is a 24-bit ADC with selectable gain (32/64/128) and two
> > > +  differential input channels. Channel A supports gain 64 and 128;
> > > +  channel B supports gain 32.
> > >
> > > -  Specifications about the driver can be found at:
> > > -  http://www.aviaic.com/ENProducts.aspx
> > > +  The HX710B is a 24-bit ADC with fixed gain of 128. Channel 0 is the
> > > +  differential input and channel 1 measures the DVDD-AVDD supply
> > > +  voltage difference.
> > >
> > >  properties:
> > >    compatible:
> > >      enum:
> > > +      - avia,hx710b
> > >        - avia,hx711
> > >
> > >    sck-gpios:
> > > @@ -40,13 +40,45 @@ properties:
> > >
> > >    avdd-supply:
> > >      description:
> > > -      Definition of the regulator used as analog supply
> > > +      Analog supply voltage (AVDD). Also serves as the voltage refer=
ence on
> > > +      both chips; no separate vref-supply is required. =20
> >
> > There is no such thing as vref-supply.
> > =20
> > > +
> > > +  dvdd-supply:
> > > +    description:
> > > +      Digital supply voltage (DVDD). HX711 only.
> > > +
> > > +  vsup-supply:
> > > +    description:
> > > +      Supply voltage for the on-chip regulator (VSUP). HX711 only.
> > > +
> > > +  rate-gpios:
> > > +    description:
> > > +      GPIO connected to the RATE pin (HX711 only). When driven low t=
he
> > > +      output data rate is 10 SPS; when driven high it is 80 SPS. If
> > > +      omitted the RATE pin state is determined by the board wiring.
> > > +    maxItems: 1
> > >
> > >    clock-frequency:
> > > +    description:
> > > +      Controls the SCK bit-bang timing. The value is used to derive =
the
> > > +      delay between SCK edges; keep the SCK high time below 60 us to
> > > +      avoid triggering chip power-down mode. Defaults to 400 kHz if =
not
> > > +      specified. =20
> >
> > Don't repeat constraints in free form text. Drop last sentence.
> > =20
> > >      minimum: 20000
> > >      maximum: 2500000
> > >      default: 400000
> > >
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          const: avia,hx710b
> > > +    then:
> > > +      properties:
> > > +        vsup-supply: false
> > > +        dvdd-supply: false
> > > +        rate-gpios: false
> > > +
> > >  required:
> > >    - compatible
> > >    - sck-gpios
> > > @@ -58,10 +90,19 @@ additionalProperties: false
> > >  examples:
> > >    - |
> > >      #include <dt-bindings/gpio/gpio.h>
> > > -    weight {
> > > +    weight0 { =20
> >
> > Don't change the node names.
> > =20
> > >          compatible =3D "avia,hx711";
> > >          sck-gpios =3D <&gpio3 10 GPIO_ACTIVE_HIGH>;
> > >          dout-gpios =3D <&gpio0 7 GPIO_ACTIVE_HIGH>;
> > > +        rate-gpios =3D <&gpio0 9 GPIO_ACTIVE_HIGH>;
> > >          avdd-supply =3D <&avdd>;
> > >          clock-frequency =3D <100000>;
> > >      };
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +    weight1 {
> > > +        compatible =3D "avia,hx710b";
> > > +        sck-gpios =3D <&gpio3 11 GPIO_ACTIVE_HIGH>;
> > > +        dout-gpios =3D <&gpio0 8 GPIO_ACTIVE_HIGH>;
> > > +        avdd-supply =3D <&avdd>; =20
> >
> > Why no clock-frequency? So basically difference is one property? Then no
> > need for new example, less code to maintain.
> >
> > But OTOH, where is vsup and dvdd? =20
>=20
> dvdd-supply and vsup-supply are optional HX711 properties and
> arenot present on all boards (e.g. DVDD tied to AVDD or use of the
> on-chip regulator without a separate supply node).

For DVDD tied to AVDD as a board config (rather than internally)
both would ideally be set to the same regulator rather than just
not mentioning that tie.   The other case of it not being connected
is valid.

> The example shows a minimal working configuration.
>=20
> I will remove the example for HX710B.
> > =20
> > > +    };
> > > --
> > > 2.43.0
> > > =20
>=20
> Thanks for the review.
>=20
> I'll fix the schema issues you pointed out in v3
> Will share v3 shortly
>=20
> Regards
> Piyush Patle

