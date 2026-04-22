Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01DD14AD0D;
	Wed, 22 Apr 2026 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876827; cv=none; b=X3QmERIlI3yHc0jcJ86F20DzT+VmupJ9eCJbg4BZ67Ap0dMXS/Q6Zutg/N3dTK5/8CDbOWyMGwULe22cS8hDdGeBTBFIKxnvwxhrPvox8j376nqtiGb7VG6UROkq5YxsGF8jhs7oK0sBNHGJ3EOoBqqa5KWoGVtUFePOMuafJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876827; c=relaxed/simple;
	bh=Kf3tiKfUPBf2Itg1+pT5MqX+UlYfv3dXLfRYzeIK2Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I78AcwXlbZFSDoQdVZO2+vCfuJDg3okCEOm86NPYX3YRjpsm3dFo7Is4cwlLcMq5eghloA4C5NyOSSKAMtvWzgNjX+SD6MI5VRej6Ydq3zXtgyUSiG6xYhFvzIgyqQJj+UxoU4gmbWp5j/0bZH0xbvcRQUHOTzY0X/d2XwdLwAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcJ4/PPR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcJ4/PPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A486C19425;
	Wed, 22 Apr 2026 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876826;
	bh=Kf3tiKfUPBf2Itg1+pT5MqX+UlYfv3dXLfRYzeIK2Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcJ4/PPR4pVsuiuDLBHWqGNCVsvfMrk4gGdxKlMH/KrxYzEoDt0Y0jVp3iHX3WC7T
	 dhTgwfXydB6uD6kAoYLKtoAGSp6uUqNvezdq3DBBRXrAR5QX3Y8TO2L+iy7RxSc0pd
	 8DWU68hLCUm1KoRDi80y4AuJWxSea7Bl9vHSnWrSVceeuHoS1kbXxEN23lxuOi6z8u
	 lXwonHpZ72WYbzPyDb3aYH8O4JdMuO1ZuyGN4jnoMTkGo1d6wRQ/h6tdWNV3w0x7iz
	 AvI9Ocf2PELe4IjWBNQa9+77KPUopUXuRvx8lg/yZwlv/W+Hxit1TVNuekBIm1Jf/e
	 ozFFEUHI9ezmQ==
Date: Wed, 22 Apr 2026 17:53:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: mcp47feb02: fix example
 indentation
Message-ID: <20260422-lunchtime-hatchback-14f42177cbe6@spud>
References: <20260422-mcp47feb02-fix7-v1-1-709c7c02799e@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LyKibLmoNturNUxy"
Content-Disposition: inline
In-Reply-To: <20260422-mcp47feb02-fix7-v1-1-709c7c02799e@microchip.com>


--LyKibLmoNturNUxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 04:40:52PM +0300, Ariana Lazar wrote:
> Correct inconsistent indentation in the example and use consistent 4-space
> indentation.
>=20
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--LyKibLmoNturNUxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaej9FQAKCRB4tDGHoIJi
0gHHAQCtFmx9oTfcU557pLDUCkrFXzsoO1J0YrO9AR7OMM370QD/Vqj9zjGXKF7p
OHl20Fe9rddQoHvkL7t/xVj/16ikJgE=
=accy
-----END PGP SIGNATURE-----

--LyKibLmoNturNUxy--
