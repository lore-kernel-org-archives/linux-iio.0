Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357BF3BB9F4
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458987; cv=none; b=XBHE+QkpQHEECIGYui1CpIG0YkOdE9yp0NlyiL9hiFM3kpB1b7950SSKQmDKH4da3FWBEcbyTnXv00vK2KwUewxxieae4DSGuPP4tukO1yUmVJwyYx0y/G0sS7GJa2VsucazfugecBa935qdG4ZXHZ2uCvDPeDb9Ph+tGNs332k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458987; c=relaxed/simple;
	bh=Div5yxlglnPNlEq92sKIOutbhS6DoZJ3nxXjujNwMes=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LfCpevevpCox6H3kMU9hXii7r2b/VDVFf83EyrYzK97VsIXcsCBaL/WsfwVEyUvP9PM4VI0axF+/eseiKSMrv2s6UbOLT9ymatwQ2cpTEnuOlb3e7GdnlTWVgodCA2uHAs7kK1poALcDFE2bkTquWAh/UWhNMCq44Zd6TD+J32U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=XSc22qUF; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="XSc22qUF"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-484cf882ce5so5215643b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779458978; x=1780063778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dnryr+x2yZjU4omLfati+UlNE1xmARQl7d4bNblSI1Q=;
        b=XSc22qUF4gqrTobBtfmVS5fbH8kJUSmWj4AI8oc7Szqiu2jz7n7M0tCvIzQKzDGIG+
         PXphBxXVbCzlfZpEGMgA8gUmpIDElxer7mlz6MXM7ufHt4muowP/a2SbtxEE+js2eawD
         J24FZhKCX6huSmwErP5AfJuJFrXuK2n1ruW/JeOg9rf049cARl3wHC+AFfh0yYfm0Otk
         JNOPKOGJBeJ1ZDiuNlFrz3nhBj055qkhMB4+5pRq0yzwuS2b9mc16tk49KpqqqWyQhhA
         t6CkQvHeTxFLwDmnuEqDFUi9BB3LTA+D1lqNLk06CjApD74K3cD94Ev4En1D6OJCTzR3
         1ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779458978; x=1780063778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dnryr+x2yZjU4omLfati+UlNE1xmARQl7d4bNblSI1Q=;
        b=V0bE9wZ5nMKt+tptxRQeILyq3mqJL3xz1rblTCl9K2SP+flZUHBtomX3++qA+ojt4K
         XhCxMn6Pu5Q1rIOf2AT1KM2LlOO84q1KDamPb6Xfe9EMP8ivPM7mIyTBaA7Vjxep5F7T
         yb+i7UvSeVnw/Af63p3Gpqq2kelsYo+QqM+/gBPjD2Mr2OjV4FGYH1Pm58tOA0NQgwB9
         82tPv9ZicnsmG13QHC9rhSreHuJoQ0WfGG2Rn0ivgALeGM+uvaqIdqQj/8zxisFLUv52
         zbERCg5E2imFFKNdDn1/9EwiBasRM+EsFH9w6pOQvIRlw3wOG/vlsrghoTvL5s9eeNaE
         i/uQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9Nns2CkxDlPPtHFRO2Amb+9lv4r5VeEOODa2klEK23uJGdejaP+9owf9YYRG2pm1ijOaIlH8V8Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Trpu5x6yPaBdIo0VHlFaLv9nPkVN6AUVHuRaBcg/RFZH5dtp
	ZlZvxzcopWiANqLd7yBqzvkUyvhPiCViFh6iRxYzY1gqm5ZVVC2ZOXxr9DqvymCugbE=
X-Gm-Gg: Acq92OGuna138sq9MhZARxtvHhMEfWOx1+JX53CjPQqOfkIqSXT8riKK3oMiwkwg3NW
	H7Bt2eLzAUUMf3diLXKlMb1EACL5P1WgdwkEg9LXppL+nXrJpApesz9rURXDgP8ZOvFhMj3Nce9
	gwxyKaS8WQ+WvtDL4AEavLFrNnInWBzSm6Xu0tsKsp6MwhkLC6/TKjXfkpKN5gCKGe+AqbrW1se
	rP8Kx5m7OoXLmhcQ1wKgz9oobmg878oPhtBN7X3ZJowP9v52snzx9zKEq+OJgaz+fveGJ1mgVHU
	F21Oq2sifph+8M/45mPpoxUl7K4MXmVA12rXA1+Xql1LgeZWjyBEUKnHfnlbNMu3Qdy1n9yPpf7
	8Zc8m+q2W45M73PChtBbsBa4/Z8h3Z0kBjG+ulkxZbhP1Q5QkwjrT0ezBuV1VlwpZZuNWVEHRgF
	f6P1Cw74BIGSe4QTeGTLoizglHIdtbwIRN2D6qNIKkHGjArKYG7Vd0vFuMJQMTFAMxopDpaXLzj
	QBMfL+F9FQK
X-Received: by 2002:a05:6808:4f6b:b0:467:268d:31cc with SMTP id 5614622812f47-4854a169876mr2339807b6e.26.1779458977741;
        Fri, 22 May 2026 07:09:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:26b1:32ad:c1ad:687b? ([2600:8803:e7e4:500:26b1:32ad:c1ad:687b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485546ed055sm531458b6e.12.2026.05.22.07.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 07:09:36 -0700 (PDT)
Message-ID: <ef6deccf-f916-4fe7-8561-71620a8a7b59@baylibre.com>
Date: Fri, 22 May 2026 09:09:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] iio: temperature: ltc2983: Add support for ADT7604
To: Liviu Stan <liviu.stan@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Francesco Lavra <flavra@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
References: <20260522132321.1641-1-liviu.stan@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260522132321.1641-1-liviu.stan@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/26 8:23 AM, Liviu Stan wrote:
> On Thu, 21 May 2026 19:18:28 +0000 sashiko-bot@kernel.org wrote:
> 
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> New issues:
>> - [High] Reading the IIO_RESISTANCE channel bypasses hardware fault detection, causing hardware errors (like broken sensor traces) to be silently reported as valid data.
>>
>> Pre-existing issues:
>> - [High] reinit_completion() is called after initiating the hardware conversion, creating a race condition that can cause spurious read timeouts.
>> --
>>
>> commit d382a4cbefd41723ab5ddd91fd399d716c8faaec
>> Author: Liviu Stan <liviu.stan@analog.com>
>> Subject: iio: temperature: ltc2983: Add support for ADT7604
>>
>> This commit adds support for the ADT7604 temperature sensor by repurposing
>> custom RTD and thermistor types as copper trace resistance and leak detector
>> sensors. It introduces two new software sensor types and exposes a new
>> IIO_RESISTANCE channel reading from a separate result register bank. The
>> ltc2983_chip_info struct is also extended to use a 64-bit supported_sensors
>> bitmask for the new types.
>>
>>> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
>>> index 326f843f42713..e2ffeee026eef 100644
>>> --- a/drivers/iio/temperature/ltc2983.c
>>> +++ b/drivers/iio/temperature/ltc2983.c
>>
>> [ ... ]
>>
>>> @@ -1205,7 +1502,8 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
>>>  }
>>>  
>>>  static int ltc2983_chan_read(struct ltc2983_data *st,
>>> -			const struct ltc2983_sensor *sensor, int *val)
>>> +			const struct ltc2983_sensor *sensor,
>>> +			u32 base_reg, int *val)
>>>  {
>>>  	struct device *dev = &st->spi->dev;
>>>  	u32 start_conversion = 0;
>>
>> [Severity: High]
>> This is a pre-existing issue, but can this function experience spurious
>> read timeouts due to a race condition with the completion?
>>
>> Looking at the rest of this function:
>>
>>     ret = regmap_write(st->regmap, LTC2983_STATUS_REG, start_conversion);
>>     if (ret)
>>         return ret;
>>
>>     reinit_completion(&st->completion);
>>
>> If the hardware conversion finishes very quickly after regmap_write(),
>> could the interrupt fire and call complete() before the CPU executes
>> reinit_completion()? This would overwrite the completion event, causing the
>> subsequent wait_for_completion_timeout() to spuriously time out.
>>
>> Would it be safer to call reinit_completion() before initiating the hardware
>> action?
> 
> This is theoretically valid but in practice, the conversion requires at minimum
> two 82ms cycles (167ms), so there is no realistic window for the interrupt to
> race with reinit_completion(). What do you guys think?

I would still move it before the write so that it looks correct
and others can copy/paste the logic on other devices.

