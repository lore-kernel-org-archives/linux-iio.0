Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA52BEFE5
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114893; cv=none; b=dt3/TFgX9UHkkNgCzRCxfq1lJNsuNj3fymtJ22sze+jqwX9zcYW3hc92p5V2lKlHuqFUkK6K05Kcx/BadToAOMAMVz4NBOF4Q+LYmSWCHNFsBuT+RHZWKM1rrh47hPJvxZyviWpA9u81XF4dDuLNS3deSOo2kPFHStUSqXIQK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114893; c=relaxed/simple;
	bh=RHou1NZeZQJ2nBNPN4Aw2D1HXZfghIJsey4jXHsv5xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYNhDq7/Cmmv0b2xXBa74lmj24nwIdWhxMNfp0/S4c0YTsfck9H9OpMBk05Ui4IQQokEx+gapReoD1kkRW5tBdN29UVcNTx2zhFNPxGouZ+T5gp/g2WB3p1ef0rJje+N8xCZlyI65tUhG83pgIIIy33h8XIZNGw4wYQkmgxTSX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fKsXV2jL; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fKsXV2jL"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e4004a4a6fso2652485a34.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779114890; x=1779719690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R76EEUUYziDn4rTNwghYF5TGd9QqSpO9um+ZkcmBhtY=;
        b=fKsXV2jLOL811+xvlkYGS1r7FZs45Yb/wHJ0BVwZxAOnH+bVbnffG+bRcizN/XZAI5
         bbEHiMtopvGf3WJSDjQmVxFkyjb60ENu1p/rqWfGLVXvAfdxwjcZc8965SMeG1/VSdH5
         EfYkvIdfoIvED/t7PBiQQrHy+8Ac+AUGtgeplZfJO3h8g6XBd0ElD9JTqYMnvc0hwzD5
         lAusEgg8tcJxq6eGDKtI4xba204nE3yRG/IU9djquaa4ZyZB4wBHCLm7Wnb+M69GH0kY
         QW1XTX/qf1Mr6+hE7Wr9KWMR44Wf4QdOkRiwLtvM2T2lcIe6LvzlvpduaM4dgdZpbyqj
         YGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114890; x=1779719690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R76EEUUYziDn4rTNwghYF5TGd9QqSpO9um+ZkcmBhtY=;
        b=pQ085OsZkyunID/B8tdG2rYmlcfohF++UaWVSQv3KC4+MRa0j77yZPXD9Eg3MpKZ/j
         AMgIYQqYX8zYLlG9phEeuzU6Rm9S6sO1rCPN1/1UeRo9s2+p0h5yigTa7RA3ikWxc0Ic
         AIAy6EOCCcjPj7bYOWsmQNSUuFWPj4882qrh154KI1puP6FZkiy1wjjvjFzH+AOwMtWE
         tM/w+LpgmgekQlaadrEvKo9XAtoZoZUbnAlBr+MPM7UecBuT1ZKqSZoP1nBf88oE88u1
         jkagdFUJc0Oi2hWW8QTNKpdQb6tZCUC5DuUw4J4vDCYi5QDdVIZl4qHKRDU0vndWWX9S
         qVTg==
X-Forwarded-Encrypted: i=1; AFNElJ9mFoiHuLIQV7PVaaDo2EbvCMXIc9+gkeoZIQtiforVZqLe+Fmkf2k2nh9VtKufkt/lrLgN/SEEnN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjTUnr9ExP/H2wMkuzkMCDtFp/4byViX+fIdm7+pcSHeM+/6ib
	PdAQJ0I4R3Mnzi/C1WJo7ZmFyWODfNDhCsJXzZnKrKZyE24/oaRIdST6ad8R8vN+jyI=
X-Gm-Gg: Acq92OFFGAn2D22BemwVCiV5DqgukwGfcCmTFQ/QzNZbNlL17FH0veqPnrGbvToxB7J
	mzciOs/GFytjyGc8jzi/VOwLrcONXozixnuycXxu/xWPigoDCWmHfxY6N64YxGNx1L1Lpm88tsa
	HM5eci/Urx1dsLqJ7JZK0234nXtwhl1ll/Sq0H/hscddudDCM+IvP3Y0db+viXK94s+bEytPhXG
	kV/8HpFBHg1UVk0feIxZI2+a1N62wPoJbM/V9uUq6nRP1PgQVzSdsxf0gqaU6OjZ9v7BN1d2w/E
	KnFMli4g2BMwdsNuLcH3ALyBtTb8qmpAjHyl9ukFfg4oRRPE/PW1sQRTGbhnGhUbThOI5XudI1n
	8I2Hz2G0bKy0uClZg1ZTD+tjysooHmVxH8/sJACIvGTLSYoUitm0wJgId1W2vRibcXsJW7myaz8
	LZlrHhVGeDNIqK5gazvz2Ousjx4mDO9gGLM1R+8KHSGQXXZqZnyLDXVBti8CLxqOQqijNK/+Uoe
	g==
X-Received: by 2002:a05:6820:1746:b0:688:2480:7fa8 with SMTP id 006d021491bc7-69c942dac4dmr10442247eaf.21.1779114890563;
        Mon, 18 May 2026 07:34:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3be6:1187:fed4:378b? ([2600:8803:e7e4:500:3be6:1187:fed4:378b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d049384f6sm5675126eaf.14.2026.05.18.07.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 07:34:50 -0700 (PDT)
Message-ID: <41c0317d-2ce8-412c-818a-4a84201fce29@baylibre.com>
Date: Mon, 18 May 2026 09:34:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] iio: timestamp declaration cleanup
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev
References: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
 <agq7PPw0qupI_8Dh@ashevche-desk.local> <agq8Q1wpzIw4XhNQ@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <agq8Q1wpzIw4XhNQ@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/26 2:14 AM, Andy Shevchenko wrote:
> On Mon, May 18, 2026 at 10:09:48AM +0300, Andy Shevchenko wrote:
>> On Sun, May 17, 2026 at 01:17:17PM -0500, David Lechner wrote:
>>> While looking around the code, I noticed that there are a lot of places
>>> were we are manually filling all of the fields of an IIO timestamp.
>>>
>>> This is error-prone (as seen in the first patch) and more verbose than
>>> it needs to be.
>>>
>>> I went with the approach of using the existing IIO_CHAN_SOFT_TIMESTAMP()
>>> macro for doing a struct assignment. This does require a cast, which
>>
>> No, it's *not* a cast. It's a compound literal. And instead of doing this in
>> every driver, add it to the macro (in a separate patch). Oh, let me just cook
>> it for you (I added that to several cases in the past).
> 
> 20260518071349.469748-1-andriy.shevchenko@linux.intel.com

Nice, thanks. I agree this will be the cleanest solution.

> 
>>> makes it a bit more verbose, but we were already doing that in to
>>> drivers, so I went with it anyway.
>>
>>> If we want to consider alternatives, we could make a iio helper function
>>> or macro like the first and second patches did.
> 

