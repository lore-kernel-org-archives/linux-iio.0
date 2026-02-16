Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB73285CAD
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267128; cv=none; b=LOhNftuvbsKpvlniSnOOZuAJdUFackfHK6S0nhVUeKkVXAx5zA4hre4M/mqgqr/Pder9wF6mhOYBeJ+aiiN/85S0A+PuVplINZOMby0vDTBlAh0uRMwgUqI03KeQtShXxy9y5IiITy8Xd4/2f374QorksOxBisTpOogg/PPnrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267128; c=relaxed/simple;
	bh=Hga/yI7lb3JU4eP+Zv7hPwnm8zmrz/Hem1JLcJbvYnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBAfFpkqqCKk1/tQlvg9CeOBI5VH378mM6ILFv/djQaoFRSgFHVN+yYWhhTLmRebx6g+z59ppRaSkd3n13uP9OWln5BfFRgXel34GykT9w1h/GifwNJPMZgCtRWnYlWvsIik0PiSV27Qx+T1FU54WQZwq4seTi9Z8jp54vhHpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TG3GZ1kV; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TG3GZ1kV"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d18c654458so1402825a34.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 10:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771267125; x=1771871925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDiQ566T8bkw/d5Doj5hiSSr6BOtEFdXBHTWP9g1Fv0=;
        b=TG3GZ1kV+rFmYYSEa0GTVqjnVGyFI1eOQulX8sS3JUIfJNgvgp7zzCLtD5RD7CNrqB
         q7iALtebS0T+2aeUh6gavtq4G/SfeYTJtBqxKKvrk7k8MYa0E41F3EJReJ2QPTVuF6dK
         r1igJ2BtQdWTA0lKlNxYOf1f5CuRFQaf1G8NgSwzWdJ+EL+VIIVOk+0dHGt0xZhUVbxB
         4vMtIrcKPYKrwkZEnCdXBFujf1ax5B9V1cNQgIQmjdsX69Kir+/Tnr1DHNAX316F4IkN
         s5NS58mpeahc/ItQOp3q7/R8b9Ao0wk6+ahyo+UgKLhUM1rbEsF/1DyXxaF25gqZWN8i
         wpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267125; x=1771871925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDiQ566T8bkw/d5Doj5hiSSr6BOtEFdXBHTWP9g1Fv0=;
        b=Lmi5uMM7LxU/x+kZmvo+kOnalK5fetuvCR4SSJyEGUDGa7PjbXyik1/BSpu812S0oI
         ArottW/x99cuqx1iTrhTgdse9JMJyXNuPXKRX48Yk67lVC9xithNSjDBsXyfSlI8vn1f
         cBKbSP/ATDfL/gVxF1t/9jjVTMRRe1vZgIv7rDOLcX3cX/L9ikDS/zGCPS2rkmfGzRgM
         H8QKSwdJoDBnKQ3WvAwhSxItRVTV25bNIrrz6vWs4d9Z9iXpA4EqXLvYqaUeEXOcnTBo
         PVTOETOXM9RZT8UA4b6Mu0dKxNwdJmQb4M92AP9EBL0Y71Sf/B7rNIDqAdDGYoHBzwXW
         hx1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZg/GXK89stdMz71MTkoIOB7BkJCvODcwv26EeE4NgjO5FFUPKhTJSiagJYsW4MoQpGayFbknsQdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzudGr6ijdZxML/kxO1+5XGQEtSIQGB4ScBSOMqgbdXMSZNmX9l
	H8JNzupHpdgzx7Xe+N7VdZrgPyER5JaDo8nYZyrLQRXJbLhcsSVkW5ZbVsRZyw5/2BuIOIFlAjz
	ZbZiD
X-Gm-Gg: AZuq6aKU7OZD3CcpJ0gHPS1hdNkMLkUUL80BPt/UmcTxNQMzzBvOkz1fToK1I7s1X/r
	xjxmKB54wmRtFgZLVSHemB3Rtnni85rubdDIQ+2hqNrFClXKxbVtuy4QiQUSrtqRq9uDNSbe9f+
	aw34Fvacm2De5Xc1afpsLf+QtjtT7DyRTImNOckYnX3dbakqouy1JT2J+UWnwCp/nE5cvjLoC7/
	V7ID8vszAE/zPdoMUFCL9ENNBg9cohuq4tryeKVolsuJ/X3s0su/MTcjT1LOfSgw1/gTTZMl7QJ
	oqlw0nkFC1wqGYTs/Dd17ScjT2/CZTzkg06ZFK8fpuaYRdR88Z6esQvCpphpZZ+DTRWnbV0sskV
	l3GiK7t+VyIPCn4Ib1IICh8hZDgFairPKsGttcl4pctyxUk6HfI+NBtXiZCTF4BAKTOxtDErb/R
	BDIAdpzOAiX1g93EgtYAXBl8ojuuS2cddjqVvFrkjXa5w9JMQrdZEQFWhGWl4Emn8Y/Tp94utD
X-Received: by 2002:a05:6820:4687:b0:676:778d:dfc6 with SMTP id 006d021491bc7-67768ccc026mr4066989eaf.38.1771267124634;
        Mon, 16 Feb 2026 10:38:44 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:2d75:8cf2:6289:6a96? ([2600:8803:e7e4:500:2d75:8cf2:6289:6a96])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6777c128a11sm6499574eaf.0.2026.02.16.10.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 10:38:44 -0800 (PST)
Message-ID: <623dc31e-cfa9-4cf7-a6ca-5044333e47bb@baylibre.com>
Date: Mon, 16 Feb 2026 12:38:43 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02
To: Conor Dooley <conor@kernel.org>
Cc: Ariana.Lazar@microchip.com, andriy.shevchenko@intel.com,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 robh@kernel.org, jic23@kernel.org, andy@kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, conor+dt@kernel.org
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
 <20260212-mcp48feb02-v1-1-ce5843db65db@microchip.com>
 <20260212-germless-favoring-c27ab4c53128@spud>
 <aY4yaVP2TQFRI1E4@smile.fi.intel.com>
 <a3bab395580cd83410c1c7364283285586c9b128.camel@microchip.com>
 <5818b02c-4456-4484-9443-da7429cea3dc@baylibre.com>
 <20260216-shiny-itunes-00a31d1f4db7@spud>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260216-shiny-itunes-00a31d1f4db7@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/26 11:34 AM, Conor Dooley wrote:
> On Mon, Feb 16, 2026 at 09:37:35AM -0600, David Lechner wrote:
>> On 2/16/26 7:31 AM, Ariana.Lazar@microchip.com wrote:
>>> Hi all,
>>>
>>> Thank you for your reviews.
>>>
>>>
>>> On Thu, 2026-02-12 at 22:04 +0200, Andy Shevchenko wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>> know the content is safe
>>>>
>>>> On Thu, Feb 12, 2026 at 06:00:06PM +0000, Conor Dooley wrote:
>>>>> On Thu, Feb 12, 2026 at 02:48:34PM +0200, Ariana Lazar wrote:
>>>>>> This is the device tree schema for iio driver for Microchip
>>>>>> MCP48FxBy1/2/4/8 series of buffered voltage output Digital-to-
>>>>>> Analog
>>>>>> Converters with nonvolatile or volatile memory and an SPI
>>>>>> Interface.
>>>>>>
>>>>>> The families support up to 8 output channels.
>>>>>>
>>>>>> The devices can be 8-bit, 10-bit and 12-bit.
>>>>>>
>>>>>> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
>>>>>
>>>>> Other than the interface, what's actually different between this
>>>>> and the
>>>>> 47? Could they share the same binding?
>>>>
>>>> If that is the case, I don't think we even need a brand new driver,
>>>> the
>>>> existing one should be refactored to adapt SPI interface.
>>>>
>>>> --
>>>> With Best Regards,
>>>> Andy Shevchenko
>>>>
>>>>
>>>
>>>
>>> I have decided to submit two separate drivers, even though the chips
>>> share similar functionality, in order to make it easier for the client
>>> to identify the supported chips.
>>>
>>> For example the I2C family of devices has: 3 different resolutions,
>>> with 4 different channel numbers available for a particular part and
>>> most important you can get the same part with or without EEPROM.
>>> That means the I2C driver will cover 24 different devices. The SPI
>>> family follows the same pattern, covering another 24 devices.
>>>
>>> Microchip also has some devices (I2C and SPI) with Nonvolatile Memory
>>> (similar to EEPROM but limited to fewer than 32 writes) and I want to
>>> add these families to the existing drivers while maintaining the split
>>> by interface.
>>>
>>> Please tell me if you have anything against this approach (having 2
>>> different drivers split based on interface and each of them to support
>>> at least 24 different part numbers).
>>>
>>> Best regards,
>>> Ariana
>>
>> The usual way we support parts with the same register map that can have
>> an I2C or a SPI bus it to make three modules: <name>_core.c, <name>_i2c.c
>> and <name>_spi.c. If you look through the iio folders, you will see many
>> drivers like this.
>>
>> The _i2c.c and _spi.c files will just contain the chip info tables that
>> contain all of the differences between the chips and pass that to a
>> common probe function in the _core.c module.
>>
>> It seems like this approach should work in your case as well.
> 
> These usually have merged bindings too, right? Only real difference is
> going to be that the spi devices will need
> spi-peripheral-properties.yaml which obviously the i2c ones wont.

Correct.
