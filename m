Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986317;
	b=DwGV6xB/PKzy+n0ySpdNQSQvtz7A4Jjwni+1C0euLj2yxIo4eWaRCc9yUU9DMWPJJ0HS
	 SDCzXR2uS28shYFaWXGQqVmOVHKDGDFxvJ8m6ASdagNezpGPLZXtH1cERcrErZFnOJSvi
	 83Rp78l9kVVsdoWEDtJ2RsQx7A6l35v5NNmVa/nHsawYL+yGBdR5rQ9P3yzqCX69cQNeV
	 y3FWu0aVk2EdU6Imo9fKmIukAGpMWEk2HYbAYx7QSkCir5q+v/wTeM7TM1oXnPuBftsuV
	 J2YAaJ4R82hOCzGzEdnQhBDDkF90dJdq+MI+owwssyBzJtAzE9lRvJsJO9QXrAdpAfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986317;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=80RCt9u9okdKiIDhA2JH2m+wj/veBxbNH/cBk3sVTNA=;
	b=qzdkZHuQ2O3BxaCsXZyRqJe1cQY7e1X27qXccj1DHkn5IuZkB8SqYQxyv1w2Hzts8ml7
	 JnoJlio3jJEgWl46FMzF17xF8Skzy6xTJFLxvDxrI6ddLwBwoWNtbIWhGDBaQuVdXWLAq
	 nOyZ+fyQS0iiEft9crIgawGiYlzdzit7gYmJtP/i2jq5RZ9t43YRJC2yJcuLwYXzCPkiv
	 KAIXmVRKagXIeWUxq6kiNJbecD17A9Kmp9nhmkqHSY08+T8Bz/JcqMSUGCjWW89oKZis/
	 hlCUdzjbUpYN70SHLoj9uOkip/nRgMC99A3TmzlqwW+vps0jfTSTfNXUUhCQtSd3W7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eyk0NeDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F694606A326;
	Fri,  6 Nov 2026 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eyk0NeDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C401F0089F;
	Fri,  6 Nov 2026 17:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986317;
	bh=80RCt9u9okdKiIDhA2JH2m+wj/veBxbNH/cBk3sVTNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Eyk0NeDldM5fIzL9BFXO1GfYX4ktCGxKbtKg15gJVGa3RtzhdXuvv+x3b21RDmP1p
	 8aZTpV4R/0/cB4eF62ylXnVZp26GjZ0cG2Hqc71ntcmkCvZE2kwRh3nSTKAUa/AEMm
	 oCkLyaA5MyRX40I19T4zaOzITzeU0tHigqflDfX3fuxx7xo0oFk4+3vYJlyIbAfoop
	 6gZM8HP4gR6JgfL7m/A48vCwjygPlQBlR/1bz1mSR5929Bbm+oLgesk+rQSHJVT3z6
	 6dHQBzbfQV5aZvRVwfJwWy/aDfczYuD1q55UvV4fKXtpW5baqFHPOBCdU3sT1b+9g7
	 M6dzUlMRKjz2g==
Date: Fri, 6 Nov 2026 17:31:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: light: ltr501: Document LTR659
 proximity sensor
Message-ID: <20261106-detail-impurity-3dd73f634845@spud>
References: <20261106091943.35783-1-clamor95@gmail.com>
 <20261106091943.35783-4-clamor95@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cAm+0zv9F6JjeS7a"
Content-Disposition: inline
In-Reply-To: <20261106091943.35783-4-clamor95@gmail.com>

--cAm+0zv9F6JjeS7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--cAm+0zv9F6JjeS7a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4PBwAKCRB4tDGHoIJi
0rqUAQDzmalcHqme7F+wCwnx9u3UbtOl5OnRgU2mnasG5Qm9lwEAkXzxJLr08kkW
BZaNhRPyeKdodrwq/lHXG02JmPbzxwg=
=nUth
-----END PGP SIGNATURE-----

--cAm+0zv9F6JjeS7a--
