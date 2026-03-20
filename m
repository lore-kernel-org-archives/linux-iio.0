Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A55B3D1711;
	Fri, 20 Mar 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027637; cv=none; b=cObnGQkTlj0679EpjS6KRqcz+MaIkgqT3JAMqZXnhopoTjvDFxRC+vX+870ZmQO1H7uDuQSruUC1NsQr6qjzS9xNlJ2XhMRVmpKeQ8IVW3pETje13c860sBMFfq9AURhaSxaZdqfzZxb8lVPDuA89I/q5MnbZLAs48qQn1q8K44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027637; c=relaxed/simple;
	bh=6Mjk1+pZcOL6YeYH4dIY3vVPBbYPiWREkcuzQYNf8WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWPGr35etCmyfFMEe4t/gq48XY9aJ15HbPIucvXDM5JtmSeFGaMuvkH7umcyzWlhjz0koup0EU4bVsWBY12sIBd5+k/eiAzd2eo/0IGKZWqxVnLiymnIRPEATPO9EEKZWO5tuzkOC7szVV9bpUoca1u7ljkYl7e5AaBGMb85m1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdzCmBr5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdzCmBr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA39AC4CEF7;
	Fri, 20 Mar 2026 17:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774027636;
	bh=6Mjk1+pZcOL6YeYH4dIY3vVPBbYPiWREkcuzQYNf8WQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdzCmBr5TwqIkh+rKFKzFbf0CQ5fmLAZmN5SEORrQemXAODzImiUY+LLxfixzW9d6
	 jNRtBMC6EI7NDnVdkRiVcyyrb9oNfUH6npfDShkhzapMoQ9WPqEDgeJTdjcBotFXrD
	 YNOQzURu28tkJhFChHB/PaS5FuRu9oRpG9o7/4Q9GahmZmOedgKtgu0QgpUXcIBs6k
	 F6k/K4EsdMc6ASic0IEDY8wNwGMiE/cI/gx4LNt9CJtmlQvWXwVGAWb0UGDhLb5vFo
	 CJGCB/7T+hgGD2bubbrTg0+Qw5rn/Mi4ncZRJ6m1t0juv8Z56osyakV694+d2i29mf
	 kR3XRLparGFmg==
Date: Fri, 20 Mar 2026 17:27:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Carlos Jones Jr <carlosjr.jones@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Beguin <liambeguin@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Jorge Marques <jorge.marques@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2305
 support
Message-ID: <20260320-popper-uncurled-723c68d33554@spud>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
 <20260320140819.191700-3-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8LrQ4qPzToout+qF"
Content-Disposition: inline
In-Reply-To: <20260320140819.191700-3-carlosjr.jones@analog.com>


--8LrQ4qPzToout+qF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 10:08:18PM +0800, Carlos Jones Jr wrote:
> Add support for the LTC2305 2-channel, 12-bit ADC to the existing
> LTC2497 device tree bindings.

> The LTC2305 is compatible with the
> LTC2309 driver implementation.

Clearly this is not true, given the driver patches in the series.
pw-bot: changes-requested

Cheers,
Conor.

>=20
> Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml        | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml =
b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> index 5cc6a9684077..b246d492950e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> @@ -4,13 +4,19 @@
>  $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
> +title: Linear Technology / Analog Devices LTC2497 and similar ADCs
> =20
>  maintainers:
>    - Michael Hennerich <michael.hennerich@analog.com>
>    - Liam Beguin <liambeguin@gmail.com>
> =20
>  description: |
> +  LTC2305:
> +    low noise, low power, 2-channel, 12-bit successive approximation ADC=
 with an
> +    I2C compatible serial interface.
> +
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
2305fa.pdf
> +
>    LTC2309:
>      low noise, low power, 8-channel, 12-bit successive approximation ADC=
 with an
>      I2C compatible serial interface.
> @@ -28,6 +34,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - lltc,ltc2305
>        - lltc,ltc2309
>        - lltc,ltc2497
>        - lltc,ltc2499
> --=20
> 2.43.0
>=20

--8LrQ4qPzToout+qF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCab2DbwAKCRB4tDGHoIJi
0mhRAP9B9ByHEGoGo+5X5rF6oICFNxDCAGdK10ccPGjFsmaEUgD/ZiUwvv3JKYXk
vIwsk4oQiLCspvQTC7agRfU74+Kl6gg=
=jCNz
-----END PGP SIGNATURE-----

--8LrQ4qPzToout+qF--
