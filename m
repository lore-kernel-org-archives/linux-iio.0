Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993642DFF6;
	Wed,  1 Jul 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904070; cv=none; b=AleJkUBWvLXF38qtmKajfrhGQADOLXu842u4lsMIvSBIU2c7Ynauo4JSpW6rTvpCu6wPJ43QCKUR+mvP/y7kHtRNyEywskGLWbFwcvrQV6WurACxTYJ7VUDkRTV5mZeDhIvcWIofm48guqfEXnS6wCgUJh+Cp+YUjCbg7Tw6UDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904070; c=relaxed/simple;
	bh=NJLKXuAy7Y09RSdhb1EYekxiJOEEQTEVUn+u+kA7hG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSvzBMFgkK4gWxpzrKJARgy1bSHNPDRAey4o/71Kk4LL5bUDfmarGAj0P1qBCD8/vUEB9XctWyWfIn9gFko9dUBXkF1YOWWcM2euhFNINcgsN756AmQChZCCJ9Ee6deJrqbfjxFYJmsTm31nebz+Hn9+MxxLU/AItKs6MfM2S5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCBpK/qC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCBpK/qC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5681F000E9;
	Wed,  1 Jul 2026 11:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904068;
	bh=nQ4PsDHYabC62Okbc3S5UnoU2U7Ydz2PKMaX+5DJstc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lCBpK/qCLR0Wp8AMFtVO2ZYKGh9TJDJPL16mIuJ2LZBUdPDw0MaNMgtyuiuCaPChT
	 M+8NfHmujqdqKDN0WuRF13M6FiO7GqG+2tudMLyW41C2O1Oowh+ty83dVJ/bAQuIwY
	 mIAuBL2zzyd9UZTAelVEZjhAkYYYsDUJXJHi8DubvpitE6aKob3L2hzZTQgSa4HBPp
	 oGVjBe4yS5HDCYir4Jkfe4jcnGp5FNv7PBAJT9B4amHZffTze/tFBA4QosYBlhSj/3
	 r40OIoXB0aaove71G2aMs/TB7eE4jEcUP0AdbW9sX7TZ2aCO/Fij19i8EnJeBt09J1
	 09V/U5cvYPh/Q==
Date: Wed, 1 Jul 2026 12:07:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260701-ardently-sloping-2d5ba83b61fb@spud>
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
 <20260701-ad5529r-driver-v5-2-ed087900e642@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0M00TNO2mVEAmOIw"
Content-Disposition: inline
In-Reply-To: <20260701-ad5529r-driver-v5-2-ed087900e642@analog.com>

--0M00TNO2mVEAmOIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2026 at 08:40:40AM +0200, Janani Sunil wrote:

> +patternProperties:
> +  "^channel@([0-9a-f]{1,2})$":
> +    type: object
> +    description: Child nodes for individual channel configuration
> +
> +    properties:
> +      reg:
> +        description: Channel number.
> +        minimum: 0
> +        maximum: 63
> +
> +      spi,device-addr:
> +        $ref: /schemas/types.yaml#/definitions/uint32

Same comments apply here about whether this is a channel or a spi
peripheral level property.

> +        enum: [0, 1, 2, 3]
> +        description:
> +          Device address selected by the ID0 and ID1 pins. Up to four AD5529R
> +          devices can share a single SPI chip select; each device responds only
> +          to transfers whose address bits [13:12] match its configured address.
> +
> +      adi,output-range-microvolt:

I didn't notice this on the previous versions, but doesn't this
duplicate the common output-range-microvolt in dac.yaml, which you
should be including here because these channels are dacs?

pw-bot: changes-requested

Cheers,
Conor.

> +        description: |
> +          Output voltage range for this channel as [min, max] in microvolts.
> +          If not specified, defaults to 0V to 5V range.
> +        oneOf:
> +          - items:
> +              - const: 0
> +              - enum: [5000000, 10000000, 20000000, 40000000]
> +          - items:
> +              - const: -5000000
> +              - const: 5000000
> +          - items:
> +              - const: -10000000
> +              - const: 10000000
> +          - items:
> +              - const: -15000000
> +              - const: 15000000
> +          - items:
> +              - const: -20000000
> +              - const: 20000000

--0M00TNO2mVEAmOIw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakT0/gAKCRB4tDGHoIJi
0pnQAQD9lhRrxn1NbXQ8zdd56gFpnXVgtHwgo/R9/U8JU6MARgEAuKhd4IqN1Y05
FDtxSXMlM8NIEpnzxf86fNIaYlXdcgc=
=Qn0X
-----END PGP SIGNATURE-----

--0M00TNO2mVEAmOIw--
