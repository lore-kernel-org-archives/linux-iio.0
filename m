Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74F3A7F67
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488030; cv=none; b=RhWHGuA4no5GxMTo5/ejtMw51Bv6PRK8oN+SHsVnNL6bbOTgBy6zORbcJb4HH8Eev8k5wmRKcdk18aWrvzA6N/WnAhzbsYmZpQtQage4A6GuzkzBNYi849OqMCtAtzaoUueGCGco10Dxx+jEi+QCR7qC68kYUWbNeb8u2kI4j28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488030; c=relaxed/simple;
	bh=ixI1m2JIwigKT9carEcPKDSVR0MMBoicc7KnPcBRpDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgV6qcZD9D0a0aqcWIYSiDBqHZ4bp0D1GGXIftrCrG1itKXdhk0CJQSgngVLNYeuoC2GgnnOuTHTX8uBTKq1sE7c0R0QfZmTikRRvfJrX0ewju+qg0LqEf7/VQfEqsHTiWaEb5/cpJOeUdjzPdb2l0SzRghHqv5xu3OPYD8QT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foi/ARtf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foi/ARtf"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a525aedb24so3960027e87.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778488020; x=1779092820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Df80qNeDPx0rB6WR728JKPLmFNIRxLsod6mvLa2jWdI=;
        b=foi/ARtfswE08Y++GIhzdHr8fVVnkVqLU5jhcA1BX/NvruiWay5yHic7qBs5/tnsrR
         wdYyrkkpB26bX2+Ar2RbCvZ+7KfG3yfBMpR2rO4MhHhSKnbcDK7JcxclfrOPhXSIo9wG
         1HJLKm+SXys6K9gF/pAR09XhD4lRoqRi4JptpTnLwhAf3Zh+ejPFJiT/FUdH9/lYg0S+
         A8XycjZoAKfpjxnY9spSLBC8BnsVTbm6xmsyEA/tyXOFGovskg6nuhxltlOdq7VkbXiv
         sAeIRp0vXg/Mv7f7DsRBUwhGnU7NQj+tuVa2f6zTgRyNrHJF4L35ltPmonk2vwQR/66s
         BaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778488020; x=1779092820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Df80qNeDPx0rB6WR728JKPLmFNIRxLsod6mvLa2jWdI=;
        b=Jj6uPLTYlFwsSpGsobixeAyJOhaCXF/VRVK1iOha541N9GAPzDpzNBD28I+p+TYopk
         Of9BcJnKmuTz/aDAOln8JlXFd9E5lutFO0uLUIR2m3F36otAl6uemll0VW0A7xT+c/k/
         XX+HPNHkG+tuohzReskr0/DQ5XGWtIFMx6WNrrJhEKwoTp/mK5BNg8Om0BvrDPUA+2sh
         ZZAqbavzIfoDjaPk3GAyQgnlmelj+ATrWFjFQthBf4up3/aFQyzlOCftRJMBczwuvUD6
         WRy2XAJ+fwOp7Eo9LSoXPSO2rpZjAEGknKamDfKQU2I8DUVSGzf693LA26GZupOKbqFt
         uWPw==
X-Forwarded-Encrypted: i=1; AFNElJ/JOAjYvUTPErD1eV47kw1WihTGgL8gDmg6tr+abfQsaQ6auFlnJtSOp8f8sV+DR5TWqnFsp0VYlWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxthZqzGWTk+7Kt4oPvdLeF6QC5Q1+ejYkjgC/yp7Ar3HKb5y2y
	wXZy4zaj5xVk6Tbz8BWveRnkj70NliwFBc6Q6J7smEgiVWb9ve35ceDX
X-Gm-Gg: Acq92OFdkgK7Pc0hkvCjLe0hhpgurLlbngLM0rLnHr6+oqDLxmb75YEjfpvLn+1Zd39
	jWGSPIDuy38NQ9Y4WVNVc+LdWs/Mz7UzDoi0Ka63MVdbxj3KH1QEvBIz78kPrgoQNN6XJ5c2SRU
	jGRC14n0DF5G9+NXS8lNULQXrHMixoM6cDw+ThuLHdjnLTnMV+FbEcwBxW3b3ktNM0fFelAHoXB
	HJTbCrXkdJQMb2Qgm/hr6umtlBajW/AySWIIGUAtHLLFHURKHATRGGrWcvcjSDRBkr09vc0uKBz
	e9vgSLLiGOjBkcVBrYOUW2lbaEzUstAO5tsjQmsTFvW06ILY/dP0JS/4w/f0ZbtD5vEr5J93PTm
	pXc6CYbHoHfm/2CkEvs3bTtP4eNll5H5WBwlnMQKryaQIUSJcxWnRe/G2N+FP+NhnUiD0L+NtEj
	ELFN+Py6xBTd+9V4c+EESUn5MFNzrmC5H7ma8BRd3t3fneVe1RazvHhM0EkqzR2ipzlxYy59EQo
	JFGd/wj
X-Received: by 2002:a05:6512:33c5:b0:5a8:934d:7cad with SMTP id 2adb3069b0e04-5a8934d7e5bmr7050642e87.20.1778488020149;
        Mon, 11 May 2026 01:27:00 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4fcsm24719271fa.19.2026.05.11.01.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 01:26:59 -0700 (PDT)
Message-ID: <f089f090-4dcd-43ec-ab95-e425d4dd81fd@gmail.com>
Date: Mon, 11 May 2026 11:26:58 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: bh1730: Add bh1730 light sensor driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>, azkali.limited@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 heikki.haikola@fi.rohmeurope.com
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
 <20260511-bh1730-v1-2-e0df1f499135@gmail.com>
 <agDMAiBUtXLamFHY@ashevche-desk.local> <agDMWcCYLCvX8vy_@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <agDMWcCYLCvX8vy_@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/05/2026 21:20, Andy Shevchenko wrote:
> On Sun, May 10, 2026 at 09:18:48PM +0300, Andy Shevchenko wrote:
>> On Mon, May 11, 2026 at 01:09:50AM +0700, Alexandre Hamamdjian via B4 Relay wrote:
>>
>>> Add a driver for the ROHM BH1730FVC ambient light sensor. The device
>>> is a 16-bit I2C digital sensor with separate visible and infrared
>>> photodiodes, four selectable gains (1x/2x/64x/128x) and a programmable
>>> integration time.
>>>
>>> The driver exposes illuminance via IIO, performs runtime gain and
>>> integration-time tracking to keep the ADC in range, and supports
>>> optional als-vdd / als-vid regulators. Per-board lux calibration data
>>> (integration cycles, lux multiplier, optical-window coefficients, and
>>> gain sensitivity coefficients) can be supplied via device tree;
>>> sensible defaults are used otherwise.
>>
>>> +#include <linux/delay.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/module.h>
>>
>>> +#include <linux/of.h>
>>
>> Regular drivers do not to be OF-centric. This won't allow them to be used
>> outside of OF-only platforms.
>>
>>> +#include <linux/time.h>
>>> +#include <linux/regulator/consumer.h>
>>
>> Missing a lot of headers, follow IWYU.
> 
> ...
> 
>> Here I stop my review and recommend you first to review others' patches and
>> learn from other reviews. This will help you a lot with avoiding typical
>> mistakes.
>>
>> Also Matti would be the best reviewer for this as he worked (still works?)
>> for ROHM and knows the HW a bit more than average kernel developer.
> 
> Forgot to Cc Matti since I mentioned him. Now done.

Thanks for pinging me :) I am not super familiar with this particular 
sensor - original ROHM driver was written by my colleague Heikki, and 
not by me. I will anyways take a look and provide what-ever input I can. 
(I will also CC Heikki just in case, but he may not have the time to 
look this further. Besides, the email client which can be used with 
company email isn't really upstream compatible ;) ).


-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
