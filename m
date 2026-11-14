Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618625;
	b=Iuq+cTnhfl9mHxdBrs5gMTnds1IHHHui00aovuQ0RKC3rcFYEXU0WDsIW6rTK4j8V2aM
	 FcQLPW5OppypFaVnl+K2Xr7PSt1BNH9fuURb/F69oNLFGw7gtfJH7DLRNxRVnk+ow86Sk
	 2I382xN929CIKllgizFgqBR8gtSN6PEIabHmtCAkD6U44GWPU2tAR8psfRTKslE+BqLAT
	 mZeYHiA3Z42Y2y4ACjxXRtVtTr6x+N+6mHAVkPGHgarzC48bUaUZvVpXct5msBTZy2ARi
	 MTghqW/lepJE318Gsw+3Wi7TXJZ9teo0A6chG3pfPG81P/pz1bAqczJDLkR8l82igwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618625;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HZBsu99DV8KPogbykaRPIYzC3+hqkstjia4yoW8N5EA=;
	b=cRyOGy5yEV8FKc/Hu4n5JIavDs5VsqnRguly0IQteVBj8HuwRvqZeQUdNaaCCFDIi0nC
	 h7yLOl82xTQzQbe30EGH+hrqjl7dDJ8ylKLaX9mYAtB7K+phH6apuCKikj2U1kVhnZdg7
	 XOKwX5hbVo7PLMNIkVQ+e6KYQ7jVP8eNaQG/pj5Ze8TufHQ0HMdiK/JUyLpg2bjI/IkjU
	 mqLI9wDSA7jMcbilHb4kBeq571Xx2b9UtwtRxUxXN4FUu0L1Lq+j82J4ordyk0cwbWlSp
	 DPRU9E8jcJhgmIdkyqc5mVbSkoglkvIEGaJaKvYhai3w0VeiJtUIpgBtv+h4v4+BCyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yoe7Mb0n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F92606A331;
	Sat, 14 Nov 2026 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yoe7Mb0n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0FA1F000C4;
	Sat, 14 Nov 2026 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794618624;
	bh=HZBsu99DV8KPogbykaRPIYzC3+hqkstjia4yoW8N5EA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yoe7Mb0nIQWUp73vu+o4m89xTcD/mMNd7NTivPJIOONg1g0JdqCX3cP/LyNufhe+T
	 3kNaEk4WIfVAPvvFhqpqaz23HZ2ULQnbRbaRyCArIWJ9U8fKjmeEtJT3a4EMydypu/
	 xfUcTigmbLqbmuTqMx0F2GXR0BXLQnJbt74P+ELyjsKLD/Vzz2F4Xaaa6F2Ki0MPny
	 eoCppCKpezd2v2rk7k/mT5x+NtzUXLAUobffX3QXeXT7nHRfw1066U3PB9MXTE7VG9
	 8Ma3fW75VHEg/oGSiDBvNga71Yy3Dzgt7hliGMtgHA7G610RP3GsLauu6d3cFB2Hm/
	 Wgyu7AwRo4m9w==
Date: Sat, 14 Nov 2026 01:10:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Rodolfo Giometti
 <giometti@enneenne.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz, Joshua
 Crofts <crofts@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Victor Chernyakin
 <chernyakin.victor.j@outlook.com>, herve.codina@bootlin.com,
 thomas.petazzoni@bootlin.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <20261114011015.44831cf1@jic23-hlaptop>
In-Reply-To: <avcvfUcFwdJWjvs8@ashevche-desk.local>
References: <20261113151543.2241604-1-maxime.chevallier@bootlin.com>
	<20261113151543.2241604-3-maxime.chevallier@bootlin.com>
	<avcvfUcFwdJWjvs8@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Fri, 13 Nov 2026 17:40:45 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Nov 13, 2026 at 04:15:42PM +0100, Maxime Chevallier wrote:
> > Add a new driver for the TI TLA2528 ADC chip. It has 8 12-bit
> > channels, that can also be configured as 16-bit averaging channels.  
> 
> I forgot to check if there is a justification of the brand new driver,
> I assume there is.
> 
> > This is a very simple driver, allowing reading raw values for each
> > channel. GPIO mode isn't supported for now, as well as buffered mode and
> > the 16-bit averaging mode.  
> 
> Some nit-picks below, but they do not prevent from this patch being accepted,
> so
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied, I did the second of these suggestions as a tweak.

Thanks,

Jonathan

> ...
> 
> > +static int tla2528_read(struct tla2528 *tla2528, u8 channel, int *val)
> > +{
> > +	__be16 data;
> > +	int ret;
> > +
> > +	guard(mutex)(&tla2528->lock);
> > +
> > +	ret = regmap_update_bits(tla2528->regmap, TLA2528_CHANNEL_SEL_ADR,
> > +				 TLA2528_CHANNEL_SEL_MANUAL_CHID, channel);
> > +	if (ret)
> > +		return ret;  
> 
> Ideally this needs a comment explaining in short why regmap IO accessors may
> not be used.
I left this alone because there is a comment in probe. I'm not sure repeating
a comment that basically says 'because weird' is worth it.

> 
> > +	ret = i2c_master_recv(tla2528->client, (char *)&data, sizeof(data));
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret != sizeof(data))
> > +		return -EIO;
> > +
> > +	*val = be16_to_cpu(data) >> 4;
> > +
> > +	return 0;
> > +}  
> 
> ...
> 
> > +	ret = regmap_write(tla2528->regmap, TLA2528_GENERAL_CFG_ADR,
> > +			   TLA2528_GENERAL_CFG_RST);  
> 
> With locally defined
> 
> 	struct regmap *map;
> 	...
> 	map = devm_regmap_*init*(...);
> 	...
> 	tla2528->regmap = map;
> 	...
> 	ret = regmap_write(map, TLA2528_GENERAL_CFG_ADR, TLA2528_GENERAL_CFG_RST);
> 
> this can kill two birds with one stone:
> - make this one line (yes, 82 characters is okay)
> - keeping data structure free from error pointers
> 
diff --git a/drivers/iio/adc/ti-tla2528.c b/drivers/iio/adc/ti-tla2528.c
index c02b04e19785..754b31d6725f 100644
--- a/drivers/iio/adc/ti-tla2528.c
+++ b/drivers/iio/adc/ti-tla2528.c
@@ -128,6 +128,7 @@ static int tla2528_probe(struct i2c_client *client)
 	struct iio_chan_spec *channels;
 	struct iio_dev *indio_dev;
 	struct tla2528 *tla2528;
+	struct regmap *map;
 	int ret;
 
 	/*
@@ -148,9 +149,11 @@ static int tla2528_probe(struct i2c_client *client)
 	tla2528 = iio_priv(indio_dev);
 	tla2528->client = client;
 
-	tla2528->regmap = devm_regmap_init_i2c(client, &tla2528_regmap_config);
-	if (IS_ERR(tla2528->regmap))
-		return PTR_ERR(tla2528->regmap);
+	map = devm_regmap_init_i2c(client, &tla2528_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	tla2528->regmap = map;
 
 	ret = devm_mutex_init(dev, &tla2528->lock);
 	if (ret)
@@ -179,8 +182,7 @@ static int tla2528_probe(struct i2c_client *client)
 	indio_dev->info = &tla2528_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = regmap_write(tla2528->regmap, TLA2528_GENERAL_CFG_ADR,
-			   TLA2528_GENERAL_CFG_RST);
+	ret = regmap_write(map, TLA2528_GENERAL_CFG_ADR, TLA2528_GENERAL_CFG_RST);
 	if (ret)
 		return ret;
 
                                                   
                                 
> > +	if (ret)
> > +		return ret;  
> 

