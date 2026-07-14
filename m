Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577273DB636
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057130; cv=none; b=GIfHFT/0LUgCwrW6ktVS+ne2yz1yUdtEwXerf4J+T3kq4yueIxO4VloWcrklqt+6RYCM7xWmuceX26Osd6r+dKIRWyFCu+6UaGYwnnT30FovbPwzSScKiDrEX+3+oviuFYeDJJoaB8aHbfxg2Kripcr2GQycNjcos6P7PEiP6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057130; c=relaxed/simple;
	bh=EX5yKJb8Euh5X5VHbTkU92t1oQnTP18tRQRozxrHgjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsC+7y53uQFK1qJ+O6kpdVgXBfphodFvyxLorhX76kQvmv/CrtxYXXcbJpcJUNeSaoZ7gs+wbAWJKJ0ORjhl6MSlry/d95CQ/3xIRPKVxVgQztf2Oz6uTk4tZZNagdCMCdvqJZXgtyvIgqjvw65CiXRwwlVkm/0A5MyDYDuvRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=GhqoKbLY; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="GhqoKbLY"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a3da2369bbso8984eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784057127; x=1784661927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4ONTzaMp1liWwOrIeA/8iMl09tZSizZYRiO5e4Y3Gs=;
        b=GhqoKbLYyftAiGIg8EgIbsYWldMPOvKxIFb22SgeixCVTst2JWWD2aEcB9SK6u2YvM
         qJuVrERbTsFIdhrmOu4aBJZLPGBvstKa5SRfItuFpvL//7uOuKGHjbPnj/VsjZTFY5aj
         pubxwCtuKPygzb02zFtB3uuIYgvDdlSLGl+O+mKPm7mp67i9ZBENz12Yv3niGe05oglJ
         rexz+IEVAkSqii+xRSAy3oKmbs1H/69SdG1W2uPDOVfi1NotCwxiuhtMAu0bzkHLZ7Wt
         sKY1ovQurxASlLJKA/NiO794CF3EvgYN7eC5UX39lDcbiowNabTM4H+KED4nNAoW8iAu
         iYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057127; x=1784661927;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m4ONTzaMp1liWwOrIeA/8iMl09tZSizZYRiO5e4Y3Gs=;
        b=lJ3Vprj56rcTuuksE0pf7wVnXZyjiyu+Oax1n/TJKXV3Rbs2rEwXM6OmVHWJHFlpNu
         0f/YpbRK6GjyKIwGWWL82ySxnfYqfXDCApB1zZFfUlzXXdFAO2U48vEYa8o1qp9XWUaj
         CjFQd5pYFqsCaYB5aPH09yUqpHeA4gYLPGEP8/EgEXBCJSOmTkvWgKaHoy3faWUoOdmf
         FPKTy7zJyBKczv1FgW9dclRIuNRpdmfqJVNyoOasm11VY8TTC4nf+2VeSxVLOsLIu/6m
         yMCqwnqWRPSjpsxOj0DlF26wUsDSD7U2A3E8VHiMGCLqvMZ2iLR8qxvCRzURtD7VDOEe
         R0Vg==
X-Forwarded-Encrypted: i=1; AFNElJ+k4KHAexQgXTWnMx254080amHq9ysa2+nPU32lnksn0TNvX3PEYaz0T0BzThqmWXD0aboXH56BXdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdLOqVUSxj40NKjKQ7NKUy1XsYAeYfrS86CQjTj+dgjAgBPnL
	nYDmProDLlDLnUUfK0HdaKqKPGtK3o9gHkf7qPu4M9jwQcdXFRbV0al9EZpPyna0b1A=
X-Gm-Gg: AfdE7cnlomE8CQQBEMNhDWbysGI2Mwf+MWSSCgBNMJT2juQW/iWrUcoR4xH3VsUDrRp
	MvI/Emh2NEkkLHeC+Rh3GQXEnUh9u9u0y5diccWamxrZvJQaZOmpmYwke/rtIPFw4SFhQZ/pKQb
	0gotuRg5sfewAw1O6peF4KNr/EMmcANl4dcOExQR1lbG7Q6NC8GTCzCT6ZCzaF2LHaDTGd3otp9
	ywRK3HDjZA/vpZmFCFpraj0pW8XTn3PYRRDJLCX1e5s2sp6QFHGahIQS+m5Xk5fpb67UuM6AiKq
	bOP0qLPVIoEjcBne0AT1ssP6QerDLt0Ie5XQRGrwNAuwEsqxy4Gmn1JmiXVOGBSsWkOmVlW9oK9
	/m5BF9UKfK06skJbS11RLv5EEiN85umfEbYVWdeTcfkSNiL8K/gbiieg0fqDqdL7M1wnIw5hESX
	aDvcgysowFUKE9lUQWX9mvQBxhhTJhmVPQ1wHyXyYlJ4QWoKYhx2KoGDqumSrWn/vuAc3TBAXOx
	w==
X-Received: by 2002:a05:6820:3410:10b0:6a3:c52b:b953 with SMTP id 006d021491bc7-6a3c52bbe82mr2181491eaf.50.1784057127280;
        Tue, 14 Jul 2026 12:25:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:280e:69fd:7612:d5a9? ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38e16c7d8sm8811266eaf.9.2026.07.14.12.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 12:25:26 -0700 (PDT)
Message-ID: <2a86e4a0-0203-47bf-8857-cf4fa9b642ff@baylibre.com>
Date: Tue, 14 Jul 2026 14:25:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: Add DAC8163
To: Conor Dooley <conor@kernel.org>, Lukas <lukas.metz@gmx.net>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
 <20260708-dac8163-work-v2-1-3acd1bf20182@gmx.net>
 <20260708-spotty-spectacle-f270b4c66d18@spud>
 <alZPZuAQfiROz8kf@berta-MS-7693> <20260714-unweave-pointed-ef9c6c02a053@spud>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260714-unweave-pointed-ef9c6c02a053@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 11:49 AM, Conor Dooley wrote:
> On Tue, Jul 14, 2026 at 05:01:58PM +0200, Lukas wrote:
>> On Wed, Jul 08, 2026 at 05:37:44PM +0100, Conor Dooley wrote:
>>>> +  clr-gpios:
>>>> +    description:
>>>> +      The device registers are reset when this pin is asserted. The output is
>>>> +      set to zero (xxx2 devices) or mid-scale (xxx3 devices).
>>>> +    maxItems: 1
>>>> +
>>>
>>> Sounds like this should be reset-gpios?
>>>
>>
>> Thanks for pointing this out. The description is actually wrong. The
>> datasheet says: "On activation of CLR, zero scale (DACxx62) or 
>> mid-scale (DACxx63) is loaded to all input and DAC registers".
>> That means other registers are unaffected. I will update the description
>> but the clr-gpios is correct in this case i guess?
> 
> Sounds about right.

For ad5791, we used clear-gpios for a pin with the same function
(even though the pin there is labeled CLR just like here).

So would be good to stick with that convention. (Same reason
we always use reset-gpios even when a pin is labeled RST, it
is the same function.)

