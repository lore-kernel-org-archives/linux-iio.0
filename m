Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34893 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdAaKRA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 05:17:00 -0500
Received: by mail-io0-f181.google.com with SMTP id j18so127858801ioe.2
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2017 02:16:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170131100938.23660-1-linus.walleij@linaro.org>
References: <20170131100938.23660-1-linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Jan 2017 11:16:53 +0100
Message-ID: <CACRpkdYDMH9A=ezPkANRQXcqceEqn-A+oL2TxHyNkjmSms5AOA@mail.gmail.com>
Subject: Re: [PATCH 3/3 v4] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
To: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rama Krishna Phani A <rphani@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jan 31, 2017 at 11:09 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> ChangeLog v3->v4:

Oh and I didn't remove the dev_info() where the driver brags about being
present.

I usually like to have those positive affirmations from my drivers so I know
they are there. Otherwise I can't tell the state when I for some reason
forgot to compile it in because of some Kconfig issue from the state
where it is silently present. This is especially helpful in mailed bug
reports where people post dmesg logs. Then I can see "aha at least it
probed".

It's not super-important, feel free to edit it out when applying if you
totally hate it, I won't hold it against you :)

Yours,
Linus Walleij
