Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A014AD0D;
	Sat, 21 Mar 2026 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774094892; cv=none; b=uy98I11RF66MaAlWMbf2/AfGVmlVOvAIfFAJS5Kj6lYk9tfyc710EX84RE9jvgBeFrqntA4pGh1wzZ86i19xFG/2Z09SF6tle9nDMBH+ykn+iaZSdiMR+1Dlk/1N0WaAmydNiU3XaD+YkvIjKIxoTzNIHzlxUEx+x9WH7pFgJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774094892; c=relaxed/simple;
	bh=O62baZvxNhe+sJSdkpCx72Bx7qKxI6OfZmOANLtTUKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzaQ0dTLTQI8PFD/oDcPfos308011cxen7SmZsH2S/GvAaLj9SzWTXxNxanNHW3IJ8ThyPSlS6LcduyDB5zjMqJKfggpToOpnMpNZjUFGzl5/QiwXjHFNAXwM7hy2EVe/EMVYB/dLRaMgfZFdQnLGCPGu9mZe8MLwvtQ1rGPmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQvusTJN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQvusTJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656E4C19421;
	Sat, 21 Mar 2026 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774094891;
	bh=O62baZvxNhe+sJSdkpCx72Bx7qKxI6OfZmOANLtTUKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQvusTJN/lUNR/JDipbiPGE1vAKJG30Di8OMHy9/pgIGKsevbgt6coMe22e1IrCjB
	 591oipvMC8rpFKFt/e87a0U/Bbmj1lrwGp20xInI4PjdInPCWEsWGvtrvWnJlF9sxo
	 tDyhkrHpmmhanwCpHKai+B6WydslIsVNwtVBL4jloqCOzwpYpRt6a6GjBz9OJ9pojI
	 B6dUo0+9zIVYqRgheqIRepE6K7eD7NNW/bVHz/Iw6K7z9rng+DFaTVQwCWtBBuZBdx
	 VDcWeova5vdfuHdlzNoWxOtIibSn8K4QCH+iYPev9Xnr3TuE8jNT2bB6sYgiuP796v
	 8txARIS7/fGlg==
Date: Sat, 21 Mar 2026 12:08:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/4] dt-bindings: iio: adc: ad4080: add AD4880
 support
Message-ID: <20260321120802.391cafd0@jic23-huawei>
In-Reply-To: <20260321100154.1258-4-antoniu.miclaus@analog.com>
References: <20260321100154.1258-1-antoniu.miclaus@analog.com>
	<20260321100154.1258-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Mar 2026 12:01:53 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
> with integrated fully differential amplifiers (FDA).
>=20
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. This requires:
> - Two entries in reg property for primary and secondary channel
>   chip selects
> - Two io-backends entries for the two data channels
=46rom the v6 discussion.  I'd just like to know a little more on this.
Are they really separate backends?

Given discussion about interleaved data, I was kind of assuming they
were different front end interfaces to a single backend IP.

The freedom this binding is giving is for those two backends to be
completely unrelated. I'm not sure if we want that.

Jonathan


>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v7:
>   - No changes
>=20
>  .../bindings/iio/adc/adi,ad4080.yaml          | 53 ++++++++++++++++++-
>  1 file changed, 51 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> index ccd6a0ac1539..0cf86c6f9925 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> @@ -18,7 +18,11 @@ description: |
>    service a wide variety of precision, wide bandwidth data acquisition
>    applications.
> =20
> +  The AD4880 is a dual-channel variant with two independent ADC channels,
> +  each with its own SPI configuration interface.
> +
>    https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
4080.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
4880.pdf
> =20
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
> =20
> @@ -31,9 +35,15 @@ properties:
>        - adi,ad4084
>        - adi,ad4086
>        - adi,ad4087
> +      - adi,ad4880
> =20
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      SPI chip select(s). For single-channel devices, one chip select.
> +      For multi-channel devices like AD4880, two chip selects are requir=
ed
> +      as each channel has its own SPI configuration interface.
> =20
>    spi-max-frequency:
>      description: Configuration of the SPI bus.
> @@ -57,7 +67,10 @@ properties:
>    vrefin-supply: true
> =20
>    io-backends:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: Backend for channel A (primary)
> +      - description: Backend for channel B (secondary)
> =20
>    adi,lvds-cnv-enable:
>      description: Enable the LVDS signal type on the CNV pin. Default is =
CMOS.
> @@ -78,6 +91,25 @@ required:
>    - vdd33-supply
>    - vrefin-supply
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad4880
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +        io-backends:
> +          minItems: 2
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +        io-backends:
> +          maxItems: 1
> +
>  additionalProperties: false
> =20
>  examples:
> @@ -98,4 +130,21 @@ examples:
>            io-backends =3D <&iio_backend>;
>          };
>      };
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +          compatible =3D "adi,ad4880";
> +          reg =3D <0>, <1>;
> +          spi-max-frequency =3D <10000000>;
> +          vdd33-supply =3D <&vdd33>;
> +          vddldo-supply =3D <&vddldo>;
> +          vrefin-supply =3D <&vrefin>;
> +          clocks =3D <&cnv>;
> +          clock-names =3D "cnv";
> +          io-backends =3D <&iio_backend_cha>, <&iio_backend_chb>;
> +        };
> +    };
>  ...

