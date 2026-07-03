Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC0414DC1
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090940; cv=none; b=a2bHdVlHMkODDrvD98V2QIzButM8XZMWU8R+NfCtFQxx/BG5O5DkGNKxjsMg0lmPaVf57sMvUP6xrVSO76U39PkHo/BUs4YNO0f9cBELgGVMwJhsaHPc37M58LaEzdnePdS3iy4mX6gADKkcfXv7GVKxNdlS5zfqK+8W7M3Y+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090940; c=relaxed/simple;
	bh=vU5G6kbkbMYUju8uEzt/NM53se+SV59vfYr8ggF++Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUfA6h5juPbHG+sX+MzomaOv3FzyP50wbnMvMEE72PzyuoTMBBf4jVaFE+3jMqselsI3eElHqPbcGtxEwJ+pFBRzeF1YXBQuKSF317ybvPWggdtre6oJk+T1HoS/tOO5I8kG2YFf1y6Wr0+ZB+LgSDWdqOCbHbs0pIlzv93zYGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ow5ZN/Ap; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ow5ZN/Ap"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44ce4d7883bso367007fac.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783090934; x=1783695734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0Grj9Qi0+dk5fVU5XSa7j0vuzMhx4RJGQKccjW2bkw=;
        b=Ow5ZN/ApokUjAXmdOBLCTM1PpuiYh5jwlBkWNH9wc7pRsUHBUf45Fh8mHU5NhyB9oL
         4JocQbyZd+xhhPn2lIgYR3aLCWBUKC2eoGsdvPRMqqhvI83gxORYOx8y+lv8juhd+r/R
         OINJBeioalzBMVphz/EqSmIFlb0t3tl7o0OouWlf28G41PMnzF0Ocv3fglR/jfo+Z+j5
         qi8I9q3UCokbaf2XcGgTSIuMtCzJZlyoLGRX+4X/5VeQ+kHPqBDgFD7O4MmjSwPUNwIF
         fS2ntVtoIsWETN9qjoIs9qI0n5chsEqns0cHvkqtBKrO3Y7hg4bC1wzM3HcddZ86aY3n
         LaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783090934; x=1783695734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0Grj9Qi0+dk5fVU5XSa7j0vuzMhx4RJGQKccjW2bkw=;
        b=C0aNdp6VcIfd4tfl4KV2ZEZTWLjxYe9k+tTQnQDiTGz/MJihK41+P1d5ojcrMGKkh4
         saYDrFSk1zOjM17BbDikR4DV1XylUVzIEeXvLwqdX0i0mKBqrMrjINPGzbn37/YL7Zwr
         YwHopkTA4Q/LrCEA0EZYHj3cf+95vL4g1+4gsji2L9mmDSK94x3e/b2oZYZwqjawTnRS
         weOZGgkz7D3rsoiikYvgaS9RfjHfQKUrK9CbAz1mCLcgySoH8xPj7/vjHQdxlI+l54MN
         fnPr60vDUjwwSsnzqENmGqWf+zv211DlXsUiD60L/ios7fKWmAD8xX5In0FO1OM37XkE
         QDag==
X-Forwarded-Encrypted: i=1; AHgh+RpdJDfQy76jaRDMgZayOY9IXqBgna0EkjOEY8c5EMESFanpvzS8fyLPAnjR2xClEOzb7Jm6feDhiFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rIxNOFjovcwKNeIjA0WCIHbgTOgfFSmUhIXO9oSrYcD4IkFu
	jfjQTcOk/rIUZQ+f7E11oeNcUFLMqeu3ZkA8c5728HhplWtoBg3t+zg+LLJ5xLUQNT4=
X-Gm-Gg: AfdE7cncxdODpG7fCm+JGkgfmGC2/eGPs05nQxnUlM64MtTeP9YGbt7lfF4j2dMxQS8
	y9hD0Oi/v1qP6YKSNupwMNG4ykHrSCb/80XwxrfaiaqJcKQTeDT9OX4nvk9cYW6vF4l/r+YA4JM
	fJUKW0tyyoayjLJDYzT/TZtl0/omJF7pI+Og9ai28cDy7ZYr6YwmWBuAshwzmdJcvHCdWaVZMZN
	oyVg3s6gDe/+r2tUj2nD0btX9R6v3hUIZU8h/dZ2/sNcEUoXLZK09+uXenBhoXsG6+s277hLNCp
	l6UPmjFP7WJGrBssJ7a9In5js0LbsBOKDIWhWJtknOcxQ8AyzNlg5oiZOZkNQ4hjjCoL+bXyYvj
	LcpintlBFULUu//7rxhkgSb43p3JiMm1G4E2XYBO3TQHNPXfg2k/chIefdKZZRyqgUDe5r3R0Vl
	1xdLSyTnxH0deZxwTfg/vUkj0Ko2Yc7OvK3VCjV+4Xo6BQXl+BjwfS3AetIkhrKWU=
X-Received: by 2002:a05:6870:326f:b0:440:67b1:b59b with SMTP id 586e51a60fabf-44caac0e76bmr6806975fac.0.1783090933482;
        Fri, 03 Jul 2026 08:02:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6af9:a9d7:17b5:2644? ([2600:8803:e7e4:500:6af9:a9d7:17b5:2644])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb1bb17fsm2183286fac.5.2026.07.03.08.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 08:02:13 -0700 (PDT)
Message-ID: <7a549442-f61e-42a1-86b6-aed6a8977290@baylibre.com>
Date: Fri, 3 Jul 2026 10:02:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: dac: Add AD5529R
To: Janani Sunil <jan.sun97@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-spi@vger.kernel.org
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
 <20260701-ad5529r-driver-v5-2-ed087900e642@analog.com>
 <20260701194103.45541cbe@jic23-huawei>
 <3e094744-8603-443e-8027-8fc2f2817879@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3e094744-8603-443e-8027-8fc2f2817879@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/3/26 5:01 AM, Janani Sunil wrote:
> 
> On 7/1/26 20:41, Jonathan Cameron wrote:
>> On Wed, 1 Jul 2026 08:40:40 +0200
>> Janani Sunil <janani.sunil@analog.com> wrote:
>>
>>
>>> +      adi,output-range-microvolt:
>>> +        description: |
>>> +          Output voltage range for this channel as [min, max] in microvolts.
>>> +          If not specified, defaults to 0V to 5V range.
>> No way to specify the default as part of the binding rather than a comment?
>> I haven't checked but does
>>         default: [0 5000000]
>> not work?
> 
> Tried that approach. But the dt binding check does not accept default for this DT cell-array property.
> 

Wouldn't it have to be written like:

  adi,output-range-microvolt:
    ...
    items:
      - enum: [...]
        default: 0
      - enum: [...]
        default: 5000000
