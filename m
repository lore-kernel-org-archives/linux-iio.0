Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F2385D8C
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225513; cv=none; b=VprLlCG90OIX0qWal/3/F5qxPGnDTa5wOf8873sAoX+qgSWkVnrTkbhSQHaWUzZNyk05U+glwGD6LnaHmMo1xWvKGyE8tIXD7zRLdgoo/3RZspeSlaFgdgcfOjABeaYKcxWUrK9K/4so36C4Vz9j44GsgJgOHuMPOaNBrdHnNIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225513; c=relaxed/simple;
	bh=oVL6eH17uUbLQpEv24sREcpe+hDdZ4ElLtxAHWNQvO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mChW2sjcVUVcdFz2De/pfdbK1c2h5Y14Kawoj9S8yGOsGNplJWOBHyLnGHiE+Djq2IAZsd61iFqZsTdNtbVtMAQ1y3eanZS22Z1NJUzcnfkU1/KVBWxUpt9RBs3iM2iIhqecJMMGSk1ZQOe5aLqCjjJ2ug/3+t/7RHEzSlsyESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4d1AmA4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4d1AmA4"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso2480343f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782225510; x=1782830310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2Sd8g57ugFLdVox2kG3CaIMONKuSf0WLGf2qHcF74c=;
        b=S4d1AmA4cxKt0CULjn2Rk2Sb2iTOIbb5gQ33Dkn+jIX1xYhD1OTalae4nYvp5G/+e4
         bnIhHynGiN5A06hUGMUP03nkwn8rvPKEZ6bwm7nOfJsmZDv44lEm8+xpMI2Fwl7YFb2o
         n1JH1lEAb13QA46W7PEhkcrPFWC0hfPjFwqJJFYJ2TQz1+Csmn7+SgOITuv1ak/blI37
         DeISoDWxZC+VuXez5pT+DyFBXyux9BocQuHlkTMc1kOuoublcUxMAgYeyz2oJpb4SuSL
         raBsVPx8RgGiqYy2jLKYZXabwFiFhc6PMh/qHr0vbB6U7VBtjIH0UfW0BuD5u8FH0WbM
         47/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225510; x=1782830310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w2Sd8g57ugFLdVox2kG3CaIMONKuSf0WLGf2qHcF74c=;
        b=ITz3NWdyNq2WocBXsQTgtLkgeIM5bM1iJnggeXarKAAH6Ik1b+8GKYYzAoxw3i/7RB
         w4HV7x9oqBC536CwPgAnuHPmPtqjqtbgPk8iCE+UNEfhyYMcCDNDbBCnQ+dCLcI4Y3VV
         K/6y7kMjl4+RbpMjnpQ8ScyghVVurLUII6Wa4tOc58wtfAtDb8Q9bUzD6SsIc0IpgPQ0
         NvgWLoEyQMtmj+zd3F2hXVKoghkg4aO7hJCVjAM6rfggAqvW652L/aAvQ8kkzJM9vJVZ
         pbA2e4v0hiVDU+iu9gMAMQLrPXp1KyUrGdrV56KtAIk0TVFGSKxJCfLrOl4t5+FSEroX
         NexA==
X-Gm-Message-State: AOJu0YxJZgIGJuXQlW/norbGocGC5CuBZQrzAvvaL1PmP1bKWZrLfXJY
	WWvU9FxMqRNv/d2SYRrCtRuTr3mJUtGV+QSoPRuEsZvs+38bhtRXf4AT
X-Gm-Gg: AfdE7cnWHs714SQtK3jE59Z3fwm8k+uzMzDVRdVB72HtXff2yETEXABPZ3bTsMcQ40/
	Ot/p1jC2I5pIgI2MddPqr3cBHZJ5ep2eyyrTRJVn+sbK9VYQWZpfe4T7eabJd19sBfaKnEpCKJH
	b04SUNSc+lUxmJXqh13BUuM0jljubQx/K6RANxH9xTz8UpuJw1H6+5+iiA6YHYCWMSEvbtwFwBd
	EDQbWj7ey+S+u1shPS5/O6e2gdpQpYc1kR7Nj9hnJuTUQveGUA7iA7Fz7yVVrKC1qt/ixoWHEA+
	Il2Bkv/XyOK0lT8RtwkU3IbhjJEzmJDciPCBZkMJcuPB11apDYlgQxiUPSVORPqcU/ESLgOLSyz
	1rgIQTix0EdRsBXtsq39kpZ6ll2fJS1mAeqwqtRXrI8S1w+DlV+7l+FF0YckYPM384fciSb2Kd2
	ckXN/x+UME1mrjEJMO1gCzQvinM54YhCUGB2Di8VTmyRwM5iyykcBh/KHisyqJ3N+/fEHeYVpTw
	WtKM2gwn9yFwamvHnoZtZTSAVNeDQe5GG3/3osvDYX55NrdqdDzm5V9vOf545t/OSF8oI25a5Uv
	tnDfzdxFWlzKJAF+8tIshTPxh9xljVxCQ9/DSnn5+UiKjSXEnMRoowU=
X-Received: by 2002:a05:6000:22c6:b0:460:3233:beed with SMTP id ffacd0b85a97d-4666348bb1dmr23233666f8f.41.1782225509853;
        Tue, 23 Jun 2026 07:38:29 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e3esm34607427f8f.8.2026.06.23.07.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:38:29 -0700 (PDT)
Date: Tue, 23 Jun 2026 16:38:27 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <20260623163827.000079f4@gmail.com>
In-Reply-To: <20260623140113.12574-2-shofiqtest@gmail.com>
References: <20260623140113.12574-1-shofiqtest@gmail.com>
	<20260623140113.12574-2-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 17:01:13 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> The MAX86150 (Maxim/Analog Devices) integrates two PPG optical channels
> (Red/IR LED) and one ECG biopotential channel in a single I2C device.
> Data is captured via a 32-entry hardware FIFO with a configurable
> almost-full interrupt.
> 
> The driver exposes three IIO channels:
>   - in_intensity_red_raw   (PPG Red, 19-bit unsigned)
>   - in_intensity_ir_raw    (PPG IR, 19-bit unsigned)
>   - in_voltage0_raw        (ECG, 18-bit signed)
> 
> A hardware trigger is registered when an interrupt GPIO is provided in
> the device tree, enabling the IIO triggered buffer path for continuous
> low-overhead capture.
> 
> FIFO reads use regmap_noinc_read() to burst-read 9 bytes (3 slots x
> 3 bytes) from the streaming FIFO_DATA register in a single I2C
> transaction.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  .../bindings/iio/health/maxim,max86150.yaml   |  67 +++
>  drivers/iio/health/Kconfig                    |  23 +
>  drivers/iio/health/Makefile                   |   1 +
>  drivers/iio/health/max86150.c                 | 512 ++++++++++++++++++
>  4 files changed, 603 insertions(+)
>  create mode 100755 Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
>  create mode 100755 drivers/iio/health/max86150.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
> new file mode 100755
> index 000000000000..1bf10fd1a3d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/health/maxim,max86150.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +

Split this into 2 patches - one for the new dt-binding and one for the
actual driver, KConfig and Makefile.

Additionally, since you're adding a brand new driver, a MAINTAINERS entry
is required.

Kind regards

CJD
