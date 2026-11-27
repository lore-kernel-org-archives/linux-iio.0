Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795761266;
	b=NVxVHvcydwkokXa3xfAxkhtqmKxxXc/tyeFc69VKMvXwNVfFDrlsM9PymPGvkLEMPJbX
	 9BiT6ntXCLoIOh/nEjsPuZu4yoPNqBbUU761mZxPBa2NN9hENkF9y4MFdDnth2xZ57LoH
	 MT3SAJTWu9iH0WIwJZ4ZnT/anmQrV7bKwMSfv7F0RRwzWM+eDTr59eY/lFDb7sUCPK9ue
	 TR5yHPFEP2dwpd5N+blMPsbGnJVP0nTE9TCrYMRXfh+UFdZ3X1kHQfezawa7nwKMKw4IZ
	 3ZPJa+McoCOkoTqPcpJhhkBv3RuUWJGfhCdwV3Bc/nBUs1Vu136STMp7TPte6JsDehw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795761266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gUzNN5Vkw+FWG6ldm/CpYslMZUG/iWEMjDh+KHc0a9s=;
	b=wunn0CpbCvPz0zyMkatfX3u3BKadNyKmI5V1OpGXDnLvHzXPK8TDMWKi5jAeDbCiNTej
	 gg3aL7vXAw+vlh76sahOTIqpqgjTHAkJygaAcUdY9pOACP/v6Dkm9HdJpl6VybbSrJC9p
	 oj/oC+CHf7+ys3hp2zY8CSiKuFoGjoiQPgpeBHMvkRgRei371U6nPI+JbICVNdtTGRQO3
	 FUTAVacyV1qO/ed+UUVlD5UW8Fzv5QqbuGJR9u8DEM0br/G2H1fr5Jy7qvgYDDv0XeTPK
	 G62ZEMp32amCo230ZdJRoX+mvWS5RUkOm7NBHWLbAwvSK7OvE3Cd7OP/AwTaEkakkQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HP53Pcxz;
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E3C606A321
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 06:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7E3C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HP53Pcxz
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c126fa1e3aso5733100e87.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 22:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795761264; x=1796366064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUzNN5Vkw+FWG6ldm/CpYslMZUG/iWEMjDh+KHc0a9s=;
        b=HP53Pcxz6VK/d6Ax3MTyVnSdtArB+vXwV3IZ8ubtFb78o88Zb1uKFP/GOgE2eC3VUz
         zZ+PT6v2ILrKcaJaqFVU1QDdbdTVWxvfrevuYbQkj/BiufpDAchFNczsvGPEcgXYpqF9
         Quoc1a68aOcasr9mZ9qICWsu+RLRoPzyiFkally9q3S0sFHEvEcLwSUDRczNAsTV4xtx
         QzHJRjiyoUNFHnwFzxaok2gagjHNmMaxoOU58dR3HRe4jfJy3tqsRdxQVgU25j3ikOYj
         TyRi7NVI5VHDmKH4+Zcn6VQfo/pyjQNQJjMHNkHw/PcvhPxxvskDg0J4szE4F0H45FKK
         3uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795761264; x=1796366064;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUzNN5Vkw+FWG6ldm/CpYslMZUG/iWEMjDh+KHc0a9s=;
        b=KcUpdc6hyXyJpj5a1tD59uQcG/XzHXdhhSgT1+aTIKZxpAOAJbGP9QGN6MTFSawUWI
         QMnJBjB21urRViIVU9DtGhpBFv68YbyV7fTzNmdykJZ2AJ7WUMqas+pN0v+MJZUWeo+w
         DBre1edXmpUqK/uwnumkPLJkqrD0U+RUALQNMeFrRxl1x4GSFdKfwrzgSQa083o2Uc5D
         4GCajtEkaoLRiOoEXs0fnJ+pi6CoeffstIQg1MyoKiuoR3dN4OIUvwB4gOpnjcbG0a3H
         pbb55Sv5PY8ryychz4ROKTGcWq005/k9VswzqspTbgqczaOEs4co9jxY0yqX/WFtnGWA
         6MUg==
X-Forwarded-Encrypted: i=1; AL+hErFo/Ggb+x0K0auSxh53Ul8SjPuti+DJp3lMmVVzZIeShNX1Yk7DL3aCPesYWCIse1VWgcE0wP/WihE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jWh9wmsmKF87BwIMufXiAiESS0RNKkMeqwFGlA6K8w7Apbk6a
	YrM4HuqIwTt8gdcOt9dZXdGzGIGkM7TlF1WcLUbejpp/D+POgEJ35QUQ
X-Gm-Gg: AZFdTZcekpZ4RJvUruEg8dUEPm/5CBdmPFZM1LBQNxcWVIUe+Zw2eH5F22pOJpvIN5a
	kKKxjN0bmfWgrdNHH2P+/yJuZ5cmXTX3OWZHwhN3QKlW8ru9toQkPs6q8j4dlDe/lxdnGFZTjCy
	RENXyAaKub7MyoKmH68p61xRzL/FBjYuJz6/8SXpFxqnKITwJP7Bdxhqi6NHxBGEk6rxvN566Wp
	CVSyJG0pTKF7kCK1blRsFhgSvAVbxK/PVACF8mBVOXxo5HnbM7juekL3LXzyjTHufK0GV1GPE/1
	40R/vxA5FxQsBrdfBXU42xHi/IP2W/PkleSZp0vhPYtLPskOKoQw/yH4eXTxYeG1p0nWeHwD13w
	CXyCTMIc1+ORB4oHsGZVul9gQLIbzGQHVhKAGUH8/ltbV2pmAlShFNnw0MKRDfEG2LTgRCeAsHA
	yXGG6wC/KZFYMwrSGeIkTkAnHKA7p3RWZo5w9Tfrafnk6FUEP4VHkqlJs1sTyzTqppemkhTDx1b
	jIgpcO39RoVHsPE5GuVNRYhL7TdmItnaCM69tdUOJVZ6GJ/PrkwbRxE5yeAgkGsoQdTmbW7TpOY
	zX4bA4ngHpA6byLXcCySLslxSH4sgmlXKCx+ZJ/B/p+y0dPvriWAowNKNn6uymTFzTegvr0tzpl
	6WWo4KcBXkg==
X-Received: by 2002:a05:6512:108a:b0:5bf:b93e:8854 with SMTP id 2adb3069b0e04-5c1bc88c6f5mr6895499e87.57.1795761263755;
        Thu, 26 Nov 2026 22:34:23 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd07a2a5sm5678566e87.78.2026.11.26.22.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 22:34:23 -0800 (PST)
Message-ID: <036d044a-67ef-4716-aa0a-cdf3108c12e4@gmail.com>
Date: Fri, 27 Nov 2026 08:34:22 +0200
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
Subject: Re: [PATCH] iio: dac: rohm-bd79703: Fix full-scale voltages
To: Joshua Crofts <crofts@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0723d51fa973f0204e1c436c08a784b7b1cca795.1795699121.git.mazziesaccount@gmail.com>
 <3ec029d6-d53d-4cd9-8582-a15cfd3eb4d1@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <3ec029d6-d53d-4cd9-8582-a15cfd3eb4d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the review Joshua. (I appreciate reviewing effort even though 
it may not sound like it.)

On 26/11/2026 15:31, Joshua Crofts wrote:
> On 26-Nov-26 14:23, Matti Vaittinen wrote:
> 
> ...
> 
>> diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
>> index 127ccc2c4a22..1d58bc1544a1 100644
>> --- a/drivers/iio/dac/rohm-bd79703.c
>> +++ b/drivers/iio/dac/rohm-bd79703.c
>> @@ -41,7 +41,9 @@ static const struct regmap_config bd79703_regmap_config = {
>>   /* Dynamic driver private data */
>>   struct bd79703_data {
>>   	struct regmap *regmap;
>> -	int vfs;
>> +	int vcc_mv;
> 
> _mV is the preferred style to denote SI unit variables.

I have discussed this before, and I disagree. Regular variables have 
been lower case since forever. Capitals have been used to scream "Note 
me, here is something unusal you need to pay attention for" (like 
macros). In my, admittably not always humble enough, opinion, the whole 
"denote SI units" is stupid. I haven't yet seen an engineer who wouldn't 
understand the meaning of vcc_mv in this context. And, to be very blunt, 
if I saw such an engineer, I would rather him stay away from the driver 
code. On the other hand, I have seen engineers who have spent long time 
with kernel code, stop reading to wonder "Hey, we have capitals here, 
what's special with this variable/member". So for me a change from 
vcc_mv to vcc_mV makes this worse.

>> +	int vfs_mv;
>> +	unsigned int num_vfs_chan;
>>   };
>>   
>>   /* Static, IC type specific data for different variants */
>> @@ -49,7 +51,11 @@ struct bd7970x_chip_data {
>>   	const char *name;
>>   	const struct iio_chan_spec *channels;
>>   	int num_channels;
>> -	bool has_vfs;
>> +	/*
>> +	 * Some ICs use VFS-pin for full-scale voltage for first N channels.
>> +	 * We need to know these channels to get correct scale
> 
> Small nit, but missing period at the end.

Thanks.

> 
>> +	 */
>> +	unsigned int num_vfs_chan;
>>   };
>>   
> 
> ...
> 
>>   static int bd79703_probe(struct spi_device *spi)
>> @@ -184,23 +206,26 @@ static int bd79703_probe(struct spi_device *spi)
>>   				     "Failed to initialize Regmap\n");
>>   
>>   	/*
>> -	 * BD79703 has a separate VFS pin, whereas the BD79700 and BD79701 use
>> -	 * VCC for their full-scale output voltage.
>> +	 * BD79702 and BD79703 have a separate VFS pin. On these ICs, the VFS
>> +	 * pin provides the full-scale output voltage for half of the channels,
>> +	 * and use VCC for the rest.
>> +	 * The BD79700 and BD79701 use VCC for their full-scale output voltage
>> +	 * for all of the channels.
>>   	 */
>> -	if (cd->has_vfs) {
>> -		ret = devm_regulator_get_enable(dev, "vcc");
>> -		if (ret)
>> -			return dev_err_probe(dev, ret, "Failed to enable VCC\n");
>> +	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to enable VCC\n");
>> +
>> +	data->vcc_mv = ret / 1000;
> 
> Better to do ret / (MICRO / MILLI).

This is another thing I've discussed also in the past. If you genuinely 
stop to think this, why would MICRO / MILLI be better than 1000? Which 
one brings smaller cognitional load, huh? And assigning the result to 
variable vcc_mv makes units explicit in any case. And speaking of SI 
units and scientific accuracy, what actually is MICRO? What is MILLI?

...

Micro is 10^-6! Milli is 10^-3. So, this becomes "ret / (10^-6 / 
10^-3)", which is plain incorrect. So, instead of making things better, 
this obfuscates stuff even further. So please, let's not spread this 
madness any further. (So actually, this should be 1_PER_MICRO / 
1_PER_MILLI - and that'd be even more cognitive load. When did our goal 
changed from making easy-to-understand -code back to making 
fancy-looking code, which is harder to understand, while claiming it to 
be an improvement? That's what these discussions really look to me.)

I agree on using MEGA for 1000000 and even 10 * KILO. This makes sense 
as when the amount of zeroes increases, counting them becomes harder - 
especially with old eyes like mine. But using (MICRO / MILLI) instead of 
1000, that's, in my opinion, just plain stupid. Intentional obfuscation 
of a perfectly clear thing.

I am ready to discuss these points when I submit new features, and I've 
done this quite a lot in the past with Andy ;) But with a fix for a 
pretty severe bug potentially causing unexpected voltages being driven 
out of a device - which may cause a havoc to hardware. I'd rather get 
this fixed ASAP. Maybe you can send an improvement patch with suggested 
styling "fixes" if you feel really strongly about them, and we can 
continue discussion there? I am sure Andy will also join us ;)

Yours,
   -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductor
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
