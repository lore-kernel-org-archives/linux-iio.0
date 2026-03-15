Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03748371CFA
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773594449; cv=none; b=lEtc1Izp76nz7RcrwUlrbhj5K+QJKWltTkOgJP9eQZONAKPMDUAhUbFrhOpHXMNxQJjtcxQHkiQURJ7gptcvKGNzKqJopDSyfBvKvtXfuTCPbGDbpVVTWkrJ4KGcdJO1blzYkVaQuZ9qi1yuaCe+/wJ9vU83Mt2FzYaAmXTecrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773594449; c=relaxed/simple;
	bh=u7g/7fNCkIeTMCYO3iV/qfav7MuiFPpqrSVcnGrxMBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFfqDRxytz0P+z+Z6ArzyHuwxpLY4Wc6fUKL6PzS3pf7A3Wx2KSB6PtBG+vCqLtKeP+TEbSW6dNTULuRI64/GuTJecx5c1+yowNtkbY+qh+mpveYMjJmGv0wc0RknwhB534f8xZiu/PmLzKDOWfvvtyP3vhHae0umLoeggF2pwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXpCvxXD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXpCvxXD"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b942424d231so456570066b.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773594446; x=1774199246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ups20uRnYGz6Ay3iT6SM4s0q/qm3+3T4sX9Egk3yWMY=;
        b=MXpCvxXD51aZGQlwIvOcLBBX4zRc8uF4mZx4CZLh+TOtPiF6PJcWVoV4u5fXXNuxDA
         5BKrczr5O0txyEDRwovSQzPzSbKpu29n0MXMyZDmtB4qxkIGUsVHSkHIBcRbLk8Jbnss
         HGdty24QuonvyMas0c3xTjfbxicr15PKq6NDLNdOcVpbjWvnktVgeUePdPbuQtm7U9x5
         j5jKKuYc2Ctvbh0c88OS8y3C/sum8y464jAjmLfv/4ZZgAX5LQPi5dkhl2WE/1+cgqjp
         kgH8e65UAoJiFHwS1hrhzClXvg9A1rgDuTQvS0kKgOyRYA9BGjuDboP+3m4bHJ6G2FlQ
         M5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773594446; x=1774199246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ups20uRnYGz6Ay3iT6SM4s0q/qm3+3T4sX9Egk3yWMY=;
        b=HsXr31mk+kUHNWBLd4vbsAy7Fd6WpbGbhfMewHEgyFDrVzbAqcIrX7gjRNa0fRBhBU
         joODP7Fnum002BBZniC6Dryx5YBaFxoxx1NchH3DMXlISDslSKB3d7SeDj6pDqBbsXgO
         PKCdkpHhOOSGFq5DeCYd0h/sc01pW8icVg0/lPzWXOp9ikJsqbkaOy4P9xOJv4EIrkUz
         TctamwWINOCLYsPx8YKCXMSU+X3QbixZzuwxkCz75lZ7/zdh9t6XQuDms4390qoiDX2O
         1SjuamXyO7P5PbyJYAnYZ5KKvQDtxq7lR2NcKXFJTC3wzpMKtMdxLvM+uBr1PubA+gUv
         yiIw==
X-Forwarded-Encrypted: i=1; AJvYcCXy0pjbtj71tDRCnkE5AX6ZyjLor5gxdTKP7xJxXB/IZBKxVOLcdXOQXCRqfmOQPCfXtt8D7bFeabA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz41mDkXZmIhneEwCa+rcadCbu5izDeRG51L8rTGplYzcdulrP
	StWubePoSJqdIdg3lg5YZhhWZnthfU1Ss4XBaT9Vv5y84YSuVyNqhPRX
X-Gm-Gg: ATEYQzwDYRcs95V1DvZaPerx/Tj60Yg1dLlxmg1fV2hNYqwdVqtDBtwyF5wnOUu59ee
	jDLCaLNL/PuOae5QqSvC9FN3/O5LlKefGnWZfMzVTW9vPjss989q3LqrK/JGSEn3yfMi1+/WP6c
	HAlOmmzPzUu/LDcQWjoGnwfS75LJFej4cPu+uXXf6jnZDypAwHnZWUG1HXwh+d94dZcKKs78d0L
	8Ida2OXWUCQHCWwIl8EURaqxDW9yLYaH1iwsVzQ5A4l3QVZdeqz+M7Cxe8H9uXNSFgDER8GJ4mm
	AfGYLQLYQioABLM60TzxT0boXcRM1eqlf44nq+sLEvoUZXFOXgpqkv1fD2sA9nC6yavvX6uBYNl
	R+SP1XRpEjmkF9GgHN64u/T8twgwTxbKbMTK8fDcx0V8x9w55zcy51VJ4jg4txsyifcbCEM456x
	kJpJcRZBuDozcrMY0VAp3mkloNDpaqJYgR9zK3
X-Received: by 2002:a17:907:fd0f:b0:b87:1fe6:f223 with SMTP id a640c23a62f3a-b9765012d6cmr568157766b.6.1773594446007;
        Sun, 15 Mar 2026 10:07:26 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976d0b5886sm399606066b.65.2026.03.15.10.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 10:07:25 -0700 (PDT)
Message-ID: <567e0d49-270a-4442-8416-a9625bbe98f5@gmail.com>
Date: Sun, 15 Mar 2026 19:07:24 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: light: vcnl4000: add regulators
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
 <20260314-vcnl4000-regulators-v3-1-3c4a48d30676@gmail.com>
 <20260315-honest-debonair-oarfish-3a33ed@quoll>
Content-Language: en-US
From: Erikas Bitovtas <xerikasxx@gmail.com>
In-Reply-To: <20260315-honest-debonair-oarfish-3a33ed@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/26 10:49 AM, Krzysztof Kozlowski wrote:
> On Sat, Mar 14, 2026 at 06:06:30PM +0200, Erikas Bitovtas wrote:
>> This commit adds supply properties for the sensor, I2C bus and IR LED
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94
> 
>> anode supplies [1], which can be found in vcnl4000 ambient light and
> 
> So other devices do not have these supplies? Or have only some?
> 
> You already received that question, so I assume you checked. Then check
> again because 4040 has VDD.
> 

VLED is supposed to be the IR anode pin. Every model has one. It is pin
1 on vcnl4000, vcnl4010 and vcnl4020, pin 6 on vcnl4200 and pin 4 on
vcnl4040.
VDD pin is pin 7 on vcnl4000 and vcnl4010, pin 5 on vcnl4020 and pin 3
on vcnl4040 and vcnl4200.
VDDIO is an external supply to the I2C bus for the sensor.

> thus in
> that case 
> 
>> proximity sensors, to ensure the sensor is powered on before proceeding
>> with setup.
>>
>> [1] https://www.vishay.com/docs/84274/vcnl4040.pdf
>>
>> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>> index 2ba4d5de4ec4..a1b4c02db246 100644
>> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>> @@ -33,6 +33,10 @@ properties:
>>    interrupts:
>>      maxItems: 1
>>  
>> +  vdd-supply: true
>> +  vddio-supply: true
> 
> VCNL4000 does not have VDDIO and VLED pins.
> 
> Best regards,
> Krzysztof
> 

