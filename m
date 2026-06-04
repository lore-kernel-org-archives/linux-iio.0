Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32B426EAA;
	Thu,  4 Jun 2026 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572147; cv=none; b=kOwAT7rHXXjVL5ENI05oqym+QTPlukZPAz5dHqzS7G5ebcaSzOKyQXDrkV+R53XLZHly8I6u89uq0JuV6xUKhEnCEAMs0K8B4wrNq9/mRjnlj6NBwf89PDJ/u5uZvLaRtIYcsdbH9yn0h6kIE/Fbz2vF88AM7FXNdMRPepbEltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572147; c=relaxed/simple;
	bh=rCU4Gxie0eVTTkpbXv9dbym1eyR074y2+nE+wP0mWpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmDVKgHp7LhNjXn+UJdAHad0C3J/zE7tneHHatzBPb2Qs09M5nm4xudtpVRZBzIn1ZrV3b1N2SydUbMKhUi9Fo7PGvlPlHevf3EaIvdmuxOijajq5AIt444YgiOtg6O91QjizkaCaMx9URg7oKQL3k7Z/AqxDAANU9zzY+TWZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSo2CUdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSo2CUdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A1E1F00893;
	Thu,  4 Jun 2026 11:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780572146;
	bh=YqaIARxLCsfRvEuwDJUVGQSwsaKgqQhBSuWQAJzCQKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cSo2CUdDtSwzmTl4SbVCV01/t4l/Dudj/mefXIyBNYHuoH+icLvBi9SQb+9o+kZ2S
	 nmvIFxh0hlcjyNbQ2MraUCqzHCYMkE9ubDoLAZTxJ9vccqnSnzZQUq1LHYSGxbAeYG
	 ClKYYxFAaf41z5JyDl4nXBgFkoKQQOqIBYFAldPR6LPfWGJqjh/iFanLJZ1gTPvzw3
	 y3xB5w2XKlKjbLsamDMgG4pR3A9zpwQolINbR3O5Sf/z1mjlrwVL3LqLLduXIkr9Fy
	 IEXRPY7JdAoDxt6C8rbNa3Mj1aRIPjxW+V4+1B6BWXpUxIbEH4ta4sMMRnW+2U6tDE
	 8C59L3MG3QqYg==
Message-ID: <200a6c34-3321-4c2c-9746-52348e700cd9@kernel.org>
Date: Thu, 4 Jun 2026 13:22:17 +0200
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
 <1dbd3ab3-de6c-44dd-8100-e8ee60f558c8@kernel.org>
 <20260604100304.11d0e003@jic23-huawei>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260604100304.11d0e003@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/06/2026 11:03, Jonathan Cameron wrote:
> On Wed, 3 Jun 2026 16:29:10 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 01/06/2026 16:09, Jonathan Cameron wrote:
>>> On Mon, 1 Jun 2026 13:53:23 +0200
>>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>   
>>>> On Sat, May 30, 2026 at 10:54:31PM +0200, Wadim Mueller wrote:  
>>>>> Document the bindings for the Sensirion SLF3S family of digital
>>>>> liquid-flow sensors on I2C.  The family currently covers the
>>>>> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
>>>>>
>>>>> The driver auto-detects the variant from the product-information
>>>>> register at probe time; the per-variant compatible strings exist
>>>>> for documentation and dt_binding_check purposes.    
>>>>
>>>> Here...
>>>>  
>>>>> +description:
>>>>> +  Family of digital liquid-flow sensors from Sensirion with I2C
>>>>> +  interface.  All family members share the same register map; sub-types
>>>>> +  differ only in the flow scale factor and the calibrated measurement
>>>>> +  range, both of which are detected at probe time via the
>>>>> +  product-information register.    
>>>>
>>>> And here...
>>>>  
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - sensirion,slf3s-0600f
>>>>> +      - sensirion,slf3s-1300f
>>>>> +      - sensirion,slf3s-4000b    
>>>>
>>>> And here something else. Confusing. Didn't you say device variants are
>>>> auto-detectable? So you have only one compatible sensirion,slf3s.  
>>>
>>> And then future fallback compatibles can never work. 
>>> Basically as far as I have ever been able to establish this is why
>>> generic compatibles are almost always the wrong way to go.
>>>
>>> If we get a future part with an unknown ID and don't have these existing
>>> specific compatibles, then we have no way to specify which one it is  
>>
>> But why would you have future part with unknown ID?
> 
> That's what manufacturers do on a very frequent basis.  They tweak something
> that has no affect on the interface or channel scaling etc and release a new part
> with a different ID.  Can be something like a part suited to different operating
> conditions, or with a different supply tolerance.

and it will have a different, known that time ID. How could be "unknown"?

> 
>>
>> The device is slf3s with variants. All of known variants have an
>> interface to detect the actual variant. There is no indication that this
>> won't work - why would company remove the ID register?
> 
> They won't remove the ID, but they will put other values in it to
> indicate new revisions of a part - often entirely backwards compatible
> - sometimes with extra features that we don't use until the driver is updated.
> 
> 
>>
>> But even if this happens, then it would be change of device interface,
>> thus you cannot use generic compatible and you will have a new dedicated
>> compatible.
> 
> We've had this discussion a number of times for whether an ID register difference
> alone makes a device non compatible, and the answer from DT review has always been
> a firm no and that it is incorrect to reject an unknown ID if the dt-compatible

True, but this is not the case here. That incompatible device would
simply not use this compatible, thus it will not start the probe.


> is known.  The compromise that people were happy with was an info print if
> such a mismatch is detected as it might indicate an incompatible part replacement
> and a broken DT.
> 
> Probably 80%+ of IIO bindings with fallback compatibles do not have
> matching "who am I" register values.  This is incredibly common.
> 
>>
>> If the device is actually "slf3s-0600f" (because slf3s is a family),
>> then I am fine with using that as the fallback. Specific front
>> compatibles are also fine in such case.
> 
> Yes, it's a part in the family. Each of the compatibles here has a
> separate datasheet:
> 
> https://sensirion.com/media/documents/C4F8D965/66F56F53/LQ_DS_SLF3S-0600F_Datasheet.pdf
> https://sensirion.com/media/documents/6971528D/63625D22/Sensirion_Datasheet_SLF3S-1300F.pdf
> etc
> 
> (wonderfully inconsistent file naming ;)
> 
>>
>>
>>
>>> compatible with.  Given these are providing scaling info that means we
>>> can't realistically support such a future part with a fallback at all.
>>>
>>> That would only be possible if there was feature level discovery. A single
>>> whoami register with no structure to the value is useless for this.  
>>
>> The whoami register defines all the features, no? What would feature
>> discovery improve? ID register is simply logical OR of some feature set,
>> still uniquely identifying the features set/variant.
> 
> Would be lovely if true. Sadly almost never true. They are typically just
> the next number in a list of parts released. There is no direct information
> on feature set encoded in that value, we have to have a look up table in
> the driver to translate to feature set. (Not relevant here but sometimes
> manufacturers forget to change the number and we get different feature
> sets with the same ID and no discoverability)

I did not mean there is direct information. I meant that you can create
such map, so basically it is defining all features.

> 
> If they were an OR of features that would be great.
> 
> The thing is a little structured in this case
> 
> 0x07         Liquid flow sensor
> 0x  03       Product family (e.g. SLF3x)
> 0x    03     Subtype (e.g. SLF3S-0600F)
> 0x      02   Revision number (changes with minor firmware or hardware revisions)
> 
> But both the product family and subtype are numbers to feed into look up tables
> (maybe revision number as well)

The values don't matter. What only matters is that each is unique, you
can map it to a real device (and its datasheet) and features are
decodable from the datasheet.

Best regards,
Krzysztof
