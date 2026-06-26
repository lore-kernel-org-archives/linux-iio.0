Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342A1C862F;
	Fri, 26 Jun 2026 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490702; cv=none; b=r7C/3CIMcVC6Toy0lZWJ0qDhpfmJ2kUOelPDDaPfzSRTYOWU3YKs+iF/SEx5N/tYnCQDyJqT5MireuA07GHDe7f4/hP79jFvveR3oIa/DEjex9v9K7d8DYoOpxm59nu5X/6h/VMLPHSg7D1ys2+0+jmI7cnP0kPvXytnFH8B4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490702; c=relaxed/simple;
	bh=rlty3jUdWI5sS0xw0KPmccsNt5s2yEgknfvnwikxVPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJPWEmISYb4Nk/O3eUU69tvzLjc+cAzAB32TfW7AdP5x0hqUUZi0LyNICWrAGHDEucwHmw3Mj4Mys7BVVnOwqBBzu68Mt32DGulgoRy4yvNNVMcUcbeddTr2UfGKvaJf9AurVM/zWWfJQNwR5N9TdYMrEzSuXxXWPeqYGkmLlVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5zEKvkH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5zEKvkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C251F000E9;
	Fri, 26 Jun 2026 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782490701;
	bh=GP0f5OXvLpgUfyxAYV0UgbN6TxEDBKuhQnhGy5yk0Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N5zEKvkHxlbDiBz4cTLCbwB1G8l2eF5+p9Lk63ZGjKdF9fiV+uTIJz3TfzV37b0rf
	 9kwSQqTq8/yPYuZw9vl1EawIASUpgFkkD8D/WIDRVqL9+qkPqefkBGMCp6BAfJRWxt
	 40Ne1QMM/3euD4Aa7SdVN3K26u7XQ0mbHKLV4UkKJhOAEatqjrW0nDa9cWsUIsp4le
	 15r0KUcq1cmOj8aVXoumvtVfrVQhfJiyBynaEve6W270TPk5+XXFujTqT/2MIugsF1
	 gZsgzX2TuuSLN8Awc0HZJlJgo3SAaXqRYv5fDRhdtkzPBK7NvHgEv69X/2ZtAj6Dqt
	 pDBto/nvebOXQ==
Date: Fri, 26 Jun 2026 17:18:16 +0100
From: Conor Dooley <conor@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: adc: add ti,ads122c14
Message-ID: <20260626-rising-legged-dea08bb68bfe@spud>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-5-ceb9b0b561cb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ba7fx8A4nBucjtA2"
Content-Disposition: inline
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-5-ceb9b0b561cb@baylibre.com>


--Ba7fx8A4nBucjtA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 04:55:07PM -0500, David Lechner (TI) wrote:
> Add new bindings for ti,ads122c14 and similar devices.
>=20
> This is an ADC that is primarily intended for use with temperature
> sensors. There are a few unusual properties because of this. In
> particular, the reference voltage source and current output requirements
> can be different for each measurement, so these are included in the
> channel bindings.
>=20
> The REFP/REFN reference voltage is usually just connected to a resistor
> that is being driven by the ADC's current outputs, so there is special
> property for this case rather than requiring a regulator to be defined
> to represent that.
>=20
> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
> have preferred an enum of strings).
>=20
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
>=20
> v2 changes:
> * Added ti, vendor prefix when appropriate.
> * Others are now standardized properties from adc.yaml.
> * Moved top-level unevaluatedProperties.
> * Fixed some issues with the channel@ matching and reg property.
> * Dropped description on bipolar property.
> * Renamed currnet-chopping to input-channel-rotation.
> * Drop header file and use string enum instead for reference-sources.
> * Added burn-out-current-nanoamp property.
> * Drop allOf: and just use oneOf: directly.
> * Fix inconsistent indentation in the examples.
> ---
>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 205 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 211 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml =
b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> new file mode 100644
> index 000000000000..59ee4d652a08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> @@ -0,0 +1,205 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c14.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' ADS112C14 and similar ADC chips
> +
> +description: |
> +  Supports the following Texas Instruments' ADC chips:
> +  - ADS112C14 (16-bit)
> +  - ADS122C14 (24-bit)
> +
> +  https://www.ti.com/lit/ds/symlink/ads122c14.pdf
> +
> +  These chips are primarily designed for use with temperature sensors su=
ch as
> +  RTDs and thermocouples. The channel bindings reflect this in that each=
 channel
> +  represents the conditions required to make a measurement rather than s=
trictly
> +  just the physical input channels.
> +
> +maintainers:
> +  - David Lechner <dlechner@baylibre.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads112c14
> +      - ti,ads122c14
> +
> +  reg:
> +    items:
> +      - minimum: 0x40
> +        maximum: 0x47
> +
> +  clocks:
> +    maxItems: 1
> +    description: Optional external clock connected to GPIO3 pin.
> +
> +  avdd-supply: true
> +  dvdd-supply: true
> +
> +  refp-supply: true
> +  refn-supply: true
> +
> +  ti,refp-refn-resistor-ohms:
> +    description:
> +      The resistance of the external resistor between REFP and REFN when=
 using
> +      resistor bridge driven by current outputs for RTD measurements.
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: FAULT interrupt (GPIO2 pin)
> +      - description: DRDY interrupt (GPIO3 pin)
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum: [fault, drdy]
> +
> +  gpio-controller: true
> +  '#gpio-cells':
> +    const: 2
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  ^channel@[0-7a-f]$:

How does this work/what's the intention here?

0-7 I get, why a-f but not 8 or 9?

> +    $ref: adc.yaml
> +
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        items:
> +          - maximum: 15 # arbitrary limit, channel@ can be any combinati=
on of AIN0-AIN7
> +
> +      single-channel:
> +        maximum: 7
> +
> +      diff-channels:
> +        items:
> +          maximum: 7
> +
> +      bipolar: true
> +
> +      input-channel-rotation: true
> +
> +      excitation-channels:
> +        maxItems: 2
> +        items:
> +          maximum: 7
> +
> +      excitation-current-nanoamp:
> +        maxItems: 2
> +        items:
> +          enum: [1000, 10000, 20000, 30000, 40000, 50000, 60000, 70000, =
80000,
> +                 90000, 100000, 200000, 300000, 400000, 500000, 600000, =
700000,
> +                 800000, 900000, 1000000]
> +
> +      burn-out-current-nanoamp:
> +        enum: [200, 1000, 10000]
> +
> +      reference-sources:
> +        items:
> +          - enum: [internal-2.5v, internal-1.25v, external, avdd]
> +            default: internal-2.5v
> +
> +    dependencies:
> +      excitation-channels: [ excitation-current-nanoamp ]
> +      excitation-current-nanoamp: [ excitation-channels ]
> +
> +    oneOf:
> +      - required: [ single-channel ]
> +      - required: [ diff-channels ]
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible

reg?

> +  - avdd-supply
> +  - dvdd-supply
> +
> +dependencies:
> +  refn-supply: [ refp-supply ]
> +
> +oneOf:
> +  - required: [ refp-supply ]
> +  - required: [ "ti,refp-refn-resistor-ohms" ]
> +  - properties:
> +      refp-supply: false
> +      refn-supply: false
> +      ti,refp-refn-resistor-ohms: false

I assume you've tested this to make sure it enforces the behaviour that
you want?

--Ba7fx8A4nBucjtA2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj6mSAAKCRB4tDGHoIJi
0kQKAQCzm6Ngd4bmvsA0a/8j3qp8r7rd1AOC03u7TaB6+4HR5gEAl8h11GgLGanx
ZuTmKBPaz8MQVl7JwsqP6sS24J4ehAs=
=ldQ4
-----END PGP SIGNATURE-----

--Ba7fx8A4nBucjtA2--
