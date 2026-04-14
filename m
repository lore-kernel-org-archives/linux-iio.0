Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C463E6DFB
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181695; cv=none; b=n3Md9T3OlA8lAR8BA2EVdHS6yZqNOQsaJgBIBJgaC0DPh1dSCoPuFc5dUVj03W8VnmVPKUtYSB9srLgE2/yBlx2eHRWJnYKJKLiuQrWCCEYNGeal3HAYno7PofuXezO1BN3Zke1snDr6jKCyl5ZFSWJhX9JTG/Q5U+m6FHwlTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181695; c=relaxed/simple;
	bh=ikNeOhmOPowGIBwTP2RDR/ooE3V0oQJWo5zR1OOYVA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQfB7YC47QB3vjz+EHrmrc9Q5cCf757G5r8/dU/b7XwcW3M9n6itKxpzZckw+eWL3lHRNYgFOqGNtK8rWRib9YlQmPiIf4vNdLG7U96nn1mHc8DxSsN1OWfyilMc4BYkU2sjRFTPyCuxBCEJQjLQ/ibNWugOYOtSGpf29CmFjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=pXmNRxtP; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="pXmNRxtP"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40ef10ec84cso4039732fac.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776181692; x=1776786492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1qpwzTA4mcNAyi8583h1bBEahEbIPk2eqNHcWexf+0=;
        b=pXmNRxtP4DpCN3oDJYSdy5qpfIIxDDGaYMJKtcp1h/+fVgJfyhN/PJT+LwGDukXbGj
         sxOMYAdtPverLqtSSynz4HwvOmHhR7BhIndvuUvINUXpV6NyEIZGj3G1gMBjDHNq9dhE
         6uIqmerQT7H9/FTx2a1AR3z5PRjpjT6VLc+PkjRAn/n+rGp+Wx8ZjaUzuNvi46/9OoVl
         IJOU7+S2uPB8HShlti08hyxW6pqIlbR1qsVWdTJlo/l6GnO8Dvcqen09nfzbLBNoWIIa
         wijDs+PDTgx0IzuGikpPYwpNxG1+8zqH+flZamX9Og5QAAD0t9bIM8cRTcJEMWK6fEpP
         aslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776181692; x=1776786492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1qpwzTA4mcNAyi8583h1bBEahEbIPk2eqNHcWexf+0=;
        b=nTnlNAvDY/RFo8XBy+YS0pYaFU1BV/srgquk28JFZchAu/TeQj8TUWqIH/JTki1V8F
         TCmwRg1w1yZWGPLOjoLY77KG4SM9Lt9d08+Uq3WLNBRFBb5IfmimBLu60pODt9Z3rCil
         u2HmHvAo4H++GEbPhf9miN3sPQ7PynbNJ8ERQTB1EJsLDZ89smkYvUYQZ/jplHdCVkWa
         ufGASigE8ncBnR4t/Xwxcj+WonAVVy57rGiPjsOKWhqe6i1rYdIPVn29HoZOnZlxZHcW
         8tkM5YFgCOcATaE6pYuP5pEAgLbLqyHUkInVJ1yA3jIK6NV+jTiKeANKrRrhgNdjkgY3
         7Slg==
X-Forwarded-Encrypted: i=1; AFNElJ9SC9rgsDWkls8gXeYPlQNABihWRn2P94NX+N2act0HvHGgDmljEyb7hlG7Ki2T1lnaxvCoBxe8wrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvbgaLzOaHQa6FC4rQdLq1eEu8BKqGiVKij6XYjuOgcTIPZa7R
	VCBOAdOiD0Aff1ynqHP+NjlUFOPtnlG+0sn0exyT4QZqgMx+ps6WxZlV/GZ9LlNwyII=
X-Gm-Gg: AeBDiet2EdldmoC6WKNdbqh0t3pNN1vtLOo1gwcCyrOQyluKtRLomBF5Se9RWZ2AbB8
	4/gB9w28K7Ogl9CDhVkzpEuf066lJeqWoHyXnDSi1RnliJjFcYMpkNIYkZxxL6W8K7ifM3KcohW
	Nep04gXQX6wCoGRZYECji42OFcjFnkC9ZS6ZLRwUc+WVAIFKYTXYiBJoVYOtMhWAzJRM/pU1NxD
	ff2PBHov2Ll8uXeVCtUbdoR4GekEjW3yHbD2qFYDD8c/q/hq7zWwqoYyJ6XDiuHssxRGMvJthZU
	NGqT1YLCduJcXUm2hd5u3CbPdsNb018F9FghT1cxZvw3j488SEEfZBqgeBixi0yRcXiDXQEd3qy
	d7Cqz6Tyx/ln+OKCCIWNWOrvqnwhfxQI8vAfmpdL/9h7DAQBQa0BXxRD3kXxwrniC69lqHl7YcA
	fivrBjqb4oIh84sCISaMmk7knn1hF9ebPO+cMFeo99riUbEpl/RAuEu+sThbMRZVhPOC7k+WeP1
	w==
X-Received: by 2002:a05:6870:ac87:b0:41c:4c93:4234 with SMTP id 586e51a60fabf-423e113e7bcmr9431171fac.35.1776181691738;
        Tue, 14 Apr 2026 08:48:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5bfd:a817:5527:c417? ([2600:8803:e7e4:500:5bfd:a817:5527:c417])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dd42130dsm11757546fac.8.2026.04.14.08.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 08:48:11 -0700 (PDT)
Message-ID: <16816b5d-2316-43be-99ca-6b54d4326371@baylibre.com>
Date: Tue, 14 Apr 2026 10:48:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: dac: mcp47feb02: add MCP48FEB02 SPI driver to
 MCP47FEB02 I2C driver
To: Ariana.Lazar@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 jic23@kernel.org, nuno.sa@analog.com, conor+dt@kernel.org, andy@kernel.org
Cc: Jonathan.Cameron@huawei.com, Conor.Dooley@microchip.com,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
 <20260403-mcp47feb02-fix2-v1-2-da60c773550e@microchip.com>
 <1e05b8f9-e95e-458d-9179-ac8268023ae5@baylibre.com>
 <4b289795ffe7ce3505087446a5f2aee053ace561.camel@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <4b289795ffe7ce3505087446a5f2aee053ace561.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/14/26 10:28 AM, Ariana.Lazar@microchip.com wrote:
> Hi David,
> 
>>> --- a/drivers/iio/dac/Makefile
>>> +++ b/drivers/iio/dac/Makefile
>>> @@ -54,6 +54,9 @@ obj-$(CONFIG_MAX5821) += max5821.o
>>>  obj-$(CONFIG_MCP4725) += mcp4725.o
>>>  obj-$(CONFIG_MCP4728) += mcp4728.o
>>>  obj-$(CONFIG_MCP47FEB02) += mcp47feb02.o
>>
>> Shouldn't we be removing this old file?
>>
>> The patch series would be eaiser to understand if it was split into
>> one commit to split the existing driver into two files and then
>> another commit to add support for the new parts.
>>
>>
>>> +mcp47feb02-objs := mcp47feb02-core.o

Ah, I missed this line.

>>> +obj-$(CONFIG_MCP47FEB02_I2C) += mcp47feb02-i2c.o
>>> +obj-$(CONFIG_MCP47FEB02_SPI) += mcp47feb02-spi.o
>>>  obj-$(CONFIG_MCP4821) += mcp4821.o
>>>  obj-$(CONFIG_MCP4922) += mcp4922.o
>>>  obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
>>
> 
> Thank you for the review.
> 
> I kept that line so the core module would compile as 'mcp47feb02.ko'.
> If you prefer, I can rename the core file to mcp47feb02.c and add just
> the lines for the SPI and I2C modules in the Makefile.

It looks like there is only a few other driver that implement
it the way you have. And only a few others that don't have "core"
in the C file name.

> 
> Another option would be to keep the core module named mcp47feb02-core.c
> and compile it as 'mcp47feb02-core.ko'.

It looks like this is the option most other drivers go with. So unless
there is a good reason to do otherwise, I would tend to go with the
most common pattern.

> 
> Best regards,
> Ariana

