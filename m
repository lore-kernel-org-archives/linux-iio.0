Return-Path: <SRS0=XRxs=YG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0632C4360C
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 21:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929FB20815
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 21:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Kctz53au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfJMVFY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Oct 2019 17:05:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40261 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbfJMVFY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Oct 2019 17:05:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id y39so12215737ota.7
        for <linux-iio@vger.kernel.org>; Sun, 13 Oct 2019 14:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwzFrHP8emHiD+TR5FVL2huynl9lJIVnYT139Y7jloQ=;
        b=Kctz53au86RZDn0JKJ5p12VVPCcvpPg4khZytnuu0DhF+GDeQyn7Uf3GRIns5eh6kn
         gxMqHIIcDqqdFh2I0WYnk+rx9GgWLjdnbjLT50A3f8ci6iL7D9b3gwG5n8hDOc2KiT//
         gsPq0IQ4HdNbVy4/1DyNGfdX++iQCxeM6GEv44+DFob1D1y6KrshGlPlXVlLqTeesS+9
         dJ8CdiYWt0NbEgqGHk1bzOxhjSsuRwlJM7YcQNsnpu9Q22aPbIisvnR6V3+II4K+OzNX
         StsQdaWamfxg2dSaCo8vdbM4ndP2iQbP7yABj2HyMeg2ImugtzTypFze4LQr8J42tPS/
         nFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwzFrHP8emHiD+TR5FVL2huynl9lJIVnYT139Y7jloQ=;
        b=YkxBi551bHE1etcy258ZhIPU9zXm7hl46k++rr3cad5lXNJBafspXLWl7WRVP1izYE
         OA+Kgae91Hn/WcKRwDxc1O1IWXA6qXoYoAFgVm8wUaiS50B4n8MKy2LfPdMnl1Fz1+cx
         Mtm9dfWSJkdFDA6wZ/mfOW3lUfCywiwq/fRrw5VtUSiZJWTJW95tvUEIqXmejfp3hlbV
         ult6bo64ZtErlVGQ7k6AXk+64TVrHIgok/vg3iqSlDHXUNHdMH6hoWGtsgNqTlcer3NY
         BLa4OSwcmWZLI80/k66lEdMcxe7F6VSjwtzL3SAvGtnUySk9FszIats0OX8E1+SgdDRK
         0Ukg==
X-Gm-Message-State: APjAAAWBTUYuIAKmc3gz12cBK8Kg7c6CjE6tttQYxAg43hOy8lznfMSS
        cAXn+XGsT691WC/bC2PghZh//lJ3dCg3SdZXYew=
X-Google-Smtp-Source: APXvYqzLTAz7dtGpws8cL3BuT6yXDOX3Wb+MwZ6HaluQMRWg0PWKPVyjiwj2H154nBr2DCdi0Bo0+HH1sf2me9Gb2bo=
X-Received: by 2002:a9d:5e1a:: with SMTP id d26mr6139890oti.96.1571000723468;
 Sun, 13 Oct 2019 14:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191013153759.1840761-1-jic23@kernel.org>
In-Reply-To: <20191013153759.1840761-1-jic23@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 13 Oct 2019 23:05:12 +0200
Message-ID: <CAFBinCDUQm6pSVgbWV8UEpBZW+zNjC2=7e0FxeHMo1b_33vTmw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson_saradc: use devm_platform_ioremap_resource
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 13, 2019 at 5:40 PM <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Avoid local boilerplate.
> Suggested by coccinelle via coccicheck.
> CHECK   drivers/iio/adc/meson_saradc.c
> drivers/iio/adc/meson_saradc.c:1218:1-5: WARNING: Use devm_platform_ioremap_resource for base
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for this cleanup!


Martin
