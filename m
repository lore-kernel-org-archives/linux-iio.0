Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF03D332E
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066899; cv=none; b=LXCI/Uxa6Zm2y7LH+3yP8p7Z/2TF1KmT1TxngWfUNm2Jb1zNSVHH2CrsT9Q32vJQKpsEKS24Vp6ALAxZgzmVbuWFe+Tcbss1Sw38FQ5tWrJrUZZxGHNLU1wvKMTdEP8ClktE2UHoCIDHbO4qxVDgVoJXAq07lEuzgLWPr2EUz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066899; c=relaxed/simple;
	bh=dNwjQS4Ze5AVUXxTNwwtAMEcTV30AgWPK58E9Q8lvj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtaAmHjuRlfRIX+XwaXTBU+7L/BQIpDvyfRKqnNueMCSSUf+e5ubc+826tV2WlsLLt++dOyNj6TVyLnlVghlOhYWW34FBFNcpCImwn7ieD1kLWZCsxAgd0+g3JUZ1twBNHWwDKNZ6lIsfeQVIyfx4b/zIaXDF4NL2+TlFe/lEu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GEXiLin1; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GEXiLin1"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40423dbe98bso2874150fac.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773066896; x=1773671696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/2nZ3AXN7tfnpTcvPfto5djcQ417TUS0Z4ffFdUirY=;
        b=GEXiLin1J3e1ijArnxDfLr/g0ciKQbmfyg6/Hx21Jq+d0zHsSMrywyK4IrniHzFKMl
         HrMxakK6BqyUtmSCAGTiLCcqixpocqZPiu8vAyzcjU2r1NcnCCcq9uA5sVwKbaT4Col1
         S7ZSZMPMv8M2+QTla/MR/LwFt6Lqi3U0Dh0L77vmX7KrsORbt5Lt8K6JVfZCrnhnx/EN
         g5KTjoMsHJHQzK4Kik87ILDrU7YKxJ4apuiZ1mX+KK0gc3MvdwDg2TDdrGP8jC7dzkDg
         7nVSnxVJf4bOdYk5oskF8pOZYTnlTv7C+UAyZwEsqF49YMjRAzWwZQgrkz3Tqu4mGnGH
         eYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066896; x=1773671696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/2nZ3AXN7tfnpTcvPfto5djcQ417TUS0Z4ffFdUirY=;
        b=Et4cuXgJ5NNMYT1x7OXHmbrYsdqY6tzcnH95sbpkg5Aq3D5Silun5q7EXyL7SNUESm
         u2/PmPCKcMyVvlXDFHk+LCLY4MVWqm8lZpeBXaQWTnlX8hepSNtjAJ5jck0j3Yg0Ap3M
         PxupegY+CCGfgjemjR9V64AW8x3enfXda8PMuqoO8KtGfGsYMMe05qVXqsWPJ6SjvGpX
         HW39nSfDbRy1cgKASYQfNOW/8UvP7vhYB3yg2ql1SzBiKsq+BRMMPtFgGUD1gdnp/Yak
         HAX0jkqrxBCnyKpxCXJeqlp4/I7TZYWd5jhn0ciw78nvOnHX9wtekDn+7gPaAeh3uyCt
         ezlw==
X-Forwarded-Encrypted: i=1; AJvYcCUq15e4PmPqyf+8jSUcNW1hmNpPMlozOUc6f9nyWn4gkRYSmBIwxc3NAfsxmaq9rmi07SvR1m93tlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4QEZH98Aw8L32h4fWNphTO0beww3C1sFSr3nTMuwQOEwLFn6i
	J3Bg0CTNcew3oezv4bVbeJACkQlMNVL6WYl51Iz0gjnJe61nykwG328pMpn8TcME43A=
X-Gm-Gg: ATEYQzybSb27Iiu4+vI4BHXbS9jUow/jTd7+b9a9hnl1MSs/LmYj/wP2I+PT6sFH+0y
	0mjS2mhJ1UudDEVeJuUfcqZrPimzWIbpaY6TAVtiK/z7PpFeFC3lDkPI7IZDHmmED7oPP1Hz2I8
	R2iw8PkaLkqmWJDjl/uqLFgr9xTIo8/B5cs0Prnj0iBux6IwdSCSYUgf47NlJoEugZ1QDwZZF8e
	OAYoy3+eazEa8qNRU1++0Mmdl7wNcYw59pjcNOjN1vMu7/NXUhNGXRLhDJ/Kys3uyP9BAPTWO8G
	r38SIKq9prmf5CfHJbndd8y+GnC+DaP+ERBkojh2JhSQJLry9HQlcbR5z+dd5P8bQbOHi3ogxdp
	9tQ8X9ejC7btZyCgjauUEii/AAovr1tbX/dWpQXVdMde2WwFzkPRorSKgGqw8VIoauBlfINvrxp
	c9CyP1Sq/e33P+juZKWYMGkqWMJCbfMxbqTOxIuwOsQI7PU2liIAx+MIWywE3SzEosOl5f
X-Received: by 2002:a05:6870:8a21:b0:404:263b:9da1 with SMTP id 586e51a60fabf-416e3e84a31mr6480974fac.5.1773066896060;
        Mon, 09 Mar 2026 07:34:56 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:77:c35f:9c1b:c75f? ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e6836886sm8715938fac.16.2026.03.09.07.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 07:34:55 -0700 (PDT)
Message-ID: <b4aec378-879e-4a8b-960d-051cd8b94615@baylibre.com>
Date: Mon, 9 Mar 2026 09:34:53 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add bindings for AD4691 family
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
 <20260305-ad4692-multichannel-sar-adc-driver-v1-1-336229a8dcc7@analog.com>
 <20260305174559.1ded5173@jic23-huawei>
 <LV9PR03MB84149F32D4CABA4D2827D85BF77AA@LV9PR03MB8414.namprd03.prod.outlook.com>
 <08717cd6-a732-4f06-a6f1-8cbdaa755b78@baylibre.com>
 <20260308182839.19587743@jic23-huawei>
 <SA5PR03MB842501D7A27A10BC203E5433F779A@SA5PR03MB8425.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <SA5PR03MB842501D7A27A10BC203E5433F779A@SA5PR03MB8425.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/26 3:57 AM, Sabau, Radu bogdan wrote:
> 

...

>>>> Regarding 'mode', I agree that it should be something that could be modified
>>>> at run-time, especially since all register modes (CNV_CLOCK, CNV_BURST,
>>>> AUTONOMOUS and SPI_BURST) rely on the same principles of reading the
>>>> ADC result from the registers, the main difference being that PWM on the
>>>> CNV pin is required for CNV_CLOCK and CNV_BURST, but the board design
>>>> stays the same. Perhaps this PWM can be initialized at start-time and only
>>>> be used when CNV modes are being used. This would mean mode can
>>>> become an IIO attribute that could be set by the user at run-time.
>>>
>>> More likely, it would be two different ways of doing a buffered read,
>>> so maybe two different buffers? Or just pick the "best" one and only
>>> implement that mode.
>>
>> I 'think' burst mode is really an oversampling thing as you read back from
>> either the output of an averaging filter or an accumulator.
>> I doubt there is reason to support both the oversampled and raw
>> readings at the same time.
>>
> 
> I agree with that, perhaps burst modes (CNV_BURST and SPI_BURST) could
> be dropped. Also, AUTONOMOUS mode could be used for read_raw since
> its compatible with both CNV_CLOCK and MANUAL hardware setups.
> So, then if the 'pwm' is present in the device tree, CNV_CLOCK
> will be used for buffered readings and if not, MANUAL will.
> This will indeed not only simplify the driver, but also keep two important
> modes up for choice for the user.
> 
> Please let me know your thoughts on this approach.
> 
Sounds sensible to me.
