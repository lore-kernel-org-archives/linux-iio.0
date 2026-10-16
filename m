Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254044BC97;
	Fri, 16 Oct 2026 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792191763; cv=none; b=ph30J4uJMFYcypVpFCBP5DD1RJMshprU7npTvN4FW+lhYCyDckVYEUa9yG7qxcstK5Fh++YOP2mh5xDezuiRjSPplnmUWj3XcyzFF/APrHbN1EHXsgje8JqA3HibL9um5KV4Li1AnyRNyxa7/hpfAR+kNVriiYYiQMAm5rmbw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792191763; c=relaxed/simple;
	bh=n3ty2ZyvDzwgUhYeZDEYtUwS66NH+nc/7eGrAnKN6Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrTKyFlRJ6p5AXFN8++jGpJ2ymvdmPeqAxAO6bIAGQQUFYZBarDWYn7XuOut28Cpjkew0BYyu0Q3u977zCFrAnOtCvWmJqoTZ04jV6m+I767Ezsi9jgJBS+jmjXK59oKFzjkIxNo7Mq5VXC2dmyzZ6eJowhLv2wlzA4ecWksWjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkhsbZVd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkhsbZVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A271F000C4;
	Fri, 16 Oct 2026 23:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792191761;
	bh=gDPFJsipEFwmkLMvZylTLQTQ9ctAuVaoBrxo7YA/QQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JkhsbZVdvnNuIM7WsGZ0/7PEHhrq+DG1SJQiCJizHg/uQz9g5JYHV8M9lIGHU15N9
	 XYW0hdXgiTJyiCxrgrw4ZCjTFOZB+GtYgFgUUwFhRi5m0rMaPBbi8Dz35opMMVZ5lI
	 wdbB0XZXpOcL2WDxHBFKFcstuqd7wNRfjnqpC94PsZztqCDkz64RsQVRoq47cyGjK3
	 GJqb30hhGnnAb+q4rBPlS6JLxAy36Dmf47cZ05F5lEHTWI6KGic7Hn8pPqm5ZV6qv+
	 4OlO1LDsVhZAxTaKUUIXEHDsk5RpZnhMOQNzU+I5nMqgjqLloJHOoIGXdSuml9PiVn
	 mEC8ywo+Lv2ng==
Date: Sat, 17 Oct 2026 00:02:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bruce Tsao via B4 Relay <devnull+bruce.tsao.analog.com@kernel.org>
Cc: bruce.tsao@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: Document Analog Devices
 AD5413 single-channel DAC
Message-ID: <20261017000233.4f929ce7@jic23-hlaptop>
In-Reply-To: <20261017-ad5413-upstream-v1-1-61f40c8fef25@analog.com>
References: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
	<20261017-ad5413-upstream-v1-1-61f40c8fef25@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Oct 2026 03:23:53 +0800
Bruce Tsao via B4 Relay <devnull+bruce.tsao.analog.com@kernel.org> wrote:

> From: Bruce Tsao <bruce.tsao@analog.com>
>=20
> Document the devicetree bindings for the Analog Devices AD5413, a
> single-channel precision DAC controlled via SPI. The device supports
> voltage or current output modes and programmable slew-rate control.
>=20
> Signed-off-by: Bruce Tsao <bruce.tsao@analog.com>
Hi Bruce,

Welcome to IIO.

> ---
>  .../devicetree/bindings/iio/dac/adi,ad5413.yaml    | 101 +++++++++++++++=
++++++
>  1 file changed, 101 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5413.yaml b/=
Documentation/devicetree/bindings/iio/dac/adi,ad5413.yaml
> new file mode 100644
> index 000000000000..74e869304aab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5413.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5413.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5413 DAC
> +
> +description:
> +  Analog Devices AD5413 is a single-channel precision DAC supporting vol=
tage
> +  or current output modes with programmable slew-rate control.
> +  The output mode is selected via the adi,chan-current-mode property.
> +  Optional reset GPIO may be provided.

New line per sentence isn't really adding anything. I'd reflow this
a a paragraph.

> +
> +maintainers:
> +  - bruce.tsao@analog.com
> +
> +properties:
> +  compatible:
> +    const: adi,ad5413
> +
> +  spi-max-frequency:
> +    maximum: 50000000
> +
> +  spi-cpha: true
> +
> +  spi-cpol: false
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Optional reset GPIO (active low).
=46rom a quick glance looks like we also have LDAC SYNC and FAULT.
+ a reference out that probably wants to be modeled as a supply.

Upshot is this looks like an incomplete binding and generally=20
we try to make them as complete as possible from the start, even
if the driver doesn't yet use everything.

> +
> +  avdd-supply:
> +    description: Analog positive supply (AVDD)
> +
> +  dvdd-supply:
> +    description: Digital positive supply (DVDD)
> +
> +  avss-supply:
> +    description: Analog negative supply (AVSS)
> +
> +  adi,chan-current-mode:
> +    type: boolean
> +    description: Select current output mode. If absent, voltage mode is =
used.

We have some existing dt bindings for multi mode channels on adi
parts. See adi,ch-func in various other bindings.
Whilst we've had various discussions about generalizing that to
a generic dac binding so far we haven't done so. Maybe now is the time...


> +
> +  adi,slew-time-us:
> +    description: Output digital slew control time in microseconds
> +    minimum: 0
> +    maximum: 1000000
> +    default: 0
> +
> +required:
> +  - compatible
> +  - spi-cpha
> +  - avdd-supply
> +  - dvdd-supply
> +  - avss-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dac@0 {
> +            compatible =3D "adi,ad5413";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +            spi-cpha;
> +            reset-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW>;
> +            avdd-supply =3D <&avdd>;
> +            dvdd-supply =3D <&dvdd>;
> +            avss-supply =3D <&avss>;
> +            adi,slew-time-us =3D <125>;
> +        };
> +    };
> +
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dac@0 {
> +            compatible =3D "adi,ad5413";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +            spi-cpha;
> +            avdd-supply =3D <&avdd>;
> +            dvdd-supply =3D <&dvdd>;
> +            avss-supply =3D <&avss>;
> +
> +            adi,chan-current-mode;
> +        };
> +    };
>=20

