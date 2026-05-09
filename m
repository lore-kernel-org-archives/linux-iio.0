Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018A18DB37
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778331889; cv=pass; b=Qpfhq3OcmoDBUhJ/XGPvbb2VsvZ9JXinJxh7grDu052BCrU3wFW/ayGA1oi3+3Ldb9eyNf/EyPpE1xgFlpBk3GKGgtzSThqMxbR7smD0K1ijrfCEegmxIOsrE6h5EFQCfAm/GnsoFiPACO89HItNVP/hr8oIP+/nJvqtMc5vhxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778331889; c=relaxed/simple;
	bh=oAwLZinOTiC4bHFL/Y3RGk2gY6bX/MYFrRDcfRiQRb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSJBqgQO97MV1Hoz8Dm3p7eTmOnBC4CoLSqH7pEUMaCBsH2BKorT8rFBekStxgjlRFF7DMMX6jpp2q0HmGMtMckaPWBm3C0TYO6amvOL9Mb/eOLFVguSL4Y7Yq0/lnd/RU8glTPWavSOy/YMLHY+CGEYC1UvWmWGIctj1pMKeRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9eNjxd2; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9eNjxd2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so28469315e9.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 06:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778331886; cv=none;
        d=google.com; s=arc-20240605;
        b=dxQ1n0Yh+jPYvK28aA6hoHvrp/3UVTc8qZozvCSZq1TI/QubOw93F47wCEnkRfXHdo
         wT69KL8s4KJrmaPglLaVTiVs564u7f+8Fg4G6I2Op1t56xs15ycO6iAPkP/Igwk06F/7
         t8ohpnlz8n5ce+8gR+PAbfBYqxottrXa1Brb+BYkWB9xfhhTtfBxSXOoTu/qODb9kikK
         idvze17Jw84Lq6mVh2xL4evrmnY/c8qAa7I3AScZAHJ4gFI3FTWRiBmEhUL83iEvrGj3
         ZMDvWZnLztgDXGWCAvyK0rzJ+MPiyyWx2aDyx+Q/1v14YUXaWNR7wvdm+SVP1u8qVN7C
         vlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=asxX3RegTqh0Si28DGtUB6ImuCDOsYGCPYRlDBhdJyA=;
        fh=0iusdtI84c3r1Zgob2zzfbZ4+Iav68/yhoY6tpIk7UI=;
        b=bx3Mi0wRpFM+MG1w/nzDHqOPsNhCOjqWd8OcYfA3Q7SGU7eK4rS9KetJabOrvPm2k4
         v51tCx1y1UT0g5yAFulWGvqnz5kBTI2xS8Dn781Erm6h8UiVdq11x0Z4NliEmeAk2nEb
         7PjZehTLNa5l7HVudVlHvR+FXpITSHHvbh8BsIbEPzHJ7pM9kql2vaYDxUOctdrY0C4b
         6KiUZNSpd9Ya6L4Qu8xjJfCfOzs7+eOG2JaEOnkvyIr8NV1Kv82+/oRU1S5GjZk1o3pL
         OPE4meALuDsoNa8Dzu9qUKtT+RIq8upBg3Ty+pKcwtmoWFleOffjpYP+sqh2sa6sUK6F
         0i7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778331886; x=1778936686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=asxX3RegTqh0Si28DGtUB6ImuCDOsYGCPYRlDBhdJyA=;
        b=g9eNjxd2Aq042bvLar8hcGTC9q1jCaP33WiXqDq4/1+JLDEIrhJekkuSrdkbYojj/V
         xt9AVrPq6ekEaY47rGnrDwkH0iIO59JnsG3eA7B20qmTo0BOCRLY21YkQ0qPy86F6W+Q
         bSnkstQj/KiD06toRza4NFp5GeAJzYCis9WSOyncFjK2yU3JMHXl7rIhmtgqo1DzSAKn
         cuTOWdSOe2WlnTbjZ0cZxWBQet8qjX68Y4KfNy+hZufj429sDx7pb486ehZa5574xq5o
         ZHpc1yWk4tYh35orncu8n1DHVMQthyjrlEd6SUKAodVQesvIYf89igDv8UBqkI4gCkAl
         z0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778331886; x=1778936686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asxX3RegTqh0Si28DGtUB6ImuCDOsYGCPYRlDBhdJyA=;
        b=tZztd/Oc52rPZz8LU7LvQ4MYSeGEmNM9RxG37FATBsknaMNn8cUjhmiaXv2oSeNVvF
         2jndsK5MrbIiQJouvXUX95EhBoQ06LR91bJB9WRw5oG/BxiRFIEz9viJ6c6XOyVWYpyb
         RX/r+f8DL4jmZRCwwIlU1yeu+GJ+ax2sZmkB0nUSeuUKnnHDSZltH6am+Capf4jjmIlA
         FvZC9gqKEJuLLqXn+rDLgCXN92bGOd7mlgNnjQbbHSpRC+qi2EGiej9XH1PUaxQaB5oI
         iOsNc1ikSDFTDNTpRDFKQan/LyNS6e5Hf6Oq496U5Sfmew53ovQRmEwCz6G7q6Ml48wJ
         pfTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iOfuShDE220wiJL3n6ZFPIx6K++s92dySveVURXV0dZppT4AUJCln6YFM54VXoT7wUEhGvAzb2u0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2elTm2Xgzr7TsJMg9XmGHfMjk5i0HbZqUY+HYOkIjRmbpIaUe
	rSK/CS2cwDT4qyYpwmXsIQUQ7z9lkjg1bgN9CZYgM3rLEPCxZwcCbE9n00Gx34avF9bKykvaTR/
	d7SdXTsxkEiKdPagoSc1YMEN++yx4OT4=
X-Gm-Gg: Acq92OEOSOaaAfzDae9rNHipmIrQKDqlfDr8eOHyojWDFr9QtUYYvekILYd7cpLAcTh
	miQD3zMETZzygbQY+KxY64rjfPllp7cmgQDaCl9I3dxxU106YIjHWx/NXALIK/EdnxmAnYFNSuP
	d0kEno3SgT6VTWx1xfKsRxydZqB/zvpqQ2LyaSQoOe8DslUjLf4bkkiwl9nTBoT/gBkv6soe7Lx
	SMY1YXILvWg1JhAEuNYILdkXAmtyGROg29Y24HvalsgvhkhJUANfqGQs8wzLE8yCvS/c6GkrMW/
	3yKH9L4AqcBM15G+kCdXYBgCePa9OvY7aFWDsPLw5WGBGjDCYoAwV9WCzh53OoIRV6NgZ69Yja+
	Wp53cvVgd2hhaDqnGiDsqOxPpyBTmgQ9v7vekj+VLKSevCoUQHqww2zXzveDXFwEWNsYs609XQG
	fSAmIT4tLiFvwSqncGQBfiE7hWS20cekHRq7D3tw==
X-Received: by 2002:a05:600c:1d18:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-48e51f46e46mr261680615e9.20.1778331886058; Sat, 09 May 2026
 06:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509125201.29872-1-m32285159@gmail.com>
In-Reply-To: <20260509125201.29872-1-m32285159@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 9 May 2026 15:04:33 +0200
X-Gm-Features: AVHnY4JjCIkiVqSxelL8AjKDCcpEte1axrI3wzje_HPD-bVfSE1g9zkxTSC2HE0
Message-ID: <CALoEA-xo=0T43Nii5mNi+jwpXNgSf-3LVwO2Xy-0EMyQ227Zkg@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: sps30: Replace manual locking with RAII locking
To: Maxwell Doose <m32285159@gmail.com>
Cc: tduszyns@gmail.com, jic23@kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 May 2026 at 14:53, Maxwell Doose <m32285159@gmail.com> wrote:
>
> Replace manual mutex_lock() and mutex_unlock() calls with the much newer
> guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> modernize the driver, and to increase readability.
>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/chemical/sps30.c | 60 +++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index a934bf0298dd..186dec4cfd78 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
>   */
>
> +#include <linux/cleanup.h>
>  #include <linux/crc8.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> @@ -111,9 +112,9 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
>                 aligned_s64 ts;
>         } scan;
>
> -       mutex_lock(&state->lock);
> -       ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
> -       mutex_unlock(&state->lock);
> +       scoped_guard(mutex, &state->lock)
> +               ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
> +
>         if (ret)
>                 goto err;
>
> @@ -136,23 +137,23 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
>         case IIO_CHAN_INFO_PROCESSED:
>                 switch (chan->type) {
>                 case IIO_MASSCONCENTRATION:
> -                       mutex_lock(&state->lock);
> -                       /* read up to the number of bytes actually needed */
> -                       switch (chan->channel2) {
> -                       case IIO_MOD_PM1:
> -                               ret = sps30_do_meas(state, data, 1);
> -                               break;
> -                       case IIO_MOD_PM2P5:
> -                               ret = sps30_do_meas(state, data, 2);
> -                               break;
> -                       case IIO_MOD_PM4:
> -                               ret = sps30_do_meas(state, data, 3);
> -                               break;
> -                       case IIO_MOD_PM10:
> -                               ret = sps30_do_meas(state, data, 4);
> -                               break;
> +                       scoped_guard(mutex, &state->lock) {
> +                               /* read up to the number of bytes actually needed */
> +                               switch (chan->channel2) {
> +                               case IIO_MOD_PM1:
> +                                       ret = sps30_do_meas(state, data, 1);
> +                                       break;
> +                               case IIO_MOD_PM2P5:
> +                                       ret = sps30_do_meas(state, data, 2);
> +                                       break;
> +                               case IIO_MOD_PM4:
> +                                       ret = sps30_do_meas(state, data, 3);
> +                                       break;
> +                               case IIO_MOD_PM10:
> +                                       ret = sps30_do_meas(state, data, 4);
> +                                       break;
> +                               }
>                         }
> -                       mutex_unlock(&state->lock);
>                         if (ret)
>                                 return ret;
>
> @@ -197,9 +198,9 @@ static ssize_t start_cleaning_store(struct device *dev,
>         if (kstrtoint(buf, 0, &val) || val != 1)
>                 return -EINVAL;
>
> -       mutex_lock(&state->lock);
> -       ret = state->ops->clean_fan(state);
> -       mutex_unlock(&state->lock);
> +       scoped_guard(mutex, &state->lock)
> +               ret = state->ops->clean_fan(state);
> +
>         if (ret)
>                 return ret;
>
> @@ -215,9 +216,9 @@ static ssize_t cleaning_period_show(struct device *dev,
>         __be32 val;
>         int ret;
>
> -       mutex_lock(&state->lock);
> -       ret = state->ops->read_cleaning_period(state, &val);
> -       mutex_unlock(&state->lock);
> +       scoped_guard(mutex, &state->lock)
> +               ret = state->ops->read_cleaning_period(state, &val);
> +
>         if (ret)
>                 return ret;
>
> @@ -238,12 +239,11 @@ static ssize_t cleaning_period_store(struct device *dev, struct device_attribute
>             (val > SPS30_AUTO_CLEANING_PERIOD_MAX))
>                 return -EINVAL;
>
> -       mutex_lock(&state->lock);
> +       guard(mutex)(&state->lock);
> +
>         ret = state->ops->write_cleaning_period(state, cpu_to_be32(val));
> -       if (ret) {
> -               mutex_unlock(&state->lock);
> +       if (ret)
>                 return ret;
> -       }
>
>         msleep(20);
>
> @@ -256,8 +256,6 @@ static ssize_t cleaning_period_store(struct device *dev, struct device_attribute
>                 dev_warn(dev,
>                          "period changed but reads will return the old value\n");
>
> -       mutex_unlock(&state->lock);
> -
>         return len;
>  }
>
> --
> 2.54.0
>
>

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
