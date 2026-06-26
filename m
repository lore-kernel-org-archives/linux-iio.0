Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BE403B1E;
	Fri, 26 Jun 2026 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490376; cv=none; b=m5YHZdUiW9TUdkdXbh+mvX/v37TQth48lB8lUGrrd4za/c01HT8xlUAYBLvIl71h1RVNqEDfV7aoJcAob0e5+UU1qLwcspHtxSQnPfCTsVax5nZCwW21A3xSDvKOtrp3Yqqz7bCxCOcBKRbSJJmYXYbsohv1Hzo2kKjWSdgy4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490376; c=relaxed/simple;
	bh=fuxlO8rQJXJag5wZutRDAqyYjkaS1xFZlIYzahCqOSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guIYV9dAvu4lwhG/ZuNMaVPLP3aS6ll2C6UPGnk+7T+BaQJX9c/xKCBJjCK8LMDEaRyv+7nbteW7kHGwDLUeaxVuYkADKzRm1HdpylNa5+mOEckb8mXtJBWG0u6qbAcZX4wolpjv/2gULofhDP+7MjYb5+eW9TgBIzMxHy/vifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0X43bRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0X43bRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A601F000E9;
	Fri, 26 Jun 2026 16:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782490372;
	bh=fuxlO8rQJXJag5wZutRDAqyYjkaS1xFZlIYzahCqOSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T0X43bRadiUroeVz8dlITCV2MkkmwuU6B3vFlgJdjpseukO6vAtqVTtthuyX1HIeV
	 Q8cr1slCu4PKOMCzK2kyOeOabLdqwB+4ctEH4Lrc193USRK22U+IrgXCY0kffvRLNx
	 sEIWpuLUNanU+9IPgfRGO7cSxmmPLJ0NbrI/q9VIKNdFhPFuzGgo2H5ilWnVRlTxVQ
	 ynVsjzwJDZJvt3kU8IRrkjk2ftq3Hm424EYKUa3ZBei/jrxGpkWm7q9W0t+N1fJKyB
	 DkUvHcC+9KWSZOiPmjAr5Rq8oM6SL5JMvNiDW2wjxysdJT+dC9yae4+LuIa5mlWND/
	 pTMEOQYIDmkWw==
Date: Fri, 26 Jun 2026 17:12:48 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] dt-bindings: iio: adc: Add burn-out current
 properties
Message-ID: <20260626-heroism-science-897415141eb1@spud>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-3-ceb9b0b561cb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="btZYcrTFaIXmzvTj"
Content-Disposition: inline
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-3-ceb9b0b561cb@baylibre.com>


--btZYcrTFaIXmzvTj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--btZYcrTFaIXmzvTj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj6lAAAKCRB4tDGHoIJi
0q1XAQCTX9kxFXuPzfoEf07r2MWwHKarUXY5mAw4nhqSDF0lJgEA5gwzFB4Jh2Au
gozhJw4VSahC7ySJuwwyD3pJeO//4Qs=
=B1mx
-----END PGP SIGNATURE-----

--btZYcrTFaIXmzvTj--
