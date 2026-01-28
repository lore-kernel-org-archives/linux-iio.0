Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60062749EA;
	Wed, 28 Jan 2026 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611405; cv=none; b=Xzwy9iT8Cnek6ReHkfXMCPBXj39TGR3XJs1dCNwdbUcci4Vwx+vcTdkg+OsRCVZl7+TV/DEgQF4uDfWouGw/No90WJcnJRE7RIHxgFYkqaX+IPgF1xmhywCELc1xsDhpFywjYH7e/fN/SrVl3z8QmwT++iGaavQhrete6OtvTk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611405; c=relaxed/simple;
	bh=0B519Vg/97pcy/TIGo6fOqWtnD7qqsR2NhzAAYeW+OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoV2XTdj98oJxnDlrxFsPvBLE5IR9p3RBqk98wXtDkDeOiWmg4Lob/+c+5b/KsGGcpHWSTQJLAGVICMok/5w8zG9tJoFlv5h+3rB4fAmJEmHxpV7xoHhYxxHoOyuM+dWwpyNn7ge27e/pl3j9+OGq8cowGtl2ccREsoQdcNyl2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu1Zmezw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu1Zmezw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F898C4CEF1;
	Wed, 28 Jan 2026 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769611405;
	bh=0B519Vg/97pcy/TIGo6fOqWtnD7qqsR2NhzAAYeW+OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qu1ZmezwAkbrJ2zKOND7KXDNZeEK9g3dsBxeX3K6kpSSy8wO3QgnGgNN+djimNs69
	 FrlIWBOVspka7ZkS3wEnQ0pGDCW50d39gBsqucCi1mNNDoooZ+hSqaGRdvakXcrrzm
	 vqlyagn+vtVu5tWCj40T46YN5Wn3jgKCU4APeKfs26aJDLShVt8vDYA1cBY8WNnd/G
	 AMhSiiQb10T7hMFw7ICI/PBXSW16L82COqA53F7jI53FIi0MNFOrgC/7wtXgN7MSZ0
	 /Q+W9iJktOx2HF9F8eh+mQCFAb3uMCvkqZOWMnsg3PNhPZJ5Ccf6q4g52LDLwdRjOR
	 OvfBqNJeVXVZA==
Date: Wed, 28 Jan 2026 14:43:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: iio: amplifiers: Add AD8366 support
Message-ID: <20260128-grieving-polish-4292db90090d@spud>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-2-c9a4d31aeb01@analog.com>
 <20260126-porous-hurdle-bfc510f113bb@spud>
 <rzco2g6psoblzaaqrdnmpmhs44hl7kqusa2kuafpkjx635dug2@rtwebhwztfkd>
 <20260127-goes-grandpa-891eb0dc413a@spud>
 <4dkomm5sskte4olhvjtkuae2t34qim5alp6ptsn3a2m6cyqqrt@kemulszlm3ta>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K0apa4UihCntjqdq"
Content-Disposition: inline
In-Reply-To: <4dkomm5sskte4olhvjtkuae2t34qim5alp6ptsn3a2m6cyqqrt@kemulszlm3ta>


--K0apa4UihCntjqdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 09:39:12AM +0000, Rodrigo Alencar wrote:
> On 26/01/27 07:38PM, Conor Dooley wrote:
> > On Tue, Jan 27, 2026 at 11:37:52AM +0000, Rodrigo Alencar wrote:
> > > On 26/01/26 08:11PM, Conor Dooley wrote:
> > > > On Mon, Jan 26, 2026 at 01:51:03PM +0000, Rodrigo Alencar via B4 Re=
lay wrote:
> > > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > >=20
> > > > > Add device tree binding documentation for amplifiers and digital
> > > > > attenuators. This covers different device variants with similar
> > > > > SPI control.
> > >=20
> > > ...
> > >=20
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - adi,ad8366
> > > > > +      - adi,ada4961
> > > > > +      - adi,adl5240
> > > > > +      - adi,adrf5720
> > > > > +      - adi,adrf5730
> > > > > +      - adi,adrf5731
> > > > > +      - adi,hmc271a
> > > > > +      - adi,hmc792a
> > > > > +      - adi,hmc1018a
> > > > > +      - adi,hmc1019a
> > > > > +      - adi,hmc1119
> > > >=20
> > > > Why do none of these devices use fallback compatibles? Please put t=
he
> > > > rationale in the commit message.
> > >=20
> > > Will do. Each device has their own gain range/step.=20
> > >=20
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  vcc-supply:
> > > > > +    description: Regulator that provides power to the device.
> > > > > +
> > > > > +  reset-gpios:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  enable-gpios:
> > > > > +    maxItems: 1
> > > >=20
> > > > How come enable-gpios is optional? Is it optional on all devices?
> > > > Do all devices support enable-gpios and/or reset-gpios?
> > >=20
> > > Board designs often hardwire powerup or serial mode enable signals
> > > to high voltage level, so there will not be a reason to add the
> > > enable-gpio.
> >=20
> > I don't see anything about all devices supporting enable-gpios, adl5240
> > doesn't appear to have one? I'm not going to check all of the datasheets
> > to see about the others, but you should disallow the property on devices
> > that don't have an enable pin.
>=20
> Understood. I will prepare the following for v3:
>=20
> allOf:
>   - $ref: /schemas/spi/spi-peripheral-props.yaml#
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: adi,hmc271a
>     then:
>       properties:
>         reset-gpios:
>           maxItems: 1

This doesn't look right. The stuff you currently have in the patch
should remain, and this should become
if:
  properties:
    compatible:
      not:
        contains:
          const: adi,hmc271a
then:
  properties:
    reset-gpios: false

>   - if:
>       properties:
>         compatible:
>           contains:
>             anyOf:
>               - const: adi,ad8366
>               - const: adi,ada4961
>               - const: adi,adrf5720
>               - const: adi,adrf5730
>               - const: adi,adrf5731
>               - const: adi,hmc792a
>               - const: adi,hmc1018a
>               - const: adi,hmc1019a
>               - const: adi,hmc1119
>     then:
>       properties:
>         enable-gpios:
>           maxItems: 1
>           description: Power-up or Serial Mode Enable GPIO.

Same for this.

Thanks,
Conor.

>=20
> > > I went over the device datasheets and I could not find the
> > > reason for the reset gpio. I left it there because it was being used
> > > in the current driver implementation, and I would not like to
> > > invalidate designs that might be currently using it. I will ask aroun=
d.
> >=20
> > If none of the devices have a reset pin, then you should delete the
> > property from the binding and the driver. Not like you're going to break
> > something if none of the supported devices even have the pin!
>=20
> The pin might have been there due to an old revision of the ada4961 device
> (the reset_gpio was added to the code when ada4961 support was included)
> which I can't find related documentation. However, it turns out that
> hmc271a contains a reset pin, as you can see above.
>=20
> --=20
> Kind regards,
>=20
> Rodrigo Alencar

--K0apa4UihCntjqdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXogiAAKCRB4tDGHoIJi
0njaAQCn8VQe54YswGoonkiTQ5m8B1Y5mDTsQWGp5/oLjuPhggEA8hN+BhjHgGQ5
NQRqUNgWNdnh7UZk6L7onHmxcOLLGwA=
=QCqp
-----END PGP SIGNATURE-----

--K0apa4UihCntjqdq--
