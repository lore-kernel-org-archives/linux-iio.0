Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1515743D4FB;
	Tue, 16 Jun 2026 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624576; cv=none; b=E9tyidrlNba6n5V8M+uXfW9ySN25heiF3IdbtyVM9qyM9Doa9LEV34R5ZO1sP6GtmMWCMAMfYi34tDNlaWONvN7O438rSQcFKrE/qclHc2OY+HN2o/gSR3vXFGFG3SgbeTnEkR+9sr5/U2S5NbKuN3qHpZ02xvU/i92h6iIT2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624576; c=relaxed/simple;
	bh=tbZdYRssnMc1tPdeHTB9KBupFi6MeJUHUJTnqK3jnro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEiJ0UnXXxaZXA20mEJJhC4+f6RijVMKSgmtHhxt3PijMOsGD+UNe2kbHgmHA495DBn3s/fOX8bwQ241H/Z0huPCZ0WD/Hb8e5GhFnYlNk7y2Rl8Vw4m0nbFj0r0JSl0TYOEpDSukEseKNVg19nDD6Duda8PSfueWY1pHYD0Ubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqwoSB1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqwoSB1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C471F00A3A;
	Tue, 16 Jun 2026 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624574;
	bh=tbZdYRssnMc1tPdeHTB9KBupFi6MeJUHUJTnqK3jnro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IqwoSB1d+aKHgby6Y4P4Ha7VF8hUwzGg6nG5zg40oY9J0K30b4CaK6j9KWm1Vn+g7
	 Csi63qULUfrzZAT68L1qhRpv58jJ1IOKApIhC1iIuqsxBLaAJXBrOu5ot0X9vmU10r
	 rXH04jarToFjb4/BuKjBTr9uoIBFu+NmV5WPQU19mSJG5HR2sKne8Bf+PqIdX16S7e
	 ndASXBARK/a2wMOo4EI8ZbEu8lPt52OK4N+k7ZavhSiLBpbsmfrlODO3EhqcB+rubE
	 6iArfdeCqnz5aD/ZbzaJa5+UrwlCPWf52XIB3Sz1TMlyCjZfGrJPUyTdYUiSMNXTK8
	 eUS409YJsAcCw==
Date: Tue, 16 Jun 2026 16:42:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: magnetometer: add QST QMC5883L
 Sensor
Message-ID: <20260616-camping-slug-15ebd1524376@spud>
References: <20260616114942.37241-1-siratul.islam@linux.dev>
 <20260616114942.37241-3-siratul.islam@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uiONKxPyM9s9/R2T"
Content-Disposition: inline
In-Reply-To: <20260616114942.37241-3-siratul.islam@linux.dev>


--uiONKxPyM9s9/R2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--uiONKxPyM9s9/R2T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajFu+gAKCRB4tDGHoIJi
0uXZAQC/+uVjuHYjYXHgKGQc5XFKXXFRcRzLwTzZngFLZT07IAEA/RcmnUdMAotS
iJ22/o/3O8oUSPj411v3V71Pcm5NJgo=
=unlx
-----END PGP SIGNATURE-----

--uiONKxPyM9s9/R2T--
