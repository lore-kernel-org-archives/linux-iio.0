Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6623BC69D
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778363057; cv=none; b=e7WN7DZk1XAK0S4+ohvMhJw28mz5ZIW9ZbPtTATi20bmHU4cHvItcJVeEICfv0Xe7BIT4i5WGB0hkb3vUeqsfkpf2RwZZWIubepyFe2RWaKBEaQHQNZZSHAXV2/zwXQ3EuadeImS/x/fl8OfFGBB57/Zjox6+SUtFY4xilFcw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778363057; c=relaxed/simple;
	bh=vB44uZWT3qqtK5DaYAUGs8e/snWfIMx26bui7J+MJA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxcVFD6eXVItHqkAsek2KnJCzFlrK0MHliLDOmjgJHX66V5WpRRMiQEMNME6A8mEUxHKqdjnRZgkF9mCIjOIMFMlnfR60px1v0BIXr3hucavjfX0ZAi+jBKVTDtsLmiiyDh4gFMpmdKaSSvGrDmqep8f4diEsZCBMYvjQRYBHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ChujKKJc; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ChujKKJc"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-42c08cbae4cso2489448fac.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778363048; x=1778967848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXZzTHF7fezizkavi8Uzwn3xe2IHuKW42J4Xgyiga18=;
        b=ChujKKJcaOPlJ2lTAaQCPlqqynTNg6GL0d77Hj8MhUD1Gw2bylO+MtvXXxIew0t0bm
         daVZb7iFoHtVt6te+O8rsfvgx8ELH2GlmXEDkgZKIv9ttX1mjd7bn4ROpAklReJ5sZCd
         KECLl1eJ6H+yMylcGkMxU+rrhHBlrXgTU/1S4qUceTzJqbuww4WsfNIa/A7EZnMNG7Tm
         kex32RzC/YwAV3M0uPQxOVDg7AuLNEQI2qKEAeNXfAExw8f7HPQbvs5o9fL2ItxeIW2M
         /nKKWK7uL0MHjQAJzEhD0G9HmlZ1+0S6XMfoXt2aM7EYjAaqR9Mnv0c6we8pcnxNSOAb
         jxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778363048; x=1778967848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXZzTHF7fezizkavi8Uzwn3xe2IHuKW42J4Xgyiga18=;
        b=JTTwMz5P4HLsaIzvfZuWDyn9buL6bAKCMhx+uthpV1D7NvVm4s3qndXFLkjjiCs2ZD
         jp8hikLCqrIKKmUIfxERzvMSbr0KMOdSidwwdr2zhaq1K2rYNxA9UcSgrU30yWEzPJGK
         Z3GtDrPheel5WjXf8BysE0xULVlzQ/Y21bWCDev0eEgE4ZZcMRlVFLxT9aL01z9K2l8z
         skkfKcxjt/lEMnnREFKf8R/iV9sCiV1jkGxfhI4sqbsaeVPWnUEwx5jmvJusBTjN99Ne
         H7DcdMRHhnCzcw2qBRPjSj94skxI0QJagorlJoSL5gaRVWskOZS3n8pclesNMp6wXRaQ
         wPBA==
X-Forwarded-Encrypted: i=1; AFNElJ+h1VyjyiZK3x1rnKAIS7XM35ofBv8wPiaPkwUAraIAPvybWLF8qVcGOhofztQV13Ig5ZrUscLM8tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwxnnN5YO1dv2VilsNgn8OSAnK/J2d/E+qNAVhso533WsjTD7c
	bM6hiewc8A035Qfr5V5HwgBv1XWNrfCeY5zH9IlGr9x3WMSijDlF1ZqIiuG8YjIA7/q1+9MqzDC
	XIgnG
X-Gm-Gg: Acq92OGEUfdccKZ9+d9cwVNppLE7ysNweJpwKjB4JlULM/8n/oa22aMR1cKVsZqgFQC
	m/9Z2G6q3OaXVwnCIjjnk88+hv2BWfKAnDPgrOy7MhXbpyZGZu8aUY1Y/C0ec9d4hepc9IhcaE4
	ySJxrXLDEYdr0kcayGHRVtwKHazo/iAntRhcIw1eb0vvQC4E6/HvqkFtvnS3L7eXfSx8h9z2o2R
	LERNrtD+AfFwXvZj5DWJOw14ekKJk7NhCd5Se0SejYNbcUT0ZT24jU3PX4SQw2FO5YuwWCW6zZl
	yG0EVeXaCzfy0YHtXADEmreFxDSlw5aWzjODSP+3Fx8dIjwApTgPDz7ZFzvN6guwg59T+EwTAqt
	YT+3r8vCWhfgHj7dqZmdxz9Cz8aJEwnYe7VhT5zdSAqtSF09v9CIbr9m0lrk3CtLE9ZON9NYd3N
	MA4h9709wzsuZ/rmUYY/YY2YZKDykkHuFW0OSdMo+i6l9/cBmI+InUSpkcUWM87eGUKXH4YRS4Q
	w==
X-Received: by 2002:a05:6871:582b:b0:430:3ddf:9712 with SMTP id 586e51a60fabf-434f68b5252mr12449477fac.5.1778363048264;
        Sat, 09 May 2026 14:44:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355710cfccsm5715160fac.8.2026.05.09.14.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 14:44:06 -0700 (PDT)
Message-ID: <d16fc10c-c9d0-4e2f-9e1f-bddf0a955fc6@baylibre.com>
Date: Sat, 9 May 2026 16:44:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] iio: introduce devm_ API for hid sensro setup and
 cleanup
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 5:10 AM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Key highlights:
> - Prepare change as pre-requisite for devm conversion for HID IIO
>   drivers by removing redundant argument
> - Add devm API to setup trigger and clenaup resource using
>   devm_add_action_or_reset()
> - few cleanup and prepratory changes before updating driver for devm_
> - few sample driver update using devm conversion to auto release resource
> 
> changes in v3:
> - Added cleanup and prepratory changes before adding devm_ API
>   conversion based on self review: 0002, 0004, 0006, 0007 and 0008
> - Address andy's review comment on commit message and coding style
> - v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-sanjayembedded@gmail.com/
> changes in v2:
> - Following input from Jonathan and Andy, squash initial patch v1
>   series in single change as individual change should not break anything
> - Add devm API support and two driver using the same
> - v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-sanjayembedded@gmail.com/
> 
> Testing:
>   - Compiled with W=1
>   - Build-tested on QEMU x86_64
> 
> Based on further feedback and reviews, I would extend this series to convert all HID IIO driver to use devm_* API.
> 
> Thanks,
> Sanjay Chitroda
> 
> 
> Sanjay Chitroda (9):
>   iio: hid-sensors: drop redundant iio_dev argument
>   iio: hid-sensors: cleanup codestyle warning
>   iio: hid-sensors: introduce device managed API
>   iio: gyro: hid-sensor-gyro-3d: cleanup codestyle warning
>   iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger() using
>     devm API
>   iio: humidity: hid-sensor-humidity: cleanup codestyle check
>   iio: humidity: hid-sensor-humidity: use common device for devres
>   iio: humidity: hid-sensor-humidity: use local struct device
>   iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger()
>     using devm API

The series would be easier to follow if all of the cleanups
were first and then all of the new code was the last 3
patches.

> 
>  drivers/iio/accel/hid-sensor-accel-3d.c       |  4 +-
>  .../common/hid-sensors/hid-sensor-trigger.c   | 24 +++++++-
>  .../common/hid-sensors/hid-sensor-trigger.h   |  5 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 16 ++---
>  drivers/iio/humidity/hid-sensor-humidity.c    | 61 +++++++++----------
>  drivers/iio/light/hid-sensor-als.c            |  4 +-
>  drivers/iio/light/hid-sensor-prox.c           |  4 +-
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c |  4 +-
>  drivers/iio/orientation/hid-sensor-incl-3d.c  |  4 +-
>  drivers/iio/orientation/hid-sensor-rotation.c |  4 +-
>  .../position/hid-sensor-custom-intel-hinge.c  |  4 +-
>  drivers/iio/pressure/hid-sensor-press.c       |  4 +-
>  .../iio/temperature/hid-sensor-temperature.c  |  4 +-
>  13 files changed, 78 insertions(+), 64 deletions(-)
> 
> 
> base-commit: 39b80c5c9830d12d2d6531059001301c4265322a

