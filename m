Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D713CF67C
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781190; cv=none; b=MR3n/ZSAv9zEH0bEqGjQ+F4ea0bNQsM7RJY/6EN0VjX+HVeBD/Hvhv7mBiYzaw3d8hdNfhRdUiaCaopZzkBBOu3znyrlsKRoy8PyKWNAnwjUU/b0jxXBkbYtks/dT9TI7tAzUyGcHOD6vZRubz/WnyMZPjCyDbcdMy8FjeEjVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781190; c=relaxed/simple;
	bh=UWPQCfgf316qPUguCLiEFmB2ZXHdeN0sOy21ZYEMOWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EF71Ge/dBu9kcXZPYlpVe8say3JlBlhaLCNdLqmkGW49wQARv1k/KXQeA9QFmnjSrww6YpQuYL5OukvPMwqPyjWFquvXmr+VhqUo2++jpiXkaM0aBLBfQwziiSIYkbFzjDaAJAtA5GiFF/cJXh4WW4i1rhhO27NXUbIfZImBTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Y2p/7jYg; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Y2p/7jYg"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-479d9b155deso677822b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776781186; x=1777385986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ya9KQ8AG7Y9lezf9EpBb7uASqYKD1uqcvJf1BeHB1ns=;
        b=Y2p/7jYgEuH1+I7MUMEh33jpigc6gHDFNZ3kxhcfDJj+m3wXd13qKM5lAcSl7+68Ef
         VQFptxE3Js2158B8xtORWckMaP0rUEHz6mdYDZcsKXlgG9ZG/rBVBj0jQVlzmCApzPxp
         Iye+7f+A0tDgbPT0X2r1/BHli8JkOWb7duzEH4N3tzEuKk/P/yzBSONuzOBWpTsrP2UH
         ZW9flHnFzEQ8nIgp1zZSd3Xuu8BFmo0Gci3mA2PuqkzBPOPqT1nDtoocA/xiHl+QTUXz
         AJbwKI3k9Xyykg7JSzbXUT5FHR3citteukHoLz6LQLP+jWv2lkinu4ryVnRvDYzq1rFL
         RV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781186; x=1777385986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ya9KQ8AG7Y9lezf9EpBb7uASqYKD1uqcvJf1BeHB1ns=;
        b=JdpsYoQj0rRq/qk7H8Gg8x9BoIXVksQU833xFwAUThdddx8VGUauYK3wWymdBu5Yny
         sEgUltnLHu87Ud3NXWzurJbYsjcz9WexvlSgTjFGCsgClUmLNjXu1Djnf5Pnp25aP4db
         tfnyMZ0/MK3lvTxGkrxiFYZQolItP6IumeLAfXn+0zQ4HRbsLgRtsSdV5prKZ0uzEEqH
         cGX6zPEZDhUDalRtwSnVH5HkX4i9dWf9EJFhJIiHrtUt59c4czn8v/NZPyqyEPg5NFZE
         ccJmtkzMgeci2ow39uSR+jwUS7tevljkC+WY5YKmZ8ASkDMwyROVIdkEIeoa1K4hEqba
         niqg==
X-Forwarded-Encrypted: i=1; AFNElJ8bG4CsbmnAN/fALw0bM3DNAAK89DmvJlZ2HCt5z7TNTt+AulKL4/No+vkhqnVR3L78oGTBLD2QsNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0I8JfHjtXRKpUkMJVp18bv5ICXs6c68NFg2/fctAWq5SBNDGU
	lnVMYzpA5wrD0rufhmOGs1PdLGsHKLCf0pLm6jR5Et5QWolsFtWzmwzBk20cP2Fb4FI=
X-Gm-Gg: AeBDievnQYcrO12lPaXvB4hTOURND++wf43OlTYXFJb4YjHFTOMCJ2UztjDM4EsIuL2
	oMKEugkU8vSrHpX279TyxqpkGieL5EZIpu4YHHVV8Xt9o6kwjpHYGKxih9+2e3MSt4HiWqDIuNO
	O/KDE6VTsiczG2a2N1nYVM1aISHCskTDdibbCErQubvFY+k+malMFIZaGPGnU8w8ZK6ETLDbABD
	MpRWxsN3SEW1C5fLMcdnvy7IpzJtvL9LaWrv8HYgHyz8xd/IYICYPbtXiHPyxjlVL0txxIzIRRy
	rtS31Dv1cUUoxMtDF7tTq2eQPiE9Gp2GSCEQ5GiX0GGzFqvO5oHFzcEmC3lzzj2byQj7vK1PbeV
	roDz/n12w53sBG3HUutAU9wchCwIa73oxHNwqtEMFcEfPpBB1O1vIblTfuGoEH42DltQMJT7ty/
	2x8tnN+XcYH4J8aIUpOvSXECBgRSvOetpboczVYl3zMSZq7rGgSi9rkDmRfqgLdzM5rsaa+2LVG
	5NSzMqaVFxx
X-Received: by 2002:a05:6808:2507:b0:467:3f4:9073 with SMTP id 5614622812f47-4799c882ed4mr9496713b6e.16.1776781186245;
        Tue, 21 Apr 2026 07:19:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5? ([2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b930bd9f2sm10716833fac.8.2026.04.21.07.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 07:19:45 -0700 (PDT)
Message-ID: <60e5cb91-e82a-47be-a7a0-c89f5f1b04ee@baylibre.com>
Date: Tue, 21 Apr 2026 09:19:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: iio: dac: mcp47feb02: Fix maxItems value
 for reg property
To: Ariana.Lazar@microchip.com, robh@kernel.org
Cc: Conor.Dooley@microchip.com, nuno.sa@analog.com,
 Jonathan.Cameron@huawei.com, devicetree@vger.kernel.org, jic23@kernel.org,
 krzk+dt@kernel.org, andy@kernel.org, linux-iio@vger.kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260417-mcp47feb02-fix5-v2-1-6592ea499cce@microchip.com>
 <20260420150116.GA2486072-robh@kernel.org>
 <8a57341539af3a96ad42004be2389370b76a1a56.camel@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <8a57341539af3a96ad42004be2389370b76a1a56.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/21/26 9:11 AM, Ariana.Lazar@microchip.com wrote:
> Hello Rob,
> 
>>> @@ -161,8 +161,7 @@ patternProperties:
>>>      properties:
>>>        reg:
>>>          description: The channel number.
>>> -        minItems: 1
>>> -        maxItems: 8
>>> +        maxItems: 1
>>
>> Perhaps there are 8 channels and 'maximum: 8' is what was intended?
> 
> 
> 
> Thank you for the review.
> 
> Indeed, I mistakenly set maxItems to the maximum number of channels,
> rather than to a single entry for the reg property (reg value is
> between 0 and max 7 based on the part number).
> 

> If preferred, I can also add minimum: 0 and maximum: 7 to specify the
> valid range for the channel number.
> 

Yes, that sounds like the right idea.
