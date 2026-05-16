Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6773D6494
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778943881; cv=none; b=E6syGx5wvPkV5MVPtK7y9e18PVf/vLD+If2xi5xjVlrJnfB1lA9bL7IkpKZedd4Tt/IM7zJxHz+jcYsoHc1ERSlay34Ta3REIPqyievjY5eOiUy9LAXLZwZcTg55D6inXd9q6yA2ufKSyIy9mGjVgS7TRqsoXVhonfS3oXRtNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778943881; c=relaxed/simple;
	bh=DeP8aPNhQW7RoZvHLHe8KiJ2+37TOAE4UdpZx1617fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIgV1uDmhk1QekeN2TuEnKc6uW5dqeaoIvp1dzWpsTckADHTMn/yIRauPH4IrgwaBnvq/dZm0fjVGF/tLjAzmPhajauSeopIGJYdEogVGbnhnlsEjeYEyfIukJLHF8TC9DBaVnyJAkYLQesYKNmvcXliP7Ka9MBnkghy0bZtR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3Dnw17Q; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3Dnw17Q"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso485710a91.1
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778943879; x=1779548679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oCte4RlZADTF+ESUS6lzcGdE+SS5zOb6KTF8q92kgKY=;
        b=C3Dnw17QSffMmTTRiMGUjCPvmeuqFkg2bADtVqbzE/AmR97Gg88JnaIWi1SUFVLS0O
         xq55hCssgeGzrR5jWA9BHoCzWdZd3lZ/uFiSfahEzY0OG5a6ifgMJWUZgvBEvPjgVSTp
         TUePt8gcnm4sZVcXD4forV4xFKJLddalo0vBF1DLWuJI8TaRlMlfLf2Hqs3yLDqDxstZ
         adhkRDIlFcqjs92cDmnizD/fURSqnfHW4kOcWtaYvyKmex2H6p8C5Rivc1YnNasSi9We
         sHyRKNM+uTrK+hVVqr8SZ8YluLfTdG0Tlb9AFJc96/ulVeTxbDMlQSDHJNxHcTCIKnKu
         7kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778943879; x=1779548679;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCte4RlZADTF+ESUS6lzcGdE+SS5zOb6KTF8q92kgKY=;
        b=pvTEh78COedos+0xfJRx0cqqHgmK+nMkJI/N+0lJvKcTBbuIFsRuqe5o0H4zIB69li
         c9fFJEEIyX9E/794ZKJDi8H2orcKl9N5eIUp7iCuuiM55DwYbDhrBTCthAXMAiF3ovbP
         eG/+4/khTLpGEjETwdoVzhq97dgWWlA6e4JJUAK4l/4ECuWr07NY/Rn8TZHlVZwwyEaM
         50vdMJxW0bfI2iGeDwryzEjRdBXpztQ0RIaEWsuT9cHGFeLkvULB8TtmkjsaKiBJvzw+
         X1M5HNAMPiibAlAgfOirxEfQ3qDmCxbAWrdXFeZKsdTxVBWXlrvGFYzM80DGRlElxYVl
         377w==
X-Forwarded-Encrypted: i=1; AFNElJ+WAp+KMVG1LnbsP3KTDjUP3b35QcPHNi8xiQ+PMMw+Lt8n7p0VMSaCT1bzJ8siOGHbtwh9vb1h34k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrzdx99hbYAkm3bOP5GVLpVX1dYq3mJ3FPkpBv8UzHwhBBlCX2
	588vrJxS2vPy2eHAfeIG9l39uLJLVSoQVcT2lERZ4NNQdzZguwtVBwnb
X-Gm-Gg: Acq92OFHRZEtWqOfvKLM7Bv7XO3tiqTduWGoexBb7NfgyxfNvOqYSkH+JjEoHXl7drS
	3Sy0NEn+ZOf+bYIsKYk1DkcGUPfsSmcFA62AXjU7qC/e52dnXo3jF99eJbpQCHTFFGbIU2+XkHe
	DvI0Y/+ZvYl29zvA+DoNQbQ51S62Sp6nXG5SGcmQEE/BNhHqhpIjG/1+V1QF1KhGodWa5Dyw9/G
	b/0hhVzy8mtQSj9PkuknLzCabgCEQ0m3eSDe63pdpOvshAvAxGp3EAwMd5Qvu7uQ/7jxVaE20kn
	8bgCvCtaT1E9a2g7tOKRnY39Ft5pL6henK+haj2zjhnVwpbFJ1mG+lGbR2yVovQfJT2xEr4Zxrp
	fzGKcKDOJYUDz+k8SyKB1aMv/Qand1A4Jik6JAx51t7yBgczfHzZhjHF3Ygs+5Bzd/PtvopPylS
	MOOk56DfOOBf4YnO3veIQJIydw4rHofQU5SaGBHIcI/Db0Ocz/qd7QfJ8ZBokdonSjEszBOQyd9
	ysv2oWLbd0=
X-Received: by 2002:a17:90b:38c9:b0:369:9469:aeba with SMTP id 98e67ed59e1d1-3699469b41cmr739591a91.1.1778943878670;
        Sat, 16 May 2026 08:04:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517fe89dsm5806546a91.17.2026.05.16.08.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 08:04:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d5fe3740-bd49-4835-acf1-b8cc56543318@roeck-us.net>
Date: Sat, 16 May 2026 08:04:36 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: add Versal SysMon driver
To: Jonathan Cameron <jic23@kernel.org>, Salih Erim <salih.erim@amd.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, git@amd.com,
 nuno.sa@analog.com, andy@kernel.org, dlechner@baylibre.com,
 michal.simek@amd.com, conall.ogriofa@amd.com, erimsalih@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-3-salih.erim@amd.com>
 <20260504183215.37c8ae65@jic23-huawei>
 <66268e35-4897-4c40-b358-1c973b70426b@roeck-us.net>
 <ec5634b3-2f17-42b6-8bfb-124ac0c7cde8@amd.com>
 <20260516112057.381dc19c@jic23-huawei>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260516112057.381dc19c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/26 03:20, Jonathan Cameron wrote:
> On Tue, 12 May 2026 12:35:21 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
>> Hi Guenter and Jonathan,
>>
>> On 5/4/2026 8:26 PM, Guenter Roeck wrote:
>>>
>>>
>>> On 5/4/26 10:32, Jonathan Cameron wrote:
>>>> On Sat, 2 May 2026 12:19:48 +0100
>>>> Salih Erim <salih.erim@amd.com> wrote:
>>>>   
>>>>> Add the AMD/Xilinx Versal System Monitor (SysMon) IIO driver.
>>>>>
>>>>> The driver is split into a bus-agnostic core module
>>>>> (versal-sysmon-core) and a memory-mapped I/O platform driver
>>>>> (versal-sysmon). The core uses the regmap API so that different
>>>>> bus implementations can share the same IIO logic.
>>>>>
>>>>> The core provides:
>>>>>     - Static temperature channels (current max/min, peak max/min)
>>>>>     - Supply voltage channels parsed from DT container nodes
>>>>>     - Temperature satellite channels parsed from DT container nodes
>>>>>     - read_raw for IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCESSED
>>>>>     - read_label using the DT label property
>>>>
>>>> Various comments inline.  One thing to check.
>>>> Is this one strictly a hardware monitoring device? Or does it
>>>> get used for more general ADC purposes?  Did you consider an HWMON driver
>>>> for it? The above sounds a lot like hwmon. So why IIO for this one?
>>>>
>>>> I wasn't awake enough on v1 to raise this!  Sorry about that.
>>>> +CC Guenter and linux-hwmon for that discussion.
>>>>   
>>>
>>> This very much sounds like a hardware monitoring device to me.
>>
>> The device is indeed used for hardware monitoring, but the hardware
>> characteristics push it towards IIO:
>>
>> - The predecessor (Zynq UltraScale+ AMS, xilinx-ams.c) is already
>>     in drivers/iio/adc/ upstream. This driver is the direct successor
>>     for the Versal generation.
> 
> Was a long time back but at the time I think it was argued that some
> usecases for that device were general purpose external ADC channels
> rather than just hardware monitoring. Is that true for the new IP?
> (might not have been true for the old one!)
> 
>>
>> - The supply voltage encoding is a modified floating-point format
>>     with per-register exponent and format bits. This non-linear
>>     encoding doesn't map well to hwmon's linear in*_input model.
> 
> Given IIO doesn't really do floating point either I assume that is
> getting converted to something fixed point which ever subsystem
> is used.
> 
>>
>> - The device has configurable threshold events with per-channel
>>     alarm registers, hysteresis bits, and level-sensitive interrupt
>>     masking/unmasking -- which maps directly to the IIO event
>>     infrastructure.
> 
> What in that list doesn't map to hwmon events?
> 
>>
>> - Oversampling is hardware-configurable per channel type with
>>     per-channel averaging enable registers.
> 
> I think this is not present in hwmon (could be wrong!) but is there
> a 'right' configuration for a typical usecase?  I.e. would sensible
> defaults work?
> 

There is a per sensor type "samples" attribute. I don't recall a request
or even a chip supporting per-channel oversampling, though such an attribute
could easily be added if there is a use case.

>>
>> - Up to 160 voltage and 64 temperature channels are dynamically
>>     configured from DT, which fits IIO's dynamic channel model
>>     better than hwmon's compile-time attribute groups.
> 
> This used to be true, but hwmon has for some years supported a similar
> model for channel creation to that of IIO + you even for traditional
> attributes it is easy enough to create them dynamically (that's afterall
> what the IIO core does under the hood!)
> 
> Anyhow, take a look at struct hwmon_chip_info and the HWMON_CHANNEL_INFO()
> macro.  I couldn't immediately spot a dynamic user but maybe Guenter can
> point to one.
> 

There are several hardware monitoring drivers with dynamic sensor allocation.

>>
>> - The follow-up thermal driver uses the IIO consumer API
>>     (iio_channel_read) to aggregate temperature data across
>>     multiple satellites into thermal zones. The iio-hwmon bridge
>>     then exposes the same data to hwmon userspace.
> 
> This might be a good reason for IIO. However what stops you just embedding
> all that in a single hwmon driver that also registers the thermal zones?
> 
The hardware monitoring subsystem supports registering thermal sensors as
thermal zones. It would be up to the thermal subsystem to aggregate them.

Guenter

>>
>> So the architecture is: IIO driver (provider) -> iio-hwmon bridge
>> (hwmon exposure) + IIO consumer (thermal zones). This gives both
>> hwmon and thermal framework access through a single IIO provider.
> 
> So overall there are some possible reasons in here for using IIO but
> I think a little more in depth analysis is needed.
> 
> Thanks,
> 
> Jonathan
> 
>>>
>>> Guenter
>>>    
>>
>> Salih.
>>
> 

