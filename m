Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A237C0E5;
	Mon, 29 Jun 2026 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747345; cv=none; b=la8rx67ABqQm0qP+7u2Y4nHi1T/PSuLyurF2EHgRMOImxsW7Zee56XWZ0yJLC2IL2vly9cNeQexwnJA8LY1jbRB8iF4mbO0kqFK8RBeRMfrgSKO/7hZe6bHIHjM9o/wDKf/uf+7+bkoaOjYlt1pJraWk4zJsJiS74bhGNJS4IVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747345; c=relaxed/simple;
	bh=t9chGVaa1WtKYlqTPv6UXZYIQhSIncoAkH7DNac3fBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLs01BIE3NQhtoL3aLUMQ9gVlPqm6/L32ErLJw2BSyoAZeQtIX2M7+rzCTkafMI6N3w/F7hSQzpY+LCKhdoOv1A5jfhSB1LwxHVAoI0sD43gcT5zabzwtLJLhu1JNkwsW35GkzqyhIsw5iOH/fBKlIM4UtSIiy205nSCxct9TCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F142UrWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F142UrWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BF31F000E9;
	Mon, 29 Jun 2026 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782747344;
	bh=t9chGVaa1WtKYlqTPv6UXZYIQhSIncoAkH7DNac3fBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F142UrWfol30Ah/1POus3FkRUx3FNpXX+q94mW9rJQgQWtLzfyYCUtguv7YIPwmYh
	 BhWJMcTnuqaIMi8j/eIa3jkiAVJ014iB0SpUvNNtGAUcTlyOYSkoxrM7kjbU+f0hUr
	 WFSGpZBTHTXHbLd8CxX1qyUYpJQidXs+ENJgfOgzkoNitP9Zepgoar14Him8KaVp9b
	 WKp1MPGLNP6ASLnr/2qSW0r5ILMSF2k0EDgvT2hcXRyL3E5TNZ4DPPJoGSz1IpJ7IU
	 Z6kU/mvCrSxB3CfQKXK64sG0KjuzUaPgwNKQcSuScz7RLsPY1/jhdZXgnKy2JpLznD
	 S/sQ4ZPiWaT0w==
Date: Mon, 29 Jun 2026 16:35:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: wbg@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, o.rempel@pengutronix.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 1/3] dt-bindings: counter: add gpio-counter binding
Message-ID: <20260629-trekker-estranged-754e9bfada16@spud>
References: <20260628210241.119825-1-wafgo01@gmail.com>
 <20260628210241.119825-2-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZOxRcXird+mP+OQW"
Content-Disposition: inline
In-Reply-To: <20260628210241.119825-2-wafgo01@gmail.com>

--ZOxRcXird+mP+OQW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ZOxRcXird+mP+OQW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakKQzAAKCRB4tDGHoIJi
0lQ0APsFvTDXWyHXHur0YzSMYJ4DaT12G8z+VRf+i8PGbKLBVwD/SH2IIbG9F5Ex
/Z9+tUVfeeUfLPKcYRvHkgXmvZtm9Qo=
=owo8
-----END PGP SIGNATURE-----

--ZOxRcXird+mP+OQW--
