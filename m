Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11AC3630B0
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019936; cv=none; b=IZskEZobrp8jmtp4wXXbmz8b0jfTLOFAnOuCRIZ7D61UHMhUWAH9dntAlEeHYKHpKnj2ZBmEx+kAL5LCjYoBmsuWzOA9pmWdT0L6sDpYEmkCXfS0mSyzQGPaL4AJarlhZrKxWKtenSKc23pNptmcB1PGKS8nQ3rljeBrIplz6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019936; c=relaxed/simple;
	bh=Pd/hnVKuluDMGXFrmK+hPDJ6CozFH0uTu02gz7MUWBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjwKxOnF/JRTRC6bgNT4fW0x/i0bBzf/fHc+RxPx3VN2tBpeEnKUMxykhyPlLFlU3QUXhXNrXzAt9Tfh/agPWq29moL2btCwJnKqwHg8G+H2MTQghFSxPjxaiL8y50l3kSijdnWABs0Jscs6XjcHurNiWyymztDzypa2kblB3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=hjC+hqwe; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="hjC+hqwe"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dbff06e4a6so3622779a34.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776019934; x=1776624734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fys629eMO179bbNIA9Bgqf2+pU0BIPxhSDRjIB2+TI=;
        b=hjC+hqweer1c503LY4v2CrRg3RNNLOLlteF31ZA+iJRx3xwk77m/TNgptp+IjfoDsT
         SJaoSwQ1//2HL+oUbIo5Iwqht5HH41VwIhWEVde+NTJmrwzoqImA+O1EUtwf4II45hYu
         C0mucamE0qG08ORqPezabOWMKfNP56sIYE8tCkhv1gCBxxOYezmBHTzpb8ZHjXHt6PkZ
         S1/C7V50rScloO5A9GCIBqTDwVvUzNMvfm0/wrf5QR4+R5uHkfyEGgWBFC/PcAIZBqZw
         mLbPXUBVkwqSAuXn0SAEoilp7KYnLVw4rWBqPozu+NDZRrYYDL29FCnF1pKILQBjmHhu
         dqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776019934; x=1776624734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fys629eMO179bbNIA9Bgqf2+pU0BIPxhSDRjIB2+TI=;
        b=XLTvUQ4cofaGbEkZlu+tj8ms6taMJp5u4lEtKagmLM6ld/co2hSN3KPHhRMLqSkt8k
         bT4xCjrkiPL705uLGSXNF+PiVBuzXsV0cQ1oGB9X6mX13bPjyMuv77mhhi1I7EorCsvd
         nvn27qH4k5mm2qhGMABxN8I8oX4NjpTm+9mOST1uuSWqElOfeHUAZ3jtIelpKUN+nbH7
         YSP6ogHrgAu/k6K97w3PeZrndnmAr/1XQ14AyCVQT/EuQhU/7EJgP0ZXdBeMHbSmqa9x
         L4SGRkM9ZCDrlVZDXlFZadDbq0/5DzhmK1nXx2rlfzfuaxPuq4s04IhcPrG3tgyWLArU
         a9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVbtc49azwVN0+/TeIzR8fku6ZBOMzIr99epwTovZlQ7unSGnF0KXsSK4hoSMA/FLq46P/b9KxIdMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxumjEy9oE8TotH3IRs1dFpH9EcyprBhyk8CicqLxBJTxhvAW1d
	oJBVoOUcT890UZLRSzgMdCjwhYNWnQzDH51f9GdMrp3xnFYyw9jfVYrWuuE+1P28acc=
X-Gm-Gg: AeBDieteMRhXDnBb1XYdO3GAtpt3ltL4jFgo0DInUYvrRfyNxadjhbRI7Rg6bNsS2pq
	4Na7miGthG87zqe8e0r91ZQxA8q4WixQwoswMsBE+dRc64vGc5Q5LMMxoiC7CzzOBY869400APB
	adJstHVq9HbwHh/rFTnL5GwWNQc529w30KBllpjZO3LuvV5oG+0WQ2lvG4oVWZK5YbSdQ90YGRp
	epxtxZ+tL16DL1Ext5WgHVGiXaEj0gIXawgAUxXOuKqetl/NoYtS9OteTk5RfB2YbttZJJI6TPs
	2emxjgdH4Y0UMYFha5kPDgiTnuhC+fDoRvrDHsENeHxpigzom8YcESyGDS92qgLgCqv008lfnQI
	vCoiAsvFqXteUacvoE7Cw5cXCxGg+Y1RPrnZ/Fa4eMuJrF/BUJ0cnwgDLI4hso78xNYa2mY4Fce
	tIjahdrOjQsmhIk+rWM0HJmKqAbgWbJSFTJOxbYVAcpILkww9wHKe9+si8RVftQnCcAvSRlLius
	Q==
X-Received: by 2002:a05:6830:4116:b0:7d8:7d95:fa59 with SMTP id 46e09a7af769-7dc27a28405mr7191572a34.0.1776019933611;
        Sun, 12 Apr 2026 11:52:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5c13:5a8e:1b91:8035? ([2600:8803:e7e4:500:5c13:5a8e:1b91:8035])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26965485sm6752348a34.22.2026.04.12.11.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 11:52:13 -0700 (PDT)
Message-ID: <2d966423-52b5-4b8a-a4d1-0edcd93a841b@baylibre.com>
Date: Sun, 12 Apr 2026 13:52:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] staging: iio: magnetometer: Add QST QMC5883P
 driver
To: Hardik Phalet <hardik.phalet@pm.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Brigham Campbell
 <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20260409210639.3197576-1-hardik.phalet@pm.me>
 <20260409210639.3197576-4-hardik.phalet@pm.me>
 <736964f9-1e93-47e7-80ca-1a89f239a353@baylibre.com>
 <DHR32TA81G99.14OO5FKEDU8CB@pm.me>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DHR32TA81G99.14OO5FKEDU8CB@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/26 4:54 AM, Hardik Phalet wrote:
> On Sat Apr 11, 2026 at 1:32 AM IST, David Lechner wrote:
>> On 4/9/26 4:07 PM, Hardik Phalet wrote:
>>
>> This is a little bit much to review all in one patch. Could be nice
>> to split out power management to a separate patch.
>>

...

>>> +static IIO_DEVICE_ATTR(downsampling_ratio, 0644, downsampling_ratio_show,
>>> +		       downsampling_ratio_store, 0);
>>> +static IIO_CONST_ATTR(downsampling_ratio_available, "1 2 4 8");
>>
>> As mentioned in the cover letter, we'd like to know more about what
>> this actually does. If there is a good reason it doesn't fit with
>> any existing filter attribute, then we'll need a patch to document
>> the sysfs ABI as well.
>>
> In the device datasheet, OSR2("Down sampling ratio") is mentioned like this:
> "Another filter is added for better noise performance; the depth can be
> adjusted through OSR2". OSR2's defintion is called "down sampling ratio"
> in a table. Nowhere else. I didn't know what attribute to map it to in
> this case.
> 
I wonder if there is an application note or something that explains it
in more detail if the datasheet does not.

We could always omit the feature if no one knows what it actually does.
