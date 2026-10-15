Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59552BE5F
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073104; cv=none; b=cN56jdUFgSL7yC1LFrAArdpgSD28jOc6q9xj51WL5lpAMVFWqI0GT0gOLi4lIIGMH66vl6bmuEbSnxM2jc+uwjGOt8Y6Vp9G/m2+RnrlqCq6clFhN5MsOD3QEcOa8n1/LceIUYCTui83kFZ/k5BivMpOEc08UlR84Smv/+YrxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073104; c=relaxed/simple;
	bh=rsXRTMWRgOAUoFFW65/OyKrBql26Jz4Z0gD0mEPvusA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+9fGcslpXLS4GJHSpDyl2f6DSibTm01f6PuAt2r3T3uSH3qIqPRWnjWFPTRexJAebtrL/6H/X0j4xH+zXispXm4Q75xSmxD5QDwkI1QV1mICI03L3uVVibvGtRon+cqseu9L1RNqAnRBtIJtQLHlpcZkzR3qr1psZBgWlGpkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WuiF6m3R; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WuiF6m3R"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6790844c9b0so4126299d50.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792073101; x=1792677901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nwwCXgdH1/n2kjSGAX/1uosUanbLq6bg/jam8MfBwUo=;
        b=WuiF6m3R5iIq7ZlNajTv3Fywc9buQaZRIwDKdHz2xdmKBDtv7dmYcOazN/88k4tuPT
         bk5vygnm+1BLIpleBbxtO9qZMtWv213eG220JpIYDrSWKN9e8h5ZozhBJsxb630+T+m4
         FwdXzr2wF90hSfTQvjwQ7SrgQfgqkXLuusfwYTo2oXWGwDZd6kJXeTiUwwxnqfejXBLU
         uw3jbQLBqQWraUHMEW0QE8dEsd54jxw6mII17zs93T4N+bqIHem6oRgt28ZCVE9egKOs
         YSGYpWIgJNUT+mq3A1PwHFk4qFiIxO+nc8tq/tWmEgsa/iGQnYxel6QjSF22xxY9R+eG
         6t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073101; x=1792677901;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwwCXgdH1/n2kjSGAX/1uosUanbLq6bg/jam8MfBwUo=;
        b=Dm34B5FmbtKXy/l+TDzo/eQ7BDarw/zN/Bwi/iIsgZvgCSLhTkPvwMsCY8A5iOwuCn
         uzJVE6OKeq6wv7u1rZOm+4ilblOTBC/C95sNOftv6yqYGtETqUZo+D1/5pYor6CAPGEQ
         GURPGKdX+GF+Mew0zX9KOxizQ+zuDyICJoKNms7HK64CL5uJic7iScVJWRvvnkg9awzb
         REji9HReRlNQtjp9bJtrEBbiJyNY0oshxlC6YPtHlXVkbOXLFv5yj3HfHxI/WQXfoFQz
         Y/rqDygU4qu6fKEwPp8Kofe69q048LqJFo83gqhHm8/L3xq5WGV+h86iTs6ecKKqoEWk
         mZ7Q==
X-Forwarded-Encrypted: i=1; AKwUvByagCMHjApgmiGjeT6Sn9s5qM2DhucBf0Ueyt6lxi57QS0BPZ52CUYaZRfkShbKrhCGIpbKkvYK3Ic=@vger.kernel.org
X-Gm-Message-State: AFq9FYL805cfYRIOXpI94BqwhwVSHENoi+2PQLbdbvuiKXkvaFMqtavA
	lgXZmWJ4XH0oe9agec06L7uIF6oLu5w81Bgk6eiE8SAfcqNJB4uEa/mFXVVbLWGqe58=
X-Gm-Gg: AYBFou18pVNnuSXuwFqKwIGsOWVXezIDWTw1M0AS0Aa8RhAtOw0UlpC1ym4AsGKWMxy
	T9Tec55UBvfoxBxnCNXzlLKamEDAaFz8ZZUtFO7123++MWHkJiz+Z2oPPljK77uLBIFmdh4FJTX
	MSx6x2sU2GcZABNTxutFtvWfkMRgnOZvpSmPNNfqorVx7fpSsSDSXingBk4lHGm2lDTkhJt1PmQ
	06LBJe0G7NdfAHwTiZupQQLVF3jwXFXY47952SoQqDtDPCoiXGF3MF/M4MSq5i5WzGcCRUmLkf4
	zAIQnvBPV26H5myHOwere1L60TLA/VrB3gtwXhbjSKhU8E2elNt8J/FraoNcgKshp4471dr3TP3
	/saghgd3/e3kAlIm+GX6jEGVenWuZ7qaCihuO7B3rioglcK/xOX7/vM1EuR6Gv7fCVxoyPxEQxw
	O+MwDY1vhJCsfyBjirkYi7rvdoGyRuoIcipac3MbKVFxoJJtJ+uxlYt48S/p5TWBI7fwotB9SV3
	Ho7N0uyztPzgkkFbb9uH+Y989CCjeWdtbNvZnt6Cj/0YJWk
X-Received: by 2002:a05:690e:138f:b0:675:3507:46e7 with SMTP id 956f58d0204a3-67936984262mr7357304d50.24.1792073101087;
        Thu, 15 Oct 2026 07:05:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7a64:39ea:e5ac:f974? ([2600:8803:e7e4:500:7a64:39ea:e5ac:f974])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6799548f8ecsm1390554d50.18.2026.10.15.07.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 07:04:59 -0700 (PDT)
Message-ID: <11c08f9a-091d-43fb-8c1e-f3f2fe6ec3c2@baylibre.com>
Date: Thu, 15 Oct 2026 09:04:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c14: add gpio support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
 Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
 <20261009-iio-adc-ti-ads112c14-gpio-v2-2-3231a795fa63@baylibre.com>
 <CAMRc=Mfn7+uQYvLjGLxU9wMOnRwx5pyPgaLp6oNx+ZcFXyXL=A@mail.gmail.com>
 <cde9d00a-bfe4-4093-b03d-f76a122e4ded@baylibre.com>
 <as46xFp-3fXvWPlm@ashevche-desk.local>
 <ca27a15c-5b21-4381-a82f-e80bb0ae488a@baylibre.com>
 <atDXNlsDIAzOpgFg@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <atDXNlsDIAzOpgFg@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/26 8:37 AM, Andy Shevchenko wrote:
> On Thu, Oct 15, 2026 at 08:01:14AM -0500, David Lechner wrote:
>> On 10/13/26 9:05 AM, Andy Shevchenko wrote:
>>> On Sat, Oct 10, 2026 at 08:46:30AM -0500, David Lechner wrote:
>>>> On 10/10/26 4:00 AM, Bartosz Golaszewski wrote:
>>>>> On Sat, 10 Oct 2026 01:25:52 +0200, "David Lechner (TI)"
>>>>> <dlechner@baylibre.com> said:
> 
> ...
> 
>>>>>> +	if (device_property_read_bool(dev, "gpio-controller")) {
>>>>>
>>>>> I think the right one to use is device_property_present().
>>>>
>>>> I thought this was the one case where device_property_read_bool() is
>>>> actually correct because gpio-controller property is a
>>>> /schemas/types.yaml#/definitions/flag.
>>>>
>>>> Otherwise, we should just remove device_property_read_bool() from the tree
>>>> because there would never be a reason to use it.
>>>>
>>>> My understanding is we should use device_property_present() for non-boolean
>>>> properties when we want to know if it is present or not before reading the
>>>> value of it.
>>>
>>> That's not true. The _property_present() checks any type of property, while
>>> _property_read_bool() returns an actual value of the flag, while they might
>>> overlap in the behaviour, they are semantically completely different.
>>
>> That is exactly what I said.
> 
> But you made a code different. As I read it it checks for "is the
> gpio-controller property present?" For the question that you may
> think off "is the gpio-controller flag is true?" I consider rather
> if-else branch as we *either* option.
> 
> So, when we do
> 
> 	if (...check_flag...)
> 		do_smth();
> 
> I assume we check the presence of the property (flag). If we do
> 
> 	x = ...read_flag...;
> 
> OR
> 
> 	if (...read_flag... == true)
> 		do_smth();
> 	else
> 		do_smth_else();
> 
> I consider the appropriate is reading the property.
> 

Are you saying flag != boolean DT property type?

type: boolean

vs.

$ref: /schemas/types.yaml#/definitions/flag


I know we have both names in dt-bindings but I don't know the history on it
and if we consider them semantically different.


