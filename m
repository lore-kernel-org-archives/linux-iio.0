Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B2468C15;
	Mon, 12 Oct 2026 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832218; cv=none; b=pEm+sOb7QEnefKX6o1MVE1w/JjiJPTcC6XDtwQRp77CfrtXtkwbH1BiHRM6DdGkJzSyhmv6yF1H5j99ZWiXyaUpRL+SLhN/T1k3p+FT894v2/qCYTq2bt4QG6Pt7HKymVBnnx8xw59sThxzk9wLOV6iezNPNWqrxCZAK1NFFBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832218; c=relaxed/simple;
	bh=uqzqPPJFRY6sFQmLHSQoXpCsILq/WivcCYqqa/zXNYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv2OnSvLeRnLNQaRz2xur5KhIioSlTUbkTU5QzwHf9ydeRp7uJqJUR8pJ/dBt7HX2QvEQa2I31PzzcKrpaffAWLR9MXrxEBQlIKavzeYpE3bnuKZ7fOxaT8yQ+bGJjqxbQo0AOFGs1ASuZYt0vpsj6Zc1wW2HvtzbPTFN9tTvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxlhnS4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxlhnS4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC051F0089B;
	Mon, 12 Oct 2026 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791832217;
	bh=uqzqPPJFRY6sFQmLHSQoXpCsILq/WivcCYqqa/zXNYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CxlhnS4Me+BDeGA8TbVeXn668oIoAie+WcSghG0Q7kIwUvcgnYmMYYv1bwUu8OKHc
	 uJKFG7ZCTqpRNU38JE/GX4LemQpbdhwJL9us9HBVdhjWrSGl+8Eg6c9tXOKhmrgW6Y
	 AM2UUMDycTNExFT6tTy8eNUfwng4riUkyLpSkmBEcA1qij2skDH3vLqZT5N3kAeozb
	 B/3/mqSL8f9TOXcQ2xH21opzKvD3LHlkEYgwJ/IPdMmdD55y5Z9psy+v0rzhKpDsOQ
	 0IRG9SijjMZqMsK6jkye4bGTJqWgvlL4uAyaT64Okrh+tfoOXmn5Wn2cOkpGBXkOEW
	 MnznQeE3+jkQw==
Date: Mon, 12 Oct 2026 20:10:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
	andersson@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 1/8] dt-bindings: iio: add Open Sensor Fusion device
Message-ID: <20261012-outgoing-bamboo-2cef661259de@spud>
References: <20261011231340.42885-1-kimjinseob88@gmail.com>
 <20261011231340.42885-2-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ksc6OZhJs0PmL1Hk"
Content-Disposition: inline
In-Reply-To: <20261011231340.42885-2-kimjinseob88@gmail.com>

--ksc6OZhJs0PmL1Hk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ksc6OZhJs0PmL1Hk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0wlAAKCRB4tDGHoIJi
0kBxAQCnoE9Mh0dZVLw5Dz2sc6maxBLRUqIkKmZQPhLEsLfNFAEAvWjdN8ZJOPJ0
DTl80WdPadYdfGXL4+HuvhFuNHlbUgg=
=kkqf
-----END PGP SIGNATURE-----

--ksc6OZhJs0PmL1Hk--
