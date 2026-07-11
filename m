Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B0287247
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783441; cv=none; b=aStHt4kZ+KTFV2maTeT/+wGMekXPoZpgjdysdzrjnUUbUhd67tMVsxXiaTLh10ruw/HEzOvVDtV8fUJL9yqjuaxNNOXqUEvsruIXbWV+C4d72Lyiwrz1XCnQbVqoxLtFRk8tg2d/Mcc/F6KUHCFDK6tKSXw65UC5kWuqM0b1W68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783441; c=relaxed/simple;
	bh=ytnfegl7Qybj0AzCwxpuF7iUfDDtBrbX3UJyTbFECFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tg6at25xzzilt9w5EBHIqRM6EXaOFeZjwdxltn9XkGaLQn3wMht/cOW2LDxUNthpqfA0BLBihXBylRT81J2e46cGnkIqna3IzGAelu8cRPQTUfpFr/Rp5QwOAngb6mrEspZo2aTj3q8iRpvOKt1Kiukf6cdp2A4qqLN4a3oAlQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nqfb1Qyx; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nqfb1Qyx"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb4d532e65so883173a34.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783783439; x=1784388239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPASv6Zq6YY/gY0oEbRpb3fd8WBXtfv+ncRCm+l0SYU=;
        b=nqfb1Qyx+tiBLoFx4qCorjqcdUaW+NF5KZRAK33H7kZ7z9OBpT2CdoqglmKwIhr6tZ
         fSSoWlw24odf95XayfNIwzsX1U1xH0tXzESOMr8qO9pl9uaNC/ulEjUJq44DnauQr2/I
         XWa85atQ3G0w6JSAfHOwJrkEj3U33LN3ld5vQplda3aeDMUtlf6CRsr5QMI3AJzPlH/l
         hmeCwk8L7CN/6f8CaOE4kCes1iEsnXhtndLYInQAF0K2bSBO1rJReW4ZBe6RkoD9eAl/
         Q9vJLfwu/D0ErSDkZug7wsF2hWICLathL8uu3Jt+CPK0P3YFovq+GBVocVUMs8TF6ti7
         Emow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783439; x=1784388239;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPASv6Zq6YY/gY0oEbRpb3fd8WBXtfv+ncRCm+l0SYU=;
        b=msUHcxFgfqaCy9c3vot/4lkYOalKsN9IOcapZXx3DF3FJkXw+s9NfszFDAPvHTYIAn
         xVrRhWY+pRcSAmEu4xn7thHF32tAMlChfDTo1oq3VJDl0mhHwTS1+LkJT+/ESLNQEdL2
         tqzX/RPViehFKGdB23qqMjhVgHgDQDGXmBIR3BkTjYvSjDopyOBXrzsuUI5zyLlKfAFH
         +evAIz6D4yAjND5I3Ouxzh8eeqX2at2Rh2I/O44XMk3N4ENP3v74fyT1YCxFCiUaIWum
         tH5uHBeKoGOIqlWsiSxS8dOVsLUU2O2xSQ1ToOo3LXF2D4ZL5cFd9yY0aQxNt76DKW07
         K6bw==
X-Forwarded-Encrypted: i=1; AFNElJ/cR9nn9ED8nl8dzMXgCm41uW6+wYXxA86ul0yILfiFOW3z0VqmzNLCnCQqBLAFGA2PZLNapdB6iYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHHalzDNZJh2vWtSiK6A4K9mm2g82UnTJhdml89KnjQ8A8hjNf
	t6teTY0NaLM2+7ee09aq8Cr3SYL2SCJg7PeAryY35bxl4goQnqy1avDsRmNn7r3IgU4=
X-Gm-Gg: AfdE7clPowCvs1EzaPmk6Z2kJMtYsxsaO2QKyzKeknqtMwrtNXD12Y+fH4QcegXEOxM
	aMzo7mS7NXTKU/55eybUvgm0OCg8BpdXNDTpMMiIRAy0q4UDMNGPobk4KUs0+k1xVO4umhPaege
	uXW7jKvQhvQ9ndxcfh7QVVVIupeOiRqSupcoIMeDD1HMt8OYHKmIFsPBs7AtBlPxuFBHxkmqoXC
	TXYdkfE7rNX1zXj78r+Y+4V6tPTHUv3pJguhYqHIU7ASOm+AAx5gba599uW04e8TEe0KxDGlbuq
	+C6En/O/8JZfLgRT03/PaCwFNf3OHwpUwaq+jLRn5PRd6P2xM3Z7OnViliM8Xlx00FC1Q5165rd
	0p8BgF40B4RQSW1OlK+8n3cxwQyuHixn1QLSsD6qybg8jUK/YJzAMrkYONRcZkmvLlTUyeI1zTU
	nICXXWQsq0RHuD8rGir3OT1/bSn1Yftkm2iY7d99R5ETpr9jIr2TFXYEivnrRUhjM=
X-Received: by 2002:a05:6808:6903:b0:493:b6b8:c8b0 with SMTP id 5614622812f47-4a42ad7549dmr1908121b6e.14.1783783439274;
        Sat, 11 Jul 2026 08:23:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1b01eefbbsm7974781b6e.13.2026.07.11.08.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 08:23:57 -0700 (PDT)
Message-ID: <adf66856-1cdc-4722-bc3e-549122a912bc@baylibre.com>
Date: Sat, 11 Jul 2026 10:23:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] New features for the AD5686 IIO driver
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 sashiko-bot@kernel.org, Maxwell Doose <m32285159@gmail.com>,
 Joshua Crofts <joshua.crofts1@gmail.com>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 6:20 AM, Rodrigo Alencar via B4 Relay wrote:
> This is the second series of three on updating the AD5686 driver.
> 
> Initially, a big patch series was sent:
> https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> 
> Then, the first patch series added fixes and cleanups:
> https://lore.kernel.org/linux-iio/20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com/
> 
> This one is introducing new features:
> - Consume optional reset and correct power supplies;
> - LDAC GPIO handling (active-low, held low when unused);
> - SPI bus sync() implementation for batching multiple transfers;
> - Triggered buffer support, leveraging LDAC and sync() to flush
>   all channel writes atomically;
> - Gain control support through the scale property.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---

I made a few comments, but nothing critical, so...

Reviewed-by: David Lechner <dlechner@baylibre.com>

