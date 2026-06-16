Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3043E49F
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623378; cv=none; b=Ude1F8jTSPaJeX6MDUqul2UOoUBZL7ehmAXsZfvYogJpWR0mvRVgh/oV1oAXq2pi858t1EQPn7u3lXU1g99bVkyr1erajy2D0zECG+0+GDvFfKazacaXqoouBR9HuXnjzX6a0HyNM/m3pNXETqNH6chK91s1Gq9eV8Exw1JLBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623378; c=relaxed/simple;
	bh=Dm+eJzpZ+w4h/0RUMtGBtgG6Lo1FLnxNlxe1iA17mbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMAyL+40p39zMQqJR5un2b0wUqtzOwD5JLCb9Wau6HQ8Rtbp+6Xng7k3x1zThZOPzNTl2kbMHAuZ1bqAbvw4jBTcbwgggC735PKc1pNp1j9b8Hz0cWUWyNsMuyT3qJZIOgBfL77wlFEICuQ6lmXo1yRUWcz/ntANiG6xLazLgEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=daDr1ZOc; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="daDr1ZOc"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a0a38a013eso1012871eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781623375; x=1782228175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjhOxDkswCjowPjmQRY74kXxqAzDQo+MkQLOFEq8cqQ=;
        b=daDr1ZOcmEqvJtu4QRRSySNqnyqhoTRsjxUc/uR6mKEX/fRjc+g0QQPjsPlaY9Azey
         k8HKsM+ZKiv3nMoJovXhkAeaCDBBYYbVcX4ysm41LZSvFNi4T/Nf2KiRwjahmptT8j7z
         MpwncEhBBtW+Hr3NW8chdToHda7kvKFvVCY5N93K/8PVBE9Zu/O4AbRmsO+24EYeTQIa
         pIc8GCL9S0Bu34ImA+oF1OG/sH84L2LNWcdFhklsOwCmq/gHQjmd5zFUoR3UBo5yBe/y
         5vzs8eKoWTGIT7G7Tyi7y3K5PgNJ6MbDSbBTpc9/k6OfzXcV7msq90fizu2cYGVUYyYU
         24xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623375; x=1782228175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjhOxDkswCjowPjmQRY74kXxqAzDQo+MkQLOFEq8cqQ=;
        b=QR1LpXo94biusGaEZmmroIpZ7MwDzINxTLZmmtRkN5lut28rCF9WmfJK86DlkAMBRn
         Y15MZDsa7viPk8PPoIvBcJsc0blZzjseBkRho9WFEHm5MHf24sNqPslxMqIqav5EuIF2
         AOY3UiaS71TC8GW7otPkyuJFCUPqnW8vyklZhPLAAVv7QxKvdPfJmzAkuxUTRqL8uQ+b
         31/gQG0tVn7xwpdhDoGk1t2x0IgPtUuzIRpUUlend23CV4rqmsU6z289KDxmXdHSjcoN
         ClTf24U74Xn7dQPgBw1WQ01qe4Cy8NYWVQPwcpT/VTG2YaYqjm353m+FB3HtCJuuNWDf
         lhRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/CC8UUN6508fXTLdbjdeXHyZ5BvG/OwydWaWb+0feI+/0b5sVBAQ8AZEQiCaPOXy/yo1XQL/lPWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoujf0K2Z9HB3pI7W1tsTJJtHuPOvbpuO/XIWhySEEjZ3EFqKU
	si/dhaX9XEUxjJLDLpFoRxYtS/LtaWErXi/yEG0o/20i76Ry6A6dJe/883zE8/TVnnWCnbwanuP
	e6Ywifs4=
X-Gm-Gg: Acq92OGmRazXYVeKYypY//xMMFntLAA3Txk3m80WGO390KxNXARc9NngBRg1FwUGuCc
	AIG6TxSvR4ZsbmjCoUi+sHgGUu7aUHiqbAyIZibfb709FhZn1U9wDV2TQIeWf9HCON0FvV9IGN3
	oFvspYKkf21jpxgzbEKpaGt8iK8O+TwOl7MwXa4KB56U9BEiC+89gmbWbW8h9s2bjmE4Wr6z9iV
	bOT4x6FT4eUg47BwGBjcIGuSCjcbC4l5USFCtuOfDa1i9c9TkfNBy9alukeakKzQfQ6BaIvZfaH
	w3JdklaqD40h6XA5fD98JGWWCj8Mr+VYMIxQJ20fD35OqTrwJokK844ffL4VGoUUkiu9AIuHPGp
	NM5AVxsIGTNGU4OQqoFd0vowlbLmLu5lhp1c72WIWIB5JDKtzYvcP5kt1DbfXEBlEAT3u+V7YgF
	z2+a5/Le6cIoaDxYhYrW6CWoqJAjt0BfUNrNdoIxlqT8ToUiIFGx8meFqmVhvs43Sjgnbaan9Ot
	EKy5xQqAs5A
X-Received: by 2002:a05:6820:60f:b0:694:9910:f78f with SMTP id 006d021491bc7-6a0b446cd72mr62149eaf.3.1781623375548;
        Tue, 16 Jun 2026 08:22:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:16b0:5133:47b1:a939? ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00ce1f72sm4965290eaf.1.2026.06.16.08.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 08:22:54 -0700 (PDT)
Message-ID: <88f29dc3-7929-4d94-a1bc-6268c41ee3dd@baylibre.com>
Date: Tue, 16 Jun 2026 10:22:54 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add ti,ads122c14
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
 <DJA1PXNS9SFP.VAURJH1MR9BK@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DJA1PXNS9SFP.VAURJH1MR9BK@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/26 7:26 PM, Kurt Borja wrote:
> On Mon Jun 15, 2026 at 4:59 PM -05, David Lechner (TI) wrote:
>> Add new bindings for ti,ads122c14 and similar devices.
>>
>> This is an ADC that is primarily intended for use with temperature
>> sensors. There are a few unusual properties because of this. In
>> particular, the reference voltage source and current output requirements
>> can be different for each measurement, so these are included in the
>> channel bindings.
>>
>> The REFP/REFN reference voltage is usually just connected to a resistor
>> that is being driven by the ADC's current outputs, so there is special
>> property for this case rather than requiring a regulator to be defined
>> to represent that.
>>
>> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
>> have preferred an enum of strings).
>>
>> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
>> ---
>>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 224 +++++++++++++++++++++
>>  MAINTAINERS                                        |   7 +
>>  include/dt-bindings/iio/adc/ti,ads112c14.h         |  11 +
>>  3 files changed, 242 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
>> new file mode 100644
>> index 000000000000..dc7f37cad772
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
>> @@ -0,0 +1,224 @@
> 
> [...]
> 
>> +patternProperties:
>> +  ^channel@[0-7]$:
>> +    $ref: adc.yaml
>> +
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        maximum: 16 # arbitrary limit, channel@ can be any combination of AIN0-AIN7
>> +
>> +      single-channel:
>> +        maximum: 7
>> +
>> +      diff-channels:
>> +        items:
>> +          maximum: 7
>> +
>> +      bipolar:
>> +        description:
>> +          Set this flag if the differential input can be negative.
>> +
>> +      excitation-channels:
> 
> I noticed this doesn't have the "ti," prefix. Is your plan to add this
> to adc.yaml?

I hadn't really though about it. I guess it could make sense.

> 
> Also, do you think excitation-pins might be a better name?

I used -channels to match e.g. diff-channels. The same values apply to
both properties.

> 
>> +        description: AINx pins used as current output.
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        minItems: 1
>> +        maxItems: 2
>> +        items:
>> +          maximum: 7
>> +
>> +      excitation-current-microamp:
>> +        description: The current output of the excitation channels in microamps.
>> +        minimum: 1
>> +        maximum: 1000
>> +
>> +      current-chopping:
> 
> If you agree with the above comment, I think this too should be added.
> In that case, can we call this something like
> excitation-current-rotation for less ambiguity?

I think excitation-channel-rotation would be fine.

> 
> I say this because my device has an "IDAC rotation mode", but it also has
> a "Chop Mode" which rotates analog inputs and averages consecutive
> conversions.

And this one sounds like it could be named input-channel-rotation. Would
this also need a 2nd set of single-channel or diff-channels to the extra
inputs?

> 
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +        description:
>> +          If provided, the two excitation channels are to be used with current
>> +          chopping enabled.
>> +
>> +      ti,vref-source:
>> +        description: |
>> +          Indicates the source for the reference voltage for this channel.
>> +          0 - Internal 2.5V reference
>> +          1 - Internal 1.25V reference
>> +          2 - External reference (REFP-REFN)
>> +          3 - AVDD as reference
>> +
>> +          For convenience, macros for these values are available in
>> +          dt-bindings/iio/adc/ti,ads112c14.h.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        maximum: 3
>> +        default: 0
>> +
>> +    dependencies:
>> +      excitation-channels: [ excitation-current-microamp ]
>> +      excitation-current-microamp: [ excitation-channels ]
>> +      current-chopping: [ excitation-channels ]
>> +
>> +    oneOf:
>> +      - required: [ single-channel ]
>> +      - required: [ diff-channels ]
> 
> [...]
> 

