Return-Path: <SRS0=LZIF=B6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11854C433E1
	for <linux-iio@archiver.kernel.org>; Thu, 20 Aug 2020 09:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8EE42078B
	for <linux-iio@archiver.kernel.org>; Thu, 20 Aug 2020 09:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG5DtB5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgHTJJ4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgHTJJx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2020 05:09:53 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A2C061757;
        Thu, 20 Aug 2020 02:09:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t7so915211otp.0;
        Thu, 20 Aug 2020 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjr2E15Ms5YFsENJJqQ70oL/KScY+TpK+MfdOTOoPY4=;
        b=mG5DtB5VoZ69zbFyObb+lBGIOAtPQJfVdBuxVsWh0TD8yc+lbXZWMmDz+xb7CKtePN
         rbxBMwydUHGAO6Sx5kQpsWYue/HVrNRDOiy/+F5OlL0VjH7MurSFZOTantPl6et68bqz
         R22Y/StsrlhU4P5t2osilRnGzyb6S09DzGvad55/vwiym2gPvbgXNaKAAAJYDQl4e/Ea
         /hCtpZlJ4MrQX5/WP4rOx3szsPxQW/kyUqq1AIvq8H61F0xj0xek8XKFWclR85YKqhWI
         wsjyyum2VdSKcWP2oi+5lGe/1ysGKerP77iMGwiMC1BxXyswAwR2/cP5JKRtGj1rnsjr
         NVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjr2E15Ms5YFsENJJqQ70oL/KScY+TpK+MfdOTOoPY4=;
        b=oRDM8VNycjEf3E+qXpYBF367DBLF5EajBN4AHoGoVapVFddgDULsMeak2naoTB9svX
         y8yS4gNr/y75ShlWI6p0CNfr3UGcZvqEdYaNV74n1/QhZhzO0pm8et39TjG/pg8Qu5Xr
         Ul7vInZKv5UNiTImpgQDJ3i2LGdNy/KvNTm0wXU4QrN3nC4bO6tSofr7tfe/XLBG09O/
         AXCbgLjfTinRA69zSQck3mDhGOuvQnKcMR5O9mdLLUq5dUC4qGsqgdQafFQuZUO8oLof
         ajr9Rg9jt1SL27wldJ/UfB4tT1Kj6Bxu7CdBoMXFJbO4iy1uOLHoo01RWIu84IhYOyMO
         vj7A==
X-Gm-Message-State: AOAM532oKRt6EQTCIVbddHwmypFP4Zfp5WOAoK9ITwse+aVUYREugctR
        zcM5PDWT5mplsRscBFP4OtIl2zTzZHLnG153WzY=
X-Google-Smtp-Source: ABdhPJxs5IoenfJLEhfaPN0fAgjlHWlLXxlo+BkbEClLHyiEZ2o1bCAb+9ZD338qsiirU+cB3anppLOrO8E6DQz1KGM=
X-Received: by 2002:a9d:f2a:: with SMTP id 39mr1511600ott.119.1597914593196;
 Thu, 20 Aug 2020 02:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <1597892486-3236-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1597892486-3236-1-git-send-email-tiantao6@hisilicon.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 20 Aug 2020 12:09:42 +0300
Message-ID: <CA+U=DsojNXFxT812=i-0ceRGUV3gJXhMMb-ungP=DO166jjZMA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: Use kobj_to_dev() instead of container_of()
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 20, 2020 at 6:04 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Use kobj_to_dev() instead of container_of()
>

Good point.

Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/iio/adc/adi-axi-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 86b6b65..9109da2 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -276,7 +276,7 @@ static struct attribute *adi_axi_adc_attributes[] = {
>  static umode_t axi_adc_attr_is_visible(struct kobject *kobj,
>                                        struct attribute *attr, int n)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>         struct adi_axi_adc_state *st = iio_priv(indio_dev);
>         struct adi_axi_adc_conv *conv = &st->client->conv;
> --
> 2.7.4
>
