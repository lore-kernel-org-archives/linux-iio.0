Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D13081D6
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930237; cv=none; b=pLOIqqro8dqa4U/INhvZ1GHeFR5fpgRSQPYHmNBqO+osU/oO+h9NtH44Yc6IeYHz54oKaWJ/APJRFOpA/VCTKCbS3miO/vjINu68ffDMrpaRpmQcsZK7GM+n74BumwCiZ5WDx4xjsM1Ds9Mgbo272nFJgwaOlSQtvvOmqAyjwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930237; c=relaxed/simple;
	bh=FFqdeaDL7lqKGZ3fe3twoZ7NOyENN7PD9m4VnMm6UzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb6caMSbSB7zSvSofNWPyaxoeowtu9F5pfCgbWHtcrdbkswHJ9Vj251TorLhVztedGiNvnrwQrYfibuXWwg7qCL2U/7TohcANGtzln0bsCNWZLQRsX3AIm5Q1P4qQ/PgXvAUZ6pyVuBgt9q56FQYdWL/+bFJ1C+BeA8r7XHe1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ewZhMDQb; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ewZhMDQb"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-467e044082dso86295b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773930234; x=1774535034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KeNjfj/LpvbccEUPQ7WMLYgOxZOBhYnhu+wpfuHYq6E=;
        b=ewZhMDQbKQ9/HgQM+61OR/p6stMSNEhJ7kjaXXLfizRhLhlfmw1bvFIPuSGcIVqaJ1
         twdessCVjqw0O9dqVJe2izcSQ3dg2Ve2yMNFeSOgrAvU0Cr18nsHcGOvdn16RdcXyUgV
         r0Evx2svRJknqBQt4lk3ZF869OAx5TGwfAIjblpH1+9U2o/vTKyusCbJ6eLPT1YkUX0W
         +HdxfqmwFvJFya4snRzlakcOPom8EjB/A52y5bvCwf6Oh28QLm6cq5vy81ZYPwKcziKs
         4wTgvq61jbCF1eqmWGmTexX2ysQiFhuj+7XPlYh2uB1h4BatTLxzLFNRDEpdihPR6rKv
         QQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930234; x=1774535034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeNjfj/LpvbccEUPQ7WMLYgOxZOBhYnhu+wpfuHYq6E=;
        b=WQ0zt0LG+IulufeH3YPDxWJ4lsRequPAeEB6Hsm9T4LA+HzmqpOa037cn+tZSePj1f
         g2w7aCQBparTpJUpdeY3aXexvVez/o6u+F9ehEBVQDeVPYYTWzU7ME4ieZn8oHWvcyOb
         dqXRF8ZSmp47MXVmOQVS3ajpUU7jXL8S3TT6UAO7mCBMUmkykaO+oue4QjcJU23tasbp
         JS+DDpstAq3UVDenyAKdG29Wr6bBJo/7ZDIIrEPBn6cPUI6P0HeS8DRJxpLXcy2icnWz
         MpX2v+ozquuW21lUb/dh6tnn73Z/5a3xufAUKi5hgjHlI8WS9om6JY5ltIlG2LV3Eywz
         2QCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzyha3kuNkJW5eHXq8+nUulJSARhNI9aVKrNdC14dqbzs7Bd+yvORWpL7hW2NzKlDrCGyLwuAH9Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpyVQREI6YuBRFtcQipRRvqIc3YeCuOhzQvEPxaB2pIjwNALJQ
	HlQuRe7ZE4eKL/Cu6M56KJmWqcwKzK+PXUZFRhC772wdDy/clrV9H/yt5dZoqFI7ysI=
X-Gm-Gg: ATEYQzw1L8Ep8Q/SQraf8FEGccmwitI6wc+WXgSSiZ9K03Id1fvZGl4OdGHc9ofouYV
	PxqXnpzhQFutYCL6Qf8kzo4sRMhjIpqfyqKe4TRjyEAJxy6MFcs27/V2AypKEg8nJYJGfiPySj+
	6enZm1Zt/D8jjqXE5Gj10dhs4DJc6KQOsiBLDQG3FfbbiIOEWT9K/8zkbFEbz1HEuJbIupvRtsC
	nF9tRTzBpYfWDfI+Pty0ow0gmcDxLv1u6TeI5qzPA/y/09e/RibwvCSHR9hQpmBYOQ3JAUE0gyL
	3hX+rmjrUw1fzYljWdujxlX5SeIoSn1m0raW4n2Gqm+c4htfS6YH2sBRNaMtizWKbx71GYyAY2m
	8VZIjVCUpni3y+EyRVnSuIh0SxOtipooUyZcUXyG2K+HiCXQ+xaM4wWCgokJeREWxY4N+C9tKiP
	8G5F6NmN2PBaBycUum3TNpVZJrhzVr+IujN4g2ylVMmvSIMSEj+msrXdHTBfu15D+TNxVZ7kZpT
	A==
X-Received: by 2002:a05:6808:19a8:b0:467:819:dc61 with SMTP id 5614622812f47-467ba28b325mr4636001b6e.23.1773930234228;
        Thu, 19 Mar 2026 07:23:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:244c:fc8c:8216:1344? ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7e878b627sm82482a34.15.2026.03.19.07.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 07:23:53 -0700 (PDT)
Message-ID: <21d425bc-9406-401b-9817-7255ba3d31fc@baylibre.com>
Date: Thu, 19 Mar 2026 09:23:52 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dt-bindings: iio: adc: xilinx-xadc: convert to YAML
 format
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-6-sai.krishna.potthuri@amd.com>
 <20260221-dancing-papaya-wolverine-db8afd@quoll>
 <b89933a3-5f25-466c-a2f5-6e231aa12749@amd.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b89933a3-5f25-466c-a2f5-6e231aa12749@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/19/26 8:52 AM, Sai Krishna Potthuri wrote:
> Hi Krzysztof,
> 
> On 2/21/2026 4:08 PM, Krzysztof Kozlowski wrote:
>> On Fri, Feb 20, 2026 at 11:09:41AM +0530, Sai Krishna Potthuri wrote:
>>> Convert the xilinx-xadc.txt Devicetree binding to a YAML schema format
>>> and remove the old text binding.
>>>
>>> +
>>> +  xlnx,channels:
>>> +    $ref: '#/$defs/channels'
>>> +
>>> +allOf:
>>
>> Missing ref since you use unevaluatedProperties...
>>
>>> +  - if:
>>> +      required:
>>> +        - xlnx,external-mux
>>> +      properties:
>>> +        xlnx,external-mux:
>>> +          enum:
>>> +            - single
>>> +            - dual
>>> +    then:
>>> +      required:
>>> +        - xlnx,external-mux-channel
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +unevaluatedProperties: false
>>
>> or you meant additionalProperties?
>>
>>> +
>>> +$defs:
>>
>> Why this is a def, not used directly? I see only one usage of this def.
> 
> I am getting the below error if i define the patternProperties directly.
> Seems like complex vendor peroperties should be referenced via $ref.
> Please suggest if there is any better way to deal this.

It is hard to say without seeing the new version of what you wrote.



> 
> linux-xlnx/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml: properties:xlnx,channels:type: 'boolean' was expected
>     hint: A vendor boolean property can use "type: boolean"
>     from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>   LINT    ../Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dts
>   DTC [C] Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dtb
> 
> 
> Regards
> Sai Krishna
> 
>>
>>> +  channels:
>>> +    type: object
>>> +    description: List of external channels that are connected to the ADC
>>> +    properties:
>>> +      '#address-cells':
>>> +        const: 1
>>> +      '#size-cells':
>>> +        const: 0
>>> +
>>> +    patternProperties:
>>> +      "^channel@([0-9]|1[0-6])$":
>>> +        type: object
>>> +        properties:
>>> +          reg:
>>> +            minimum: 0
>>> +            maximum: 16
>>> +            description: |
>>> +              Pair of pins the channel is connected to:
>>> +                0: VP/VN
>>> +                1-16: VAUXP[0-15]/VAUXN[0-15]
>>> +              Note each channel number should only be used at most once.
>>> +
>>> +          xlnx,bipolar:
>>> +            type: boolean
>>> +            description: If set, the channel is used in bipolar mode
>>> +
>>> +        required:
>>> +          - reg
>>> +
>>> +        unevaluatedProperties: false
>>
