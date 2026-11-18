Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025554;
	b=190LRlki8oJNdQy5s4VNQQKC8h8cQQllbeGt8k0RA0RVBxBb8gb157TIm3iAOH4/BR8v
	 58N5/Nk8L+6Mr+IYY+E+A0cqAAhEaVP6n6xtrlOr5DViTS9H2wexGbU8QW1UnSSCQuVsp
	 0k6OeWOPO+dv/0r7OT9R6BtwVF4iVCNn8LMUQfR+eNFz0J0j7vRLKVQBOqUCkjmujJNdc
	 HfVLVvhMIbWouBTmzV9XcaInxDJ/nWUvo20//W13y6Ze/lCtT4rlKiklLhxK5f8uto74G
	 lpXbCjmMTxhSla7EwHEg2I9WqXwrSc+jo9bGUVv3ncSFjT4t0MVByvE6W7B5rWt9yxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025554;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IUksd2EN7DAxDu03VPjEPJYKskFGPuXrSVOQtY3wFAg=;
	b=IKRu3zsSU6at8M/+AJPj9p4kC2pssqRMfENj+EjdBgkuzuT1wvkBZz+kc+spbS9lazVM
	 dfbdMLVaoLrumGuuMvOKp6knpxphlOUA+z/J/NHZwN5nSeuR74ziIDYfrXgC/k74Oc1YL
	 dyL1xqdor3gPnS9n4so4EgEpfh5tk9VCs45bydBoTIrvf2E3hqqDflktuGI/4nYFTlH4Z
	 YrygZx3Vn7v1dwNaMUKkKiX9zc2mapyrDlI3Hn2L50QV5YUmRJl4vBwZPNOZX5tJtRlu5
	 dfCGw4GlJ7Le4NJ5qt0v0ezLU0MVvh0ks/NAS2TcHm4Ivv/Ct7D0lweyzM2WPkMUffQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elM43Bpu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B4606A32F;
	Wed, 18 Nov 2026 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elM43Bpu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E16C1F000C4;
	Wed, 18 Nov 2026 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795025554;
	bh=IUksd2EN7DAxDu03VPjEPJYKskFGPuXrSVOQtY3wFAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=elM43Bpuqtw+3W3DLdnGQqkXlPot4QLPnjebA+7Ygl7hBPLChmAxGrUjRUIQNTds+
	 mi6e/yluHrgdcz0iiQf9jnCd4cj9mU3FTNAOyxeCy7ho3WqswAB+Iybqkub/4OWaUX
	 NLqYU8Y2Abob1lpELVedMjpAcLx6t+4fCvOCD7C5UZTK89X/EtosqWI6Vh29D0pXfQ
	 rUl/tW4qyr9FvzOknf/G80U+F3yHjQyBlT6wQ2riPRgu7VUoG7xPqAep9hV/Ccn/fU
	 EL8zoHapGabspc6BblgfurPpCaPVua53j6h0Ga9o35xmnwDA3DUYS3/1X7trxGdal+
	 a87Oj/9KjGtNQ==
Date: Wed, 18 Nov 2026 18:12:30 +0000
From: Conor Dooley <conor@kernel.org>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: light: stk33xx: add power
 supply support
Message-ID: <20261118-coyness-luminance-6d0c07e843b7@spud>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
 <20261117-6768-stk3337-v2-1-92f4c7be3bc6@protonmail.com>
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
	protocol="application/pgp-signature"; boundary="Wi8VP7MkMSS0kuNp"
Content-Disposition: inline
In-Reply-To: <20261117-6768-stk3337-v2-1-92f4c7be3bc6@protonmail.com>

--Wi8VP7MkMSS0kuNp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 08:08:35PM +0200, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
>=20
> On some boards, the chip shares a power rail with other components. If
> that rail is turned off, the chip can't function.

With these issues in mind, probably it should be made required, even
though new required properties are an ABI break.

>=20
> Add vdd-supply property to document the chip power supply.
>=20
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/D=
ocumentation/devicetree/bindings/iio/light/stk33xx.yaml
> index f655a570aac7..114cf87eb54d 100644
> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> @@ -37,6 +37,8 @@ properties:
> =20
>    proximity-near-level: true
> =20
> +  vdd-supply: true
> +
>  required:
>    - compatible
>    - reg
>=20
> --=20
> 2.56.1
>=20
>=20

--Wi8VP7MkMSS0kuNp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3qjgAKCRB4tDGHoIJi
0lBbAP9YFPlo1iWzvxOPAtC+Ka1IITpaCyap6wkQEn5ECGM9mQEAnZMkdI6PAl0s
MCvwNfv3kH9BLnT19JYl2/vIDi4vcwQ=
=mpIH
-----END PGP SIGNATURE-----

--Wi8VP7MkMSS0kuNp--
