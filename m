Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6B314B73;
	Thu, 11 Jun 2026 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200041; cv=none; b=kjt1Wfd2PDCobmMN0SiEW6jcRWXe8W8CGe6O8IHJblRDZkzHg6qQ/gkSbPQ9qcjlRs1gihnJ262+atqgIs8dbac78y57MTXehmi1tpKyD3q8AExdhrXetIInrYaLH45XuGuFZuF8WRTsKNVHxsPYRwz97Juh2wBpGWvCt2Rj2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200041; c=relaxed/simple;
	bh=Jd4FaYfImOuu+ZqaDqiD0yyDQkR7M4/wUsvH9n7Vg94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn97s2QEa6ZATnn4dOYEv3ElvnUAY3i2tgDzEK2IYMbNlX5iLQBQoyC0yvsAC+18Rwnkl47uzCHmWIKavrw8kaeiKcS2LJuyvbIREpOXPbyTXRKcOXeqRmOQ9VhZImgdQocOzh/10sVw9e8q9PmBDBmQNMNqhwd8G2OUasNoHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlHeHWFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlHeHWFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABEA1F00893;
	Thu, 11 Jun 2026 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200040;
	bh=qBEOa87CSFATJjqvcZVwKVEXC2OOUzxrPyM6chWCTcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VlHeHWFKRueUJu+LCgT1hYFJsusHQrOInpIDLQMi24+C6H7to0uFZEBe07ydfQcYm
	 nIAnRzgyJ+F/ZoziBzJckwlZNxoapNvfgmXsxE5dXOjbSANIqBoRQ/tcyioJO/v1sE
	 aNFYM/qYqf4BJFmUfbU7CVInY01vltQbmJy9nGe426uO5FSF9ttEQXB/s1gI1BQFRM
	 KlgZHQw5WXIoJiHQ+qw4eRkxd9oAwCMhBWGUbu0t6nm0zJcJWGJvXLGMXUuotB9aY9
	 PTn2ibXIgMdP/YXXwHrYzTAiDQqcneE9ODiZmjS2SBB/dMHiEU1rwFxKFPn8bZhNUw
	 v1l18f5LY0xxg==
Date: Thu, 11 Jun 2026 18:47:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Nguyen Minh Tien <zizuzacker@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1220
Message-ID: <20260611-cavalier-punctured-62aa44182f1d@spud>
References: <20260610151342.44274-1-zizuzacker@gmail.com>
 <20260610151342.44274-2-zizuzacker@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+EuFVgbjNCLF9nry"
Content-Disposition: inline
In-Reply-To: <20260610151342.44274-2-zizuzacker@gmail.com>


--+EuFVgbjNCLF9nry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 10:13:41PM +0700, Nguyen Minh Tien wrote:

> +      diff-channels:
> +        description:
> +          Differential input pair routable by the ADS1220 multiplexer.
> +        oneOf:
> +          - items: [const: 0, const: 1]
> +          - items: [const: 0, const: 2]
> +          - items: [const: 0, const: 3]
> +          - items: [const: 1, const: 2]
> +          - items: [const: 1, const: 3]
> +          - items: [const: 2, const: 3]
> +          - items: [const: 1, const: 0]
> +          - items: [const: 3, const: 2]

Maybe this is a silly question, but what is the difference between 3,2
and 2,3? Which pin is considered the positive value?

--+EuFVgbjNCLF9nry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCair0pAAKCRB4tDGHoIJi
0hFQAP4yNFL18XM3mBg0BnNBrCMrSEhPZ10DWYYcwOvk79OyNgEAwbKsF6+f82W9
XDDP484gg92bL0mHDp4t8BAeIP6V+ws=
=1hHH
-----END PGP SIGNATURE-----

--+EuFVgbjNCLF9nry--
