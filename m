Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33540 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdAJIyD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 03:54:03 -0500
Received: by mail-qk0-f174.google.com with SMTP id s140so144690699qke.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Jan 2017 00:54:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <717ea1c4-33af-f0ca-e018-5d7ac87506e1@kernel.org>
References: <1481842105-14047-1-git-send-email-linus.walleij@linaro.org> <717ea1c4-33af-f0ca-e018-5d7ac87506e1@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Jan 2017 09:54:01 +0100
Message-ID: <CACRpkdZUk6UUN2ACXp0S1RW7k2M5t5X5N_0mJQeo_UTEa4H=9w@mail.gmail.com>
Subject: Re: [PATCH 2/3 v2] iio: adc: break out common code from SPMI VADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Dec 30, 2016 at 8:01 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 15/12/16 22:48, Linus Walleij wrote:
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
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Looks superficially fine, but I'm guessing will need a respin
> as we have a fair bit of new stuff (and a couple of fixes) going
> through this driver at the moment.
>
> All but the two fixes I posted a few mins ago are in my testing
> branch and should go to Greg once I have confirmed testing on
> those two fixes.

I looked at the git and "testing"
contains a top commit named "guessing" fixing some 64bit
artithmetic (which looks correct) in the driver, shall I simply
rebase on top of that and hope for the best? :)

Yours,
Linus Walleij
