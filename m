Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652B430B91
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134063; cv=none; b=d0/LuX4botK/f4O0DEnj7nOMaB7Z3z3gSfTtmsS2n2nOlsY4h5M9VMoqeGBDuP66VHQDATeEdBHiOO6/VeBL2cHU/s+T3/IjebFrzmCKEjrPywaKiHBOkmSkH5UK1gU/H+Fdwp4jCx78OJ5JruSvneujw88H3Y1gI5rXmvdVO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134063; c=relaxed/simple;
	bh=nCUm8571Rrc9v11gqQwOsBrkuE4vArUu7aTZDv0jhR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNRdOo6DuH6RmixYOuY49/mvp6AsfulF8xqcl+8d8Zuyfrcu19JcBZ+PnE4wfMagWHMEiX9BxXYFDATd4mnsy5zyKYD118Z8Wz/UQK2rL6Ohm79AZjcQuZCd/Yp2ZLSGRSEHKzjMbLaxxM/vEY8KIw0ySJSe+rC8x4ZNuvW3LxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcddL4Uf; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcddL4Uf"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a140efd2d5so4128937e87.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 02:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773134059; x=1773738859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Wk/PIY5UOjxYkFnDNw1res7eXVE54IeoMKH3WeV19A=;
        b=kcddL4UfeIxFXgxUjX1TBsST5bTazd3bUi8xXW0znqJyAM8ZFgpEVHiumpw5/lr48I
         Q2MQlWGZNtVZy6O5yuH4R6bAV9BiwKgyQm3zH170ckJGelQzBaF8OfvliBDQDl1MgpBd
         lD1fK00vnOFE4B0L3N2aeHp6hdj5odWXAF/0xz1uRBQhw+mifDjGGcJfrlz6FP+RdYKr
         dCXE9lVldBDhuYKbgG/kT8aygRl+rfgLQAgH/iLGBMau942KXcgHvaZEr55VhLxWBmKQ
         QGIuTlufK8I/8X4PEj9x+nE6dkU8Bq1cqeQIPvoSunr9X8obPvgEvGKw15Ej66woOK+c
         AHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134059; x=1773738859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Wk/PIY5UOjxYkFnDNw1res7eXVE54IeoMKH3WeV19A=;
        b=kgl3jpNDXbcBYzrJmVuu3btomIysSD3KIm4xV+c8arJ2T3oqfQkKHHWhLYAskvZft6
         G26pixVUFYHsjICdXd1WFhxpktEYVTrSaMsjmZPEvvTynZlFSDEpS41UNmAXz+S3JQ5R
         eonOV6vhZJtos+RS567SUk59pWnby6k+TmR3ygnTunw0tk9Z2hiRs5u+kbW+2oylpShn
         7va1+Fy6JSsutVQ6iLlxhA/YKYRCA+caHwMRWuCtpPCBxIYKTpwdT3oWVpoi3fpMd+dc
         qIEZZWsAm2ymT3vEgXij06oXwcatoApQ+2ckPh0u8S8acYQdYHmvM9FquvP5B/fthVTa
         OASg==
X-Forwarded-Encrypted: i=1; AJvYcCVnnDCXzzBqDE/r0vN9zsJ3vOJamaT7xEnuXVHU1WMdD2j2LSqoLtg7T9tWtO+JyzGaYSoNuNs/4fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5joalz7T/aXLB6MKfv5sVFnjHhtC3mnGckLxjvjKinFpI6Clq
	KbNkxME0eUXcDdd30etcgYs2ipaf9cRIiLnzsvxFAOr456qJ2/m/r+Qt
X-Gm-Gg: ATEYQzzVPfkNHVHYy980vq0G9l1v/0ecxTQIKK89dIUZdLgWsW7QT3q+kXk+UpFsd5i
	qXXmKc2z77HWOyZY/ixCij8mOM0xa735CcvJlsk/orrvzeG749Vl2+95IaBjxZ5tz6AK5o5XT4+
	9rpuJCO+tfPcM/EhIZM2OZJrTfl/x7+U9LPTQocGYdN502e2z/X8TNe+P2VbVKme6+rhvyRDzij
	1NRzu6Gn7jRdDGSR+o9XVNHgFeNhBZW7CXlEgVwWqEKaSSF4VvKhbhA784umGfu38nOxIArlZ9E
	K6EUl2OEYkzDnhjAt7PN+m5iZiiebvGMvqZWGp3PZb2qGGIZrg7zYzwbMGYSVJoMlKuA8alhSwm
	2EJpoJp+0vOk5nqljfYt5VL5MJGk+PbHc2I5J2LcL0WCoo0kgZ03YhbF+Wdf31KMiDNsB0aOzPo
	L+85lknkuJwtI0NdxQ/960rmJgM4At6HxbrQVF/li+F37Szyb3tm/RsyDNwTFQG8NyvghcxOfJB
	hEVLZ0l
X-Received: by 2002:a05:6512:334a:b0:5a1:3864:9306 with SMTP id 2adb3069b0e04-5a13cd5e6eemr4098603e87.43.1773134059196;
        Tue, 10 Mar 2026 02:14:19 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d08d31esm2614081e87.85.2026.03.10.02.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 02:14:18 -0700 (PDT)
Message-ID: <d1c6b4d5-3e33-48f3-926e-cc3d109fa12f@gmail.com>
Date: Tue, 10 Mar 2026 11:14:17 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] iio: fix spelling mistakes in comments
To: Shi Hao <i.shihao.999@gmail.com>, andriy.shevchenko@intel.com
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt@analog.com, nuno.sa@analog.com
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260307104705.49129-1-i.shihao.999@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/03/2026 12:46, Shi Hao wrote:
> This series fixes spelling mistakes in comments across
> several IIO subsystems to improve readability and code
> consistency.
> 
> v2:
> 
> - Split original patch into 6 commits
> - Fixed commit message formatting and typos
> - Added necessary tags in commits
> - Added more fixes then previous
> 
> Shi Hao (6):
>    iio: accel: fix spelling mistakes in comments
>    iio: adc: fix spelling mistakes in comments
>    iio: amplifiers: fix spelling mistake in comment
>    iio: cdc: fix spelling mistakes in comments
>    iio: chemical: fix spelling mistake in comment
>    iio: common: fix spelling mistakes in comments
> 
>   drivers/iio/accel/adis16201.c                          | 2 +-
>   drivers/iio/accel/adis16209.c                          | 2 +-
>   drivers/iio/adc/ad4030.c                               | 2 +-
>   drivers/iio/adc/ad4170-4.c                             | 6 +++---
>   drivers/iio/adc/ad7380.c                               | 2 +-
>   drivers/iio/adc/ad7887.c                               | 2 +-
>   drivers/iio/adc/ad7923.c                               | 4 ++--
>   drivers/iio/adc/at91_adc.c                             | 4 ++--
>   drivers/iio/adc/max1363.c                              | 2 +-
>   drivers/iio/adc/mcp3564.c                              | 2 +-
>   drivers/iio/adc/men_z188_adc.c                         | 2 +-
>   drivers/iio/adc/npcm_adc.c                             | 2 +-
>   drivers/iio/adc/palmas_gpadc.c                         | 2 +-
>   drivers/iio/adc/rohm-bd79124.c                         | 4 ++--
>   drivers/iio/adc/spear_adc.c                            | 2 +-
>   drivers/iio/adc/stm32-adc-core.c                       | 2 +-
>   drivers/iio/adc/stm32-adc.c                            | 2 +-
>   drivers/iio/adc/sun20i-gpadc-iio.c                     | 2 +-
>   drivers/iio/adc/ti_am335x_adc.c                        | 2 +-
>   drivers/iio/adc/twl4030-madc.c                         | 2 +-
>   drivers/iio/adc/twl6030-gpadc.c                        | 2 +-
>   drivers/iio/amplifiers/ada4250.c                       | 2 +-
>   drivers/iio/cdc/ad7150.c                               | 2 +-
>   drivers/iio/cdc/ad7746.c                               | 2 +-
>   drivers/iio/chemical/bme680_core.c                     | 2 +-
>   drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
>   drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
>   drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
>   drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
>   29 files changed, 34 insertions(+), 34 deletions(-)
Changes to ROHM stuff looks good to me. Thanks!

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
