Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5713FAE19
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654634; cv=none; b=H47saKDyJ+DH6QEaJJgQ7mN8O8VBYCrRLKGnhwPYJcp71mPrbzg72o4BuF6UnKCoXZj92J2H02O8dS/6G7rxf6raGEPtXJVpEES4kkY7NQ6izr9ZIXVUxQifbcrGq4HRf/qhx0E3gw3BzbHL9J9tr30yc7rTqEXZfmUaU/XrOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654634; c=relaxed/simple;
	bh=QFInQJXondlUA70nRR+VYLFa+WvVwFUjN0rN7mFQJiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2TBvwSDtZfuDTWmfaDuWoMJ3qjuzfwafpUcLt09vL9J2CMcldReLqk1FlIrf1rdPK4/7jPvWxlDFYNfHDeULX8/Ndb6B7aiQA513V1dx7SM8D4X2fj9xMTWS0KCGJpUcYjJfHWOAF+W5QakSVcYYTmFQkwkYgCuDvNcOfh6ri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/Wc1RY5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/Wc1RY5"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c214e625259so692937766b.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 03:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654631; x=1788259431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UviVHg4iRcsv0fdKQmMFuzXb6W/9vw8IV+1dqwY6Nl4=;
        b=a/Wc1RY5XNJNyi9xtalA395JKQG+d/KRFLbhD3MT26pBIykJU04GXtl4wMSgGelycJ
         zAS6WKB3joeIIDyOe4rCBaxAPG7DIrUOuh/85cYs6Ksp/0l16Slw7xqde576FqGeINxH
         w6cxm3yK090PL466jRpAbgXTzZuvmv5bXfKrJbDPhTKl8Xd3/i8KyoDSy8jQl8MdzRDr
         nw2SpeA6Iza/3I/5fojrkDdUffa95lLQoJRf/hrx1YdEqpGTczUm/suVmYMnVu+Z9H4v
         ecciR3KkNTFvhSLlkRgd1oi1se5GyGJvs2YkvWiRyC1lbw0FPrJ3YfffAx5968bVjzAv
         Zeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654631; x=1788259431;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UviVHg4iRcsv0fdKQmMFuzXb6W/9vw8IV+1dqwY6Nl4=;
        b=NkBEMaeiwn892Wjj0mn2HQ902LXdxW25cPwwCewvPggN2fokQ+9zY/bJ++WvJQWo/K
         qU3TV4HTGodMYEAA2HwePZNbkJKj7lqW+ltg2/vXUJRnfe/8HvdF6rkOFz7QvxG4i9+z
         w+OjUMnffz7Gr0VZlHPl4C58k1X7KyjRTwcZ+5R6PC2jzqPcZgjWxh1rfWy2NA5SkXXV
         fHP7WKRYhwT2yUx9qB7NSTE0XmlxSg0x+plQDbwzfiaEtJU7XAyiFpPBOxlBIx316eMG
         8UgKu8V5flN/dhnO4cXWUN7nKYCyWgdhwPqu5kH4G3oRw5hiCMPUfDxmuB3EDyRQuLI7
         w+cg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3UV+V00sMRj9fAPXwN44TrBwuhY2oFptWIBCMI6GRNRE03Oc838mgkMFe/PkYTAt4ebNeZzHFWv4=@vger.kernel.org
X-Gm-Message-State: AFuF++nti3mpWqo8VRqkR+zC3jSQj3t2saGoaGtrreQFokJN9Sng15Te
	hUEJFEOEw/OwU71SdRuOQksO5MqS2puYzw1dW50jrk4W5mwmGc+naJcS
X-Gm-Gg: AR+sD10EVPlN2rxy38m3tlO7mEZfc2AKnq4sHIpL7+QNw2cyQ95UOvCLz8u8XNDlm9R
	4+NqZxQxQPycGyRMmANgWRs/APFhyJc5eFZR28QfBgbihwSrcOBR5G12J+JQ9J1c7BdainupMWT
	vVM1cfDCwvP7qX0ZFjQJUNhv8qgRvK2sGe8OIroJedcJZ5trpq79E9Dm3LPA+7DNEs+8GJyoHU2
	5GIKInmqXRqTZ+4IS/FCI42krVhmswD7VDNvawjMIy8QTiMUBJ3RkizQo2+osWKh5sMLIW4abKQ
	TFR37GlUhp4F6DiaOdkzR5/7hlQCScMjFxZM7y+ozb8Es6qwnkhFNt66zWUj1rc6YbrxF634DXg
	F5mmZQ27Mc7KHTXulwgMjSX1+f81lQA2CO2M3rbH2c0NkHe9sNDRW8PVPsvhtQLz1FIUHI5iEzu
	BfckKjdxL7gJQXcuVdjsddmWEJdvsdhPIsZbsU5TyNG+BHqIjLJXI5fB09qxSD8VOdjfrqEQKqx
	PcXv3tef4ZFgvQ1b6B5N6+HHqbgkDGXCVHbG1uLmQ0FBEIyC0Mmv474
X-Received: by 2002:a17:907:8995:b0:c24:4128:c19d with SMTP id a640c23a62f3a-c24e584dc37mr540823866b.4.1787654630510;
        Tue, 25 Aug 2026 03:43:50 -0700 (PDT)
Received: from [172.24.138.145] (dynamic-176-007-058-112.176.7.pool.telefonica.de. [176.7.58.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1d741asm13240282a12.27.2026.08.25.03.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:43:50 -0700 (PDT)
Message-ID: <79c44439-86a3-4eba-bd6f-44423c59c17d@gmail.com>
Date: Tue, 25 Aug 2026 12:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/14] iio: adc: Add AD7768 and AD7768-4 core support
To: David Lechner <dlechner@baylibre.com>,
 Janani Sunil <janani.sunil@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-5-bb8fbd06d4eb@analog.com>
 <10d575af-2a2c-484b-82b0-0a00de1c50be@baylibre.com>
Content-Language: en-US
From: Janani Sunil <jananisunil.dev@gmail.com>
In-Reply-To: <10d575af-2a2c-484b-82b0-0a00de1c50be@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/22/26 19:30, David Lechner wrote:
>
> On 8/21/26 9:06 AM, Janani Sunil wrote:
>> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
>> Configure supplies, clock and reset, use a custom regmap bus for the SPI
>> protocol, and parse the enabled channels and input buffer settings from
>> devicetree.
>>
>> Connect the converter to an IIO backend for buffered capture with CRC,
>> provide a fixed safe wideband sampling configuration and add runtime
>> power management.
>>
>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>> ---
...
>> +static int ad7768_regmap_read(void *context, const void *reg_buf,
>> +			      size_t reg_size, void *val_buf, size_t val_size)
>> +{
>> +	struct ad7768_state *st = spi_get_drvdata(context);
>> +	struct spi_device *spi = context;
>> +	struct spi_transfer t[] = {
>> +		{
>> +			.tx_buf = &st->d16,
>> +			.len = sizeof(st->d16),
>> +			.cs_change = 1,
>> +		}, {
>> +			/*
>> +			 * Register responses are delayed by one CS frame. While
>> +			 * receiving the response to this read, the device also
>> +			 * decodes another command on SDI. Repeat the read
>> +			 * command to avoid sending an unspecified dummy
>> +			 * command.
> Could this have unintended concequences? E.g. register writes that have
> size-effects, like reset or clearing status registers.

Repeating the command cannot trigger reset or other write side effects. The device also does not have any read-to-clear registers.

Thanks,
Jan

