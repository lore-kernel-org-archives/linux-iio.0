Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34293 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753009AbdA3JQS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 04:16:18 -0500
Received: by mail-io0-f182.google.com with SMTP id l66so102843497ioi.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2017 01:15:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <48e07081-2088-6ffe-c58e-ac5a561b6a00@kernel.org>
References: <20170117142515.10578-1-linus.walleij@linaro.org>
 <20170117142515.10578-2-linus.walleij@linaro.org> <48e07081-2088-6ffe-c58e-ac5a561b6a00@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Jan 2017 10:15:27 +0100
Message-ID: <CACRpkdZZqW6DYXuR3ShT3NW+qpTvniEBVtnWsm11J1taYzLd4Q@mail.gmail.com>
Subject: Re: [PATCH 2/3 v3] iio: adc: break out common code from SPMI VADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
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

On Sat, Jan 21, 2017 at 2:37 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 17/01/17 14:25, Linus Walleij wrote:
>> The SPMI VADC and the earlier XOADC share a subset of
>> common code, so to be able to use the same code in both
>> drivers, we break out a separate file with the common code,
>> prefix exported functions that are no longer static with
>> qcom_* and bake an object qcom-vadc.o that contains both
>> files: qcom-vadc-common.o and qcom-spmi-vadc.o.
>>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: Ivan T. Ivanov <iivanov.xz@gmail.com>
>> Cc: Andy Gross <andy.gross@linaro.org>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Cc: Rama Krishna Phani A <rphani@codeaurora.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> This looks like fairly straight forward refacting to me.  Rama, could you
> take a look at this and perhaps test that no breakage has slipped in?
>
> I'd like at least one tested-by on this for the previously supported part=
s
> (that could be Linus if he has one!)

I am waiting for a serial cable for the APQ8064 Nexus 7 so no
test base so far. I would have to rely on Bj=C3=B6rn for this.

I think this patch is safe to merge though.

Yours,
Linus Walleij
