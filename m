Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F66429024
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380161; cv=none; b=GbWwdeS5svUo8qPjMQPOMAtj3D4Dg9RG35iyeMpQ17ww/ssG7wRXYiyqkjZHydeHwbcU+H9fbgfm7OjPT2m+5D/4Fu5WktHsnQanW9n8eayAR03NRJDUsJxOrJ7HPfXlXIBZGd42ZX0i+hk5sWUfrDCGMcfeS1ybxzUg2mKHtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380161; c=relaxed/simple;
	bh=BHyJkKWPtabg9chKvlw5ajLWZWczWFC02vAW2qDPPtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7l1UnUSrMI/v5M+IduVIhi7NQCh8X/ndO2r6CxpERDWphD9enuwsuKx6CvU9fhfh/x0IIglCYA6TZPmCA20VYySboib+iDpxDQpesjimJEaDbdatiT9qZCtf3boC0SgqK0anNvgvgM8ON8piBBqGhjI/DdWV3Z7wTuxzKMwhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OTcBvOkb; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OTcBvOkb"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ee4399c3abso1266265a34.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786380156; x=1786984956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MH5p5bgeIASO8oIGcJrEMux/A5GCFedD9u/VSUjCZzM=;
        b=OTcBvOkb9/qG+lSWL2VHfpGH8kWkXmgR67QGvpX79BL/8675QAMuvnraG87EFPua6Q
         g/wgvhgylk+JVQ6Ac9vu2GvKjE6RAQfO3NRM0qUoSbuQkfJuvu+rVKIJ/n14WkxiF/c+
         fYw9/25CcyO505609HjOkYpMdRVI+tj7nlR2BEpn+0RxYZx6bZ/hbLEz5KSOg5p40QiS
         z6OrsJ1uRklWZGLCp7yHQvKZOPFcQXvtzjJbawcwhn3xyk+c1jiZT4BQyXIkQQurwVMQ
         uvhfWmQ1gDwxjSlW3sZ9OnuCEFlsNoE+3e7mMduz7l06jA8zxOPSRMRXOCDiq7M627yF
         aMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380156; x=1786984956;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MH5p5bgeIASO8oIGcJrEMux/A5GCFedD9u/VSUjCZzM=;
        b=SHMdL096uT1pvQyljK//YgRLeJmYMrFX1agvu1FQV9n/YG8CGBIDKrhzvQCdl24MNZ
         Zq1E3F7cDa8a+8+C0S3SKG4bAnN9B7d5PX0ec6+8FabdsjXWXAgE8atUIxHP7VZcVjRG
         +s5sKR+n4++A1gSODedr2TFduwSgllLLqIJKG9W3lucFQ63yWJqf2hR5IzUdIr3TBNH0
         awgizEaLCT9gZBdkTGokYDv1TiFGems9dwlidGj+UDeMH/avnLD3izr5PsNK0lczF0Ha
         GjLUqHvtpzmCJuqUfsPRqLonk3C2pQxbEtA0sAwLxgPG9TWiFzwUHDqbe9FY1mDRcxsp
         N5dQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHyKED+FWNu3It6vFoSdpXgIG5zDEPK00wb/QTB57cOzWy5vc1zvHruPJEIqgRgEVXupskeVCnW1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZS+buHxj514zFt6Aq25rokz/dWfgpzXA9wcHImgxQyQHAjJlA
	El+jj/+nxftHxcKuIhVSH8Ooa+uu1VpWVYbmtbT+mQXkXI5JqTHByZU2iPbPPPoQNok=
X-Gm-Gg: AR+sD13QCchQfA9ffh0vreTt2D8nuO+51cBWhzTLnnbZIPhtbYkSwKfIVCV7ry48Y2a
	yXrxQxDIpIAl+ChZtjNbbapy4P5BBEYHFLR+IrL/3roMqeTryTBU24CE6ZyKPvPaMr9ENJfaoZO
	EIyTErzJWmL510sdDmVA4NETI2C5SexF5QHW6EUozOez69LEEalXvxgJ9ouyYEJfmZoCue2AZBS
	bBB6mj7ExSYb6GIkl7oot6cnWKlKFICmwIL19Tzk0mbwRh4M+zd13M7CZ1mFsiH649Cdee3J2K1
	jAQJTDubBybIhZkyUiOQz222zY23ZZ1jbBOqyX3UsI0vO7y/LyxqoweQA9wLNqhHqW2kMKtTtgm
	52kjLwxnJVW4NdxEcgq4rRctnHuYGajVABJbHdEmOMrzFF+wTenQUKkWAHsDOmlzn5D45cs1gbO
	pIioB95GOyocmUuWSVltk3HkPWLQY4t5o4gpPUtuBKwA8McysVdqr1l5o837afT+/2WNR5RlTWg
	gwy+nzga8ndDPGdk1frWI/+D0/i/plT5NfcjcM=
X-Received: by 2002:a05:6820:1c8a:b0:6ae:5250:dd1c with SMTP id 006d021491bc7-6b035366c4bmr12452912eaf.29.1786380156501;
        Mon, 10 Aug 2026 09:42:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e05b:7923:cf50:e4cf? ([2600:8803:e7e4:500:e05b:7923:cf50:e4cf])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0512521a1sm5971037eaf.5.2026.08.10.09.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 09:42:36 -0700 (PDT)
Message-ID: <7a42a318-780d-4bd0-baf1-55d030b39233@baylibre.com>
Date: Mon, 10 Aug 2026 11:42:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] iio: adc: add the ti-ads1262 driver
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-2-f89925d72792@gmail.com>
 <ad95afb4-e667-4290-8878-fdd7067f20fe@baylibre.com>
 <DKK9QWYHOBOT.2VD8XMZTE65H4@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DKK9QWYHOBOT.2VD8XMZTE65H4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/26 3:26 AM, Kurt Borja wrote:
> On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote:
>> On 8/7/26 10:58 PM, Kurt Borja wrote:
>>> Add the ti-ads1262 driver with initial support for the primary ADC
>>> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
>>> and interoperability considerations were taken into account.
>>

...

>>> +static int ads1262_dev_reset(struct ads1262 *st)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (st->reset_gpiod) {
>>> +		ret = gpiod_set_value_cansleep(st->reset_gpiod, 1);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		/*
>>> +		 * The RESET pulse timing requirement is 4 clock cycles, at the
>>> +		 * minimum clock rate this is 4 microseconds.
>>> +		 */
>>> +		fsleep(4);
>>
>> How long do we have to hold reset before the chip powers down?
> 
> For power down 65536 clk cycles. Less than that is simple reset.

How long is 65536 clk cycles in microseconds at the fasted clock rate?
Hopefully won't accidentally shut down the chip here even if fsleep()
goes significantly longer than requested.

> 
> [...]
> 
>>> +static int ads1262_wait_for_conversion(struct ads1262 *st)
>>> +{
>>> +	u64 max_lat_ms;
>>> +	long ret;
>>> +
>>> +	/*
>>> +	 * The first conversion latency is affected by the channel's data rate,
>>> +	 * filter, the configurable conversion delay and whether chop mode
>>> +	 * and/or IDAC rotation mode are enabled.
>>> +	 *
>>> +	 * The worst possible latency is calculated by taking the lowest data
>>> +	 * rate (2.5 SPS) and the sinc4 filter. This gives a latency of 1600 ms
>>> +	 * (Table 9-13). Then we scale it by the actual clock rate and multiply
>>> +	 * by 4 to account for chop and IDAC rotation modes (Equation 20).
>>> +	 */
>>> +	max_lat_ms = 4 * div_u64(mul_u32_u32(1600, 7372800), st->clk_rate);
>>
>> These are constant values, so don't need mul_u32_u32(). Also, given the wide
>> range of possible sampling rates, I would include the current sampling rate
>> in the calculation. No need to wate 1.6 seconds for something that should
>> take a few 10s of microseconds.
> 
> Can we leave it like this until I implement the settlingtime? That way I
> can calculate the actual first conversion latency.
> 
Sure. Just maybe mention it below the --- in the comment message on the
next revision to remind us.

