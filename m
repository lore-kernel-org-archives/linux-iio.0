Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDF3A2570
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441405; cv=none; b=LDguKYqckNkOEHnHrasfQH0SgaqPYCk076BMuVUUi51ypmcBsRLhL8byOwwm3p2ctnwMn1n638dFv0bd1lI1sPHmZY9rB3L0xPI7QwiQz6jNdzSC07C1OOMf5BHBr7HhN+3KaE22EEqY/Tviu5q4CgSVik1x2dp8wbARMOfPIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441405; c=relaxed/simple;
	bh=s+qSYDke52+vnlUZ3rsl7aQ5/WKvcbYqzQMya+AuESc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRo85It+G+WzWQZwcSIUUhsLBZHrFtTZNwtqOLUj2r771sAKN7q2bvelJWc/RD0HFKHk5bweHY7ENWXPKU/BQlsUioUMQ7YehvdRQQOCuVI1DQMRpfaJROa0O6mYRQn86/psti3wTsOjA5vgW9gfGa0/DKONYpoGGHoNcpPr4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuU8/PlY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuU8/PlY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso55961665e9.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 05:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774441403; x=1775046203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0dbWCIG6rCaQiBrnd43XnRhp1PJ7rqPO912CnQbhU8=;
        b=KuU8/PlYt0ZfVmhnwsbQuCLaKIIMq/h9VFCeuk1EQOalGsI1eFCwx12gMWD9GmLz9q
         4+EB7PfHRD0EFkO9axMqaB3qEzpDAx/RrESxD/3Oheu8qJzH26XNYpZYzZzfVScHyPF5
         Db+ibkb+mriXR5eeNaVaXXhTfzGaxYUH0P0FKuyRJEKc3P6aSwutGYeS4OEI0k0J7H4t
         K9slAbwPEYiy9Fgd4g2o6zLyJTmYlJGaDf0X6M0KT3AciwzvPiY/JVgt324DIx7KJj73
         2x6HiE5hXyQCieyrEbtfY5xuu53kpvZil5AlNXaodKo9ftnhZzsuUe6DnOUDXcEuV5lo
         MEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774441403; x=1775046203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0dbWCIG6rCaQiBrnd43XnRhp1PJ7rqPO912CnQbhU8=;
        b=PDDCspfWH1Q5TMhl05UTLvBPBvlrl1BVjk5cgaw43YZVeD6/8KsmrODMALPb4NhbJ/
         lp8bjnGIwf+8m4urAKUdJxn2Nav4igKakAorFEE5v4HAUJ20pQJYIke6lqijRQWXjvl/
         tFzCpcpUdJkzqFW9DHrEkP8asbV8Cw0Z4RkHUXiWbIYc4+UnleGUqrmSOQ7aVjxMP7Lo
         J8zMt0x50jTKpn6pAN+Cy6ELuADiobFkM9zEH7pn3XCpW2ZXUcFKnrBca+HLBspGpKYi
         5bd8EQwm3Y/NW5DnsEL+s75cjqHFrM4iN28YH0H0sx+339h6cxXjetvEYOLx5wFMC+TO
         9mtw==
X-Gm-Message-State: AOJu0Yw031yLsAVAQQdzR3AT0lA/x314ew7hf14QUDCx5Ymz7v8VvheH
	XZlY/0jPtse+7mquHjOYua+D7WnGnNNxem1Bxn98VaXI96DqiVnG6cK8
X-Gm-Gg: ATEYQzymgXHG8YN37m+hVgzNUTYlJyazsipwavYAJcGvJIuD5GOOmQw5aHHnczzXOTb
	1Ch7zrHSlCfM8Lr6hmcaoOIxkkEf53jtOf9brG+KEMQr7Q/fzmEuEeeMqF6xYVZl9ZPTLdGymmS
	rdRb/sc105kU7OaLx6zBa5PNQ7VJ/N3Z2bChfDluD8WoyQ0cV+E6De6UeFil2pYhw8FX4Exf37l
	kHdmdn+td3YTBoYl5DVb+acsmyHLQ+monyTPzoPSo0RWFvMp0Eizh7AFbegM7TbE6KOYCA30Sgl
	RaUzhVxiL1HxtprIPZV0vsLbnI4LcPonhxRJz13050vSBfq+r8mK5JGPlk/jaj/hXVrX60gTIHF
	pwMk3i0Z4Bj2+mWOGxADICOVrIJi28LY0caATZ2oNtdyXrDbi7X1RkWkGtImPeOBlDANttYfQlk
	SSw9KmBoYv2Z7vsW6WhS8xM+8vd2Su5euMQjuXRv+ht1Y6nnp1/8aqFGQWIW0+FOw=
X-Received: by 2002:a05:600c:524e:b0:486:d76c:fa51 with SMTP id 5b1f17b1804b1-48716071a07mr50656305e9.27.1774441402268;
        Wed, 25 Mar 2026 05:23:22 -0700 (PDT)
Received: from ?IPV6:2a00:10:8f5a:ad01:f856:f975:7cf:79d7? ([2a00:10:8f5a:ad01:f856:f975:7cf:79d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b87f80a0dsm9364815f8f.7.2026.03.25.05.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 05:23:21 -0700 (PDT)
Message-ID: <2ac6cca6-a7c5-4892-93d9-49f850953511@gmail.com>
Date: Wed, 25 Mar 2026 13:23:20 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Add ACPI ID for SHIFT13mi gyroscope
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org
References: <20260324193626.77231-1-twoexem@gmail.com>
 <acPNhGlmTJk4pfRG@ashevche-desk.local>
Content-Language: de-DE, en-US
From: =?UTF-8?B?TWlsYW4gTWnFoWnEhw==?= <twoexem@gmail.com>
In-Reply-To: <acPNhGlmTJk4pfRG@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/26 12:56, Andy Shevchenko wrote:
> Please, for the record also reply with the DSDT excerpt of the device in
> question, so we will see how it's defined in ACPI.

Hi Andy,
Here's the device's DSDT excerpt:

Device (GYRO)
         {
             Name (_ADR, Zero)  // _ADR: Address
             Name (_HID, "SMOCF00")  // _HID: Hardware ID
             Name (_CID, "SMOCF00")  // _CID: Compatible ID
             Name (_DDN, "Gyroscope")  // _DDN: DOS Device Name
             Name (_UID, One)  // _UID: Unique ID
             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource 
Settings
             {
                 Name (RBUF, ResourceTemplate ()
                 {
                     I2cSerialBusV2 (0x006B, ControllerInitiated, 
0x00061A80,
                         AddressingMode7Bit, "\\_SB.PC00.I2C0",
                         0x00, ResourceConsumer, , Exclusive,
                         RawDataBuffer (0x04)  // Vendor Data
                         {
                             0x53, 0x4F, 0x41, 0x30
                         })
                     I2cSerialBusV2 (0x006B, ControllerInitiated, 
0x00061A80,
                         AddressingMode7Bit, "\\_SB.PC00.I2C0",
                         0x00, ResourceConsumer, , Exclusive,
                         RawDataBuffer (0x04)  // Vendor Data
                         {
                             0x53, 0x4F, 0x47, 0x30
                         })
                 })
                 Return (RBUF) /* \_SB_.PC00.I2C0.GYRO._CRS.RBUF */
             }

             Method (SOA0, 0, NotSerialized)
             {
                 Name (RBUF, Package (0x03)
                 {
                     "1 0 0",
                     "0 -1 0",
                     "0 0 1"
                 })
                 Return (RBUF) /* \_SB_.PC00.I2C0.GYRO.SOA0.RBUF */
             }

             Method (SOG0, 0, NotSerialized)
             {
                 Name (RBUF, Package (0x03)
                 {
                     "0 1 0",
                     "-1 0 0",
                     "0 0 -1"
                 })
                 Return (RBUF) /* \_SB_.PC00.I2C0.GYRO.SOG0.RBUF */
             }

             Method (_STA, 0, NotSerialized)  // _STA: Status
             {
                 Return (0x0F)
             }
         }

Best Regards,
Milan Misic
