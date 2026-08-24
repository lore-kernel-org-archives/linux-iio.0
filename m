Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD2377EBA;
	Mon, 24 Aug 2026 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589502; cv=none; b=aF5WiE7AXRGF3LYAz674jdB7w092E0hcYLs/YCIxZJR2XtUBp49KZQropIK7qDwgS6vOvdqjZeTNFPB9aLwKDGhlPfL0PssQZV65wEHAE01dw0Y8iZmo6KBRA4uKow2fcXVBnK7Pb359yqR6arUpnb4QffWmMNIJfVg7lEG898k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589502; c=relaxed/simple;
	bh=hU/sAaDPsIpBC9ELNG+LmYrzgz9drI9Eq5U9BN9RNqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYQxXdPcLZIbuEhkKTiw+xyztAY8e378VEKhj8KoSZDlO0AO+gL3WhQaAoCz8GTdU/Igz4A9pfhfXkDQKPjisCjexl7NiAVffhm2zSZuEL5lyd/NxwlRKmtJZ7V1A563TDmd33P+TTklcKm/qOlbIUZ5uMYZAz6fQ0ejuJ6KfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsM4Ydpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsM4Ydpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671411F000E9;
	Mon, 24 Aug 2026 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787589501;
	bh=hU/sAaDPsIpBC9ELNG+LmYrzgz9drI9Eq5U9BN9RNqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EsM4YdpljELnLq4M3bqm+LzeHXGbZfpBbcJSUgKgKT5Uuoqd/05qECBNXX7y7tXxj
	 FDN6HAIuv5Gc7uamPFnW+ScrHewsrKs1BgfP0XtSXgTwloCjz1eiibxkls4hi+dp7h
	 uekuqZ4LCprijk2CLdIAXP9udp+pE0diu4nhksdbVjOwwMx5Yd2EkeqVN4epYU+d8G
	 0IccpOD4/tdj1urrQg72J3ww/hy+INz8Wbm7PUIY1aQaVS2ak1wIU+QIBbHMOhlK/j
	 KfRabMlem8zOFuFx0Ct+5weRG/5Z0lbJSnzzZF/j2CaqEmlz3pA7SrO/CLmJ3SgN1y
	 IeQjNf/dMd2rw==
Date: Mon, 24 Aug 2026 17:38:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladislav Leonov <vlad@zlab.su>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Simon Glass <sjg@chromium.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: adc: rockchip-saradc: Fix
 RV1106 compatible
Message-ID: <20260824-scorer-propose-d216e0a8833b@spud>
References: <20260823122039.20831-1-vlad@zlab.su>
 <20260823122039.20831-4-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AgFl4ZJM4/qIhC3X"
Content-Disposition: inline
In-Reply-To: <20260823122039.20831-4-vlad@zlab.su>

--AgFl4ZJM4/qIhC3X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--AgFl4ZJM4/qIhC3X
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoxzeAAKCRB4tDGHoIJi
0ka9AP4+tXIZZ5tZdpAPr7WKI6H6HKkBxPFC6eIG4WKmPx86pgEAydAX9weYsZg7
V7OR8TKYqLBSjTQX3a///yGD62FMAw4=
=1r9h
-----END PGP SIGNATURE-----

--AgFl4ZJM4/qIhC3X--
