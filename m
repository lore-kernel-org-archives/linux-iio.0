Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1966231830
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773517267; cv=none; b=EoElconmfGKub7wEPU5D99g0ImtlD06vZ0gyMqDOeUXWe9WOvdPUEm2bWqasVFgfilj9kmsrT4kFuOD1F228HxU1tYJVVM+hD/oeYZzYbIz+0lsPQgjafxmdn3IWnsy2yxleijPF1BzttdIwkCFnREhB0+WOK7s7iSI+wfMc6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773517267; c=relaxed/simple;
	bh=YhFNVh+TdpLVh1xk/Xn1xNU1nZbxWb47XrVk/k++Wqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+Uqbf6LcB2PZsvtBTkHBcmyHvBD1ZSKim4IZh3qQcsb1DSFtd6z0Kp+8QWIz5polWaapP/JJ63HEeTbZVU4kHG+UZY5rJPTnrkN+usQksqjXgGlKudKj9XyJ1fwp/CY6RuAMRAj363Pxw6JElhxwwA3yHoypDKILhVNYweTtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0oGyH3Ke; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0oGyH3Ke"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-415b23dd6e5so1117900fac.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773517264; x=1774122064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrIN0ZseX7ZuhWs9DTzoQIy4BiwvgAC1j7M3dYH/MTc=;
        b=0oGyH3KeQz5D1QoQoBE/Wgf4+XPHLL7F7OCZA8HEAe+ZqdG//gPjDetq5vf5wX6Scw
         8x1kxoJ3MlbTJYRehEwqk2p94Bp8uasWM3EpnpLlrYLOZl94QBdpju5BNyobdA73ZEg5
         itwt0vmLrL9jZ9QvJEDUNJ85nOwrswLEaDIekc8jwsf2+LK68psDGaHOl0qAbC58UVM9
         o8vY9E07LYWDSiqLCiiely1iYT8M7KBIcv3gA9o6ELoc5As8m8cgpMBB/2ar1CFj4uJV
         5ZDP6WrqxSYI6NpJh25kM9+/PrIUgDy4QvqAaNaR8NQlBm6JQk6qKY2uEsT4mcCVrv8I
         +o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773517264; x=1774122064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrIN0ZseX7ZuhWs9DTzoQIy4BiwvgAC1j7M3dYH/MTc=;
        b=KVlBvZm5G0jzBlNBmzuqbLmvvsFS3uZlM5dMopDNa59mvA5AnhlMPkPMcWumqktmVP
         ZYy+HXqCwwvYPgIX2S/GYCRNL1P8RCTliDyagT+/uXvpump1rs/jHvW4yyccZ9VRp6uE
         Yqgc+GiunxlFV+N1C8dEVyVGje7wG8d3pftHV1bWbGcQM6PWgC5D1/SbEr6rI2kIpNfR
         J53s9GfA/1mD5YyW3kRNREwEDqf/WCDW5yYOmMGzpBQ9cVR9C/0EbDcchZvb2XPyZQfN
         /HtjQP8YKXKNEipuVjYD2CDxqAXhjsStSSifRLAjJgljMSyL0S/O9H7XW7PPM0Aav4Cv
         A/6A==
X-Gm-Message-State: AOJu0YyHrEa2EdkSNRXt73FIzBXsGB5F4tpKIoF3KixScdMKbFbFZzBa
	KycBY/NxvBGz+B1z2EITFQ+r2T5frzoCPtu0jfCWOkQWaOgUjOOEsceAktSU9d6LuFQ=
X-Gm-Gg: ATEYQzx4up1nfDREviCVyASVDDTYVlam2zyesSBECmaN9HyWBCeggYpDPpC1X4SR7za
	QJQylIJDPfRjF2p01FjTgqC9bTpEJm4FDtoHNpwzI5zHsCZcjcsCd18FcQkfaExJQw/du34w6/2
	G0IQPWoIp4qRNsoDtae3z8VOZyzRatFlFH1BSX5ZrazxovGxuLSlmqIWRE3bdPYbTyDE8DqP52h
	pwvoD6zCv8651qZEUAPoAnGbvKnjBVj+IuADR981MCJFzp+Fvx6dRLe6uy4JQJ5rYGglqtc6N3D
	xKkaprFKfMElxRQq9SKnHV1WkDYna4Fka50jeInRN1hH47++CNayfocPAPEue3jIc9mxiCg3hxN
	RfhZj17Q98QbWA4ddACHKLLQSBCcWtO7p8Jy4AQV3IMm5Y/Qik++JlaK49H5qr1JcwwULOznpjK
	tglqQ979YqfO9u7b6dWlrh3kPx/3QdOBHWVowi2lfoK/8QQ0H7TSSjylROPyQXsMS8O+qyMTGtZ
	zoXXbI3pcQG
X-Received: by 2002:a05:6808:3845:b0:466:feb1:5f79 with SMTP id 5614622812f47-4675753d5a2mr3779559b6e.50.1773517263762;
        Sat, 14 Mar 2026 12:41:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1fb6efsm12564050fac.3.2026.03.14.12.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 12:41:03 -0700 (PDT)
Message-ID: <b7d46419-6320-4eed-9469-cf8043f0e20a@baylibre.com>
Date: Sat, 14 Mar 2026 14:41:02 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] iio: accel: bmc150: sort headers alphabetically
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, waqar.hameed@axis.com,
 linusw@kernel.org, sakari.ailus@linux.intel.com,
 harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com,
 andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
 <20260314170609.26827-2-rajveer.chaudhari.linux@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260314170609.26827-2-rajveer.chaudhari.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 12:06 PM, Rajveer Chaudhari wrote:
> Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
> ---
> v4 : Patch added in v4
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 42ccf0316ce5..4eb4293a741d 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -4,23 +4,26 @@
>   * Copyright (c) 2014, Intel Corporation.
>   */
>  
> -#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/cleanup.h>

Should not add cleanup.h until the next patch.

> +#include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> -#include <linux/delay.h>
> -#include <linux/slab.h>
> -#include <linux/acpi.h>
> +#include <linux/module.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> -#include <linux/regmap.h>
> +
>  #include <linux/regulator/consumer.h>
>  
>  #include "bmc150-accel.h"

