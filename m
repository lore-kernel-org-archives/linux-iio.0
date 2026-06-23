Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB013242D65
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248657; cv=none; b=pQYDOzudxGQm6k7toj4EPKmu6+c4wpaFXnHctXX51o9AJ0RgNOQ7tmlynZTtrc2TZToY13pWnHEFaKMjQsodAGe84S4B8Pj29phBySee1VxMc+xInj4nmKPUUfuvDVjS2wc+UBWFgIfKbefM7za2iVopNXciztwLeLucLDSpH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248657; c=relaxed/simple;
	bh=G2O/RO+LnvNcHuRCY2ZDyqZgos6zxE4R7b3nGKbOZ3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iqd60xPD3+IjgemIIPQ2ntrEgQmDrEMSl9tpMFi/YtsbD2PlIHuYwCUJnlkOFQY5nWdFvy3DAylFK9+jhHzerLSXjZXNCUmAkAGmVj9wuIbj644+lz4ukTQ4HYlNOvx+dPmrI/4WWB2F50LF7TB3i+Br1LNPjjKyN47eZ3PoTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pKvFbOV+; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pKvFbOV+"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a11eb98e8aso171261eaf.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782248655; x=1782853455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjxxtsMjV//5x1nEFpoBC5beYz3SbCaf566TA7ysPr8=;
        b=pKvFbOV+J4qEM1LQqOLKRuGrSPe+6kjoGHDBSbSdApV/FPsAGP/nkSRMv9yKCezW9U
         mKk5EAjVKx+RGaJdfV0WPY0PPXVde/VWD/SdgAg4i7gVK1wSsGLBb0aMZLMEnDKYWlVS
         FGh5QrZPKg0Ycmzn9QZZVXl0SZyzyDTihPcQhK9Z+e0slWqvmW4qcJCbVCwiFAJuu1R9
         k819Y6FN/LgIkOqCE4fqlOlBoJbItLPVmNKucrk+17QnRXDv6mjW8E6qVT/cLWhj5lYN
         ny8O+0V+yQZrljfEpdFMfyoo1NFrUzbndIGLj+uCWE0B53fyZUsPanJI84znOU+uVtv/
         P6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782248655; x=1782853455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjxxtsMjV//5x1nEFpoBC5beYz3SbCaf566TA7ysPr8=;
        b=FyNHilB8otf255PDJzeQclP0hHFzwjBcd8hVNgnoJVvNUukJEtWBoE4fOZMBVsdN9V
         3cipPv54q9UKHJ2p+8faPOZTjPopu/GrFPp8n0n7OuqON5QeeH015HXA4Gjkqubt0rRF
         mUhJJtmbMO1f5c2chPfxFD3p/Yw2+hqH47v8yNyQLHDvZbUSAWuMFu6bJyArkb2BJXsp
         GlSQHCk6yrNQpvY8AnYIkO+/O/qS8sCEnI+scQ3/lpwnuvjUn0n2hqrujPJxky/sGSqR
         KqV/uY2yD2zWUi7ip2L5YxlIb8MhUbfplfiLxt7v9xdStpabsvBMixumYpt3FVRnp3MB
         uUfg==
X-Forwarded-Encrypted: i=1; AFNElJ9jGYVUSnr9bzVd1hDxjRxRFST5e+Chgj+SiIHHxSl082iLqODMhrqklgnkG8GN6nfqoP4mL3cbBt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43hw3be+99QyakudUlB0f1JJkzgTh1rUDiWD7YPeyDivnm7b+
	ofnXH+V7i0uBjBalVb8cnvOOT3xoC4w/RfY3IziJvWYYsf2K7L4SqFiVBd+B1Knk4HA=
X-Gm-Gg: AfdE7ckraW4RQ4ErLAoLkVXWz1xxXz2xBTiDypZM+ZkukfnrA3WQFj6i90YyrLY3EBW
	WQgJ2/q5tp0MzAkwVWBhA6mykiuf2q7UERNHv7mjZ17tVoJESZPLKe1IyCbkag79U4i4jAX23Jh
	HebbKaFBReB2z6U3vM49ut5Vftrb3ke5hh3+r748TbhfXoCs0kukXbANqdlp4X8TLXgAlPY1tVC
	A3UyDWSN24egKpMwVfq5BsmywuzYScLqwAkgwInyDVDgbQAmjp52cnsHvpBNU0qurVwC2ytFtT3
	BXvBgDcGizRBeIiCOgsFAXrW34CPclJGEAWInmRlY9yhKmv2+Xsh2noXX2F7aOtOqtX5ZiLqfSm
	y3a0ixgDz+Jz6d1Vj8oealPoEi5FvsP34QhGq22vZZlTG2zKfYla1f6986vDLtGHTEVRgoKfdzC
	t+c71nEUVboRpyH8jhpsbc+SA/HJ8mYJ0HQR1VVgr6MFgMplLZiDBjJwBwFiJtzhY=
X-Received: by 2002:a05:6820:2001:b0:69b:196a:de67 with SMTP id 006d021491bc7-6a122cece79mr392604eaf.0.1782248654734;
        Tue, 23 Jun 2026 14:04:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:68dc:b788:b3ac:e34e? ([2600:8803:e7e4:500:68dc:b788:b3ac:e34e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0ea0c378csm7162013eaf.10.2026.06.23.14.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 14:04:14 -0700 (PDT)
Message-ID: <0ca506a8-29d1-4514-b4bf-296fbf547513@baylibre.com>
Date: Tue, 23 Jun 2026 16:04:13 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iio: health: add MAX86150 ECG and PPG biosensor
 driver
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 joshua.crofts1@gmail.com
References: <20260623140113.12574-1-shofiqtest@gmail.com>
 <20260623155556.13701-1-shofiqtest@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260623155556.13701-1-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 10:55 AM, Md Shofiqul Islam wrote:
> The MAX86150 (Maxim/Analog Devices) combines two PPG optical channels
> (Red/IR LED) and one ECG biopotential channel in a single I2C device.
> Data is produced at up to 3200 Hz and buffered in a 32-entry hardware
> FIFO with a configurable almost-full interrupt.
> 
> This series adds:
>   1. DT binding YAML schema for maxim,max86150
>   2. IIO driver with triggered buffer support
>   3. MAINTAINERS entry
> 
> Changes in v2 (addressing Sashiko AI review, Joshua Crofts, Krzysztof Kozlowski):
Please don't send revisions in reply to previous series. It breaks
many workflows and tools that expect each series to be it's own
message thread.

Also, when submitting a series for a new driver, please wait at
least one week to gather feedback before sending the next revision.



