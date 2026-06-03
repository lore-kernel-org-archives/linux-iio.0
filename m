Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C629357702;
	Wed,  3 Jun 2026 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496959; cv=none; b=GFCv6UR/4TVZfZ4PUSbLPFOYh7n00nN6WmkBHMNKDC9WTnE/5S9Y8RJ/8+Ogx+cMhH1z04BQT7721BwEvwKuleSbfkAxv4YPx3lk3QBjI/lPhc20Au1gNzYl+QlD+gfzR76Pi4tW4ZYuWwLyx/PtF5zSklXWoSrZbgje78It1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496959; c=relaxed/simple;
	bh=3IS+k94DYJHFIIrTbceVZbBLpOqeMUXVak3aBgdSaWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHeHXQUR4iEdhJ51Df4r7Z1E2TD2QNxDrfnf2KEiYV0C1aPtqlC5v9/x1szmrd+V5THTgx8uUooaaRRwir+cNogChPUHoBg/9dXL4VOq0Y/+uo8PkrQZ3tBRhefEZzI/ORUXox62A3WmP1aCApexffoY/xtrU4MJ8j6VP+Yf6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecfA8esV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecfA8esV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3541F00893;
	Wed,  3 Jun 2026 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780496958;
	bh=BjbyjYUmBJJMB/wiP7XQE+BbJe1wmFBZwsfOIexhZvs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ecfA8esVi0kf7JcfNC7Rxp3m56cuBuKqtVVUcFMdTpfYJtg3sqs9uFh7INXbNxzhU
	 UsWFfWIdx+7hP34i16MJHx5vWzYUEUFfXMG3NvZdLNUujYl+ctyfsvD9xFGCUoB56J
	 KhWPrgaql9ugUnpNE7uFRHSVt0UCg7Zry/lYEdbBRk6UiWN+MWh40Ddh4YARCXvYaV
	 j8mm2SyE5p4EWMdG3bt9SCFsf1dQJ14dlt55zUTMjBWL4P3ogOfZ3Ig21xtI/XyxJ1
	 kYGDE/RQnzzJvQfRn2FMkCGOL1Nxmi5TZWFfYU2OR/Cw4SQbIBTmaRCRwBQFMdgU7m
	 1Hfh9ZFWJmUYA==
Message-ID: <1dbd3ab3-de6c-44dd-8100-e8ee60f558c8@kernel.org>
Date: Wed, 3 Jun 2026 16:29:10 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S liquid
 flow sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Maxwell Doose <m32285159@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260530205435.37326-1-wafgo01@gmail.com>
 <20260530205435.37326-3-wafgo01@gmail.com>
 <20260601-banana-narwhal-of-music-0b4d3a@quoll>
 <20260601150959.49bbf125@jic23-huawei>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260601150959.49bbf125@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/06/2026 16:09, Jonathan Cameron wrote:
> On Mon, 1 Jun 2026 13:53:23 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On Sat, May 30, 2026 at 10:54:31PM +0200, Wadim Mueller wrote:
>>> Document the bindings for the Sensirion SLF3S family of digital
>>> liquid-flow sensors on I2C.  The family currently covers the
>>> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
>>>
>>> The driver auto-detects the variant from the product-information
>>> register at probe time; the per-variant compatible strings exist
>>> for documentation and dt_binding_check purposes.  
>>
>> Here...
>>
>>> +description:
>>> +  Family of digital liquid-flow sensors from Sensirion with I2C
>>> +  interface.  All family members share the same register map; sub-types
>>> +  differ only in the flow scale factor and the calibrated measurement
>>> +  range, both of which are detected at probe time via the
>>> +  product-information register.  
>>
>> And here...
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - sensirion,slf3s-0600f
>>> +      - sensirion,slf3s-1300f
>>> +      - sensirion,slf3s-4000b  
>>
>> And here something else. Confusing. Didn't you say device variants are
>> auto-detectable? So you have only one compatible sensirion,slf3s.
> 
> And then future fallback compatibles can never work. 
> Basically as far as I have ever been able to establish this is why
> generic compatibles are almost always the wrong way to go.
> 
> If we get a future part with an unknown ID and don't have these existing
> specific compatibles, then we have no way to specify which one it is

But why would you have future part with unknown ID?

The device is slf3s with variants. All of known variants have an
interface to detect the actual variant. There is no indication that this
won't work - why would company remove the ID register?

But even if this happens, then it would be change of device interface,
thus you cannot use generic compatible and you will have a new dedicated
compatible.

If the device is actually "slf3s-0600f" (because slf3s is a family),
then I am fine with using that as the fallback. Specific front
compatibles are also fine in such case.



> compatible with.  Given these are providing scaling info that means we
> can't realistically support such a future part with a fallback at all.
> 
> That would only be possible if there was feature level discovery. A single
> whoami register with no structure to the value is useless for this.

The whoami register defines all the features, no? What would feature
discovery improve? ID register is simply logical OR of some feature set,
still uniquely identifying the features set/variant.


Best regards,
Krzysztof
