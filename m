Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:41874 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeABJ3b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jan 2018 04:29:31 -0500
Received: by mail-io0-f182.google.com with SMTP id f6so12052573ioh.8
        for <linux-iio@vger.kernel.org>; Tue, 02 Jan 2018 01:29:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1514578085.git.vilhelm.gray@gmail.com>
References: <cover.1514578085.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Jan 2018 10:29:30 +0100
Message-ID: <CACRpkdbBA0DX22ZGSkQxi+euTSROPzsmLTvSPwY8peg6+7igFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Change ISA_BUS_API dependency to selection
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Dec 29, 2017 at 9:13 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> Linus, please pickup this entire patchset through your GPIO subsystem
> tree; a recursive dependency error is present if these patches are
> cherry-picked (see https://lkml.org/lkml/2017/12/26/235), so they should
> be merged together in the same tree.

OK I just need a bunch of ACKs so giving subsystem maintainers some
days to come back on this.

Yours,
Linus Walleij
