Return-Path: <SRS0=zyAD=Q5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4564C43381
	for <linux-iio@archiver.kernel.org>; Fri, 22 Feb 2019 16:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD8020665
	for <linux-iio@archiver.kernel.org>; Fri, 22 Feb 2019 16:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DLXX4Sx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfBVQYX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:24:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34377 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBVQYX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Feb 2019 11:24:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id u21so2179508lfu.1
        for <linux-iio@vger.kernel.org>; Fri, 22 Feb 2019 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwmUBlwxm26X7ae/pAiJBdHtNl4iH4Ed0C9ZDyjdd2A=;
        b=DLXX4Sx8FbsQuJKF2DOYZvQw2I8Eaf5TT55esXaKwPnhVAMbd0ysRm1l1gN34InN19
         T9t75aFojUorsgeRfGgn80nM0Y/H3VxkHR2pu4cN68oZ0Lp/iBPUWKNKuGBbh++M/uGS
         7dIcj9Yo7Gz6gANRKirVGSO1lKtGfcCrN2CPvWtlh2+KB8klUPQY6tST1cYKjQLw32x5
         wgHCS40cbn82UasABzatGYfcIJU9S86trEJZGgrtpPo1aZBpSmDvXrfXACBg73AjMJNm
         VKtEl6qFZHALVYCQZxWnwXxw6dI2351FHC/JkyDeiczSJn7M1i4w7GpgbQcp8LMKBnP+
         Z5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwmUBlwxm26X7ae/pAiJBdHtNl4iH4Ed0C9ZDyjdd2A=;
        b=SUWmUemBaW5E5sCef/yIPZvnEGM5gPuMER0S1QRoo9yXwi+1zQMS9dbD4FSOfWNBrj
         HhzRiZrewE33ePskICN60eifNYIVG96tWbjgAK1VcVPi7HCKRyy1dbnPK0fUXs9a/zOn
         f//vlWs/KAgiKcLbkPu6boc69U81sJ4vqYbxV6HR3U3k4oAEOImrEe7XPE2oksI3ohhb
         dMv1nga/02q/gOzKTcHgeTKpFh4C7JrEMJuDMx+QioEWaNb4gA+PbfkYquGFA6Jk1TKR
         ROm3joqoq6vvlP8/dAHhm1EoJ0v4x1zKHEqzedzl7wZ75yd7utTpF3muA3v5wJEOpBtR
         /arA==
X-Gm-Message-State: AHQUAubtAKrUxaZnPCNYktawNBVq6eY3NO5O9Leo2ZA4Mr2iQUOKffj8
        +sgj8nLWucSEKJcI96cAd4r4Hg4KxLR20sdTHZKCiQ==
X-Google-Smtp-Source: AHgI3IbPh6Y8mLA8LEtp91iWtv/SMSMzp7L6vaKujnfyFBlMyoGnyZNErzGniCRAxnEQOxICot36TG/4tiHckJg0MXQ=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr2639226lfl.129.1550852661439;
 Fri, 22 Feb 2019 08:24:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550768574.git.hns@goldelico.com>
In-Reply-To: <cover.1550768574.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Feb 2019 17:24:10 +0100
Message-ID: <CACRpkdbb_7JZ=TdtAfqRJZ5C3JjORqKbOqZZP71+_v+0QLpUQg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] iio mount matrix - revitalize missing bindings
 documentation and provide code for bmc150, bmg160, bma180, itg3200, hmc584x
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 21, 2019 at 6:03 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> Fixes V2:
> * make get_mount_matrix() functions more readable (use temp variable)
>   (suggested by Jonathan and Andy)
> * add these readability improvements also for ak8975 and mpu6050
>   (suggested by Jonathan and Andy)
> * squash bindings documentation into single commit for better discussion
>   (suggested by Linus)
> * FOR DISCUSSION: add some more clarifications to the bindings documentation
>   and an attempt to define the magnetometer orientation
> * add "iio: Allow to read mount matrix from ACPI" to the beginning of
>   the series to make it compile
>   (suggested by Andy)
> * replace of_iio_read_mount_matrix() by iio_read_mount_matrix()
>   (required by "iio: Allow to read mount matrix from ACPI")
> * drop patch to convert bma180 to devm (potential race)
>   (suggested by Jonathan)

I'm a big fan of this series and I really like what you did with my old
patch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
