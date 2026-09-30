Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED81515995;
	Wed, 30 Sep 2026 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807403; cv=none; b=mALV1U24Ju4dcGqkzgEALqFJzr8+xOXu+9QIJ8adnsWKBymd/tUsP0UQnWK8or+rwxGev8VsJ22T50bC7xAj8HaemVrDQK5Xj69uHGMWgrQEtgl4HMn9o/DiAcYUcXlZW/T7MxHVracCB5peC4ZLXfwXIqnGJ8EVNkbh2vKn/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807403; c=relaxed/simple;
	bh=u4WuMN5gvyBKdJCjeN/mXG8s2/tAu5mNwGmdgCldP10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAyL6o81TZD2N1APyB8o+La4+XRtzmGNpf8h0kYrq4iXm4xvfl/jNkzin5YXkq4mH2DcCr0mWigNYBDR5LOcnI1x32EQQs/rwamY/ZYnGVCpwM1VbwIQFAL7W7pdhRVIVe00qawUzi1R2pQycCeJABnt3Fya+WLu7C8Jkr7u89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qhfkh+Qk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qhfkh+Qk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBD41F000FF;
	Wed, 30 Sep 2026 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790807401;
	bh=u4WuMN5gvyBKdJCjeN/mXG8s2/tAu5mNwGmdgCldP10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qhfkh+QkLZBV20AbieskJQTSYN9OyyYIbR5JBWIzqZRENSxMzqbK8lbLAdogQr4Sx
	 l4xci+56RotTVgqfj/Ssnx26GXlWBKH+YB+/dpPr3Ewx2AmjkHoGI9gRgSfPqCC/jp
	 oNi699zrkcS5nbU2JJ4S3jvoe8zTiMS6+RI0juJaFUQ2mJHA9Fu6pgzXsBVRwaVw26
	 tV12/VYhbJBjNGponhlEB6y6Mr9ahYtj9/UjExG2OPVtnxp2PzOPZ7HBKr+zx+2HY6
	 eD6mxHfs++vdwfu1SEWs822Iun7MSO4i2FlBUF/OFwTsJszJJXMZO51KHhIMXaEj8Z
	 Ma5kiDym4NkSQ==
Date: Wed, 30 Sep 2026 23:29:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <20260930-fraction-unharmed-eb98b084df48@spud>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
 <12e5af9d96f6c5e800ad860d3cfa6ac8006a22e2.1790719425.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EBwA5Wz55DSFLoUE"
Content-Disposition: inline
In-Reply-To: <12e5af9d96f6c5e800ad860d3cfa6ac8006a22e2.1790719425.git.marcelo.schmitt@analog.com>

--EBwA5Wz55DSFLoUE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 07:44:22PM -0300, Marcelo Schmitt wrote:
> Document how AD4134 chips are connected to the host SPI controller
> according to different wiring configurations.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Modulo the issue the bot flagged, I'm happy with this.

> ---
> Change log v2 -> v3:
> - Adjusted spi-rx-bus-width constraints.
>=20
> Unfortunately, I missed SPI connection mode properties when introducing A=
D4134
> dt-doc and the device driver defaulted to a no-CS configuration. Due to t=
hat,
> conventional 4-wire mode can't be made default without leading to a regre=
ssion.
> Still, updating the SPI mode default to 4-wire is a sensible thing to do =
later
> on if acceptable.

I dunno, it's probably not really a big deal to leave it as it is, it's
just a default and it's probably just not worth affecting what users
there may be.


--EBwA5Wz55DSFLoUE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar2NZAAKCRB4tDGHoIJi
0vr2AP9gAWcPw95MKb76XVaxQkOmeMd8tI6J7BxGtvGr76EkewEAoJqk2fRTR4zw
pCveUCp7y8hAjER52AldujHMEVAI3QU=
=SopS
-----END PGP SIGNATURE-----

--EBwA5Wz55DSFLoUE--
