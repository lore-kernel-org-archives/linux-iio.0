Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650C33E7
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769201386; cv=none; b=dNDGbhvX37e1/Oagzo9Whk/ywbkXfXKe2baYIgixNDQZ2udmIUDwa4lLSrH6pBqvX+xsj5x3CgPxctPebAzEtrYzqFlF+DfPWFeufLN2MPC673RPkC0g/lLDZsFrXzWI55PRKbLcNdhVL/QQWlFQ4vuFupAAQZ6jG/oSyjMvu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769201386; c=relaxed/simple;
	bh=pHDd2aTYpGOk4640rSXaDXNoyoKUSTdCC+ufBmOLr2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgP13i8+rQ1soiayKV0WUBHRAoEPMB5QXSG7dpw9O8Sp7wwh1na0Xeq9xT8+F+gw/GxFi4AEhuVmCFoNDHHoEDkwv5rC4MJdqENBTQIyln1YYxZM1MsBc/0W8OVyWoxqgMR2AqSeNxNBmLzdtSggOOGcNskFaqt54yqCEJCWxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kZBzduAK; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kZBzduAK"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7cfd71761b1so1579465a34.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 12:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769201383; x=1769806183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01ZejG6L6bzNUlfIdifrAr3bXJoLHESgEVgVlUuXdh0=;
        b=kZBzduAKa9IRG31aAsIje82OUXvT7tS1Les6b15xih2+uPHIWThdt8U7JgYLnhqnqh
         xKSDWkxwLKPqfVdV3SSTMNU39hWSjBSA2pfmBbH0/K02z0lFrr0pq+pi9EJ7pw7KEmsB
         6ovEaoLSPvRyH2EQPHYCVMMLg5tL5x5o7uDwYfjii9Z5GudeHF7Cog0a0t1yG8Kbxanr
         09jZ3wBdkDnC5hkGIC/VdvxJNFEJmFF+JL+kc60rXZz1s4pyzbFAjJwv8Ch1AfyAxgny
         qvL6N1sTIMwMOHX/u/7vePqYrqv81kCUqAZJhluP2hpub7wogm5unShqAOjL6Oh+j0Fq
         dQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769201383; x=1769806183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01ZejG6L6bzNUlfIdifrAr3bXJoLHESgEVgVlUuXdh0=;
        b=E1MFGxfZuKtIu1gSSGA3m83viPHvwJRCIeuaqLVY3h9pginfw0TCAc/hXs8Nje9EDy
         Z6T/6Q/CTUcABZgge36trgsIS0E3RBPxWRsTsuVkDckuDvtEBWZIfMmJGXUnia3vL0uD
         +TV3WR23fAs6l4zCVbkhlT2eNiUaTaW6rxoKcG5/FkeC34v0SFc3KIhRDV9f7MYBxueD
         kldXC+w/U4tt739fSgxvSzaHB2BYl/QAOXpNj/xyUjcMQeOncZfvVxDGfuc48VlJEYYw
         EvXfVPuEo8rL/Ec0etklzAua7DhZoxxhro+jPqeG5Jhq4Ff2yTLd7MgByWEENEs2+gy9
         Wq6A==
X-Forwarded-Encrypted: i=1; AJvYcCWabLQXgzpBuDm37ufDBk7ZlSNRIntUCrLHB7e8qc0NsqXYz9VtMHy19Y/54oJgGNWHLOApPCcnm/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YziR1LYHeOV0cRRjNDux9FSIfKmbIw8PwNxPcrFAG3O2g0O65JC
	bx6dO674Y+CmwOZppfvBgI0ztqbMXtDY3sVlsrY0uamUCrKyEM2QuafWmkhGltVdK+5Q5ZgqzhN
	ewlS0
X-Gm-Gg: AZuq6aK+0SjQBjgc8twO+ozsVE3tC7CbxvpNEAyH572FDrVxlVXDhsWoww2d7g7qGk7
	pmeShf8tXZWuhydznP7zC7j91dMM3iMbdJuJ0otceyWBKUUC7Quha0QmW8LoxNc5dUuIrSvUlnO
	NnJAADYjDDVLMi+yhsnK8mrIRCseVJ+GQ9kOGUOkMhwj98qwsIOni07g8MzuNw+MS3WnJq4Ykv0
	ClNENGP8NIqQd9rLZUYpOQN5mgTAwcxHwBCWsomAuu026bP1TVUvCQVxZO2vAEmYHBdr2NKWAq0
	NBYOR8kZTZdqXE2QNTIbwEbL+ZyUI87F4hdRJ4Hx8dTeF+VUYC5Ffb6gHttpczLNAiltOlokjRJ
	QHEdX9UXfr5irToNrxW4RD2GbPt6mJe1UsFpz21k+ZfNt9mjJaK/UAUBskEpZy/DMwKW2jNVkWQ
	9O68TfSk92VNHg+G/pMKG7remko4DeWnRrA2YOQwW1wuvwrnG4XXeARUeIWQ==
X-Received: by 2002:a05:6830:6ac1:b0:7cf:d14c:ca0b with SMTP id 46e09a7af769-7d15a691cc7mr2274810a34.4.1769201383434;
        Fri, 23 Jan 2026 12:49:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:198f:2b50:c48:1875? ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b346df8sm2652352a34.6.2026.01.23.12.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 12:49:43 -0800 (PST)
Message-ID: <80f07214-6b20-4463-b574-798afc2b5485@baylibre.com>
Date: Fri, 23 Jan 2026 14:49:42 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
To: Jonathan Cameron <jic23@kernel.org>, Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260122162335.2020006-1-flavra@baylibre.com>
 <20260122162335.2020006-5-flavra@baylibre.com>
 <20260122202943.344e7311@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260122202943.344e7311@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/26 2:29 PM, Jonathan Cameron wrote:
> On Thu, 22 Jan 2026 17:23:35 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
> 
>> Some IMU chips in the LSM6DSX family have sensor fusion features that
>> combine data from the accelerometer and gyroscope. One of these features
>> generates rotation vector data and makes it available in the hardware
>> FIFO as a quaternion (more specifically, the X, Y and Z components of the
>> quaternion vector, expressed as 16-bit half-precision floating-point
>> numbers).
>>
>> Add support for a new sensor instance that allows receiving sensor fusion
>> data, by defining a new struct st_lsm6dsx_sf_settings (which contains
>> chip-specific details for the sensor fusion functionality), and adding this
>> struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
>> populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
>> logic to initialize an additional IIO device if this struct is populated
>> for the hardware type being probed.
>> Note: a new IIO device is being defined (as opposed to adding channels to
>> an existing device) because the rate at which sensor fusion data is
>> generated may not match the data rate from any of the existing devices.
>>
>> Tested on LSMDSV16X.
>>
>> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
>> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> index ded9a96076e6..3b4fa57bf461 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> 
>> @@ -580,6 +584,16 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
>>  	case ST_LSM6DSX_EXT2_TAG:
>>  		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
>>  		break;
>> +	case ST_LSM6DSX_ROT_TAG:
>> +		/*
>> +		 * The sensor reports only the {X, Y, Z} elements of the
>> +		 * quaternion vector; set the W value to 0 (it can be derived
>> +		 * from the {X, Y, Z} values due to the property that the vector
>> +		 * is normalized).
> 
> I'd missed this before.  This is going to really confuse user space.
> I don't think we can just return it with a 0 in that last entry.
> At the very least we need an ABI doc update to reflect this oddity.
> 
> I don't think that is enough though. This isn't a quaternion, but
> rather something we can derive one from. Annoying though it is,
> we can't realistically fix it up in kernel, so we are probably talking
> a new MOD_TYPE.

Do we also need to add something to struct iio_scan_type to indicate
that the raw value is floating point as opposed to integer?

> 
> Also it's been a long time since I did much with quaternions,
> but isn't the sign of w ambiguous if we are relying on only X, Y and Z?
> A bit of googling + AI suggests flipping it inverts the direction of
> rotation around a given axis. Feels like there is a constraint missing
> in this description.
> 
> Jonathan

