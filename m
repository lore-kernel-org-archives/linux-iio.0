Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3A42C4ED
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507792; cv=none; b=KnzIsMZCQYeMO4GMudWkPNVlrGQ/JY7sTaO2r9/sTgzRyJKB+L2d6d4JXFE1VQwT0mP0m4eOeKWipacddtklU11g15qC4DAJ0HzkRaOeODMo5xNYJEnXsgyxE1/EqYbGGol4fis08VWId83W5Hg/ZyqFgag/xv6ROY0fbtTFzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507792; c=relaxed/simple;
	bh=7wWRfOgAHNVaTxFv3Orz/thFdJ+yQdiNQGRNQ2UkQIw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HFA8PnFac+u1Rs0f/RPhMT3xZz++Gj/tHMA67KD9A476GMMf7K4GFvQq+c18NzhxkWV8Uz9TozokXt/U+WKrwDGCvoXiP4pJ3QbIr+xOVuILaZxwQKaIvgPvYTJlLVVVrI/9CusXfsuxMLmlJP3anTT8VRANPR4Q9Bgl8p6rpso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ENvhzYLJ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ENvhzYLJ"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6ab04bbcc8fso604304eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785507790; x=1786112590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OT5kpLMx1NAQDxJj+okIQJAeHFw/yj3RKxDWm0fm7Ys=;
        b=ENvhzYLJIbBAvpyvAKKDUgTilyUnExp8cLnLmFOuuX27cHm/SpZOrT2gd1/BPIHZmG
         z3SCPNvbHqeAlER6iaOzgOhedUISpNhpTW0cK0qwAMqBmeaBYY+/3xItF1VfMwsCZnkv
         nI9e/WNXFai1TY43TalsMNrgEHU62CVPfP6V9dciiFGZQB+X7X3HUuHpzk8QkR06yJvT
         AN9n9xFPMQKfJwdkkvjFbfG2QL20H036GmTyf24XA67j19ayurXV4mUQ8eiazZoiASv4
         Utmn4qc0YwtFKOOebV6SgsTiE0B6QFzF3zG6dwJPpGV737AZNvqd0cWbBYCRBbBrBGt/
         5PyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507790; x=1786112590;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OT5kpLMx1NAQDxJj+okIQJAeHFw/yj3RKxDWm0fm7Ys=;
        b=HHhC6MKeDN4OKUtHMLNF+0aYi9mJpYcvNIdV+qORA5hW7jtELYtt0myJPGzlAzheAI
         wLAr5tKIdDCJEVP2CfDKtff5y+6ey/B/opw+wrt4/Nfq/KKhQJMHxdIrSqwvmcdbifth
         rSh6LtOjA+7YrJdKdZ36Q2n0HW4nnVetRtVoQVFZRNFS47fjcVivDj8o/s8Hps6KY6Z3
         EhgY4dsd+IoE1qtIDhovCpX2ug/7a4mqNf6dvhdAva5266Zj8ciYxIl8/V6eeV1XFjCX
         22C+y8GkpSHCXOW6e00Bb0l91K6Uqjv8O3A5Vf7/Ljobctk7gzEexJiAZgc3sk2Y8KqR
         KHkA==
X-Gm-Message-State: AOJu0Yz1q4HiNlnkeYspvK7edwffv2cqKXHucg/0detIkz9hBEOqy2t7
	4uWiwHnyT1fChj0DWBnoHSoXGmuQCBZAs8NJyidBuiG/FPtF0N0rBMnNbIt0Fjzi1BE=
X-Gm-Gg: AR+sD10H2hL7LA867fvKY02FSuOHTrTsoqyD5zzBVqupRQL2pDmlINoW/GjfHNjPFC2
	MmnqLpAJWvBTpK00M9qM5yatPNCxT91TYXE4nIinvwLpV5XyQ3syiJ6L+gEfR69PpgNdf/YFgmb
	loB5efHu9vjqYP+tKv+QsEOIN67MapOmEWoWgAQMYGuqR/IyanedDpf4wN0NK3aXlgz3KdzC7vB
	2Lq0Lwx60/ZYmEO9d973S6YiPwX8bsEoHDmB/hMWVyM5p7LdIWQGmWi5pyhkZN3vWuVfWaJmRbN
	RXgPCyYFEv20fVONaBcocgRoInC4o5tF/mKLGoM3kypJyTELbGbzbrwa8EhCjicl8h/N3qb255R
	kiJHlEqoihte75AaQ+w9JItLt9SvMe1/Fz9ZkzSyBwOKuaMgUERKYqpsFBCUKQlPVFlQf2+dM2v
	whxkTdwwQhE6gyKgoiQylAIbPjX9MlmXSnn3EOVZrU6cjNnJJJyR+g2pbhcMei9to4NbGiofpcV
	IEIHQXP5KjXI8SKmpzS/kQ/XHEeOI+j5GWjEKg=
X-Received: by 2002:a4a:e90d:0:b0:6a1:4af2:f8e4 with SMTP id 006d021491bc7-6ae4339556cmr468939eaf.31.1785507789733;
        Fri, 31 Jul 2026 07:23:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:fa40:746f:401a:3b75? ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae3a0c5dfdsm957497eaf.10.2026.07.31.07.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:23:08 -0700 (PDT)
Message-ID: <8860e628-69e6-40de-94fc-4dd9154e23a4@baylibre.com>
Date: Fri, 31 Jul 2026 09:23:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
From: David Lechner <dlechner@baylibre.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
 <20260731-ti-ads112c04-driver-v2-1-aab0168c3c01@gmail.com>
 <b2297241-e0ae-4058-a406-348440798e38@baylibre.com>
Content-Language: en-US
In-Reply-To: <b2297241-e0ae-4058-a406-348440798e38@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 8:52 AM, David Lechner wrote:
> On 7/30/26 9:58 PM, Kyle Hsieh wrote:
>> Add device tree binding documentation for Texas Instruments ADS112C04
>> I2C Analog-to-Digital Converters.
>>
...

>> +
>> +      single-channel:
>> +        maximum: 3
>> +
>> +      diff-channels:
>> +        items:
>> +          maximum: 3
> 
> For this chip, we should also have excitation-channels, excitation-current-nanoamp,
> and reference-sources.

And burn-out-current-nanoamp.

> 
>> +
>> +    oneOf:
>> +      - required: [ single-channel ]
>> +      - required: [ diff-channels ]
>> +

