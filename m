Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ACC32ED5C
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146555; cv=none; b=kkTBw0pf2CqLj38BQrq/zRIqNzbisM7WAiqKf82gZTnjKixiMPrhA9o1mzQBkCgeyNRoVEthSf4GlGbKsX5cEYID9mz5HC4BtjCpMl2Q5bE8paJGG9ns9NjxIM1FHAO3JRScqZI7DErkNRnZM2mbdhVdAaJjswO4/LdpA+V5fNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146555; c=relaxed/simple;
	bh=J6WjMdiSmsSd4l6O9aOiDfddho9ZkXNG7JRLQmJEDtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwBZHSS1HZgePcqFTS+wHx1+R3hoYr+YpRiwBmduiyg/CpbDVsDcS8PegPSrtgGL/M3Jg1CQtyuZZlgWuH/jHJVr0LL0YssEwYnrcpAQ2K6stMakYOm2a/r41/27ju+gRfhNKFfrnDqr8MF5mjAO9sIYPxLGLMvU1BwDqRhPaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=XkfXOoDo; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="XkfXOoDo"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e93d1dd156so1101646a34.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782146552; x=1782751352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxdyTp9jzcdAMNgLpztr1n4tuC5ymiq5XeXtaFtDt5o=;
        b=XkfXOoDoIeHeOYHz5SunNd3ooJzqJMDsD296/xrp4hTwsH2opgLKzXGzdLl1AOlJTC
         6o/pq5jpRmblqhyeVj/Q3yG+xWB55IBklzNh/1fjf9SRODUFE4pjLECBNeM6VMFM36FT
         E963Wu1n5tkO7JL4ReUF87s8Z2mm4OfhqGdW8xQD/w2x1Ok0QgknZu2FzITuZhDJ3PEP
         LHSs4PveSeZkJFgh+nnlUTBFCkoSdTYHxDZuhdSCa3+YpIOodQ+E05VHhi3Ze7kNkUBk
         U17yNPTfRLDsjJJLU8Xr7FNnfSDWG88Q4NHl4y/+Lzvx67jD1013fDT1aWe/U3jARBDv
         +7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782146552; x=1782751352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxdyTp9jzcdAMNgLpztr1n4tuC5ymiq5XeXtaFtDt5o=;
        b=Cg9vfQj1Sxa8XfkFVhLSy4rGtwfpvwtAH79ag7ACT2B4smcIcNIF2JD4rn4rfAH1rK
         kR2NIipY8IfrjZ64ILqQrdsX0SuudKUuCmX2cp/A/FHDv5WVDwZEjCb8jySXWFvcIvap
         NyR/4dZRn1uiJVxM29u5+WNrGURwf5PspkKj0M76HfZ38QKRCFw6+RP2rfBUsI/1sncT
         N/KD1a/FmBnLvDbGA3Ka0/MTJY+sAaSMs+rK0/4Nm0J8srYZc6BB+m7HdGFGWAdyTBQc
         epSmVxKxw+lN4vrxHi3HlPc1yDaNJohZwlTA+/C4qYtCevqbRxun8jZQxfKpS5eVPi07
         vvsA==
X-Forwarded-Encrypted: i=1; AFNElJ/SpF9A7fKbHMHWYuI4+wAA2BfCZ5OT386Bvd3qACNXFE7vYzcK7mw4yqD2x/Fl45qgR7omV1kh5tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymhJBJgHywPh5zspRHefVtm7+wMPpgZRXKbs+nLs6vimM2KZLa
	h7xF2jGwPbs3lOqkrVYcENjWlVumqicK+HicP72rtSLwvHMSd0LdkGaalaYB0E0Fe3k=
X-Gm-Gg: AfdE7cn2r3gKKZ2H2/MAHrGzF2tjkAUfStDmwD7aRzUjIKmHMp01Ax2ViJQtsZqeOSD
	Fl2blADDJ4F5vMCGDXpE/BSKtstQCHGLA/5OcExTSP+NSK4PxB0gw0YAdTjThjD/RxJd8Ui1Uc7
	XET1fVP8f1InKmebQnW2LlQcbuLLBvaWTk890Rjsijb5CSS5wiRxRwiQ9O90TsNavggwhVi38Pe
	vz+1kmuWmAqg9G6T1Ad+pLMkB1L9h7mmkxPC35xrTQYnVaPHJd0oiZjlu9vxdbsVQOIp2olcQcR
	40buHequMaDutxbQGy3Vx3MNIQoOD2HrMyMMn/3XuEPKXdpak0NOdzaeQCpnuOsgsIpdtUrdoPm
	Yo87Ex3UxklZGCmozWPqPDNM2mz7vPnEPRu8bKE3YKEepoegt2JjWn9nuu2bFyGkRBkYZ352Yu3
	O4heLFp6o108WcMNJw0OUP1bFhZARkIgIT9Bs5KBKXZ4USjHTpr3zak2i9azrvY/8=
X-Received: by 2002:a05:6830:718d:b0:7d7:ea9f:c0f9 with SMTP id 46e09a7af769-7e92d37a1efmr11978490a34.0.1782146552063;
        Mon, 22 Jun 2026 09:42:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b69c:5a77:b8fb:a5cf? ([2600:8803:e7e4:500:b69c:5a77:b8fb:a5cf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9442e98c4sm6502970a34.26.2026.06.22.09.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 09:42:31 -0700 (PDT)
Message-ID: <4980824f-070d-4da9-a291-5563aec6dd09@baylibre.com>
Date: Mon, 22 Jun 2026 11:42:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] iio: adc: Add ti-ads1262 driver
To: Jonathan Cameron <jic23@kernel.org>, Kurt Borja <kuurtb@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
 <20260612-ads126x-v1-2-894c788d03ed@gmail.com>
 <20260613-sparkling-naughty-tuna-3e9bf1@quoll>
 <DJ92M0ZMSI2C.2I39LHFRNQS7W@gmail.com>
 <a994993e-7459-48a2-a8d7-823c1b0c9545@kernel.org>
 <20260621153318.4a723e3b@jic23-huawei> <DJF5ATR2RPDJ.3LSN8DY58E6RO@gmail.com>
 <20260622104728.039a5ea2@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260622104728.039a5ea2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 4:47 AM, Jonathan Cameron wrote:
> On Sun, 21 Jun 2026 19:18:33 -0500
> "Kurt Borja" <kuurtb@gmail.com> wrote:
> 
>> On Sun Jun 21, 2026 at 9:33 AM -05, Jonathan Cameron wrote:
>>> On Mon, 15 Jun 2026 06:30:28 +0200
>>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>  
>>>> On 14/06/2026 22:56, Kurt Borja wrote:  
>>>>> On Sat Jun 13, 2026 at 1:59 PM -05, Krzysztof Kozlowski wrote:
>>>>>
>>>>> [...]
>>>>>     
>>>>>> Functions used by probe() should be before probe(), not somewhere in the
>>>>>> middle of the code. IOW, entire probe is together.    
>>>>>
>>>>> I they all are, it's just that regmap stuff takes a huge chunk. I'll
>>>>> check how to reorganize.
>>>>>
>>>>> [...]
>>>>>     
>>>>>>> +static const struct of_device_id ads1262_of_match[] = {
>>>>>>> +	{ .compatible = "ti,ads1262" },
>>>>>>> +	{ .compatible = "ti,ads1263" },    
>>>>>>
>>>>>> So devices are fully compatible? Then it should be expressed in the
>>>>>> binding and drop one entry here.    
>>>>>
>>>>> Not fully compatible as Jonathan said. One is a subset of the other.    
>>>>
>>>> This is THE meaning of compatible!  
>>>
>>> This one I'm in agreement with. It is a strict subset, so should be
>>> using a fallback.  If the fallback is used, you just get support of the
>>> stuff in the simpler chip (or if you can override it with a chip ID
>>> you might still 'upgrade' to the more complex driver support).
>>> If you do end up with properties that only apply to 'new' parts of
>>> the more complex chip then they should be verified as part of the
>>> binding (assuming you can do that without the verifier complaining
>>> - I haven't checked!)  
>>
>> In v1 I had the "adc" subnode which was specific to ADS1263. Then I
>> agreed to drop the subnode but I'm having second thoughts...
>>
>> If we dropped it, then we would still have some specific stuff.
>> #io-channel-cells would be "const: 2" in ADS1263 chips. Also ADS1263's
>> channels would have an extra ti,vref-adc2 prop, for ADC2 voltage
>> reference selection. I should maybe also add a vref-adc2-supply.
>>
>> Maybe it's better to keep the subnode or, again, go for something like:
>>
>>     spi {
>>         multi-adc@0 {
>>             adc@0 {
>>                 ...
>>                 vref-suppy = <&adc1-vref>;
>>
>>                 channel@0 {
>>                     ...
>>                     reference-source = <ADS1262_VREF_AIN0_AIN1>;
>>                 };
>>             };
>>             adc@1 {
>>                 ...
>>                 vref-suppy = <&adc2-vref>;
>>
>>                 channel@0 {
>>                     ...
>>                     reference-source = <ADS1262_VREF_AIN2_AIN3>;
>>                 };
>>             };
>>         };
>>     };
>>
>> In this case we would have to kinda duplicate channel description, but I
>> don't think it's that bad.
>>
>> Jonathan, Krzysztof, David, thoughts?
>>
>> IMO the ADC2 specific voltage reference stuff is a strong argument for a
>> subnode or the above solution.
> 
> Given you end up with channel specific stuff that differs I think it probably
> makes sense - though I do wonder a bit if that is real.  What's the use case
> for using a different reference for the monitoring / debug than the main one?
> I could imagine some dynamic use where you want to sanity check against
> a wider reference range, but maybe that needs userspace control rather than
> in here?  


I think is is going to mostly be the same, so could be simpler to just
add extra channel properties on an as-needed basis if things do actually
differ between ADC1 and ADC2 rather than having to define all channels
twice.

This seems pretty similar to the discussion of how to handle e.g. measuring
the same inputs with and without the burn-out current enabled in the
ti,ads112c14 series and I think you have convinced me that we should not
be having a separate channel in the devicetree for that either.

> 
> Jonathan
> 
> 
>>
>>>
>>> The SLF3F discussion is about (to me) less obvious case of not a strict
>>> subset, but rather being detectable parts with different channel related
>>> properties.  In that case the ID match is necessary for anything to work.
>>> Anyhow, that discussion is in a different thread and not really relevant
>>> here.
>>>
>>> Jonathan
>>>  
>>>>
>>>>
>>>> Best regards,
>>>> Krzysztof  
>>
> 

