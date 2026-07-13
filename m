Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D033AD85
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954559; cv=none; b=A69gnueQ56ybv9SoZp9vx2dgV2cvkBBddENab7xveZ2BCAYpc58/z9pUfo4KolpFv0kn5hHwQuXSlo01dUS3TXvUBoSbWaW6xt6xSKkQGmWNDbdFyN21ThXsC2QdSepDPbPFpfW4FMpZROaIEV2zxq8nzDRbb7pAG9KGpkYlvKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954559; c=relaxed/simple;
	bh=YELl1y3J0mGPUhcgSqbaaf3tbHR8Imjyjm4zvt2BTb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBshlFtfNeGSuESpMZokuqXiFfaoc+bfVUULAMd/ng0Pq9YPSCmB/KncUrWn5kzdOGP//9NkSSliF2JUUV3Me1VELYZPdkm8P/o6ISMSgPK85Fg5NbPXVtHmd6CT7fRtv+oE7vW7iAHLycBdHYqsjO4ZsgzUn4ZEzzm6Mmp16q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=d7xaOHiW; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="d7xaOHiW"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-73b7c3791dbso1658736137.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783954555; x=1784559355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h85/e4FosMhyyW2A5K8lpjg8Eb2pk4okTuj+ceX0Hik=;
        b=d7xaOHiWL+u0VKSs6dQuhCTLOVtoFhc7fWD4NjASNttxn5U4PqN8/OZGAASBEe/QAo
         njNFmWhLxo/r21AbflFt5C62U8DnMuTKzUsVmlFV6dh+KgFkJRyprfxzJU/v6XF9Ll81
         7UeY1puwsXXnvYTo+lz4DI/R4THEbb+HwkEPYIxpzUZdn8NdjFgQJmPwCvZRFoOYg5pI
         791GccvKbodjbpnCDJ35PFjW4nJYD882PjaD8XD0HoMoZ1YAQvuOJWru/UMJS9UEvVZV
         IN8LiMdXUFXrT6VPSLmqJZcy7aT3/e6RAkqSWYXi8xJ6AxJWHbXS3y+PT1E+NvzgYSQz
         /isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783954555; x=1784559355;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h85/e4FosMhyyW2A5K8lpjg8Eb2pk4okTuj+ceX0Hik=;
        b=ZAaRgPu+agBfwEWpWbHfXeJyiAeYUBxKqnkOxQ2pDXzdVLbvAhLwJ/DOAttTAjiQuu
         gjn8lHuenb3nX5du99CES6ixtPAhEEGmOFDKEsNpM92HH1puc4/7Mgo4zKC9MNUHci1y
         YMy3XYpL1T0ZV02v2pdw0uvr1l7uJXFx47Yib6vKAyuBTZw7TWTmvRUXJ+hOUwW21gCz
         jzQK8ZaTTt/+EIMlINEmg/Ob2sGWPFnVgLWmlyCfxzLx56/HYQSdzK8TWCWXyrG9sHj/
         RfCEt0ELYngmMhf3ZFNc/0DTg/1ziyavWESSIWUwFFHWvRi1MEsNE/6SCio5CqQXDBWF
         NpYA==
X-Forwarded-Encrypted: i=1; AHgh+Rosv2e+J6siVNh017+Trxe2eOFNNEfeLSUg1Ooiqz0JWAKdJ8kpiQFSaABQ1xt6Hm+c7Kdx6iR2TM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6aZsjC7koM00qMdezvfP31+qzd9HhylZ2tb962Tb+eC0GaDu
	zjaogExctxsCPah4AGE0F7won6B8KGCHLblHF+mow4xeFQm+5Tp9e2ng8FjrFZMAYhE=
X-Gm-Gg: AfdE7cmu9E7pvIXzwx/cUZAFhCqhvplPnopIx3Nkwwmv1Pzf0GCv8bRNiH0Jp1T8dwM
	kQjGtTvgFxl2j4qWrBY89946calO2y6xmoRYbUXrAlMl80yUO0TmUNy3/L27bIpGTnxL5X3LM9Q
	6cRnEuHU9TPPMV7FrKWMuosXFpVoeXD19amkFHk8wjzBpYC99VbtbKv6xtFkBwGneY/1OQFK5N6
	MZs95m5QhNpcliWHfzkhSCAgS5MM6DZ5iyh/W+j03xN/5MBSR5iTJEnzdlgn7SlYiVh3Umua/cA
	cBbwhDB9HGEFTOFCFaUIaVY1mjkqRtTZ+mTj0L944AhtIFMGtpoaOtMDaUTIeeW447pcw+cI1j7
	TxyP0Scmn8ISilXiWNye0ptZ1VMj/fYV4LhRrggr8zAti8ImAREfW728R48v5SUpnE2yO6sfeYF
	ihbrO75IaN+ziDLE7CeH9EVxb2QDGVB7+RHqbxHHMU70y8WXvbyr6QMAkI5IK42Hs=
X-Received: by 2002:a05:6102:f12:b0:729:1a8d:b2d9 with SMTP id ada2fe7eead31-74533e17d5amr5917697137.22.1783954555481;
        Mon, 13 Jul 2026 07:55:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:610b:e45c:5e0c:e14b? ([2600:8803:e7e4:500:610b:e45c:5e0c:e14b])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed25847e5sm7785373241.2.2026.07.13.07.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 07:55:55 -0700 (PDT)
Message-ID: <1700ed07-47b5-4831-87c5-a6115928baab@baylibre.com>
Date: Mon, 13 Jul 2026 09:55:53 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] dt-bindings: iio: adc: add input-chopping property
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
 <20260710-iio-adc-ti-ads122c14-v3-4-746d52cbf1d0@baylibre.com>
 <20260713023443.1a7a9acb@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260713023443.1a7a9acb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/26 8:34 PM, Jonathan Cameron wrote:
> On Fri, 10 Jul 2026 17:50:37 -0500
> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> 
>> Add a generic input-chopping property to adc.yaml. This is a feature
>> seen frequently in ADCs that are designed to measure resistive loads,
>> such as RTDs and strain gauges. Enabling this can reduce offset errors
>> by swapping the positive and negative input channels on every other
>> conversion. This can have side-effects in timing and filter response, so
>> it is not always desirable to enable this feature in some applications.
>> Therefore, it is best to make this a property that can be enabled or
>> disabled in the device tree.
>>
>> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
>> ---
>> v3 changes:
>> * Renamed property to input-chopping to reflect more common terminology.
>> * Removed "allowed" from the description.
>> * Extended description to explain when it should not be used.
>>
>> v2 changes:
>> * New patch.
>> ---
>>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> index 308857f11220..c408feebd46d 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>> @@ -80,6 +80,14 @@ properties:
>>        ADCs usually allow choosing between internal reference sources or a pair
>>        of external pins.
>>  
>> +  input-chopping:
>> +    type: boolean
>> +    description:
>> +      If set, the positive and negative input channels are swapped on every
>> +      other conversion to reduce offset error. This generally comes at the
>> +      expense of added settling time between conversions, so should be omitted
>> +      on systems with high-frequency signals or high data rate requirements.
> 
> I'm lazy so I didn't check back, but in my mental model of this, the DT is simply
> saying that the analog circuitry is suitable for doing chopping.  Driver decision
> on whether to do it.  Perhaps we can reword it for that?

Heh, that was the "allowed" part that I removed.

I think this is really more of a design decision between the tradeoff
of less noise vs. data rate. By setting this property, we are saying
we should favor less noise. So I think it is more about the expected
signal than the circuitry.

So not sure that I would add anything here.


>> +
>>    excitation-channels:
>>      $ref: /schemas/types.yaml#/definitions/uint32-array
>>      description:
>>
> 

