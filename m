Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6203B19DF;
	Fri,  3 Apr 2026 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775215983; cv=none; b=Ik5SykWV44Yc+99e9TbV2ptYg77m9YGMQe+NAKHVbwhmkBWtOvMg/ZFi0+9ej7O88SKnX4Oo9KplU63838UnncV2X34VSQlZsrF+0j0vFKzk/tBU9kS7Q0hpZ05G22yVfhOjnHDcBdsWu52XgePQIj/6n4G2fk7kJLlVmUoBiEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775215983; c=relaxed/simple;
	bh=+JMJ99NNf/tBQ9aCddtjSOpZJQuBIAytCzzKT8IbGYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sP0JpFYCdRcDHJ0+4w4aMCnmCHgpW2ejJ8kliJ3xmFPfw8ZtZHPMJ4emcPZCp5+/WaWAJmf2+iZ8PbfTGlbNxneo4T+GLFnUj6ww0Zj9/luFlUoFu1hZFJZvJWsCwKaib8ghpYWo8Fmo6yhDD0EOVIHdwHGAfZOj61KOhsoIHqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+CdTjWQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+CdTjWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29F7C4CEF7;
	Fri,  3 Apr 2026 11:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215982;
	bh=+JMJ99NNf/tBQ9aCddtjSOpZJQuBIAytCzzKT8IbGYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+CdTjWQfzbh/WjG9ryS2QS4p8TnjzMngWVPhwHKHMFm4NNJO5ZPx8ITMDcJ7VrN8
	 hCi3D7ZA+BcVT9j2+x742RPukKIrzraCGI7GzbUDOMq5iO6+NXfzuen+HmFiCBEHsE
	 p1DAl+V+aCy8aYljfuxK0PUxTPkgQusCnuevd+MB3fcrpCIrVn4PPzUCLDnZQ/OlFU
	 jy9BLgWmZF138k+QwNMLgaABtewk9+WrWYO2fMNWPOPm2VEx0ZnZMvS32wObOn079r
	 Bh0ti9RG+Ked+c594tONbBjVJ8s9OVDVQvcbcEdBHnV87LWjxc09/QdKGk25ePQjGO
	 XJ+g22CvU8MPw==
Date: Fri, 3 Apr 2026 12:32:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02 to MCP47FEB02
Message-ID: <20260403-speed-childless-1360de358229@spud>
References: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
 <20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SJQHdSZLrb0beuMA"
Content-Disposition: inline
In-Reply-To: <20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com>


--SJQHdSZLrb0beuMA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2026 at 01:50:13PM +0300, Ariana Lazar wrote:
> This is the device tree schema for iio driver for Microchip
> MCP48FxBy1/2/4/8 series of buffered voltage output Digital-to-Analog
> Converters with nonvolatile or volatile memory on top of MCP47FEB02.
> The families support up to 8 output channels and have 8-bit, 10-bit or
> 12-bit resolution.
>=20
> The I2C (MCP47F(E/V)BXX) and SPI (MCP48F(E/V)BXX) DAC families were merged
> into the same dt-binding file.
>=20
> Fixes: 4ba12d304175 ("dt-bindings: iio: dac: adding support for Microchip=
 MCP47FEB02")
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> Link: https://lore.kernel.org/all/20260216-shiny-itunes-00a31d1f4db7@spud/

The fixes tag here is not appropriate, you didn't do anything wrong
originally*, this just adds new devices.

*other than the channel number thing, but that should be handled in
isolation I think, if my read on the rationale for your change is
correct.

> ---
>  .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 291 +++++++++++++++=
------
>  MAINTAINERS                                        |   1 -
>  2 files changed, 217 insertions(+), 75 deletions(-)

>    reg:
>      maxItems: 1
> =20
> +  spi-max-frequency:
> +    maximum: 10000000
> +
>    "#address-cells":
>      const: 1
> =20
> @@ -111,7 +172,7 @@ properties:
>          - for single-channel device: Vout0;
>          - for dual-channel device: Vout0, Vout1;
>          - for quad-channel device: Vout0, Vout2;
> -        - for octal-channel device: Vout0, Vout2, Vout6, Vout8;
> +        - for octal-channel device: Vout0, Vout2, Vout4, Vout6;
> =20
>    vref1-supply:
>      description: |
> @@ -141,7 +202,7 @@ properties:
>      description:
>        Enable buffering of the external Vref/Vref0 pin in cases where the
>        external reference voltage does not have sufficient current capabi=
lity in
> -      order not to drop it=E2=80=99s voltage when connected to the inter=
nal resistor
> +      order not to drop its voltage when connected to the internal resis=
tor
>        ladder circuit.
> =20
>    microchip,vref1-buffered:
> @@ -149,7 +210,7 @@ properties:
>      description:
>        Enable buffering of the external Vref1 pin in cases where the exte=
rnal
>        reference voltage does not have sufficient current capability in o=
rder not
> -      to drop it=E2=80=99s voltage when connected to the internal resist=
or ladder
> +      to drop its voltage when connected to the internal resistor ladder
>        circuit.
> =20
>  patternProperties:
> @@ -161,8 +222,7 @@ patternProperties:
>      properties:
>        reg:
>          description: The channel number.
> -        minItems: 1
> -        maxItems: 8
> +        maxItems: 1

Why is this changing? Was it originally a mistake and what you wanted
was a max of 8 but only one entry?

> =20
>        label:
>          description: Unique name to identify which channel this is.
> @@ -178,6 +238,13 @@ required:
>    - vdd-supply

--SJQHdSZLrb0beuMA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCac+laQAKCRB4tDGHoIJi
0qadAP9pXU2gvfHazaJWnQyst7lQFzTkL00VtheOBJ7MwGfClwD/Zl9zwMxr980P
IwnxV6Wc1l79OffqicYnMQJ0Q57IeQ8=
=3+v5
-----END PGP SIGNATURE-----

--SJQHdSZLrb0beuMA--
