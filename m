Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9039EF38
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674071; cv=none; b=qVg4HZnAZHDMC8XrhgULfIkpj9IWK4UpbqezD+dsw6HWSjLAwd3qHosYU9pVnD/+vwVZ1yJr9h51DFnWV38xjCcQg9C9KN72LFiapl3BUO/SF93SVsmEAj0ZCT9waXleUtoBQ7LRdYd85ISRPVW7O4YKkfiQvVXwryYxTfijcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674071; c=relaxed/simple;
	bh=qpG/1vY4dOiYQwru9PU879QJPd/QPvUcZPRbRx5ZIBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkNIPqEiLc7IpBChZ4Zp9AwnBhlwcDki7AGsN/VcTOn9wuG7V3QRDyOJXUlFDtyj5cqB9Af7Ugyv6VlEE406jpzBn/IWyIx8WfSVaE8tPwiQoo42yBpchlAEuRqqQHZBET+2nomFCBMDIjiJ/wAGSJvFAk05SpkBOcPsLwOj91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uZ6QC/3h; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uZ6QC/3h"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d756f2a06dso4169750a34.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773674069; x=1774278869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8x5eATN23jYRz4BCnmX7sl/BaRv2gWsraoFkpJIVsk=;
        b=uZ6QC/3hRLxPpUC2v5S+9lTZfJ5zJxZrBlEVIeiGn62i7cOZh4SeCCIlVWGPhLiV/a
         f/vYrEQOvlP14nShPxAUyw/m7sZRVFHTXeoByLlQkhJZ7zWMxbJouuHRvt2tHYn+3evi
         dnd8SUvD+Pu7I41TIIpJr0mGJo5YNsbSKAxYbdnn/CtYBh2IyGZT5OpT7xjc2G9iDxDW
         htNR0judOgV9FZnnIAELB86uEIND8QGatBe/7lM4Jlety1glViZuiCt0ciV6vvHhNQ4y
         NBDhuxhpxhgisipLUME6p3M+yrihCkh6WCktdg8HjKirceGM1C8EEk2YQldnU52vZ7Ds
         Iakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674069; x=1774278869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8x5eATN23jYRz4BCnmX7sl/BaRv2gWsraoFkpJIVsk=;
        b=K+GDJbRPqTivUj8/9Hirptwt/BicGvmPebxZC5gqPjUfKlCDH/JnuqgXsXnPKA91QK
         L+XUttciEJhnskBN/Nci0qRPHe66O6ZIOKw9ncma+AO8KK4Q6R+QPanQptkHDWSkiemf
         ycY4531FeIbJW6cjUB2u/6v/z85GhvFO+cJG1OEYZeb1PTnQfcUzYpY+rRcwOkYIKKPE
         UB/HAh4cA1hLXn4w5/YTt56I/lUnLzbyFoo1M5Vbc+94ppnwZYfFnAjaIyNghUq1qmHk
         AuZcOdKh6AWiF+4wtlE0r6TDXmRpQsMb7kRC8ecOZEHjHAIUq0TyBsK4ZNWeM59EGsA2
         7gPw==
X-Gm-Message-State: AOJu0Yy6KsSMKhnNROeFbzHbzY1y/88HSwFchy55aQCJikP3kSoGSbDd
	G0+2H5ll/QJ27ZeVc+SIXMAZrN8NVhQJ6RPsjki8CiUU6xmuH7KqeC6yDpbo3GydSyc=
X-Gm-Gg: ATEYQzyZJrWhzq6jFC3td6zEnQt561r8wC/EnoNd/Q3TRqcDTxj6E1H2VjdkVYTwl6p
	HBzCK3BWURqXfBaglPh0zQswqFHc0MpLxyYAxTMcgPXn6hrWt6IOazgjyun1yl+8/qzt5Nz6cCm
	7R05FpYirYZPY3H6Uhsz8XgyGzJ3C69yXX94PPGgrIWAouz+k8aGr7MxRcEKImczw13P5hYI6hv
	43WcOgfuzU7GbjxY3PWmXyddL7rx8+qRuSkFDnkucCD0XRXvNq0ZdhGF91aBhirIrm+IA6zNRkv
	jbep+5GdcODR6wxeSLo1MpscOD4tk6bl71eiLNfF9nmLPpVWHZu5LxAPov+4ZVb9qg9MCziH0zm
	CpBn1oBqGM0vdog1JPqUGzUBu6KuPb0grUJ3u2WH5fUasSX9kOnvf6kia8z7y/4XHmDkhTcWBFw
	S1g/GZ20NfE2bPqwpV5AG7AnaX5cNLEz4IzifDSfJuIXABvuuZ7+2iHN7ydfo0sRH6gNimD5rsC
	A==
X-Received: by 2002:a05:6830:6519:b0:7d7:4c03:d4e2 with SMTP id 46e09a7af769-7d776d1c0c6mr11002771a34.18.1773674068556;
        Mon, 16 Mar 2026 08:14:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae9a51csm12527858a34.23.2026.03.16.08.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 08:14:27 -0700 (PDT)
Message-ID: <04257601-5ea2-4cd8-8170-29decad13861@baylibre.com>
Date: Mon, 16 Mar 2026 10:14:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
 <a1824f39-3925-4e94-ac98-52dcdfbaa0d2@baylibre.com>
 <LV9PR03MB84149CBDC5DD03EDAF554136F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB84149CBDC5DD03EDAF554136F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 7:39 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Saturday, March 14, 2026 5:30 PM
>> On 3/13/26 5:07 AM, Radu Sabau via B4 Relay wrote:
> 
> ...
> 
>>> +
>>> +  clocks:
>>> +    description: Reference clock for PWM timing in CNV Clock Mode.
>>> +    maxItems: 1
>>
>> I feel like I asked this already, but which pin is this clock connected to?
>> It sounds like it is the clock for the PWM, not the ADC. So it does not belong
>> here.
>>
> 
> The pin is connected to the CNV pin of the ADC, which in CNV Clock Mode
> replaces the internal oscillator. 
> 
>>> +
>>> +  pwms:
>>> +    description:
>>> +      PWM connected to the CNV pin. When present, selects CNV Clock Mode
> 
> ...
> 
>>> +      Two cells are required:
>>> +        - First cell: Trigger event type (0 = BUSY, 1 = DATA_READY)
>>
>> I'm wondering if we really need to specify the event type. For interrupts,
>> we we just specify the pin and not the function when the pin has more than
>> one possible function.
>>
>> I know that we have done something like this on some of the previous SPI
>> offload devices. So maybe there was a good reason for it. Or maybe I just
>> had tunnel vision at the time.
>>
>> I suggest we try implementing this with just one cell that specifies the
>> physical pin. In the driver, when SPI_OFFLOAD_TRIGGER_DATA_READY is
>> requested in the driver, we can use that to program the function of the
>> pin accordingly.
> 
> I agree with this, since only DATA_READY will be used anyway as an interrupt
> in CNV_CLOCK mode.
> In fact, I am now thinking of removing ADC_BUSY entirely, since its used in
> just two cases, which none of them perhaps make sense :
> 
> 1. Manual Mode,where ADC_BUSY is selected for GPx, though is not used as
> an interrupt or 'feedback' of anyway.
> 2. Autonomous Mode, where in theory it would be used to see when each
> channel was sampled, but this mode is used for just once channel single
> shot reading, so again, not actually used.
> 
> The implementation would see the enum removed and just initializing
> the GPx pin used as DATA READY using a macro. 
> 
> What are your thoughts on this?


We should try to consider every reasonable possible wiring situation.
The only case I can think where the devicetree might need to know the
requested function in addition to which pin is if the pin is wired to
something not controlled by Linux. That is an odd enough situation though
that we could defer considering that. I think we could add support for such
a thing later if we needed to without breaking the existing bindings.

So hopefully I am thinking clearly enough about this to say, yes, we
should just go with #trigger-source-cells = <1>; where the cell is the
GP pin number.

> 
>>
>>> +        - Second cell: GPIO pin number (only 0 = GP0 is supported)
>>
>> If GP0 is the only possible pin for an output, we should omit the cell. If
>> there are more possible pins, we should document them (even if the driver
>> doesn't support it).
> 
> You are also right about this, other pins can be used as DATA_READY, and so
> the DT should perhaps indicate which of those pins is actually used, so
> that we know at probe (gpio_setup would make a comeback?) which
> value should be written to the GPIO registers.
> 
>>
>>> +
>>> +      Macros are available in dt-bindings/iio/adc/adi,ad4691.h:
>>> +        AD4691_TRIGGER_EVENT_BUSY,
> 
> ...
> 
>>> +
>>> +            clocks = <&ref_clk>;
>>> +
>>> +            pwms = <&pwm_gen 0 0>;
>>> +            pwm-names = "cnv";
>>
>> Should we also include the trigger in this example?
>>
> 
> In this example, I would say this is needed since the CNV PWM is
> not only starting the conversion on the ADC, but also controlling
> the sampling rate, making custom sampling rates available in
> comparison to the internal oscillator used by AUTONOMOUS.

The point was to have an example that shows SPI offload usage.
I assume this would be more common that PWM without SPI offload.

> 
>>> +
>>> +            interrupts = <12 4>;
> 
> Best Regards,
> Radu

