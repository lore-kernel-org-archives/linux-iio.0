Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695FB351C35;
	Thu, 12 Mar 2026 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337158; cv=none; b=oFEkrxExMvpBqpMXlFvNEJI9ZWJ/tJyK4v4mAmK2FE01Zoq6S0SqwXGgN9f0fMs3zrxv0ccjSb8/hk4PSLLjoRWpR8ukj1igYJZMjA2q61FJfF9FNKv1Y4w4kf0nv36zjpVVqhxuKQErdWGXuA24WOgp3fH12Mjcuu593BovnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337158; c=relaxed/simple;
	bh=8tangXIJgqmeLCu+uid5kcJH5BZUSAQ549JIKe6bFOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4gxOsOLyx1GlU5bjBX5nHV6A7I+L3mtpzS7m0xfQTtDV9+9hyZFhW6P3+gga+NGlFlvRN79YhnCCbSaGSTlChSwXHizVimvEFCj14Ve5lQFD2NL/diM2jvCYFu7f3yN9pPwiWpVXWF7MB1alXdAntJlasGDauFUxjNeMCWztTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlmGN1XD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlmGN1XD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD07C4CEF7;
	Thu, 12 Mar 2026 17:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773337158;
	bh=8tangXIJgqmeLCu+uid5kcJH5BZUSAQ549JIKe6bFOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlmGN1XDZwTrDBfg6Ol0kqK12NK5p/UYK06a729WdBYcxpA87H/k3EbD/5qfBaXKI
	 yfGpNnPbsnGShxz9YXdeeVp1eMDwwHy7USwNGVoUQh8v+0xXxcwmKBMpHMmSlpdGWF
	 5bpIR1HGTSgxTk1WdzMtsT59fB2xT/YtdVJ5YFAYBc0oR61TTRhFWT9TiusMLUhOVq
	 uk2hMRR/BJpLARGtuv/HwKmwASZyp4kaLHk4lo1Ok4WiRfMn57acFOUNUYbYaFB3Jp
	 78IuhxQBUhQmVv5lUcQ6J+H1tSNfNnPHaWvJH3+WU70XPrc63frvXTmKK6DHS5HCBn
	 8CqeQk2AKAZBw==
Date: Thu, 12 Mar 2026 17:39:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: light: vcnl4000: add regulators
Message-ID: <20260312-slouching-shelf-c8f64433881d@spud>
References: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
 <20260312-vcnl4000-regulators-v2-1-2bdebbcbb58a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pYN3c8jb1SuI1kvB"
Content-Disposition: inline
In-Reply-To: <20260312-vcnl4000-regulators-v2-1-2bdebbcbb58a@gmail.com>


--pYN3c8jb1SuI1kvB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 01:53:12PM +0200, Erikas Bitovtas wrote:
> This commit adds regulator properties for vcnl4000 ambient light and
> proximity sensors.

This we can see. Your commit message should say why.

Do all devices in the binding have all of these supplies?

>=20
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 +++=
++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.=
yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> index 2ba4d5de4ec4..a1b4c02db246 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> @@ -33,6 +33,10 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  vdd-supply: true
> +  vddio-supply: true
> +  vled-supply: true
> +
>    reg:
>      maxItems: 1
> =20
> @@ -54,6 +58,9 @@ examples:
>              compatible =3D "vishay,vcnl4200";
>              reg =3D <0x51>;
>              proximity-near-level =3D <220>;
> +            vdd-supply =3D <&reg_vdd>;
> +            vddio-supply =3D <&reg_vddio>;
> +            vled-supply =3D <&reg_vled>;
>          };
>      };
>  ...
>=20
> --=20
> 2.53.0
>=20

--pYN3c8jb1SuI1kvB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabL6QQAKCRB4tDGHoIJi
0ke5AP9tyhxjqz1XVt343vG25cnoWFoR+CMvKiFP/ROJAoyuGwD+I/P3SJp3/NFn
xsGHIzSSNCLJi7r72LTMxP13Yw9Saws=
=f0Xg
-----END PGP SIGNATURE-----

--pYN3c8jb1SuI1kvB--
