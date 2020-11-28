Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1742C63777
	for <linux-iio@archiver.kernel.org>; Sat, 28 Nov 2020 23:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C30208CA
	for <linux-iio@archiver.kernel.org>; Sat, 28 Nov 2020 23:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz4dxEse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgK1XTC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 28 Nov 2020 18:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgK1XTC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 18:19:02 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B578C0613D2
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 15:18:22 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id k11so7294481pgq.2
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 15:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gOwlx47gYt1W3MHWgz8KjiuA/bNiWbFgmz/p6n60JAQ=;
        b=Iz4dxEsexNDmWSnYCNL9jaoFPZVDnPYi6fH/J6KWRQnvKMsPh2eZryNFz8qCYDngJ1
         ILcWj8lrsw8Eyh7oDe2wPV5yK7Kcnh0RY59sfVt0Qu3OSYpIo7q+ugO4tzncy3ptUzCd
         8pnV9UqHYzCR1Pi8PlJ9QW6b0IpxKud84Df4N7K2YSglZqO33kXeOoX+TTNS1zODw5EH
         kna7ZQQX/UWr5jtT4NgLFVXNeqfXEhN0FR3vBQYESo9REJ289ekdzdZVwpPVtO5mwb3m
         1AItDag8nX7j9Afm489MFTKYnWR9KP8w4VoZOMYV84wx/vF8YiBfAoexbOZccRKOMFbM
         zm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gOwlx47gYt1W3MHWgz8KjiuA/bNiWbFgmz/p6n60JAQ=;
        b=ElLJmJ6cOJNZH7SEKF2B8PhHdkMofIIsPQwkR8+CY4u11qE6lScBkiB91+EM/TcS1e
         S7ZHYTZao7b7kdP4wI0FIXw7WimpnrGBRog12Lgx5dWzfE+G/U0uJcSv1W0tneGIxK4H
         xPH8fuFl/vWLTRGCBXKEFRi6SSjtmXXuGYQwSQxK20nhGeqaDa985cK5WvfmbUK1pBOz
         xQddVaIj+fo9C8dDB7o0zQWZYy6xps1WgCcj/Zi7IrFJo4DCzyz4UKVcSz1Wv0LoOUpc
         vJ0LLALqupyKbiXPl7ijkjlz0XnvCbAx5SmSI0eKcyJqadtg9UOH+5hYbW/a0nF8jpAX
         9lnQ==
X-Gm-Message-State: AOAM531CVGKZpbQmxAZtUm6z6A1rtX0GpAOoQT8+2dB1nuYQYgkU/eDh
        tRsAyoLzbYUdn6kY5wL9xJSSQxnZO/D341551Xs=
X-Google-Smtp-Source: ABdhPJxQEJNzSr9jRBCfyGBGirQRlMnEou7J1L25RO53CZhccoMEsqg3Bg7eBZCtxgjvJ+yfMp408xBg4Y0RncjT2Sc=
X-Received: by 2002:aa7:9597:0:b029:198:50a8:a6cf with SMTP id
 z23-20020aa795970000b029019850a8a6cfmr12820267pfj.40.1606605501879; Sat, 28
 Nov 2020 15:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20201128185156.428327-1-jic23@kernel.org> <CACRpkdaA5yhgd4+BgFN6WeC7pmoKPj8kYabD7TtFyEieiNVZfw@mail.gmail.com>
In-Reply-To: <CACRpkdaA5yhgd4+BgFN6WeC7pmoKPj8kYabD7TtFyEieiNVZfw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 29 Nov 2020 01:18:05 +0200
Message-ID: <CAHp75VcKOrjLBwRBZ0gi0S8tL2QK7+3i2dhABbaQaBW8O=_6iA@mail.gmail.com>
Subject: Re: [PATCH] iio:gyro:mpu3050 Treat otp value as a __le64 and use
 FIELD_GET() to break up
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 29, 2020 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> w=
rote:
> On Sat, Nov 28, 2020 at 7:54 PM Jonathan Cameron <jic23@kernel.org> wrote=
:
>
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Inspired by Andy Shevchenko's proposal to use get_unaligned_leXX().
> >
> > The whole one time programable memory is treated as a single 64bit
> > little endian value.  Thus we can avoid a lot of messy handling
> > of fields overlapping byte boundaries by just loading and manipulating
> > it as an __le64 converted to a u64.  That lets us just use FIELD_GET()
> > and GENMASK() to extract the values desired.
> >
> > Note only build tested.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
>
> Are there any specific prerequisites? linux-next?
>
> When I apply this and try to compile for an ARMv7 target I get
> a lot of noise and an error:
>
> In file included from <command-line>:0:0:
> ../drivers/iio/gyro/mpu3050-core.c: In function =E2=80=98mpu3050_hw_init=
=E2=80=99:
> ../include/linux/bits.h:36:11: warning: right shift count is negative
> [-Wshift-count-negative]
>    (~UL(0) >> (BITS_PER_LONG - 1 - (h))))

I think GENMASK_ULL() has to be used.

--=20
With Best Regards,
Andy Shevchenko
