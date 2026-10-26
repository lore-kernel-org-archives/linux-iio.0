Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012487;
	b=a7tsTF11bY9lQ6v9auQexwFOdNe2xLP+eRZaZHqXea0Cytt0d641cbIhv9pwY1MGIFNp
	 YgiWDGeffXF3hR55ll2A400s/pS9OmTZLxlU7xvXy16ndqqroN+6W8rxCFHTM48JPiuu7
	 pJnRuGOb4FGCuIYNrG/pp6yHH3J0CSK5KpxEzjJAWXLDrSmDMuBUV48lMqpEkn+i5SwSQ
	 Wpl2cHTdU65jLIR3n3Y66imjrdRsCVPSjCBD+qz8rWcOJIAe7eZSA6yKajtuNN1veyFaY
	 v0rgLMZ7twcNNfC5u36pTnWXuomEwmMzVrnE3s6O0g94H3g2Czm6aMluq3YF6QYPOTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012487;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e4iyrsilOoIaqQRR5s2r1PWNoBmgKZMvdEkIhqDbC54=;
	b=Sgr+JcTQqdzcrO7jPjEW/hgiq39q1jh/6saX71GbzUqUex2+nsMnFo7hYXLbiz/ANUu2
	 f16PyKUaV1Fz39hu3zixsVC0svUIp3sRAZ0otVCruSHpS3jqqTCHi2l7OXtWUExsf5rxG
	 p2rYoAPIsSxl83CT7/LftYQJ1aKGfd7mW3b0lEJWIxVuRCkMCSYUQFAmW5WDPg7u8ZQd1
	 xqIwzPTS7gMkku3BSDrhFChZo2991+N8HdZClITXAcY4Heo5LzUJRX+Dp8GDaskgbIQyn
	 yc91AQ+3GYh9sAC/dSW8IT1mB3EZnxiAkXhCUqqL4Oq4bM1onXiCc9NHLrTkX8PL6Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3ASrSox;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD66606A31B;
	Mon, 26 Oct 2026 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3ASrSox
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C711F01825;
	Mon, 26 Oct 2026 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012486;
	bh=e4iyrsilOoIaqQRR5s2r1PWNoBmgKZMvdEkIhqDbC54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S3ASrSox/gv+FHA71IZFlTDSdRER/g1ajQ+AVcwUsfB1b0MAJ60yFDnEwtr9C+Q+F
	 MLgGFpvW107eWsBBZVzNI0L/x9r+7qrsPwxdqOMSKr1vtUbMTOVUnZvRfdxFa7zh2Q
	 bz9QPbDSaMTvfBnyIKeor7N9yTnbh4oizD8grLzc7oQNQz7iji4F1OvJoXcu7zDOGG
	 9Mo5nzQIny6DYH9HZ3Zz5Lhu1IS6FiSPyC7CHa9Oi91ni3joTUlbDbb0GE2PosqASA
	 9rO+x05w3bc6lHPDGpfDJxn1PdVfi0iETLnbq8dRmaBq6S42nuhF9gsU5LLZiysLJa
	 PnwPTXTTlGDnA==
Date: Mon, 26 Oct 2026 12:01:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Olivier Louvignes <olivier@mgcrea.io>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Message-ID: <20261026-monumental-adaptable-coucal-f7291b@quoll>
References: <20261024041357.34346-1-olivier@mgcrea.io>
 <20261024041357.34346-2-olivier@mgcrea.io>
 <20261024090006.00002720@gmail.com>
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
Content-Disposition: inline
In-Reply-To: <20261024090006.00002720@gmail.com>

On Sat, Oct 24, 2026 at 09:00:06AM +0200, Joshua Crofts wrote:
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> 
> The changes above should go into patch 1 (checkpatch will
> raise a warning if you're creating a new file and it's not
> documented in MAINTAINERS).

That warning is irrelevant (false positive), so it is perfectly fine to
add the complete entry here.

Best regards,
Krzysztof

