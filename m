Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362923002DF;
	Fri, 20 Mar 2026 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027233; cv=none; b=Pk7YdE3KXOMzokyKxlhjQ4sDIDGJMo7Y1wIFmq/Cv7THsnr9MtVa6ILNrHhHUr1QUdOjB23cKsP1EP0S7zNS43GEI6KA31xvg3NU2xuDRopF4uv2+tjpz2OSr/O0yTjTb5h125cxEjdAdPa5oUjhFWrBQ1F8neTK8cL5bbkld/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027233; c=relaxed/simple;
	bh=gUjmNdpoufx/LOllFEAXcboSVvQAry7b28nOT3dZAF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzEWZDKtksHCo/UCAgJkqbvHBCWoFrTovx1IdkjiR1qfLO68uQsk5zLEWfjr4kvzx3Dl2fIfs0cG2g3iYXlFKcdAUX0kXHoJ63ZNkWvcnnPQqL8mjCj1k+UQh6Vl4FVWdSn5X3/KU7DEJ+bH46wKNBKIMshsQB7ouIV2DV5/+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA1o/36k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA1o/36k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC00C4CEF7;
	Fri, 20 Mar 2026 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774027233;
	bh=gUjmNdpoufx/LOllFEAXcboSVvQAry7b28nOT3dZAF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hA1o/36kGFFDrKajyiVxRTEAv7AJZCK/+lA7KBry82O/5q84vlgtjTrdd0b0NVAxr
	 YOfLmMDih1QZuGfw0SkgkM7mfgPRvJKekQgNBIn9lZWk3uOXcTTflLkHPJnT39gXRV
	 WklxnGSS98gpGiWdrGwoZ2CcNGOsdCuY8hxZz8Keinp6WUgnhd8lntBCWmd3SkaVcd
	 9c6hLMN3N6lUcXBtUtpp24lEEzkFhIY8hZ6e/yczADOJUTSalQ4uXgHgg32/Is8Cu0
	 wFPWRjg1Bt+WHfcrY+PpWw60ZLdvDc/XkN/feVce0LLxXdwbAwyUco4ktp1t5Kg3kz
	 cfHuXhrPrAFgg==
Date: Fri, 20 Mar 2026 17:20:28 +0000
From: Conor Dooley <conor@kernel.org>
To: David =?utf-8?Q?Marinovi=C4=87?= <david.marinovic@pupin.rs>
Cc: jic23@kernel.org, andriy.shevchenko@intel.com, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, michael.hennerich@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: dac: ltc2632: add LTC2654
 compatible strings
Message-ID: <20260320-doorway-rack-75f58f141999@spud>
References: <20260318135736.91564-1-david.marinovic@pupin.rs>
 <20260320150957.105571-1-david.marinovic@pupin.rs>
 <20260320150957.105571-3-david.marinovic@pupin.rs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8xyPhteJzLzSXz59"
Content-Disposition: inline
In-Reply-To: <20260320150957.105571-3-david.marinovic@pupin.rs>


--8xyPhteJzLzSXz59
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 04:09:47PM +0100, David Marinovi=C4=87 wrote:
> From: David Marinovic <david.marinovic@pupin.rs>
>=20
> Add compatible strings for the LTC2654 quad-channel DAC family.
>=20
> The LTC2654 devices are 4-channel, 16-/12-bit DACs with an internal
> reference and SPI interface. They use the same 24-bit SPI command
> format as the LTC2632/2634/2636 family.
>=20
> The 16-bit variants (LTC2654-L16 and LTC2654-H16) require new
> compatible strings, as no existing compatibles support 16-bit
> resolution.
>=20
> The 12-bit variants (LTC2654-L12 and LTC2654-H12) are register-
> compatible with LTC2634-L12 and LTC2634-H12 respectively, and can
> use them as fallback compatibles.
>=20

> Changes added for:
> - lltc,ltc2654-l16: 16-bit, 2.5V internal reference
> - lltc,ltc2654-l12: 12-bit, 2.5V internal reference (fallback to lltc,ltc=
2634-l12)
> - lltc,ltc2654-h16: 16-bit, 4.096V internal reference
> - lltc,ltc2654-h12: 12-bit, 4.096V internal reference (fallback to lltc,l=
tc2634-h12)

No idea what this section is doing, could probably cull it if there's
another version.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

btw, please don't send new versions in reply to old ones, can cause you
to get buried in people's mailboxes.

Cheers,
Conor.

--8xyPhteJzLzSXz59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCab2B3AAKCRB4tDGHoIJi
0oF6AQC1UxcI4CloyPGfmWXyIqR4+xy2sxzadpu6YLIlvGC0IAEA6PkyGrcN+KBx
zzACDjW+F2kJIa8LO6Al0bAnq63QAAs=
=rJmI
-----END PGP SIGNATURE-----

--8xyPhteJzLzSXz59--
