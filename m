Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34575 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdAQOfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2017 09:35:23 -0500
Received: by mail-qt0-f172.google.com with SMTP id l7so160714216qtd.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2017 06:35:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161227065814.GC10531@minitux>
References: <1481842118-14095-1-git-send-email-linus.walleij@linaro.org> <20161227065814.GC10531@minitux>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Jan 2017 15:35:22 +0100
Message-ID: <CACRpkdZ2eqpFhBjbzaDu2kAKE0_4Q15Kb-p_TnnXGrox42-QjA@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rama Krishna Phani A <rphani@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Dec 27, 2016 at 7:58 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Thu 15 Dec 14:48 PST 2016, Linus Walleij wrote:

> I gave this a spin on one of my APQ8064 devices - with PM8921 - and I
> can do measurements.

Nice :) I hope the v3 patchset also gives something, hopefully more.

> Several of the channels do give me reasonable readings. But the channels
> in PM8921 are different than PM8058, so it looks like we need additional
> prescales defined. Further more, the 8921 has several different
> thermo-related channels, each with their own (post-)scaling function.

I hope I have fixed this for all variants in the v3 version.

> And lastly it seems that I have 2 thermo-channels on "mpp amux", but I'm
> still confused to how that is supposed to work in the downstream code -
> I will need to investigate this further.
>
> One of the channels defined in my APQ8064 device measures
> ADC_MPP_1_AMUX5, a lookup table is used to convert the measured value to
> a temperature. As the table depends on an external thermistor, which
> seems to differ between products a number of lookup tables exists - with
> 156 data points each.
(...)
> On my 8064 device I have 6 different temperatures (2 coming from amux'ed
> mpp channels). They all have different lookup tables, which seems
> calibrated based on some external resistor.

Rama Krishna cleared it up a bit, then I have tried to make it even
clearer.

Essentially all MPP (multi-purpose pins indeed) can have any random
analog value coming in, but there are some layers of enums on top
of the actual hardware channels confusing things a bit.

Some MPPs are used for reading battery temperature and system
temperature in some systems, but this is essentially a board-specific
use of a general purpose ADC and need to be above the driver, however
I tried to encode the most typical usecases a bit in the different PMIC
channel tables, so that MPP8 is usually set up a temperature channel.

We need additional bindings to specify conversion functions from the
device tree but that can be made on top of this patch set as an
expansion.

The approach chosen here is that this ADC driver should present
"processed" (scaled etc) values, and to achieve this the scaling is
done directly on the raw values read from the ADC, which are
first scaled to uV from calibration and then scaled to e.g. a
temperature.

This is all clearer after Rama Krishna's patches.

>> +     /* We strictly require this voltage */
>> +     ret = regulator_set_voltage(adc->vref, 2200000, 2200000);
>
> On 8064 the reference is L14 and it's at 1.8V, so this fails for me.

I have removes this hard setting of voltage.

Yours,
Linus Walleij
