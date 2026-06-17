Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2C2EEE74
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733871; cv=none; b=C+28QLx3C8bRqBTZhy64+eX9TK6YW1iCKEDko9O5Gk7M6Chj4YXRtPMWuy7b0elf8kxB3/PBfQMOvDgAsqF+2cYJWKNDQZFzbdAesyWsYrwJ/jDczF4QRvfH0KOrWo7t08bu7l0fO8wIE/cvwqdn7JbjrbLW97jnM8tza5Ewpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733871; c=relaxed/simple;
	bh=hoUViAfvoZsdvCJtYfwxPDW+hJ/pqsKtq6bGvWIPTOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgGn66RCxSnUehcLsB1Wv7GO+MR9Rokdj0aLDKGrB0qqUEbMdxddD3jw625O/8vwtLS1+i1CM9zMzii0i+rLvzmm8uR8qwPC4zW1xOr4A8Vy+j4C5KGnt2ShP2MBSlrpsZIHVtygdRQYO5ZsJPQbZTqvWy8GvQqKyQCATg7+vO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ysn+SBqX; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ysn+SBqX"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6b554044fso225163a34.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 15:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781733869; x=1782338669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T0LbBI+FU/KDwYzYSVcJiiga5DiPx/zovQTtBWvE53c=;
        b=Ysn+SBqXI9WDcmUjDYpQ108eXB9EZsjleIZlOwCrV3wIQKjSmFs443VTnfxuD62Ql+
         NDlsSMr2TaxLwR5YlF4Pt72HyODQJIN6NLuZq+BJmFtPztLTKUalNh1mFwx3/q3qu9Iv
         FhAUTQbKfUwoUVqTg4Zl326LCP7prLPKHwD+hD16YzxnC+UbO8zveP2SRDK+IVU6iuRW
         /lAp/HXgIbn1qTTJ6ajXMGADh7DLKC/8VmxixG+40ZPfgB8qWl8j880ob9g1bgifAU9H
         F86g8wEhw3G/q2FbT+wwv8hh4PdFfjXDf9H12UEsT19H0+dKiitu9SJVorR83uNg04z+
         a2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781733869; x=1782338669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0LbBI+FU/KDwYzYSVcJiiga5DiPx/zovQTtBWvE53c=;
        b=RClL6TWW14HEDCKey2Zeg8R9laYfiFldquFw+iTR6xOtDBgMfTHngH9ilmmktMPo7e
         m8d0jO2diTS57uC/w36wepOfTYIowp5WKHG6h7MAz589l0vYtcEhqeZ7xEFc4F9YGN3Z
         8WstEzFqVwiTtOM2xfKlzZscT9L3X4Xl3yhaQhD6jz3vZNrv73EC7zfqnvDh27WiElXJ
         E2Svei51OjwG+nw/YotHgGmvEFLtJ/auSF46GunZGdl2/ZFFCxwx9RUUrkw84cXJwTgU
         onCqq76J9Y4D0/M/L0vZS62C6MEug///3nt2f+sJw6TcfU4cvXkALpAx7ERlM8p+6U8I
         JhOw==
X-Forwarded-Encrypted: i=1; AFNElJ/lVqDRCnOOMOdmSxCgh7mVz3fOWGq7i08OFnnYmwJeMjQdNwtvEU9guGxRMAErHY5hnNm2ryATihg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCmzrp4Fc+NITl+itcFV5ER0kMGtHDlHrw+l67+GbBUg5VEy4
	CTJXovG+vd12jOmAyz87TGBx63R5Un6n1avOmfjXHpDhaH2rtuc5r5Q/ij9q0RCiv0Y=
X-Gm-Gg: Acq92OH5bZz+joOgQqh8Eheb9QWlR2mxPaJY++kanukIj7unw8mvJjF1OW98X1Gu0D+
	Yu7eeA7kr00U4IJeBZ5dTJgaN+fXwx2hwrWsgo0RkpWf8t6BIZbfffTFZFOV84YN8OYlhdNRN1S
	blDOJObaEBl4pW1+dmCNFjryD7k0N3zBSJ1sqjqdVDdbIcxexnbuPtDi82OaeFTgXNPDyvdI8aO
	O9MbC5tP1zixOGJEeMHvVQVJM2ODdFvP1NLCgDDpiVpqo7RKIEPB95ixQR9bdOoXq+qGEmzLT7v
	gZeF882ehSXJxyNVLsnneC7J7SFfvClse0ajaMgiRQ44a/nFkG1meiO2vomeKTHH2YcYX1o48b1
	LZYqd0QMu8ksEgyFf7ARh/DBXpLPxSd0IyNZhT3vLSn07P9i9g4gEGd8KwZtdu825GUXnFRvd/e
	PnGQTgpHhNHz91fWglT1+8ON1i1QtUWLC3ToLDa2GbfDudrgnuvHgl79ERGhj1tGE=
X-Received: by 2002:a05:6808:3084:b0:487:4d74:ca6a with SMTP id 5614622812f47-4894467fb82mr5608088b6e.39.1781733868747;
        Wed, 17 Jun 2026 15:04:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:9458:d356:778c:22ac? ([2600:8803:e7e4:500:9458:d356:778c:22ac])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dfb2d32sm6991645b6e.15.2026.06.17.15.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 15:04:28 -0700 (PDT)
Message-ID: <76d39d2a-051d-4706-8433-3d3eb97e7f2a@baylibre.com>
Date: Wed, 17 Jun 2026 17:04:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: adc: Add ltc2378
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 pop.ioan-daniel@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <f9e88abdbd23df8039282497a81d3c8698a10665.1781661028.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <f9e88abdbd23df8039282497a81d3c8698a10665.1781661028.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 9:03 PM, Marcelo Schmitt wrote:
> Document how to describe LTC2378-20 and similar ADCs in device tree.
> 

...

> +  vdd-supply:
> +    description: A 2.5V supply that powers the chip (VDD).
> +
> +  ovdd-supply:
> +    description:
> +      A 1.71V to 5.25V supply that sets the logic level for digital interface.
> +
> +  ref-supply:
> +    description:
> +      A 2.5V to 5.1V supply for the reference input (REF).
> +
> +  cnv-gpios:
> +    description:
> +      When provided, this property indicates the GPIO that is connected to the
> +      CNV pin.
> +    maxItems: 1

Missing pwms property for when CNV pin is connected to PWM.

> +
> +  interrupts:
> +    description:
> +      Interrupt for signaling the completion of conversion results. The active
> +      low signal provided on the BUSY pin asserts when ADC conversions finish.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - ovdd-supply
> +  - ref-supply

I only looked at LTC2338-18, but it has a REFIN, which is optional.
Nothing named REF that is required.

