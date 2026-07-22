Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BD466AFC;
	Wed, 22 Jul 2026 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738355; cv=none; b=amDwX4GqO25b+Imcdq/b6v1z5+/V9DnYI0xTP0YbQIjo5EVwgDM8u04GNzaTrhB79KSzkCp26m0eRgWFwYHTLBsfolv0Sz4z9Y9osaEb88q3cnqqYGKOrt+qRgM7t0xo/0c3SkmO8ZO9Mn1dniqT1kA4+cibkEuc8xkUMG/8fYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738355; c=relaxed/simple;
	bh=Jwu300nntlb13ewddWF26g9eo1g3L4jtlNQ27HHjg08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7XEJEqqh4r2N3geGYoHWTJI05uro07vtWJNdQt6kK7Ys1O0FjRYbuZvuayplWyYe1iMVz8sxWhc+skE+DezS0sfUVNcru1SArrMHwG9sbWrmpvJnOB4qr5YZO9PoqgtiI+yM/94bl84etx87SP4vT0CG9yN7tEdZJj1nA2JUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwHXKkDh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwHXKkDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116CE1F000E9;
	Wed, 22 Jul 2026 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738348;
	bh=Jwu300nntlb13ewddWF26g9eo1g3L4jtlNQ27HHjg08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lwHXKkDhB+grmXykbfjrw0DrVWItTExsIuOmxLJc4yCXIXD1B3XO65KwE8QxgiV9h
	 8YMizOlPU0ARAMm+yuwpN1s/HubTPNMp7t7DmUU/EOaAts24AGAVvKjZBIsJsaxpqE
	 PM7scCJCFq4BYpFc6YZ++vmnNz7qmxGpYF9AewxtCKL4B02tZQjQyiFiHUWCRqQ8oM
	 3g1TSVuKAoIVU57CNu4k6OG2ZIkF49cKs28lBXLCDKxkAzDZk0i5N78pkZBDrAnd0o
	 7UsE1poMKSPS41R4w9gh+SfvfCVbb108Yub/NeTl0UwR04XbIm0AsTpz4gcbhO6CaK
	 is1d4zUTEXJeg==
Date: Wed, 22 Jul 2026 17:39:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 6/7] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260722-backlands-transform-c68a2c79af68@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-6-7781cd74ad75@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PuhZMZRlsy/mq89J"
Content-Disposition: inline
In-Reply-To: <20260722-ad5529r-driver-v7-6-7781cd74ad75@analog.com>

--PuhZMZRlsy/mq89J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 09:54:18AM +0200, Janani Sunil wrote:
> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> buffered voltage output digital-to-analog converter (DAC) with an
> integrated precision reference.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--PuhZMZRlsy/mq89J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamDyJQAKCRB4tDGHoIJi
0m9EAQCvPVyT9IrFATmxyLOLuSjLFY7/e49J2++Eh2Pspa6Q/wD7BKi1DcWUSLth
GaSuCzGbw44f0FXynpCkxY0A7D7+QwU=
=XIrL
-----END PGP SIGNATURE-----

--PuhZMZRlsy/mq89J--
