Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052F5237A3;
	Tue,  8 Sep 2026 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891241; cv=none; b=RTynaY2DUCKZvYCMqZ1jCMGAXT9C2kiH8QVSPN3rq3M4k5WSowSpT0kLS6rPJ+hDwHzuaJ8+Ne+WkJj0MYBCKsk+IP8HEKNiWlDJbI1+h+R2CA8e0G5asAckSADNw01g0tl5j4XpNt3xteZNg2HPeGd/iQiFmW47BlmwhwPPng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891241; c=relaxed/simple;
	bh=NtFrhtnuyp69Nnab2ROizhRWavl4dBjWerLBkeZiofU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e30L9qcgZZKSESQz5xYlYk23oXyvp+3KG9LJ4b66O2i1VXttVY/foVrUmN941vDzYpH+Up7FtOzSHe8W7rIN9etmP5GpVk3NNl2NZ+M2+AszeUnsYT2BnTFUMPVBn2xPhHrW6xoWL3M5TmjvCM7ogZOkmkSNzgFuFJsQ2JicOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL0qIjiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL0qIjiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAA81F00AC4;
	Tue,  8 Sep 2026 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891239;
	bh=gFVchvThcD9Eo80lfIVILhQiw5GiMArAqLZas0is2C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dL0qIjiIiO2Z65blxOAZ5PLcNAUleggM0+g5WhUv8JbTaOY6AriakINDHgTS+Icej
	 6l5p5GRjRMw5+LFooAX7LXnzrQYVRwfhNnKKlsBMoxf+nyewxZGM6w+QCZizmwuXX9
	 ukk7n76pYfupPF5GsiZBcLrtNK5DNQq9Wh6NSorTHXo8I7tC78WGkw5KOgJkvuREWj
	 nA370hR/Wj/ancT6kFUdKLRXL2JJpRXKh0oSPpnpuhE6bJSDALJcmteuNcK+Zt7Gkb
	 sCjxmFPrf2Q528cShMdn5iofLp6dg3XDe/du3dyK7zkeZ+5l4FYfyScEnfqCisk5Se
	 MvZzMej2fn0xQ==
Date: Tue, 8 Sep 2026 19:13:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: add as7343
Message-ID: <20260908-dinner-shelve-1d61e19ee3b7@spud>
References: <20260907210042.32552-1-marcus.yu.56@gmail.com>
 <20260907210042.32552-2-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4QRZKbOQ6hXibigH"
Content-Disposition: inline
In-Reply-To: <20260907210042.32552-2-marcus.yu.56@gmail.com>

--4QRZKbOQ6hXibigH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 02:00:41PM -0700, Chang Yu wrote:
> Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
> with i2c address of 0x39.
>=20
> The GPIO pin is described as a generic GPIO for now. Binding design for t=
he
> more advanced measurement/LED synchronization use cases are deferred to
> future patches.

Unfortunately, you can't change what you document, so picking something
correct now is needed - even if the driver doesn't use it yet.
>=20
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-=
14-Channel-Multi-Spectral-Sensor.pdf
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
> Changes in v2:
>   - Add the LDR, the interrupt pin, and the GPIO pin to the bindings.
>   - Fix node name and unit address mismatch.
>   - Include MAINTAINERS changes.
>=20
>  .../bindings/iio/light/ams,as7343.yaml        | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as734=
3.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml =
b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> new file mode 100644
> index 000000000000..b06d445b92b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/ams,as7343.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS AS7343 14-Channel Multi-Spectral Sensor
> +
> +maintainers:
> +  - Chang Yu <marcus.yu.56@gmail.com>
> +
> +description: |
> +  The AMS AS7343 is a 14-channel multi-spectral sensor with i2c address =
of 0x39.
> +  https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Chann=
el-Multi-Spectral-Sensor.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ams,as7343
> +
> +  reg:
> +    description:
> +      I2C address of the device (0x39).
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Open drain output active low interrupt pin.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  ams,led-current-microamp:
> +    description:
> +      The driver current for the external LED connected to the LDR pin.
> +    minimum: 4000
> +    maximum: 258000
> +    multipleOf: 2000
> +    default: 12000

Rather than a custom property, the tsl2772 uses led-max-microamp:
tsl2772.yaml
46:  led-max-microamp:
81:                led-max-microamp =3D <100000>;

I wonder if the same should be done here, or if there should be an leds
subnode? Perhaps the IIO folks can comment on that.

> +
> +  gpios:
> +    description:
> +      Optional GPIO pin for general I/O.

Please expand on "general IO". Docs appear to suggest this is used for
synchronisation.

Additionally, I think this name will make the gpio somewhat difficult to
request. Calling it "sync-gpios" or w/e will permit the usual gpiod
functions being used.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        multispectral-sensor@39 {
> +            compatible =3D "ams,as7343";
> +            reg =3D <0x39>;
> +            interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +            vdd-supply =3D <&vdd_regulator>;
> +            ams,led-current-microamp =3D <14000>;
> +            gpios =3D <&gpio0 6 GPIO_ACTIVE_LOW>;

Valid Sashiko comment here I believe.
pw-bot: changes-requested

Thanks,
Conor.

> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04fa5322d9f7..8cf4e1635053 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1430,6 +1430,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
>  F:	drivers/iio/light/as73211.c
> =20
> +AMS AS7343 DRIVER
> +M:	Chang Yu <marcus.yu.56@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> +
>  AMT (Automatic Multicast Tunneling)
>  M:	Taehee Yoo <ap420073@gmail.com>
>  L:	netdev@vger.kernel.org
> --=20
> 2.55.0
>=20

--4QRZKbOQ6hXibigH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaqBQYwAKCRB4tDGHoIJi
0rFTAP0UKfiCDi1ACfy0mqQe48QJpi4vQY8KmzLN4QO8JUSvJgEAznVV+tWBYXqF
Xonh23zq7OWQICdd0F9RHJi3wryHBQ8=
=7PmM
-----END PGP SIGNATURE-----

--4QRZKbOQ6hXibigH--
