Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42973603EB
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778959514; cv=none; b=bUMgSTXR56vLcH6VJl8DDQWePLiTyrW4uGYHxarCYMTZTdfd3szyQNSKtOBEoZV0ZmGFupbbRJcXzrMlGzMXaMKb/rxoa+NEesMmODs3y/hGTw5tDWlhR6+bmfI/8O2z5L324hF2PIp0BHzQU3cOd8KefqMX6TTnXhtkWiI5fzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778959514; c=relaxed/simple;
	bh=Rch9BlJKm86u2jFjWPy/exsEl++VNJ8K47Z8YCQbhlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKuavNhlWJfvYnLdHXNECca8UuPtrR8ma0JTQ12xUEEYFqG0cdIRuDzacirNI2mJawkB2vxvks3KX3Ay5v32LjAMXpSfXqsOY8tTi8Bu/v6S6nzOjQgJjWzPjpPeHRP4O8gnvV4+1HkIhW1+GLbPc/HvpEUMeewUK7nTYU+kViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=sjV3WU6g; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="sjV3WU6g"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dcdaf06498so647404a34.2
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778959511; x=1779564311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fPwesdjsiyiHQsIQO0tND7lOMwn0nsVsfr8NNzx7zw=;
        b=sjV3WU6gDdb0fiziRhotQ9qQeXC8VEmtLrnNWudUrByaxsuCsYa6AxQqE7/fkBNGPa
         V0AcgN6U7M7K9+/wxUOvV5ss0LytD1wpmk7nYvA3JkRiFwUshu6bCauzBjpM5hgT6r1n
         FA1MqINegzVeAVmmqnQ5guYze+89oNRBAh/+iTCIeXIe9H/c7g5Hp/U2AFHakAodC87T
         apYqtK50GdRB7ljIC1f1ZtiaJh69wCnTCFcmOl256m6B56ldux7Sv+Wz5zP73e4yYsKF
         cE29cBTu2UeceI2qgFk/9DPET6JS8IG+hKpuzY43oIM9ctwxWA5I4/uOJ2LNyu31wYng
         umxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778959511; x=1779564311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fPwesdjsiyiHQsIQO0tND7lOMwn0nsVsfr8NNzx7zw=;
        b=mEoOcG/EJAEmkZ+Hl6JAxgAcE2jZw18Jh6GIguht+MXNIaVP0g6lA/W/B6JijeNAon
         1cRUWT2TMgeNdyaHmk2NdPpPUh8o9MPOamlCmBmhWgnGM0/6zg9FMbmavJfEJiyMtAmQ
         mK3omfDk4+o63yDicTILt0HL+FZyBHbLIA8sandZA7K8vscBVp/uiOW+MwYPeciaRPPd
         9G2YP5cOb4trp0XmItBXy+lW4LyK+eFJWhPiyEuWCgoqKggBrpSTuriyZvtwgO1VvsWu
         L9UjsddabGGluBCEVbVeodXro3EFG0TVYIHi/P+1TLsK8O15aPorUfMl/+Owt+cS7jJJ
         nbpA==
X-Forwarded-Encrypted: i=1; AFNElJ+UXmbq9q80sRiSNDoxNNx63l0qQqIr4k+9dcfeHkmWGS3r/SFD+yk4P97IEh4DZNn2JYOAEYIKsdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZt3lB5D/sZFs4OQVODXRn6PZL4Y7bxdhGNR2nRVyhvEdaSsE
	N3CidCrcA6ugUbnWvkMEnoRRpEqr8Jl1kZ9FDW92EfShF8j3AoceB1Wlr/+gvFgNlzQ=
X-Gm-Gg: Acq92OG7jmSM4/wyN9YblPwIgPnjqiFrA0PxejKnPrVw+VmMFCjicPe/myY43u1IcrK
	pAKvUxUjaqo5xdbDI464whBxEWvR+HQHDjfyKTe3cVs/GIQJsxXNruNInFHBu+iJXKeQufsNLUC
	rp2OgE8a93hsn8WZvg650IoC17GzwOj/+UbDNRILdl8VoqjKgjA4Kz85DzH0W2+EWM6rZBQwzX+
	De+8VgT7POsiwgv4WzRhXjgiTUriu0nf2ytUuwDcv0Xv/rN94Bn1cO/5qA9hucZBghd3yF0qsxI
	yOsjyvZMmSTGwtQqgCJAXSSchTxQdbK3GTjwS9eoWkHu9FqPziAfJwWwFlJimHiSV7GvDgmCOtn
	jCTr2ROtwl/20jjOEVUmgx4WNIckvrvFUfVJzTQ76n2717VWXU2pwUWJHDZzK1d2ECLlShJpBkn
	s/19RsSqIjr3u7lWZhCl5ApMI29PyTZIrwOosDDWwiRUYNJS8+GdkJQwZ8u+J8A9EvXgeHV1GqO
	w==
X-Received: by 2002:a05:6830:4704:b0:7d7:4ee9:c39a with SMTP id 46e09a7af769-7e4ea031993mr6198970a34.4.1778959511638;
        Sat, 16 May 2026 12:25:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b507cbesm4126569a34.0.2026.05.16.12.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 12:25:10 -0700 (PDT)
Message-ID: <53d547ee-1ac3-42b9-92a6-e7f48b72fee3@baylibre.com>
Date: Sat, 16 May 2026 14:25:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Add AD5529R
To: Jonathan Cameron <jic23@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Janani Sunil <jan.sun97@gmail.com>, rodrigo.alencar@analog.com
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
 <20260508-ad5529r-driver-v2-1-e315441685d7@analog.com>
 <20260508134843.7646c4f5@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260508134843.7646c4f5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 7:48 AM, Jonathan Cameron wrote:
> On Fri, 8 May 2026 13:55:47 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
> 
>> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
>> buffered voltage output digital-to-analog converter (DAC) with an
>> integrated precision reference.
>>
>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>> ---

...

>> +  * Multiplexer for output voltage, load current sense and die temperature
>> +
>> +  Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf
>> +
>> +properties:
>> +  compatible:
>> +    const: adi,ad5529r
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  spi-max-frequency:
>> +    maximum: 50000000
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO connected to the RESET pin. Active low. When asserted low,
>> +      performs a power-on reset and initializes the device to its default state.
>> +
>> +  vdd-supply:
>> +    description: Digital power supply (typically 3.3V)
>> +
>> +  avdd-supply:
>> +    description: Analog power supply (typically 5V)
>> +
>> +  hvdd-supply:
>> +    description: High voltage positive supply (up to 40V for output range)
>> +
>> +  hvss-supply:
>> +    description: High voltage negative supply (ground or negative voltage)
> 
> I don't mind doing it this way but in some similar cases where 0 is something that
> can be considered the 'default' we've made the supply optional.  What was
> your reasoning for requiring it in this case?
> 
> dt-bindings should be as complete as we can make them - with that in mind...
> 
> There are some more interesting corners on this device the binding doesn't
> currently cover such as mux_out pin.  We'd normally do that by making the
> driver potentially a client of an ADC
> 
> Easier though is !alarm which smells like an interrupt.
> !clear probably a gpio. TG0-3 also GPIOs.

also optional vref-supply for external vs internal reference

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - vdd-supply
>> +  - avdd-supply
>> +  - hvdd-supply
>> +  - hvss-supply
> 

