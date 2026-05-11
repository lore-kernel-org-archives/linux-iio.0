Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC003A4F23;
	Mon, 11 May 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516609; cv=none; b=fwfRiYdGtRlwSyy7HZiO1AerIhAKtzVSgOSPeh7tuItHlzM6o6KqGcUgjJknMWTXvbXIwcrPU1XzoNJA/wDGcdEjbsIyDEihKHF3mV2w8EKykOfiIzr3A5q8N3sPNfB5ElkudsZagQgmfs25R1GDUON/P/t2dUR5FPtyBuON/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516609; c=relaxed/simple;
	bh=nbkUiUE1BNhrAoTH5756+l7LroIv5ibrOiE7onUb2yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRAJTvBUeu6bOxO0PP4MKKJx2pLjlPeTTCk23vIll030Wp6fFxciUaIhSkbLxWE+h29vkWRPjgWQA/UVtuUSumAYbqFPHcR6r/62vnGwFQDYwPPZiWDWoTXkuuI+XKGHb7TAbvhNZxT6ta+PvkSyXZyl/7aZOt+hqIcAA5eLJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ermGCxjj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ermGCxjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FE7C2BCC9;
	Mon, 11 May 2026 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516609;
	bh=nbkUiUE1BNhrAoTH5756+l7LroIv5ibrOiE7onUb2yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ermGCxjj4B/rVImWf8/3eRces3eGYbXqtaklUFhvUVRcBCUV7DcIq6+5oiBpQBVKB
	 Eyy5f06tVpVKIQdak1gs68UOR0/9ZE2dpV+ydvpfIhWyPGMCLqXLQaocpzAELuuX/4
	 OvXfX2ROQJxhhBemPu4QNWkPBA025JfDhagxJRIKipzxzp4cvRh9kzgkQejmhYwwAE
	 k737mrrDtmy15R1c09kTG5/TlcKyxyYpgmDlo23rLOAZfZQJ7am9IkkCi0fZTL19KS
	 aaFeF/W8S4C6zB55NM1OE2G2c4p+oEh5w/J8gda6a+LQz3l4Q6jcoQ1aGkvwhQtGgO
	 my3OJXvy7hQ7Q==
Date: Mon, 11 May 2026 17:23:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jic23@kernel.org, lars@metafoo.de, michael.hennerich@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dds: Add AD9832/AD9835 binding
Message-ID: <20260511-pasty-unethical-29d0469f6c43@spud>
References: <20260508233730.77834-1-dennylin0707@gmail.com>
 <20260509-backdrop-contented-b81438c518f4@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HYGwaMv44528BMPN"
Content-Disposition: inline
In-Reply-To: <20260509-backdrop-contented-b81438c518f4@spud>


--HYGwaMv44528BMPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2026 at 05:00:35PM +0100, Conor Dooley wrote:
> Jonathan,
>=20
> What's the story with adding bindings for things that are in staging?

nvm, David replied to the v3 or something of this and said no.

--HYGwaMv44528BMPN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagICfQAKCRB4tDGHoIJi
0otTAPsGtunbJn66IA6TJZ5Uf/PjlerGhUVFbh8+YkEHRpYw/QD/b5r3Mn+tEd3A
iQ++Vs5oiBPkKCtFUpIF4NWiFgCDxwc=
=+dc6
-----END PGP SIGNATURE-----

--HYGwaMv44528BMPN--
