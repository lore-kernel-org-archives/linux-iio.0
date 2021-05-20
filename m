Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C84C433B4
	for <linux-iio@archiver.kernel.org>; Thu, 20 May 2021 20:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D896135A
	for <linux-iio@archiver.kernel.org>; Thu, 20 May 2021 20:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbhETUBc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 20 May 2021 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbhETUBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 May 2021 16:01:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305CAC061574;
        Thu, 20 May 2021 13:00:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D3783301;
        Thu, 20 May 2021 20:00:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D3783301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1621540808; bh=2WNLJX/xlZc5xTtT/m0BAIjR0dGVeWDMrn8wfYaNCUM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JWiESVFNzhYgP3LIrHH+2tY7pTjoh+gKnctlpgARBvgwBWg4BACU+o/zkUA8eRdPF
         jS85XmMhRO5jK77x2BlQkPxDSbCrzhxlhaMXvDctoM1+BMQOa0yL/SZHdunNPbhAgt
         4USigcfd0H+vMC4CmQMvwXkhr8hvfRf3UC0K6z2vi4HY7A5m+ShwS2LJ/UDdBlnsDP
         SPBGKoeOrTvsAjV7A36ox1hL3nOjKNp5cU8ATBlHyBRqSKzr5ElccrOeoSfEDcgg8h
         LH4udeqBoy+VzdXLKBnnbzSb6qpvpqwupJQPHnbWB4IHmqCdgQ0/NFGZsiTs5E64Wr
         JxMzmR3UeuhAA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        kvm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 00/10] Documentation build warning fixes
In-Reply-To: <cover.1621413933.git.mchehab+huawei@kernel.org>
References: <cover.1621413933.git.mchehab+huawei@kernel.org>
Date:   Thu, 20 May 2021 14:00:07 -0600
Message-ID: <87wnrtnpko.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> This small series contain a series of fixes for the documentation. it is
> against your docs-next branch.
>
> Three of the patches fix duplicated symbols at the ABI documents.
> There are still some ABI warnings from IIO, but all but one were
> already fixed at linux-next. So, hopefully, after having everything
> merged, the ABI warnings will be solved.
>
> Mauro Carvalho Chehab (10):
>   docs: update sysfs-platform_profile.rst reference
>   docs: vcpu-requests.rst: fix reference for atomic ops
>   docs: translations/zh_CN: fix a typo at 8.Conclusion.rst
>   docs: sched-bwc.rst: fix a typo on a doc name
>   docs: update pin-control.rst references
>   docs: virt: api.rst: fix a pointer to SGX documentation
>   docs: ABI: iommu: remove duplicated definition for
>     sysfs-kernel-iommu_groups
>   docs: ABI: sysfs-class-backlight: unify ambient light zone nodes
>   docs: ABI: sysfs-class-led-trigger-pattern: remove repeat duplication
>   iio: documentation: fix a typo

Seems like good stuff.  The last patch in the series, though, adds a
warning:

  Documentation/ABI/testing/sysfs-bus-iio:799: WARNING: Inline emphasis start-string without end-string.

So I left that one out and applied the rest.

Thanks,

jon
