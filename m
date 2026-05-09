Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6E386C28
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362558; cv=none; b=gGfaxMnZDIw5hm235NOS/ud8vRb2vgb+lEUMNqMKnQSOpiWjWH8c7McXYugmdRgcWQ7O9N7rn3TI4D0seaGsVbT5i00Bfmf+GBMeUj5l9ga6LQaA27l8Z59tk5cm9s5e5Jn5XGmZf6ds7QXmApZj4RMNWiqPa0+y/U5wnSQMzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362558; c=relaxed/simple;
	bh=J67uTUzOtJv34a1o3K1+pm6HLFFypjoFMklnf6FHSa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZ/dazuxw66F6/0nZfn1o3edODWK2yav+n82C7iwDlx1HUthlAup0MQ36D+f2oMK4bCYEPW9ReEtI/g/L0MOIGtO9zy0/+FPK9UumAIK+A0JRxenpsEZlyqB2YDg7N1RGnK8e2y1jzb+XW4DX5r5sbX1I/pb9f0x0Pue0guEeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ahvZ3RAg; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ahvZ3RAg"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dd73b7c757so1667490a34.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778362556; x=1778967356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/ekXA5bmU61aG7UyRq3M0hlEU3MeLb60TJwuJg45PY=;
        b=ahvZ3RAg9YmKWyMxux+4iay/owfd3ZX+hm7wP/IpMuo9Xm+S2Uyz/uOjQehbfHWeug
         0c6OJauURQpOL4xmdZCdlBZvzSQgEV/eKTHIkyz/WbGfKVf3JX16cPOGOGYJ9KUwAx7L
         8rB3YmzeB7Cc+kzGEOjnT4Hk0EaotqZoPRR2AllEmNAVTbE3T/fd8Q/fjnvz1dtxMD9X
         5/sP6ByZieeDA0rE2AzTk3liukVESii8PsTbqFM6dg2s/rHlBgkzT5Gueb2GEPwrnt7s
         FtjDMbbyKQMUE2YwZDHH9wClCNa2Wnsyv23RmyRUYk/jpvkHkxigNPBpQISHE2Daai4d
         ZJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778362556; x=1778967356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/ekXA5bmU61aG7UyRq3M0hlEU3MeLb60TJwuJg45PY=;
        b=AdfVxpoqXIzc287llL1hS3im5RHxAFIPb+6vIaSuoXVFAqlmO5qrJ/uM5NdeFAeijI
         /CHb+uoUzQzpKF4g0dHhXURcWS6XxfT0e3Gxvok3TDMkSoHeO3Q5XhN2GSv7aYCEPmtp
         xOX94V7F5pYIWk4praM0fxrSaW6XVpg/nTMx1S03QcqeKRkk4tkjyVBPiTHFrFmBpL32
         tW/kTNdx/Qp39yg6kSv1U0bydmV05ujoPX9ZXOSDFm+EkShM+iLEnhmfrb9nsEVdeeQD
         uh/u0qIkFduf8WZ1B8rSv9fz/Kq98a+t/uWQ8sm+ctNJywpo3hBmzm0v4r8oLWAcuHfm
         qkgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+N3XZjZ73tmMF0fSPEnARazattsSKFVS4Ax4PrtmrA/dfrcKTf1irGVKK4Klqsfk8FsQtt86qiRsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGsSdrI61EPX6XggiCPusImpSc6h3SwukzEcNrUVhRzi0CqIr
	++WpaRJjhHyhoNMaX/y7qrKRP8MngPm/KJrS1rJeFCbfKeRrya134ufeVg7qgf5o/p3SkOZXaBa
	KnRVd
X-Gm-Gg: Acq92OGj15F04vp+9xusTJNnN2SFN2toDJ1dvRUj5dpvFsJ5VexA1u/wUe8AfldZzDv
	Y6qnyI8MP5+EtoUh/MkU7rZNRRRfHRsJZRfR63keadSDEnK/nfi8gaMIuIq5HEH6Vt+j9gQtT1B
	V2rzSx+6SPL3ryYgYWYucUsnhr0iUaMf4ui+Tr4Y72vu9nsbnZjbnluOVcKB3pv7Q+qNMGnUL19
	0xveVwOl4MMpBcu6WNAylmxuiVnsjIlBdLYQ2TibSO3GYFiPPfa34+R6TL+gOBJJVC9cOiVz4gS
	N/eGWPqedEpcrvYIfNpZTsfPQEnO6qk/4QqMoZsNeN7ZiBtqHCukBeLujQkzdiXRQ6GHRUSZKeR
	bHd0k3Nzbvc03EZlCW2I/6iKRzvn3dQ1Q2yL5s3kngpwNikAbN2VNQRgPt6e8gmYVW4Fx3BCDgL
	GOj6rq6+dODBWaarqCKa93SkTZ94Q0LibB4zlcqJWfF2F1e6hhUpWzryipent3EMtnr2v1qjlBg
	w==
X-Received: by 2002:a05:6830:2a10:b0:7db:d229:d51e with SMTP id 46e09a7af769-7e381f98af6mr2630712a34.12.1778362555980;
        Sat, 09 May 2026 14:35:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c04e00sm3715141a34.7.2026.05.09.14.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 14:35:55 -0700 (PDT)
Message-ID: <eb091bdc-3c1d-45aa-aedd-3c9da27f7f21@baylibre.com>
Date: Sat, 9 May 2026 16:35:53 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] iio: hid-sensors: cleanup codestyle warning
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
 <20260509101040.791404-3-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509101040.791404-3-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 5:10 AM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Reported by checkpatch:
> FILE: drivers/iio/common/hid-sensors/hid-sensor-trigger.c

checkpatch (or any other linter) says so is not a good reason
for a change. They are suggestions, not requirements. If the code
is improved, say why this is better. I.e. improve readability.

> 
> WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 28d050b45c74..98fadc61a68a 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -313,7 +313,9 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
> +
>  	schedule_work(&attrb->work);
> +
>  	return 0;
>  }
>  
> @@ -321,6 +323,7 @@ static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
> +
>  	return _hid_sensor_power_state(attrb, true);
>  }
>  

