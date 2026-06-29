Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C8C30EF9B
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742895; cv=none; b=l9wWF+mOjPtx1zR2UFJ5BlhZzzIAS97Ek2yMG5yEzNPTGS3upDTvMEeJnVQk87Yq3g7QqrrVG3SSRxDPRBdAAshVgPOZWb7YPWRWZhGbaYKKT+JRuytaVXBbEgszLC6jmplsNy3Uc5Zmz/wymXD/t143+84BpdlVMcCtor2rX4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742895; c=relaxed/simple;
	bh=LUL98Jii5NBy8DtVvh+AtTh3d0km+5BZJDTwIdlwhrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmSQtwEvVXSC8TbECmZFBuMESVDtZz2oFoWJR+jdUCn9XA26VIFEdQoBsCM+1W2GSyPD0+1MCINx8B7Bcxl4hocQ6dcTKkTqKHWeG9F2ZrzI2BvfFB747Z1LymXzPTTbPhst5G5Tgqmn88WT2Bx6vbwlzrVV2wp+ALj49rLGcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Wrbut9uV; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Wrbut9uV"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80bb578d58bso28268297b3.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 07:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782742892; x=1783347692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDNP0S9CPY60Cash/eNce/YjDb7GyUnlfdhuwl8jcI0=;
        b=Wrbut9uVX8ux6Dfpg7EWb+A/Tsd+axKgkPmeJt9T5fId3BUTlRQR8PEUJtf40jM3O3
         fvsBslFeck+1VZD1gJ65CeHRlTCwS+kyFaIa7NTwxzndlZ1fXd/PlQKr/zZRX6nEraGG
         4/oJkcnILmEXs7jx8PtcFX1NIrNgMN5m14uxDqjvEHn3T2R8WqhIc8eN68tm71Ilsge+
         CYXrveedg3/OyoGMRxiLqWnmFfrNa403A/FGnRC9FmdLswo0JHlTDGAv7fpo7uO1tujX
         xe3lKyONb017KgPCm9WiY+VFaTddj81whp1y0tCDRJW/bYoxfx+8HAo4DcvHKFfATmxG
         AagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742892; x=1783347692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDNP0S9CPY60Cash/eNce/YjDb7GyUnlfdhuwl8jcI0=;
        b=hq4YaPfLJYnOGhB51ptf7AAiFgo0R8a7DCtl92xCD4j2A7WsOe+nbhmB2XoPm60w+t
         fF4FVl6Kj8Qxj2zwmpZ+Nr8I3YK8mSUI2vAYZDakC4hpM8UnbOwlXzGQEPF4c6HgqA6U
         VgMUqmgvq7CQZyX73CcEdknT05PHGSNaChnx1OFPlO4ltHazRB0pKQCdeVAZeVIQHq4R
         MzGp0vIUKJT3QDpQELAEHDQxKHTALsTUz1wLguYlr2GCxxD1l1shxpr6b3jsdDsKEHph
         j+YBNSR29lD+nvy6P3C118sDHDsADzex/aobXCLkFo9MatTdxO1gN1CzM2gyLv2r88B+
         VZcw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5sc2x6gWEQ8Ib3Fm7MJQ1YaryPycgAbC24v3fr+MvFFLPic/74/7U/eS+nZhp3m+SCt/7B16oO8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPV4I8vGo0SXpsgLYX/PzkCS+gX8HSOZFwE6f0RAYkJZp2reR
	7QOZcVm9IbiSF5BGWPj/+3NHrKE0tOBp/Cq8R2+nlOJl59sfcF5pm7CdL8dd4NXywHY=
X-Gm-Gg: AfdE7cn9+Hu1fCuugR9GWlzquNpgcOi6PBO0I6gqSfAOfBbWhpgpdfXJOpWrjsMzlRa
	yU+LF9QqaL+/H5aKS9A1FNCa+V3VdP2dQ9NVBVDvJiwKZpPNV/bKANHOy+goaye7xR/1KBLrk12
	WAV1O3Ab591GNIdYIZdyj2DnQhBInQ/RiUBBf/V2yA24VAo2XMmCi4xtOFYb/ifrZv/rL4Wn7+n
	5YOLnHnVvNfBUqlf5MtLWa+O1ywDHL1Faxka0zCo7pPUUjr807OsBqI8GI8cbaqJ9/X5pKtVmon
	mJpKWFJJRneTq+BIqWGGnekoPMFn9V+y7YRxGaHclNgXy0N2YYM/THiTG6RAlCyCvcniLa8U1zb
	kKd9TRd3TL1t6MFZDC5eV7dzvpK3sJOSun02Vm8nCrGcTm7h9AFYgzkUnDTUsrh4lRt0fXMopE9
	ymLj323WU08ntbB2PMhHmwd0udK8VMYLRMP+eZh3tmYhxyzGGbjaTFdPrnyelfHjc=
X-Received: by 2002:a05:690c:e644:b0:80a:9ff6:c46 with SMTP id 00721157ae682-80a9ff611bfmr98380067b3.54.1782742892149;
        Mon, 29 Jun 2026 07:21:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3533:aa22:9a69:df1c? ([2600:8803:e7e4:500:3533:aa22:9a69:df1c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80f877b6738sm10710947b3.34.2026.06.29.07.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:21:31 -0700 (PDT)
Message-ID: <a16f61fb-4e98-4c30-8d4f-da084e27ebeb@baylibre.com>
Date: Mon, 29 Jun 2026 09:21:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: adc: Add TI ADS126x ADC family
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-1-4b1b231325ba@gmail.com>
 <946a30c9-01e9-42f1-bd2b-b7934fda85cf@baylibre.com>
 <DJKX600ONL4O.1YUTCD1L9FU8F@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DJKX600ONL4O.1YUTCD1L9FU8F@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/26 2:12 PM, Kurt Borja wrote:
> On Sun Jun 28, 2026 at 10:45 AM -05, David Lechner wrote:
>> On 6/28/26 12:36 AM, Kurt Borja wrote:
>>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
>>> integrated PGA, internal reference, excitation and burn-out current
>>> sources for sensor biasing and diagnostics. The ADS1263 adds a second,
>>> 24-bit delta-sigma ADC (ADC2) for background measurements.
>>>

...

>>> +
>>> +patternProperties:
>>> +  "^channel@[0-9]+$":
>>> +    $ref: /schemas/iio/adc/adc.yaml#
>>> +    unevaluatedProperties: false
>>> +
>>> +    properties:
>>> +      reg:
>>> +        maxItems: 1
>>> +
>>
>> If we want to allow single-ended/pseudo-differential inputs, then we should
>> also allow single-channel (positive pin) and common-mode-channel (negative
>> pin) properties.
>>
>> This will also require additional common-mode-<N>-supply properties to allow
>> for the negative pin connected to something other than GND.
> 
> Ah interesting. Why the N though? wouldn't a single supply connected to
> AINCOM be enough here?

In theory, any AINx could be a common mode input by connecting it to
a constant voltage supply.

>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>> +        description:
>>> +          Automatically swap the IDAC1 and IDAC2 connections of alternate
>>> +          conversions. The ADC averages the alternate conversions to eliminate
>>> +          IDAC mismatch.
>>> +
>>> +      ti,pga-bypass:
>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>> +        description: Bypass the Programmable Gain Amplifier (PGA).
>>
>> Why would this need to be a DT property? I didn't read this datasheet
>> too much, but in other chips I have seen there are usually rules that
>> PGA has to be bypassed under certain conditions, but not others, so
>> this seems like something for the driver to handle rather than the
>> devicetree.
> 
> To be honest, I don't know what would be the application for this. AFAIK
> when the PGA is bypassed the analog inputs are read unbuffered (?) In
> that case shouldn't this belong DT?
> 

Let's leave it out of the DT for now until we learn more about how it
is intended to be used.

