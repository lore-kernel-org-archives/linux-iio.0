Return-Path: <SRS0=LZIF=B6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D255CC433DF
	for <linux-iio@archiver.kernel.org>; Thu, 20 Aug 2020 13:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C82207BB
	for <linux-iio@archiver.kernel.org>; Thu, 20 Aug 2020 13:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdBUSZcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgHTNHk (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbgHTNHV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2020 09:07:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63BAC061385;
        Thu, 20 Aug 2020 06:07:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1so611254pjd.1;
        Thu, 20 Aug 2020 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KqAsHDETQOry6yr0jg3Z6xIgB+xnOYYAudJegp+z6Xg=;
        b=WdBUSZcfs2umRDboNZztXlEAAV7GXKDNIeb3Qb2tD03c5LMqg/0C6EmPXDfMC4vGWL
         flyFLLiEZhr4QCDVgE3+cb2zmhMWitLjXqJ0jj0o4gYEw/evnDkw549tkqmeEGscRXiM
         1ZB7RY9M0hxS28Kea7vrFQwB13yMu4HdnhSCKzBywdTbdjHcXiMtNyG0gf6YqYz6WqcB
         9YmTgQO2wTo3eDMwEH9314ukhV0zyWbjsQoImrKwTmjhsu8rzPuPZeN8L/ViGy97D60m
         ZOvHlwd0+bLn5hL72D8Z7pc0CdOU3wnfqxyVHVM20A6dASHAcEzFQF+rxu70wU3I3XLh
         Cs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqAsHDETQOry6yr0jg3Z6xIgB+xnOYYAudJegp+z6Xg=;
        b=Pzv1M0ZNfF+X4Av74M8Z4Khsdmj3Ks1vUqu/uTENRnCHWk3BRzRmVwofOd//seYbHz
         X+p9Zhp5/KCiXiW3B65R33LbC4NixRmCatrAhz6Us1w1gmjmKRe7lGGpQw0relFxNtxv
         CsonANaYrEk4fxYfAPhVgoNYN4/lhC6QMdZyFfWNyTQDSrZz5tLFFONDjObPKuA96Ocg
         mtNYm7fcZzzMnz4EpYE9+L9heaHyA9EJJmx8+piCtMwvLl7/sJDS30NiU2W66fy9wy+m
         iMJYuvlX72wowEzAJkKaK2ARxFyb2NuVbxGXBzC0NKpluQ8VSHtJTEQUgstUqcg0M0nS
         TFCg==
X-Gm-Message-State: AOAM5307qfckB3gxlEDTLQKHNeauvC2Knr2NVwEj3nLrNWGj5f0IdtgS
        V0WubRwTcC69/oNXC+iVpLC7UahNPRNR59n4DNM=
X-Google-Smtp-Source: ABdhPJzTHllU7kCzBoIpVPf6oizdkQ2tk+JvmqjlKxXsncAf9YDI/4BREQa+apJHkj8ZH65udItiUhcbOlKL8p4kbqc=
X-Received: by 2002:a17:902:b098:: with SMTP id p24mr2309156plr.255.1597928840300;
 Thu, 20 Aug 2020 06:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <1597892486-3236-1-git-send-email-tiantao6@hisilicon.com>
 <CA+U=DsojNXFxT812=i-0ceRGUV3gJXhMMb-ungP=DO166jjZMA@mail.gmail.com> <CAHp75VdqrczNjsgR7JZTsK8+=RmgFopGJ1VZdD4+BYxBHMHukg@mail.gmail.com>
In-Reply-To: <CAHp75VdqrczNjsgR7JZTsK8+=RmgFopGJ1VZdD4+BYxBHMHukg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Aug 2020 16:07:04 +0300
Message-ID: <CAHp75Vf1C17eQzbuaxukzqxTgKO9Lv6fKDZ5JqfwMFWcvbMxFA@mail.gmail.com>
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

On Thu, Aug 20, 2020 at 4:05 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Aug 20, 2020 at 12:10 PM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> > On Thu, Aug 20, 2020 at 6:04 AM Tian Tao <tiantao6@hisilicon.com> wrote:

> > > -       struct device *dev = container_of(kobj, struct device, kobj);
> > > +       struct device *dev = kobj_to_dev(kobj);

> And now this can be one line since dev is not used separately.

On the other hand perhaps one object per line is better to read.

-- 
With Best Regards,
Andy Shevchenko
