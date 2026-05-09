Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF54839936B
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362715; cv=none; b=iJqICOtgoZ+krrOvnhoPLmfEGRI5j2I9trLZ3uMXdPwr0XedfASn/D0SnJZCC9lAF64O7/GbCSG/fygjwfX8qBSGIyKwdfCkpx0Q0ZZVW7QsJqYVq7ahjsrj9TH6XE00bFsSaRyLjMykjS6QE7STue3BToJCNz5YK3L/9BYOEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362715; c=relaxed/simple;
	bh=Lzy8Y02vMM1ra6Kp3zwwNJPUui+pq/nw0dALYSvm0l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnFSu3s1l+2G1VA7jz+wWtk129Xi9hdAKjKwdq19lVzST9NpTqbAAvXe7xWpktX2CmT5EFPh7xCszsvonmyi/ZaSdjERv/b0y0cqPy+2pfZFmLYoU+M0BZBDivaYljlozHpyWtD5ftNaVi2zSkomjxW3l28j+WqCB7uQtW9rUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=UKSOX0U6; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="UKSOX0U6"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dcd89701acso2832492a34.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778362707; x=1778967507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BizQb7RbXQIMM/Ma+be2LYItJpdbh1k0Zyy+TbXHjU=;
        b=UKSOX0U6eXaYON7bUHr9VYIGdJ891J6Kc8Wty0FGF5Xqc57k+Eo+6irngvVRkiW7JT
         RQ1dvKrzjTq4zYBkQ8VCP56LcrJesjzyWmTb0wLs+uKGYDgsQaag2cu+/9sDFX+9uV5l
         nJK3aLhMJ7jVf+5p8r0nORiagfdxeDTFUjRpTN9Aa3QgqndqYuoC296BShNJgiSOTJa2
         6BOCnq7q6HekpYafA5Ff1/M7xfnAoLwoTnfIrG3Zk8cMtoe5aiStBmIsmApjGbVpPN3V
         8nB+iTvYcPPr9F1L0sA/z0KMZoTtixmPZKIrJj+lOaWJchWOZAjC6sDYmuCZpZhu++hy
         wZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778362707; x=1778967507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BizQb7RbXQIMM/Ma+be2LYItJpdbh1k0Zyy+TbXHjU=;
        b=ZiC/X8hSVry1QCkA4vBQU7xdo9ABoS/xRuEUxgyKr4kWwOhcEyy1Hid0r7EQYgUIGS
         7UUtxi2Zk78u2Z9DsEJnd1ECFaFEJpY62bS38eSr92TXcTdhI3gQfa1ftO/NPzRKoMji
         blePaHDYL+QrD8WEZRTa/OrJVHitee3QmQ8wYi9qoqpGjhw7hhQl14W5FJ5FyvXnaCZb
         nKFmohfwDhgxa89ucij3gc+FgML1oRdLAOwecCE8+Q/WA2crrVT45L8TML7OQl0h+WAs
         oraNPk9iUxeoeMSdiONQIJvrt33p3tnxA3+cQ2PbivaaXdtOXDVjPbuV4VCH5WhWdF8G
         dvLA==
X-Forwarded-Encrypted: i=1; AFNElJ+TYdoYUYkPTCkagL390YYO2cz31QxLwZVxxBbEWQMZUF1I+r63dqqzFL5U5okYPGdN32aHj/cKjLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZzNLa0hRExYM9DbhyUyRO4Ns55DB1BcRPOOuKld11b5Eeh2pb
	M6KpUhZzEZkqtNuuRCQ6JvysRUjzsczEBZxCOrTu3UkvzOwEbWX0kndjgvyGe07kRx40oyiLCIV
	dE3eq
X-Gm-Gg: Acq92OG++ADGSJMk+mlgmsDKyqt5gXn43ciiURAe6AWT4Xsqn2TeH3CiQzsP0Y5FRPn
	N9dVcMg/cYgjJ6wkP9kAWcxEKnmiACGZL1xvnlC9AWomtOaf8YtZYNKUFBfDR+3XilduhBGno15
	VBHaz2W4DqT83soWZaoI82m1c1ZN/Xa8X+7X1esWPBzPGfzrn1xrQhxxPYtATHR+PDgfZK2B5Of
	mHafQhH1CQtnRKhk7DnpMTgPARoPBmCwK76BBE2oCuIAjoUM8+8OJbapRNKSv9sXuq+jO69DR6W
	Ny0MdimypK/1bhZkJgtAysIniTery2PiSVSh8WNRvaMwI7ajyegsLnITza8qKFZh4vOtL4ZMxm7
	IGFYksVOZXmsfeYUcZy74Cwisl29YZu6esdg/ieo0qOdLIhpqIgjiCQi1gbDiZJTIyXeqjr6Ixu
	EluksXVvZUlXMAJPbbwcAtVMj8OgNnkoNT1WFotH2iJ5Ek3adNHdL+LL3lYN6gHtGcxP/+ciqen
	Q==
X-Received: by 2002:a05:6830:600c:b0:7d9:b58e:55ed with SMTP id 46e09a7af769-7e1df137a49mr11616808a34.25.1778362707189;
        Sat, 09 May 2026 14:38:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c0bc16sm3723179a34.12.2026.05.09.14.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 14:38:26 -0700 (PDT)
Message-ID: <16811995-2371-4f4e-add8-76b5acc30f53@baylibre.com>
Date: Sat, 9 May 2026 16:38:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] iio: gyro: hid-sensor-gyro-3d: cleanup codestyle
 warning
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
 <20260509101040.791404-5-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509101040.791404-5-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 5:10 AM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Reported by checkpatch:
> FILE: drivers/iio/gyro/hid-sensor-gyro-3d.c
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> +                               unsigned usage_id,

Even better would be to use u32 since this driver already uses
that type.

> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index fe663b19e902..87537f9c58fb 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -187,7 +187,7 @@ static const struct iio_info gyro_3d_info = {
>  
>  /* Callback handler to send event after all samples are received and captured */
>  static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				unsigned int usage_id,
>  				void *priv)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(priv);
> @@ -209,7 +209,7 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
>  
>  /* Capture samples in local storage */
>  static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				unsigned int usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {
> @@ -244,7 +244,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
>  static int gyro_3d_parse_report(struct platform_device *pdev,
>  				struct hid_sensor_hub_device *hsdev,
>  				struct iio_chan_spec *channels,
> -				unsigned usage_id,
> +				unsigned int usage_id,
>  				struct gyro_3d_state *st)
>  {
>  	int ret;

