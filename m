Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36625 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbdAaTy3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 14:54:29 -0500
Subject: Re: [PATCH 3/3 v4] iio: adc: add a driver for Qualcomm PM8xxx
 HK/XOADC
To: Linus Walleij <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20170131100938.23660-1-linus.walleij@linaro.org>
 <CACRpkdYDMH9A=ezPkANRQXcqceEqn-A+oL2TxHyNkjmSms5AOA@mail.gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rama Krishna Phani A <rphani@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0c54c4d8-265c-112e-60f1-af21b73148ec@kernel.org>
Date: Tue, 31 Jan 2017 19:54:10 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdYDMH9A=ezPkANRQXcqceEqn-A+oL2TxHyNkjmSms5AOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/01/17 10:16, Linus Walleij wrote:
> On Tue, Jan 31, 2017 at 11:09 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> 
>> ChangeLog v3->v4:
> 
> Oh and I didn't remove the dev_info() where the driver brags about being
> present.
> 
> I usually like to have those positive affirmations from my drivers so I know
> they are there. Otherwise I can't tell the state when I for some reason
> forgot to compile it in because of some Kconfig issue from the state
> where it is silently present. This is especially helpful in mailed bug
> reports where people post dmesg logs. Then I can see "aha at least it
> probed".
> 
> It's not super-important, feel free to edit it out when applying if you
> totally hate it, I won't hold it against you :)
Meh.  I'm not that fussed ;)

Anyhow I clearly did something crazy last night as the first two patches had
disappeared from my local tree anyway, so I've tried again and now hopefully
all is in order.

Applied this one as well with a spot of fuzz but all obvious stuff in the
Makefile.

However...

ERROR: "qcom_vadc_decimation_from_dt" [drivers/iio/adc/qcom-spmi-vadc.ko] undefined!
ERROR: "qcom_vadc_scale" [drivers/iio/adc/qcom-spmi-vadc.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:91: __modpost] Error 1
make: *** [Makefile:1198: modules] Error 2

I've fixed that up and some static declaration issue.

Please do sanity check builds as modules!  It all needs to be one one object file
when added to the $(magic)-m

However, I can't see any way of keeping them module name as was (qcom-smpi-vadc.ko)
without renaming one of the c files out of the way. Please check I haven't messed
anything up.  The new naming is a bit naff, but I couldn't think of anything better
off the top of my head!

Actually this is enough of a mess I'm pulling these last two patches for now.
Will push them out in a special testing2 branch for you to take a look at though.

I also temporarily changed the mfd dependencies to add COMPILE_TEST.
Seems fine, so if you could do a patch adding that we'll get better build coverage.

Jonathan

> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

