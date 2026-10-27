Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098363;
	b=fXAuAQg7qBhTbLkhBxl5OU40z8YORRICmpFNf4B8SfAf00dOrUdU2clDA5S0t+U7gDpi
	 GbusLL8dWkPtTOms5iPrIP2V9E4X0NP3CGf4lFRi7u9YTJsJJNVTtF4fF8VaSGnrQCvz6
	 pEAICe5lb/BxNBVWfXP3lvGX/A373lZCaV/FLUFOkc9d5UhLI+6mZSQbiKGqvDB6azSHm
	 JOOMeIl9hIAmzAafcFoZXf3R/hq9KFNFMVAhFvtZND5nX7oUtZEUwTBagmfqBPnVppqHM
	 SmQFpunpvJuMC26mVpcFXalGHLTGln1j9rw1Q2/WFOAjnTzoUFoldkSEtod30pF2xpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098363;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nb0Lf50bJgBV2CiWucdnoIYSpgrOvc7UWebGORq0ITo=;
	b=Qm6nvCDKtKNj52MREOVPOELUceOQpq3e0i+oocpSczFPDYioEA4XCMTv0Wu+JOyj/uIS
	 vOkj1aBDwt/dSFN68aHmrMMvd8rMxlx/p7EozDKEg3eo994Rd8D+fQF3QhoHTFGHZHD8f
	 hH2ugghidrXVvBnlI+EjZMvIh9EsJtpOBQwW1AdqFzzBtatp+ORKO4mNbZUS0atekCAGR
	 0itph/DmqUjzzPEev8h3aOyYG7aYh6N3X0Bf1BmgESHrCfs09qTzLwm5ShaIF4QXurfn1
	 0fnDAZiv1c6cpPMfNDNXG7jgbYSAwlJxsf/LcWnSzQqVLM5ic7pGt/vK6DKepUtOyYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hO5a0BFI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CA606A335;
	Tue, 27 Oct 2026 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hO5a0BFI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7971F01200;
	Tue, 27 Oct 2026 10:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793098362;
	bh=nb0Lf50bJgBV2CiWucdnoIYSpgrOvc7UWebGORq0ITo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hO5a0BFILnam2QbREVi5eYsEJ2yGN9Fu8pd1BwNmJxgglAb0Kvy+s5dFQA8TUzzWo
	 rVsCIrUJ4vBurRfdkj+TnguSgQxfIs95ppVRFzB4UQhx9Dri0WAxOXyGz+WidlFPBr
	 whuQ7NkP/WPc7GrU/LRS+3+kGYyW+vhJEFEOHZUPp/p/uvBpj3C1gkijHHEaMP/WK2
	 HlGLkEfbjeW5A4LH9wQtiiaRoTDinQ+tbsAIpWV4ocxjkhIho/p2+Kah4niflqGgGU
	 ij7viDDpCf9BPdLJRckq8Z/tHj9EVwdqEYq996qNY3FOc0yylAdldh/xhNB7BuWAbr
	 r1FHlA2p+JK7g==
Date: Tue, 27 Oct 2026 11:52:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: adc: Add the Ingenic X1600 ADC
Message-ID: <20261027-fractal-unbreakable-parrot-224dc2@quoll>
References: <20261026083631.48406-1-olivier@mgcrea.io>
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
In-Reply-To: <20261026083631.48406-1-olivier@mgcrea.io>

On Mon, Oct 26, 2026 at 09:36:29AM +0100, Olivier Louvignes wrote:
> A driver for the SAR ADC of the Ingenic X1600: four auxiliary channels,
> 12 bits, one interrupt per channel. Tested on a HiBy R1, whose keys are on
> channel 0 behind adc-keys.
> 
> By their programming manuals, the X1830 (3 channels, 10 bits) and the
> X2000 (5 channels, 10 bits, one more data register) have the same
> register layout, two results to a data register. As Jonathan said on v2,
> the X1600 name stays, and supporting them now is welcome but not
> required: I have neither to test on, so this version is X1600-only, and
> a chip_info with the channel count and the resolution can add them
> later. Nikolaus, if Letux has either at hand, adding them on top with a
> test would be welcome.
> 
> Changes since v2:
> - Cover letter (Andy, Joshua).
> - MAINTAINERS: no list line; the binding's path in patch 1, the driver's
>   in patch 2 (Joshua).
> - Includes for what the driver uses, copyright line, MODULE_AUTHOR(),
>   reverse xmas tree, open-coded return, no message after
>   devm_request_irq(), a blank line (Joshua; Andy on the return).
> - fsleep(2 * USEC_PER_MSEC) (Andy).
> - The ADC clock divider is now even, as the X1600 programming manual
>   has it; v2 wrote the divider minus one, as the vendor kernel does. The
>   divider fields are named as in the manual, and the two clocks only
>   repeated sampling uses stay at their reset values.
> - The probe comment on staying powered up no longer names the keys
>   (Jonathan).
> 
> v2: https://lore.kernel.org/all/20261024041357.34346-1-olivier@mgcrea.io/

Please keep here complete changelog, so also v1 etc.

Best regards,
Krzysztof

