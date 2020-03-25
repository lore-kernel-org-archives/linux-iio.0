Return-Path: <SRS0=vKzs=5K=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C94C54FD0
	for <linux-iio@archiver.kernel.org>; Wed, 25 Mar 2020 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E143F20740
	for <linux-iio@archiver.kernel.org>; Wed, 25 Mar 2020 15:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irn64M+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgCYPsB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:48:01 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39595 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgCYPsB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 11:48:01 -0400
Received: by mail-pj1-f68.google.com with SMTP id z3so651689pjr.4;
        Wed, 25 Mar 2020 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHLzrrFkz02OANjXXXqYyNxuX8bvrVIchzwqAUHYgdc=;
        b=Irn64M+Metg1KLx4yeGU1A1For4ZpyIGrSlxfUdZSvDUCZAZxyGeeVYHi9vdMWgPJx
         dSW6MinuHTPYnFcTz+bx6C73F0VDbgOapZ8zA4ftKuF2/pIAqc9FbasaEx7wgb2v0u9d
         V/qznbasgzvRWo4tQJLjn7yhjlAux1soZc9MjjbZq8zBmnVhOV/hQpmPoEOienzSwUKF
         +HUNXXrtRxMMfOevMkbMpxKjBbqt1ByfWajuVOUey073jBVA6J5EvcFpujOaWHKJMtpU
         zVZC9iyBW8EFSKmD5IDG7HDZBsQyn9uqgU8GOWhAQmr/LS1Edq1/UTxsFf9YX78eXKJ9
         JYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHLzrrFkz02OANjXXXqYyNxuX8bvrVIchzwqAUHYgdc=;
        b=sWTVPgwNq94KSxmvnpyHmNwuM2ee9KqCUgg73Sv3r0Bs4YaJfibrX5uJZBGfxiJBpT
         lNAG1NI0dAqvasdFMrbzyB1rK9AoCbOCkDHNGKSTCBsb8T2Kq4/ItoR2D2O4GxiLoZoX
         mE8NST142NzFwOLMsxQ4HqLd97s6eOKKwN8IuxLQbg58WnorMCnIcy2VVNqm2n3wr+E8
         DxNw8+G10e6zToJVsPaXAtwGwoAZRUZOmi4pCZQcFotbFQDCiQC4oRFhKpRKrsmhO/2Y
         W2tVLVIOrFPeg4fteUx5kQw5Wb85Su2/4WamQPf3Q6abKzanVXhHnto4GHyrD/YLhaPR
         n/5g==
X-Gm-Message-State: ANhLgQ3tiWl+39x+YQlDsHOLwiTvnmwH8Uou07+2kNs5BglkISUPnoAt
        hSOdfpVRogdC9gCZq1s3tkxA9o1UVR4AUKkXtR5VV3PD
X-Google-Smtp-Source: ADFU+vu2Wws6sn7JbXvxhKP610uZyziu+NwzlFdVceSABJSdPjxRhAUXSVWDb9uo1oVEvddulgPCEVW6/siZQogcHfI=
X-Received: by 2002:a17:90a:3602:: with SMTP id s2mr4345960pjb.143.1585151280026;
 Wed, 25 Mar 2020 08:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200325151211.19949-1-i.mikhaylov@yadro.com>
In-Reply-To: <20200325151211.19949-1-i.mikhaylov@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Mar 2020 17:47:52 +0200
Message-ID: <CAHp75Vc13sKEF0jHY=Bzde3e0t9tnkX-42LrRQigZRmqRQfKHw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iio: proximity: driver for vcnl3020
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 25, 2020 at 5:14 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Add proximity sensor driver for Vishay vcnl3020. Only on-demand
> measurement is supported for now.
>

You missed chagelog here. (For the future, please, don't miss, but now
send a followup message what you have done in v2)

> Ivan Mikhaylov (2):
>   iio: proximity: provide device tree binding document
>   iio: proximity: Add driver support for vcnl3020 proximity sensor
>
>  .../bindings/iio/proximity/vcnl3020.yaml      |  47 ++++
>  drivers/iio/proximity/Kconfig                 |  10 +
>  drivers/iio/proximity/Makefile                |   1 +
>  drivers/iio/proximity/vcnl3020.c              | 242 ++++++++++++++++++
>  4 files changed, 300 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
>  create mode 100644 drivers/iio/proximity/vcnl3020.c
>
> --
> 2.21.1
>


-- 
With Best Regards,
Andy Shevchenko
