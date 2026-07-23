Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF33DC87B;
	Thu, 23 Jul 2026 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824866; cv=none; b=Lro6UEp367xOyPDs2L92RnzpahOAdRLC2yjotd3/xb5+BqaHRziCnWqlf8G3MLI0vvJOQDqBzifU3hyTwWy81IoagkYlv3VoRcGVGCsl4xpHCCS6ol1CET8+l8+qErrAqwL5G4k+7HlpNmqUwAiMoNOq0E2ZHxSCgauHyynCSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824866; c=relaxed/simple;
	bh=YuG0rT0lWjM5qhBg9McC2muftQTY1Zt5Q2DbXkjOnaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/oP6hyNAOaR6XkqIfQ/RodlqFJ6VtuUYfE7i0zZ+kJvLTj5TbKISSWEppae18Gpame18evb8Lk2FQKuwC6TaS7DCV6iOyfDIRbReTBIRI4BZxieM0xfKmIPNL5/ObTGAp8+l9RvNykiHtVLeFZ+Pyx8B7OjdBFZqoEiFOqekqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRDCwEkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRDCwEkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E08C1F000E9;
	Thu, 23 Jul 2026 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784824861;
	bh=fHVu1scpITmeb2YDLXOuQLYRDw4sgfpPUx4Eq/Xz6vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SRDCwEkkZPKvowOcSlvlf/BxhakgAHEbN1vldezT0LokS2FB8zGnx+EWjsq4Sb2uL
	 wL3EjefMlq58W8s1OAphaDgVwety4krxZbOdsWdZA8J/UswAjmwWLxvMt/pLLsnKnN
	 O80kQ1K0CgXVROesBkpCsU72WwAneI/lbY5+kOMGZmpGyKk0sRysb7UsbP3ftp1HxK
	 3+v2MGDNr3DvXGH1tIEqSJiZd4XOYkQIZGobOO/nujpOysYc/eF1RoSORXeMAt/mcn
	 vJAtdKHTmY8+s9/97n+ZQMPdhZJjNRj8ZMC9tIvSCpRZhgmc+O6ObcJEQQgab/K934
	 me57VNR4/5vlQ==
Date: Thu, 23 Jul 2026 17:40:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, andy@kernel.org, nuno.sa@analog.com,
	linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com,
	ciprian.hegbeli@analog.com, siratul.islam@linux.dev,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: add maxim,max40080
Message-ID: <20260723-jingle-mousiness-f0f5a0edd76c@spud>
References: <20260723065036.2683075-1-stefan.popa@analog.com>
 <20260723065036.2683075-2-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yE6gneEGn3HJwCL0"
Content-Disposition: inline
In-Reply-To: <20260723065036.2683075-2-stefan.popa@analog.com>

--yE6gneEGn3HJwCL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 09:50:35AM +0300, Stefan Popa wrote:
> Add device tree bindings for the Maxim MAX40080 bidirectional
> current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../bindings/iio/adc/maxim,max40080.yaml      | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40=
080.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yam=
l b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> new file mode 100644
> index 0000000000000..170bf4eff8706
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max40080.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX40080 bidirectional current-sense amplifier
> +
> +maintainers:
> +  - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> +  - Stefan Popa <stefan.popa@analog.com>
> +
> +description: |
> +  The MAX40080 is a high-precision, bidirectional current-sense amplifie=
r with
> +  an integrated 12-bit ADC and an I2C/SMBus interface. It measures the v=
oltage
> +  across an external shunt resistor and the input bus voltage, and store=
s the
> +  results in an internal FIFO.
> +
> +  Datasheet:
> +    https://www.analog.com/en/products/max40080.html
> +
> +properties:
> +  compatible:
> +    const: maxim,max40080

ADI want newly documented devices to use the "adi" prefix.
pw-bot: changes-requested
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--yE6gneEGn3HJwCL0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamJEGAAKCRB4tDGHoIJi
0oKDAP9jP0uqDFmcLoFN0w7K0Lq6OLJKSLMyTH2o8dzwUbWBEwD/e960fPepKrI9
AQh9KZXUb+6+eZG0P0zTtnHRKrghKwI=
=9inJ
-----END PGP SIGNATURE-----

--yE6gneEGn3HJwCL0--
