Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815599;
	b=XXZ+/XiJMrtUxk02rytLUZvC9gf/MTaDC28wxvzlnyYAJNyldX4K+bthJqvNVGv1YSdq
	 VuaekU8vxKwtK7ENAzHhdSeyJefKAnEz7x/livPV5wr4SaHDnogKAwg2BOzHc9RdUyH52
	 0oliEb+cijcjOcpTQaje2KJQvbDEXY3t6yv9VqdxgNN3MpqSMm2uUWHV2iaqH8HKzn1WQ
	 CmkRSSBVWNpFUtiR0bfAHQOxdzU8ZqfIUJx0bx2ZVDgLXr9HjMqrRCbaD1x/wXh5J9J9Y
	 gINsCs1YAgt1VYDD/aUARF+H3t3A1RYLP4/WilDDNzQGlad/5Ei7CexOP8QPhmsLMaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815599;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=JYnILKMZUQQ2qcf11fz0nOgyjnPywaDnZ+5Jo4mb0H4=;
	b=4XE7ji/kpwtHqZQjhquimLqTewn+Wua9fSf4/9907D3KOPKLoXFHJ16BNhtEp/T8UVig
	 vZNWsJFGMD55Zh54P1eN0jzVkof6yZDIXspzGbTdYGkqaNkO1FNHYL4DYWjBxYjCv5jUT
	 dFcpc1RDcW9QnubhhJkxq7EUlLfNc1o4HjlBuPkfz5R2eKlApQhGmmpe1zRQ+mhUaq6EK
	 l4qyaRSc4/OP8z3UtXq+lxF6KQo1Zr/h8pcEfHSlmD83ifsJcHJfoGE+twAwHkAC0TP/m
	 zJAXljU8noKhRt4fNnvEVnpwZWya9YG6JFPWv4mL70TSwf3DVw8iiHXgFHV854/1ZWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="XsS9wk/K";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F4606D83D;
	Wed,  4 Nov 2026 18:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 438F4606D83D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XsS9wk/K
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 853D61A1455;
	Wed,  4 Nov 2026 18:06:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FE5960770;
	Wed,  4 Nov 2026 18:06:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E71110329205;
	Wed,  4 Nov 2026 19:06:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793815593; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JYnILKMZUQQ2qcf11fz0nOgyjnPywaDnZ+5Jo4mb0H4=;
	b=XsS9wk/K+3MnYk2ZviDuOyRdciIrNf/G6bpo1TAnnDdxOY5EXX4guoJqQ/ePMKWhHV2shM
	Fig3dQL+ImMwlhpLYLsWPQ+/+Ku/n4/UuHVoV/JaST62i/xk3zcIzKYxnhw8N7J2x2JKBj
	4B/I5x/WDey2atSKT4TflgCxtgzlRhGPNeh+leZAp+T1CTpq/U7BaerDFfl4fJ26m6o+AC
	m1RcnoVxroCGDAvngU/qYezzl0ZjNESJj9jQ1FUfuTq6ydtXQKrVRvpRmrF88yUQmtGtwY
	90XLvh8crZAdbA7fkGuDgPzusRIHoYYm0DWv3YBQJf+ldsoJ+3eTRqx2bH2hgg==
Message-ID: <ac9f57f7-cb96-4a2c-85c0-5369b3bb0a64@bootlin.com>
Date: Wed, 4 Nov 2026 19:06:25 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
To: Joshua Crofts <crofts@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Rodolfo Giometti <giometti@enneenne.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 duje@dujemihanovic.xyz, herve.codina@bootlin.com,
 thomas.petazzoni@bootlin.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261104125726.1754980-1-maxime.chevallier@bootlin.com>
 <20261104125726.1754980-3-maxime.chevallier@bootlin.com>
 <20261104145641.000070f2@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261104145641.000070f2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Joshua,

On 11/4/26 14:56, Joshua Crofts wrote:

[...]

>> +static int tla2528_read(struct tla2528 *tla2528, u8 channel, int *val)
>> +{
>> +	__be16 data;
>> +	int ret;
>> +
>> +	guard(mutex)(&tla2528->lock);
>> +
>> +	ret = regmap_update_bits(tla2528->regmap, TLA2528_CHANNEL_SEL_ADR,
>> +				 TLA2528_CHANNEL_SEL_MANUAL_CHID, channel);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = i2c_master_recv(tla2528->client, (char *)&data, sizeof(data));
>> +	if (ret < 0)
>> +		return ret;
>>
> 
> As rare as short reads may be, perhaps add a check whether the expected amount
> of bits have been returned from the device?

True yes, I'll address that. Got a sashiko review about that too :/

I'll also address the other comments in V4, thanks a lot for reviewing,

Maxime
