Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785D388E58;
	Sun, 18 Oct 2026 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792349011; cv=none; b=WMIkL7o7Hlq+fANbDSgc5h5N0WqFguOi2mPCie7qfJn+U3yHFqHpr6wP3k5qWpnpYVX3JPr1AYMVV6zZboIygd2ZA/nGoZR1suWrF/r5/uTbiFwWv4nR8u4HDOfiopUWK5lTt896q2T/LjIce9DwUvoOTGSgLIYimltHt8ClFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792349011; c=relaxed/simple;
	bh=b/mCOFAvVzM4HbmD+iL8o44VhpJfqZxQbnUrBbgDGU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxWDRYhQiFOQRiv7TYbOguo5nnq36a1a6Q1tqIchqf7CNzbspPTKpjxUQgm08us8/oLVV2ccxmDCuvn5WzdOOCVfubdCLBWmbo0gS0QfCLfvf/cpu+7/UdGxIDGWxVixUgG1rivvzjE2v0gtYsrYnVcC0whLEX2cuiT0kEmPXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0/pMrZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0/pMrZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D377E1F000C4;
	Sun, 18 Oct 2026 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792349010;
	bh=qiOERPCTQiGVFgwfZLglWEV6akVIWi2rX3u7+KbZC3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S0/pMrZvfE+oKfHNSjqsarg79YYCAUFYpYzLR77bM2i2Zh47WHatPZU1MggM2Km5c
	 fhlbURllt5N1hl0PrERey7XFvnYqEgJ6lIAollpBlgfIAJvMSKz5ihOmiSqeL2x2CF
	 pVvXNx7+ReZHJpUj1nyCb5EPV4NkTTJZgjJmSBHUaDJcB0eqZoPcK1T7C0BEwfwhEV
	 CldAq+IJxnbNPPNULSYHru4stMUg5o1VXBPMaFuJcR3N8KSQFAaQRmMrKvvV9FonLG
	 pOe+j0ZxfNKLPYXz0VLi249D9n69eXmu4AxeAyeM1xw7ZBsPM4MchQHgQWxA6JJkqx
	 5HDpcCuS2udfQ==
Date: Sun, 18 Oct 2026 19:43:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Guenter Roeck <linux@roeck-us.net>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Add support for Microchip PAC1711 Power Monitor
Message-ID: <20261018194324.22e726ed@jic23-hlaptop>
In-Reply-To: <20261007-pac1711-v4-0-6ef34d7a7947@microchip.com>
References: <20261007-pac1711-v4-0-6ef34d7a7947@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Oct 2026 17:41:52 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> The PAC1711, PAC1721, PAC1811 and PAC1821 products are single-channel power
> monitors with accumulator. The PAC1711 and PAC1721 devices use 12-bit
> resolution for voltage and current measurements and 24 bits for power
> calculations, while PAC1811 and PAC1821 have 16-bit resolution and use 32
> bits for power calculations. The 56-bit accumulator register accumulates
> power (energy) or current (Coulomb counter).
> 
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
> PAC1721 and PAC1821.

I think the sashiko comments for this one are a mixed back but the
one about intermediate unsigned state in particular looks like a good spot.
I didn't look closely at all of them.

https://sashiko.dev/#/patchset/20261007-pac1711-v4-0-6ef34d7a7947%40microchip.com

Whilst I do plan to enable sashiko emails for IIO fairly soon (subject
perhaps to more discussions) in the meantime, if you want to speed up
review of your patches, you can reply to the thread addressing what sashiko
has found.  That way you save reviewers from trying to figure out what
is true and what is a false positive.

Jonathan
