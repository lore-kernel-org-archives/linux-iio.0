Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D247DFA0;
	Mon,  2 Mar 2026 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772482256; cv=none; b=stmjIx8HgdJ91sIKTg3YLTdDrkbxktLpeSKML2213K9O7EvJfYADsOXwRMBLndALug615VRNsZBqMtjo5swJomdhgmd6iXpODCBOXQhi4j6j/auGtHLwepc6mH/cKfNvSTHNQVSmfxH9q3xHtER3iU7UBJ3HXFXBwcJ4+rYaZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772482256; c=relaxed/simple;
	bh=qeYj2gAq7H8eA36J4GrAlei8yALkw0i1XJcZTTYnwtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhae+9rooEvcTTQQc2fz0nMHrk8UUY5+eG/5znHvWqH7CO5wiVopfUBNbLBPG+T4LHBv29FgjwWpFLv5tu750zS7yFkmNOAL6hze+QKMW8FUvWYsaKegrEt1STX7WOObmMzmI2ANgnO8RCI29my46rljOLPa/ZVuce4zckb0yoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5pCLhyQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5pCLhyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B2AC19423;
	Mon,  2 Mar 2026 20:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772482256;
	bh=qeYj2gAq7H8eA36J4GrAlei8yALkw0i1XJcZTTYnwtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5pCLhyQpRyGanhopGeIw05Ah8cbFcZ5BuELOzdONKvX7tgwMdmJ8k7KbuMVvUAhF
	 bIiixbs/xQ//m7EyrlNwUDsoDlmITaX3GmBaihDy4KgFq4YjHsgh0619U5OMwZZmsL
	 KwbZ815zHhLCV0uuLElQOKr+1dZWWwryAnF3koWNBYkuLHxZEA9jzD3lfqeAZBPk79
	 6FmYigWEnJlwJdIZpNLRj+qXeH5pln5yELw0MTHDzfO7rYvEP9qAbgU6jlj5ZYADuX
	 DQAFCr8Ryz5+UOOcdqvZX05Mv0LsiWhahdj1Tes2f0PvDNdv4+HxZR4OFbS51pzoAA
	 IWqIvf+oOngDw==
Date: Mon, 2 Mar 2026 20:10:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Jorge Marques <jorge.marques@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: accel: adi,adxl372: add ADXL371
 compatible
Message-ID: <20260302-detract-subprime-e99e1bd75a89@spud>
References: <20260302122116.1282-1-antoniu.miclaus@analog.com>
 <20260302122116.1282-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D9VeISMC0dStEaT2"
Content-Disposition: inline
In-Reply-To: <20260302122116.1282-3-antoniu.miclaus@analog.com>


--D9VeISMC0dStEaT2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--D9VeISMC0dStEaT2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaXuygAKCRB4tDGHoIJi
0vWZAQCTdztQQlxIn1YJ673Qk+llT571VOPjzUKwF6NRqhlOPwD/YM6z/HtMz3QJ
Mn+Bklrr3407pRw4DHUWuu7KWLVyJAg=
=MLTK
-----END PGP SIGNATURE-----

--D9VeISMC0dStEaT2--
