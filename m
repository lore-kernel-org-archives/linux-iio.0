Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF32EC0AA
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256260; cv=none; b=IFYIU1gni7ydttZVrUO5ItnlEMY9W0xgp95tunJjcwhY802JURK9duIMIW22XY2K5/mndqqxwrNWbzsAophtn86UlXwMS/kMrIGBJ3LZcY+6/ZhkyrnujFHODA64iTgxD1CWtvUYfgk/RL6CaS+pvBnkVFHu76fYocP0/j9hilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256260; c=relaxed/simple;
	bh=jLE5YYy+MDiih1RJ6gcLTrV1hmCmgEQPsAZQSUozZQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+QvbP7jfUzo8xjHI7WD6aC6FLSCj/y3W/8JJXtx8+4gnlVFhRVH/ssdsW8jSzFLwVhoeUEp/M2d320IveboARn/v9r9Ay/yYy5Vfvpqi+qX81U9Xjqsi/US754I6yGJT4W9KllEuwrJT17S97V0aOE3uekI7uCjuvoGzc7mbL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JZ3JqGMg; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JZ3JqGMg"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d18c654458so1325620a34.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 07:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771256256; x=1771861056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0DKips6ivFwUBeIMB5IKo4Bf8gok8QOHPMtvnL1jZI=;
        b=JZ3JqGMg6U2zz4/X/ScINoR5WJmZALROCPOVUTlk4xaMku/FRN0/Bl9zJ0nZohMfOS
         NhCLYnpp1UF7jKOc8tLWqYK9SQyMcVmxuFmVJctlMBt7Y9iRpALw3+CSSRtGyzTfshA3
         MGV18ROg3zgsNuPRN4He8Sf6N8UI9mKrOky8ZRgTPYu5r/by4ugR8NSt75F9FMBb5++r
         PQcTrONpCIo1B7pmHDtySTtVXfpnNZ0hrl1gJl4Xlba3n6cWkSseTlbPMvbZKdIer3wH
         Wb6S0nYjWn7pi6cYk2L0v/w0Zm7FjSqiiRZbjKYTQhif9Tgygoy5LxWIyu09nipxK2BF
         V+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771256256; x=1771861056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0DKips6ivFwUBeIMB5IKo4Bf8gok8QOHPMtvnL1jZI=;
        b=dmV9VW0YL8t5fww1+IJQho+U5jPB6CWaciEgBTYw6tpM7nN+pS2hLq+/9epvY79JRZ
         oRokKe7XNnDx1gmiMnnDGKgM9mUqyCH+jY61n4DSi8fF8Kkb+ZKf52osxGV+GIbynmfs
         JMiihVeqrVHnHDV2V3YMUV1irUTFSkPxX8Bf3zwJqsN3xMImfTXF6aLAoh7msvjJ0klL
         CTGGnLV7OD7TWnBZ3IHAw3yGvUGew2TtfxD7gAD3QAMfSeTOeNCDJ2Bgjbq3bocw0Y/l
         SAbdDsOhfL9O4fTVwmDRMZ141N6LhwZ6tdPOen8gv6yczCgM5rTp2t9X+NtqBEF+UgZG
         BbuA==
X-Forwarded-Encrypted: i=1; AJvYcCUhq/xvAA1gFxy9LZYHz3IvBvYwujhOv7CjFCVg2Jm6teCcOolcRSDbJzeQVn26UFB56kZF4qiiKqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZZzX4p+lvU9cN8qRzoxE6JfXUuh37S45UkurLalGcoqKSk04
	dALKBBDQtibojqOUV5jXWgJJbZp+oeT6hBfhsasl2DZcDOysM+40zMcc0XLJIRTAr14=
X-Gm-Gg: AZuq6aJdEYiDjYE0noNSY+IyhiSMxnmqp25SHpHFHM7HbaHLP263tRHNJYWqwUP9Hgm
	7nfxwNryMtbA4xu9Xc16oBA4OphvsYQ0Q3rlViKdB/fFKLPn/2w+iisLGpC+Ouc86usNmJoHurX
	y4OnofOvaCPtmvQ7oEXawON1jPXKVHKaKnitZYBeMpLQ6kYxSkxxrh4GcPqG+UihkMktflE6eYk
	EGse1o4FQf3PGceItNzVsBgt3sbgh3JWvRGDNcObC26ODHVfNhAKgmtpCMqjmoIdurpes6N6MNn
	AqIL2X1LL3nW/Xb76BAYo0Qs+XZUUU7Cvhk+TYpFEBOchJWWdrwwnXNEAFIhlyI8GvfY3K/RQy2
	Q2nxQ2XvNbeNpstoq2/ojHeefX3XpGhtMMRIj6KUntl1H2HTHnqONtixHx7eqJdhbMuoWfuqH72
	30gbLxIKE7gypVv/YEJ1iCHmOjZGcjC2j307hPje5B1/3SlK9PLYpJzufKBIZWwl5hMYP9lcdD
X-Received: by 2002:a05:6830:398a:b0:7c7:2df4:faa3 with SMTP id 46e09a7af769-7d4c4b18aaemr5980060a34.33.1771256256446;
        Mon, 16 Feb 2026 07:37:36 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:2d75:8cf2:6289:6a96? ([2600:8803:e7e4:500:2d75:8cf2:6289:6a96])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4bb66a066sm9693597a34.19.2026.02.16.07.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 07:37:36 -0800 (PST)
Message-ID: <5818b02c-4456-4484-9443-da7429cea3dc@baylibre.com>
Date: Mon, 16 Feb 2026 09:37:35 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02
To: Ariana.Lazar@microchip.com, conor@kernel.org, andriy.shevchenko@intel.com
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, jic23@kernel.org,
 andy@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
 <20260212-mcp48feb02-v1-1-ce5843db65db@microchip.com>
 <20260212-germless-favoring-c27ab4c53128@spud>
 <aY4yaVP2TQFRI1E4@smile.fi.intel.com>
 <a3bab395580cd83410c1c7364283285586c9b128.camel@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a3bab395580cd83410c1c7364283285586c9b128.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/26 7:31 AM, Ariana.Lazar@microchip.com wrote:
> Hi all,
> 
> Thank you for your reviews.
> 
> 
> On Thu, 2026-02-12 at 22:04 +0200, Andy Shevchenko wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> On Thu, Feb 12, 2026 at 06:00:06PM +0000, Conor Dooley wrote:
>>> On Thu, Feb 12, 2026 at 02:48:34PM +0200, Ariana Lazar wrote:
>>>> This is the device tree schema for iio driver for Microchip
>>>> MCP48FxBy1/2/4/8 series of buffered voltage output Digital-to-
>>>> Analog
>>>> Converters with nonvolatile or volatile memory and an SPI
>>>> Interface.
>>>>
>>>> The families support up to 8 output channels.
>>>>
>>>> The devices can be 8-bit, 10-bit and 12-bit.
>>>>
>>>> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
>>>
>>> Other than the interface, what's actually different between this
>>> and the
>>> 47? Could they share the same binding?
>>
>> If that is the case, I don't think we even need a brand new driver,
>> the
>> existing one should be refactored to adapt SPI interface.
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
> 
> 
> I have decided to submit two separate drivers, even though the chips
> share similar functionality, in order to make it easier for the client
> to identify the supported chips.
> 
> For example the I2C family of devices has: 3 different resolutions,
> with 4 different channel numbers available for a particular part and
> most important you can get the same part with or without EEPROM.
> That means the I2C driver will cover 24 different devices. The SPI
> family follows the same pattern, covering another 24 devices.
> 
> Microchip also has some devices (I2C and SPI) with Nonvolatile Memory
> (similar to EEPROM but limited to fewer than 32 writes) and I want to
> add these families to the existing drivers while maintaining the split
> by interface.
> 
> Please tell me if you have anything against this approach (having 2
> different drivers split based on interface and each of them to support
> at least 24 different part numbers).
> 
> Best regards,
> Ariana

The usual way we support parts with the same register map that can have
an I2C or a SPI bus it to make three modules: <name>_core.c, <name>_i2c.c
and <name>_spi.c. If you look through the iio folders, you will see many
drivers like this.

The _i2c.c and _spi.c files will just contain the chip info tables that
contain all of the differences between the chips and pass that to a
common probe function in the _core.c module.

It seems like this approach should work in your case as well.


