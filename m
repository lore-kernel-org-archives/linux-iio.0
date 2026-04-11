Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D387390987
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775933290; cv=none; b=cKVGQT6MrEdhqJeZrnuEvHxV28STMEiMvinMU2cBnBP77W7a29tvjwBbV+VX6qzBjdPNlMrBMGGIE+NorGG1ETETNBF7sabgKXiQRGy3Opwxsl8vIdAPhLuyMeL3+yDBrJR++hDEaOfacwOr5IFJ6wBaNax1HYDDDF9GgNr/0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775933290; c=relaxed/simple;
	bh=w+//mi82t/AFJZGOE3RgKjE7VvmOav8XF5R+l+x5Cq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFWGcXSwAbb1zZva2xZxYwBEzAjzooootAKeAvKRgjycsFzsDt0jElD1Q8A+MpnB+dZYtSo3sVyUo256w+cBjv6bUZ9g71Tu2x2yWEXW3fYyuhfhfeHE8npS2IvAQu2TCJTygO0mh6RqqvOgegMKxqwiJxCgMEB0R4paI63hKu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=svx4rfZO; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="svx4rfZO"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d1872504cbso2829222a34.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775933287; x=1776538087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+Q6r4TxWKIWFNBvpJX7A4fFI6RUB70unKQpvglQM5o=;
        b=svx4rfZO9Iit2gnw/pJgO6w/ydWg4BcsvJsC0aMS0Q9RKYcdPlgllvV2WEsV7XH0MH
         4insKIQhKTIPvSWe55JmcVwooGeQT5CdlapSZtbyBs+uzjMQej5IZR6SHm9G6OTza4fW
         w9yYpU2Z4q/h3Ii17rr65fJBCj3beaPdcSGh80JP5GJFTA/TWc5GLlP8MDMb81PCjC1e
         +EwmeND9lBTz/Tfc+z5dcf2e7kxWjNxNCeb28POrjvAOZ/BVmhjKCTAIlvFdh+h5cB0i
         g2RgbQCZB2i8A/CVLTmXQZZVhbRqwyD1wasioVpC9M5Q1OiRLPHJLtFmogYzgM1B91EL
         WUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775933287; x=1776538087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+Q6r4TxWKIWFNBvpJX7A4fFI6RUB70unKQpvglQM5o=;
        b=kh82DxCPhdy+id/3lz1ZLByFhEr8ZgVmgKzTSRIFxUxyZovB8qUFRWdeZ6zRraej97
         0rr0wH7WEW9/kr+fNUoRnI1V2zvpmnukguSOiF9ISXDQfGa77HCGGCmEeSLuitaUSt6N
         Qp37KTYnsz4KwYUoxwZh6WCm76KlwTnU8MGbKIslBNRSYR1yVvaUVU0O50/19/R7/9kJ
         7ywM/kipaNasKiZia7SVpmvjM6Od1SvVxovPrmbd2wVM7NojUwj7d8bCMoXGjwXXIZv3
         ci3qBJFp8mgdMDvZy8/2Ygah59qVHeDyYscf2GNaReJEAiErjYQUNJI6+/ppygFlADW3
         m1fA==
X-Forwarded-Encrypted: i=1; AJvYcCUTAUUA7mhVb0PXOotaF2AP3MO/XTyuWTkDDaSpQ6UZ2d7T5Y9cEgIYHUXcYFGTRDSva6WFkI5g9go=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPehJ1BrsEmJNeBNrsIlIUby5JAJgbC0zGShGaVWflAhQn608
	sKY3Syp8+1uu81Fqm+TJJYeiprjzfUf4Sf2HJlrj4miS259CKHEJuITbnY2kKU/UvRk=
X-Gm-Gg: AeBDietBlvahDpXPd2QyDDUXspXnN0G3jRsLZWQTB+KLBq7y4GqJpz0XBAu/0MapdnP
	LfhPYCVYSKNTXQDOvVHLauFcHAqIhnm2yxLs8ELa9PbI99r3R0We7b77qpZkybq9cNMmDvuNmCJ
	5k9xuLjM7RFI4b+8SPkyzoh/NU4pMbELTXR8ukECsQ97jsa8BCMZpYCct2Dn+QeM+UP4T6G1MJb
	f/anT+2JgpYIucgMMQs/gSfSOULCMutmVx5tYYlGjvqQLBBWsO6qdyf0TV1i/XyWw2RcGEoV9PP
	WeIzEvDnZr6YB8uh6jiGQdFNL10bHfiSyWd0p1tuoo+TpZ23+btV6g9rqu1Hxj3qMSQHW8rCa6y
	MMjv3PRELGRHAmhIvZBWihZ81z5Yo0g/Z48T8Bn6BPGmeekFGudTYHYDTrY/El6w4dCu0f3YlJL
	Bz/jctIpfzrckewYqKmmKp5K0I/93XoGweZ42Nhx1nL+qwGTxCAh4kcR8qWlPC3xtJ7IAjw8nbE
	w==
X-Received: by 2002:a05:6820:178c:b0:688:6d55:189 with SMTP id 006d021491bc7-68bf7fc8aaamr3342033eaf.18.1775933287437;
        Sat, 11 Apr 2026 11:48:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d2e5:c81c:5b23:fe55? ([2600:8803:e7e4:500:d2e5:c81c:5b23:fe55])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bc7dfa174sm3298516eaf.3.2026.04.11.11.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 11:48:06 -0700 (PDT)
Message-ID: <4c34f4f3-f3c0-403e-bf14-29403ce263b8@baylibre.com>
Date: Sat, 11 Apr 2026 13:48:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iio: adc: ltc2309: Add LTC2305 read delay and
 optimize chip_info
To: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 "Sa, Nuno" <Nuno.Sa@analog.com>
Cc: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Liam Beguin <liambeguin@gmail.com>, "Marques, Jorge"
 <Jorge.Marques@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20260331012457.9324-1-carlosjr.jones@analog.com>
 <CAHp75VfkdmebYjBdOnkqrT87Sm9PR8OehYvPSwwxiY9zq9hfbw@mail.gmail.com>
 <SJ0PR03MB5854F9BE63C740C8EDB18E24F4262@SJ0PR03MB5854.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <SJ0PR03MB5854F9BE63C740C8EDB18E24F4262@SJ0PR03MB5854.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/10/26 9:27 PM, Jones, Carlos jr wrote:
>>> This series adds missing read delay support for the LTC2305 and
>>> optimizes the chip_info structure for better memory safety and efficiency.
>>>
>>> The LTC2305 requires a 1.6μs delay between I2C channel selection and
>>> data read operations - a timing requirement identified by the hardware
>>> designer that wasn't captured in the initial LTC2305 support (commit
>>> 8625d418d24b ("iio: adc: ltc2309: add support for ltc2305")).
>>>
>>> Additionally, the chip_info structure is enhanced with
>>> __counted_by_ptr() annotation for improved bounds checking and
>>> reorganized to minimize padding.
>>
>> Now LGTM,
>> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
> 
>>
>> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> 
> Thank you for the review, Andy and Nuno.
> 
> Hi Jonathan,
> 
> Just a gentle ping on this series, it has received reviews from Andy and Nuno.
> Let me know if there’s anything else needed from my side.
> 
> Kind regards,
> Carlos

FYI, Jonathan uses patchwork, so you can see the status of the patch
at https://patchwork.kernel.org/project/linux-iio/list/.

If it still says "New", then it is still in the queue and hasn't
been forgotten. There is usually a lull after the -rc6 release
until the next -rc1 release. Then things start moving at a normal
pace again. So it still might a be a few weeks before this gets
picked up.
