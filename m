Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61579377EBA;
	Mon, 24 Aug 2026 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589534; cv=none; b=QfMWcB141IbKoBWvDg2SSw79dcUdX8DpEqyydkyel0SU8VWR0aNHSxYjZQ3oruVB1LnaZiq2/ZzN+2V/xCo2iO0Mses4Ptg+R9ZxveXRX6S92lYyUqrWOyIZz5T/4Z/LWt/DXU3j04nwDulE0Nj+6q6ZlvBXrVehJwjrkdOuIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589534; c=relaxed/simple;
	bh=sqwRY2t2GG/HXlNPtzthyAZCQ4zDXDfIWhWR0nQ8CGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpO7oR5rV5Ux4bmffJsMT0i2r5uQvn4Ncxw/4FaJX56OnghVDUsr+SBiQvjy+7vk0BC5ghFwphwc5i5upd1MuEi66tYUfwmK4zjNKrbaGe+zvJJtprdfUWa2fHHs+/xqwLzOdmiK/UDV/dNadPW7hQ3Lk0HuhvpB+ug+li1Tec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVEbCejI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVEbCejI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC75A1F00A3A;
	Mon, 24 Aug 2026 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787589533;
	bh=sqwRY2t2GG/HXlNPtzthyAZCQ4zDXDfIWhWR0nQ8CGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cVEbCejIw7fUoGqozdRq73PJRbL3ssn1jeYvkLhnCatNT1/nLXOBgLQ0ikTR9NMsu
	 NBODwqN999Q+Sfi76XYduxvKn0AAEiskHomhO1Sat/xdyZ6hZntbxWUJBdYrGxtKrw
	 RQUYn26RLEfs90HTNXB+bav6T3XW1MDqs+GjfLEb5xCc6gbM2i7wqEj7+GwhFq0kWs
	 8ULReDc38D/6z1L4PxbQJYQioPaLjTrJFmYEefBJ1EU2v+sv4Bd+3iPHpaarZ8Zyir
	 mOYxC6gwSQizZ+jU9m5xRvdMC4kiyHF7LCfN2Y9QEWPgoq9X1+zE6Gi/I4VkmI5h0Y
	 p7gMNMt4hHWaQ==
Date: Mon, 24 Aug 2026 17:38:48 +0100
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
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: rockchip-saradc: Group
 single-entries into an enum list
Message-ID: <20260824-stiffly-caress-91a7d95592bf@spud>
References: <20260823122039.20831-1-vlad@zlab.su>
 <20260823122039.20831-3-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwYF2VLTXBcJVgoO"
Content-Disposition: inline
In-Reply-To: <20260823122039.20831-3-vlad@zlab.su>

--mwYF2VLTXBcJVgoO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--mwYF2VLTXBcJVgoO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoxzlwAKCRB4tDGHoIJi
0kGXAQDe6WT4X2xsTPjTCUY9zPGU5BTZNXdzwhP0cgJ3PUZFxAEA39XrZeoLINvt
WuD3NSdPjZe+7irgZTXSUyIpuds1TQs=
=yfyJ
-----END PGP SIGNATURE-----

--mwYF2VLTXBcJVgoO--
