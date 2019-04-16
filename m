Return-Path: <SRS0=o58m=SS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA86C10F13
	for <linux-iio@archiver.kernel.org>; Tue, 16 Apr 2019 11:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C249A20821
	for <linux-iio@archiver.kernel.org>; Tue, 16 Apr 2019 11:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsPDXNF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfDPLuc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:50:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33790 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfDPLuc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Apr 2019 07:50:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so18841495ljc.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Apr 2019 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDEUUJoJSi6YoYZnXF5gY1Gw6oRcZMS/KEqiS2IofEw=;
        b=rsPDXNF9+dl3oAKvj65WtlpVCuxrIRVUMzeWCW4rQ9psniXY0agR7uWZ5X97MiZb9g
         5mX0FokaIVnOlrBYcEU33PN5y1KAKJeoC6GtA09jPcl2nriWpXCJjwh9MBiAdfWR1y1+
         2VaZlIWuFx5cCWdpKl2w4Qw7exA3RALxHWtlfV9+NWL1ueM72Db8686gSU4h6l8x2sB2
         CBlAHO5FDMghLTIpi1C/fWkNk+OoseKrKasC8kHc6xEUmgz+pX7bvojN4tQgNYOZnmOZ
         Ch3rZUQ+gDZUzseSTn++30M1liZx3hFgalWVxeJ3V1TiaUV+GNbawVu2741rRCHUXzKS
         3vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDEUUJoJSi6YoYZnXF5gY1Gw6oRcZMS/KEqiS2IofEw=;
        b=Conik8euGCZl0ZfXThSSq49uyz+MnaVxinZ8uLT49N7HAMTO6xcVtvN4gSJnEl7rCs
         Gk7yc1TB4obXUjSgMaTRpwVsNo+neEDgRl1ymKJ6yaLDC580tEYsuj6yiJRsZm/tFFvy
         ApT/ZMehAjuHUZlD0JlGhJ54dNwfAGii5vSdZNhgfSqH2K+QqxsZNEAuizbI/okieRM0
         j9LItGc3Sn+53IN3qyEjUoJK2L8lWFn8SP+MRGbZhZPMEVL1L+vJNNsp/Xf57p+T3o6b
         ok7hrv0WleUapCtBQuOAZ3Bdxc0LWLlJvcxAubZ5Qcq37CtABt+EllyfH3dT8aZD7BFe
         Ij5A==
X-Gm-Message-State: APjAAAUanInmvAQ7vqf02MgG8zo8DLvmivrdnqMM1+xluvMNgKAaQABT
        1t3RhKCXUctNuTxrnOaTLhJ3L45rvVC7zaGT2adj6A==
X-Google-Smtp-Source: APXvYqzvLM2iOlhUPlFbXzBTzgB6hvGmlBsofIrhBUB/mzmiP5PZfWnXeTzIL/nFkAY+oDiKxJDWdnDygL3sklKEDlI=
X-Received: by 2002:a2e:3512:: with SMTP id z18mr42249075ljz.25.1555415430079;
 Tue, 16 Apr 2019 04:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <1555257218-3830-1-git-send-email-mohankumar718@gmail.com>
In-Reply-To: <1555257218-3830-1-git-send-email-mohankumar718@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Apr 2019 13:50:18 +0200
Message-ID: <CACRpkdY5cX=aP9nNwWeUd0Nx33MS0QJDnLKzbajADRsKCUVbOA@mail.gmail.com>
Subject: Re: [RESEND PATCH] drivers/iio/gyro/mpu3050-core.c: This patch fix
 the following checkpatch warning.
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 14, 2019 at 5:53 PM Mohan Kumar <mohankumar718@gmail.com> wrote:

> As per Documentation/timers/timers-howto.txt Msleep < 20ms can sleep for
> up to 20ms. so use usleep_range.
>
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>

All right, should work as fine.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
