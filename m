Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395048003D;
	Sat, 14 Mar 2026 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481315; cv=none; b=iC1cORSpU6FLHv9ETkmVBoo8kxo4XlZXFse+r2ZHRBD4W528niTAZSS4Txcai+j6Ax7F2/wN8cJ4NxR/Op0cUmDFodEQW5F3fFTsrJSeWtBC+34T/XHNuwPQZfgrYgJalrT78qwtRGzPpQ7t4febxKQ3MvoniOsYdQztUu9nzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481315; c=relaxed/simple;
	bh=kqXr9BArz3PvS0L2GA1uoT9JRBle5Jc4GIpeDAoGZ7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQlgoLuQyVCTLPmn1/OPrHZ11d4Dx3d0mw6pfOGqMsSBCS1Gshjsl0d/ZjhIQzM07HqpJT5qfh1l5tzRAigwtIBZr8ImgeHbQddZggKf6gpMH71IOr9y7YxT8R0wW2DcOPFUFQ7eycImOHTqnLm2YgZO0fDZn8MRSYw4rp7/9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXSYI/mQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXSYI/mQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D111C116C6;
	Sat, 14 Mar 2026 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773481314;
	bh=kqXr9BArz3PvS0L2GA1uoT9JRBle5Jc4GIpeDAoGZ7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXSYI/mQErB5npG1bowsFMzGLlblK7qjG69GDv14mjqI2OaMzzsvgpoKRSEVjviYb
	 lZQEvNkdCzV0z8QsUr65WaPkZZRr1JrMoP8hhbGQ3qfbipDP+UoDXRcKTkr8+MQFL3
	 +J/mHwinur5B9kINeaUG+qWuVAf1R/Dv+RjyZhoEseE4zBiwqVRhhMddP2VNwdQkyT
	 f1nRljvlWujAcmw4GFYgQYZbET44FLw9g1EegLo29FUg05JXdclsUalkbiminNadoE
	 F26NiAcJwJEbBOZUAypwBNFjMT5Xnbb9MVrJgG3YHQZS2kFBonNHMj+uzy2anDeQYv
	 7bpsGPn+BnUdg==
Date: Sat, 14 Mar 2026 10:41:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Radu Sabau <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Message-ID: <20260314-resilient-colorful-myna-ecaeda@quoll>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>

On Fri, Mar 13, 2026 at 12:07:25PM +0200, Radu Sabau wrote:
> Add DT bindings for the Analog Devices AD4691 family of multichannel
> SAR ADCs (AD4691, AD4692, AD4693, AD4694).

subject, you did not implement entire feedback. Respond to all the
comments and implement them.

I finish the review here.

Best regards,
Krzysztof

