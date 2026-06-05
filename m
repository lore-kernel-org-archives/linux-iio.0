Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB50394462;
	Fri,  5 Jun 2026 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675648; cv=none; b=RQFu3PCf0LQO1wGMAgKnpUQa6bLcNlv5lQK21kNSuDmH2bkF0WdixDd2hORhEKWGhQCofacBJb11U6sp/MmFZktQZv8ziUPaEf/TgeSFTFvKVAmBHG/R2MRlwtomXXHTBiEDMBfGddT44/2JbvPVs+0ybFuuqJPQTvfR9ZZ7I9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675648; c=relaxed/simple;
	bh=5dVUhFpjbYqFMj66ApW3IFadsxBJTPkevv1Cx+fV/sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ee8JrOoQ3uhEFGk9OJy9PoPN7+SKqMrqKV/HZb7MImQeyrc/S9V8PWZ1ejkr/CPwlNFHAdNP4992Rdn++ZEwOXP4TlyrwfftWsfQeHFr/K2SMqdMBN3b4rtpoOh+AUCH3hAZ6dYq87sY9L4Bfw7Ix6zj9ID21aZLZRNO70elLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYKkSPXe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYKkSPXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0D91F00898;
	Fri,  5 Jun 2026 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780675647;
	bh=/B1xxDKU9ZRX82lOlwJil3Y2ZWZ/fpaWwlXF6/X9Kpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iYKkSPXeGtA/d6FoEk65Jzy2Y6NY7mNNxpSZ7tAQramgf/RWhhfC8c9cgp5yKvoYN
	 MErHO/22E+fBhCvw6CBxpVmcqUecKdEKlAr9N2w+cTUwXUKjk8hSBlosg9srYaW9t/
	 2swDWDb39T8lmrqJf1ebdC4u9kg8q1XcHt1AGG/hSniGbFv73PmCExy2oBQJh9Wfr7
	 fUt6HI5IfpVR4mbVlqgrG6iziFyrQMmiy7FdEBgW6p8LSBMWhZGaZU8En28EKL66rP
	 +S/P/KudZ7azT4lSIQ7bQEbQQSwyajRPbXNoOU/Wp6x+690xPYewKV1ALzXiplMMnq
	 svq1atY7jTK1Q==
Date: Fri, 5 Jun 2026 17:07:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: jic23@kernel.org, linusw@kernel.org, denis.ciocca@st.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sanjayembeddedse@gmail.com, maudspierings@gocontroll.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: st,st-sensors: add st,fullscale-mg
Message-ID: <20260605-musket-ecosphere-2d3761964b57@spud>
References: <cover.1780652883.git.github.com@herrie.org>
 <e49aba850b1f48ea00089e7142c00584541001eb.1780652883.git.github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kSebB565KYv20uXB"
Content-Disposition: inline
In-Reply-To: <e49aba850b1f48ea00089e7142c00584541001eb.1780652883.git.github.com@herrie.org>


--kSebB565KYv20uXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 12:08:42PM +0200, Herman van Hazendonk wrote:
> Add an optional st,fullscale-mg property that selects the initial
> full-scale range of an ST MEMS sensor at probe time, expressed in
> milligauss for magnetometers (and analogous engineering units for
> other ST sensor families that may grow this property in the future).
>=20
> The property is purely additive: if absent, drivers fall back to
> their existing chip default, and if present but unsupported by the
> specific sensor the driver warns and falls back. No existing in-tree
> DTS is affected.
>=20
> The motivating case is the LSM303DLH magnetometer on the HP TouchPad
> (apq8060 / tenderloin) where the kernel's chip-default +/-1.3 G range
> saturates the X axis to the chip's 0xF000 overflow sentinel out of
> probe, because the chip is mounted close to surrounding power planes
> and picks up enough DC bias to exceed the smallest range. The driver
> core hardcodes fs_avl[0] as the starting range, so userspace cannot
> recover without racing the driver to write the in_magn_x_scale sysfs
> attribute after probe. st,fullscale-mg lets the device tree declare
> a wider initial range up-front and avoids the race entirely.
>=20
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  .../devicetree/bindings/iio/st,st-sensors.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/D=
ocumentation/devicetree/bindings/iio/st,st-sensors.yaml
> index a1a958215cdb..335f38e9f78f 100644
> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> @@ -126,6 +126,24 @@ properties:
>    mount-matrix:
>      description: an optional 3x3 mounting rotation matrix.
> =20
> +  st,fullscale-mg:

I'd be inclined to say that this should spell out milligauss, but
this seems reasonable enough to me.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> +    description: |
> +      Selects the initial sensor full-scale at probe time, expressed in
> +      milligauss for magnetometers (or analogous engineering units for
> +      other sensor families that may grow this property in the future).
> +      The value must match one of the sensor-specific full-scale ranges
> +      supported by the chip; if the chip does not support the requested
> +      range the driver falls back to its built-in default.
> +
> +      This is intended for boards where the magnetometer chip picks up
> +      enough DC bias from nearby PCB structures (power planes, ferrous
> +      shields, etc.) that the kernel's chip-default highest-sensitivity
> +      range saturates one or more axes to the chip's overflow sentinel,
> +      and userspace observes that axis as permanently stuck. Declaring
> +      a wider initial range avoids the saturation at the cost of a
> +      slightly coarser quantisation.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>  allOf:
>    - if:
>        properties:
> --=20
> 2.43.0
>=20

--kSebB565KYv20uXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiL0OgAKCRB4tDGHoIJi
0mWhAP0WtJXb6Y1fNVc7JRVRXauldTnWnniSpLpJ0CYwHpQAMQEA/+fXOjmXsv5D
BLMdqhx3tRTkJljg6eJVtEavHs/5UgY=
=yNKR
-----END PGP SIGNATURE-----

--kSebB565KYv20uXB--
