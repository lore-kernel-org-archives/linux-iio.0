Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05305492524;
	Thu,  4 Jun 2026 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592520; cv=none; b=VgPyr+cTWmS92umj9V8eHwJMTjPTDbi74nEHQBqxnBqaC+dwBr8yWC+g5AMMqvkSvzQB6O5/zgKNOKTuZ6iFofbf9Odbyohf0GNbwrxwtvjgUdgEN+ZGOlG3rbrzDMsfmtf7dRryDgE61uaOWetyzsII6AvxRDHNYDybzZpc+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592520; c=relaxed/simple;
	bh=raAy9temd8hB86sOsCztiHa1ETJjvPFZC+qYV20Pnk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiT7OuAjC02hAyLksUx75vEOtdqIj38ZMZN4EbQ/Yp5CJvGh1RY0sJUseL2Gv+UhLnqXlUVH8pw2WxOTqTbNu6SL0EGuVo8SRYWRIq/dGHIeW7PRGZtsGJd72sv1mVQNjoqWAJTNDBronosaTrL47W2A0HekPLJ5OQWvwQeKfVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsrX6ZcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsrX6ZcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150601F00893;
	Thu,  4 Jun 2026 17:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780592518;
	bh=raAy9temd8hB86sOsCztiHa1ETJjvPFZC+qYV20Pnk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DsrX6ZcGomliWleDZgsl9/9w/dUo1cu3WCnsk1/eJpseVK5uKzA3b3n2kB1kGYnKf
	 fMYsqpy38fvaN9C9sIA4nG2oA/2B2Rn4u9MtRmwTWtV2jdCILIgJQLPy4y4cgNa34b
	 UR8MKMp5F90BJlAAzCZufANF1EJ/SXuwVsVBjZ/vNdqbm6rQ6mhWTqoqDB5c8RHCBF
	 C79gmKzVl/JoQhwfr0nZjXE8Z+zx6bURkT1orMas1+CcONSp4DZD5fk7GQFgYHP7hn
	 lgA0yyJ2ZHTWkgRQM7YIuXJYjHoDUu6hykEZDUmuvpdj47aJxG74p0KT/rr8KAYd7m
	 aDNLa/dCwJLGw==
Date: Thu, 4 Jun 2026 18:01:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: dac: add support for AD3532R/AD3532
Message-ID: <20260604-monogamy-barge-4de86326873c@spud>
References: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
 <20260604-iio-ad3532r-support-v1-2-c3552f9031de@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XenaTFJ5bkpYZG1A"
Content-Disposition: inline
In-Reply-To: <20260604-iio-ad3532r-support-v1-2-c3552f9031de@analog.com>


--XenaTFJ5bkpYZG1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--XenaTFJ5bkpYZG1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiGvggAKCRB4tDGHoIJi
0vcNAQCCthVAQIcuIQuiEA+q906aQIm+VjxGwHzINV5+fI6E5QD/aNM6g1+GobRT
WZjZyCBSo1p3bogDr3xrpAFEx51OEwc=
=dDfF
-----END PGP SIGNATURE-----

--XenaTFJ5bkpYZG1A--
