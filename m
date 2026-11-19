Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079352;
	b=s5wW37SCpSUF/a847ZEguTJFtwYYPu1D6xFCc0/zOSNlK5wB+RTm6ggrv5Tu/dLRkkGU
	 sr8qHx5phAOgmBdWmDs7u8yGjD3QM7dXk9E/+AmtbbPBhKgvM6r0P7SXHeeKn0PmrM7eQ
	 d/UOFJ2LN+1QL/v70az3im1+G1/8v6RONHSPhbrC8PBJviFKSWdirbk0T3hdvt/TPNHCm
	 RXQqYmuAH3LnSzVs4utSluFti3V4+B4PMBquwWEv03bI0whdDftmqz7j5Bxgf9E/3u9ns
	 M+uNaD2XJmoF9ytUdmM9YwfUY9xXa7BZDeBg4yFpNN2K9AqboYUcL5cGDp8RA96yyDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9oi8lNsBr5w3e44Y3FX22JF9crP76D+3fgnNVixtEfY=;
	b=u/Kim4No3yjLNglxq4wy8iQs5kTlRdgEgnthvoMHt3PRWjZ7ssJ6Nup4OTGE8ROCtAeD
	 /EbEiANOO6dGfSveHoJChJ3yETBhnORRKbUNj74s852tECf7wJSMzQTp0pEm+kMpILoRy
	 Jaa2lQU1mhUSYsLZuYYjhRoX3RHEx5buO74ek29n6Jc8mq0aTtsPxApPeQvlBplNhCL2b
	 GKB/mqp+OVgCh88NTKAo7MsHEMAupwJ+S0IFuiFC/B13B6lA2mzO9AW2oQldu7Rwtr0XK
	 5gAriNXJL77gvumaaj+AKy/SaWVqNIpuu0b+K2D4rAGZOm/+CGyN5Ubt0bB7WNDAKNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qLEFgXRu;
	arc=none smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6B606A320
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 09:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D6B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qLEFgXRu
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab46699a09so18155551fa.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 01:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795079350; x=1795684150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9oi8lNsBr5w3e44Y3FX22JF9crP76D+3fgnNVixtEfY=;
        b=qLEFgXRutmjegEMdb/rjrXD2DXMP0SkYUr1b/AQWFWcZt7dIG4GT0/oWqbAdRady9t
         fWFIujqixptaRvueI2+opdC+bvZcyX+8Ur/0y395gXalLTRNy6XCEHvOE4W9VHB/CATf
         aECzfu1zUQNggQAz8vFhP3/O2rbIBqtucs9fQ4DXYrMHS7TgC+mqm8GXkn0b4NtWBJNM
         Ru7jJLUHe9KIb8zrdxbRSGwZtQg3wD0O5/zsNeG42+Bu75r43tCylfS5F2apKubYqtCO
         cx+QXE3BKSBZPlSkMs1X6Rt+ym5gnRKQf11JtyiFOIv3aLB0dQGWNVNdyM+C4T3OutL9
         1BlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795079350; x=1795684150;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9oi8lNsBr5w3e44Y3FX22JF9crP76D+3fgnNVixtEfY=;
        b=B67cgk9rP/swSJ7Hpk7GiW+SuhchocJswZmy6hi9I0ejixiS+OrE1CLijZD2q4Pvwi
         BB/jgSSBzBjGyD7Kfy5Bb1xyK11gzKHf0VUkm/dAb94gSfg8JNNX8WVpviXIpF4CaW1T
         ya1HEOhJ5FzuRrg31PFE+n14UUS+pwjEl4davh9JVaNChXPfm58Bd0XrLI7I2IFVrT6r
         gIj21RpNgHG5E18OX6MxOemaVhDwqQHavAqaYouusk29vTm5o+3Q5CmWOm6aktxhd561
         /LrDT2fHk9FgDKoRyPnkkmP0puEkuPBAFuEaqvIMcnLzMKTcOjq2CX29jQlMy2PJMAu4
         CrBA==
X-Forwarded-Encrypted: i=1; AL+hErFVNjL2etcmj1gzvU9z7YMNKx8o/DDbzdOqte225eqrjrdp9UOHWlZDWSe6eunEWi13hbO+XZsOY5Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z84tLDxUzyvsb5Th3LzjcFiWKXU0e9pbIIDE29EHAf7hPDaTVrM
	X7ob4O1EVBwEFxqXAXvNmhBQzy/ERUXG6979OmK89STd5lUnQ7gx5qcO
X-Gm-Gg: AYBFou0SN1TlH6+YMUpAnVNyv/jzLtMOv3JBwKFxb7naYg2EN3RvDJiWlB9tr7TULWF
	SROmVVkPkCQ0rz7hQosfsoR6QhtdDOr4w5HY88Y2EKyYb10RdvbKN9PduM0XCGxDvWfOPOvXwJb
	vUjj60Qbssld1gx2KRpNDjgve/0fZUhLmezXNC0QbhvyY13JR/svS0xhuJaxEIIr7G/uUOfrch7
	piG7Azb3t0zBFPvH6ZvmJxYfzqWFmYlwcXBe0IddrkR5hNUmCqdBwfiwzNHgXX/mqnY8ltzQh73
	5xsCSmIJHJ0rVrkE50PpDDz6mgbU7yeyZjGAXVc1zIel3bSPP1nFkNaNoSS8WscH3zYkPlCACJ3
	Qd+viwhZc61d06pzttkIIKlBR71MWqI8IJhGlCZI48oNQm3gAFTQp60Km5LlhxNrl44YStQYpG+
	o11FE8wOtbjbfaYTETC765D214Sbe67H+5uEKuVMbquJ5aXYTsathWwkPxW7xmDsMXB/gjzll1X
	wdf+mputbPz7oSFK/iTQD+vJPbI6QNA0giNnxOhD5Hx19dXDsNZ1tviarn8f4w0Gmd2oPsZT49x
	xJP8pjGbYPiULY8FAcJ4dGHoDV3JNnyogZmlCvxalvobsTnauxk1d8xPO+jorjspNKNYrqHS6ZM
	Et71FRNbVKQ==
X-Received: by 2002:a05:651c:41c9:b0:3ac:e25f:3082 with SMTP id 38308e7fff4ca-3ae673108e3mr18231351fa.23.1795079350134;
        Thu, 19 Nov 2026 01:09:10 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae6ebf3296sm8012721fa.38.2026.11.19.01.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 01:09:09 -0800 (PST)
Message-ID: <30520c58-9ac9-45ad-ba2e-9626b8b95350@gmail.com>
Date: Thu, 19 Nov 2026 11:09:08 +0200
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
Subject: Re: [PATCH 2/2] iio: adc: rohm-bd79112: Support ROHM BD79111
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Joshua Crofts <joshua.crofts1@gmail.com>, Radu Sabau
 <radu.sabau@analog.com>, Janani Sunil <janani.sunil@analog.com>,
 Salih Erim <salih.erim@amd.com>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1795009599.git.mazziesaccount@gmail.com>
 <ab74e547e892ccabb763a06e8231e8ed44f4fefb.1795009599.git.mazziesaccount@gmail.com>
 <av66oui-2Pk1XOIi@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <av66oui-2Pk1XOIi@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/11/2026 11:00, Andy Shevchenko wrote:
> On Wed, Nov 18, 2026 at 04:19:35PM +0200, Matti Vaittinen wrote:
>>
>> ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
>> where pins can be configured to be either used as GPIO or ADC inputs.
>> ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
>> sources.
>>
>> The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
>> for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
>> promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
>> the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
>> clock.
>>
>> NOTE: In order to achieve those speeds one needs to use more optimized
>> protocol compared to the one implemented in this driver. This driver
>> retrieves samples using two 16-bit SPI transactions. The first
>> transaction writes the channel to be sampled, and ignores data on MISO.
>> Then the next 16-bit transaction carries the data.
>>
>> Achieving maximum sample-rate would require the driver to interpret the
>> MISO data of each 16-bit transaction so, that when the
>> channel-to-be-sampled was sent in transaction N, the data is read at
>> transaction N+1 - which also already configures the channel to be
>> sampled for transaction N+2. Supporting this would require the
>> channel-to-be-read for the future read to be known when the current
>> channel data is retrieved. For raw-reads this is not possible and for
>> buffered reads it would make things a bit hairy.
>>
>> So, here we aim for simplicity instead of the peak performance.
> 
> ...
> 
>>   config ROHM_BD79112
>> -	tristate "Rohm BD79112 ADC driver"
>> +	tristate "ROHM BD79112 and BD79111 ADC/GPIO driver"
> 
> So, as Jonathan mentioned this should be rather relaxed, so we don't update it
> each time the new HW is got supported. Also in a new style we want a bit of an
> order by having this, text in top comment, and MODULE_DESCRIPTION() to be the
> same (or very similar, like with or without word 'driver').
> 
>>   	depends on SPI && GPIOLIB
>>   	select REGMAP_SPI
>>   	select IIO_ADC_HELPER
>>   	help
>> -	  Say yes here to build support for the ROHM BD79112 ADC. The
>> -	  ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. Analog inputs
>> -	  can also be used for GPIO.
>> +	  Say yes here to build support for the ROHM BD79112 and BD79111
>> +	  ADCs. Both of the ICs are 12-bit SAR ADCs. The ROHM BD79112 has
>> +	  32-channels, the BD79111 has 16. Analog inputs can also be used
>> +	  for GPIO.
> 
> Yeah, and here the style is to have something like a list
> 
> 	  Say yes here to build support for the following ROHM SAR ADCs:
> 	  - BD7911 (12-bit, 16 channels)
> 	  - BD7912 (12-bit, 32 channels)
> 
> 	  Analog inputs can also be used for GPIO.
> 
> (feel free to amend, it's just an example).

//snip

Thanks for the examples ...

... and also for the other comments Andy. I'll create v2.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
