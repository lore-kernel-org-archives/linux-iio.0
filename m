Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2C377AA8
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126505; cv=none; b=ZynR0ayncAFvMYbLRqXZ5AHKt4Td43lzvP5i5k6wwek4ocxlzemRlbE4FippEK5apLByFkeXA1I15rynC64ALNDUOGHQrlZkMQvgeUcG0xHOxXf0eLokzU0xsn0eTOs3WQ4VTm7i7hbA/bwUViK7rHQ5QpEH1UToQ0M05g/0JJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126505; c=relaxed/simple;
	bh=s9tjNp6sYyYP4mCT3gXmsSd7L9AQpuVwD/wbCY/jEec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2yRhB72F4zQAEd5SAivlO+uiH0AGKySEmNBweUXzNJkcp8cFWdhN/dzisFY7zEvd0Z4g1xRkZi3gsB0rD0kdD5P3KZTHDSKxjW4yzU7sTTZVrLlXMpXch8NblfORgz/QaTL4A3kz/Ez/44oeofLoahC9EzTWUak+esr8zXZIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pYUZhPwS; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pYUZhPwS"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ec1e9d3359so2367713a34.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 11:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786126501; x=1786731301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O7m1ciHkvtKCbvcubLILJiqP/goECKk0dZZNr4piEjQ=;
        b=pYUZhPwSJxeO9WBfXuZFCy+XTWYeJFw2E4CTViQObxGkLsJFuvu2dPDqLak1ROGuz5
         P38wMNPMXE2fPz1A5MjSSXe60c7iCLf8PaMyRmZ9p5wZhF7rYakZ92qa6LVEQ1ngj3Hm
         VAWwkcmHrQKzaDSDRGO4fo26pC+UiHaPvt2TEgEYuVwI+5tIjf1CbyFvNkqHVcAR+8at
         57EAPGGpG4CnGeP74WdGT8CZM4REzccVR5ZCrjvcYDDlom6nlCaw8twffqBYr63P+iAv
         NSJ0En7H+0oKQi49EcP3Z/ukleylKQeHvEem6O3QZ4MnAl2snIkhhTYTXyfUiFwxLqK9
         57Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126501; x=1786731301;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O7m1ciHkvtKCbvcubLILJiqP/goECKk0dZZNr4piEjQ=;
        b=A40Kl9ALKYT5dpWLZuYC/tV7aXVVPB5kvFJUF+vq9RPyLpBg7YKP+XizkykZQM9x59
         LrgMyF256bSnt6lzh6CtsR6G2pxI8widddJszYZFsaa263+DEiGNzOr/ty2Ubo7elLUO
         OSqmDB3oa7pbr0HlwDRk6I9lNf3DO5NEnrs8b6DW/hjJrw/n2VdliGHdidmRDxKwZJSD
         gMGEpB9J3XSkYj+oLPxYiJAXawI5coP/wkT/V8h9LsuNwY6tzp9iPq+q934/gxN+mW5T
         PQDzkikKxFGK4MIqNPgNl1j4AsnEBjZSsXpVgcJ/gaHYrvjZiTr/Wp9caHUnTC6NhYV8
         6A2g==
X-Forwarded-Encrypted: i=1; AHgh+RpCo3lR0cYlzVjS7cCTZ8OxgFL/V1J/ymwUSbikRBvlA0vD3LBy0JoFKaCbQrSkkORVCTgZipjpkno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5T1jLt4xzNokmov4wbQmk7QNvhKz5vNtk2RpYskkt+d7wXelP
	q+MFzPq9JR+dESt0TvmQYw7F3v2jtadVK4jvBHRwPJPXuWHn9Zbeiekx+AQPuaEHkkM=
X-Gm-Gg: AR+sD11bXI6vRaEm8EWR5LJ1we/EnpfJFl/PmXoHC4ePZmjbGg1h+VgtMa4Tqw6BuGc
	FxtKnZTDOnBtz6vPjx+MBhms14fpk87nG4gf84p+GPt90k6D0QslM8OM6Cf2YrCQp2UlQLNvmiB
	WHxSDpuR8rluY4t9oolVC7k2GDcFwDwyTYXLpXydWl2/A//IQwSF1vAuJgMzzjGkxuPDLqr9TOZ
	/1lqjTJnaRoG5FVnuCrWjJ8UOQDwS+dFP7yaJqvnmZYlRLXxoyZA98sUxPBDVZJ8TcoIrhiG62i
	EVWxyr6dAz8li8oR8E7PR2OLdz5wYCVgGknKVkbgbVPbsUHcsCnVdZxy5OUBWUwZdoaPreFKJT2
	FiPUIVtiz0nDdjxPK/FmdU7GIEESKMDKDsP5hCWKoYuqIunbEqte3XPUw4IOiiFDDRotj0cpB2F
	/O61W5LJEPVE4V2iKW5ksgbpr3FnjMZfI98XTdJiaVtQuqTbNmcoSr6X+SgUY19HMPkialK3+xx
	d1M2Kcm0tJK/ijXcdmMncf8Y+xUFC0Xry92HzERky05YXhS
X-Received: by 2002:a05:6830:6685:b0:7ec:2fe:1ec0 with SMTP id 46e09a7af769-7f1e5ce9482mr16883603a34.4.1786126500710;
        Fri, 07 Aug 2026 11:15:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b714:88c:313d:dee2? ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b563978sm1826299a34.4.2026.08.07.11.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 11:15:00 -0700 (PDT)
Message-ID: <53ded669-6dec-4472-840c-91052b1afcb3@baylibre.com>
Date: Fri, 7 Aug 2026 13:14:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: iio: proximity: move LIDAR-Lite out of
 trivial-devices
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mranostay@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20260714215433.41259-1-rodrigo.gobbi.7@gmail.com>
 <7b8973fd-385d-4532-8213-bb0a811081ae@baylibre.com>
 <0ca14770-bb0c-4be7-a9b0-6e07d521550d@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <0ca14770-bb0c-4be7-a9b0-6e07d521550d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/7/26 12:10 PM, Rodrigo Gobbi wrote:
> On 7/14/26 19:44, David Lechner wrote:
>>
>> interrupts:
>>   description: 
>>     Mode control pin can be used as a status output to provide interrupt.
>>   maxItems: 1
>>
>> Mode control pin can also be clock output, so we could add:
>>
>> '#clock-cells':
>>   const: 0
>>
>> if:
>>   required:
>>     interrupts
>> then:
>>   '#clock-cells': false
>>
>> I only checked Lidar Lite v3 docs, so we should see if these are available
>> on v2 as well.
> David, quick pushback on the #clock-cells suggestion:
> 
> The oscillator-output mode, per the Garmin datasheet, page 8 reg 0x4 from [1], isn't really
> meant to supply a clock for another device's logic. As I understand it, it exists so the host
> can measure it against its own reference and compute a compensation factor for the device's
> own distance readings, since the on-chip oscillator is only rated to ~1% accuracy.
> 
> That seems like a different relationship than what #clock-cells models: a provider is
> expected to report a rate that a consumer just uses to drive its own logic. Here it's the
> opposite — the rate itself is what's untrustworthy and needs an external measurement, and
> there's no consumer that would actually want to clock anything off of it.
> 
> Given that, maybe it's better to just describe this rather than model it as a clock property,
> or leave it out of the binding entirely for now until there's an actual consumer for it? My
> point is more about whether #clock-cells is the right semantics for potential consumers here.

Yes, this sounds like one of those cases where there isn't an obvious
correct binding and we should leave it until there is an actual use
case to make sure we get it right.

> 
> Tks and regards.
> 
> [1] https://static.garmin.com/pumac/LIDAR_Lite_v3_Operation_Manual_and_Technical_Specifications.pdf

