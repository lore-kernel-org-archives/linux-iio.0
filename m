Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5532FA2E;
	Mon, 20 Apr 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699448; cv=none; b=Pn/1tRPIAbx/xak9z+WzTnhwFGKaBvENzcrvOCxQ5PISKB260MFQDFsjTHyXbwPr7lxklYCvD3lKAdO9TNaQpZU++xYiDyuII8tVlQmYbJr/E4www4b7/obtDGwb6aNRjm0ZN3K2tTDta5fqRwB/xo5mI5ubKMx2lAlZ129m1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699448; c=relaxed/simple;
	bh=HiHsLUK/vFKLqIDlv/OPnzbXZIRIXmBZ4vGVMo0/F/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djOFTSx71MjaOuep1NQ5ayjdQsWLgw2DIob+gHeTtxGtGwHCDB9TRlWrTJmw2FN8wRiPBeAlV0gn/spgEvVFcep5+fMGXIowJdgW3a1eAsDB4bQ9kIcXeaJfTm/JmfEQhdqPnPaoa3SNiKO7Ij464hVIgS9M+60ncH9ak0yfCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvz2X4IM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvz2X4IM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EA6C19425;
	Mon, 20 Apr 2026 15:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776699448;
	bh=HiHsLUK/vFKLqIDlv/OPnzbXZIRIXmBZ4vGVMo0/F/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvz2X4IMtni6rpX35awakMiINmAr0vcjtAt7WrohZmiu5WO97s4Y2D/ReS6Od599N
	 Xef64Pw92usjwHUUlfdb0IMz4/mglkPx3nJiS58rZQq6BIRBjk4ctpTbdbjFrjIMQx
	 coHS95t3a4rAeoYVBMXYtObFaOzU7Ds9Xi/wbyMZ6AVJwpHADy5U5Y+ou3pQ671ZcQ
	 Pht1rrYa+02rFuOTSUxPrLp8jgHwazuw0MqBNgdt+79LBSaHD9woTK0Mnw+V1RsnxR
	 MgN2sHRhd9CocC9Bh7vwLMuvxDuwS0+a/vXxsy2n6GlemlGudVyWo6E+Ppw3u8X6Wy
	 gZp36gELtYTNA==
Date: Mon, 20 Apr 2026 16:37:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, wbg@kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: counter: add gpio-quadrature-encoder
 binding
Message-ID: <20260420-visor-sworn-736fb32beee0@spud>
References: <20260419195908.12202-1-wafgo01@gmail.com>
 <20260419195908.12202-2-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+MmUcQ09GDjPuGUN"
Content-Disposition: inline
In-Reply-To: <20260419195908.12202-2-wafgo01@gmail.com>


--+MmUcQ09GDjPuGUN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 09:59:06PM +0200, Wadim Mueller wrote:
> Add devicetree binding documentation for the GPIO-based quadrature
> encoder counter driver. The driver reads A/B quadrature signals and
> an optional index pulse via edge-triggered GPIO interrupts, supporting
> X1, X2, X4 quadrature decoding and pulse-direction mode.
>=20
> This is useful on SoCs that lack a dedicated hardware quadrature
> decoder or where the encoder is wired to generic GPIO pins.
>=20
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--+MmUcQ09GDjPuGUN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeZINAAKCRB4tDGHoIJi
0ulqAQDtYixKHZymy0ZCqoRyCwysAQ4On8NIf43v8CB2XFPttwEA2c840Fl2qFrm
LiFMxz66pD6Xng9Sbd/N05kYHIJUqQA=
=beAM
-----END PGP SIGNATURE-----

--+MmUcQ09GDjPuGUN--
