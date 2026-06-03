Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127D48165E;
	Wed,  3 Jun 2026 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500358; cv=none; b=q8fZowC2QoqSpoNErJTLYVyh3DsoaZo+P7e9MxGerUoH+fd2zVFaDhvu4pmIy4BnKWx+xVl1K/q3ScU5B47pHs4BFz9eAiRNU2lAenJpQzYV5sdNCnMPtsWbYAVTFXUU9c1zOS5JLAALGhLLclFcIMFaZCNB9fZZHO3kPOuZqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500358; c=relaxed/simple;
	bh=vpI9UlXlDYY0NO+W4KrLBKTpphqWb+zi/Wll4Nl8qIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck7Xvz5rG9kH9T4qHExgewR2uI5ojWOvnYp5Sh8OXcZi4qpufhtvW6eE3Z/TWwbYq8+z8y12GvJxQdHpWUE9/eRsayHEXjQFwLDkMSfukkOtzRT4s8l+qd/IiPft7W+BNiLrk1X/Ge3QjRXyylT5SBYrGN5Hdp+DKb0Agb6WKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=invrlklP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="invrlklP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96801F0089A;
	Wed,  3 Jun 2026 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500357;
	bh=vpI9UlXlDYY0NO+W4KrLBKTpphqWb+zi/Wll4Nl8qIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=invrlklPQhvxbP88proC3Plz9nVtaxqinJ25AdghgvtH0c+afIsd1qMAHMaYkQ/4f
	 ajdQ/XxMZiCg7bIvZryLx4qtjhGq0e9Qnq6yfbpY5QBWXQ4LlHHkBQ0LSijlnwkCwX
	 NHspcpjgekhyin7Xp4I3NQ6qdQnEcGj8onkDiBnwZLK7vbynoZHrydBrkMuihOiGI0
	 ftSBLGfVIKkGAwsbAuKgNqK9BONwwvd0Ls3BDiuz5ZMfmxp9sk8GEWXltoZl59j26U
	 65bW+qGHsfWZkmFyofkppsok9CMbDlR5HIdrpyo7r2QbozI/zyoEaBUeVGwioN5q35
	 ZeeiqYJnS4y1Q==
Date: Wed, 3 Jun 2026 16:25:51 +0100
From: Conor Dooley <conor@kernel.org>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 02/12] dt-bindings: iio: dac: ad5696: rework on power
 supplies
Message-ID: <20260603-rebalance-patronize-072e4eddd245@spud>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-2-691e01883d27@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QLSlSIjD+C29P82i"
Content-Disposition: inline
In-Reply-To: <20260602-ad5686-new-features-v1-2-691e01883d27@analog.com>


--QLSlSIjD+C29P82i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--QLSlSIjD+C29P82i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiBHfwAKCRB4tDGHoIJi
0jHJAQCxQQAjcMeB3bz3Apn68lqlpLd+QdVynxxZ5p6DhDhyAgD9EVGJM1PfBni4
OMqKbgXb5tps4BM3ZlRS6a+LbgU4vgs=
=ZXr4
-----END PGP SIGNATURE-----

--QLSlSIjD+C29P82i--
