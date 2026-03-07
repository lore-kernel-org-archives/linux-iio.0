Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D932E729
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772902626; cv=none; b=gJuql1i1WcgkvyJdbSw7bs/CqTt22fSb351FKhmtIL/owgjZmEFy+pfXWaZAdMqa42qchCpMx1Ie5QMCVZSXJdL1uPZPXJyhEyERlVpgGwUjk2DwhpaNkd3x1Fnww5ePHDV6PjRy/h37GbaNdfuzPp5wKGBftmp4O3L2eNxsb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772902626; c=relaxed/simple;
	bh=aatrlOiGoA39oFJftX99q90aQlHSCQn8nrpZj9H4bPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjeVgqVEkUoeib7WPhZ1pHgXGymnBWqJ0lokFiO7QRjWi/Zbw8J4QzfiQZXoqnMkpboXvJguDpbNgJEDHKcxBhc0WuuxvvhjFMHWeiBAXZdgmobSUvZh3I6MNVj63LhY48BFWXIgaVHNRJ1ZlvbwQ5ar+65kZU3+Y2TViSkTRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lrLeKo5h; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lrLeKo5h"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4c3484268so7318071a34.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772902624; x=1773507424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N17bWKAVNic/QJp0Klj6senGm3Phl6tbrkoAFBQxBUc=;
        b=lrLeKo5h0RtuGv/OBq/FHIqmkn5ZFixwXywClzHs2fXLSVqmy8cA/ZQ/IwzMWcbMZU
         G2SCPY0fDNYliJKdwdFx5zqgKQJMtLONg7xTc8sL4tivGAdcai7fkqNW89bAd+G5epTk
         ip1KAxviDJHURDMpsJeH4a/o1zCpAqC8yCvNbXUI9PDLkpGxd9I8JccEMIARwvY8j0Mf
         Iap03fZ0QffiUXCGfAp/H9wr0ZZB8zVidTjLfyXB47KXsKB6ZP+UzObNJgKoEAPVZS+c
         tUFDczKWOeF+KBUVcI88+GhcOGIOpl9jdJkWBqbgepW6OrSQ79KNXs2qtuF4sD/SQ30v
         N5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772902624; x=1773507424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N17bWKAVNic/QJp0Klj6senGm3Phl6tbrkoAFBQxBUc=;
        b=jAAinimShcNQs4dmht7PcEVyAkovdqhFUgDiOc7synfPQVB1G9LtxvBNR5c5eAxOwo
         mmnEmT15bir6Msqa3c7bfgLCUIXpksCsQBeAlOv/KEn5NGTkcAxs49GIc/zn1Oxl9qEQ
         GHCWM3cH0C8KkKozX1VYZGsxeYNNV7Han/MlLJfaTWnpyuLza18NvfBxRgLwtiI3KRg7
         nvDAiQJ5Nap1obD3/yAfbcTr9gaUZqyp6HDWeS5rbW64SDz+wINVoPca/Hw/LPv9X8sY
         lGcxNoL9++JXRjzt1JwN9aXg9ADVOtfcHHVb7w2IbjfhHLO5u27B345r10YzHWA3Rr53
         KvaA==
X-Forwarded-Encrypted: i=1; AJvYcCVABun0AK8mBctvp6lgss01egtY7mzgT4+F8KLeBh+sbrjisXczdcuZy99jTAAaMbozLpZaR/Bod0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbCZTtGWyYIN5Dm1wxkj6JDTli66a5Jd8bYgH8BBbMVqd0Zej
	l7Xfjzdh2w4O8QMFn2mrv2kLL+haNkrHQhJYlD0eDNWkkfPn01/aa8Jdn5oSNPTIaIg=
X-Gm-Gg: ATEYQzzCUTKROjzjOoWL+fljk/B8B6NwVGDcAbfXMBWmQ+0Rq4MW42jX2RrjNVgIhxC
	vCt/jotkjj8FyC9XC8/E/4wp0u/YbElvJy7A0Gbw7LFuoBvmpcZt0C0DYou67RXrkk927ciRxtL
	bwHgocpj1PPkrdsnGKrY+qQ3jQOq2J+L/QgN+58qs7pjJqAxD36zp5UgCEgnvKjEushpjI9nKAy
	e0SJQ2qZpDTcchwZIDKB7fvQ50oUoID5SGm1C5319cbYqsjzqpl0LvalNvWc5aGNiXLRFKypGHw
	UIVeRc7uSPDXxHwvSf8wKCUOZsn6N2CG2A1rsBaSi/K/sTF3tjxeFFB7e0BOtz3UcKuL0ZdzlDV
	B/i/l0EWmHwZD4k/T414R3zF4rFH5N6rHRIWck3wO/IsCgnBYciw3ngwuiPVqLX3pruo9wVHQnv
	eURD88PmycJgz01vJyEIGtNiLyrQ0P5r423xWrAN8L4JQ8A2LWL+rnlmWoZZ92mTkkJB/feKdKa
	w==
X-Received: by 2002:a05:6820:81cb:b0:679:f11b:a511 with SMTP id 006d021491bc7-67b9bd1690dmr3543813eaf.45.1772902624163;
        Sat, 07 Mar 2026 08:57:04 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67b9d50401dsm2907326eaf.12.2026.03.07.08.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 08:57:02 -0800 (PST)
Message-ID: <0894daae-08a0-421a-9f94-cab2cfae1ec6@baylibre.com>
Date: Sat, 7 Mar 2026 10:57:01 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: add entry for ST VL53L1X ToF sensor
 driver
To: Siratul Islam <email@sirat.me>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260303090253.42076-1-email@sirat.me>
 <20260303090253.42076-4-email@sirat.me>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260303090253.42076-4-email@sirat.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 3:02 AM, Siratul Islam wrote:
> Add maintainer entry for the STMicroelectronics VL53L1X
> Time-of-Flight ranging sensor IIO driver.
> 
> Signed-off-by: Siratul Islam <email@sirat.me>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61bf550fd37c..cb8ee607fda1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25093,6 +25093,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
>  F:	drivers/iio/proximity/vl53l0x-i2c.c
>  
> +ST VL53L1X ToF RANGER(I2C) IIO DRIVER
> +M:	Siratul Islam <email@sirat.me>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
> +F:	drivers/iio/proximity/vl53l1x-i2c.c
> +
>  STABLE BRANCH
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Sasha Levin <sashal@kernel.org>

It is preferred to include the MAINTAINERS change in the patch that
introduces the new file, so this can be split up between the two other
patches.
