Return-Path: <SRS0=UPod=6B=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AEBC2BB1D
	for <linux-iio@archiver.kernel.org>; Fri, 17 Apr 2020 20:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A2C206B9
	for <linux-iio@archiver.kernel.org>; Fri, 17 Apr 2020 20:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9j5U2Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgDQUtk (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgDQUtj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 16:49:39 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F59C061A0C;
        Fri, 17 Apr 2020 13:49:39 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id 19so3809641ioz.10;
        Fri, 17 Apr 2020 13:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/5KJFmOpE2KLSUP8j+/RNY6rBwg32SJvyDFTbrFnjg=;
        b=k9j5U2CsXAvOhbXu8Yd2siYsccDOfo6sQLomLD9IyoyxiUXGyIwiGBx7caaD33JcgF
         e3XxHOdN8Urqhrk76QoWVjO5ZG+0Cr88Fk51Js+q0redYD6n4yKFrmQEpwETPKq7qNLO
         b/9K8asMT6etv3Mca/n9DaOiSFjgrLrOPTeDoB/zQwcTS6SRH4Phz3qEXX0GNpteME59
         +ygAMAJ0xBW/DZ4u3shERp+COeLcwlBy7wFuOiVO/nBIIQpbT2S5Ps4DdgviazYrc+A5
         eD12T9Q/UUKPaphc8D++g/GmHMWPqKY/JTSLXqmkq7QDquCKpsGhb3uSYpqAF9GykUZt
         Z1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/5KJFmOpE2KLSUP8j+/RNY6rBwg32SJvyDFTbrFnjg=;
        b=mewKUdx1SH2t/0Qw7E618GzBZ6psRT5+LaPDfrCyKz0fpTzlAy4vtE7k2kgi1zu0lX
         UhC3g1hSLNySng+HUMzy0PdGG1juWHpDAY4GoQnVdhgYf5+8r+UZlmtIpVLRYVZs4/BG
         P4tKyEBF6skye/0qbO/mSuwFqFZYMRnFMEf2/Dk9NQWqDOk0FZd7LRFy1tRfZABiu4zN
         JpwGZpPEQGjmd6Yblkzh3/VsouAwUChQA9SuUZhFq8Dt4uGw75Fdk/mr0065CmHpvnZ+
         uEzME84xzsKSxP1i5ifYmI825w5HybIRsHYKm4teRT09fbj2BKKBULmBx3z8PjUc28v9
         Xy4Q==
X-Gm-Message-State: AGi0PuYDAS0KlNlRKKzgOrJZSvQ6CpmXJEKE+cQ352lxOnD2nfpXNZQ/
        tltzLnC8hIC5J4U3I0yT+Q9cV5wWHtV6LjQUviA=
X-Google-Smtp-Source: APiQypKEdV/Gubhy4Ciu633itt2gmWEr8YJyaidff96eETyTanDKpubhbd2NYFPX5WrIfg9zL8wI/TjlMrBtvO0NmWI=
X-Received: by 2002:a6b:f60f:: with SMTP id n15mr5069585ioh.22.1587156578608;
 Fri, 17 Apr 2020 13:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200417162204.14463-1-digetx@gmail.com>
In-Reply-To: <20200417162204.14463-1-digetx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 23:49:26 +0300
Message-ID: <CAHp75VdAn3QYY3gejnsdKuSyaLme1tiksSnoeg9rtzcJNG6S0w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: magnetometer: ak8974: Silence deferred-probe error
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 7:24 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> It's not uncommon that voltage regulator becomes available later during
> kernel's boot process. This patch adds info message about unavailable
> regulators in a case of the deferred-probe error and also amends the
> error message with a error code.


> +               if (ret == -EPROBE_DEFER)

> +                       dev_info(&i2c->dev,
> +                                "regulators unavailable, deferring probe\n");

I dunno why you think it is worth to spam log with this?
This message will be printed as many times as driver got deferred
probe cycle (maybe dozens in worst case).

> +               else
> +                       dev_err(&i2c->dev, "cannot get regulators: %d\n", ret);
> +
>                 return ret;
>         }
>
> --
> 2.26.0
>


-- 
With Best Regards,
Andy Shevchenko
