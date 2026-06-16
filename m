Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423F395AFD
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643888; cv=none; b=AogXvp6QFMODma4C4gEO1r2I0gdvVupZIy8wPYrn/LnooICp23Blir5W21waNo56ijkuL8/JQGD97wH0q4biSfbRgT5n/z7eN1LbyxxMzU/+hPiLea4cwSfjvXR22SL5QgezVHuRegiru8zESSLjgiJ84ftabakv7LrSPgIy9aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643888; c=relaxed/simple;
	bh=dmwblY+8rAzVH26m4BK5sAA9J+PbYRdAKI60Jq1v2Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRpJ3Vm+eAM7E6TjwHXPSMTiN1UC4wu5PYh3UzcN5LkdcVrbFYW9u6mFGfBJOhtc7OEHPmos4OFBs6mdeR9IhbCu5Z/6lm60p5ir7Fixkdb3ohNJOHdXof19iD8kMYWUfB2sKKhjZnLIMTPTxYaC/xAIe4KD1C1KBBi7QE8XjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jy553YU8; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jy553YU8"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4866834f8deso1954481b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781643885; x=1782248685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XaPfMOSoE2zyuKIcPFd8pDEn9TxZzzHnmOGsTPWgqY=;
        b=jy553YU85J3IquAZPJVslR3i2FTBVC1hzEJIPgdibC1dcljKHFdAAULewVDCoPzv+h
         b4owxlBcgrM99nE/TMcvpswazT1zMzzaBZ21SXWj1zRncurhouPjWAJ7oCM5OShXx61q
         9JgKlGH/K5BmpDDKOYebNhrVL1J+0uqZbs8NSMX/ROsCacmtIAEk4MBJ+X2nQusydpAw
         BBE3gy1UcQdY9DsfLQeqwBXjeD6PHPsv8MOZvIsJ7otcU48XUlJbwF2GSo7YFgYi1Lzo
         zQMBGJpqqws2uaX1WbyImj6QEwgc/v3i3VGtrlhPm/tWloQ8tuiTrxWqtdDaPtKIqP2d
         mwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781643885; x=1782248685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XaPfMOSoE2zyuKIcPFd8pDEn9TxZzzHnmOGsTPWgqY=;
        b=Ng0pfcxBTFkrSeAAdrmK+Hb/aIRsTB9CNAIXaMt26wNCHr5qqv2UxoaqzVDHtnFTmP
         eaPK2HZTdz+ovC1lVzzp9psIAbCULWk4Gqa9VGm3iMfk3eh9nlrki62Cphorgfw28ueu
         /iG794ie9gz0Rmf4Zr2YRBvlUhDCM2LttBpWcVW4Gd+Qt3hIQxUbYeKmMsVrJfFFi0AW
         8xVv3jJHUxGkoK+2fGafyEoxlbH5qmfPeTpiPQ7TX1byVqMUpcUii2LgGFCH0kFlnMN9
         30aZmKhZgv9LNI8nhqPTCaLDqxOZRBlnY2sDeA8baX9YjENJXFec0G2m/EsNDgMNnpIO
         Qo2g==
X-Forwarded-Encrypted: i=1; AFNElJ8kJpKCQYAPnHTVFNXh0eYOlNfpLQgDb2c9t4MJK34TC9M2a9Vz9Y8lZbHRgOWJAUt3mRn0lSJeDG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybnJqldE4RTnoiBZcL6qgYIcZ2ZrXPM2yGm6sl/ZKglPkWwfCA
	ssVrpNXuAH1h28mSUdJY2LoPjG6LZfonbJBeWTAwf5XhPutExGZ+ZiAIgC1jUD/DYzo=
X-Gm-Gg: Acq92OGU9BWBpLzHog3Mt4N5o1AgUge7j1/JeXc860jZPFWUZBLLedLfOIhwjEOajUa
	1502EWWJRK1pMSAB18JetD7ggDGMfhIBfgNq3PaNdx56Ik8dYMLCbOUn12p44k2q54+QJKNo5T3
	+qQHpev+Dk9AlW+kn8JCwmrXTI4bo3k0k6xZu/FbdKgnKsodw24Y7m6nSFSDbPkGqXtuPZoZrhS
	kg6LwmVa4NdYvDCK2yW0TyiP7gRcxOQF9cbBzuHYMQVFhWrDo0yVJWQ6ycC3GGB5uErjX6OqtYF
	19SPWUREsU1Td+TowRPrCtpzT8Y2qPPewE6rzfkOeKVD2E8+ZCIo2F7wXA1TWx+ozPI+cCqClDp
	/ytm+NOtqwNI++6iZojFo5V9lFvCn9Ids0vmPPJNVOo3OEFy8/9aoawd6P+B79zreuOqUWkofgq
	CQuAVIs4NjZTZXgBFDr7B4GBDfOhsWmQCfpJLW9j9sO51UyrTOhQ3lR0+gUi8cbV8VGBFYaBFNP
	A==
X-Received: by 2002:a05:6808:3022:b0:464:5f3:ed1 with SMTP id 5614622812f47-4894460a8f9mr631257b6e.26.1781643884895;
        Tue, 16 Jun 2026 14:04:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:28a8:6095:71d2:86eb? ([2600:8803:e7e4:500:28a8:6095:71d2:86eb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6df8e1sm7565070a34.20.2026.06.16.14.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 14:04:44 -0700 (PDT)
Message-ID: <c24982d7-40d6-4fd6-a083-90a8d3ce7f63@baylibre.com>
Date: Tue, 16 Jun 2026 16:04:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add ti,ads122c14
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
 <20260616-spoon-ducky-b05e9bf7e999@spud>
 <4bc99611-4bf1-4797-ba31-6f1d7dee1e1e@baylibre.com>
 <20260616-livable-muster-d268af11dcc8@spud>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260616-livable-muster-d268af11dcc8@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 3:50 PM, Conor Dooley wrote:
> On Tue, Jun 16, 2026 at 02:54:55PM -0500, David Lechner wrote:
>> On 6/16/26 11:07 AM, Conor Dooley wrote:
>>> On Mon, Jun 15, 2026 at 04:59:59PM -0500, David Lechner (TI) wrote:
>>>> Add new bindings for ti,ads122c14 and similar devices.
>>>>
>>>> This is an ADC that is primarily intended for use with temperature
>>>> sensors. There are a few unusual properties because of this. In
>>>> particular, the reference voltage source and current output requirements
>>>> can be different for each measurement, so these are included in the
>>>> channel bindings.
>>>>
>>>> The REFP/REFN reference voltage is usually just connected to a resistor
>>>> that is being driven by the ADC's current outputs, so there is special
>>>> property for this case rather than requiring a regulator to be defined
>>>> to represent that.
>>>>
>>>> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
>>>> have preferred an enum of strings).
>>>>
>>>> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
>>>> ---
>>>>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 224 +++++++++++++++++++++
>>>>  MAINTAINERS                                        |   7 +
>>>>  include/dt-bindings/iio/adc/ti,ads112c14.h         |  11 +
>>>>  3 files changed, 242 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
>>>> new file mode 100644
>>>> index 000000000000..dc7f37cad772
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
>>>> @@ -0,0 +1,224 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c14.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Texas Instruments' ADS112C14 and similar ADC chips
>>>> +
>>>> +description: |
>>>> +  Supports the following Texas Instruments' ADC chips:
>>>> +  - ADS112C14 (16-bit)
>>>> +  - ADS122C14 (24-bit)
>>>> +
>>>> +  https://www.ti.com/lit/ds/symlink/ads122c14.pdf
>>>> +
>>>> +  These chips are primarily designed for use with temperature sensors such as
>>>> +  RTDs and thermocouples. The channel bindings reflect this in that each channel
>>>> +  represents the conditions required to make a measurement rather than strictly
>>>> +  just the physical input channels.
>>>> +
>>>> +maintainers:
>>>> +  - David Lechner <dlechner@baylibre.com>
>>>> +
>>>> +unevaluatedProperties: false
>>>
>>> Weird positioning of this.
>>
>> IIRC, Rob asked that I do it in this order on another binding a while
>> ago (the reasoning being that it was too far away from properties:
>> otherwise), so I've done it like this on a few bindings now. It doesn't
>> make much difference to me though.
> 
> Too far away because it refers to properties in the "main" node, but
> appears conventionally after a rake of properties belonging to the
> children?
> 
I found the original request:

https://lore.kernel.org/all/20241022204312.GA1524310-robh@kernel.org/

"Easier to read the indented cases that way."

Reading it again, it sounds like the request was just for the indented
additionalProperties to be moved.
