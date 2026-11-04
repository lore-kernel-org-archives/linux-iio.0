Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793807133;
	b=wMxjfpDHB1otf4XH6Cuz7cNLSn+n3Slyli6IfetsEk1inC+CvZz0F6svOd8yG8SwmkUr
	 scuYQAwsHcnQl+R+LILWfzs4dcZq5a1AkLDy2GxWNBLzRl3xYTi4gqG7VUxYIJd3I//I6
	 afCZ759YE4xUFAxsDZynZzT3lqpaT6bIR6AcOQBAtkmgk4pYFq4eHqOr0L3hxh3JMljl8
	 qsdsMMjjOEOAwcRmTrPeLVswpaJlyYwI+XpPp7QaQNH5N7FqLHQzMsPUkhFNHHrdR3pow
	 Mf9ayoAsLD0bD/8Ml7Rp+wxosNaa8ej9+dwAd10djtwOCaTkxR2RN7RPd1Rc0p6U4aA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807133;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UiVPtKeFBCLtUIymmIehHatACUcvqVgmWR/Go0AACwI=;
	b=cvjK95GGcuw+aSkBXVR/fKhzbD5T5yOG2Vp8zKeCX34/Cbjb8Xg7prKWhrH7gy9QM5Bv
	 gmBtOeRhNGPEy6o+pUY9X/6NM9mZf137P2R0yrdAC+a6wKjXujwUIE5UDmhz41Xn+zOKH
	 ZbDnIT5H51/OV7ZkPHTl3WzjLmTr0TFJeeOd9Hi4Qg3HPODsoQZapTxNOu5znEQskTNOt
	 h958EOcVLzliNiHMAJDwJgsY16wmDSXt4TRPqj0hhPV8Rk5oe5y8Xn0eJvR47jA5kQu2h
	 1tR3ivtIxPUrw9ISYACrLfS8mhF0exptvzcdYODrc+VkEAnXV+yBhVU+pMDvmhgyy8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9sILAcN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0C606A329;
	Wed,  4 Nov 2026 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9sILAcN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793807132;
	b=TgzacdaeK/6EZOeijGzWF43hO2d9BycWAEHo8mTvT8AdzOwFaDFrnQoeT/vwcuzu/whM
	 OfXcLXBF7mkqYWsfrD/bF499W7BcCMt25ieZVV2u3VJXw+7c2omU+EeBMRxT/Me/EdZAI
	 DLMspBlT/s0jRWGFaTDqQmzymlaxsapkEoZRZfOBFvfqMD4dJA5fxtVlqo4oLe+3oqVaL
	 DoM8Awi6gErFwhUj1HIQxY85PGFeWtRBmPPdWdFhjcZV5pOan8BsY3ycL5Q4RrtqLnPdJ
	 jeW5d3Ixb1WWZKzaPlrfWt9UWEkZO5mmtHXJLJmUEh7LrmD5OK/gVsffvZHFcx504kw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793807132;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UiVPtKeFBCLtUIymmIehHatACUcvqVgmWR/Go0AACwI=;
	b=P3by71RdW6whUYoXwf6Ka7Pw2Jg587oitv2MptAEfeCzDQZz6bLP9dPQXIVcURcSYPkE
	 0jtgO8Ms5PKvJQCt2fA21psIXd0A8Djgi5u+92WhPzgQ4ZhyBvafVqtSKkzCwHApVzy+X
	 NwEWqUzf6tkDmrxUF/pxikwWkzdRoB4TDT1nkWwhnHscxkop8Vyz5SgEQ8/0ESOtB5J7x
	 7E8wJfeXBcXsDEr64WfDV229njYUbhsRo/CIAyrBbcm2HSQZ7mMKZh9ChSU44vCFZgZDR
	 bMlvoQW1wBlRPzuIv7kI9mMKkXLNpJMNv12JLhoeSOfp/2F9zGkOZTtE6ixfsGNjWGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id AA2841F000C1;
	Wed,  4 Nov 2026 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807132;
	bh=UiVPtKeFBCLtUIymmIehHatACUcvqVgmWR/Go0AACwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A9sILAcNto+WkqHN6+Vt0XkYtC7US/rjEJy/HrhymlGP7L86tnQgY3JaeKky1MgWp
	 cjTePnup+kQkppdakRFhaERWE0dXxamWBo5enoBroAQQBdKk/rjrOyqk8e6dg0xmRq
	 rB3QLJfM9aush7056qxVE9F7huQSTZvKfrw1aL8/njV0X8CI9Ag132IIk57RoNOpEf
	 r0ZRFg8OYPAFm5WLt+8CUBWTaW5oOqKWlKc/oTHmmzZJfouAiM7wWPs+IO2Owv8Btx
	 mzYND3X87sp7db3TOgKD/8c62cuiGMbKA+TzHxkTRO1+4KeMN2TyH0MviLVsoX6kST
	 nvvhA+8GkYW3w==
Date: Wed, 4 Nov 2026 16:45:23 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Rodolfo Giometti <giometti@enneenne.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>, Eason Yang
 <j2anfernee@gmail.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz,
 herve.codina@bootlin.com, thomas.petazzoni@bootlin.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <20261104164523.00002cba@kernel.org>
In-Reply-To: <autSKpnh0hORsYT4@ashevche-desk.local>
References: <20261104125726.1754980-1-maxime.chevallier@bootlin.com>
	<20261104125726.1754980-3-maxime.chevallier@bootlin.com>
	<20261104145641.000070f2@kernel.org>
	<autSKpnh0hORsYT4@ashevche-desk.local>
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

On Wed, 4 Nov 2026 17:41:30 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Nov 04, 2026 at 02:56:41PM +0100, Joshua Crofts wrote:
> > On Wed,  4 Nov 2026 13:57:25 +0100
> > Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:  
> 
> ...
> 
> > > +#include <linux/types.h>
> > > +#include <linux/units.h>
> > > +
> > > +#include <linux/iio/adc-helpers.h>
> > > +#include <linux/iio/iio.h>  
> > 
> > + #include <asm/byteorder.h> for be16_to_cpu()  
> 
> Yep, but please before linux/iio/* block.
> 
> ...
> 
> > > +static int tla2528_read(struct tla2528 *tla2528, u8 channel, int *val)
> > > +{
> > > +	__be16 data;
> > > +	int ret;
> > > +
> > > +	guard(mutex)(&tla2528->lock);
> > > +
> > > +	ret = regmap_update_bits(tla2528->regmap, TLA2528_CHANNEL_SEL_ADR,
> > > +				 TLA2528_CHANNEL_SEL_MANUAL_CHID, channel);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = i2c_master_recv(tla2528->client, (char *)&data, sizeof(data));
> > > +	if (ret < 0)
> > > +		return ret;  
> > 
> > As rare as short reads may be, perhaps add a check whether the expected amount
> > of bits have been returned from the device?  
> 
> Bits? You probably mistyped bytes?

Ugh yes, I was in between meetings and rushed my reply. Thanks for catching
this!

-- 
Kind regards,
Joshua Crofts
