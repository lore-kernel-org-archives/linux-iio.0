Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011848;
	b=vRtT25JxvrEh2kbHybdKAF01m+fApm3A3y9WeKu1SYYtsP9TFKovPAVowUsuyaKqytOU
	 oxX7TZicFNMM4IO9SlG7avcUloxEFOn1FhkdvFXvtaDM1uzSLASB++1GVWmjdXJKc4bXY
	 Y14SMHvWKQ8cXfbCsvMd15YsIkoGqme7tES2eQCbsdxu8oO6dqHtsk5n1O85wUOo6qa96
	 ZR2xjRDGGpRMrJ1yWWn1sjbBK8m6HEGXsfnHh5vGzB396aXs9h/TnJ1ngDdPPku8pCQuL
	 +QNj+zP2YeLkgDSrg0hJr1S3A+jjmmni66brk1JmX50zI0nhmWxESZ5lvEfyjnSLX/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011848;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ofbC0vCVo/jfB7y7WETBkHxwuuO4dkPfUQBNyCu1RQs=;
	b=JO784uW2NO/psTtYho7f9lNqE36FHhXMR/18fX6aqQtI1ATR0WFoWFtnXZrOOgGWaaNS
	 aymmkHEP0oKMaowQfcnFDq4pkFw96zfY2ro4h/dPl4Iq1yAipfcKGODnmgTFIybTWTMu/
	 v7K5HlFh4v7h9Gft2xR6NPpbfER8dsSqhIqFJf+Cyec4VkUunS9gFU1HCdG5gDG+FcqdC
	 cUUaf3KHffiXkhTkpXv2GytvSfqhY32ByI7+KxyXojTJ1JGmbXVsP6Z7QM1LUqJfAZcjz
	 ysx1Rv7Kl+wKIuI+UXoqTRAS6U6L7wzqLi4iLRGuXIbMTUX/KqROf5gqRHvm6EXMyRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMde7UQe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38FD606A31B;
	Mon, 26 Oct 2026 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMde7UQe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D8B1F01828;
	Mon, 26 Oct 2026 10:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011847;
	bh=ofbC0vCVo/jfB7y7WETBkHxwuuO4dkPfUQBNyCu1RQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MMde7UQe5nDSP/Sfyn0ocPgVngItDpSLW4fbgJcUequ7L6sOvK5IHZOeLJ845k1NM
	 Zdm1QSznx9wsihldhGkHY42NB8i2fsX6VyUIEWCAw9HcdpfZlmgYWRQ8xLMO42xNp9
	 ItbKIZpN4qTn5iy8ME0evktESViSxuyZWBIZ7TyNhhIEjPWdU00WJMga/XPqrcXSza
	 B+H1fqsqsSgfZKMlC+PPO5yBCTqBvaOOL6Mulhn0Sz+92xycgcqtJnKO+BANFNfhEX
	 bw4vFtKV0uO938GIELcbRKZtWhuRJ9zUQsUYXy3m1BJie56kLDPmPmAOAXNQjSBIy+
	 ypbnjyoqM29eA==
Date: Mon, 26 Oct 2026 11:50:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Olivier Louvignes <olivier@mgcrea.io>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Message-ID: <20261026-hungry-masked-anaconda-7fadb6@quoll>
References: <20261024041357.34346-1-olivier@mgcrea.io>
 <20261024083809.000026e5@gmail.com>
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
In-Reply-To: <20261024083809.000026e5@gmail.com>

On Sat, Oct 24, 2026 at 08:38:09AM +0200, Joshua Crofts wrote:
> On Sat, 24 Oct 2026 06:13:56 +0200
> Olivier Louvignes <olivier@mgcrea.io> wrote:
> 
> > The X1600's SAR ADC has four auxiliary channels and none of the
> > touchscreen or battery engines of the JZ47xx ADCs in
> > ingenic,adc.yaml, so it gets a binding of its own.
> > 
> > Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> > ---
> 
> Please use a cover letter when submitting a patch series.

It's fine for two patch series. Please do not make it more difficult,
than necessary.

Best regards,
Krzysztof

