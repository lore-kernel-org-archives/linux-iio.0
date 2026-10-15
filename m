Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79E51EDF2
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069368; cv=none; b=E9MD121548mL5lKGFFEhOajV1mf5iAsjzwv9frW1a82MzWKQpZFx8wlYhw1SY69dAhc4r0u9Ylo9lpJjmSTnP5g/7NgLWALQm0vGRu/P9ZSs8k8lPehI/ciM8E94wZls4K/RCKHdnRUvfrG6dwuXBbI09Bmcj/wKyYeshTwfMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069368; c=relaxed/simple;
	bh=sNHkM2NSJVz1FH0SzB8TgpwxSIcu6W92qD2xJF5gKMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8yorY2Cn5ooub0pp+ciJiGvWquw5aJ3+xXynmtvCMaIrY58vdgkZJ9XapGr3Yj5pzHEISWzBUwz/rwQ6Q8aqrnva9h7b9fFX+2ed5CN8hA/rPngZMqJxj7CHGICDObJTz2LNeMbj2loRooH+yck46iI1JmHZTlTikO4k3Nsy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pvlGVDHB; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pvlGVDHB"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8252259f6d2so3020158a34.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792069366; x=1792674166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=at9NDBQGEaYtN0ifydUv/WOhJYVf5LHHhPf50pPTXz8=;
        b=pvlGVDHBZX0vieQEbBCSmfO+0tX7LhcWO1Ck/yHebhBhSLj+M1w/MYwdCZYaZTw1dY
         F+L4U+qA7O5uRbSeXSPof15nopieIrkDdSwjLA3NwyiYLPceH0Xwrke72Muue2rfnNnB
         flggkYggYa8tZqFFXL6atV4qYewvDqRCX13mDfFRMdYoWsZA+tXY6J9egHEfnq7zSkvV
         0G3uGCNC3hHZGisB7ApD7ax37NgJJ9oeLZOtVSRhZW2Qn1eG6ZAwsls0O4bT3RC3sOE4
         8dOjaibkNGBUEZ9p4fkegE4aqLzdhuU1nTxP1ZbUiG7F9Bd7eDgkvV1xT1ysJywP/DK4
         qHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069366; x=1792674166;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=at9NDBQGEaYtN0ifydUv/WOhJYVf5LHHhPf50pPTXz8=;
        b=MJuLNtHu35U7nxpF/5/5UloiGz7xLjQFVxlEXaXgbjsd09O208IetBTw+EznRdtte6
         OZjn017FN5lIZIXEyOKzqviDQ5baGEQFXQKtx53R5MtlHBlMzg0GCMKFFMd2un+A3gVP
         vKJZ4ZQASEBvWkIxJysW+U9IjFG3xDl8QbFo/pbM6kVOCXg+D2/K2csQfl1H4n79A/qk
         XHtuGcEimpg2RdvUvaupypUTNWio2A5C7yykBFRQ4p1/ETTiEZbUSQYHeLznfZ8Y2bFR
         ToOtNaMHTwzsIz4BKJUjEq/ZXegbaB5TBmp4TNjavy6nCpLhAoZHpXy85CyIBtah8rYR
         L6Rg==
X-Forwarded-Encrypted: i=1; AKwUvBxizLqDkJxtjFQxCn7WLNesnSPPg5rN+GUsDXg7b48VAeKFXoHk2acQpuH/TQdeaokkpO1mdZV2tSg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKr5x3np4OsWQn+d7YkpezV0FWBkJKGrXwlGMKoOOCOqov3ESw3
	fHhUnUKiCqvOqVi+Bc1Mkznjoxiuz9HhrkaQEfpgY7tVcARosYNdZInWL/vo4I9EutQ=
X-Gm-Gg: AYBFou3zIaxOm19Gs9nPvy7prI57YDTdIEu+Bg4N8+2G/4Qt8rBGlwYX1LNFZP1Tkiu
	L1GeByNbH1sXX2c4/u6Fr5xhazTvdX9OcR64GfjsQ3T0d8Yg4S5LGC4Asom0TCZO28qjAzm21tm
	HTpWHLl9rIDlPHNPz5uwAmZlfGWLRG3E5wpaW/9m/91dzccq316Fd6K40Wxj5dYGPnDDCV/CtB/
	U2Z0dpldIMN+0dah8uQpyLoTUXF/ZxvoiKShZpvUYz1wgWl3eNCFAa2mxFJh/4seGFwpZ0X3/Jl
	KV72jfYCmWyVsBP2bYcGQLWL7nXhxHoaCfAfpvqjCv7ghgtqyvnK4z1Wi44V78uz79KuQ7OqqzI
	FJUH21ERtl7/hiC6W/Z+P9C84Pycpn0F6ACcxlNxcM2cXS265gjuNk3LfWjsJlsC6CDbEzcWlbT
	92qDyLCcMccEMJjMFAXVjxwfsSlhehwuSbjOKQWBvca9O+XhwKJBA5fB8/iBcaZ7sfAZLEsBcOI
	6anLZ+uAxOtquelkmfyCD1phrSVOE/dBmOLtsGvAc33QApH
X-Received: by 2002:a05:6808:15a9:b0:4f1:7cd5:8e0b with SMTP id 5614622812f47-50c4dfb9a1cmr17338045b6e.22.1792069366316;
        Thu, 15 Oct 2026 06:02:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7a64:39ea:e5ac:f974? ([2600:8803:e7e4:500:7a64:39ea:e5ac:f974])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1a325a38sm19891522b6e.12.2026.10.15.06.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 06:02:44 -0700 (PDT)
Message-ID: <92a8384e-17d1-47e6-bebd-406941f349f1@baylibre.com>
Date: Thu, 15 Oct 2026 08:02:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c14: add gpio support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
 <20261009-iio-adc-ti-ads112c14-gpio-v2-2-3231a795fa63@baylibre.com>
 <as47IMM9rtBCAH0-@ashevche-desk.local>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <as47IMM9rtBCAH0-@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 9:07 AM, Andy Shevchenko wrote:
> On Fri, Oct 09, 2026 at 06:25:52PM -0500, David Lechner (TI) wrote:
>> Add support for using the AIN4/GPIO0 to AIN7/GPIO3 pins as GPIOs when
>> the gpio-controller property is present.
>>
>> Pins that are already used for something else according to the
>> devicetree are excluded from the valid GPIO mask. This includes analog
>> inputs and excitation current outputs used by channels, REFP/REFN when
>> an external reference is used, the /FAULT and /DRDY interrupts and the
>> external clock input.
> 
> ...
> 
>> +	for (unsigned int i = 0; i < ADS112C14_NUM_GPIO; i++) {
>> +		data->gpio_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s:GPIO%u",
>> +						     dev_name(&indio_dev->dev), i);
>> +		if (!data->gpio_names[i])
>> +			return -ENOMEM;
>> +	}
> 
> I am sorry, I still didn't get what's wrong with the dash (technically
> speaking)? So, this may use devm_kasprintf_strarray().
> 

Nothing technical per say. I just want it to match the datasheet pin name
without the extra character in the middle of it.
