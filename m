Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F013446C19
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665864; cv=none; b=WuWGhJgitVQL9iTz7arvSdvPFP4HdtMchVpkOtHaZHa+mQMsmizb6LwB+olzmKM3+jz4WfKgfHDBKd4svqeXNTpqwV9ghg5y6NPzofEdFV3LxyiIRRCP890OoSfvURBtbLdTmKLezZS/5fMs3pWBiXRiQzEiVjf2C2hu+P4l5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665864; c=relaxed/simple;
	bh=q4fmKfhNvE2e6sble7TF9RAgMQFsrD3C7OFXvi8DTWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVjlU57mxn978F2Z8Uz8rQhnTTPJm1EoJ/DXgoFc9TE7UxM3jQDxGYL9VSfACFEluUHilPd8LpLoq9YlLwsJRCS0NyddZknYDXaaou4mqbZWM9ybXjoII9AY1XJ9gD+tOekIZ/wf+S46Bj8EQv5La+FcniTvIsvd6iA07g4SI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJnLlB1i; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJnLlB1i"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2020421077so820652666b.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787665861; x=1788270661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tHnWeKaj8W4Oq7BCPbYGJwG4B0bt+vGlTEM1FKI9IJg=;
        b=QJnLlB1iyIxaXFJxASiPFKMBPGuWUVwXOZ+rqJF4VuRsxRxiVKV60LASPJLcNG4T3V
         ezvoma0Z2DS8Sz+V8XCZ3058pmAtfhJg4g00TzajkwAcRfk/9fjJ+sqTuruMaQyH8RDj
         /cHRjwTOVooAFLw2U8KcNr3pZEmXSx/gwz3a2nIUpDVmU4YMQTjiK1JaUT+TBsaZg9Qj
         LaW+zC0XlAt2unj2qRnjLZZY9wU/oR70MmCIE/syTlrqK1uhrBOnULonJPaGpT8qDA/z
         2keXIKK95fIp8Ubla02kGxrvE0QCNK33tioNVGmuquo8OiToWjzaRQXqw1IcPBj4oHPH
         lokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787665861; x=1788270661;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHnWeKaj8W4Oq7BCPbYGJwG4B0bt+vGlTEM1FKI9IJg=;
        b=g6NgGyTXqS/f0s32yrVgsg1AYu+qJSvYTb0OH3x09nlxK5WcaaVyzziaW0IGPn+8Sz
         AMzjvDIXDg5eFYhvO+fiUIRfeUXQjKtOsgDeM+8iNsZ7WS5gg4L/maeOkrhe1tShpo7G
         HIZxNq3VW5jaefqHWPLsVZid6a62qRQtqz4JTGZzJ41iHbeu+gpETYpXkB/un2syrZxb
         pWV1KGTHmEf8YKfRW2NXbZ9u7U4duLfMdqOXwRwk5VmyeTTFSv8k69wZdHc7WdPhqgAV
         9nmsV2M4OPJkGKzeNgpGX09g/BQnPCBc0eKUSKw5apxnWAX8Th92Q2Wru37zB9GxMoPO
         3oHg==
X-Forwarded-Encrypted: i=1; AHgh+RqYurmjgFUmD6KK3HPAoyVseG+1GdyPqzBCSayo07X3eu0eLolJ+h/xhEbHcNqkwRu+0ZmGstTmIFk=@vger.kernel.org
X-Gm-Message-State: AFuF++nKeXHwO4DIu4S2+OXfRhs5I0eysSeU8QCm7LNd6tBBuDgVJq1p
	O0yidaXXiWh2xxXAj4TwU9EzAiLdEudQN5T0MJoS40nVqCzoy/KkSeR3
X-Gm-Gg: AR+sD10TKHgEE5BT5rG495zCSrLAug+WqHWl4NQr4HaiM4EXQif0EyEIIiQFIrY7P03
	0ZdTpqXHbTLJNVf060gyyklaAJVUeRJrEWoj3HNTK+/eHW8oRfootzekkyaQ8hKWPfUFal8tkSD
	YRlt/chxGzaBl1kTsFGIqKHizMfwsb80LjZGH8qJwwyq7dxwGNK8gPjmDIUWHO5iWVoXc84yBTv
	K1gqvJI/Gk7ShqS9K/zjDh+Y12+o87LxdZ3MXNet4WzbBhzDVvM/MG6vvL6nndctSipikjuyOw4
	q0rvOSSUuuHS2SGKgL/M/UKzjFzhYiCiBn783nBeSzn3FpZju54WCZMXOqFUPsvQ8ezhdwYd4lO
	0m9ue/wYsriY8j7g32esFSKwbff/4F97hlNjqW5o9nc/yfVi91Nz1Zj1cOJw1l+Q3/pQclSZY4Q
	bg0aDKScpycHs834RksfxUW68v0aYGRkMWn7fhZELh4/xFH3OcJjucnoZthKj9tJkthN0BoVcdz
	BFIXI715F4RsorKagNd3TxFmqNz+gGDLI3YGP20ud3HhTpkh6lLYbrfvFt+ACFbA5h6efQV9+2v
	TL0=
X-Received: by 2002:a17:907:1c90:b0:c20:edda:ef5b with SMTP id a640c23a62f3a-c2491e839abmr2663366466b.14.1787665860484;
        Tue, 25 Aug 2026 06:51:00 -0700 (PDT)
Received: from [172.24.138.145] (dynamic-176-007-058-112.176.7.pool.telefonica.de. [176.7.58.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496734bfcsm1958495166b.43.2026.08.25.06.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:51:00 -0700 (PDT)
Message-ID: <77daa3ee-e5cd-4be9-8110-6f31c90f76d6@gmail.com>
Date: Tue, 25 Aug 2026 15:50:56 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/14] gpio: regmap: Add optional runtime PM support
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Janani Sunil <janani.sunil@analog.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-12-bb8fbd06d4eb@analog.com>
 <aov7QpTVLDZ9PEkw@ashevche-desk.local>
Content-Language: en-US
From: Janani Sunil <jananisunil.dev@gmail.com>
In-Reply-To: <aov7QpTVLDZ9PEkw@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/24/26 10:05, Andy Shevchenko wrote:
> On Fri, Aug 21, 2026 at 04:07:05PM +0200, Janani Sunil wrote:
>> Some gpio-regmap consumers share their regmap with a parent device that
>> may be runtime suspended. GPIO register accesses must resume that device
>> first.
>>
>> Add an optional pm_dev field and acquire it before register translation
>> or access. Release it using runtime autosuspend after each operation.
>> Keep the device active across the complete direction-output sequence and
>> propagate failure when setting the initial output value.
>> +DEFINE_GUARD(gpio_regmap_runtime, struct gpio_regmap *,
>> +	     gpio_regmap_runtime_get(_T), gpio_regmap_runtime_put(_T))
> This is not used, it's for guard()() case.
>
DEFINED_GUARD() was added because DEFINE_GUARD_COND() extends that class and reuses its type, destructor and error helpers.

Regards,
Jan

