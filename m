Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FC2773C3;
	Sun, 24 May 2026 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651264; cv=none; b=NZ6+DnfbBRuHka+G6YSrDce1mdARVpJYtIJ/DmxodyPggWaa8W9s+fqFAi2+RZfccDNakb15L3w+HrxCSdLf8kdOb02PpzBxpQEvFmisIWlNUE23k8oKAo8Zc93rqR9upf19gpYAeeq4yVELUFzdpoNh+ClEI0Zbh4L6rzVggYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651264; c=relaxed/simple;
	bh=1FF9aoLbdw0yJTCNZZshoIPipr6muLVgaOu4w2qQXSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVh8BmXgzGv6N2eEgqWRto+85/zLl50LdaO9557SZP1Noae2vH0OtemfNQKCezmCwFHKro6V/pHLM0Pb3L3DsxfFmnUbQRQiNhuef0wgfCAZoiQylClIsQIcQXfsOcRJcQnFi+NoiFCiKe1xUclbMcl2bFPIRDXP8RazjDZEWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXeZiby4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXeZiby4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646221F000E9;
	Sun, 24 May 2026 19:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779651263;
	bh=1FF9aoLbdw0yJTCNZZshoIPipr6muLVgaOu4w2qQXSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GXeZiby4qylDp/3n57fIMQHf+4tebKSwRUX8udvXNJkDbiiooX6gfuZmSSy9/Q0he
	 Q2PVeXWL1cyBR4zBPENOC/uTRtbPQbv7xwz5N0y0XOBNbs68VTZQsz+0G9nC7cZhSW
	 z9GtyO5rcxAXHbcOV1scCvZn2ytUTNX4f6WT8SN35VHX5meSSKA3WMdfCbK1akfdQr
	 zg7Wl2TcsTeuAyarVfb8BUzXK3cWHcd0FlLQ0Fvcs/O8DEG+5xOCk8aw9XZdzVxF7e
	 ZE4RZrUw7KuTpRlExGgR+z4yZ0NTDFMq8TvvT5zwOTBoBJ9qFjz2FwF79BRwXpBimJ
	 w4vDO3d/n7BkA==
Date: Sun, 24 May 2026 20:34:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/7] dt-bindings: iio: add Open Sensor Fusion UART
 device
Message-ID: <20260524-tidbit-shorty-a4754de1db64@spud>
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
 <20260524085312.15369-2-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q0wExonoB7NcF54q"
Content-Disposition: inline
In-Reply-To: <20260524085312.15369-2-kimjinseob88@gmail.com>


--q0wExonoB7NcF54q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 05:53:06PM +0900, Jinseob Kim wrote:
> Add a binding for the OSF0 UART-attached sensor aggregation device.
>=20
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

Most of my v1 review was ignored it seems. Please go back to v1 and
respond to the points I made.

Thanks,
Conor.

--q0wExonoB7NcF54q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahNStwAKCRB4tDGHoIJi
0tnnAQCDSpXQa9zNguEepfT9/B3dggegQXIR4aHnpI/Q5eneAgD9FpJm4lHXRqjb
OkFFwuBNTEthq/xFKvq5EEMGqUDjDgg=
=rGKn
-----END PGP SIGNATURE-----

--q0wExonoB7NcF54q--
