Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791537F724;
	Tue,  2 Jun 2026 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403898; cv=none; b=Eoe5kuf1h0SgSGpG7g0dEaAuPIxqAs/16vgXR0Be1Jmy6GkoqpFJa9tPhkPQIeZaaj70fEzaQJZp5ozLmAHqQAYW4g/oCeA4hrCgESat71sZxQE+Li5ij5/WZG5qPWRbhJJ73bMlp5A+LvaeBKc3V26cz02yhE1O19+sCJ61lsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403898; c=relaxed/simple;
	bh=mysM/UMNaPDBpCRsJJMna0v79scT5CRSOxuxf9/9Mrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/kKQ7x2lE5hX07xLl/CsdhbWK+FiEyfKVtgNsEkPnE6nB2LwEOxvKLrPP7Ndf/eFdjdv/6jVZovXqz5M9AoN3viUxfcYnyXH19bVplBDZLzm0D6f1ef7qIXHVGcGRWLQskXUW45Xs8LP9GvL82MdT3rMh0yCZyfxN7rVGlgGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoIneWsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoIneWsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30101F00898;
	Tue,  2 Jun 2026 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780403896;
	bh=mqteGhjy+xwcz4PbOrCU9N8F+pg/FZYg/qOU0tH1ZjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AoIneWsIH3D/QiwCUVaDb8iglTjh9vBHPary57jgZ/D3KED0lhj2jnL4YcrjV8U+A
	 QKrRnPIrdSYGHn9bWfU+arRkb+uq0Yqs9NsLN5HWLj90c3qlf7ZyhNqYNjJeL2ob9x
	 1L26NBlGF4mymaexBQLw7zOA066cjaG4PcoR08P+zXiiE7x0zcpaDwBj1GQFlJYqKR
	 2CsU1nTJfJOyuPxv5FO3uLdf3Usnh+8mb5t7h676eh90YrjzqqehzhfPh/5s+yZEGr
	 aDrLlpx2qDNdJyGqaNVs6Z2vfTRSiYaXvNQOTTUgDu9DBr8jxJUI+3+fUW2lUyEUMY
	 RHI30pCQ1ZXcg==
Date: Tue, 2 Jun 2026 13:38:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rishi Gupta"
 <gupt21@gmail.com>, "David Lechner" <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 "Matti Vaittinen" <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260602133806.53590943@jic23-huawei>
In-Reply-To: <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
	<20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
	<ah6p-f2RCW8VcuDR@ashevche-desk.local>
	<DIYI40YK6CSX.2P4017PHVJHCT@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> >> +/*
> >> + * The gain selector encodes (PD_D4 << 2) | GAIN to identify each gain setting.
> >> + * Gains are multiplied by 8 to work with integers. The values in the iio-gts
> >> + * tables don't need corrections because the maximum value of the scale refers
> >> + * to GAIN = x1, and the rest of the values are obtained from the resulting
> >> + * linear function.
> >> + * TODO: add support for MILLI_GAIN_X165 and MILLI_GAIN_X660
> >> + */
> >> +#define VEML6031X00_SEL_MILLI_GAIN_X125  0x07
> >> +#define VEML6031X00_SEL_MILLI_GAIN_X250  0x04
> >> +#define VEML6031X00_SEL_MILLI_GAIN_X500  0x03
> >> +#define VEML6031X00_SEL_MILLI_GAIN_X1000 0x00
> >> +#define VEML6031X00_SEL_MILLI_GAIN_X2000 0x01  
> >
> > Not sure if these one-time use definitions improve or not the readability
> > of the code. Up to Jonathan.
> >  
> 
> I prefer these definitions, and a similar pattern is used in multiple
> drivers in IIO, but I have no strong feelings about it.

Looking again at this, what do the numbers in the defines actually mean?
Seems a bit odd to have the base gain of 1 being called X125.
Maybe a comment on that would be useful.  I don't mind either way
on defines for this but if that number is useful to have I'd rather
have a define than a comment on each line.

> 
> >> +static const struct iio_gain_sel_pair veml6031x00_gain_sel[] = {
> >> +	GAIN_SCALE_GAIN(1, VEML6031X00_SEL_MILLI_GAIN_X125),
> >> +	GAIN_SCALE_GAIN(2, VEML6031X00_SEL_MILLI_GAIN_X250),
> >> +	GAIN_SCALE_GAIN(4, VEML6031X00_SEL_MILLI_GAIN_X500),
> >> +	GAIN_SCALE_GAIN(8, VEML6031X00_SEL_MILLI_GAIN_X1000),
> >> +	GAIN_SCALE_GAIN(16, VEML6031X00_SEL_MILLI_GAIN_X2000),
> >> +};  
> >
> > ...
