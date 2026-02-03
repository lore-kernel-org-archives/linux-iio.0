Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C613D646A
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138722; cv=none; b=pZi297SXYuxhpH8Y/Vy8m4BsvrZwrEEXF2VTXYDGS3Jpl2+2Ymmkeb0+tPkOAgxEJKy3dG1cjrnEKIGKpB+Ra5HZ+YX4RCI5t/TgbCyfC4u+79YsLXgYaJYWT3xkql24pxPMdgKXg4iHPTVcjIxqoyOUpLkU0Wc9Zez0+rkhDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138722; c=relaxed/simple;
	bh=KvVwtGkYOu5PUrbVCouPvp9ISvZPAAdo9DySfRKviFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROKEVbfmLNRxDki7R7ZZFt7+w/fivilRZq3A3o8YOk3p0RRR2gEN44edwlVU9jTyCXZmZEoG3E1EiRLKpW/2CLDVDuJCMTXUZfQGOZqhVKpzFbw0yd+lkiscOvhoG8rnft0bxfczEdtvqaptt6sxJ4oLTT9Pne+wY0nKuubMHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E833CbFG; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E833CbFG"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-662f5c5507cso3497281eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 09:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770138718; x=1770743518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wy/dNsn4u7o/hART3NmXV1T9kIccTcgOCggRGW81zXY=;
        b=E833CbFG9bS7eGRz7RDodJUaeg7rVgQjtpwzJmr8FoEOt3kRviZf6HAPTNjzckqfTd
         ZAc7XJVGXdS8Idexo6B/8WeeIWWwO5UYI0JYCmGTo4V6Yf4i9MUCkq557tLkY4icQWLD
         2vhg8Ey83A5wqCkDzmbbQzSgzvR+wP0p2sckynfWOtxw51DJAAF4fc7qiE8FywZ6JhJG
         N/5xZa9X+hMdwN6L0SaAfcU5sAIQNw/85kU5lTH7HkHYK7GvlLw9j6O+eigfiCe6aLmz
         DkBNB4u5Cxe1hb8ILGJP8bM29Z/unudho4TJB7JOqyjUymHVT5HIdtelMvMtCWMOh5hK
         SyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138718; x=1770743518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wy/dNsn4u7o/hART3NmXV1T9kIccTcgOCggRGW81zXY=;
        b=q7oAu1Zv5c4KxSCK4+8ErxvKrMBOwm8Dh9TDbCc53mooMum2svu7Vs1kltjjlb48af
         oNiu2OPaVY//DWoHhwvQ+Q4bIlhJPK472LZ5a2Uw9749c4jWJv0h71Q0JBul5xEUaXga
         k5aIxrdr/gag3JP15WqRL+cpQM8z9ZGg5mGLBEkO4xuyYluMgO0ZHKqQdFMxhzF/5PVL
         9pVRFqEe3e18s2IaWEeS5dQrJbO3n43XGnf8jwrp1AaHiN39JRzhz5VN3uNdpc0dLPHA
         KXWQLXLkMDblvVe5s+oB8bCmrXYya4akHiVNSjC3WbzfzHiW3X4hlIujKgo4LrYtoyAr
         Brxw==
X-Forwarded-Encrypted: i=1; AJvYcCWmLLKS+7ED0ozWY9UxU2QmbafdDCQJGj5+fnEgAjlU9ZeD+bzHMQj9QgRHnumFMrfKOyho+uz4pbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpyIFC4LMEiiBqc1NEW8928sfsdb2nxx9VgBvEz4w1XIF/44WE
	NeiWBcuc0nAD/VdTy5GoqgSU7ZpbgvFBwn9GBEghKYvzc+sWgZHKiHiKtlCNOWfmn3g=
X-Gm-Gg: AZuq6aK3bGjeEBw5FZp5agOyoUFURRb0qeb8IP+/FYO+eOuHKrfTb+X99dgRW2MFy0G
	QTug5FNTChgiHXPc/KFLcb0r+GgaZkMN3D9LQPBj0xzBYAubMQByIeDOaOw3/cegHafCEZ+CFkJ
	2jIYNSaeLMSJhIWIMcK2a/ZeMYq6C9ZhSRfF5QZl4vPkXbi0StvarIaZBaZd6MAfgDLL51fTTbm
	pBxMT5G+8pAthOIRxgJSbtJvXH6BQw0dzx1mwrvOnsi+ym4OkVQjrCAD9f/HtgStKwzh1dqaEPk
	oI9S3jyuuu08/qvdlt6UhFUToQP2uegctEXmz8d8vZetqTuOx//1GyIvZQo7bpAV3wvXwpdYkse
	gxkbNBHr9PGws+CuK+DYu1e/fp3kiNtO+zMaNoHv0nCyJ0HtujDyJICmJ1/FOb7b7DyV2aw1ROg
	XBLu0+IMkrP0j4d1akvzS9pRuZnXYQUvS8plMZhqEp4yoPn1hgNK2Fnwo=
X-Received: by 2002:a05:6820:a01:b0:65b:257b:a898 with SMTP id 006d021491bc7-66a210468f5mr148431eaf.29.1770138717633;
        Tue, 03 Feb 2026 09:11:57 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8e13:880:992:e796? ([2600:8803:e7e4:500:8e13:880:992:e796])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66a35f7a4besm27682eaf.17.2026.02.03.09.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 09:11:57 -0800 (PST)
Message-ID: <b920f61a-02f8-4e6f-a2a4-0899d399148f@baylibre.com>
Date: Tue, 3 Feb 2026 11:11:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad4080: add AD4880 support
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260129152731.154368-1-antoniu.miclaus@analog.com>
 <20260129152731.154368-2-antoniu.miclaus@analog.com>
 <5d2e85cd-caa2-43a6-a451-3b822bd0ef01@baylibre.com>
 <CY4PR03MB3399D81C92B07FEC8EFA09B19B9BA@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CY4PR03MB3399D81C92B07FEC8EFA09B19B9BA@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/26 9:42 AM, Miclaus, Antoniu wrote:
> ...

...

>>> @@ -98,4 +127,22 @@ examples:
>>>            io-backends = <&iio_backend>;
>>>          };
>>>      };
>>> +  - |
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        adc@0 {
>>> +          compatible = "adi,ad4880";
>>> +          reg = <0>;
>>> +          adi,aux-spi-cs = <1>;
>>
>> We can already have multiple reg for a multiple CS device.
>>
>>              reg = <0>, <1>;
>>
>> So we shouldn't need a new adi,aux-spi-cs property for that.
> 
> Sure, that was the initial plan but for some reason going for multiple regs gets me to this:
> 
> [   11.396833]  spi_new_ancillary_device from ad4080_probe+0x4b8/0x5a4
> [   11.396861]  ad4080_probe from really_probe+0xc8/0x2c8
> [   11.397281] ad4080 spi1.0: chipselect 1 already in use
> [   11.397297] ad4080 spi1.0: failed to register ancillary device
> [   11.397317] ad4080 spi1.0: probe with driver ad4080 failed with error -16
> 
> While the aux-spi-cs works fine. Any tips?

The one existing user of spi_new_ancillary_device() used the multiple
regs like I suggested. So I wonder if that is broken too. The changes
for multiple CS for SPI parallel memories in the SPI core was made 2
years after that driver was added. So I could see how it could have
been broken without anyone noticing.

I didn't look at it too deeply yet. But my guess is that we need to
modify __spi_add_device() to change how it verifies the chip select.

If it is being called from spi_add_device(), don't change the behavior.
If it is being called from spi_new_ancillary_device(), then the
chip select should be verified as one assigned to the main device
rather than verifying that it is unused. I.e. don't call spi_dev_check_cs().

