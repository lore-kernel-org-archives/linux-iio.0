Return-Path: <SRS0=zyAD=Q5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F59C43381
	for <linux-iio@archiver.kernel.org>; Fri, 22 Feb 2019 11:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6224720700
	for <linux-iio@archiver.kernel.org>; Fri, 22 Feb 2019 11:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tG9lMKBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfBVL61 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:58:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42889 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVL60 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Feb 2019 06:58:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id i5so1608210oto.9
        for <linux-iio@vger.kernel.org>; Fri, 22 Feb 2019 03:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30sAx+D+gGIcqJCGQ00bISfpIFDoV0prM3vsGhaLGTc=;
        b=tG9lMKBWRdWXTNg6PnzL4ojNx2dbQy2Q5JAJfGBTnAGOk5E6G2ymLialBVAIUms+fd
         lIDXNHAtUrrNzuLHiyEcYqv6dT0hP7LKJPfJs4ygaFY3vbt6JyRXHksc4LajJ2Hg4xAD
         4HKkowqHB8Qr+QZTImCYqyCXP390H78+oyvgXoQNlGil3smGEXhwjXhZD7fqCWo+0qrp
         GmMowVE2onOT3bl2bU4TWVLBhbq9KCdFWen7LSkpCoFe1WPC6sGEbp2tBy1wTQqO3K4m
         RuslBvHpIdpNOq/Wnuu7IdBrTDi99uvi3eoE/43HsE2eippSaC1zrllNwd8jeaZ/kEYY
         U/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30sAx+D+gGIcqJCGQ00bISfpIFDoV0prM3vsGhaLGTc=;
        b=FxsYi1Zsx+mfP7Hsw09YB7kGQi8seoghiYyVLVbrYDSTnX27OsxAvGg7MZdAE8dHtL
         qNe2/hsJLtko30xmeBRV3j0i8CoDe5m2Kw4fL1Kx8Uppp1YpH6VlCXhVHOiJ3sPXrA4/
         c/xS067yFEz1cmKnCGlSTOSd+ItX1JY2CF/QmZED70Cw/plImeEhcw40yjPAWlTSajly
         sdvmiBX80/FM8wjlq2KSj8pNDAPbRopoBCgtAOickwqA1fkoeQxwDFwSMKRMXmYwX0HB
         KZ/NF7ZK/9pOyvc7ZyzMeKKlQt21BE4fEMTNpm7N+GphH0v5DaH/tZrABnuvliH1CVLv
         m1tQ==
X-Gm-Message-State: AHQUAuZeXdzEQhPOytx3NF1FzVJCtuCvXLCuDF1TGad0jbjwAGVeD/py
        gH3+CMpx+qF7F0e27iOVAyhXAjYbQpiOeQMgGnY=
X-Google-Smtp-Source: AHgI3IYy31O0RiYxqEw55f2u/kEg+WTQTFtmY6LtwU36EBWcV4J5T3wyipJF/VtaJOHCvxuSAfeGGs6eXUId3HdLJX0=
X-Received: by 2002:a9d:7608:: with SMTP id k8mr2209292otl.157.1550836705874;
 Fri, 22 Feb 2019 03:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20190220182344.19236-1-jic23@kernel.org>
In-Reply-To: <20190220182344.19236-1-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 22 Feb 2019 13:58:13 +0200
Message-ID: <CA+U=Dsr2Yiu60fOvcR18EePM22Z1N-d_W6RXHf2QvxvTj-hpGw@mail.gmail.com>
Subject: Re: [PATCH] iio:dac:ad5064 mlock cleanup - move to a local lock.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        alexandru.ardelean@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 20, 2019 at 8:24 PM <jic23@kernel.org> wrote:
>

Hey,

One comment inline.

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> indio_dev->mlock is intended to protect state transitions in
> the core. It's scope is tightly defined. For device specific
> uses such as those made here, we should define a local lock
> allowing the scope of the lock to be defined near to what it
> is protecting.
>
> These mlock changes can be non obvious, but given we don't do
> anything other than direct for DACs, these ones are easy to do.
>
> If anyone wants to help with this particular effort it would
> be most welcome!
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/dac/ad5064.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index 2f98cb2a3b96..6c3ba143839b 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -112,6 +112,8 @@ struct ad5064_state {
>         bool                            use_internal_vref;
>
>         ad5064_write_func               write;
> +       /* Lock used to maintain consistency between cached and dev state */
> +       struct mutex lock;
>
>         /*
>          * DMA (thus cache coherency maintenance) requires the
> @@ -248,11 +250,11 @@ static int ad5064_set_powerdown_mode(struct iio_dev *indio_dev,
>         struct ad5064_state *st = iio_priv(indio_dev);
>         int ret;
>
> -       mutex_lock(&indio_dev->mlock);
> +       mutex_lock(&st->lock);
>         st->pwr_down_mode[chan->channel] = mode + 1;
>
>         ret = ad5064_sync_powerdown_mode(st, chan);
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&st->lock);
>
>         return ret;
>  }
> @@ -291,11 +293,11 @@ static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
>         if (ret)
>                 return ret;
>
> -       mutex_lock(&indio_dev->mlock);
> +       mutex_lock(&st->lock);
>         st->pwr_down[chan->channel] = pwr_down;
>
>         ret = ad5064_sync_powerdown_mode(st, chan);
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&st->lock);
>         return ret ? ret : len;
>  }
>
> @@ -349,12 +351,12 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
>                 if (val >= (1 << chan->scan_type.realbits) || val < 0)
>                         return -EINVAL;
>
> -               mutex_lock(&indio_dev->mlock);
> +               mutex_lock(&st->lock);
>                 ret = ad5064_write(st, AD5064_CMD_WRITE_INPUT_N_UPDATE_N,
>                                 chan->address, val, chan->scan_type.shift);
>                 if (ret == 0)
>                         st->dac_cache[chan->channel] = val;
> -               mutex_unlock(&indio_dev->mlock);
> +               mutex_unlock(&st->lock);
>                 break;
>         default:
>                 ret = -EINVAL;
> @@ -856,6 +858,7 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
>                 return  -ENOMEM;
>
>         st = iio_priv(indio_dev);
> +       mutex_init(&st->lock);

An equivalent `mutex_destroy()` call would be a good idea in ad5064_remove()

>         dev_set_drvdata(dev, indio_dev);
>
>         st->chip_info = &ad5064_chip_info_tbl[type];
> --
> 2.20.1
>
