Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795023591;
	b=QjA0El+KIdLq2wSHv4AMSgw7ZyNbRa9U3uFjIyrn+ZqydIn4Kztj2Hf4rFrW7lvv3Pkl
	 uadwXAgQTrnLaD2OYbnPAXZshaaUnPulDpQ7zK4jqNZFyo350qFeYDtYF12c71YOUmVkj
	 QO0sJ11PNUJaJYztF7O04/SNvnTK5CQyCDRlYEV6asAAe4dQrtURQdkL3ewxS9mlaC7sO
	 mYUI4jztKYJ98rqGESFe1MQhbjOeEyqYhp6KzLCjeKGgKXlPiBc2ddb7cA+lE19kyUGsh
	 VQaVZg4eWZ1WLFkUwuHlpP8LUh0Fn+5z5Os72NuXQzdMQFgZsKked0c7rXelf0uq5uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023591;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GXgX0kwAKKbNvo3NPPaYNQlo5gTekPgN9S8xFmR9pC4=;
	b=UUxm3Kp0MC1nZSPPMtGe8nxD5FaL3oj6uZjgNpia/+hrkhG/jXdApt3PlCD8cPKyQFC4
	 luehYVz0vbOTykaPrK2zZ07Fxj0JT77pLZrBXEp7WUsLzcWSear2bXj8w1bjhNBgYSflT
	 Wbq2moplHmy7u5kby08aBiLLoI+urR4XxaJR3yNtEQm1asaS6b13usYGi13sMetPEpIiJ
	 uYddhfeqeEtH6j89sL4BiMnH3DDYtgDXYFoedqzWeGDMqDqxbX6JdK9WFl03kVi8f1R6u
	 tWPGGFp82NPqLuwh+JsDvM2vj5p//s4R+CCGXIHMKhZ7dar51/B9ZrVtCdQNh44HIPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MgL+/cDE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20537606A325;
	Wed, 18 Nov 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgL+/cDE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FEA1F000C5;
	Wed, 18 Nov 2026 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795023591;
	bh=GXgX0kwAKKbNvo3NPPaYNQlo5gTekPgN9S8xFmR9pC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MgL+/cDEI6lfuLt6Bm1sQe72ACFlWQSD+tf9hUPzKJa5oqr5YkbI01+tZs8L9YkL6
	 EgAwoHqmqYCdRpmnOeU3yzui3vCpvV6RyTnz+zO9y4JzOJ2kbXnhfol+H22IyP/Pyt
	 8BpcPlNmgLo41dH5W6dLoaJfkEs6MMBVEDvxH416CALTsNR0Heud4hf/EpZK5gaWBP
	 Gxw4ZyrgB1F30IwE2SZbPyHOPcPYAb1ToDQdkq8XCTsriwOZBk02CpBSEV8rjffthK
	 RGRq7PnvX9b6z+L7aU6KjNsvz3X8X+W4A98OoIn+8AeALOaJMj7fH64/DEihZSi9nE
	 iPNB1Wk97+HGQ==
Date: Wed, 18 Nov 2026 17:39:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	Michael.Hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	olivier.moysan@foss.st.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 4/5] dt-bindings: iio: adc: Add ADA4355
Message-ID: <20261118-liver-decompose-434eedb257b8@spud>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
 <c7be62089d2b54dbf7fb57cdea189bdb1cade7c5.1795003864.git.marcelo.schmitt@analog.com>
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
	protocol="application/pgp-signature"; boundary="7KeiSr613VEX3nr7"
Content-Disposition: inline
In-Reply-To: <c7be62089d2b54dbf7fb57cdea189bdb1cade7c5.1795003864.git.marcelo.schmitt@analog.com>

--7KeiSr613VEX3nr7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 10:04:13AM -0300, Marcelo Schmitt wrote:
> The ADA4355 is an integrated analog front-end and 14-bit analog-to-digital
> converter with a serial LVDS data interface.
>=20
> Document how to describe ADA4355 devices in device tree.

Please explain why the 4356 differs rom the 4355 such that it cannot use
a fallback compatible.

Thanks,
Conor.
pw-bot: changes-requested
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../bindings/iio/adc/adi,ada4355.yaml         | 104 ++++++++++++++++++
>  MAINTAINERS                                   |   7 ++
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ada4355=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml b=
/Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
> new file mode 100644
> index 000000000000..d169619fef25
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ada4355.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices Transimpedance Current to Bits Receiver
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  ADA4355 programmable transimpedance, current to bits receiver and simi=
lar data
> +  converters.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ada4355.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ada4356.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ada4355
> +      - adi,ada4356
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 50000000
> +
> +  spi-3wire: true
> +
> +  spi-cpha: true
> +
> +  vcc-supply:
> +    description: 3.3V power supply.
> +
> +  vea-supply:
> +    description: 1.8V analog power supply to ADC.
> +
> +  ved-supply:
> +    description: 1.8V digital power supply to ADC.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  adi,vld-en-gpios:
> +    description: GPIO connected to the VLDEN pin for VLD output enable.
> +
> +  adi,gsel-gpios:
> +    description:
> +      GPIOs connected to the GSEL0 and GSEL1 pins, in that order, for
> +      transimpedance gain selection.
> +    minItems: 2
> +    maxItems: 2
> +
> +  adi,lfp-gpios:
> +    description:
> +      GPIO connected to FSEL for internal low pass filter bandwidth sele=
ction.
> +
> +  io-backends:
> +    description:
> +      The AXI ADC IP block connected to the D+/- and DCO+/- lines of the
> +      ADC. An example backend can be found at
> +      http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.h=
tml.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +  - spi-3wire
> +  - spi-cpha
> +  - clocks
> +  - adi,vld-en-gpios
> +  - adi,gsel-gpios
> +  - adi,lfp-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,ada4355";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <100000>;
> +            spi-3wire;
> +            spi-cpha;
> +            vcc-supply =3D <&supply_3_3V>;
> +            clocks =3D <&ref_clk>;
> +            adi,vld-en-gpios =3D <&gpio0 89 GPIO_ACTIVE_HIGH>;
> +            adi,gsel-gpios =3D <&gpio0 86 GPIO_ACTIVE_HIGH>,
> +                             <&gpio0 87 GPIO_ACTIVE_HIGH>;
> +            adi,lfp-gpios =3D <&gpio0 88 GPIO_ACTIVE_HIGH>;
> +            io-backends =3D <&axi_adc>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 02015eaec312..692f1e6d56ec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1794,6 +1794,13 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
>  F:	drivers/iio/amplifiers/ada4250.c
> =20
> +ANALOG DEVICES INC ADA4355 DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
> +
>  ANALOG DEVICES INC ADE9000 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
> --=20
> 2.39.2
>=20

--7KeiSr613VEX3nr7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3i4QAKCRB4tDGHoIJi
0lGIAPwL9Ok5CfhDaHPz6PfDM55YstB+pHs1BtlXH5AZpuz9hQEA5xfUN54c7i+w
8XAvs4w2rW37d7epckopz1ZegBBy1QA=
=iCcF
-----END PGP SIGNATURE-----

--7KeiSr613VEX3nr7--
