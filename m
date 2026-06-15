Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5F02AD2C;
	Mon, 15 Jun 2026 04:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781497628; cv=none; b=J8kXlFGEeN0NU5I3NjFpXOJYdr8AxF0SPKgMkVNgwvWdEA75YL5zuD7PU2Dac3E/xqnOZWQsgemvubU8+rRbgTKt4ekBOQrvocxq8VDIlTTkMMx4Wksw1RGUPmTNdsP14XhulgB7wZ9VN2Fmm2PJbiDfg/uC7I9HqGkbXSHGROg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781497628; c=relaxed/simple;
	bh=cSJeumcbp4HbRcl5MBu/rRqVYBXDtiOSnAElKqKZ2cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMEnvvXBM7SLvXazcAWGqr+puaU8ejoUPXmcGT9apXz7YbldjRBb5XgOS2K58tAhH8EpoyAunCldpyeEvdddc7pfqUoo9RZQS6cp26TwnXzqG2YKcY6VPGIqENZQjgLQgN1SZNQotkIdM1v2HhoQNKuqvW/cePG2MIGPChXmKeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9VEeFT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9VEeFT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265951F000E9;
	Mon, 15 Jun 2026 04:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781497627;
	bh=PutqXygEbgIrZ8v6ecbxnI9XjwAfh8YhF6fviR77oRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I9VEeFT5TKwjlmYkmIaaWQzejwExOLAetOZ/bgoVdNHR8dwLRCuzsDR6AwyKBE+PS
	 YHFnDLx4YRjNst+iFtlPE5jyupzBqxwKS97ZPLD2IoLnb/alan5U6wfyvdJfP2vGRP
	 lQmRk4zjmI2NhThoZJBLdYh7OHcjFnERKyZ5Sfy7GdJbC5jvHdLa1KbWdDjmHB83GF
	 GuTYlAA7CEVqfKJh3MPkH5Me5PgoWjvm8j/udLqjc/mBfSj7L2m8z143yb7JsXTViI
	 jwjAEq6+sKi8xJjtaXCDsplStKF/fpa4HJma0dtQWhNJF89jCCDk9LsrAsIWnH5bZG
	 mnhKwC00+egkw==
Message-ID: <84503093-4bff-4c93-aff8-aa07e1a6a1a1@kernel.org>
Date: Mon, 15 Jun 2026 06:27:00 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] iio: flow: add Sensirion SLF3S liquid flow sensor
 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Maxwell Doose <m32285159@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
References: <20260611132700.671322-1-wafgo01@gmail.com>
 <20260611132700.671322-5-wafgo01@gmail.com>
 <e01d100b-9809-4af3-8f21-055f687ca6c6@kernel.org>
 <20260612184729.795e0e84@jic23-huawei>
 <4e4ef1ae-62e7-4639-914c-19f49930be02@kernel.org>
 <20260614161011.7f7946f1@jic23-huawei>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260614161011.7f7946f1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/06/2026 17:10, Jonathan Cameron wrote:
> On Sat, 13 Jun 2026 09:51:13 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 12/06/2026 19:47, Jonathan Cameron wrote:
>>> On Thu, 11 Jun 2026 16:01:12 +0200
>>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>   
>>>> On 11/06/2026 15:27, Wadim Mueller wrote:  
>>>>> +
>>>>> +static const struct of_device_id slf3s_of_match[] = {
>>>>> +	{ .compatible = "sensirion,slf3s-0600f", .data = &slf3s_variants[0] },
>>>>> +	{ .compatible = "sensirion,slf3s-1300f", .data = &slf3s_variants[1] },
>>>>> +	{ .compatible = "sensirion,slf3s-4000b", .data = &slf3s_variants[2] },    
>>>>
>>>> You should have only 1300f here and detect the variants. That was my
>>>> point when I suggested to use the fallback.
>>>>  
>>>
>>> I'm lost. How does that work?  They cannot fallback to that part because
>>> it relies on in driver detection of the fact that they are incompatible.
>>>   
>>
>> I am lost too. Then why were they made compatible in the binding?
>>
>> Entire discussion was that these are FULLY compatible due to variant
>> detection. That was the entire point of discussing more generic
>> fallback. Using specific fallback does not change that - it is the same
>> concept.
>>
>> If devices are not detectable, why were we discussing any compatibility?
> 
> They are detectable, but the feature set is not, so to me there is zero valid
> in a generic fallback, we have to update the driver every time a new part comes
> along. (i.e. I agree with Conor's reply to the previous version thread).
> A specific fallback to a completely compatible part would be fine as there
> would be sufficient info to not need the ID lookup.

This patch has specific fallback and we discuss this now.

> 
> The case in the binding for this version is the worst of all options because
> it implies it is valid to fallback to something that gives a false impression
> of being specific when it's relying on ID matching to say actually it's something
> else.
> 
> So definitely not
> +  compatible:
> +    oneOf:
> +      - const: sensirion,slf3s-1300f
> +      - items:
> +          - enum:
> +              - sensirion,slf3s-0600f
> +              - sensirion,slf3s-4000b
> +          - const: sensirion,slf3s-1300f
> +
> 
> Falling back to slf3s is better than this, but I'd rather not have a fallback
> at all, thus allowing correct fallback to the parts listed here in future.

Why? These devices are fully detectable thus fully compatible.

Best regards,
Krzysztof
