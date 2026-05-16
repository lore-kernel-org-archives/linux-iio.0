Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB83164D6
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778955574; cv=none; b=RagprcN0GdHhCoxH6xO9oJ9EPCgb96yJrjClnTmBqA1+1WRlsaSqFofPFyka7RZazdf95CLIhwzaZZeuOJM5MRS8mPmKfuxCfrf81KKnBxsU3FuVWY6DA5w+WNVC9X2jeJHXaix5Jwqln8Rv8XzJR/vqV4en+sThiGGmZnUWXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778955574; c=relaxed/simple;
	bh=rLKR92+LhqER84UDy7wFJ8TAKPsxlz8VEnn+ZLlqvCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z00zszvR42FW+055OKf14MjookkfMyArTaK65zw/jSA5LeFaiEDubiv+ZYRkU61BnnRe+rdSBt+T0u+FFoNXrm7kfyBdpUG9QLcFaQ2TK3BOVkrSZ/gvCDNqPcActEtnBbeTjtQAyWJnGdQ06USPudm/JcN3Uq+ikC5JJXEsYUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=QD96m48f; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="QD96m48f"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479ef2b78f3so1004157b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778955570; x=1779560370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6khnYJZuftIZrPxz/07tzI4y6u2DCVytnqRa+QnxXg=;
        b=QD96m48fdbGhJNiriB4Mn8kUsWk25RDbt2dZ/EHI5O5ozG2BMBE/QKG01joIZUdAws
         lGV8oyBxfjNTgYoe5vmdWUUObfORmEQTR0gSvVuAiX8wFTrQUldVNsjDJA3XL3QQdcV+
         C1FGx0Hp4Mm61KFBXGi5l2NEoIaZEdVF8Cc3AGREQlAp0YUINPlLYvvInUKNnIZjGUgl
         QHDiQ1HfjY0D17gDqiXg4TiFsV9hafwtW6+bgcVQ0xNR/1ZSmzShPbuc8eL4nVgWL8B3
         vebHSSFTQMTo+u5ug4+V2mOQj3XoIiU4PCKM98FtR+CwX/4M/PxhOAUFghvoYax7ZOmn
         ETQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778955570; x=1779560370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6khnYJZuftIZrPxz/07tzI4y6u2DCVytnqRa+QnxXg=;
        b=eBy0mrg1WvuBPLNFf1anrvViXL1TKVh3YPA9cJKAir72ClFL8+mZVBbLlt6xGtCIrz
         +jn9HQBhji/+8kc8acItjdZBBgRdtV/eYlaDpxZZSay2OIKsS6fDbHCyHX6kbrQ2icBW
         tECQQU86L9ErbnO6EZbthwkWmdNGDFlBF+MyMnIyg/mK0fwgukZnM57ckyKvIxy+yBSA
         JdEymhBNDC0l57yhJJHtOuftpAg7Fs+gPRDdA3qj7KYLqXUJNFvQlbT1NUsjYhPJD3Sd
         qGVeuujYOxKoMzk+AZamIy0jP6JkzsNEQQ8LjziLlPWscoF2Bz2Oezt5CRQ3Y7ysprou
         83Ow==
X-Forwarded-Encrypted: i=1; AFNElJ9vid035DPBVS6MWtzzOv9qWvySgT4hfwmAcEp+NhL2YR0ZQzJAXFp3EgecCkjcHZIWaRu8sZWcGN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtIz0PXn5wp/AHPt3CHDsXhZ0zbOyb7/+suWDbDKV2fwic5YxE
	xyGZvnd5c6V1KRh2A5SZlJRLQ2bJuh/VxcR7qYmZGzQn0mxz4WVkZrxvlWIBMwwGJyU=
X-Gm-Gg: Acq92OHk/7iALruFV39YAo/ij+rwsx3Z1dH48KHwh6WTTJRicO+sdkcQewO9jJzzlvx
	SIP1+oKrppQp2ae2JvoZjYdx0gDqOy4kEXhP6DYx6ahk3ZLWtQFLSWpMvzgndzX/1FHn21hZYhP
	Plu1SVzsEiH+RGVNaMgUOyL6pKnmF8Zi+AVGPDyAfrIJVX9f8wB75zejh7sfArWFJoLMgjLgUIA
	MdQT9eiV21u6kNobWkP8KSs0JR+z6nnTBkTjNzq72wAF0SPtnU6RAiZLa0wfnwZIQnq4qYmmmmZ
	koWzXIhRfRSEqnSXvVKZTQhiYnxrw3JzjuRn5C1oOHAAAjyh81VbWnVmqZeZkU1JzEqKMr16xr5
	xKUGisTi3lkZ+INs6OjzTsCGIRycPRYnT/eCGsI0UlaVubitMarVrij8dKWxCXpdq8lax3IoNHH
	xaWfyFN2oduZaAsh+9loz98zofMuBWZWwrASxJnOurUstEc+kQtZ97qulhsT8JDNt4YH4rHXDSa
	g==
X-Received: by 2002:a05:6808:e3d7:b0:477:10c3:cccf with SMTP id 5614622812f47-482e5636062mr4307471b6e.20.1778955570576;
        Sat, 16 May 2026 11:19:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc1fc0c5sm6913096fac.8.2026.05.16.11.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 11:19:29 -0700 (PDT)
Message-ID: <1da2847a-275b-4260-9d07-76ebbb2c558c@baylibre.com>
Date: Sat, 16 May 2026 13:19:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] iio: light: add support for APDS9999 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <cover.1778659152.git.azpijr@gmail.com>
 <f389419972fc790a25b6041f1212e15f155804e2.1778659152.git.azpijr@gmail.com>
 <d98bcb3d-21ae-4b62-af63-48fad4301f70@baylibre.com>
 <20260516173904.503259e6@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260516173904.503259e6@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/26 11:39 AM, Jonathan Cameron wrote:
> On Sat, 16 May 2026 10:28:47 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 5/13/26 3:10 AM, Jose A. Perez de Azpillaga wrote:
>>> Add IIO driver for Broadcom APDS9999 ambient light sensor.
>>>
>>> The APDS9999 is a digital proximity and RGB sensor with ALS
>>> capability. This driver implements the ALS/Lux functionality using
>>> the green channel, which uses optical coating technology to
>>> approximate the human eye spectral response.
>>>
>>> Proximity (PS) and RGB color features are not yet implemented.
>>>   
>>
>>
>>
>>> +enum apds9999_gain {
>>> +	APDS9999_GAIN_1X = 0,
>>> +	APDS9999_GAIN_3X = 1,
>>> +	APDS9999_GAIN_6X = 2,
>>> +	APDS9999_GAIN_9X = 3,
>>> +	APDS9999_GAIN_18X = 4,
>>> +};  
>>
>> Giving the natural values of enum explicitly just seems like noise
>> IMHO. I wasted time looking for an anomaly.
> 
> I tend to ask for this when they are hardware field values to make
> the point the values matter rather than just being an enum.
> I'm not that fussed though.
> 
> Jonathan

In that case, I would just use #define instead of enum.
