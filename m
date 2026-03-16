Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1531E511
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671797; cv=none; b=oAmlxgfEovVwo8hIdBAJxALm/KHP3bQPf7OR3wMkpruLr1GGicaGsgnP0sAYi9q79zFtWgtTXHPojf617tVWm17OaGxM+5bcRtdClFDERveqga6qwFgLZjTYlgHxlG3pLorifZMMyo/jpRAEW4KdjrMWITIljGLRG7zsFistWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671797; c=relaxed/simple;
	bh=iSL82u/rj+K8vkgdtjJJbJQVglewWtRM5osVFtum5DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDDsKPBh2dzCp3/HedOc+dqUZ56oUoCbvAH4Vb36opSZTPq4bE8qeBNTheQ5Lm1CVHOHZmAWy3NTOOTSUjlI62twgJz19oQ5/PZ1GT0YfhhZlKUxTSi5sQ/tALMxw3cxl6B/lruwt8FDr1mKMIWy7Dfv7A572li9YqxrgJ+CZqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mcqcugOw; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mcqcugOw"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so1758253fac.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773671794; x=1774276594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkfU/ntQc9vQPrm0zeiXFf9WQePuMgZsPXAkNngYEuE=;
        b=mcqcugOwKDBlR/VIIg85pjq3PsBmlg0TWy96y46KRcQ0lUE69TL9HDZrYozszY24l/
         SZJ/cXn4ZqXA55plNYXJEF4kXuBf4qBxXbA/sc4iQLyZnNdLGL/CMOstwu4wCJlaVG20
         RMjIEwTdVWh3eFbIRLk18p15LuqMAwH+Mz5cVpSDNlGy1S1EYKEoGUv7B/DyPQEcSdXU
         /j0tVFh8g9LnkNRuV2b0z1tRyFiS+Zq2a9x9uGYn4vJhca+eBl2NH48RLId3Yq7yk8XZ
         aWbZ//MoVuq75G5eOqmw8obIOn+YMALuu48n0nO0AbO5fqFOjGaUfp9RonF01k1OsomW
         odSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773671794; x=1774276594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkfU/ntQc9vQPrm0zeiXFf9WQePuMgZsPXAkNngYEuE=;
        b=tDxX/3aL/9waPS27lICLiW+ygQDyL4dlcC6zu2U/ZbWA39HFOmV5yqLSNuEcQ7s1D8
         0To59LtZE1Eoh+8CB3tRsGTSZmzvGCkOWeYX7dKc+UJWnQj2a3o2tnDYQsVO/dqlxcCp
         9OgTJuTbgGQkDlN5yC7qL/1HKOZdwoZlIBrU4stYEo6c5Avt1fhHNnXxRIJYp7S4nBJq
         HvSEzGezM6gfKeFapziSvjybqL/v0VvuAG+CZSyyC3Q7c3qxAbh9SRoiMjoo0QGXxexW
         OT7Za9JSpTApXwbGdHo7TNXk13dkmS6X7ELF4ew15cPhCUTe2FjMLI8QhC7visiBRAT5
         D0wg==
X-Forwarded-Encrypted: i=1; AJvYcCWgfV3anC58IP39Swzm8LPX3IWrV4uQTiaAPG+AVGaM4llRyEuqsLR3aMdE90edtGcp+9i2Equ+7sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Sg7TTVlQ2/vX/2RfUASLNyjHrSUwEAOVqR/PGzP3Kpnc+mu1
	J/J2RctwweKWJiYzFECPKyY0eyeKrx2evIu5N09aL+LygYkt7WR0r4acz0DMGgVe2E0=
X-Gm-Gg: ATEYQzzdQoyKlM08OecYFYceJAes7P7VzJbkdW81i8fSZs3nuJ3NT4PlRmC8FjFGhrP
	3ixheatTO5mx5vUYr7CFB65gbL5WDrQ/2KI4TRbO1vtkxlXsk1jODvCm6Hm9FjOpjvExUYMi/90
	ZrS0SnBIOg+6Sf585knqfel1nFkg2Z58gW1XoIU79p1nUnMJ0hd2qK2XBiZSHwOHaForm2NHLAi
	e/vpbAs17JrLbD+mx4Pv6bt3z8k/gpZEMNDO0m7cXmocXFJQ1Wc/nNt/cCWISPpZYX9YM4Kow/N
	aChz0+DcYmbwPth2/cahC6x4VELmyWbsoZTdC8IjuVlbA+z1jeetlahvmNCyprTxtnMZIDabC9Y
	4+vYXm6ikpe+RWfZJbYtCeBbU8WPhEQdlvHIKfwuIA3U4BU+QZ4NZRnapR8xsuLV53JHvl97aX0
	Sx/e7mtOxw8hrjTUQjVr+AphKGOg5OvPJ4c8U3BHxz3QnK1sa6dmv4ixUf51gTvBY/JVbsm6Mgl
	g==
X-Received: by 2002:a05:6870:a782:b0:417:ab68:fbb1 with SMTP id 586e51a60fabf-417b9059ac3mr7018417fac.10.1773671794159;
        Mon, 16 Mar 2026 07:36:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e26e2c6sm17149665fac.7.2026.03.16.07.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 07:36:33 -0700 (PDT)
Message-ID: <60aea3c6-52db-42a5-b1b5-b0af50e3342b@baylibre.com>
Date: Mon, 16 Mar 2026 09:36:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: aw96103: fix firmware read on big-endian
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 shuaijie wang <wangshuaijie@awinic.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260314-iio-proximity-aw96103-fix-firmware-read-v1-1-c74fe9ccd82b@baylibre.com>
 <abfZyvsfzjPv08QM@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <abfZyvsfzjPv08QM@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 5:22 AM, Andy Shevchenko wrote:
> On Sat, Mar 14, 2026 at 06:20:12PM -0500, David Lechner wrote:
>> Use get_unaligned_le32() instead of casting to int * to make sure that
>> reading a 32-bit int value from the firmware binary works correctly on
>> big-endian architectures.
> 
> ...
> 
>>  	bin->valid_data_addr = AW96103_BIN_VALID_DATA_OFFSET;
>>  	bin->valid_data_len =
>> -		*(unsigned int *)(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
>> +		get_unaligned_le32(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
>>  		AW96103_BIN_DATA_REG_NUM_SIZE;
>>  	memcpy(bin->chip_type, bin->data + AW96103_BIN_CHIP_TYPE_OFFSET,
>>  	       AW96103_BIN_CHIP_TYPE_SIZE);
> 
> I gave you a tag, but I have a question here:
> Hmm... memcpy() happens to work probably due to keeping LE as LE and chip_type
> being a byte stream itself, if AW96103_BIN_CHIP_TYPE_SIZE is bigger than a
> byte. Otherwise it may suffer from the same issue, no?
> 

I checked how bin->chip_type is used and it is a string, so not affected. 
