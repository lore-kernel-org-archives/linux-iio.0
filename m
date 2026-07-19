Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71834404E;
	Sun, 19 Jul 2026 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784441917; cv=none; b=bX63Mm5hbItFmT9YcgpjfIH2Q9VAl/s7z1l8QbL1c7thT9nuQRejozvpFiFVIJ+itn1CE+ezHc8MqKRasMgMEGzEHvbySAF3yFHQgxK0rTE+7y1AsxeKLcDK4TQUTk5RLHn9mY21J8///p4XKyTKaLVpvZ8oIxShFhnIfv1UQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784441917; c=relaxed/simple;
	bh=6FP32E/h9rYFX+aShjExrfq8NOOL2pF+9RQkkeOinkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9qRIuD/isOLTtEXmJCrkKTCUtzymqWKXS0wj7dAH9fAPHf+pNfQyzJlspNX8A9H4+Fg/1RUgF5IshkV9+rycOopQOyIGW6p753SpF8pS3rOaR/OlQrqNfRODMk7R+td9Bh4eXzSBz8Nz5jLM74hjt437uI3LkrX+UXOQl9Kq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns8SsO8P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns8SsO8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19851F000E9;
	Sun, 19 Jul 2026 06:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784441915;
	bh=qO6qz5sKxfQbkIsp5rJlmemWKhkjXjhnbP1vuh/AZXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ns8SsO8PLrXOwgeU3T0GRlrjbH2FTGCkzaRiiGnz2P0EtsljhnFjh0n3rM+jyzScm
	 RksjgnM0DctrKKFYwm75puOQROmAXUmg1jQtoixg++lxiSbNXN5DWyvVOUMeLUPSq4
	 CvzdC+c2FBMIHRnjRnUnmruQLmYJk2YBWlZQA8BUmLD7M/Ng0VlsTzRHxJF9Sif0gN
	 EQHH4TKLIxFd4yzlxmjfhx08VRANtykrZV6I87OvcVQAHOqhp1IwPqW4O0Qck1bWvc
	 0LrTuNpyRy2po0BcWC3s67bjlHMpUSxiLhRlBPd0AokosclprPxHfweoAc3Y1B42kE
	 iL0rsvrjqKXOQ==
Message-ID: <31eb950b-3848-4f0e-80ae-804d89ca4c5d@kernel.org>
Date: Sun, 19 Jul 2026 08:18:28 +0200
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
 <84503093-4bff-4c93-aff8-aa07e1a6a1a1@kernel.org>
 <20260621145117.70b2d50e@jic23-huawei>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260621145117.70b2d50e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/06/2026 15:51, Jonathan Cameron wrote:
> On Mon, 15 Jun 2026 06:27:00 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 14/06/2026 17:10, Jonathan Cameron wrote:
>>> On Sat, 13 Jun 2026 09:51:13 +0200
>>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>   
>>>> On 12/06/2026 19:47, Jonathan Cameron wrote:  
>>>>> On Thu, 11 Jun 2026 16:01:12 +0200
>>>>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>     
>>>>>> On 11/06/2026 15:27, Wadim Mueller wrote:    
>>>>>>> +
>>>>>>> +static const struct of_device_id slf3s_of_match[] = {
>>>>>>> +	{ .compatible = "sensirion,slf3s-0600f", .data = &slf3s_variants[0] },
>>>>>>> +	{ .compatible = "sensirion,slf3s-1300f", .data = &slf3s_variants[1] },
>>>>>>> +	{ .compatible = "sensirion,slf3s-4000b", .data = &slf3s_variants[2] },      
>>>>>>
>>>>>> You should have only 1300f here and detect the variants. That was my
>>>>>> point when I suggested to use the fallback.
>>>>>>    
>>>>>
>>>>> I'm lost. How does that work?  They cannot fallback to that part because
>>>>> it relies on in driver detection of the fact that they are incompatible.
>>>>>     
>>>>
>>>> I am lost too. Then why were they made compatible in the binding?
>>>>
>>>> Entire discussion was that these are FULLY compatible due to variant
>>>> detection. That was the entire point of discussing more generic
>>>> fallback. Using specific fallback does not change that - it is the same
>>>> concept.
>>>>
>>>> If devices are not detectable, why were we discussing any compatibility?  
>>>
>>> They are detectable, but the feature set is not, so to me there is zero valid
>>> in a generic fallback, we have to update the driver every time a new part comes
>>> along. (i.e. I agree with Conor's reply to the previous version thread).
>>> A specific fallback to a completely compatible part would be fine as there
>>> would be sufficient info to not need the ID lookup.  
>>
>> This patch has specific fallback and we discuss this now.
>>
>>>
>>> The case in the binding for this version is the worst of all options because
>>> it implies it is valid to fallback to something that gives a false impression
>>> of being specific when it's relying on ID matching to say actually it's something
>>> else.
>>>
>>> So definitely not
>>> +  compatible:
>>> +    oneOf:
>>> +      - const: sensirion,slf3s-1300f
>>> +      - items:
>>> +          - enum:
>>> +              - sensirion,slf3s-0600f
>>> +              - sensirion,slf3s-4000b
>>> +          - const: sensirion,slf3s-1300f
>>> +
>>>
>>> Falling back to slf3s is better than this, but I'd rather not have a fallback
>>> at all, thus allowing correct fallback to the parts listed here in future.  
>>
>> Why? These devices are fully detectable thus fully compatible.
> 
> Ok. We aren't really making progress.  Let me layout the three approaches.
> + advantages and disadvantages as I understand it.
> 
> What we have here:
>   compatible:
>     oneOf:
>       - const: sensirion,slf3s-1300f
>       - items:
>           - enum:
>              - sensirion,slf3s-0600f
>              - sensirion,slf3s-4000b
>           - const: sensirion,slf3s-1300f
> 
> Advantages: Fallback to a real part.
> Disadvantages:
> - Requires a driver change even for drop in replacements (which will have
>   different WHOAMI IDs.
> - To me it implies that a driver that supports slf3s-1300f should just
>   work with parts we haven't seen yet if they have that in their fallback
>   lists. I appreciate you think that we shouldn't put effort into supporting
>   that case, but to me it seems more or less free to support and is useful.
> 
> Generic compatible for fallback.
>   compatible:
>     - items:
>         - enum:
>            - sensirion,slf3s-0600f
>            - sensirion,slf3s-1300f
>            - sensirion,slf3s-4000b
>         - const: sensirion,slf3s
> 
> Advantages: Fallback to something that doesn't imply the post fix is coming from
>             DT. So kind of hints we need detection code.
> Disadvantages: requires driver changes for each fully compatible drop in part.
> Note I'm not sure what this brings us over just having one compatible... Maybe
> we'll some day get a non detectable difference where we need to use the binding
> but seems fairly unlikely (I've seen that happen once when a manufacturer failed
> to update a WHOAMI reg value for a new part).
> 
> No fallbacks
>   compatible:
>     enum:
>       - sensirion,slf3s-0600f
>       - sensirion,slf3s-1300f
>       - sensirion,slf3s-4000b
> 
> Advantages: (Common!) a future drop in compatible part works with old kernels
>             as the driver knows a match + part information to use if the ID
>             match fails.
> Disadvantages:  Not sure I see any... However I'm guessing I'm missing something.

The same disadvantages as in other cases:

"Requires a driver change even for drop in replacements (which will have
different WHOAMI IDs."

But I think I get your main point - since we need to compare WHOAMI
registers for fallback cases, then there is no benefit of using the
fallback in the first place, so let's go with original approach.

> 
> Note for this topic I think it would be great to capture some best practice
> information somewhere so we can improve consistency.  I've looked around and
> there are some bits of feedback in numerous threads but those are hard to track
> down.
> 
> The Dt spec refers to these as being about programming mode + driver selection.
> I will note that we have very broad families of devices that have a somewhat
> standard register interface + do always put the WHOAMI in the same place.
> In the vendor  drivers those match a single hydra of a driver; upstream we
> have multiple drivers as devices do very different things and hence in
> practice almost no code would have been shared - so I have no idea what
> we should have done for those more commplex cases.  Following your logic
> (I may have it wrong!) I think we would have had a generic compatible
> for the whole family but in upstream Linux no driver would have bound
> to that. I guess there are  different extremes:
> 
> 1) This case - register interfaces is consistent for all registers,
>    we are just matching on constant tables needed to interpret the
>    data in those tables.

Interpreting data in registers is the programming interface, therefore
the programming interface of that part is different. However since there
is reliable autodetection of a model, the programming interface is
considered compatible.

> 2) Similarish.  Main register interface shared, but optional additional
>    parts.  If one device is a strict superset, a fallback is
>    appropriate (in my view) but if I follow your points here then they
>    should all have a single fallback compatible.
> 3) Not particularly similar, but still detectable in a consistent
>    way.  To me not appropriate to have a common fallback as based on
>    the dt-spec thing about matching drivers, they will typically
>    match different drivers.  Maybe we should have a common fallback
>    but typically not bind to it?

Unused common fallback rather suggests they are not compatible. The
purpose of the fallback is for SW to use. If it is not used, let's just
skip the fallback.

> 4) Detection code becomes a mess and is different for each part
>    (see the old i2c_detect stuff)   So hopefully no one thinks we
>    should use a fallback once we reach
>    this level of complexity (unless part are genuinely compatible)

Yes.


Best regards,
Krzysztof
