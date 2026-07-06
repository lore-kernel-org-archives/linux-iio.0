Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143063AD507
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354786; cv=none; b=VpQhpnDF+4ZTlFqhoM4qYcU8A2oyPKAojIshFuKHefUTWk4zUEJ7HS4eIGHYpmK+8HbX1vIz0rhjNsfmGrflwGNq5qM7kcbqCL4tuqCfCb7ZBCYw8Alaz0m+GVTN0k2PgfKEXNKyJdj6uaxQcKJNT9xyn4rgdk4SEcsYtBVquC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354786; c=relaxed/simple;
	bh=vA11+14l5gSo/MhdBMFiq+ymaNF3lUVsP5h/DVioFiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLIonrDo+xEzAyT/SDV80K1lteqFcKIFuLSoq/yUhOGPbokljjwqtOqcv6bn7b5qr1bNRxrwnrhqvMyukJAsmTzLhgru9skJrFN2/7qvIizZl8OlHwdGXdhixO1Ajb8HuJLujtUrPk4WqxYBdrR7IXVpjtfJncXDM8cXIX65TWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CUkC/5I7; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CUkC/5I7"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb68bdf53aso1043245a34.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783354783; x=1783959583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+xEzohj9Gz6QYFWnlANkEH3cDEdCmvWNWgOEl1idZI=;
        b=CUkC/5I7FbDOMhQI5ZrOB/6HnShu82xZM4CVYvwSnjk90XdQb2T3naNc19n2/i3UVI
         ii+V7JK0pLp1KDtmdIsLCaWyNjZgZ0OTget8J/tMGdxfCYJ+GTyiXaF37R8w3+HI0cBa
         E3N4p7V0Pf+Hr4C+akIGtR2yKZtwgEqiWjsljHqAVR/h1CB2fdZJQJQ/zq9aJ5F5GtBK
         IyrVcVJC51PLGVi71LSJbE4FR+AImRHnenjYxrDsPOkxXb0iASfoyywrHRqDOHFWtgx9
         5xBxpRBwhma2d9tD7g3nSqIS0xXGvrI7j0wLUYF0wOlPPyERLK8RCBTOXYN53zSfNRTG
         IJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354783; x=1783959583;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+xEzohj9Gz6QYFWnlANkEH3cDEdCmvWNWgOEl1idZI=;
        b=tC/IWGgSaLHjlhnMYlwjrKzbCBTTckWnbmDbGb93ulYa7K1iQ0ioH2Cjc7XFZ2aB+y
         JIR2CXMWXFJbpHFT5fYFsfSsZdEwwJAbBdCjNG+0zFe+rgztWoQ7ZR05Ho3SzltHX16q
         lZlQY7q2GxrcClipcsRRvuwR0rPOxM7bscbInkRrTdQodxU/phssNifArtTIb0AeilHa
         z++oGUoxMxj/oqd3tx5XLrBN6H+aYz4GbXABLzbam6Qh0wszO5c3Q4nDZ+rwJV7b3Fzu
         mMNPY2rPFa+UVRZyD5KrZJ7sh/GVOVzmmcNYR8Q9eZLlzxu3AK98Yi0Y2mnK0DwOCv/A
         O1Ag==
X-Forwarded-Encrypted: i=1; AFNElJ+MdpSHofwcrM4ZH/x5OTcVt1/4tSjXXzzbtEVbXoPgUeYvUgcl+SlG9SQuhK5NlDDl++sLIwkbTSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9eIvwVdyemq5myrBba13tdZwX3LZKksEwaokHjsY7z63cjYkp
	JbAhLU29gWbKFtsAUJA7Lzt7XDBLsNLBnM28mkEyuSg0bE7D9RC9mClo8gvpre/h/Vg=
X-Gm-Gg: AfdE7cmELjh20C906DODK4V4X9t06/7xTWV+EQLKcbG7vDurXyLRaoKQudGDW3tpuLJ
	AAaTRVq9dFlMgvxGbZIOVnIfayk5o1HLJXFh+9hlIhNcGizRhEsxhmdsLBZPABITgQodsnVoi8f
	oPr1nLJ4c6B4Il4aPgd+StE67s/FzMQO2qMl8071ecY6a5sOH88wdy0HaeZfsgIYLZjX5/fUKvA
	ye5lqYphwQV27+k2xYpWy0qiTc8WfTkDIdkGYDavl4YxPYIz2ngiOrPrSnoTTKufM/JwaQAqqB6
	8R7ZS08TMdfDMYvggPaUDvJWPe7hHqkpKyjHxBSJ+SwYYTwTzCHKPK6u2UenTAVxuItoDhg7sZE
	ifgh1ZWFBDGH67GKuVjzq3SbqbgbUo6SOjrgVQbir3hjW6OXMSxOgjNkgDkHCeJVKO9ZDUucJOy
	5NABrvKJuxQbDcS357abo1Ie3xRttKBt8H7xzmTZzmVCUBj8AVr3Zh2vGW1fjnXCbeIlYR46yOH
	w==
X-Received: by 2002:a05:6830:6603:b0:7dc:4947:36a1 with SMTP id 46e09a7af769-7ebb222aba7mr768726a34.12.1783354782993;
        Mon, 06 Jul 2026 09:19:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a38a:a0af:ed1d:5c77? ([2600:8803:e7e4:500:a38a:a0af:ed1d:5c77])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb8a1fe31bsm5441582a34.2.2026.07.06.09.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 09:19:41 -0700 (PDT)
Message-ID: <8dd4bb6b-a83d-4584-8893-b56b8aaed973@baylibre.com>
Date: Mon, 6 Jul 2026 11:19:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] iio: adc: ti-ads1262: Add conversion delay support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-5-4b1b231325ba@gmail.com>
 <20260630015027.3afdfc3a@jic23-huawei> <DJMK3NCDCHL8.1EHG93D5O7ROZ@gmail.com>
 <d8fbab77-6cb4-435d-aac9-0d72cd4a59bc@baylibre.com>
 <20260701012026.29f18bf4@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260701012026.29f18bf4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 7:20 PM, Jonathan Cameron wrote:
> On Tue, 30 Jun 2026 13:44:49 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 6/30/26 12:23 PM, Kurt Borja wrote:
>>> On Mon Jun 29, 2026 at 7:50 PM -05, Jonathan Cameron wrote:  
>>>> On Sun, 28 Jun 2026 00:36:06 -0500
>>>> Kurt Borja <kuurtb@gmail.com> wrote:
>>>>  
>>>>> Expose the programmable conversion start delay as a per-channel
>>>>> IIO_CHAN_INFO_CONVDELAY attribute.  
>>>> Coversion delay was always a somewhere weird bit of ABI.
>>>> What are the delays relative to in this case?
>>>> Is this a device that does simultaneous sampling?  Pictures
>>>> suggest otherwise, and convdelay is currently only defined
>>>> in that case.  We might be able to extend it but it needs
>>>> some thought.  
>>>
>>> The chip has a configurable internal conversion delay to allow for
>>> external settling effects. See datasheet section 9.4.3 if you'd like a
>>> bit more details.  
>>
>> Since this depends on external components, it sounds like it belongs
>> in the devicetree. I have the same feature in the chip I am working
>> on and was just looking at this and plan to add it to the ti,ads112c14
>> devicetree patch.
>>
>> This delay only applies to a "new conversion", i.e. when certain config
>> registers change, and not every conversion, so isn't like the convdelay
>> attribute.
> 
> See settling-time-us in adc.yaml.  I'd forgotten we had that ;)

I got some more feedback on this and this may indeed be something we
want to tune at runtime after all.

I'm not really sure where it fits in though. On AD112C14 that I am working
on, the DELAY register value adds a delay (for settling time) in addition
to some other intrinsic delays. I'm pretty sure ADS1262 is similar.

So one question is do we want a usespace control to be the total delay
or just the additional delay?

And when the delay takes effect depends on other things. Normally the
delay only happens before the first sample after any other parameters
change. If we read the same channel again with the same config, then
there won't be any added delay. But if input chopping is enabled, then
this delay happens on every conversion.

I'm a bit on the fence of if we should extend the definition of convdelay
for this or if we should propose a new settling time attribute. I'll have
to think about it some more.

Maybe something like in_voltageY_calibsettlingtime?

> 
>>
>>>
>>> But you're right, I should at least also edit the ABI description of
>>> this attribute. We can postpone this discussion for a future series.
>>>   
>>>>
>>>> Jonathan  
>>>   
>>
> 

