Return-Path: <SRS0=aw/O=QS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2B1C169C4
	for <linux-iio@archiver.kernel.org>; Mon, 11 Feb 2019 08:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A27F20863
	for <linux-iio@archiver.kernel.org>; Mon, 11 Feb 2019 08:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RKBkluOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfBKIe1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:34:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43932 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfBKIe1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Feb 2019 03:34:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id o1-v6so2140652ljc.10
        for <linux-iio@vger.kernel.org>; Mon, 11 Feb 2019 00:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBwVq/2kgXI0NZVvileKPaowPKcOhcpTEl/viUnmBok=;
        b=RKBkluOuqeaBUAF+gCsFl+EjlRYuEFLJa/fomibjDDJtNgZTYRyUuKo/DVfidWuY1f
         pPWhJxIvOVwxfatVFkq7fMgWdTWmURBnss9ymYCMQDUjTuEWP4BrTW6Cv34nDIaxEdPG
         W7rtZI6+S4DSpnniXH9sNpeEnyt0UZ+BLLXmlGJahTErPRKmzS/8yBc+mNjOcPG+vdn2
         BOYJ0p9pCG4XabxLpYx2dFhq5FeDBDBFR++T/EGt2uapZFSgr6Fzd19o7WI4t9FqOr/9
         9ULLQXPkR+OCWg+QUyd54qVRLr1FySA5rlk7tnGgwmLXmD8b1tAaFJw9WNWi9R3kTRIe
         qiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBwVq/2kgXI0NZVvileKPaowPKcOhcpTEl/viUnmBok=;
        b=kTpHExuTbu22oUOZCgpHY7MzCpY3y6i1dH88ixzqTLzGJeih9cxYW/yulCgwakJVj7
         yTQhNuMuwuLJGThMuTDcvkv09jT3CHFrv5pKTvvIZSb2YRawV6YSiCm7bzKqO0Uj29mp
         KBOznQRr198a6YsJa4MPB6cNG1FWeLcaS9yLciG3iDHqAJJQZJCHltHaiorJkRWQU5oK
         oW6ApYzFh0RcBv7mtUS0h8vpKfU/4jHf333NiOoQUU5XzbvtG3KJ27/zTpoGG53NmMMS
         2x9v//qenqsRZ+UmKRZwW8wXXwcF+5VA/QtnuK0iYyEOBnFJTPk9JcHNGYIH16naNH8J
         16Xw==
X-Gm-Message-State: AHQUAuZeAyliV28iktQwTrhNzfktP3CO03ZkuHzhxedyrgjBSt0yL3rH
        L/qZfcWQaMx+oj1Gnlmk45caBd2CWSk4coCxGx85EQ==
X-Google-Smtp-Source: AHgI3IYrzHNRgFBl0Ih5TEWUE+KH9bGOYxa6pWA9RRTl3bdugCph2r0fr5Wj5EF+2Fbo9tt60KWwzD7ljs/OJ7v35gA=
X-Received: by 2002:a2e:96c9:: with SMTP id d9-v6mr6106310ljj.105.1549874064899;
 Mon, 11 Feb 2019 00:34:24 -0800 (PST)
MIME-Version: 1.0
References: <1549653856-47409-1-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1549653856-47409-1-git-send-email-justinpopo6@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Feb 2019 09:34:13 +0100
Message-ID: <CACRpkdY-nZrX0EDgsE79egVDK9Lmrj_+gJN6h9B3SQT1z3OUzA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads7950: add GPIO support
To:     Justin Chen <justinpopo6@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        David Lechner <david@lechnology.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Justin,

thanks for your patch!

On Fri, Feb 8, 2019 at 8:25 PM <justinpopo6@gmail.com> wrote:

> From: Justin Chen <justinpopo6@gmail.com>
>
> The ADS79XX has GPIO pins that can be used. Add support for the GPIO
> pins using the GPIO chip framework.
>
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
(...)

> @@ -56,11 +61,17 @@ struct ti_ads7950_state {
>         struct spi_message      ring_msg;
>         struct spi_message      scan_single_msg;
>
> +       struct iio_dev          *indio_dev;
> +       struct gpio_chip        *chip;

Why use a pointer here? Correct me if wrong by a struct ti_ads7950_state is
always allocated for each instance of the hardware right?
So just struct gpio_chip chip; should be fine, then just fill in that
struct.

> +       /* Add GPIO chip */
> +       st->chip->label = dev_name(&st->spi->dev);

So it would be st->chip.label = ... etc.

> +       chip = devm_kzalloc(&spi->dev, sizeof(*chip), GFP_KERNEL);
> +       if (!chip)
> +               return -ENOMEM;

And no need to do this.

Apart from that it looks OK to me, but there are some locking comments
I see.

Yours,
Linus Walleij
