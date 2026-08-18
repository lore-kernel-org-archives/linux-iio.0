Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CB367B87
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041652; cv=none; b=Slj9HSyJltsF9f0Y3e37S/e1d1lK4i/goeKaodhSvyoJ32ahZxEePSe8WJ5OpBsjlhD5JuWQw+vlT6Wfp4N1IsJzkmmCUQjERJok6nuVs+PLttaufF3QcDhDyei4EgBY7rWkL0svMTjE7DL7bLnCsyjbTPlUoxnQzA9qGPpLtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041652; c=relaxed/simple;
	bh=JDzjZcLP71KCvagkMKD84MYXhOgKomjguCW9GMyB0bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pw7XyV1cluhPVDCbJL5JDbXb8uFiDQLvJXoWkuh6VHpG1tMq93yFCik5a0MQjAB2fV4hANi4Iqwx/d7lcEPgYg1VPcyBTZ3Blj114OCxVfCoY6EfixL7BlcUlwHx6vydpWulPdP4iU7N70V8DIEh6ogHwJQJafkQ7o2YqnjILJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rjz7IUyF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjz7IUyF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-476a130c138so4500261f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787041649; x=1787646449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uuK5mDxMiFBjBjKQm/Fiu5kzFGUEM5srIwSUyEqNmyc=;
        b=rjz7IUyFe10YkUwvNbaJibLuM/n/edgAhlGlK7mAklD2GLJyMyksM0Rl8ZatP4sJCM
         fbOXoj1hyejD7L+u9KX9607IO5foOZ4+1/rGIuv9pDmNG7dL0XvYBgBFsq1AGJ3DE+VA
         e3i+Cc3EybrdP4wcrbb1ck1h998kyNxCyPtUn97XIhXiDDUM3CuoI7wCennaDu2IveTU
         KBbf5025J+uU8aRH8EiWLlJB1mMdODlwwVxcGA0lLChDGdxhblYbfOYBKJ1Xhg2iLS8Y
         6cw+kfgSRKMumnbm6BkxOJG+YtSKJzE9IuXwABB6syRr9cPIPsozu/9ii3aphEa7QRtu
         17aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041649; x=1787646449;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uuK5mDxMiFBjBjKQm/Fiu5kzFGUEM5srIwSUyEqNmyc=;
        b=B3q0zZ7ogOaNrbCmKQ5VZSSoABVz3OmV1WdJTj0jmOFDSUFensOZdIGE4Rz0ly3ziO
         P39WvVxL0vkNTBmKhYz3mLU2nyeJ1hQvo7X78AX01KErQ7Xh2DZJFm8D4kL0wPvOxIGL
         wsYgXsndlWqgzk+oDPJrA2iIqXfd5gR30WI6ORuNSvrXkRZp2yc3gTtOHu/PguFnmn5e
         kYJOmUyIkwRGSql0AgSRdBRHfYaDQtYOgNCMsSdJxa9q1qlWXAA1pzkGV8sfFWH779/q
         QFT1d+cxsBvUPPIHW/NSuDwa5loD8WW9xH64UmhuP02RXQYG25Nkt0yGTI0g0NhSoIbN
         X4CQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBJIpimumMT3dPJhmcmD4Y7LT5zqHcDX7Hs0v2ndiNGzBFX1ffI6Nut/gNFmefRbiovl7aBNN39Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxk1UW7Ut0MNeHqOnV/ZzQBBG3wdFy+TGEAfl0PsWrNivX7e0B
	ZQAMlNyEPetClUk6MdTjBQzc3iQOhMC++3hBcDitIaWVLCpvICbuBPvq
X-Gm-Gg: AR+sD13HBBxiIOQQwigEvSU9bQkibVvbLROExUzsVC+euCv8i+RGYqMGILQgsPiGlrV
	0Ay8M8wTqxeFUCZZx/WO9dtQEjhGKZccPjhR6m+lp7cehAu7HQFzCdVFHp1hsuXBsZow2C8l7zQ
	Md4vFwo850IAAa08Z5vdSIhqtoRKYv52pXUqENFjdI6C7DMTcr9QJ/i+bf2guclUdS9EL/OfQUx
	TB8qHtP36B0ydNl1iZURPjG8RqXHQkMO20gA+hqb0sji4+gko4PfAuudcPxo2XyY8VBbB+0+DsH
	HNEDBvJRPO47FH8b1+wnpy8NKuGK7YLRPUy0spDlV0ubnPqAfKVaUSJEhOm318DZOQi1szzgQGz
	4bQy+6bAIUOtwxYJNP3FN6YsijurDsEHXu0mXXagl/HV+P65FjGho/jqP5e+DpeALcyzrai2FHC
	Oj8Jp+2rR6OQUhBrpsEorl+Q2SupNU5Mx2yl4OO3wu1AMXiJtcTVXrj0gmQhzg8ZYv8DBRb+1RS
	GjkgxI0AypxA10GNFbXx7qBW183aWzcBWK1m6iDMxEctxc/EKEkjycMYz+q1VeKNTc=
X-Received: by 2002:a5d:5e85:0:b0:47f:91eb:342 with SMTP id ffacd0b85a97d-4816071addfmr48543973f8f.13.1787041648823;
        Tue, 18 Aug 2026 01:27:28 -0700 (PDT)
Received: from [172.24.138.145] (ipservice-092-208-247-184.092.208.pools.vodafone-ip.de. [92.208.247.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b51asm10172929f8f.11.2026.08.18.01.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 01:27:28 -0700 (PDT)
Message-ID: <6f2b715e-f62b-4b6e-9605-23d6978b6cbb@gmail.com>
Date: Tue, 18 Aug 2026 10:27:26 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] dt-bindings: iio: adc: Add AD7768
To: Jonathan Cameron <jic23@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
 <20260813-ad7768-driver-v3-1-cb554399ad26@analog.com>
 <20260816192409.145df670@jic23-huawei>
Content-Language: en-US
From: Janani Sunil <jananisunil.dev@gmail.com>
In-Reply-To: <20260816192409.145df670@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/16/26 20:24, Jonathan Cameron wrote:
> On Thu, 13 Aug 2026 15:56:54 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
>
>> Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8 channel)
>> simultaneous sampling ADCs.
>>
>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>> ---
>>   .../devicetree/bindings/iio/adc/adi,ad7768.yaml    | 338 +++++++++++++++++++++
>>   MAINTAINERS                                        |   7 +
>>   2 files changed, 345 insertions(+)
>>
...
>> +  adi,data-lines-number:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [1, 2, 4, 8]
>> +    description:
>> +      Number of DOUTx lines used for the high-speed data output interface
>> +      (distinct from the SPI control interface). AD7768 supports 1, 2, or 8
>> +      lines; AD7768-4 supports 1 or 4 lines. Defaults to the maximum number
>> +      of lines for the selected variant if omitted.
> The default statement is a bit hidden and I'm not sure useful as it's not
> an obvious default.  Maybe drop that and make this a required property?

This property was required in v1. It was changed to optional in v2 following a suggestion to use the highest number of data lines as the default.

