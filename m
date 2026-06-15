Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4CA246782;
	Mon, 15 Jun 2026 04:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498097; cv=none; b=sRbn5jl4r+5m+m55waBJXnUblubaMMdVqBNqIlSvAoyZ6ohmaKlCoe8hQqCKmdcg7gz4PWJ+xk4AyKagUkWSy7LTrx3Q/GzRHVDSvrMGEv2fq2IH6Nnk+7AxQ3ZdCpVtS4qumJ+Hdfm7wDc0s/5SAYOGo8otcaMY9bmetEHJrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498097; c=relaxed/simple;
	bh=5SJTvxfd7f2iLculV5spHy/9XNjuDl8oyP2/AUktYjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7x0pP5eDgICSuzSWkCfx47fRzbLB8eaSHb7oc4QcwonrfcN7T+BzvRLgxCyeYOF/H6PxvDVkadsrO83zAKEbgsenBzsYeN7+LM+Lvc15Onakm/zAS+bB66XFT4zReq9sEoSLDv2RKowLDUM6OGaXMqjXLghVjPCuwliYI1pzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJL2UoCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJL2UoCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337EE1F000E9;
	Mon, 15 Jun 2026 04:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781498096;
	bh=gWEDPbPVwTMCS3dB5DzxYPLhtVx2MMG50KY35u0kwNY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AJL2UoCf3sgrhkCxCgOI4reu1Fwp+hbLiNg2OZf8xtC8ki2FvTbMefCh8/MToR4Zu
	 BQDqREDzO+WmenxNwuXrBbT2yC9GSt9vUFFZZ0uoneZe9iAwjb2WUM03CfQfSLOaLw
	 bWn0TTmK+fMLnUh3xksry6clYXJAGpbH9OAteS9A0jfnv7jSl74DGoHonV7MhTITeq
	 wcYfoqeTsFW0TDj4MVb8mjFONHo1jpxMTjdhD3KVotqKvsoYFkUvzNrJeVTRy0kvJ8
	 JTE8MBIpLTNlOEEMbgal2LliBgOS5AJZTvRXgzpg0mtQZqS5sPQW/2Rj7fGp4jqyzB
	 J1cHjnFh5PINg==
Message-ID: <73d85fad-d39a-4c34-90c2-819998656f7a@kernel.org>
Date: Mon, 15 Jun 2026 06:34:48 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: Add TI ADS126x ADC family
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
 <20260612-ads126x-v1-1-894c788d03ed@gmail.com>
 <20260613-loyal-azure-goldfish-cf6d54@quoll>
 <DJ92JT0CPSXJ.1113K3KLSRHH4@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <DJ92JT0CPSXJ.1113K3KLSRHH4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/06/2026 22:53, Kurt Borja wrote:
> Hi Krzysztof,
> 
> On Sat Jun 13, 2026 at 1:54 PM -05, Krzysztof Kozlowski wrote:
>> On Fri, Jun 12, 2026 at 05:46:19PM -0500, Kurt Borja wrote:
>>> +  ti,neg-refmux:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>>> +      Selects the negative voltage reference input:
>>> +      0: Internal 2.5 V reference
>>> +      1: AIN1 pin
>>> +      2: AIN3 pin
>>> +      3: AIN5 pin
>>> +      4: AVSS pin
>>> +    minimum: 0
>>> +    maximum: 4
>>> +    default: 0
>>> +
>>> +  ti,vbias:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description: Enables the level-shift voltage on the AINCOM pin.
>>> +    default: false
>>
>> There is no such syntax, drop.
> 
> The "default: false" syntax? Sure I'll drop.
> 
>>
>>> +
>>> +  ti,idac1-pin:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>>> +      Selects the analog input pin to connect IDAC1:
>>> +      0: AIN0
>>> +      1: AIN1
>>> +      2: AIN2
>>> +      3: AIN3
>>> +      4: AIN4
>>> +      5: AIN5
>>> +      6: AIN6
>>> +      7: AIN7
>>> +      8: AIN8
>>> +      9: AIN9
>>> +      10: AINCOM
>>> +      11: No Connection
>>> +    minimum: 0
>>> +    maximum: 11
>>> +    default: 11
>>> +
>>> +  ti,idac1-microamp:
>>> +    description: Selects the current values of IDAC1.
>>> +    enum: [0, 50, 100, 250, 500, 750, 1000, 1500, 2000, 2500, 3000]
>>> +    default: 0
>>> +
>>> +  ti,idac2-pin:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>>> +      Selects the analog input pin to connect IDAC2:
>>> +      0: AIN0
>>> +      1: AIN1
>>> +      2: AIN2
>>> +      3: AIN3
>>> +      4: AIN4
>>> +      5: AIN5
>>> +      6: AIN6
>>> +      7: AIN7
>>> +      8: AIN8
>>> +      9: AIN9
>>> +      10: AINCOM
>>> +      11: No Connection
>>> +    minimum: 0
>>> +    maximum: 11
>>> +    default: 11
>>> +
>>> +  ti,idac2-microamp:
>>> +    description: Selects the current values of IDAC2.
>>> +    enum: [0, 50, 100, 250, 500, 750, 1000, 1500, 2000, 2500, 3000]
>>> +    default: 0
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  '#io-channel-cells':
>>> +    const: 1
>>> +
>>> +  '#gpio-cells':
>>> +    const: 2
>>> +
>>> +  gpio-controller: true
>>> +
>>> +  adc:
>>> +    $ref: /schemas/iio/adc/ti,ads1263-adc2.yaml#
>>
>> Not a separate device node. Fold into the parent... or explain in
>> commit msg. You have entire commit msg to explain odd things.
>>
>> In that binding description you call it "independent", so it should have
>> its own SPI chip select? Why "independent" and part of this binding?
>> Maybe not independent, so basically part of this device?
> 
> It's independent in the sense that it is a proper subdevice on the same

You cannot use DT syntax as argument why you use DT syntax like that.


> chip. It shares the serial interface but operates completely in
> parallel.

How completely in parallel? If the interface is the same, then it does
not operate in parallel. It's impossible.

> 
> I decided to add a subnode because other devices might request their
> io-channels and most importantly a different voltage reference might be
> connected to it.
> 
> I'll clarify this in the commmit message on the next version. Although
> after seeing this submitted bindings [1], I wonder if it's a better
> approach to do something like
> 
> 	spi@0 {
> 		mydevice@0 {
> 			...
> 			adc@0 { ... };
> 			adc@1 { ... };
> 		};
> 	};
> 
> Any thoughts?

Does not look like separate subnode. You still did not provide arguments
why this is independent.

Best regards,
Krzysztof
