Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D413AB267;
	Tue, 16 Jun 2026 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624470; cv=none; b=jtQNxcva41VYqiQrg2VrOUWUa+p1N6u63Vj78MtOOsEldY0vAr8b1BBbWRbMGttowyYYMIeZSVIjgsrgQI+Dua+pq8qk1aMRTEvamorUH0Wu/qIqku6CXR9T3zenDrBQeUjMHskrJC7EKxgodWq9JlxdJy4dDsOZhntr3JOVo6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624470; c=relaxed/simple;
	bh=L3dXwzlMy2LgBGgHPYpIPiVb7RGZwJ8RI/pxEwwkH4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml1G+kgYfezygViGg9QoYMiXUA58z5734xhddx6syhI4Vkqr0oax/nd7ntWnI/EcxjdogOcL0ExmAlrUH3mj0L+j0KRYeMLP72Iv+xWFA6N57rP7CJnOh2fjFkEn5FJa00QIF2xXXhBW17A8XY5OgotHq3C/z+ZFpVNy1uBgky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYtsO2T1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYtsO2T1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5AC1F000E9;
	Tue, 16 Jun 2026 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624469;
	bh=L3dXwzlMy2LgBGgHPYpIPiVb7RGZwJ8RI/pxEwwkH4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AYtsO2T1puU8FIBLqMZDYx136bEz74sMUPsCSdtwYZfLx27httDPb57rqWuEjQrB0
	 awcH64am4nvuq0EpMtu5uXb4SsRG1urvcLsgduPphC7JPXfXTHIoHwtidtKwbCkDca
	 uLwPIs0Zm821D0QeNHpwqABhzOvVurKir4WdbmogUXHlSvCyOmNQg9G2d2qlMNLpPj
	 SDP2C5ejCl12UyaApKLq8JZ0POgPYVMhv15skAcSjqTwfyQV/ZoxJ4KgBWxC2NOhL6
	 pbrgKguj4HgOpW7H0dTozcp6eKNZk+xMK5yageGAZO5uf6J+FOvm7B1CQVcjQ8DsHr
	 EoEJQHBRwOu6w==
Date: Tue, 16 Jun 2026 16:41:04 +0100
From: Conor Dooley <conor@kernel.org>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: mediatek,mt6359-auxadc:
 add mt6323 PMIC AUXADC
Message-ID: <20260616-patronage-swapping-197a674f9df6@spud>
References: <20260616-mt6323-adc-v3-0-1c27c588185d@protonmail.com>
 <20260616-mt6323-adc-v3-1-1c27c588185d@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XgkNMFzBNJmMg/9j"
Content-Disposition: inline
In-Reply-To: <20260616-mt6323-adc-v3-1-1c27c588185d@protonmail.com>


--XgkNMFzBNJmMg/9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 05:15:39PM +0300, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
>=20
> The MediaTek mt6323 PMIC includes an AUXADC used for battery voltage,
> temperature, and other internal measurements. The IP block is not
> register-compatible with mt6359

Cut this sentence here, whether or not it uses the same driver may
differ per OS.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable


>=20
> Add the devicetree binding documentation and the associated header file
> defining the ADC channel constants.
>=20
> Also change the description to 'MT6350 series and similar' because
> the binding already includes more than mt635x series PMICs.
>=20
> Finally, add the MAINTAINERS entry for the header with ADC constants.
>=20
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

--XgkNMFzBNJmMg/9j
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajFukAAKCRB4tDGHoIJi
0lkWAP42gL/N6EHSOWxFx7azXHM1KwgVvjuVTAYMl28Ow9l25AEA+dsRSJmfseNN
zXxN+zYbLqyqdUDOdc8JzjNArYl4qwA=
=JWkz
-----END PGP SIGNATURE-----

--XgkNMFzBNJmMg/9j--
