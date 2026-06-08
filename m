Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D1397E9A
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956236; cv=none; b=AkoEuTsOdDUW+E86Gl4pjPtoVBDa5nZbO8ZUQJY927hz/3x3AHP4YLRzBQLuRy4741K4AxDCKRiypBfl+vLMakoz5kpd6Xn+zYXp98/eFUV6ST/kxQT0C3/EtRjXkzrY0Ft1BxwoOSTgt8G1xCjyGkdmaAyA4DV/nCikdXuT9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956236; c=relaxed/simple;
	bh=JlBnF56ZRWnzHd6GxrSk+oSNEixwMBnfd+3FNnXVXE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XeLRRbmwtNHGtsGd1pEWBwb+SJinGIeKo2Ij9cLeKwZ3ZZ5S892fIGyrhC9woUq/Z+katIifSBvNtXxaOe2RYoJC6k1aRGlVHRHDdyFBnTQseqCkz8zNu4iS87CL2TRhFP44aQ1vAQKn/+NRLNnT4x37tt7K/iVT5ZW8nsb1SgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUpBx5EV; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUpBx5EV"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4864a8e80bbso3068560b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780956234; x=1781561034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrvtrOj9d26ipp+5hv4zWK+nSNPtOXlbAt1AUwvEX2s=;
        b=gUpBx5EVFJN2cDP+Fpa8zl1A0xgI06Jad+XQ/5OSbyuw75UDBVxW937arNREWROTOF
         90Y708oZJNzvHbEWxpx9s4og88g48TQatRsK49EO7xNjJm2m3dyM1CmscWKH0JglP7O5
         FuRCeI1Suv63boMsYauA6gl+KuA14bMqmGdLorSkxon7WDysrvKIWDUox7CSOoLWZqhS
         X4obP46R3y9+8bbh2w5yUGaJG8jgEEpf+hGfC67pFXhl3QyPsIy7hKVKjzG9pCFS/DMJ
         j9/533ypyk+bMJuieqmus56s8QflFHnJHyqMWjx/M2wnfL80agyt7fRiJf1nGNBwlSbM
         gSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956234; x=1781561034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrvtrOj9d26ipp+5hv4zWK+nSNPtOXlbAt1AUwvEX2s=;
        b=extdKoqRSzmjErqpJGVccX5VwrJTut6Q/odd2LozjXvxjf1hP6R0HbI4uGVZcrX85n
         rpMK5h+kX0meVJLaExBXVQyMD9SJ1YawWjm9mP6rSKHU4xijaz2DsinMfhryMMu1rIUN
         FdpTizpjFjdraapaiN62aJtk3mQ9fYE+jwkL/iHjFi2Hz9ZkjslEFFEgJYwxQuSrhqdp
         aKGLEXec9FQXbfsOEZDxLvl0+6hTYalr6o1D2zFwnAFiKqonsOXRsOCvqZ1Ndu2bOuGW
         zjpwcpCUWCBAaPElYuPedRnRoPUJBxyg2DX7PIAQxS9AGDLI3NQhySyL86vjxe7e9MJe
         xVCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8okUn+9pZFKiY3WU6CZPhO6+DgR1DD9QtQ5k6MBEr1IjERYaBJqDgx0FOQU/nqeJHxtt5e1BHADRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyViEaCAcJxR6HihhXLhlqWwoZwALAEmZPBoqBt6qbaP23SSc+8
	WnPj2riLbKbF7/wNtEBQ6BRJ/2zZnUhu0Urw+6cgXbDrq8bWUAdGeRdv
X-Gm-Gg: Acq92OEjRP/CDLsBZs0jR3MMkT96nbttX3U5TXB+SBnFpNE7IdWd3Peh95SEVQgc9ej
	U7eTdTRCipqrUNN7IqB15YCypQstpAWXuFOtHYi6Z0rqtEs9IeBCIzWq/lKZBu6keLuxwswNgDR
	j+qVKLS63vZ2rty03ZrQUrXUgK8OkzIVgncn9On9VTMqmaUIGGGokjGD6OVHfm9PfdT2lnryNar
	48XVCmmWstO/q+SroPMHCxAF4Yh5wvHm0oeg7CpSBKfHZJvUYw7YjS7jFAM8Zw2hOquSRITevO/
	l7ztFSF75KPyFCvNvzzx+Ps8Ej+Xqi77RhYRE5lQUuMcoskAbPietckpZIlMnrBS8z4kD9ZG1uJ
	5zTRa7QYK+i2TgaIZqrPdLZrlgMa1MblL4B7k4mng4OoW3PyV9Q4YcSreBvFFIHwtHSKV/18g2O
	Jq0JKxlf/GJN3QJ9SIyWDD+/klpwd2l8DToq6zCJDcMlKnsV9z6imYRJDbOoTAr8kEbs2+fwnI8
	w==
X-Received: by 2002:a05:6808:221d:b0:485:4441:721a with SMTP id 5614622812f47-4868df0305emr10961379b6e.36.1780956234026;
        Mon, 08 Jun 2026 15:03:54 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b91a9d2sm14484863b6e.12.2026.06.08.15.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:03:53 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:03:51 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] HID: iio: basic clean up for usage_id
Message-ID: <20260608170351.6f0fa693@linuxescape>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jun 2026 17:47:41 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> Hi all,
> 
> This series updates all HID IIO drivers to use 'u32' instead of
> bare 'unsigned' for the usage_id parameter.
> 
> This improves type clarity and ensures consistency with kernel
> coding style, as HID usage IDs are defined as 32-bit values.
> 
> No functional changes are introduced.
> 
> Testing:
>   - Compiled with W=1 for each patch in the series
> 
> ---
> Sanjay Chitroda (7):
>       iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
>       iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
>       iio: light: hid-sensor-als: use u32 instead of unsigned
>       iio: light: hid-sensor-prox: use u32 instead of unsigned
>       iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned
>       iio: orientation: hid-sensor-rotation: use u32 instead of unsigned
>       iio: pressure: hid-sensor-press: use u32 instead of unsigned
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c       | 6 +++---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 6 +++---
>  drivers/iio/light/hid-sensor-als.c            | 6 +++---
>  drivers/iio/light/hid-sensor-prox.c           | 4 ++--
>  drivers/iio/orientation/hid-sensor-incl-3d.c  | 6 +++---
>  drivers/iio/orientation/hid-sensor-rotation.c | 6 +++---
>  drivers/iio/pressure/hid-sensor-press.c       | 6 +++---
>  7 files changed, 20 insertions(+), 20 deletions(-)
> ---
> base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> change-id: 20260606-6-june-hid-iio-correct-usage-id-57ce92cb102b
> 
> Best regards,
> --  
> Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> 

This series:

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

-- 
best regards,
max
