Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:45475 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbdKLBfr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Nov 2017 20:35:47 -0500
MIME-Version: 1.0
In-Reply-To: <CAFBinCB=2pb9dZkpSqdVAiumkSCzgaW0oejftjZNP7aYbiQJuw@mail.gmail.com>
References: <20171107140942.29243-1-yixun.lan@amlogic.com> <CAFBinCB=2pb9dZkpSqdVAiumkSCzgaW0oejftjZNP7aYbiQJuw@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 12 Nov 2017 02:35:26 +0100
Message-ID: <CAFBinCBJck9p8dDr-tmzFVyCk0Udfh4pB0z8c_HmJ4T+g20tQw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] fix the clock setting for SAR ADC
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Yixun,

On Tue, Nov 7, 2017 at 10:36 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> Hi Yixun,
>
> On Tue, Nov 7, 2017 at 3:09 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:
>> patch [1/4]:
>>   Fix wrong SARADC/SANA clock gate bit in Meson-GXBB/GXL,
>> the published datasheets[4] also has wrong description about this.
>>   This patch should be explicitly merged *before* other patches.
>>
>> patch [2-4/4]:
>>   Drop the "sana" clock from SAR ADC module,
> I agree with Jerome that patch 2/4 should be applied last.
> when I wrote the driver I couldn't get it to work on my GXBB board
> (which unfortunately has died since then) because the clocks were
> disabled (they weren't enabled by the bootloader). people who are
> using an old .dtb would get the same problem again until the clock
> driver is merged
>
>>   From the hardware perspective, the SAR ADC module doesn't
>> require "sana" clock to wrok. This should apply to all SoC,
>> including meson6,8, GXBB, GXL..
> thank you for clarifying this!
>
>> Note: the whole patchset series has been tested at GXL-P212 board,
>> we haven't got any meson6,8 board to test, so I would appreciate
>> if someone (Martin?) could help to confirm it works there.
> I can test this on a Meson8b and a Meson8m2 board on the weekend -
> I'll let you know about the results
the ADC still works fine with this series applied on my Meson8m2 board
as well as my Meson8b EC-100
I added my "Reviewed-by" and "Acked-by" to the corresponding patches
(with a change request on the .dts patch)

Thank you for fixing this!


Regards
Martin
