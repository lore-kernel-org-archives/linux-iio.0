Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC494718CF
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076331; cv=none; b=AC7SMb5qiF6flz0Kpxd0nhUmBYsxFEqsNWeEkMFD/WUlbgeZeM8ZyxksNpy+GeeHi3CGVvNzu943zmEYYb73nLkSxvEuMbCd19z4hMRkrkxuIuaKl0Y9OrGAU/eKJeXszSKynMUXkCsIr0oy2z/EE+W4oSOP15RV57q1OiVIxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076331; c=relaxed/simple;
	bh=TwF73I4ajjLYWDOyxKhP4935d9YqmNdNbY7Jf4XSCb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQZDGZ8V5vyc+25SACfLUm/sJIGPB/OPql+vLskK9j/3L9lvOLLQoIUFC+44aJ64cFTS7M2YJjwQZFVnk1jK9Om0gmqGiVIc3TGxIZF+Oz1BDRHTOfKkidtCxEXjQD+/1RKfg1bm4C9sPukyTl8EK6He3LGUBsDr1SzEPXLccLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=i5NOCd1k; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="i5NOCd1k"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8016ab5f277so244430a34.3
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789076328; x=1789681128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TdEmSJjF4d66nV7pT4E9U+BV4p4vFJmFBRk0ViaHxC0=;
        b=i5NOCd1kwtZAR70O/ZCm6dl1q4/scC/5Uta763/1v/+HtAPF6asAuoaFSUzlrvrQ1D
         lsrGMLFvd9Qt/WljoeloD5FKKUuHGrTCJTciQ8kKJSchGYc03WXZmV+3zrR1HTySpFz/
         zu7ZuCzzAdFLaEsy0UlELVmH3zpoLYADLCUuoalPNLqJpYE8rmo7vGqljBoCqRXekL07
         iJfb4GqQFD3AoAD2AQjnTisitFuKw1EBWZq+XhzGzdRfapCh6P8uW5YE/om8MLSdLmlM
         PmnSvTdt4bh83fTAvkejZFrfhPjSh4HfT9qpOfnUhTUasNacwK3INtBuTJflk+ycEeJu
         6h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789076328; x=1789681128;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TdEmSJjF4d66nV7pT4E9U+BV4p4vFJmFBRk0ViaHxC0=;
        b=aAVKxb2QQxBD2CVKuKMBnm8RRrunzRGxFvC+d64QCH3uXufwn3BO7NZ+SVDgLsv4eZ
         pioHxgv7l5Wk1AlcqIQI12JGGn6tSBY7WTBQlF/7O4eubMUW+p/VhhDjF+ehCtvM4wuf
         iM5dbkgh4miiH8CMFa6A22W2jvAuTSaRjWhMSbzuEEE0sv5PZspb/ANyeWJ0x47jI11z
         z1uOtqkUOXLfaUFQUutL1XNXVCigbq9E2dE7Sxpqmb/OaM7YM+g7xQo1Ne28rptK8fz0
         d3K73BZr5Zeh/KRbTilANcJiho9rScwm0A+2PYgpx7KdZbC0cHVWwAMQtaT8i3j1YX7W
         PRkQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/MZQzcmW5QfewqBJUafBmjAkPaLgOOaXshU7hGIldBQZ8mi/P0Cik1zN1sbqEZyF3qw8j8E+4nao=@vger.kernel.org
X-Gm-Message-State: AFuF++k8BQrxjnfr6LaiHOXbKLHsexevDfs1jUxIVb+onBjGY9wOa4ms
	rra8PXQtThwh2+uEakDycAoI3gIXSLLwSFZRKAmNkLptmKE4mU/rbvBeF6HQsJ+9XYQ=
X-Gm-Gg: AYBFou0cyMGRfvMmCrqS7RKsJo3U20iYN5Q15Sv+Rb1RNmoJEe1KxIzyo8SkQsFzFu3
	UGQwtBwNyERuux4W27+syqyflxY/CCuFp3T2diOI8SnWZ1RFa2ji6GFiRwN6EU27rA2cz4HsgFn
	HulwgyDBvvby7V/QISqCp2fRCoV/WRTnUiROcozgqIAXKcM11hTpcyqmb5Ilr0Y9pMt/OvgeJuz
	XfwM2BpErJhEtQkIkihZIRQgbi6LtVwOy0Q8VqT9EQT5N8/5vRP1+OTW+GCZ5QJNBFHQLFSaDvS
	3mn8HyDhh/b/BnobGhAqDnzojW3OOcTQI7Vmu+wmSlrmnUBb135Ok11LZYa9QiL+zk82qkyYTkQ
	w1UZirmptZTCjVXJs2q9wWi/rxQAzkPGvfm+4WHWPGVBSenWA570PB/6o+5AFMG8NuWhEpZQPSE
	qCAXjUb2PaCL/L+YRwkpRZlKHe+VCO5pM64IDNfZcwZhXEYPZS0b0GP8x08WRvvpltR+MIoKVLm
	ALuKeMs6U343ZUiM5B0ri7WQ9Tdjww3/PJG160a/vt100Dd36U=
X-Received: by 2002:a05:6820:997:b0:6be:47ed:f3f8 with SMTP id 006d021491bc7-6c0b5ff5c8cmr733298eaf.0.1789076328077;
        Thu, 10 Sep 2026 14:38:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:fbf1:d0da:69e0:11a0? ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c095e17791sm1189487eaf.2.2026.09.10.14.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 14:38:47 -0700 (PDT)
Message-ID: <0505ad77-8ae8-44bb-88b8-210f5cba023f@baylibre.com>
Date: Thu, 10 Sep 2026 16:38:46 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] iio: adc: add the ti-ads1262 driver
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-3-1dc27e9c0260@gmail.com>
 <bc00d888-9944-4a22-88e3-8f4d7384d037@baylibre.com>
 <DL8IE3OUIUZ4.2SND39L7P03VL@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DL8IE3OUIUZ4.2SND39L7P03VL@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/26 3:17 PM, Kurt Borja wrote:
> On Mon Aug 31, 2026 at 5:22 PM -03, David Lechner wrote:
>> On 8/28/26 1:38 AM, Kurt Borja wrote:
>>> Add the ti-ads1262 driver with initial support for the primary ADC
>>> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
>>> and interoperability considerations were taken into account.
>>>
>>
>> ...
>>
>>> +#define ADS1262_FW_CHANNEL_COUNT		16
>>> +#define ADS1262_MON_CHANNEL_COUNT		4
>>> +#define ADS1262_REGMAP_WRITE_SZ			8
>>> +#define ADS1262_MONITOR_ADDR_OFFSET		100
>>
>> Where does this offset come from? I would make the address the value that
>> gets written to MUXP/MUXN. But it looks like we are using the same value
>> for the .channel, so setting .address to that would be redundant.
> 
> I'm using .address to map the firmware 'reg' to channels in
> fwnode_xlate. That's why I would need to move the monitors forward. More
> on this discussion below.
> 
>>
>>> +
>>> +#define ADS1262_ADC1_RESOLUTION			32
>>> +
>>> +struct ads1262 {
>>> +	struct spi_device *spi;
>>> +	struct regmap *regmap;
>>> +	struct gpio_desc *start_gpiod;
>>> +	/* protects concurrent SPI transfers */
>>> +	struct mutex xfer_lock;
>>> +	/* protects channel state */
>>> +	struct mutex chan_lock;
>>> +	struct completion drdy;
>>> +	unsigned long clk_rate;
>>> +	u8 dev_id;
>>> +};
>>> +
>>> +static const char * const ads1262_device_id_to_name[] = {
>>> +	[ADS1262_DEV_ID] = "ads1262",
>>> +	[ADS1263_DEV_ID] = "ads1263",
>>> +};
>>> +
>>> +static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
>>> +	{
>>> +		.type = IIO_TEMP,
>>> +		.channel = ADS1262_INPMUX_TEMP,
>>> +		.channel2 = ADS1262_INPMUX_TEMP,
>>
>> Since these are the same, I would just not set .channel2 and later say
>> MUXN = spec->differential ? spec->channel2 : spec->channel. Same applies
>> to others below.
>>
>>> +		.address = ADS1262_MONITOR_ADDR_OFFSET + 0,
>>> +		.scan_type = {
>>> +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
>>> +			.realbits = ADS1262_ADC1_RESOLUTION,
>>> +			.storagebits = 32,
>>> +			.endianness = IIO_BE,
>>> +		},
>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>
>> Where is SCALE and OFFSET?
> 
> Missing.
> 
> I'm pretty sure I tested this channel though so maybe there's something
> wrong in my tests.

I think it was just added in a later patch.

> 
>>
>>> +	},
>>> +	{
>>> +		.type = IIO_VOLTAGE,
>>> +		.channel = ADS1262_INPMUX_AVDD,
>>> +		.channel2 = ADS1262_INPMUX_AVDD,
>>> +		.indexed = 1,
>>> +		.address = ADS1262_MONITOR_ADDR_OFFSET + 1,
>>> +		.scan_type = {
>>> +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
>>> +			.realbits = ADS1262_ADC1_RESOLUTION,
>>> +			.storagebits = 32,
>>> +			.endianness = IIO_BE,
>>> +		},
>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>> +	},
>>> +	{
>>> +		.type = IIO_VOLTAGE,
>>> +		.channel = ADS1262_INPMUX_DVDD,
>>> +		.channel2 = ADS1262_INPMUX_DVDD,
>>> +		.indexed = 1,
>>> +		.address = ADS1262_MONITOR_ADDR_OFFSET + 2,
>>> +		.scan_type = {
>>> +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
>>> +			.realbits = ADS1262_ADC1_RESOLUTION,
>>> +			.storagebits = 32,
>>> +			.endianness = IIO_BE,
>>> +		},
>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>> +	},
>>> +	{
>>> +		.type = IIO_VOLTAGE,
>>> +		.channel = ADS1262_INPMUX_TDAC,
>>> +		.channel2 = ADS1262_INPMUX_TDAC,
>>
>> Hmm... a differential where channel == channel2 usually means a shorted
>> input. TDACP and TDACN can be controlled indepedantly, so really are two
>> separate channels.
> 
> They can be controlled independently but the user would have to define a
> common mode channel for that. I went with this because its only a test
> channel and we making these channels static. Otherwise we would have to
> allow the TDAC channel in devicetree. Would that be preferable?
> 
Sounds like Jonathan is OK with it, so OK with me too to leave it as-is.

