Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756ED3FADE5;
	Tue,  2 Jun 2026 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410586; cv=none; b=KABux5KMe8LVmtzYy5+AVo3vVfUSSAiOFcAkizSUKlwr67NZ4+lO+F0v5qmYtSaCTtBxmwnbVL9QzwXp9Hv3obp89whkHI9/kNxd0MwYsT28X2RcO8hrh6GgqQLbcfPFIJg1JglNx54YLkGbP44Huq+YP+xSM20hN63Vp25dKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410586; c=relaxed/simple;
	bh=BNPAy+34odYlWuuQTVerDeM6W3G/JqBzfs9/lDNqs3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3AgCl+bIefOVOoW9vMxC5D2AgWjJFL5ZkBkp+OTeRatnJWnOrRDGEUIEI3CVp3j59ef0rz3n9wjd4fO/7N2dv67ffU9uGT5nbru3QqhjiN3GMjo79W9khPhhptf8kxi4TJU29vAZ8oRoAXbNHSJSwbKQ9ZM65qD9BFC4c373GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPgdmkSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPgdmkSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1621F00893;
	Tue,  2 Jun 2026 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780410585;
	bh=funR8ue4JRV8UpzFF2JgA3fvCSEkwKtqYr1wNP5bfVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YPgdmkSobZPiDaMBtTi1aea2yMPHsu6qxjivjVJCKoQCvx+YavaDzcscC/xVClIQA
	 176TUpz1Pytu4dZfD8n24fF93zfzn4hEQCubL01limT0yzRqqxMwyx6g9JwRFmMX9L
	 Q26cwAs8f+ZoUuKXrM3QEvKrpyCW6CZA02uzW+rTNnPhTqd6PPs2UwUOxxVsFaUMTa
	 XJr2R4DmF5JFKPyBPstLAbwD2BeI1V6h2lGcQlEJjsFcNOkt8AwEeGxrlwJtOkiSFb
	 wp+TvVWNBuRqeY8rsqNL0i3nkXwTAut3re0PUH7K9iSeKqzZXJoyb6UXS++0P5gySg
	 3yefRF9/V6WBw==
Date: Tue, 2 Jun 2026 15:29:39 +0100
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
Message-ID: <20260602152939.78e46dfd@jic23-huawei>
In-Reply-To: <DIYKK894ZZW5.26RO6S0GL2201@gmail.com>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
	<20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
	<ah6p-f2RCW8VcuDR@ashevche-desk.local>
	<DIYI40YK6CSX.2P4017PHVJHCT@gmail.com>
	<20260602133806.53590943@jic23-huawei>
	<DIYKK894ZZW5.26RO6S0GL2201@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jun 2026 14:40:47 +0200
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> On Tue Jun 2, 2026 at 2:38 PM CEST, Jonathan Cameron wrote:
> >> >> +/*
> >> >> + * The gain selector encodes (PD_D4 << 2) | GAIN to identify each gain setting.
> >> >> + * Gains are multiplied by 8 to work with integers. The values in the iio-gts
> >> >> + * tables don't need corrections because the maximum value of the scale refers
> >> >> + * to GAIN = x1, and the rest of the values are obtained from the resulting
> >> >> + * linear function.
> >> >> + * TODO: add support for MILLI_GAIN_X165 and MILLI_GAIN_X660
> >> >> + */
> >> >> +#define VEML6031X00_SEL_MILLI_GAIN_X125  0x07
> >> >> +#define VEML6031X00_SEL_MILLI_GAIN_X250  0x04
> >> >> +#define VEML6031X00_SEL_MILLI_GAIN_X500  0x03
> >> >> +#define VEML6031X00_SEL_MILLI_GAIN_X1000 0x00
> >> >> +#define VEML6031X00_SEL_MILLI_GAIN_X2000 0x01  
> >> >
> >> > Not sure if these one-time use definitions improve or not the readability
> >> > of the code. Up to Jonathan.
> >> >  
> >>
> >> I prefer these definitions, and a similar pattern is used in multiple
> >> drivers in IIO, but I have no strong feelings about it.  
> >
> > Looking again at this, what do the numbers in the defines actually mean?
> > Seems a bit odd to have the base gain of 1 being called X125.
> > Maybe a comment on that would be useful.  I don't mind either way
> > on defines for this but if that number is useful to have I'd rather
> > have a define than a comment on each line.
> >  
> 
> I thought that MILLI_GAIN was already documenting what x125 is: 0.125 =
> 125 milli. More than the base gain of 1, it is the lowest gain you can
> configure.

Ah. The X location maybe what meant I didn't figure it out.
For similar the past we've done _0_125 .... _2_000 
which might be less confusing?

There isn't really a perfect answer for this stuff.

J
> 
> >>  
> >> >> +static const struct iio_gain_sel_pair veml6031x00_gain_sel[] = {
> >> >> +	GAIN_SCALE_GAIN(1, VEML6031X00_SEL_MILLI_GAIN_X125),
> >> >> +	GAIN_SCALE_GAIN(2, VEML6031X00_SEL_MILLI_GAIN_X250),
> >> >> +	GAIN_SCALE_GAIN(4, VEML6031X00_SEL_MILLI_GAIN_X500),
> >> >> +	GAIN_SCALE_GAIN(8, VEML6031X00_SEL_MILLI_GAIN_X1000),
> >> >> +	GAIN_SCALE_GAIN(16, VEML6031X00_SEL_MILLI_GAIN_X2000),
> >> >> +};  
> >> >
> >> > ...  
> 
> 

