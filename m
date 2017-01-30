Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58843 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753040AbdA3ULq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 15:11:46 -0500
Subject: Re: [PATCH 2/3 v3] iio: adc: break out common code from SPMI VADC
To: Linus Walleij <linus.walleij@linaro.org>
References: <20170117142515.10578-1-linus.walleij@linaro.org>
 <20170117142515.10578-2-linus.walleij@linaro.org>
 <48e07081-2088-6ffe-c58e-ac5a561b6a00@kernel.org>
 <CACRpkdZZqW6DYXuR3ShT3NW+qpTvniEBVtnWsm11J1taYzLd4Q@mail.gmail.com>
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
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a28bbe67-8334-5d14-029e-5c4ec181586f@kernel.org>
Date: Mon, 30 Jan 2017 20:11:43 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdZZqW6DYXuR3ShT3NW+qpTvniEBVtnWsm11J1taYzLd4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/01/17 09:15, Linus Walleij wrote:
> On Sat, Jan 21, 2017 at 2:37 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 17/01/17 14:25, Linus Walleij wrote:
>>> The SPMI VADC and the earlier XOADC share a subset of
>>> common code, so to be able to use the same code in both
>>> drivers, we break out a separate file with the common code,
>>> prefix exported functions that are no longer static with
>>> qcom_* and bake an object qcom-vadc.o that contains both
>>> files: qcom-vadc-common.o and qcom-spmi-vadc.o.
>>>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-arm-msm@vger.kernel.org
>>> Cc: Ivan T. Ivanov <iivanov.xz@gmail.com>
>>> Cc: Andy Gross <andy.gross@linaro.org>
>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Cc: Rama Krishna Phani A <rphani@codeaurora.org>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> This looks like fairly straight forward refacting to me.  Rama, could you
>> take a look at this and perhaps test that no breakage has slipped in?
>>
>> I'd like at least one tested-by on this for the previously supported parts
>> (that could be Linus if he has one!)
> 
> I am waiting for a serial cable for the APQ8064 Nexus 7 so no
> test base so far. I would have to rely on Björn for this.
> 
> I think this patch is safe to merge though.
Fair enough. Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,


Jonathan

> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

