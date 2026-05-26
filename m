Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522773DD855
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791535; cv=pass; b=ZcRuW99RniH5lYaJa9yIwQ76JNaWII80frgNivGW8XoJk8CZYaAb748RglhLqIS05P3Ms1Yt5cAuQXXaJd1EaP42yA4HOxc2/U3oksKTKi0MDNbomyi8R2aEHmBQrh6P+u7yqYZ+rj+Au87kQiqzOHwaUOzGRWwP6Td4x1NlFbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791535; c=relaxed/simple;
	bh=+roR8mADp3Fu3TnQdhRbr7fYAtHH7XKBF+tCmPVSbvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5ZmgmX1goD/pXWXMJHtnP+TAC1kGrqDotNMcsmARZJNHBYiOrnaY3QIJ09SWP/EHBn/6E9ldta5EDAvGnPxNGlBlkpS8KeCsUXlVnBVcaQfTVubNvjCDFqmf74UOmpmyRypYcUFmLJdZ6SKCwkPLrakEIlWs0FETC4VCuB1MXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIJmWE4e; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIJmWE4e"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so7476693f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 03:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779791532; cv=none;
        d=google.com; s=arc-20240605;
        b=kJyCba67cUF/yAeNm/hRJKQYpsN8lipIcdgzrT2LCb4TfAlra/05diV6c87tL+4nRr
         tIxbX2eAa8eDUj9FMPe32mCwruyCjYlSE0c+ldajWABVpIMrzrBKG/vK5+NLjKEr21tY
         7JUSYxW5S1h3BzXkoznrmEfbdX38uwwa3uE+I/Jc9jLkKxnGy2t/mHC3n3QsHzsCecDH
         vRl9zOIvzhhX8R/fNM5QyHSfE7Qlg5vyZ+4gZ2at0LxRZImAcDhki5vntVJj0wLWfg73
         270+LigQ8EHYvkuw4G2u6yNxdDvNDW37akyP1SS9wK8gwFQdePUDW5bQ3UNDU5awZxPO
         9wFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W/GZITlOOI+RYJgZPFoGbe3SNJiwyBETTTUeZXLCRW4=;
        fh=UD0q7ZHoDyLlgiVTl9r7FhJIvyv9l+IQuInVPYrKpKk=;
        b=OjaQw9Vk3X6ZWmUpZxO2nZo2WK8cNDF86XfiGB8nBG1JzTKC6CIZhppYjDNQmVDOo8
         kZQoy+PQrqTNL6YgC5iqMzFEXUFHp2D3Y17x4WMJfX0QOzam9rSboMVsHR/kwYKZM1HU
         fUvdKQYGKRvZd+HgFuGbT0rZXGn/NnSv8fpZ9dNw4Vs+PXkNt6gjNrgaVhb/b4+2xaA8
         GbYgWne453Pw8afbPFdYVUvbY8sQtx2RbbhLig5U92E784hRWehrOgY0KrjpG3rRxQ6Y
         86szwtcX1uUm7DAVYkKaH7dj7Ucs7fjDVyerm8CAQwwLC1ypf5RcRwElmf1vCayybjA/
         oGGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791532; x=1780396332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/GZITlOOI+RYJgZPFoGbe3SNJiwyBETTTUeZXLCRW4=;
        b=BIJmWE4e2rADX5x9sKmcFrFPOi2EZJ7Tp/5o0kNJTDNBTVjOc5tqJxNzZcHEEb/q8c
         cU0wexj1E8uvRhPQYo4X8SfF8h55bl9TeELLYv13pBsyZJQEWmWXLGdZRuyWZW3/GT5p
         SP5WTizDPokuyvMGJ6xVtSUA894r6GRj3SUe4KbV0VJmx2XAjsIQ41M0J/8mR90bodU/
         xWCU3q4QS33z8aiJ7fZGGzZwAOfzPfg3iMVWl8mKD+FqEKdBs8oRsE1dL759oni31zRO
         T5H9s3IU7fuyYWyxYamYJh/0h7IyOsqpokR+p2lT8g9xHixZON1DguXmiP1RBBQI2F8p
         /Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791532; x=1780396332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/GZITlOOI+RYJgZPFoGbe3SNJiwyBETTTUeZXLCRW4=;
        b=RW+SYeQnKtjPe8IuMbb/fFVjrpbLApRA7IxjcVCSZrv3iaXfY26UFvGw6VtQwDe/6v
         zxvAA4ZxsSjGcX4s/8+TZUOR3dtMb9PsHwO+8P4C3vFBWa/CrlvLtPUAUXGCquj/CgVV
         uKXNQgpnjzPyqQgNLNIiE9LSEcyD38VDNe1nDuIGbuPeS+eC+U+xCq0r4EYCrSxg5XrH
         jqsf5RDlhqGAXgOd4esVcGMIBmrdj6biFSQD4VSyWnjiV/PZ6GqQ/HdDAfzkpsHiYal7
         Wr+64lsaUTlPya9mqTtPiOPF5F5WSxMKlv8OkXo/e6/WMstcs3pW4vlih3fshEK5X07n
         sbJg==
X-Forwarded-Encrypted: i=1; AFNElJ+Eu8rCWGz43n9FtzhJ9bSX5jFIPU6tMNWmWTvO96yvEItLJvqWGa1xqOqwJaPfg29WxNmnwJho1KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERRztCY2T658oUmsoHWkzHW4NxBa1y8Mn6zdjGBkAHRMKZlnv
	729OhHKBT9CkclXcE0og6k3r+jdOrHPbykBt002TnmWnua4RmWruvAmcLSDpiKybnAJVq45EaJh
	nX9hsSyigLHjdIlFRoYC7+Oly3wZyzI0=
X-Gm-Gg: Acq92OGqlFp6Geil6PRAm+7lcbB6zk+dmXBsP1W6pdXiVjO0nroZo2mDeK83UgWiWr2
	rTyYRtNR5AxbY8Yzwjc5OcpAUHPncY3uRRvYXZO6gbMEc3FPQXDu37wZmUrt1U+V3cZ7qDrPQ6k
	mCNIFfg60jNA94A4ru1lC1q7GVP6YMEYEmyAjNkOZIvWkYFrpM44wextqaAQ0co2xRty0DFU5Va
	mCgimUFMvYzGFhyTzoqVZocp9rAs9e67OqYZ9BfbBI12aXpIQODWq/CgGcelbD6AncNU+5Z2RPV
	AJAr3O09sL+GFkP5MmEEojKP2HI/9ooM/VEzoa2a8Ik6yO6bU13/9G71cz6SYCUTse75SZlba1v
	l32Vy4fSEgx0XTZnXXVVzf1Qf8W9YGdB/np4xtKz4htiKpSbsjC2cqjD5Ia/L6BT7QBvVNt1e0r
	mt6fzFTA==
X-Received: by 2002:a05:6000:29d4:b0:45e:8b03:e26c with SMTP id
 ffacd0b85a97d-45ea312913cmr24483415f8f.5.1779791531503; Tue, 26 May 2026
 03:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525152137.7428-1-sozdayvek@gmail.com>
In-Reply-To: <20260525152137.7428-1-sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 26 May 2026 12:32:00 +0200
X-Gm-Features: AVHnY4KlHlc7DFm-MOUGFrDcVGBNlcUxLVNLS_DRcv4OBRHP0vvAKh5pHPi0gc8
Message-ID: <CALoEA-z=qZf_ZLj6Qrgpvnq6TEUGNd0yj5Z=8YYqUwShY75CSA@mail.gmail.com>
Subject: Re: [PATCH v2] counter: ti-eqep: balance pm_runtime on
 devm_clk_get_enabled() failure
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: wbg@kernel.org, m32285159@gmail.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 May 2026 at 17:21, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> ti_eqep_probe() calls pm_runtime_enable() and pm_runtime_get_sync()
> before devm_clk_get_enabled(). If the clk call fails, the function
> returns directly via dev_err_probe(), leaving runtime PM enabled
> and the usage counter incremented.
>
> Route the clk error through the same err_pm cleanup as counter_add()
> so the runtime PM state is unwound on every failure path.
>
> Fixes: f213729f6796 ("counter: new TI eQEP driver")
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
> v2:
> - Collapse the dev_err_probe()+assignment pair into a single line
>   using its return value (Maxwell)
> - Add Fixes tag
>
> v1: https://lore.kernel.org/all/20260523184448.7609-1-sozdayvek@gmail.com/
>
>  drivers/counter/ti-eqep.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index d21c157e5..4f3b17939 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -548,17 +548,21 @@ static int ti_eqep_probe(struct platform_device *pdev)
>         pm_runtime_get_sync(dev);
>
>         clk = devm_clk_get_enabled(dev, NULL);
> -       if (IS_ERR(clk))
> -               return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
> +       if (IS_ERR(clk)) {
> +               err = dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
> +               goto err_pm;
> +       }
>
>         err = counter_add(counter);
> -       if (err < 0) {
> -               pm_runtime_put_sync(dev);
> -               pm_runtime_disable(dev);
> -               return err;
> -       }
> +       if (err < 0)
> +               goto err_pm;
>
>         return 0;
> +
> +err_pm:
> +       pm_runtime_put_sync(dev);
> +       pm_runtime_disable(dev);
> +       return err;
>  }
>
>  static void ti_eqep_remove(struct platform_device *pdev)
> --
> 2.43.0
>

Sashiko came back with some notes, however they are issues unrelated
to this patch. LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
