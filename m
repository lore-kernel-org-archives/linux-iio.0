Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648060;
	b=hbXPhIyFM+ephiFcAWnxDfyaq5A6VbkxU+a/dRwGWH+EIHlTsMCknJBRHXs0TjcCKSg1
	 FcGKcFyVTf0jIS7tUp54QV/oWKInEcoX79lIhstY8jj9HskWGOTVJo1HszEu3pKFxpgO7
	 ZF4OUyz6o1Q16DiUj6XLbVqSir9JKg+d6qkkFD5aeag8wOnOGlkT7PjX76hY/MSso1bIy
	 ok4r0kXg3HUcBj1S+NzxXDjykBhwMLEB1GDz9tE5gebEbBYN+Y+w4Ws3mzsr4GN7YLKoA
	 hoBVLLiDQv4hfjw+A1n7VE7AnzpvqST6/spTLR8FurJWuAuXLgxOlEP2nfqeuWLDqqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648060;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=owNsfdYBsK5m12xlNt7q5hxxRf7qF2EKm7b1ai2qSqI=;
	b=NS1QDEBCILlG9pUo29UYllO8Eq3DYWyq26yeuiQe452p8q9bn+zTExptrRl+RO+NEpC8
	 SSZtb5+9w+MljvvLFmDSGGJBumSDO4LhYHl5WT4+Mo1uY9pJARk3vksi38IMxTtUP6JGX
	 C4dn6Fl/g9Cpv7OwIzmJ8xqMNunIlj+pKL7VEdI2yCfJed02TwwW9cbqzoZH6593LM/Xy
	 VH3DliAjnKOg/qDBnLjvdNyRnEWBgdNSsHD3rLTyDRcOV5MMsGU3Ez6mPJQjy8UasBS9n
	 g9bitMOI4S8rT348Bm6SB3zlNsptRPeFWwqOgEVvBPW/h5z2Fu9ERkP0ZGYzKYcem1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnTwjmZK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39030606A333;
	Mon,  2 Nov 2026 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnTwjmZK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DBD1F00A17;
	Mon,  2 Nov 2026 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648059;
	bh=owNsfdYBsK5m12xlNt7q5hxxRf7qF2EKm7b1ai2qSqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EnTwjmZKa1FJdcmoyhq7Bf8Lc0jNQkLDFOYsF2EOd1TH6gtWtpOmO6IV1lIvekeID
	 jjX1CEGoufZq9zP1tnH4LtU+i9c/OtX00md67/YNs5Tnnd9XMRVKFPuqhDRc7pTy5h
	 rMvI12oh3R80FPKxH+RxpNKQSYPW2BkvwwmaaXq5XBtPm7e08nUGcqgJBaJUiqZs4I
	 aSnj4yt46uQe1HNbw+B90jFoW2SY5Nfxn0PYrxhHaQr13wSzmgAKH48uWMeaNUy3kw
	 rueXdH18rdbysmitk4noOChNPGzTs6cKvBQw0cLmOtBMDUXxKix9NHE9/POiO/RU/b
	 94ugZPta8caZw==
Date: Mon, 2 Nov 2026 19:34:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: jic23@kernel.org, Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad7405: Add
 ADuM7801/7802/7811/7812 support
Message-ID: <20261102-jailbird-camcorder-34dabf3406f7@spud>
References: <20261102121352.23741-1-pop.ioan-daniel@analog.com>
 <20261102121352.23741-2-pop.ioan-daniel@analog.com>
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
	protocol="application/pgp-signature"; boundary="iQO4+I6i5Fi/GSeK"
Content-Disposition: inline
In-Reply-To: <20261102121352.23741-2-pop.ioan-daniel@analog.com>

--iQO4+I6i5Fi/GSeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 02:13:51PM +0200, Pop Ioan Daniel wrote:
> Add compatible strings for the ADuM7801, ADuM7802, ADuM7811 and
> ADuM7812 16-bit isolated sigma-delta modulators.
>=20
> The ADuM7801 and ADuM7811 have a =B1320 mV full-scale input range and
> the ADuM7802 and ADuM7812 a =B164 mV full-scale range. The ADuM780x
> support a master clock of up to 25 MHz and the ADuM781x of up to
> 50 MHz.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> index 57f0970257050..18de5b0d2f498 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> @@ -20,6 +20,10 @@ description: |
>    https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
um7701.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
um7702.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
uM7703.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
um7801.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
um7802.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
um7811.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
um7812.pdf
> =20
>  properties:
>    compatible:
> @@ -28,6 +32,10 @@ properties:
>        - adi,adum7701
>        - adi,adum7702
>        - adi,adum7703
> +      - adi,adum7801
> +      - adi,adum7802
> +      - adi,adum7811
> +      - adi,adum7812

Please explain why fallback comaptibles cannot be used.
pw-bot: changes-requested

Thanks,
Conor.

> =20
>    clocks:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--iQO4+I6i5Fi/GSeK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaujltwAKCRB4tDGHoIJi
0paHAQCSmzCTF2E+Fv7pPMQ87vqmiGcy3QXuJ2uniH/obntL6wD+MKl35+O64n8t
pcWko+797do4+LGMVBP3bmBayapHLQw=
=SmL4
-----END PGP SIGNATURE-----

--iQO4+I6i5Fi/GSeK--
