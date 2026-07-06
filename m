Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF63ABD8C
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353843; cv=none; b=YiYb6buINgRQXWXyFDx8OXnGBK+gPMrXK8I2RT2iNekuHZE+QNEnITDY7f+N7seYfg76hHsBqocsPYPR0ut19+gGyFo8E3eqc3XZPj29b7zplw+F+ayatj7vo53D1d1dchC6fGEpUj99PPCt5ueIEI8e4uj6DqDky1EVIG14TkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353843; c=relaxed/simple;
	bh=1pEQzK0WF5/785k/T7XTlqu5jZxHDtonjdYKw1Fu0fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFp838tDLaSzn6H/excxP+j2emhhiqBCCd3iJJ3GpRnVlXb/fSU2MuTakOKy8Ql9I7ciKtUk20hmqeEw53ZfxbdETLdm4ikA/nAQHzENQHQXf21/1rYFwKy65GWTdaEagRYUEU7D3aDCfwo+THYxyMMSKmQwVruoGEkftPwgjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1qcoOHZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1qcoOHZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cca0c5799eso11002435ad.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783353841; x=1783958641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dI9mMky87Y6sbaEIXudUF0U1R+oiPY5jBKcaW4/toq4=;
        b=G1qcoOHZzGIrCQKq2Jkr5BYW9pf9Lrty63hwkhxBJ3eZE3Psi3MS+BSf3XhmPxKyEA
         ZDQ/tkiU0+9LbRkO1prlRe6MN8pMDSHNrSvt5Spqw2vi9pCrDlHDg5XjLhJ+OYzRKC+W
         fCwEiaYwJdASQzfUe447mwCbWi4T4XpSLrAXWmEpw2yAMPZ1Zowm49505JSHf8oKoJp3
         jI+iiBYgTdjUYPSNnwONw9XxJceYqTgvxTUpaHW5v6YrfAdRIAkY1iCnDoc4VEU78uue
         ltS10vs9Ju4l2n4+nQQI8DwWbyoIk7okKFfg0ocaTm6BfM1Aoya+SpPVc/YdeCBhrZD0
         I1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353841; x=1783958641;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dI9mMky87Y6sbaEIXudUF0U1R+oiPY5jBKcaW4/toq4=;
        b=Kslbrx68TQv4EHXvqBEXj39XLtqej7SaYz3BZ8ZjDUZ1EPgs/jfe4JcKDhjlZ3Ddvh
         BfcNYfRqFlF925SLN4NMt1yKTKWJTzp1hZbpLAXKLb8fswIM8hIrvkRD4vFLLkXqBdy6
         tIbFYk64tqsfKmfriUFfz894Tui72sfazNp6iPhUSjWaAzoPCFH8XLajnZUQG+P9Q5Yf
         8K+rC0kxMMNl+FbVeWlBtgmZlYnw8l4yONNIZhMly84IDO7hDRyLivxmakcr81IgiQ5k
         je9Eyew76GGjqnTJLstZ9PmwXo2O3b8w4zNmtjqCTCFsoWh8ch5GMid6mhImrOFskhix
         C3IQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvEGwEwbJAiOKvyFK7PrpRP+M294Cv2mww7llrVC1N6EHxoRo0pBZKE4IuRp1HV3nbpul69G6Zdh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3b6seg3P7spC1UhQI7bGFuCHnMJDVUqjVe4tltP/8nhxhE8J0
	5UMF8YBZVV/nu10DDMQDHU2SYoyWOpZSJc6euD+0bztmbw4bFJMaj70O
X-Gm-Gg: AfdE7ckDguF1JOqhLmLFqfq2tHWjD9OcvSgG9ZQyBxqihHEMOs5AebqKAC4Ngnehy9Y
	BTdnIjH+0h9xR0sZE2saABc3TDA8URPc2AliAXlFN1V1CykR1lSQZPVP543qv4hhOXluU3xgnWL
	dohsHGqPc/chpBoA7CGSu8/+hTRgCQQPaWDWjse0Sx5EikT5gGOGEpN20Qoir3miOQ/jdqV2U4K
	9tuWtjKdrIVx+21iG6Uh2Ha4ulAq4aOVqFGjJWdsquWIne7UwEAr6hESMxVtJ5H6xkEUZO1UFNH
	tVgcetVdGdj7aI5EgDDVydM//OJMFUE9KU9szGmaj7n6SKPnDxm+3DwhDNHVHVI5ibHssHO9qT0
	FjCg1s3tXs5v1u0WsYj4bUAtU7JNKvW1kzcxx2tyti8tQ3woGcKAxgoD/VIgUeFqlD6rjMP2lKS
	qJoD1gUZqhmnyHe/h2pd2h325IsfrHy3t/gdWsyTjL74RJGRMxnKX1LTOUehALn9gpA50Ryku8
X-Received: by 2002:a17:902:ce12:b0:2c9:97a8:aff3 with SMTP id d9443c01a7336-2ccbf1ae951mr12558905ad.44.1783353841450;
        Mon, 06 Jul 2026 09:04:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm52865625ad.13.2026.07.06.09.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 09:04:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <619e2d5c-84dd-4143-9061-019491b3130f@roeck-us.net>
Date: Mon, 6 Jul 2026 09:03:59 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: temperature: Add STS30 temperature sensor
 driver
To: Jonathan Cameron <jic23@kernel.org>, Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 linux-hwmon@vger.kernel.org
References: <20260621004626.66629-1-m32285159@gmail.com>
 <20260621004626.66629-3-m32285159@gmail.com>
 <20260703010532.4fc0f46b@jic23-huawei> <20260704144503.2347331b@linuxescape>
 <20260705000053.6e8fc3f0@jic23-huawei> <20260704205717.137c506e@linuxescape>
 <20260706165334.69846485@jic23-huawei>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260706165334.69846485@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 08:53, Jonathan Cameron wrote:
> On Sat, 4 Jul 2026 20:57:17 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
> 
>> On Sun, 5 Jul 2026 00:00:53 +0100
>> Jonathan Cameron <jic23@kernel.org> wrote:
>>
>>> On Sat, 4 Jul 2026 14:45:03 -0500
>>> Maxwell Doose <m32285159@gmail.com> wrote:
>>>    
>>>> Hi Jonathan,
>>>>
>>>> On Fri, 3 Jul 2026 01:05:32 +0100
>>>> Jonathan Cameron <jic23@kernel.org> wrote:
>>>>      
>>>>> On Sat, 20 Jun 2026 19:46:24 -0500
>>>>> Maxwell Doose <m32285159@gmail.com> wrote:
>>>>>        
>>>>>> Add a driver for the Sensirion STS30 family of temperature sensor
>>>>>> drivers over I2C. The STS30 family of sensors includes the STS30, STS31,
>>>>>> and STS35, all of which are supported by this driver, since they all
>>>>>> share the same commands, etc. and only differ in accuracy and tolerance.
>>>>>>
>>>>>> The driver currently supports single-shot non-clock stretched readings,
>>>>>> by using a specified delay based on the repeatability/delay specified
>>>>>> by the user. The repeatability/delay can be changed at any time through
>>>>>> sysfs.
>>>>>>
>>>>>> Additionally add Kconfig and Makefile entries for the driver as well as
>>>>>> a MAINTAINERS entry.
>>>>>>
>>>>>> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
>>>>>
>>>>> Big question first.  Why IIO? These are fairly basic temperature sensors
>>>>> which typically means hwmon is more appropriate.  What does it need
>>>>> that hwmon doesn't provide?
>>>>>        
>>>>
>>>> The datasheet says that the STS30 supports continuous reads which means
>>>> that we can read it into a triggered buffer (which hwmon doesn't
>>>> support) and at some point I'd like to implement that.
>>>
>>> Hmm. For a temperature chip that is often more about the monitors running
>>> continuously than the ability to gather signals fast.  Temperature changes
>>> tend to be fairly slow when it's a physical sensor - gets less obvious when
>>> infrared remote sensors are involved.
>>>
>>> Even more relevant - there is an existing driver I think.
>>> See drivers/hwmon/sht3x.c which supports things under the wildcard sts3x as well.
>>> Check if that covers this part.
>>>    
>>
>> I think the last time I checked the sts30 series wasn't listed in the
>> dt-bindings but it may have changed since then. Oh well. I'll still go
>> check it out. If it's (very very) similar I would probably consider
>> dropping this one, otherwise I'll improve this one and resubmit once I
>> get the hardware.
>>
> 
> 
> Unless that other driver is for a very different part, then it is a non
> starter to have a driver in IIO.  Perhaps there are features missing in
> the hwmon driver though. +CC Guenter and hwmon so they are aware of
> this discussion.
> 

I have no idea what might be missing, or why the existing hwmon driver
would not be sufficient. Lack of explicit devicetree support, as
suggested above ? That would require a few lines of code and an odd
reason to duplicate the driver in the iio subsystem. Triggered buffer ?
That makes sense for high speed ADCs, but not for low speed sensors
like this one.

Guenter

