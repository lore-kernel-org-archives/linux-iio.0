Return-Path: <SRS0=LZIF=B6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838DEC433E1
	for <linux-iio@archiver.kernel.org>; Thu, 20 Aug 2020 13:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D90B207DA
	for <linux-iio@archiver.kernel.org>; Thu, 20 Aug 2020 13:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeUdFykn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgHTNGG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbgHTNGB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2020 09:06:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59459C061385;
        Thu, 20 Aug 2020 06:06:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g15so1008628plj.6;
        Thu, 20 Aug 2020 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diWOF1th57LrHj7EG5tnoK7CBPOeUfDwxvRZ4lqQiP0=;
        b=DeUdFyknlpSmv5kkr6H1ATJsndaWr8MvMFne3KWTmGJG2YERGgiOrFBxV8km9lA2JU
         Oa6V7i+KP6qIv/FWA1Np283lXNOL3vRdGSIfwsFfjMhZKMY0/wcj28w6WCZAlYqMricd
         Be3+/O982WCiUXb4tsZAS9OEr/KdI9lmibNYy3XMw9HIowe2Rcv/4LpCoaBXo9dP8yXh
         CRznHv/OOUqYi5+iTNJzawAu6SO/kUXt4h3YBtZjIChyxiaFt77BG+zh/9lOdN6NSMog
         sVhkkOprbhTKlcnllopmB/AHS/eMfTPZmxPZ3XGQs2b2kqpFwjs1pyjTdZrCAtPc062G
         wvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diWOF1th57LrHj7EG5tnoK7CBPOeUfDwxvRZ4lqQiP0=;
        b=e//lRh9AMYuQTZVwCmflB4EyxTOOHT/7Onqa91elCj610CNrtA3bod7IeRBtwSDEGF
         sHNq9qpd4SLqvsfppmieYjXA8Db2tVoKnD3r7OyODmFLU6QqMcbuxorlMiUCQ4L7rIFH
         bHfGQ/56RrDfVAemhXD+iDNFvL+WJprfrYXIOeZfydVzrBPZt0fpREqsfoSjxHpmFms0
         9w6Cci7qAQ51+QvuFXFTErR85EO8XupODV7Pk+5Q2hoqeZWyX3sD7ZboeyRUfXjzMQnG
         M+gnQxmAfmkL8lG4iRKyj/sUOZVOHQb1VZbKyX4vs9T9ZeWyxYBtUR0ErPzCiBRMAi1u
         87/A==
X-Gm-Message-State: AOAM533griJg3l0fI7SoYTGrwcsvbhPzBQp6HZK/av8Huz8A/nCUgS+l
        Z83WmxuqKqZHM1ifYxkQFVuijs31fV5ktcDoTNg=
X-Google-Smtp-Source: ABdhPJxA7srVMSku0uu1P5zHAAAti2hEfo+ytXQ/cTrfBTaGNEDKCsEeSr7WtE6tLnyFBWb9/IWKQ2RbXaPhzu0Togo=
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr2333932pjv.181.1597928760579;
 Thu, 20 Aug 2020 06:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <1597892486-3236-1-git-send-email-tiantao6@hisilicon.com> <CA+U=DsojNXFxT812=i-0ceRGUV3gJXhMMb-ungP=DO166jjZMA@mail.gmail.com>
In-Reply-To: <CA+U=DsojNXFxT812=i-0ceRGUV3gJXhMMb-ungP=DO166jjZMA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Aug 2020 16:05:44 +0300
Message-ID: <CAHp75VdqrczNjsgR7JZTsK8+=RmgFopGJ1VZdD4+BYxBHMHukg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: Use kobj_to_dev() instead of container_of()
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
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

On Thu, Aug 20, 2020 at 12:10 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
> On Thu, Aug 20, 2020 at 6:04 AM Tian Tao <tiantao6@hisilicon.com> wrote:
> >
> > Use kobj_to_dev() instead of container_of()

> Good point.
>
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

...

> > -       struct device *dev = container_of(kobj, struct device, kobj);
> > +       struct device *dev = kobj_to_dev(kobj);
> >         struct iio_dev *indio_dev = dev_to_iio_dev(dev);

And now this can be one line since dev is not used separately.

> >         struct adi_axi_adc_state *st = iio_priv(indio_dev);
> >         struct adi_axi_adc_conv *conv = &st->client->conv;

-- 
With Best Regards,
Andy Shevchenko
