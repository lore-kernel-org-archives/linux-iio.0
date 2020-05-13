Return-Path: <SRS0=6wjF=63=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C8ACA90AF
	for <linux-iio@archiver.kernel.org>; Wed, 13 May 2020 09:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A840623128
	for <linux-iio@archiver.kernel.org>; Wed, 13 May 2020 09:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI5NR0Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbgEMJuA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 May 2020 05:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387418AbgEMJt6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2020 05:49:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B76C061A0C;
        Wed, 13 May 2020 02:49:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so6618558pls.8;
        Wed, 13 May 2020 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vI1HSpo7JSbwTRD9lhLBPGbReloovre1TONkkWI4K8s=;
        b=cI5NR0Fmf0b3v4RmzfC93mlJjUuGrnz+wojY6kn0wMKI0CqhzbAaR68zlAPTfc8dlv
         nEo440GlsOwFtHLvmIwgjuS3b21nqoISVskSnOTWHvxRLJrdNWFj6QMTmLmtSrHcvII1
         f21gkgvPL17ChZSaMzaeZarWmyda5FX9Kr5ukmdzmNBgSSse2lehTc0Ks5vhNtVA0/mE
         9rpVuAwhTwRu4icbbs7byMez/Yo1v+A11a88VyXl7uI1WJZAZarE356ybl82sEjjXRZ5
         8G2lnX/haRNYHv8EmMYC+JvmoyXtaKWUhedE/OBMwOR4zYnDyClehHQNyZI5AqEinVaV
         sbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vI1HSpo7JSbwTRD9lhLBPGbReloovre1TONkkWI4K8s=;
        b=abcJAl2ciZe1+rQEyAm0KavHP1h120wmdnahsKjDU0VQBCwljrm1YKMih15GGmO2+a
         c7R0Kf83OWxOinsJ9d5XKvy6Lk71Q0gh/vkFn0l/AAgCoGuBBBQaYzmwEwUq35jyEkX+
         A/K1hqw9CYUdf/qzC6qyb99FzXbUoZOcUI/S+7YDqJc9OlPO0r5VBZa5qAohxE0C/4zq
         siNy7fNGlXCV97TBLUy8p78m7QX34FXVn1LcepyvpF2iyiONLIOJE2U8267SUxooOyQ3
         N49vO+Cobfgxc/h+36PZ1m3IiNhsmxXtjS8A5mPmRyZNkqA6ToillKlRjzmIwLeFJSv2
         Dicw==
X-Gm-Message-State: AGi0PuY445Iqi3v54nG6GlPWwD83cdT77UbY982OxGpObje+WDxxM48Z
        +rFP3uvnUOvmTtc1Kf6fZRg292nUgMyxPkTWFAo=
X-Google-Smtp-Source: APiQypKJ0EhcKN4EMwA2AMwX12EH/qNwRgFeDBPkHlJLKVpoAB7ilzcQdSoNb7EilT7ycg/niDjp4WWhY8w/d/sAxM4=
X-Received: by 2002:a17:90b:3717:: with SMTP id mg23mr34645016pjb.129.1589363398238;
 Wed, 13 May 2020 02:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <1589361736-816-1-git-send-email-jprakash@codeaurora.org> <1589361736-816-5-git-send-email-jprakash@codeaurora.org>
In-Reply-To: <1589361736-816-5-git-send-email-jprakash@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 May 2020 12:49:51 +0300
Message-ID: <CAHp75Vex+hm2pVat_VVH5gAqPDbm-VQMes56wC=RUcQeM=z7vA@mail.gmail.com>
Subject: Re: [PATCH V4 4/5] iio: adc: Update error checks and debug prints
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 13, 2020 at 12:23 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> Change pr_err/pr_debug statements to dev_err/dev_dbg for
> increased clarity. Also clean up some return value checks.

'Also' on the commit message == 'split this to two'.
But here is a ping pong style of patches (you introduce a problem in
one patch and fix it in the following).

-- 
With Best Regards,
Andy Shevchenko
