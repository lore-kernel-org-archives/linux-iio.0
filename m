Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AD37C900
	for <linux-iio@vger.kernel.org>; Thu,  1 Oct 2026 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838506; cv=none; b=Wp9TvGfWTMC4o9AiEo8/ZsohASCH2PiRS808z4MWqEwAC+akDeR5cSKIUDHV/3YciBjPZMsCyqmLoUSe9bI9uW3SV6JN33TObNmWojJp9Id3J3QnGr+9yNFMd+1FK2AOZ79jFVPboSG158PdkOKXzbt238om0DhPui16Oifh7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838506; c=relaxed/simple;
	bh=EGJJRokvBeMuto49N6+sTpxm8e0HrHHXkZH0oOqELDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d312KrYbIs+zFrqVovmt8lq2c5C3fWDSCqSSgdZgXfoywdFRj931oZyBqwv66E3XZke4jT8A9kFrA4xsQd6hvTpYpKa+xdu40MYKFwrfDqnDiShaFOKgnML6zFVdSkrEgj8zNsxPlkWoe3LWduRo8ORMC8q0DnlIo8f1mS/8ZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il8KRa9I; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il8KRa9I"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so46283255e9.1
        for <linux-iio@vger.kernel.org>; Thu, 01 Oct 2026 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790838503; x=1791443303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CQNdVgaRBZ+BMSEVZ852Rz0UPaYSaRNjBg4ZUiywQmg=;
        b=Il8KRa9IAjf/YZupc6QdYJope62runpJmnE5naiM6vHXyKVfwd2f8FiTKzzeAsTqg6
         w19GuAQ6Vf/lpKtlWyreIyTGs3+n7Kl15hV08nG9LZ66IlUzoRZcB6ME0keaqNaMPBEx
         kmls7cHBjHTRUDWAn8LyVEQOLLZ+PB/3aVLeB5Yw0E1BUZGje9sqVHcYIgpHmxjsghyb
         Qe6HtvQ/S7BcxBLuZbfffkoVHX63P1/7zmbQwEIr9ifNqPWpRr4EVUzldh7xLym/VTOA
         ouG6fNlLMea641z2MwRis94hLYiT9tKSxTEQaI0QdjaLW6dSHoHU9rAco+Rp4znLOP6E
         gn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790838503; x=1791443303;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQNdVgaRBZ+BMSEVZ852Rz0UPaYSaRNjBg4ZUiywQmg=;
        b=eURXM4KKLFwfMszvQVfI8qzYZcH8peH+8uQv5weS3evHDW683chLJvu7z8BXiP4p6Y
         gnWHB04cS0J2hxUX77mEUEN/nsoxT7brnNHke2igM+NSMVJ6GwJV+oYpAwHR2kJ/59ep
         rtQKUwyg68FqyF6piMlvSTDZndW53qGxasNCmtSor9kwf3+ZiXKfAasZJIfwKwAuybSY
         wGIn8/DDJFnOeC3VB+hKl1x41zqN3oAdzwVdfOCJsVLj0r2bBIKr4NHALwpZ23X2rYFJ
         SCSgBPcJaG3zm9xZicJITYb2pvsGcslcwxraPzaHtaf9b55YQGINLH2wjxnmsNDeqR1m
         FrLg==
X-Forwarded-Encrypted: i=1; AKwUvByTEn8ntOkvRGZDoOtIK4bF6Ydxf91Nca9n8QfX4nz8mwhoBFvcFXm4wGivnOUT3VsE+ttlkh3ouFk=@vger.kernel.org
X-Gm-Message-State: AFuF++lnoh1qi9sRJlo1wQ+cxU9d3fJe6KbHEvCE74i8hX+v0TIBDo4K
	5LYG1B7HCGrxzte33O5oFlnLRq9SZiFru1tfCuBQ4o1VNra463otAU5s
X-Gm-Gg: AYBFou1myhdyZLUahWBGqfHhnw0AoJW7Z4+9XZVd/0k/1+3p5jF0XlypSO55yBjl5uB
	7U05x418Tnai2xz8bbhaIsi/P6VidtP9uwmwXKw5h9pKEh9i/geJ2Ocda9XLPoC6YR3AfJ5OCRB
	1GirqN7i6GNCo0H7oCbnOfF6GGGiO9ptuCc3L2X9fA3Q4wbSkoXyWNkqgSOYNITR9KilWXnOf+l
	yAolaITsDX7GwQ/OGyKo5A1dAQmr27nMjSH6TGufxyJJxEVFJKU/0NDj7s4yTlJ4hPdCy0WVDlV
	N8pgxCK+YfUaKtgfzkbKTZMkDfV4LV5KBh9Hsuc01SFNPliHpucSjrW/jbTZGZ75s3RxVMntzLZ
	LlxvyxgABaF3qURn6GeLFOyOptMg+hGxucx8WOwbo46VhECJvbo6h4wnZ3P3PMC81tH01ARqd2S
	UMV6riaBKsVKouAUqrDIkPjPZJoDLRxRkv6hNMp5ufZevyPqv3TciskT0LPWGwl9gr/XzAyftHP
	GA3vBpnkr7VLUVHEO8fMvnSbdIZNhizfJUdcRkKMaeEPmYWZPiLDbT3Bc2TPOGBYYH3S1/DrDdy
	R6G6b+yx+tB62aaBaH5/1+ukD6zNbpUGQf7Bml3/K1rT9zgSoCc8NJNjfhDlWoVD2n98VcX4/nQ
	yrnSJ5zke5UWrOf+eQa5vALewuPcGJhyDUWPRv5yZNxUwzPwtT+0Y0cycEHRyVYEKWeYhw2lFaL
	gaczkI
X-Received: by 2002:a05:600c:4691:b0:49e:799a:8951 with SMTP id 5b1f17b1804b1-4a01aff4450mr54837075e9.11.1790838503244;
        Thu, 01 Oct 2026 00:08:23 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f98224csm39045465e9.3.2026.10.01.00.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:08:23 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:08:24 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
 nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/10] iio: adc: ti-ads1015: sort headers
 alphabetically
Message-ID: <20261001090824.00002477@gmail.com>
In-Reply-To: <20260930171204.12863-3-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
	<20260930171204.12863-3-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 22:41:56 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Reorder include headers alphabetically to comply with the preferred
> coding style and improve maintainability.
> 
> No functional changes.
> 
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 93a165c5416a..ef03b74bda3e 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -11,24 +11,24 @@
>   *	* 0x4B - ADDR connected to SCL
>   */
>  
> -#include <linux/module.h>
>  #include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
> -#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/mutex.h>
> -#include <linux/delay.h>
>  
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/types.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/iio/events.h>
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/types.h>

Small nit, but I'd drop iio/types.h as it is included by iio/iio.h
(No need to send a new version though, this can be addressed in the
future).

>  #define ADS1015_DRV_NAME "ads1015"
>  



-- 
Kind regards,
Joshua Crofts
