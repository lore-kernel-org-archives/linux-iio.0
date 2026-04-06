Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803883101C2
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487754; cv=none; b=pApb/SHklt6QuY5tEc8eREUBbU4u78XB4RvcwX/XGE57+01vY/1mhuUCNpZCacmTkEzm/5F3lHTwHjsqI8+NULXz072+8pToUJqxivCDUnatuaOKJqs4eaE2GkW0cPsMyi6L9I6WyJXEluB5QJAYlXJUakH5pT6R3QSaFmenDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487754; c=relaxed/simple;
	bh=Vx0S0OEPsMTxWc2pbFyYxITTLhXEIs8IJVVZZBki8hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEoMAOPIqHixODq7ZZ7CPEAapOtk0lQNk39Q5Y97GzW/raaAFR+sbMJ3PRJomqUzW/25fqKhRIyBupHbpXT/7jIteV6nmep6tmwwOIw6+fIV4JNDDADcwl0IOCDj9DZms218HRSfntr9BeOWFfHoJJhy9D3UJO70CoeafNfjciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=crzihiZK; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="crzihiZK"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-68457156797so722068eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775487751; x=1776092551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOYm5VbuAYu3Ygkfd4vye3tA8nAqOV5PzA2/v5FO7a0=;
        b=crzihiZK3iznSPHdTQNFCTyY9tRwubZfyHEDspKG2XK2CWhL5Yqbd+Fmg/GdZGmMK4
         uFtPptj5BZY8Jq2do2wLwLQAdNRr3wePMLbJoMzXTwfRVUUJ7m3YRACdiJ8A7WQH5cG+
         L4wnVXckvLC/av90wdZ6+L+ItetoVONB2UbRlH+YYsSYvJgFyc5FwiJGYERwGKqYqOw6
         HqEg7pQckRKHVKVIGKAnVO4AzWTD3mylSaPKk0rlmwEs5QfeH84KW0jywgWxIJpY/p+s
         8DC+UNxI3ko2UftMUYUaRNWTjdeXMTxD+A1m4+LtagnAOZqq5oHVloCKwyfqcTPhgvMg
         4nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775487751; x=1776092551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOYm5VbuAYu3Ygkfd4vye3tA8nAqOV5PzA2/v5FO7a0=;
        b=njeJ8v7xgLNTd1ZOjpSfSlX92uzfWpqWpSHEgNE5Hg35XmKn92A1eFcO8KortjsROV
         PbFlD4pVmltWjN/T4UnV424JnAFhwBoAFeVcxBZMsBwje22qXFSxG6LDCUm2mFJa/tXW
         duj7xjKR4A0zKWfF1raGZNhjWFam5W8hWBeQOiim6KyVHSSOf373Jq+Ay3FrLXn1VsXU
         6XEa7tU3HuxUPnvOnGs+/e4jb0kOiw9fLddKzYEE2Wh49HwObD1xqTcukC6eSUHidmZ8
         69ry97v9iRbm1U4oW3huodWj+MDvqzYhNnZNL2RLX0PnJucpnvN2HvTZoBDY0B+DC9c0
         tgSQ==
X-Gm-Message-State: AOJu0Yxz7mJP1JwOZYNpXWPWPHk8V+H04RQvJZ1D3zrn2Pdr9Ltm36Q+
	RLdB0x18HnMSznUMVhmm4uNckwIVmXCNhEcfozUHWI52+Gh3qBI3m0+U+rBbpMe3O8M=
X-Gm-Gg: AeBDiet1dE/LVOjywiaqIYBQcgAXoziq01qsfrFVXcLFINW5el7NaZC3qElLKdkDS1E
	3msBiRApu+Lt6/i8XItWL5dvkc/fEeLKxJW/QdyvQGH4RikQx44UxIUtbOgHZWjw4XZaHsxz1pT
	5iHteww1jgcGUGX0bO04t+LrRREBs4uqANXobC0zauY9IQUzvvZT1kZ05MBDRTPGb5Gy2DxGdpC
	xohHmGXt4kiiHNOH39MGiyV97TTYfBMO4VCiYQWotS6EUh5Y2/h58ATiy7MEzqN90/MF9r49b/K
	702NFk2upCukD71PHSJZTeScM/iaQvTutCpaqwme/SlFYqIpjp1jaPapXVLMVUP4sBQh86BwAfr
	0qiDcBhDeACLITAffwd7Fd8+vel9qR3KfpMQDM/wpdfeNaC7z+amrRuPpwmQZ0z7XxSpRbtwGYE
	rsiKSBF5o3/omApkwopWvEphQPpu8F2oEXk8sqXAL1wNit5YZqzQ7BO1WUWROcyvkqgqfz+pA=
X-Received: by 2002:a05:6820:2905:b0:682:ecb8:c38 with SMTP id 006d021491bc7-682ecb811c6mr6352466eaf.42.1775487751272;
        Mon, 06 Apr 2026 08:02:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:90d7:b13f:c53:8ca3? ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68448c1c15dsm3873975eaf.0.2026.04.06.08.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 08:02:30 -0700 (PDT)
Message-ID: <b2d4ae51-f827-44d0-94a6-2a3db6d681d9@baylibre.com>
Date: Mon, 6 Apr 2026 10:02:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] iio: adc: ad4691: add SPI offload support
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
 <1d0d41c8-7867-4459-a91a-a2c6774b1885@baylibre.com>
 <LV9PR03MB84145906CC191F6AB8D2D3DAF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
 <420dba4a-0c31-47bc-b84a-5d29702b115e@baylibre.com>
 <LV9PR03MB8414CB15DEC3EBBDB8F5FDD0F75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB8414CB15DEC3EBBDB8F5FDD0F75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/26 9:16 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Monday, April 6, 2026 4:44 PM
> 
> ...
> 
>>>
>>> This is bad documentation on my part. "channel byte" isn't used anymore,
>>> this is previous version behaviour. Right now, only 16-bits worth of actual
>>> channel data are used.
>>>
>> Then why do we need the shift if there is no other data? Can't we rework
>> the SPI message so that there is no shift?
> 
> I thought the shift is needed since DMA size is 32 bits, and value comes on the
> upper word 16 bits, not on the lower ones as for CNV Burst.

That should only happen if we are reading 32-bits instead of 16 bits.
We should be able to set up the SPI xfers so that we only read 16 bits.

> 
> Manual Mode layout: TX [CMD_HI CMD_LO DUMMY DUMMY], RX [DATA_HI DATA_LO DUMMY DUMMY]

> CNV Burst layout: TX [REG_HI REG_LO DUMMY DUMMY], RX [DUMMY DUMMY DATA_HI DATA_LO]

This can be split in two xfers.

CNV Burst layout:
	TX [REG_HI REG_LO]
	RX [DATA_HI DATA_LO]

And we could even set bits_per_word to 16 so that the data is CPU
endian instead of big endian when doing SPI offloading.

