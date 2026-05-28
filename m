Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E772F7F13;
	Thu, 28 May 2026 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987499; cv=none; b=jIMRBxDADm7ey9bolvZDeZW8BG3vgwke7vPfZVS+kUqWsmbJF3BDHyIL5kFLmCWQGKRO/9v8JvkQ1mUPbaQGa+lVgY44l3Nz/jG2buPqRqYVrWNImxCMP1smTMN7s4e62vj7eO6VQdEMA7V4u96gpq1Q4i+elenbxHhLlhB1qDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987499; c=relaxed/simple;
	bh=CV93Gs2E+7eZBdUXfjVjpaPPMzba/gMgpOXeOIaQgWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dms8jsBPikmScJ+v6vK9E7M0LvR5kmKpdeQxOvMCrDSwCVqaZYxDO8P3tXChFRctw6/lGy+YwSPf4xMpNarCABQ//63S5N8boGW3WbNXVbTDm9T4NeNuYc0Fo2ZF7PWhY/F/723C/+dmXuV8pteE5dWTGlFMc5YD5jc7jmNecAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu5qWQfC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu5qWQfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E051F000E9;
	Thu, 28 May 2026 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779987497;
	bh=CV93Gs2E+7eZBdUXfjVjpaPPMzba/gMgpOXeOIaQgWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iu5qWQfCq8RVzoag/agzz6AaZ1ZM+KV0qvqExW8JUegyT4lL2Mm/gMZMDrXfxh4nI
	 SgroGxpyHGslplr0SIoFCVZmpjRmUR20R/6VTu6gqJaktunb0R15UescY1y4vJGfLS
	 GkODt4oyIBYhJb12s/iqvpm5wp93AzRCqghBI1u802bKmFb+jE+W15AXh9uDCLbLoi
	 igI1+5CSJJu1pX5W0tBXZe9nLQNTCLtnTt2VnIfwU+SlqikIcLaslaEN+Fye32Q/SO
	 AQL5/PcmwJkLj04EMESXRxOg3Jsz/QTVndHK4m/clVJbYSLPz4N5t+cxQmMxqSIaCA
	 6VUFmya5Vnw7A==
Date: Thu, 28 May 2026 17:58:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add Axiado AX3000/AX3005
 SARADC
Message-ID: <20260528-skirt-mahogany-426302fd462f@spud>
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
 <20260528-axiado-ax3000-ax3005-saradc-v1-1-345dd5f6608a@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="glY1jcPOWoMvQi2Z"
Content-Disposition: inline
In-Reply-To: <20260528-axiado-ax3000-ax3005-saradc-v1-1-345dd5f6608a@axiado.com>


--glY1jcPOWoMvQi2Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 01:10:23AM -0700, Petar Stepanovic wrote:
> The Axiado AX3000 and AX3005 SoCs include a 10-bit SAR ADC controller.
> AX3000 supports 16 input channels, while AX3005 supports 8 input
> channels.
>=20
> Document the compatible strings, register region, clock, reference
> voltage supply, and IIO channel cells.
>=20
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>

With Jonathan's correction:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

pw-bot: changes-requested


--glY1jcPOWoMvQi2Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahh0JAAKCRB4tDGHoIJi
0rtoAQCZC2aiWxZMTWZ3jWNXeFb7Fiudf+Cu7MtTU9w+jxaBMgD/SChuRYlmFBa5
mP+H04la6HHMbSF+9EdYltYwv7m/LAI=
=Ve2X
-----END PGP SIGNATURE-----

--glY1jcPOWoMvQi2Z--
