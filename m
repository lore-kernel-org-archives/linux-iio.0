Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091554;
	b=u9tnFd/8D8BEwwwKeOcq2IxUOVoLLSXU40kfOme9vbU/jpKYHZoliq55NTFl1bQUZOvS
	 cu6MZQ1Kn60dtQr9SJvwalcuPiTVYKWt3RcLncTuHXtQJO/hmMbl3skGpfFmxFnarYfLs
	 2y4p+BPlhRkhD8rmR/FIqXQb+CCOE2TlP5dWKwuP84h19tIgB+Ih4rj7PpKYNBXLabYS7
	 xhKCwldHUnCH2yEwOWH9YZlMiBUImGpkyz0GCfruaz61XjFx9RIe9W+HAtIbezN9NloIB
	 u3IMdLud1w9f+YtlT1jTuwsOzExwvPl9ce7cclrYP3f5YGDIEgXR/Y59/NqSH/PnzpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091554;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=nbpoxfxD/YxKAQmHcLsH5klOFWtwN75CT6T2h0Yqdqs=;
	b=2VQzrX5Xw1aFAVEREFqm0MfYjc4gLOtwUaHTmoez+JCqxwLl2mKI7gDHOtqEheiJzuZG
	 rZA6Han2gRJdhk41Z+Wlu/lPKJ/9DwzwG81/kWmGQ6IxKyI8JNygTdBS5cEGaCEIyxonB
	 OC0ScC5lPorXLKdIuuX71WOS5tZpFgttMqBMcjY6FJCIyHJcw8vMLvqX/HU8RqcePLSX1
	 z4DuvgBMqCZ0eiwQlNTvC0W0JaBbzjBoItgOKM7aYk5cEnvVihD7k6+KFHScOtGJhKiRP
	 50UxMdOyqSjeUKKs8M4ss30gG22n3VVt951T00T1pZExX6av1rY8VRWOQevs954z65w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=U67rNd9T;
	arc=none smtp.remote-ip=79.135.106.120
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762F606A326;
	Sat,  7 Nov 2026 22:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D762F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=U67rNd9T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794091550; x=1794350750;
	bh=nbpoxfxD/YxKAQmHcLsH5klOFWtwN75CT6T2h0Yqdqs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=U67rNd9TJxEIZwcB0EBj6XrEVzE3JPqwvLksmTXDYW/IuCAyd8lAHFB1VSbyh7vB9
	 ROtOgggq1SLZEROiRrIivsbqLpN6kGVeGF6WTeAehMDrB0cxqD8Z/MKGMLUYtAnCsU
	 ldxyjB0nTJak+5BPa1grO6VV35z6mLd6iN39tHEiOvDFIdk4uQmnO+8nTDCr75f+zO
	 SDP8zOXEId/MsqFf1MKmlkdNFAKO1eCnFNxcxYclyh94YfpH8gVZfYXrFjan5TA0L9
	 A6lwv7X7wQTvnWHUgFBufDGQa7Td5Ps4tfq1astOJ48IY/T52eO+XPVu3H+cPRRYzJ
	 wa6z9jAe72s1g==
Date: Sat, 07 Nov 2026 22:45:45 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: light: stk33xx: add power supply support
Message-ID: <geNqZOyrIjYLfmuUys8cQJU8FM53jylicArPsTGNXPnqSvHPCIc1Jad7dBOBy1GdE38RBEMSYQYDqEmaAqq2PDcglQcRBdkR0yZAjRExEUQ=@protonmail.com>
In-Reply-To: <20261107223601.0ba9ffc6@jic23-hlaptop>
References: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com> <20261108-6768-stk3337-v1-1-0340c99b0e33@protonmail.com> <20261107223601.0ba9ffc6@jic23-hlaptop>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: ad140286fd2962c5d12143b1a1cc16b7d7e26120
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sunday, November 8th, 2026 at 12:36 AM, Jonathan Cameron <jic23@kernel.o=
rg> wrote:

> On Sun, 08 Nov 2026 00:15:03 +0200
> Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wro=
te:
>=20
> > From: Roman Vivchar <rva333@protonmail.com>
> >
> > On some boards, the chip shares a power rail with other components. If
> > that rail is turned off, the chip can't function.
> Not sure how the sharing is relevant.  Even if shared with nothing
> else we need to turn it on.  So just mention that on some boards it
> isn't always on.
>=20
> The only reason this would be optional in the binding is if there
> was internal routing in some packaging or similar that meant there
> was no pin to connect.
>
> Upshot, make this required in the binding. Note that doesn't mean
> the driver must require it - we are simply documenting that the
> device needs power.
>=20

I agree this should be required, but that would break dt_binding_check
for existing boards. I don't have their schematic nor boards themselves
to verify the regulator for the power supply.

Best regards,
Roman
