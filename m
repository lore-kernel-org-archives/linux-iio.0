Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC51336885
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773499148; cv=none; b=f5HbpfE3vJUzFh8Qcw+zwsm+T4GdtopUrG2nmxtnNkCeBSj/4KvkVGOLngKmZezAhDj2MDx6XnYcD3xI00LlqIrQPYzb+dxZroKh1eom3GjKmP4IiXF9Yu1tncNrAnkN8YrHTP5DxKOtRFt/F+JPFxjQl7Qqpyth6UQ1mSpS078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773499148; c=relaxed/simple;
	bh=5M+8FF18btNiR/OXWuCMOHZwYvMZZMCmX9jXGsGAsUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awDbvJaL33tOcQfTX7KjBwGdmQpNW781mGRqMOxkaFdOOCIWgiNIBPx3RPxGPuU/xP+DHZQwNa7sGS48Ve5x/oO7YIqj/5iKyny38Ljb4It3kKPQ7/Zxnl1b2hr6ubufv5fM7EFrb4fH7GfVHO9lBBXX2g/g/ghyS84iM48z0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MIOaTg7f; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MIOaTg7f"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40ea36b56b7so2280415fac.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773499145; x=1774103945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f30xM/Mb3048ZhnccFuHLAyII+0/eJw/DdO5W4q5nGM=;
        b=MIOaTg7fWAR5C4/7q4i1DiEjxFexoVTQ3GzXj8GT8+zCHWHGVMUPI3GOcyTjB2TG8j
         6x90oQZExaRCGh1q0piZyccq6i8LhPs8qH8elO6srXUem9LVhafXxwSf3QjSzST1FpK1
         l3JS5WujmUuwfDJ2ZeczclXEeNQbiaKfpZ3BAMb9D1IDZ9CqtSUEFrtf//8btdkiRJXL
         hLFl8t+r9VJXcMQ6bT9kgE2FlZC1bXXnoydT7YxMjD1inXLlWFtEDFI26C3cWOw4OqNs
         qPVLE//0zk1t4xiuR02hlbj2BzZ5LmDYYOlXftygCUAARe3SX4NlySJCSvfbH14l6OUx
         Nm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773499145; x=1774103945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f30xM/Mb3048ZhnccFuHLAyII+0/eJw/DdO5W4q5nGM=;
        b=MktM6OjhUdYLDIhJb4wDPHVnBMeQqkC/qw3aCjmQ8st6RcmGsDzAQOd2a6WKLe7dCy
         bOdR18pr7dhCdddL3XI9FfejY7pNN+TDjZuOzaLfHYcO0b2BvS+6eIdadSLiYVzQq9ka
         0xXYxmcJeumoyZJVpsTCYb3jjdkMJu8Skcd0X94WE+vx4b8twavz7hMdz858iv+AcLh4
         7v/BxicPZ9Ihrakb1MxX0WVsh40upFbKWZ+XgLzqR6Q+O2RKnLgc7/2MHdzCisAh5Z/i
         sitlRZ2eX/zLYLEfOs/UHcK59o5xXHhMCJTAZRWrxrxNz+1RoiZr1FJXjUaAB2JasFEt
         Qx4w==
X-Gm-Message-State: AOJu0YxLIR/YJkWB/44GUagLj5wiD2wA2duep1TyXC8uujaWzs7Pg71g
	A+ta2Y1PDGIWC+6sitOBQHXqMuCmHCvXsZZ5xy7g+SdNewDBPtxFuExrIsaS1HsUp0s=
X-Gm-Gg: ATEYQzw7Qk8qVT85BVDRWH8qGJdNVrpzpZhlGBs4AubCjeDUSx6AveHVdEJoDWGDKkV
	wh+NVg35lRxb9RxsIJ/t9buxXy7CAbFRH6HNIvbopUM0YroQ/R9xKl+zVHJ4zYFMtx+xv1qbupv
	tNxl2ViMVQyiHllpnKbbqf/evIlb0E1JI89z844bqnBJgQLwaoFKLBKnGHO9SZQPA6KaAD67Al2
	/XzWdJXesRnarm20QWnyVKectRb02lkBMR2hCsegfU+H/GMXYQrvvefP7davE5/DVEyq7K6YKFl
	fe6E3j0J8oEmyMNETHQLRzkBzPtoOobBG+6swidqnlnBbWIrvNvXrS3Vt/4pp4qOpPgSWrTxf0y
	mZDPuwobwqhnMq05zktvRd6/qK78PFFnq8JHsXIR+BhzJ9apQqcfUxh68GqD1EU7D9ZtGlfP7Ty
	LPz1V7F94fYIX1p94pBj3t3PXQ/wBe7HTc24ip1JAQgMrurP70eC93FSzV+jv+ToLpawMi3JiWM
	g==
X-Received: by 2002:a05:6870:8318:b0:36e:8381:db00 with SMTP id 586e51a60fabf-417b902b7eemr3936827fac.9.1773499145404;
        Sat, 14 Mar 2026 07:39:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6c7885sm10415806fac.17.2026.03.14.07.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 07:39:04 -0700 (PDT)
Message-ID: <a2486bc7-13be-4567-a53c-b37921df7bcd@baylibre.com>
Date: Sat, 14 Mar 2026 09:39:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
To: Sirat <email@sirat.me>, Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260311224044.21480-1-email@sirat.me>
 <abLNbGUmaA7K0s68@ashevche-desk.local>
 <CANn+LW+F2bVMAGwoF8q9yBpF3x5r_hWDqvE3_JYjcLd16A_cEA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CANn+LW+F2bVMAGwoF8q9yBpF3x5r_hWDqvE3_JYjcLd16A_cEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/12/26 10:12 AM, Sirat wrote:
> On Thu, Mar 12, 2026 at 8:28 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>>
>> On Thu, Mar 12, 2026 at 04:40:35AM +0600, Siratul Islam wrote:
> ...
>>> ---
>>> Changes in v3:
>>> - Merge DT binding into existing st,vl53l0x.yaml (per Krzysztof).
>>> - Use "reset-gpios" in the binding but xshut_gpio in the driver since that's the actual pin name.
>>
>> But why is it "reset" in the bindings? If it's a power rail or enable pin, why
>> not call it as a such in the bindings? The connection on PCB level is different story.
>>
> In v2, I actually used a separate st,vl53l1x.yaml binding with
> `xshut-gpios` and a required `vdd-supply`.
> But Krzysztof pointed out that they share the same pins so the
> existing st,vl53l0x.yaml should suffice,
> using reset as the xshut pin.
> 
> I think a choice has to be made here:
> 1. Either I use the st,vl53l0x.yaml binding with wrong pin name and
> optional vdd-supply to not break existing code.
> 2. Or use a separate binding st,vl53l1x.yaml with 1. correct pin name,
> and 2. require vdd-supply

We can modify the existing binding to make the supply required based
on the compatible.

allOf:
  # Technically supply is required to power device, but we keep it
  # optional for "st,vl53l0x" for backwards compatibility.
  - if:
      not:
        properties:
          compatible:
            const: "st,vl53l0x"
    then:
      required:
        vdd-supply


And we can add a description to reset-gpios to explain that it is actually the
XSHUT pin.

> 
> Krzysztof, do you have a preference on how we should handle this?
>>
>>

