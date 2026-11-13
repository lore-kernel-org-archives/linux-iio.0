Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794583603;
	b=AoRkyNvzoLQ2MQAfEk/jWzfjnpObUqFqs9WmI3zDqmol6muazCkNGVFrzyHOXy2w28nv
	 Ei7qHJSvKw/H9DGpYMRPDvMUSwh31ggQBe6DayHnpDh3nMnhKHMk9ZlCq5vCEU2FDcuGk
	 IMCw7pZDzi9hLCR3nDNoZS+APQ/wzUUg3xegVVrj+RGUgw0YS/fSErB2vBhwHMRrcDM1O
	 3I2mrqxm5MaaL4Y4qE1cO4lOYN1YOrFF4byIJcDZ/5H4/BaOGo6QSi/iJVQyRgND6lHMH
	 mmJZX7uUaZPow1uKVb4//opdu27wQjqO9QedC5uxBEHALALLpvzVrzJAfcKoccp7zyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583603;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Si5kjDQN8ERxEKMt3iF6CinVTQG2FudMBDMZ6idH8FY=;
	b=dyPzOKkOFvg/K1kYNhnFS9PNV8w+OtRF6cygxqqSQ/YBxOsnWaPhr5/oSm7HE92O+Ust
	 FRa0kd5HEAflF9TKx1nd6bL+6vpHUuDxw8ve0wzFz42/Tee8TubLnITkHmUg1t/P0LcMb
	 ZuxVkBpQ+n0lXYs8e48L2nryPIh+zIBUK1mFvDDOzp8pW39WcEk2caM6Ed3Ysn0wxVIey
	 YtUQGJUvPVapuyuEiqqbmGqEssRHO0VyZsd2CFrHBd3cJlLPk0XlbUlOH4NpIRHxJxNzm
	 4WZHrPmmEjyZ6H5ut4ymtJAQOtPC1znNFREWGT6ydPKu+tdqKotu9Vu0KoUKp1btx8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5ohoGJE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2B606A32D;
	Fri, 13 Nov 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5ohoGJE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794583602;
	b=vkzB0n09b2ObqOQnqsrTz9H+NFapxG0VqSUec16iR1A4Mwx8a7/lhL2wgvjZ7AdlAK6v
	 cC72RXm0mzeSAK8Gq5zebIwvfK6DdbpL1rRcSoAMtHPQuIe/6bpUnB0TjiJWYBDAtMy2S
	 ez0nbalFiqDjkdZxFvpPQFWTedPmquoV39FDWd3mWctkXtqJffgOCD3Za5Vvfooah7yrT
	 2Y7QB7emD7GDFT7UCTPQ2O9RJp0U1siHW2dEKnDg5usPny2La2bINLClW1HtX6GE5vw80
	 /igJTJuwLnCE5t+KZYhWLpM+ITSs91yEv2lmQ9h7MYNFergDXiQoBy4toEYPDRTub0g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794583602;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Si5kjDQN8ERxEKMt3iF6CinVTQG2FudMBDMZ6idH8FY=;
	b=cTZ9Jr/cVmW/qmZZ733IpidjMoxueI/NlOcMcny1g28G+d+jnbpf7HPlK7ljQzYbWd/8
	 TpcmJwRaBChkcRmv1mQyA5YKMlsecGe+IhP+bYCNycWSlf3fOUEK1C2I9r+XwWdmtzpNh
	 VEK3ozP/xSGRn7xAPOKzcyF6FqWh9Be6mSTQ2qdB8apfR+tjwndEI7gfJ9K9ADpHpvUvO
	 UeRTgpazcyECTh3tD34TCtt9/fysBuhgMv+cHJEYpQ/bWbnKAQ7p7WrD79l+lDjbpRS9+
	 qlT9tJfBs3sA1CjEUTiERg0sGzqg+QISabyofcSe2Ex+t45pTXQ5wyYh8FodsXgLWhg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 733131F000C4;
	Fri, 13 Nov 2026 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583602;
	bh=Si5kjDQN8ERxEKMt3iF6CinVTQG2FudMBDMZ6idH8FY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F5ohoGJEo9iVackwuzsHP0KDjBftCM5Fs3ItiejL5W/X+woEFZ2sFoqSEbhsu2tD8
	 DfQUJepI2ZKEvzFK1P+7Jt+eYPtssXcjoFlA3pPTXDNKOPtMMO5qZlUUrzIixRjVyw
	 4GSScUtDOawdpRJpTwXcEt4Zl1mHZOlbJ7onrmHxN9Yifvce/spsdI7Zrn7reHwTod
	 +zFqcMoQogxWHsmLdUzvmIV8EvAwNwaeMbtEy39ez7rUkP5rtY9C0wByyUKRyMhlf+
	 MhjShHalgLNB+kpsHXOfxYpi1ENe/jSxiysnQ0jUPtsEYaxlDiJRQGK/xamPoVUV0g
	 b1atVsZP01gbw==
Date: Fri, 13 Nov 2026 16:26:33 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Rodolfo Giometti
 <giometti@enneenne.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Victor
 Chernyakin <chernyakin.victor.j@outlook.com>, herve.codina@bootlin.com,
 thomas.petazzoni@bootlin.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <20261113162633.0000670a@kernel.org>
In-Reply-To: <20261113151543.2241604-3-maxime.chevallier@bootlin.com>
References: <20261113151543.2241604-1-maxime.chevallier@bootlin.com>
	<20261113151543.2241604-3-maxime.chevallier@bootlin.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 16:15:42 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Add a new driver for the TI TLA2528 ADC chip. It has 8 12-bit
> channels, that can also be configured as 16-bit averaging channels.
> 
> This is a very simple driver, allowing reading raw values for each
> channel. GPIO mode isn't supported for now, as well as buffered mode and
> the 16-bit averaging mode.
> 
> Co-developed-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

This looks ready to be applied.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
