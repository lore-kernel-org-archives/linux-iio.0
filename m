Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F93B8127;
	Wed,  9 Sep 2026 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951258; cv=none; b=R+CL10oBQTyXy4bysopLcgIKMyHlPN1eNAD6gK08OKrO/pnDOW3LV1SUXSn7uNjXTXU0yuFlH+CCTiRub7wZXdD7H0zBYlWBFicuJq2aPHkq3p+UOrlBcC+EbgL6tIlVxZckkdegcLQtxa8L96bogp3jBcWBj2VV6Be6g9QBNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951258; c=relaxed/simple;
	bh=MNk17lxuCK92TbUwb5e7bAe4xCzrUTki/YNCz3lbSYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFFIemUUvoD0qP+gdayBq6xPiN2I5kf+DEiCREhdwl+ug88h4gNJb1AeLg8XUXYVFsp+5pM4KS19ooCwukjpNzoAXI+o+XGaMkUVeBUwccyG6vug02jgef8uUm5da9PjBuJU8J+Gve/ZZTX3b31u9bnhd7WdtIaxuR9MKJwDuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPC3t407; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPC3t407"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CED1F00A3A;
	Wed,  9 Sep 2026 10:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951255;
	bh=MNk17lxuCK92TbUwb5e7bAe4xCzrUTki/YNCz3lbSYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CPC3t4078dxYEKzGd6eq0Hn3U7Uz7Cr3GOIl2Dshs7/kKePVziHlovDWB+VmdPTAJ
	 5mc1W3xrf+hJpnHbAVOUKv23Fh8+/Ma2MlSRQU+EpLledzM+lrynABejib3IpuyhDo
	 4PkDxUS4gMoxmnn2zgXqFYbzZj5kjnm4BTEWXe//3DhYsc8mG4zVlE7GgTaJQkvK80
	 0zCc1I7Thww/scG/4hfKzWC4ubKFV8CCvzcrUWhrkSauiq10aDsIvTkD61GLsWrtOs
	 CrTjc6mof5B2+PYNrRWIyW+W+tlNDeaTA6OXbV8OQY+zJ416qanfNOW/qb3Y35bkVq
	 c03nT558cjadQ==
Date: Wed, 9 Sep 2026 11:54:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux@analog.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: ad3530r: add AD3536R
Message-ID: <aqE60T0Bf82j3XK8@squawk>
References: <20260909-iio-ad3536r-upstream-v1-0-16ab930dcee3@analog.com>
 <20260909-iio-ad3536r-upstream-v1-1-16ab930dcee3@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u2hP8AO71Wm470Ed"
Content-Disposition: inline
In-Reply-To: <20260909-iio-ad3536r-upstream-v1-1-16ab930dcee3@analog.com>

--u2hP8AO71Wm470Ed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--u2hP8AO71Wm470Ed
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaqE60QAKCRB4tDGHoIJi
0kAQAP9Cqpv9J3xQ4YdidSCTO9BPzW9YgrOw/D8Dp+oL7uJpPgD+IoVB5Shlzxmb
IogJd5q9MuyyorYpbk2+pHDmlwsIJQU=
=gpBL
-----END PGP SIGNATURE-----

--u2hP8AO71Wm470Ed--
