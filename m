Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E81FF7C7
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785602947; cv=none; b=bRqR4SAHWCJj9PQUN8vkUNXbC6dVC55M15xNWoIeXznBvn/81nwKqDGAHUWkD0rgL+eg2Uez6aQyncwUmxEFZw2TcM+Tw/ECspANUTvb38U6A2OK7g3PHAN2Yns0c5yKsu2BxNDX2qe+AZSAx30wvKkQ2e2y2sW16kCEXEV+deM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785602947; c=relaxed/simple;
	bh=BmvfUV/WfzoLvLRpCiGKUn8HBUqkhoIXdDJ4rt6WREE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XI6QGSiQ5U5rlNXfOBnFhTyqiR3qPD38Ls7jCdNJRg4exLOzCZc2e3ZDdMRsfFGY8cT2qTOidnKxKf4+SWVwNSxPH+Ez3WAics8U8EK8SSnXecnnBQeVJaxiuokZl27unnEsJCx6VK83Hy4+pxL4qx/i6gXpD7DuYlRdfSRntr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kCvX05n2; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kCvX05n2"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb787dec99so1414413a34.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785602944; x=1786207744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/hd3T1xQvNyB/6IyoVuyaA+Q0ZD3Y79BRfJwwvpZwQE=;
        b=kCvX05n2oElRs0fibBGF1VbqyUrnun6zv9VcW8o5nT68SfKdZ6Klctgag1RoWR4jnV
         HlOHhNKbYUomTPD57Qtns0LaRvM6DEjuctkOHDEJ53SnRfPV7sZStBdYnEZFZjCQr2SB
         hLjEX5ZTAL+XJD7oLSnDBVx+ST+63u+s6Z4nxCMTll2tBt5DH0jdr2zW1d3DgMXh4Yo3
         8IfQX4pgoszBkGuhqkaGOC4dYDjPW6KqcSw3Mz/pc74emyD+O8hcPbQPuMeXLrxb7Tjb
         hEUev5wEoA+FBTkQ+dBcGoreUjlriGjIYr5eC0Gy0R7pXzXNcN8ApVmsmVB/zo8DU57t
         qNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785602944; x=1786207744;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/hd3T1xQvNyB/6IyoVuyaA+Q0ZD3Y79BRfJwwvpZwQE=;
        b=NSDKtAPpdQ/Tt0VhgkWJWelPaPbTalZZYo2uV3ecpGD6LgMJFIpTOED+v4vpDv64hV
         HKJh9garKnPZnGU8skpLd+c0gzgFmiDYzKb687EJATlxeUoguZ+sW/FloSzS7eTkAP0s
         799jzhGZ9RWv9EYYge/TncNxddXoBE/Bu6zyZYhaV8gjNZXRQEZ/CJRd5W3dDBKBPKX/
         x7ZwK8sDIVa0jphAWln4ypTLLMpcMngNu7t8Nkmy/BVphpN8qtAbJTd2pD8LXMGpI5Fi
         80fbkmDjjYGGzp8Ea7m4fDBRcIOYdj3239GDYsv61klM3UlNztdN9FwxrJedjveh7hbR
         /JiQ==
X-Gm-Message-State: AOJu0YyqUnclElKaSv9GWIyiOK1OoCTanwVZId4uQ0xKDdLDxmomWiwb
	Qqq4HV55hfdxQvPeofDWCAo2xc5qO4Pj4k0l2MuM8H7JPegsiXvCDRJmyx4nhPMwMrc=
X-Gm-Gg: AR+sD10haEEcoC6RigCcQt+FalOEMZm9TihkGwbaagiEDpPL26tVkIfHoyvYcSn2BXi
	dWRMONegvLEIyP/rjDodV4wrnM/bZM2ti9T1JlMAPbe6ZU+TVNFR8uRT7fokIFKsweD1drhTBxp
	SO0merAAiACFndhbWDpXrOAqIEYo10n6xTObEP13BjtF5odHCbLep9EEkMFkCWfMZ2xK2llgFKV
	tz6+hBGUEn7GT8y/gjfXEyUcjrhTjUCn/tO/p2qABGjPwaOyQ/cDeL/ZZK8S+snGU+ONBsY78rm
	kSJCcD0We3zm+5mG7b6GY9VFkZaztdHUuEmNySpmb1xD7NT+fSTC2VwVzuB43mjaIEqQchH/O/1
	dl78FBhpJ1Da3w22UVuNqfvDS+9VHcDh//NbmvirCT5sDv6M5XW+ahX1X2UljLEO0afy+GXG2VO
	re8NvBOsr6L7B9rQwy+reOZjS1KH/m0GnFvH00GRR7mewmv3gAmGsc/jjSiXU7QmNpm5AfSWFBl
	ITegPRaB4RNs/zXxAw2k0K59S5Kty327AE7he0=
X-Received: by 2002:a05:6830:81fb:b0:7e6:f482:df36 with SMTP id 46e09a7af769-7f196f48cbamr9251653a34.15.1785602944505;
        Sat, 01 Aug 2026 09:49:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:359b:17f1:d4f9:4949? ([2600:8803:e7e4:500:359b:17f1:d4f9:4949])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a586sm3398388a34.16.2026.08.01.09.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 09:49:03 -0700 (PDT)
Message-ID: <4c720f59-020f-4e26-9d7c-e018556b71a0@baylibre.com>
Date: Sat, 1 Aug 2026 11:49:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] iio: adc: xilinx-xadc: Add .setup_channels() to
 struct xadc_ops
From: David Lechner <dlechner@baylibre.com>
To: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
References: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
 <20260729125455.95893-5-DileepKumar.Nagavarapu@amd.com>
 <9d6d0f3f-ca6e-44e0-a280-c07a7d55453b@baylibre.com>
Content-Language: en-US
In-Reply-To: <9d6d0f3f-ca6e-44e0-a280-c07a7d55453b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 11:47 AM, David Lechner wrote:
> On 7/29/26 7:54 AM, Dileep Kumar Nagavarapu wrote:
>> Add .setup_channels() function pointer to struct xadc_ops to enable
>> different interfaces to have custom channel setup logic.
>>
>> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>> Signed-off-by: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
>> ---
>>  drivers/iio/adc/xilinx-xadc-core.c     | 6 ++++--
>>  drivers/iio/adc/xilinx-xadc-platform.c | 3 +++
>>  drivers/iio/adc/xilinx-xadc.h          | 2 ++
>>  3 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
>> index e3b1d5bebe98..d39ff54439ba 100644
>> --- a/drivers/iio/adc/xilinx-xadc-core.c
>> +++ b/drivers/iio/adc/xilinx-xadc-core.c
>> @@ -656,7 +656,7 @@ static const struct iio_info xadc_info = {
>>  	.update_scan_mode = &xadc_update_scan_mode,
>>  };
>>  
>> -static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
>> +int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
>>  {
>>  	struct device *dev = indio_dev->dev.parent;
>>  	struct xadc *xadc = iio_priv(indio_dev);
>> @@ -762,6 +762,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
>>  
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(xadc_parse_dt, "IIO_XADC");
> 
> This function is only used once. Would be better to just move
> it to the file that uses it instead of making a public function.
> 
OK, maybe it is used in another file in a later patch. The commit
message here should explain that.
