Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729144734FA
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275191; cv=none; b=DmAfDa2LHnbSoVcDUhN7KuHpnqpemdOm/8JQxot5eFC5ZB2+zvPo2NLePZkZ4IHWoSJqnaIHJfm+OccdMDA2vEFGKt22HAPn+52Z93OxwQf6kADxR9pVQYCFg/ZkAUBVQNgTtCGk5q22fF2pnUxDGvl1jf9x/nfNZMWjgb18DmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275191; c=relaxed/simple;
	bh=S5Qgx7ajQ7+7dbJdjbe42nnJSzD4uTYyiMFeewfn+Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOQ+iWJ68bDVOQ/o9B1ObNtA6HEp/FJjF4vvkjHD74sDxgiKaeMpTXhp9H5hU3oU0zi9Ncqa5AAIr7QBotNnpvU+JR2ta5tlN8BZVdZcVPGbENHfxu7FS2+vBdoDG6Hak1F+2OMAU8Fr5uTevdQvDRaAjCTZ/fGzALlch5zVT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=V9rKKe4X; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="V9rKKe4X"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso214415a34.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785275188; x=1785879988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xcjeAiaFIEvJ/x7s9bhIM1GS0uJ3u5Dz39U32Qrg/Q=;
        b=V9rKKe4X9jvs/kqM4DWfeHu1wC9ssDSgJR933RMp9amYrBs9F/Jut0NLzH3H7JiOk8
         QuZ/9UuscBDvUWNleKM8gqRS/z9+OsmZwkZATNpsNsCvQJzUYmftMzefPpfraoTv+vxh
         yvF6ahZP8H3EXWoPL0BfARAEVaQabQNm6IBPUqZAEFyGGEl2/22dmp+U+6pPdD3470lU
         4gEtNKsovndYrePt7OUMiddtwCWCQ4WaKrqiMVnFW0/1hUDPpGjUi42U1SrVcmGA8yam
         cnmdqUmEdlcLHUgmCddBFKoNPkYFbFssEVKkFaqFwKduJGiwzYQTOucYH6JbwxLQY8G0
         8ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785275188; x=1785879988;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xcjeAiaFIEvJ/x7s9bhIM1GS0uJ3u5Dz39U32Qrg/Q=;
        b=MHaYxCmpEMzO1yGO7EUmJdd7CSp3z0qzB/mQ3Zt/ZDqsTWLDvbD9lqqJAmSoh3oJwx
         0T67pkMmLrxMIC4NWJGzQOSAIXPj51Ull9DDPScATS1Kv89TFKVDcge6ZF2g0qdcJlsP
         6i8lIFaaz4nxyTy6RhaKFC/IbvyyxVZ3MqUPgZYRawtq9kHHAT7lYt7vr7Rd8p2wGi5m
         b8I3V/z11Gw4fgDQVb/ePPQvOQBd6irpJ+fjuOX7UJyA5WcNfB0+0kUGftGwej3ky3fx
         I1YR/Te0jCLVG9z6rAtV90bCVNEPwjMBgSIGi4oAujMzzCRsdkdqrHGAXhOSqjyocgC0
         PSvg==
X-Forwarded-Encrypted: i=1; AHgh+Rpt6mVbPiUrjzXKk2QaVNtYtYbyQqyy9F0dMq3IdjVTxhxxLkePxcvnGw4gLLfzGhIy/oR/XJhPR2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6weIxvmNJP0nj/0drMgB1trs2/SAUjQpTd6BoKcbo+u8AZRb
	ihzdqaEePXxnDPnSm2GdfjeUQX4YK9UuWUoyvWqmI/Dbwq1IWT5ykF9d2vH0tWNub0I=
X-Gm-Gg: AR+sD113FN6z/Q5TA5ZgmBhCvHym1Ag/qol1qV4lAv6zs/mtQiCzgzOU/EQHgo6L2l4
	Kmbx6g8hTCplGQ2txAW/OMPm3jcfF5VMkbWqV8b/0vf84/HWIDk9Zdy2KxzHwaNUdsIRnKf9giT
	TkNxgSdnwXvDH5fMTMaW2K8cwHaxpZ7mQJMYbbD01AptjE4F4Jr/TomPDUschmr9smWmIexrFvm
	vMrfIbUf65eIum40JpAUEKBfttyCLzXClPvVw1C5POws5RHPeQb1Kj5l484ONY0Hpk69SxoCUmZ
	30GofG1suQKujrgGhWQASz3gegdD0eOD+0HAfGUERhrUak0tHxmpwYUp9qlQHh1XHUZ9KULQISV
	n+mT6s+Vs0liGZ1MHsQQsjroq+ye3nuc1rr77LFzm1b9HLMvwZXEceuoPhw3OUGqXEDN+G9xBt3
	WblPa6hSa1XFy5Ou/NpyomBhEBJlSUC33ZSBcYfF25gayCxcIEH0R36piTGMBfCSTKmDhkooWHU
	Yond1APwZQZoG6jIF5OZVniVnWQanzAI/v43eU=
X-Received: by 2002:a05:6830:6ab1:b0:7e9:d250:a731 with SMTP id 46e09a7af769-7efff247ec7mr2173612a34.20.1785275188304;
        Tue, 28 Jul 2026 14:46:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3096:ee5f:6f57:afe1? ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d595384sm747860a34.4.2026.07.28.14.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 14:46:27 -0700 (PDT)
Message-ID: <163c9872-17ef-4b01-9392-96e896c284b8@baylibre.com>
Date: Tue, 28 Jul 2026 16:46:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
To: Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Janani Sunil <janani.sunil@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
 linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
 <e2118cfc-feef-4843-917f-844834ef4e60@baylibre.com>
 <20260725230445.60a445a0@jic23-huawei>
 <20260728-barrette-rickety-788b47da503c@spud>
 <e1f977a8-ab38-4dc6-a82b-b955545550a0@baylibre.com>
 <20260728220544.5c65bc50@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728220544.5c65bc50@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 4:05 PM, Jonathan Cameron wrote:
> On Tue, 28 Jul 2026 13:39:20 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/28/26 11:10 AM, Conor Dooley wrote:
>>> On Sat, Jul 25, 2026 at 11:04:45PM +0100, Jonathan Cameron wrote:  
>>>> On Sat, 25 Jul 2026 15:55:01 -0500
>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>  
>>>>> On 7/22/26 2:54 AM, Janani Sunil wrote:  
>>>>>> Some SPI devices support sharing a single chip select across multiple
>>>>>> physical chips by encoding a device address in the SPI frame itself.
>>>>>> Add the generic spi-device-addr property for describing these hardware
>>>>>> addresses. The property is placed on the SPI peripheral node and may
>>>>>> contain multiple addresses.
>>>>>>
>>>>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
>>>>>>  1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>>>> index 880a9f624566..b59d047cf117 100644
>>>>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>>>> @@ -142,6 +142,13 @@ properties:
>>>>>>      minItems: 2
>>>>>>      maxItems: 4
>>>>>>  
>>>>>> +  spi-device-addr:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>>> +    description:
>>>>>> +      Device addresses used when multiple peripherals share a single chip
>>>>>> +      select. The array allows one logical peripheral to comprise multiple
>>>>>> +      physical devices, with one address per device.    
>>>>>
>>>>> "per physical device" for clarity.
>>>>>  
>>>>
>>>> We may end up relaxing that again if multichip packages start doing this.
>>>> Fine to add that clarification for now. We can revisit when / if it ever
>>>> needs that relaxing.
>>>>  
>>>>>> +
>>>>>>    st,spi-midi-ns:
>>>>>>      deprecated: true
>>>>>>      description: |
>>>>>>     
>>>>>
>>>>> If there is nothing useful the SPI core code can do with this information,
>>>>> I'm not entirely convinced that this needs to be a common property.  
>>>>
>>>> I think being common does make some sense from a standarization point of
>>>> view and it isn't obvious where to put it other than under spi.
>>>>  
>>>>>
>>>>> And this only allows for one logical device. If we wanted to treat each
>>>>> address as a logical device (all with same CS), we would need #address-cells = <2>;
>>>>> instead where the DT "address" is two values, the CS and the device address.  
>>>>
>>>> Ah.  Good point for the adc@address or similar needing to match a combination
>>>> of CS and spi-device-addr.  Conor any thoughts on how this would be done?  
>>>
>>> I'm sorry, I don't quite understand. Why do you want to support both of
>>> these representations? Hardware wise both of these things would be
>>> describing the same setup, so allowing this alternate "multiple logical
>>> device" typically is not permitted. What even is the use case of it?
> 
> The microchip parts.  They are entirely independent. The device address is
> just a way to save pins.  That is contrasting those with the one in this
> series where the design assumes you want to treat them as a large logical
> device in a similar way to spi device chaining.
> 
> 
>>> Does it matter at all if you have one or more logical devices from a
>>> consumer perspective?
>>>
>>> I do have an idea of how to solve the adc@address problem (you can do
>>> adc@address,spi-device-address like some other devices) but as I said I
>>> don't get why it would be needed.  
> 
> I think we should often do this because there are some confusing cases
> otherwise. See below.
> 
>>
>> I would expect that if such a device was intended to be used as individual
>> logical devices that they would just be wired up each with their own chip
>> select rather than sharing one.
>>
>> The only reason I can think of actually needing adc@address,spi-device-address
>> would be on a system that was really short on pins on the MCU.
>>
>> So not saying that we need it right now. Just wanted to make sure we were
>> intentional about saying we don't need it if we don't.
> 
> To enumerate the cases:
> 
> 1. One CS has multiple spi-device-address and needs to be a combined device.
> 	Given this ADC does some fun stuff to include messages with no
>         spi-device-address that are meant to be received by all such
> 	devices we pretty much have to map any that share a CS to one
> 	logical device - we have to bind one driver.  This is kind of
> 	similar to SPI device chaining.
> 	address == cs.  spi-device-address property not used for that.
> 	- This one can be normal SPI style.
> 
> 2. One CS has multiple spi-device-address but logically separate otherwise.
> 	This is the microchip devices I think.  For those the device-address
> 	is just a pin saving exercise.
> 	address == spi-device-address. CS not needed as there is only one.

We would still need CS to tell the SPI controller which one is wired. So
we should never have adc@spi-device-address, only adc@cs,spi-device-address.

(There currently isn't any binding for SPI_NO_CS, so the controller would
still need a CS line even if it isn't wired/muxed and CS on the peripheral
is hardwired.)

> 
> 2b.  Same as 2, but there is another normal ADC with a chip select.
> 	How do we know adc@spi-device-address vs adc@cs given they could
> 	easily take same address value by coincidence?

As above.

> 
> 2c. Basically Case as 2 but * N CS all on same SPI bus.
> 	As David calls out this is the pin count minimization case.
> 	E.g. I want 8 devices each of which has 2 pin straps to set the
> 	device address.  So I have to use at least 2 CS.
> 	For this I need both cs and device-address and Conor's suggestion works.
> 
> There is a case of 1 + 2 with different device types but result is same
> as 2c.
> 
> Now, to me the question is whether we say that if spi-device-address is
> present you always do adc@cs,spi-device-address or do we allow for not
> doing so for the composite devices where nothing else is sharing the CS
> (like this driver).
> 
> My inclination is standardize on always doing it for these devices.
> 
> Jonathan
> 
>>
>>
> 

