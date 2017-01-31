Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35925 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdAaR3i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 12:29:38 -0500
Date: Tue, 31 Jan 2017 17:20:53 +0000
In-Reply-To: <CACRpkdYZzPWyyAmr8jTfRQuSADXkFoZpehhEVFLAfVnXmum4aw@mail.gmail.com>
References: <20170117142515.10578-1-linus.walleij@linaro.org> <20170117142515.10578-3-linus.walleij@linaro.org> <cab36d80-53ba-bc43-cf08-6aafb56c737a@kernel.org> <e9a2162e-65e9-7276-25f9-4597da1125a3@kernel.org> <CACRpkdYZzPWyyAmr8jTfRQuSADXkFoZpehhEVFLAfVnXmum4aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH 3/3 v3] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
To: Linus Walleij <linus.walleij@linaro.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
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
Message-ID: <787406E0-A1F1-4B86-968C-3925715693FD@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 31 January 2017 09:48:31 GMT+00:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>On Mon, Jan 30, 2017 at 9:15 PM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>
>> Still outstanding bits and bobs in here so not taking this patch for
>> now.  Will probably do a last sweep of patches that are nearly
>> ready mid week as need to do pull before weekend to be sure of
>> making the next merge window (i.e. ones I've reviewed already but
>> have minor outstanding bits like this one).
>
>Sure, didn't mean you to apply this one, I was planning to respin it.
>Just eager about patches 1&2 so I decrease my patch stack.
*Laughs*

I wouldn't normally take a big rework like 2 without a patch making use of it.  Anyhow
 should be fine as changes were all trivial in this one.

Thanks
>
>Yours,
>Linus Walleij

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
