Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30BA32B125
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779658752; cv=none; b=ZsdW8yFAAdj8R3k/pWqiZrcfygbReB4Kn+OCukS7IZe1dvQc4EjRUQT6wiM1zbY2TtJRFA0i5VHgTLhWUT51yKmgZ6v1zY1eghe5koAG1z/vtOOwFKb+pEU4XSPX8iwpPaJQet3l4CFwGiYiL01BYHyMm+DB6elf0IZ5bUjc7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779658752; c=relaxed/simple;
	bh=ppcUKHw63/62CDABjF21GkA4Y+TFIUCPLasI6KiPMQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZoai+8Zw0xKjERZHui39dFrX4a3v8zwD/lJMuFgrNbhyCm37/xY3n7kg0V0AYVIGBYhdkBz5lHt3NQugecjdLCYWLl6/9zKCHB6LAPbzQrwIHYYmyVPcSab/4Hr442V6lw6RDmaYWRHqAkXvBkkuAaIPZ+iwTHYCGSuJzR+BEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kzf6zB3H; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kzf6zB3H"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8025f1c227so7229935a12.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779658750; x=1780263550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pKBkAs6C8YaB4CUd9CTag1oLEcWAKz7fDVIDPuAOyaw=;
        b=Kzf6zB3HrTcmoQdkKKhMiGLbchZZTqvWfMWyNqPd0M4mP/JbUa3k1oWa3zWfjpmfk0
         WuE0yQ4WSASZuS9WfMqAIg//9tdp2GQueJQoEs3nKnKlDckJTTgomGg56jsEAlz9QRwW
         rL1zGfhuKYeBkgCg+aJlJ5fheNkYSXOf/sPiGpjhWATI9Iel6zFCMFdgwi19v/IM5zZ5
         l4s7hD80dXxDB3js5XbkQljWCf1Ho0NJTTif7KUHmhWIw4ZTsgTNZg0p+XtIZ9ecLnct
         eYgG9QJ4+gSpNxTpMYTxJC4JIF3A7Z0R3orc1ZB+GYBwkRM6TAOTV3hrCshK8IZwm2kW
         xJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779658750; x=1780263550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKBkAs6C8YaB4CUd9CTag1oLEcWAKz7fDVIDPuAOyaw=;
        b=E90p4wd7Ywm1Sbnow6RH21n/XgBXSE+Gtp7KiuCRGUxLRVHbNsYFD95M5lnMny8PnN
         Gq1rh2WIRyw/F1L+NU6J6T5P37NylGeUriivsdfC4sFnigOybrd3HPMUs4S1fp3bdj5J
         B5mkhzOqKtuSZ+ZQ2V7XhE3VprmUQaySXUY925qH2fqDcmQt+HnuqqRCcJjA8DuZodGP
         bkxXEYCG7ZQuB/cAQ6RWJuNDgDQpkLIQOdaYEMYeDqFBnmJF7uL7zDFoKdT8kx+qu38l
         4qruIla46wtFFnFfn8OmXL2xKe51AG+Pk4bJRHuLaEiv8261yct0RgxB8I4mhvzgCdfT
         gnag==
X-Forwarded-Encrypted: i=1; AFNElJ+N4GfVwdAlg+tw/LwFBxJDWrCsbpkY0h6+nVZPddjJunBDQIJeT9U0NrpbDbCZHQVsrfnfeCpK/N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqes0hFd+HjB19Pd/ptq6FBegF18C0fwQOgl86wAwNt8bARdfp
	XmJd7VVe528ShG7TrqsIwmyPRD0rcUuLm7EQpWFhriTJ+NgJQ3kIImH+
X-Gm-Gg: Acq92OG+ugVdwlMJzm/SjFYALnnSDCic9d2LziiWS0nFO5LLS3D4V733GjQm7bcY+uC
	BjvyusXQnZw8+KKIRdArMpj/RPmmWYrv/veOaT40kNfYuP/EiaHbktUaQ5n3ylrJMXn7cWirUru
	mJ1F+jKdgaDcCDJIHqsqyU/dROxSvQmo3lhbondROIH/SMMJr6/lA1PU73A491Ry/XNYkPRj4y0
	rFvm9NC0UJle0fgJ3RJHyW3zRLS9C2NisVyUeR+k/7e4OJgwhLDVC8W3WN0aPte5cMgWZ0DY5jE
	axXkIUzQP+J1GcHDOZoPOYI05CR0T5py1BKJatTa+goZX/dtzeWUo5toNCSVrRUUY5Ke0IGmVwd
	gqUlGEnTT5RaMutI8cmttQdhSqIpPxbBrKoyIPH+7FB++lqDkJnyQtwN5+ptoEgisU3xrODI0rI
	BGazgUPM6kXf9dqmg2CkfaJL1Adq7YEBIZdYVK1J9pHI362dzmUTisCLavGDA3hKdlBaFfWah7e
	6adXyUtYUM=
X-Received: by 2002:a05:6a00:94d3:b0:835:388c:9764 with SMTP id d2e1a72fcca58-8415f379971mr11312991b3a.37.1779658750143;
        Sun, 24 May 2026 14:39:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165003369sm8285196b3a.57.2026.05.24.14.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 14:39:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <95f0914a-cb25-44ea-9cef-d203c624f74d@roeck-us.net>
Date: Sun, 24 May 2026 14:39:06 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/4] iio: types: add IIO_VOLUMEFLOW channel type
To: Wadim Mueller <wafgo01@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jdelvare@suse.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260524205112.26638-1-wafgo01@gmail.com>
 <20260524205112.26638-2-wafgo01@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260524205112.26638-2-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/26 13:49, Wadim Mueller wrote:
> From: Wadim Mueller <wadim.mueller@cmblu.de>
> 
> Add a new IIO channel type for liquid volumetric flow sensors.  The
> unit exposed via the standard _scale attribute is litres per second
> (l/s), so drivers reporting smaller native units (e.g. ml/min) only
> need to set a fractional scale.
> 

Two questions: Why restricting to liquid (there are also gas flow sensors),
and why litres/second and not per minute which seems to be a more common
unit ?

More on the latter in patch 3.

Thanks,
Guenter

> Update iio-core's name table, the iio_event_monitor whitelist and
> the sysfs-bus-iio ABI document to match.
> 
> Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
> ---
>   Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
>   drivers/iio/industrialio-core.c         |  1 +
>   include/uapi/linux/iio/types.h          |  1 +
>   tools/iio/iio_event_monitor.c           |  2 ++
>   4 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5f87dcee7..68eb703c1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2458,3 +2458,20 @@ Description:
>   		seconds, expressed as:
>   
>   		- a range specified as "[min step max]"
> +
> +What:/sys/bus/iio/devices/iio:deviceX/in_volumeflow_raw
> +What:/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_raw
> +KernelVersion:6.19
> +Contact:linux-iio@vger.kernel.org
> +Description:
> +Raw (unscaled) volumetric flow rate reading from the channel.
> +To convert to standard units (litres / second) apply the
> +channel's _scale (and _offset, when present).
> +
> +What:/sys/bus/iio/devices/iio:deviceX/in_volumeflow_scale
> +What:/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_scale
> +KernelVersion:6.19
> +Contact:linux-iio@vger.kernel.org
> +Description:
> +Scale factor applied to raw volumetric flow readings to obtain
> +the value in litres per second (l/s).
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 22eefd048..aa34fcd8e 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -98,6 +98,7 @@ static const char * const iio_chan_type_name_spec[] = {
>   	[IIO_CHROMATICITY] = "chromaticity",
>   	[IIO_ATTENTION] = "attention",
>   	[IIO_ALTCURRENT] = "altcurrent",
> +	[IIO_VOLUMEFLOW] = "volumeflow",
>   };
>   
>   static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 6d269b844..49480f321 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -53,6 +53,7 @@ enum iio_chan_type {
>   	IIO_CHROMATICITY,
>   	IIO_ATTENTION,
>   	IIO_ALTCURRENT,
> +	IIO_VOLUMEFLOW,
>   };
>   
>   enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 03ca33869..078004750 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -65,6 +65,7 @@ static const char * const iio_chan_type_name_spec[] = {
>   	[IIO_CHROMATICITY] = "chromaticity",
>   	[IIO_ATTENTION] = "attention",
>   	[IIO_ALTCURRENT] = "altcurrent",
> +	[IIO_VOLUMEFLOW] = "volumeflow",
>   };
>   
>   static const char * const iio_ev_type_text[] = {
> @@ -193,6 +194,7 @@ static bool event_is_known(struct iio_event_data *event)
>   	case IIO_CHROMATICITY:
>   	case IIO_ATTENTION:
>   	case IIO_ALTCURRENT:
> +	case IIO_VOLUMEFLOW:
>   		break;
>   	default:
>   		return false;

