Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5253D88E2;
	Wed,  3 Jun 2026 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500554; cv=none; b=pmJ3roJbGNPl55f29juEv34OgSX/W6qoiu/1ur2ausizMnx5vBoAweMGvo5SjDnoBXLTdaHETZHaGFEpklAQtcHviAtsZgqy3bZSlztAUvosFoAgeZGk8V96X1FQQxZO+u0fMeUqQc2u7KBUSoWBoNP/NoV89dwg/0f+eOMGcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500554; c=relaxed/simple;
	bh=dEM4FZiYxW5GwuHui+XET6DH4BwS+45tvNzCTdARDiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzYGm8V662SAqm/dHxyxgJ797zmUtb2m8azXmCGwktOSrdZA2RyBcxVtTQ55rr8miU1aN0ZE3Z3Z4pEHYHN8B9qOGb1PfSjzd+T9JhEmFWsOPbY/UdlzRIeFGXnO+SPtYMyiaEr2iraZp+qrNbMZiSsaH9anwxF3VBSJRZo+tvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbNOyYyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbNOyYyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6244D1F00893;
	Wed,  3 Jun 2026 15:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500553;
	bh=dEM4FZiYxW5GwuHui+XET6DH4BwS+45tvNzCTdARDiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PbNOyYyiz8IZwYJEG0n+fAwOz9+vF5Hul7AVXy8HkjLQIU0/XpovG6Jhk9K9J3EJ0
	 1chyVNTtz1Tn7m9cplpxJ0DhUIuCFfx/fftXz7AnyRKtFDKXF3Tjl2FdH4mB/m8GqM
	 7y5HshQOQBAwkky6kjEWWk6NoL+JucNJr0V0z7Cyi+3y5VD3scuUxqdSXSD119Y0c7
	 jPYdXBlB2gW9DFH2i3Ad0CJfJ0iQACnUihbBxOpAlsqLJ5fllY84TylNXH0uMYs5H2
	 tcpIK+O2J7TZK7iiymP2V2Z4KvPPI8DGKKcBfWkG6Dgg9mGymgM1vhEdlsayvPuod6
	 1bAP8cKUa7nOg==
Date: Wed, 3 Jun 2026 16:29:08 +0100
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
Subject: Re: [PATCH 04/12] dt-bindings: iio: dac: ad5686: rework on power
 supplies
Message-ID: <20260603-jinx-comment-893bd09b67e9@spud>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-4-691e01883d27@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MaYwtlXVLhGyALtk"
Content-Disposition: inline
In-Reply-To: <20260602-ad5686-new-features-v1-4-691e01883d27@analog.com>


--MaYwtlXVLhGyALtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--MaYwtlXVLhGyALtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiBIRAAKCRB4tDGHoIJi
0hHpAP4vSnt2gJc7cOKZ5HA16ZE9X3/61xB+ARF0TMDXNE9uhwEAjBaheBYS48KL
mADBl6MOPknJR45HEpYVF36x6gnu8QA=
=OxSt
-----END PGP SIGNATURE-----

--MaYwtlXVLhGyALtk--
