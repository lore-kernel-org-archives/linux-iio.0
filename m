Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378F3822A8
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672390; cv=none; b=YxChLg4BXxY8l1pHtpCqjKh4ZOA27Z6FvCJOZy+pWBpuvWS2ai7soXZdks32TIQwOajBDTjYbvjgQUx53+noSeW4Pb8SPcQTP3VbFiAlsjOBEzKieUeqPLuXt11FIzxucvofdHIyUcrMZhmVqZUpITO/UM8YMjPxBS/BVm0EyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672390; c=relaxed/simple;
	bh=KLhc8MHd8tL/SDyjk15u4oHHHuvXYcZ3C+ThQ3+0iN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+AUO2Mjs7nsWaXK6RaflTM8ilXjnXg0XsHjW4SFN8JfiHL6dcGpytM+OAy6ZT0W5VCMvsy4ch4Npa3dphCwYJplYLyaOXJirXsuHMywDe3+PXL1b2UJhKVAwpG49nTOtvZcNEdZagxj+uEuT6Pyt227r+uQSFk2YklzSBgTscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-95697b46831so1694203241.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 01:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776672388; x=1777277188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swS+z/M+higPeDEQGwZrHmQKmmCSiMojyvHgCRclIkM=;
        b=i7aY+8T2aHfG3h8cH44a5kEVsCtqB3GmF8sVutfA4bOfsJZz4gaiFT7AtU3Ae9JNgA
         QkCOLFIbIFP1r7FKcTIF7c+ydBXywQqsG4bDeEES7NwgTbtdYi0uojcR6Mc5KqwkZaJK
         lhiuIoK3984oxoGNRRNwPEh90HNHelqdaw3KBbsR6Qbx0lpiUUR4jjihYhKHa7MoP937
         ierjOSE0zA2I9ubw3Ja5hip1+QrSnpHmbT56oUOfyTyAF1zcrFGvFSm4TRQEtA59MVvD
         JnmXC12gWWzTTDE+iDrDGZruao6l+oYzvD1cDBXdSb5P/hyNJx8ubrs/CasGcpHHBAz6
         GpUA==
X-Forwarded-Encrypted: i=1; AFNElJ9KdHa5vbTe7NMiW+EMqqzu6Z1vA/9LYg3OxUYRGxX8aE6J3QkXLzbR/gOZMcjmqHgkmFhUPXxJCwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTY9AKjjyujnwjBh/CxrfzI33dTwcP4bfq4nuwUf8etmO1mX8J
	lrh+B9LxHFUv+zT/EhyXRTD6uQMmz5u+2Nyf7tlc4cYKmRqWNFPfhQpkfI9Rs5F9
X-Gm-Gg: AeBDievuSdohyf0O7An0Osze3Zocr2r+bMS5t/s2NhiY1Gd5xXwT2BWwLLyBgUqICsy
	bKjR2mPTDR9NDIwQNl0kuEcEOYpEG2wX4Ni5utqUA1TW38Pm1akD08ivclnoCQuMR98oW5BZQXd
	h+HjbtYg/QKCiyiuhoEMDVP8T0PEJqh/OzpRpE+MBQsDrbCNRo7eNpNnvO02S99yu//QaDQKoQK
	jUYaxKbMvohWQPFifsYQjJRA6WoadBwU8UH5o8SuAZQL7xIJj8K/XVHrrU+qckUZN/eYYTA+TNx
	Y7F9Dq85EUD4c+9swLUt9fQcbjop9dSvNnRUFlfet5oUPDo9kwf1q5Xs7e6Aw6Fj0bgP8PShXXh
	55AXYOCqpt9rOAlWeW8JoOVwSonfWpu7HAg5jIrxQOY7w4JZGVS1WaO2GEkjOvLUu+hLZSbMi6A
	mUD30xKZI2+LTrSoAuCfIEkqP2U3FC+afFx1V9AH/49kIAA5g7Crmi/1C5PH94sKsczTl3V63/0
	BFedzr0dmlp5g==
X-Received: by 2002:a05:6102:160d:b0:5fe:af0c:79f5 with SMTP id ada2fe7eead31-616f4538251mr5728554137.5.1776672388395;
        Mon, 20 Apr 2026 01:06:28 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95890bcbbc7sm4294532241.9.2026.04.20.01.06.27
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 01:06:27 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56739adfa1aso2094730e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 01:06:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8wdcYNbkaeo5Idsiq4CIFD/UBFLKBSXwpfWDiv6qExfzCcZt/vzQg98VqxDsVkgqhgOSCXOUdpFUg=@vger.kernel.org
X-Received: by 2002:a05:6122:4b82:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-56fa5a232c6mr5348565e0c.12.1776672386884; Mon, 20 Apr 2026
 01:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414192045.3598010-1-sanjayembedded@gmail.com>
In-Reply-To: <20260414192045.3598010-1-sanjayembedded@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2026 10:06:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCYxrCoi7zdUfmbgxXwdwiSKB3YczG-odUQLgvUJ9HQA@mail.gmail.com>
X-Gm-Features: AQROBzDLtPnWNAl-Z8Hnu1eLF7JeWxlb0Ot639dfJ05nzskER9DymDPClItnw_o
Message-ID: <CAMuHMdXCYxrCoi7zdUfmbgxXwdwiSKB3YczG-odUQLgvUJ9HQA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: mma8452: use pm_ptr() for dev_pm_ops
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sanjay,

On Tue, 14 Apr 2026 at 21:20, Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Use pm_ptr() so the PM ops pointer is automatically set to
> NULL when CONFIG_PM is disabled. This avoids unused-function warnings
> and follows modern kernel power-management conventions.
>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Thanks for your patch!

> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1744,7 +1744,6 @@ static void mma8452_remove(struct i2c_client *client)
>         regulator_disable(data->vdd_reg);
>  }
>
> -#ifdef CONFIG_PM
>  static int mma8452_runtime_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -1812,7 +1811,6 @@ static int mma8452_runtime_resume(struct device *dev)
>
>         return ret;
>  }
> -#endif
>
>  static const struct dev_pm_ops mma8452_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)

You are still getting defined but not used warnings, as reported by
the kernel test robot, due to the use of SET_SYSTEM_SLEEP_PM_OPS()
and SET_RUNTIME_PM_OPS().  Please define the structure using
DEFINE_RUNTIME_DEV_PM_OPS() to fix this.

> @@ -1835,7 +1833,7 @@ static struct i2c_driver mma8452_driver = {
>         .driver = {
>                 .name   = "mma8452",
>                 .of_match_table = mma8452_dt_ids,
> -               .pm     = &mma8452_pm_ops,
> +               .pm     = pm_ptr(&mma8452_pm_ops),
>         },
>         .probe = mma8452_probe,
>         .remove = mma8452_remove,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
