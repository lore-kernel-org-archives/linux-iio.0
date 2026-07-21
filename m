Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D4D2E1F06;
	Tue, 21 Jul 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649691; cv=none; b=MxorJJkVlp07gL/r1vKV3igDKEkml7oqNHZGWWcmpbDOQyqgIRhdnIAW8dVZ02t6bqQvAmVmT3/Rz5DaAXY89wS59rWFtTtK0fG/nh1ATa1JHJb6/CEZ4gX9svor3zYLkIrtyqLQ9BvaF0PAIy9k88IVv/p+5vkQgcH/8QaAhO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649691; c=relaxed/simple;
	bh=9qj3Kj6QReBjzEOqIAGzOwG1wF4VKk7HQiWLOsngivY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prVkRH059DKChAkuPXJFyx9RjdYaheSbyQ2Nq2SqNChrFOBRkjm5P16KUKgniEk8qDk8ambsb/ywh+YDsZ2yOLCPAAfdO4aNmLfDwtQ/uvFV5nVlh1l+U7x7hgaGpKmd+Y965NpP3D2qTnK6I/8ATwOfdX00ZF7ggf2LfB4gmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvhqbcVL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvhqbcVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8621F000E9;
	Tue, 21 Jul 2026 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784649690;
	bh=OiZ4pSpuVPr9CKAPjC/MggqTcPszIr4IfglAljiUWa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kvhqbcVL1sruT9EcDsbyQAn+dJ3y/EnSk0JPzUn1wsV5SunEf2yXcNG52eIR7FUP4
	 g95hW0mRllRLeb196pnF1Zpzkoq957OCcF010neewYv17pcnQe3Ad5S/gctNZuVrkq
	 a0HPEBQX45ouZkegDLV1kTuQ/95L3uxrnS6st4t2nmiTjZEpJnPIsosGsQBTEjH2CA
	 uiwaJe+C1mWtzRui8ByheL9rSi8iZY+3CgWQ3yvDfv1BNF/kh/OsfdgZ8V2z0+ELS7
	 +8cURTR/ATz4Q0bPttJ6/mKD6mBFH+NAL5HSjJU3YoS3kVjxSRbAtUuRRBbUh7HKm2
	 mhp/hALBIDr3Q==
Date: Tue, 21 Jul 2026 17:01:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: icm42600: add icm42630
Message-ID: <20260721-lethargic-purge-e3cfb3c50677@spud>
References: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
 <20260720173411.82979-2-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Ob0Kh99cJqud7Ni"
Content-Disposition: inline
In-Reply-To: <20260720173411.82979-2-jorijnvdgraaf@catcrafts.net>

--2Ob0Kh99cJqud7Ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 07:34:10PM +0200, Jorijn van der Graaf wrote:
> The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
> found e.g. in the Fairphone 6. Document its compatible.
>=20
> A fallback compatible to a sibling is not usable: the part reports its
> own WHOAMI register value, which software validates against the
> compatible.

Why does software do this? If the whoami is the only difference, the
software should stop checking it.

>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm4260=
0.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> index 119e28a833fd..add3a7fef09d 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -31,6 +31,7 @@ properties:
>        - invensense,icm42602
>        - invensense,icm42605
>        - invensense,icm42622
> +      - invensense,icm42630
>        - invensense,icm42631
>        - invensense,icm42686
>        - invensense,icm42688
> --=20
> 2.55.0
>=20

--2Ob0Kh99cJqud7Ni
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCal+X1QAKCRB4tDGHoIJi
0kbUAP9tJjGixT0fzWBOrL4zktryyCI9m0I4dCiFJsn5flz4xgEA7hITYvPyyFXK
1cxKh3czSrZGW6i4zoT6PnVpHzmw1AM=
=oAwh
-----END PGP SIGNATURE-----

--2Ob0Kh99cJqud7Ni--
