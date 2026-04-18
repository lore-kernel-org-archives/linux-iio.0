Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE31E98E3
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776550740; cv=none; b=QaC0QBsP6N4LmYPtdAgtU9z3sGfPT7kwSa873UCGx+dcBOWKxCdkXmGZSoLLnBmGLjLlT0r2sZHbIDBdhKFYUAJfYCEJgHjfubOXallkFA+aVRRd8tfmN2EotiQVRsL56DhWuU7ZAX8ZwSeQc+2EZyQf4895m9JR/2dRy505yyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776550740; c=relaxed/simple;
	bh=1+qBHzyq/RyZJbREu6jXeYPnrwObeNp0SVWFjo3/mGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxSgRgp2zUU2kxM3EhNecMCLBNk+IlDIOnhp2C5R5fdj3twQ1WCKaVvqMkAhTg4HEUgOF1Aq090DenNRfx1PNF9sEKezYyPYlKSlSm2OQgFOeAXIqKYZS1Wa9iiUxM7kN2Svq1TIRGNP+JpkqVzV+utxxOUWtxCCWznDu4rF7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=IEMZ9JNc; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="IEMZ9JNc"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so1714664a34.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776550736; x=1777155536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jUgfQx3lTPA8+l0sSnmwFwjO5apfcViqgnRKAaYZmE=;
        b=IEMZ9JNcgs0Ak5I8FQwmUlIRJtdvoa6yVVIV9F6oMBOiM1V991pGkew57G3GScZXZj
         d+OoHl/1cTtC2fjeRPgZKqgURtfWa+STRAJaPqGM+55IIkOUJ99tLuOnA7QE5NvL0Hfk
         YR2f2YfNhk2Kz/N4C7BXS5U5AvENK9aMgdgZnylTp9wOs8j0kz3jLTwoHCPQ/ChEO0zn
         0VmxfszJc67nSb4Hhu7QYkrvfRn+MQe/2u11PBe+qCNav9m+D2TCVGVPnQI3VSJK7MpA
         xgH0SnLcgieElPO+CKK8hhjDfUiMXlG6Z+rj5LRuV+QfEjHcVdfVTepA2ek1eK+j+SD8
         tRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776550736; x=1777155536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jUgfQx3lTPA8+l0sSnmwFwjO5apfcViqgnRKAaYZmE=;
        b=Z0tw5iKwg2K2I6W6ohopReq6S1pbjPXCnFjwDF2lMS1DoBDWCYMWj/0r9oht4eS+fa
         Hs2ds3JreJFDg6q6bSdyRKkfpDcfnMcdgA0RLdYkni7eiqO65nBi82bBaieKKkaTqW5y
         hNjTOCPYf+7gdW8kTd7OMG2A8T0BvcDZx0llWT9OmIlhB5sCieUS0DLj7jnheazpsHk5
         wH4cg25eqZ4TqViZSIN7/M454o+B781pR3hnB9XbhOsQbSyHcwOxe7ULR/DSB8DVGtM3
         c6M0s+7eNwE5EJAjVKA6T7LjJBUnH5dBSG1J5gwt4dlPYyCyPZlYnt5/Y6Dy45YA8Ut5
         bcGg==
X-Forwarded-Encrypted: i=1; AFNElJ+FVEwipyVVx3BmzTuMxxX4t47D39E7DOTIJY+4SUCjNkOF2+djyUFHOtOFoNKNMRYO3oIkHfBjHZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB9xgBEHAMNb4Dh0A4/GkGPzunY7kR+JElhBPh9EQunKAg+/xw
	JCdlKkT9EaGzqg8RjuZm0/rggdN+eUC2GKYc2esAze3W9Jpjr1lVJN2b4fYGOY060MY=
X-Gm-Gg: AeBDietJXvY3+3nxbc5p66TRAcybn0IR2MOzlxouT4eTsXLr91NxRigEWyviK8noMOU
	8flJrh3h8XAhMhiREXR9FF3/8tYLEE0hqTvDdGQDEF+Dv8mRuUBHzb0H6r7NE97mGARGIp8zhCT
	5KiLG15EDHNBuTjYQ5Kmyp6LmfBUtctLAaxSm9ydLAC5r6+yqRY3rYV6UZ0d/DiAdqDvgeT4f53
	ueSaTDQmdgqw/npawTkDbMSC4wbfBUfNE+60/axcrGm3XEwoPtxsq4EEpWSZG2cJ7vqzCGblAPx
	6bfz6DJjea+pS8G5kfKwE1jR/e9MPHzxTY/yZsCrO3xoqbA6F46XuexYx2Scxvp2JIFahIfYxcs
	L+hCcwGWH//pPHfijtfr2wLtaRmvXryxtCvRZv+z3YMFCkJ35Ad45RmCxNvyAbgRrsOVV06CbBf
	EpDb+P2vascCpcbf9uUsectlPrwCk3yKr3VXzA3nhtMLDOKs1A1enqhJRDfjE3jhzfoGQnWPYOX
	Tj7Va28Qu7I
X-Received: by 2002:a05:6830:2b0a:b0:7d7:da43:387 with SMTP id 46e09a7af769-7dc9518bfffmr5451502a34.16.1776550735928;
        Sat, 18 Apr 2026 15:18:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b1f8:aabe:74d7:21ba? ([2600:8803:e7e4:500:b1f8:aabe:74d7:21ba])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b19fesm4638922a34.22.2026.04.18.15.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 15:18:55 -0700 (PDT)
Message-ID: <ebd1fd7b-ee47-40e7-b953-cfe7bff41961@baylibre.com>
Date: Sat, 18 Apr 2026 17:18:54 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] Update APDS990x ALS to support device trees
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260418144716.132936-1-clamor95@gmail.com>
 <36e3611d-642e-42de-9a56-cf81c3e06832@baylibre.com>
 <CAPVz0n1ph0Cjw9WOqoVPaEywF0MzaNXeEjw6=0rKf4qLWiJZtw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAPVz0n1ph0Cjw9WOqoVPaEywF0MzaNXeEjw6=0rKf4qLWiJZtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/18/26 2:48 PM, Svyatoslav Ryhel wrote:
> сб, 18 квіт. 2026 р. о 19:24 David Lechner <dlechner@baylibre.com> пише:
>>
>> On 4/18/26 9:47 AM, Svyatoslav Ryhel wrote:
>>> Document Avago APDS9900/9901 ALS/Proximity sensor in schema and modernize
>>> its driver to support OF bindings.
>>>
>>> Svyatoslav Ryhel (5):
>>>   dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity
>>>     sensor
>>>   misc: apds990x: Use more device managed approach in the probe
>>>   misc: apds990x: Drop Vled supply
>>>   misc: apds990x: Convert to use OF bindings
>>>   misc: apds990x: Drop IRQF_TRIGGER_LOW trigger
>>>
>>>  .../bindings/iio/light/avago,apds9900.yaml    |  83 ++++++++
>>>  drivers/misc/apds990x.c                       | 197 +++++++++---------
>>
>> As mentioned in my reply to the dt-bindings patch, there is already an
>> IIO driver that looks like it could be compatible. I'm guessing that
>> this misc driver pre-dates the IIO subsystem. I would have a look at it
>> instead (drivers/iio/light/tsl2772.c).
>>
> 
> tsl2772 driver fits, thanks for pointing out. Maybe you know how
> apds9930 lux table was calculated? It is quite obscure to me.

The tsl2772 driver says:

/*
 * Different devices require different coefficents, and these numbers were
 * derived from the 'Lux Equation' section of the various device datasheets.
 * All of these coefficients assume a Glass Attenuation (GA) factor of 1.
 * The coefficients are multiplied by 1000 to avoid floating point operations.
 * The two rows in each table correspond to the Lux1 and Lux2 equations from
 * the datasheets.
 */

So probably just need to look up the A tsl datasheet and compare it to the
apds datasheet. The apds has some equations with GA, so just need to figure
out what Lux1 and Lux2 correspond to.

> 
> Obviously this patchset is obsolete and different set of changes is required.
> 
>>>  include/linux/platform_data/apds990x.h        |  65 ------
>>>  3 files changed, 187 insertions(+), 158 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9900.yaml
>>>  delete mode 100644 include/linux/platform_data/apds990x.h
>>>
>>

