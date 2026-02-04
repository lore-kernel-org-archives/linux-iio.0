Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8C3D348B;
	Wed,  4 Feb 2026 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227832; cv=none; b=H094ZGRvBriup1xkoC+95Mr9Zi2ksFRJ8kgP4m0Nf/pPPUAExsAzIzHHDQ6qbClhOPmFeELnSMvK+syTrBVOIaT/ke/jJka0LDGM+NWcbHsCZnZM+YjNg8OA5WzyuyKibmIp7RrjNUd0p745XFbnSqgXUuMKbtiDCKUGdmSxpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227832; c=relaxed/simple;
	bh=u8eitFun7SwUQLUe4lI2x7ITmzwP10+eke8n1TCIBo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGF/PgkYhJUPFTardQwWCfLK9uNzz3dRqXxOiYjpB/VthqDKgTtfyypQz55WbLIPs8P1r2i7eBxBKlZESe803bYJ6ZHBgpLKSMKMAkOqSN3gqCLBaAoTdCCWwQIemxJqugFKfNOk6zDDmCdVcakd2UeAU77ATGFgoA5xSEV1MnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkQPj2rw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkQPj2rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DAFC4CEF7;
	Wed,  4 Feb 2026 17:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770227832;
	bh=u8eitFun7SwUQLUe4lI2x7ITmzwP10+eke8n1TCIBo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkQPj2rwDrtcLYrGcG4N2wnrcNGyKy7nzQ3jRTSjNCKqjL+G+S3kGbm8uUcouJdRC
	 NnkWvhEVjyOM8di1SAr5TUVOCDEb1kE+6GotGqkB3rqkI8Oi4jWEBE6DvMDjXIWvtK
	 v2IiLbKg+BFoFUE9wdJJU9FKyT9cfduhnouCR92THN8nfpBRCD+ZnmEek8hJDkGgol
	 oanVe8iwloYiRX4QWNZLgDNQ7kZtfvUOQPeuPU+fQXex2fzOYRDzVkb1lfhoIHVvU6
	 GLRlcJoKfHKXuB9Mt2vwhtTW2d7s2Z4RInne8KPSHPdetMON1KIzUbjcz2aP1PsdHV
	 +k3Yn62vDaBtw==
Date: Wed, 4 Feb 2026 17:57:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linusw@kernel.org, stephan@gerhold.net, hns@goldelico.com,
	jic23@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: accel: bosch,bma255: add bmx055
 accel binding
Message-ID: <20260204-unsterile-eastbound-f67032657b5c@spud>
References: <20260203143946.301233-1-jerrysteve1101@gmail.com>
 <20260203143946.301233-2-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aPwjS0UqukRY+ZDb"
Content-Disposition: inline
In-Reply-To: <20260203143946.301233-2-jerrysteve1101@gmail.com>


--aPwjS0UqukRY+ZDb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--aPwjS0UqukRY+ZDb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaYOIdAAKCRB4tDGHoIJi
0tBjAQCT1P/NH5fCQuS7p4MWehpMRhIqlYHQ4O2jNofDU8c71wEA77pZHwRhBw7A
tYHfIOKzTTTS4fOYZNRgNDbnlbI1ZwU=
=v5sf
-----END PGP SIGNATURE-----

--aPwjS0UqukRY+ZDb--
