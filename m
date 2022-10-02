Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E39C433F5
	for <linux-iio@archiver.kernel.org>; Sun,  2 Oct 2022 14:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJBOhU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Oct 2022 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJBOhT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 10:37:19 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C714A26AE1
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 07:37:17 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso3233802fac.6
        for <linux-iio@vger.kernel.org>; Sun, 02 Oct 2022 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=on7Qgjrpx4l3G3McmtRTQ/mG2Pd1HrAnwhsCNdu1eTE=;
        b=XuxOdGk7Vs81fZMEEO0SJdcVq4g+WSnG0lTwJaD/gnNAEExz0ybmJJAX7zJT54lsvT
         8wyEUgOGDNB6EGIioovylH38HUkWohrKM+6W7wB8dI3b8poFb3LMC0jL6BL643D+sfb0
         b2p+BSUs8921bphVH3iuS+4NXtIzmisb0U6DlMSVVrq7LWuD6EcgADZvcowEpgSVcgWf
         sb3/KuCj6gMvy+ffq5jxNU/x3QqW8TNKm/rNCA0mE7jxIxgcpt65e2pCLxKK9xN0vTJA
         PsjG6EQoPhRTlGnPT9pZ0V6Ku/BrXWDtKd+c8tgDnTaxEwqIyFJwzMhsAB2UwS1aYIEH
         bqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=on7Qgjrpx4l3G3McmtRTQ/mG2Pd1HrAnwhsCNdu1eTE=;
        b=TkPAp+b5eXVB4zHnzlpeWKmr30NJcdzxj5uyvc5w4dme3LkA0bIEyyIxdDDlxD2maY
         DH1bvPKlkaqgisAEeGFqm8a/Yql/mtz8N9fLOUAO6KfEF0YrJZ16BKi0S0HkLN4UUPbo
         j5BHTtS0cbYnu8P87xpzEWL0FArh9jCzNCProbtMtEi+6Bqs14A6Ynqu26TsduJLMWwG
         W7B9hx+UXlGilMlHLkFhfAdSGzbh8h5pSM2cBzogDVmd9pwX7JLVht3wlV2fEYBKwgB6
         rO9U73a0cQ4gReD6Tmn5clnUl3H0KM+/mIrNVYSfsQaVAcm5C3NeOdtMM5ezn0P6RIIZ
         +pkw==
X-Gm-Message-State: ACrzQf148+R6pnNvCEmN+7fyQ/YwYECEakgXb2T01Gj3MkyWTHq+9qZi
        E10tdk7HUKNS7Eh0PKYBYH6zf5WRYO17ECvCcLl33A==
X-Google-Smtp-Source: AMsMyM4VswIv/iXSjDicYezuHkMIeP+27LBgPTvvzmVGg6UKOgkQXZ+lEFJzbER28wHqGLz/gDsm52qivHydHwlvsGg=
X-Received: by 2002:a05:6870:d6a9:b0:127:fb20:c5c0 with SMTP id
 z41-20020a056870d6a900b00127fb20c5c0mr3411466oap.175.1664721436214; Sun, 02
 Oct 2022 07:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1663834141.git.cmo@melexis.com> <20220924173221.1174608b@jic23-huawei>
 <CAKv63utk0r+PJXkkY3PpAmKp3WT6H5GxnBLdtJm28W1kz01E+g@mail.gmail.com> <20221002122535.07d66ab3@jic23-huawei>
In-Reply-To: <20221002122535.07d66ab3@jic23-huawei>
From:   Crt Mori <cmo@melexis.com>
Date:   Sun, 2 Oct 2022 16:36:39 +0200
Message-ID: <CAKv63usrE-DMQu-mTOCMsvSwPnNspeSsZJVncQkpaX3xOtVGtA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] iio: temperature: mlx90632: Add powermanagement
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>> I sure hope you mean 6.1 material... It would be great to get into 6.0
>> as i think that is a most likely candidate also for Android kernel
>> baseline (which is what I am also targeting).
>
> Sorry, I do mean 6.2.
>
> The merge window for 6.0 was months ago and we have to line 6.1 material
> up a week or so before the 6.1 merge window (which probably starts today).
> That allows us to get build bots and similar results before the merge window
> and with time to fix any issues.
>
> So unfortunately this will only be in a released kernel in about 6 months time:
> 3 months for the 6.1 cycle that this just missed and then it'll go into Linus'
> mainline tree, but the release will still be 3 months after that.
>
> In the meantime it'll be in linux-next from just after 6.1-rc1, and in
> Linus' tree for 6.2-rc1.
>
> Kernel cycles are short for a bit project, but they still have about
> 3 to 6 month delay for new code reaching a release.  This just happened
> to hit the maximum.
>
> Jonathan

OK, then fingers crossed we get rc8, as then I imagine you could put
this series into the 6.1 right? Would be really grateful if it would
not take 6 months to get this into mainline.

Crt

On Sun, 2 Oct 2022 at 13:25, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 26 Sep 2022 15:20:16 +0200
> Crt Mori <cmo@melexis.com> wrote:
>
> > On Sat, 24 Sept 2022 at 18:32, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > > The sensor runtime suspension is set to MLX90632_SLEEP_DELAY_MS which is
> > > > hardcoded to 3 times as much as MEAS_MAX_TIME.
> > > >
> > > Hi Crt,
> > >
> > > Applied. However, we are cutting it very tight for the coming merge window
> > > so I'm not sure I'll get a 3rd pull request out (this just missed the 2nd
> > > one as I only queued up material that was in a final state last weekend)
> > > So for now pushed out as testing and we'll see if Linus hints at an rc8
> > > when he releases rc7 tomorrow.  If not this will be 6.2 material now.
> > >
> > I sure hope you mean 6.1 material... It would be great to get into 6.0
> > as i think that is a most likely candidate also for Android kernel
> > baseline (which is what I am also targeting).
>
> Sorry, I do mean 6.2.
>
> The merge window for 6.0 was months ago and we have to line 6.1 material
> up a week or so before the 6.1 merge window (which probably starts today).
> That allows us to get build bots and similar results before the merge window
> and with time to fix any issues.
>
> So unfortunately this will only be in a released kernel in about 6 months time:
> 3 months for the 6.1 cycle that this just missed and then it'll go into Linus'
> mainline tree, but the release will still be 3 months after that.
>
> In the meantime it'll be in linux-next from just after 6.1-rc1, and in
> Linus' tree for 6.2-rc1.
>
> Kernel cycles are short for a bit project, but they still have about
> 3 to 6 month delay for new code reaching a release.  This just happened
> to hit the maximum.
>
> Jonathan
>
>
> >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > >
>
