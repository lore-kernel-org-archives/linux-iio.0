Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A891389DF0;
	Mon, 12 Oct 2026 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838946; cv=none; b=XhaBTN5GSnGJcvczOaVCuxg6CzDdg+iR2w+CnzeehSlTqSg3I0jWD14Zq1mH6QahfSKJeHySHtbIAeNBEVhqchspPCgU9vZrEgmDmgK1WUi6V5D0Ktx3d+HgsWCfBTjIcL96VIL8VtHVz23jAiArH6xb24twn9HjaW/08mG+AJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838946; c=relaxed/simple;
	bh=BWcp8FvSxy/trB9yyz437nnSLTWJI/ifDFnTKOFPVMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukGPjSThGjyjPvINXsiV9jUhNPxy+TUYMWNksYLWv0fJXH8SgyLZUpDYcYEfTuKHmFEuMSadXtCBza/eqCFhOdB+GOgzYBojKre5wYh52phefKypya4Gblc9Fz0YvaxDTQOS6fuvStuNEIJgxp9O0Et11cRytA0ZmVwnC1qtkGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bv7GtmUH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv7GtmUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763B41F0089B;
	Mon, 12 Oct 2026 21:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791838941;
	bh=BWcp8FvSxy/trB9yyz437nnSLTWJI/ifDFnTKOFPVMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bv7GtmUHxaDMbcStZe40nP0glKmx9P/w+O+2fnQpfpuz6l5OlxWX2EPXFGCHLbCGE
	 zy8HQ0ho7pgj7X0uAu/8W8wxL9By7kizfdjZbsggWsTmM0g9sPdwWYP2v8p4T6oaj8
	 IDCcBVvoH7WltLA/pLcbS/e4qzoRX22qmy7x4hC9/aK9efWPWkM3+91cbvsQrf7Gna
	 DcgeGlI+KTqsbIpoEEj4E6kzUu0i+GvQQHhtaQ/T5gkqarMKWCwAXtNjos00OotgDt
	 RSpltaY5a/vPMs7xC61xIaHOXxpUESXQ4YgXWUkLqKqscMXIba/6XKWAzMwWl0KYwW
	 vb0Pgtx1wgerw==
Date: Mon, 12 Oct 2026 22:02:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/10] dt-bindings: iio: adc: support the TI ADS126x
 ADC family
Message-ID: <20261012-avert-sprung-6f98f8ac3ff9@spud>
References: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
 <20261010-ads126x-v5-2-49e331cb2fed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WrIjd18zoM77510l"
Content-Disposition: inline
In-Reply-To: <20261010-ads126x-v5-2-49e331cb2fed@gmail.com>

--WrIjd18zoM77510l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 03:52:41AM -0300, Kurt Borja wrote:
> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
> integrated PGA, internal reference, excitation and burn-out current
> sources for sensor biasing and diagnostics. The ADS1263 is compatible
> with ADS1262, but includes a second auxiliary ADC (ADC2) to perform main
> channel (ADC1) cross-checking measurements, system background
> measurements, or temperature compensation of the primary sensor.
>=20
> Both parts can configure per-channel voltage reference source,
> excitation current sources (IDAC), plus input and IDAC chopping for
> offset and IDAC mismatch cancellation. This lets the device drive and
> ratiometrically measure RTDs and other resistive sensors.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Previously I commented that this was probably too complex for me to do a
genuine review of, but David seems happy so that's good enough for me.

Since you changed the stuff I didn't like,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Thanks,
Conor.

--WrIjd18zoM77510l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas1K2QAKCRB4tDGHoIJi
0lxxAPsEUQ45dfeZelzRsCs9VIHzlKUyf/I687/tenK3YdfkbgEAsDn2vGAUBVsl
1vIZSJx1iSkp7zOli/fVkTxbvepZVwA=
=VlVn
-----END PGP SIGNATURE-----

--WrIjd18zoM77510l--
