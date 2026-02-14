Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8F29993F
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771089104; cv=none; b=To/4NuKy1AAaW3kc8P0yFost4s2kDjqmX5ILloPfjDanhSanZNgh+Hy5GXvQKJSmd4lk7jIKhPWLTk1YeoW7hMdG04yqlKmR3IuPduE9SyQ91Bg3K308PP3/CNsXZNAIHte5byG4TnKe5R9to9PCBFFyTi5hwu67BcUJ2AQpZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771089104; c=relaxed/simple;
	bh=shFR3Mhq3NXkwORzGCftZUUFZdufqUdbJyYnw7FrVyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ljl0lh8pItGUBo+ZugW03aq1ePLYiDE2/g0ezPL/Ckvspo+1NeogsPYNriqUTInSG4I+IeSLLxQjiLnYum79zqo+9hGYfcy9zC4lpjo2t2FYqI438Y+HT5R6NykpyzvtS+r5nhk4KPKzsBacTFapfcgiSjLdrB3xzRcKxXCqQMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ES85KRny; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ES85KRny"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4c9537f90so838607a34.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 09:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771089102; x=1771693902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FNAkJ9+Xkxzx6OmOeEwUxFuTSF9UF4m4udIYFnx2DOo=;
        b=ES85KRny9reUJVX6ajwH8QxT06Yixi9Nh5/AUr68siaD1hDTBJuFVznE+Lvjb7bHe1
         jXGL+aHn1ZxImuAkWI4riM8ueOzHSLAXQHpI38k44qldytxYfCsSflFnL/ebbuiZ63rm
         KscFJfqsZWP+bwgqxXcNip3mKc+jL80sMM5zy8mM3O0S0xXC0N5rae0iikGNWq85hk4J
         1U35Temmfo5oU/YuylcIczbBCacItTFnT1J2+X8DGmGwDqF7tmKrR6ckTPLq4/4Xa/Cn
         pNphfRouGfom8Fn5miW1GX5XDCxon0P+axBQ08cgikouzA1JszPSnTduJ2GToZsOJmFM
         tLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771089102; x=1771693902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNAkJ9+Xkxzx6OmOeEwUxFuTSF9UF4m4udIYFnx2DOo=;
        b=SfVlqmP6D8ITklgRVdDyHoHreypRAf5OLziVf6O8+PZ1V6Tkv1rvls8NNTTmdcBs8O
         MCv8+wrkTvI0VkYCi4E/6G3MnDK1HaC4U4PLm2WR0PWdbe9ehS+41roal2+r9IwwhWVA
         wZh1g5b1roJXihprT6B/LfPA8WWLCxJlWPjmUZ9xXzjh3+FMvTY/6f1ja0H9+1yf8pjb
         8jBiQQbHDOlFE+ABZBWe4zFI1uc8KgLYl55mKdP3rQXwV5NHxC7OI7vgmtfHrWXe+Lu+
         aHPs9NJqFHavx08zk4uXwQ6ay6DQOyKNWVpxestPSTqwpABKqDDLbg6zx7kWXkD4oPq/
         kI/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMuic8XNpn7ozivKOgHaeHFULo9vWP85OZ0ZZrrMceqJwlLFirqjcCdArgCbHKfVNsH4QeIGWDyuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHE4vzWIPha5V5Bh0d3WbZiC618pwfwx6z/DhZPieVSRyjB0ji
	Wy910IWwEZveGYucyOeqEiBb6nWVGrIRZkrIOQbPAFl2qHf94RG1GFO5cxUZdr7abVE=
X-Gm-Gg: AZuq6aI4vH8qrZS2yzR1zV5ooPW3l9HqsZZ5gGIrDsYGo5HupKwDZKc6C3smQvQb+W4
	Fk/fQuMGBpTQdTp9HLddmSFQ/gqFrppyVknXO7RN2RIz1FpXmh1zfbUOPOxtw1l8isDr2QmXZ/Z
	A/Lbh6CWjuhLjCfF0sRjRHrlrT/xMGxdoPtjsXsNYfiOi8AiYxsxVxOEqbu58AffhVBXTCOaH1u
	1z6gZfYwd2ZzZ1vYo1u+hRJLexe1Xkhzb/oYvDmlOjViTLzEj0HHJvt8CPLdVqYxiwejJwEr3Zy
	+52HzdYkMRQyb2btg0h3OHu/P3jFwSpJG3BzhTMnMcAkUgjj37saEB+WJCk9EdL2jJWTnHO7+Ei
	+a4gjeZYGJBDo/bGRGez5Ih6R4vWfAvk8E0/K6cjbI188W7kqevXpM94BBXli4Va7XzuA1QLMNE
	vnRQhy0PXTHQuofniqu3rq60+jX0r7jiUsfRAJFnh6XNUK7CppZ1GrZkzhJcqF+EL7NpY6yg==
X-Received: by 2002:a05:6830:4981:b0:7d1:4f21:ff79 with SMTP id 46e09a7af769-7d4c4ade534mr3765219a34.22.1771089102314;
        Sat, 14 Feb 2026 09:11:42 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:109:393c:254e:962e? ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7530d08sm8764230a34.2.2026.02.14.09.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 09:11:41 -0800 (PST)
Message-ID: <53cb71bb-4943-4e2f-bd26-9adeada84852@baylibre.com>
Date: Sat, 14 Feb 2026 11:11:41 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] docs: iio: adxl345: update math and examples for
 scaling
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, jic23@kernel.org
Cc: rdunlap@infradead.org, skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260208150515.14798-1-0rayn.dev@gmail.com>
 <20260208150515.14798-5-0rayn.dev@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260208150515.14798-5-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/8/26 9:05 AM, Taha Ed-Dafili wrote:
> Update the documentation to reflect the addition of event scaling
> and correct existing technical errors in scale values.
> 
> key changes:
> - Fix the 62.5 g/LSB typo to 62.5 mg/LSB and add SI unit conversion.
> - Correct decimal precision of in_accel_scale and
> in_accel_scale_available to match actual SI unit (m/s^2)
> values reported by the driver.
> - Add sysfs example showing how to read and interpret the
> newly implemented event scale factor.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
> ---
>  Documentation/iio/adxl345.rst | 41 +++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
> index 3ca6a78feb5b..321565699817 100644
> --- a/Documentation/iio/adxl345.rst
> +++ b/Documentation/iio/adxl345.rst
> @@ -13,7 +13,12 @@ This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
>  * `ADXL375 <https://www.analog.com/ADXL375>`_
>  
>  The ADXL345 is a general-purpose, low-power, 3-axis accelerometer with selectable
> -measurement ranges. The ADXL345 supports the ±2 g, ±4 g, ±8 g, and ±16 g ranges.
> +measurement ranges. The ADXL345 supports the following ranges:
> +
> +- ±2g  (approx. ±19.61 m/s^2)
> +- ±4g  (approx. ±39.23 m/s^2)
> +- ±8g  (approx. ±78.45 m/s^2)
> +- ±16g (approx. ±156.91 m/s^2)
>  
>  2. Device Attributes
>  ====================
> @@ -98,23 +103,23 @@ listed.
>  +---------------------------------------------+---------------------------------------------+
>  | in_accel_gesture_singletap_timeout          | Single tap duration in [us]                 |
>  +---------------------------------------------+---------------------------------------------+
> -| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB      |
> +| in_accel_gesture_singletap_value            | Single tap threshold value                  |
>  +---------------------------------------------+---------------------------------------------+
>  | in_accel_mag_falling_period                 | Inactivity time in seconds                  |
>  +---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5/LSB      |
> +| in_accel_mag_falling_value                  | Inactivity threshold value                  |
>  +---------------------------------------------+---------------------------------------------+
>  | in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis        |
>  +---------------------------------------------+---------------------------------------------+
>  | in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
>  +---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5/LSB |
> +| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold             |
>  +---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5/LSB   |
> +| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold               |
>  +---------------------------------------------+---------------------------------------------+
>  | in_accel_mag_rising_en                      | Enable activity detection on X axis         |
>  +---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_rising_value                   | Activity threshold value in 62.5/LSB        |
> +| in_accel_mag_rising_value                   | Activity threshold value                    |
>  +---------------------------------------------+---------------------------------------------+
>  | in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
>  +---------------------------------------------+---------------------------------------------+
> @@ -126,6 +131,10 @@ listed.
>  +---------------------------------------------+---------------------------------------------+
>  | in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis       |
>  +---------------------------------------------+---------------------------------------------+
> +| in_accel_gesture_scale                      | Tap threshold scale (0.612915 m/s^2).       |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_mag_scale                          | Activity threshold scale (0.612915 m/s^2).  |
> ++---------------------------------------------+---------------------------------------------+

It looks like the others are in alphabetical order (or , so would
be nice to insert the new ones in the appropriate order.

(in_accel_mag_falling is also out of order, so that could be part
of the precursor cleanup patch)

Also, missing in_accel_mag_adaptive_scale (it was added in
the driver changes.)
