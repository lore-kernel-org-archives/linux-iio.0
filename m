Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36707 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbdCYS2Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 14:28:25 -0400
MIME-Version: 1.0
In-Reply-To: <231f1fef-e947-3461-2e5b-99d80abfa73a@kernel.org>
References: <20170325162938.28659-1-martin.blumenstingl@googlemail.com>
 <20170325162938.28659-3-martin.blumenstingl@googlemail.com> <231f1fef-e947-3461-2e5b-99d80abfa73a@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 25 Mar 2017 19:28:03 +0100
Message-ID: <CAFBinCDVLZdBEX=UnGKFCkRF02YYx4hoRw54+AcwAku9zGjvaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: meson-saradc: add Meson8b SoC compatibility
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, carlo@caione.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 25, 2017 at 7:13 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 25/03/17 16:29, Martin Blumenstingl wrote:
>> Meson GX SoCs however use some magic bits to prevent simultaneous (=
>> conflicting, because only consumer should use the FIFO buffer with the
>> ADC results) usage by the Linux kernel and the bootloader (the BL30
>> bootloader uses the SAR ADC to read the CPU temperature).
>> This patch changes guards all BL30 functionality so it is skipped on
>> SoCs which don't have it. Since the hardware itself doesn't know whether
>> BL30 is available the internal meson_sar_adc_data is extended so this
>> information can be provided per of_device_id.data inside the driver.
>>
>> Additionally the clocks "adc_clk" and "adc_sel" are not provided by the
>> clock-controller itself. "adc_sel" is not available at all. "adc_clk"
>> is provided by the SAR ADC IP block itself on Meson8b (and earlier).
>> This is already supported by the meson_saradc driver.
>>
>> Finally a new of_device_id for the Meson8b SoC is added so it can be
>> wired up in the corresponding DT.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Looks sensible to me. Just fix those bits from Peter and we'll let it sit
> a few days on the list to see if anyone else wants to chip in.
OK, we'll have to wait for one of the DT-maintainers ACK (on the other
patch) anyways, so I'll re-spin this in a week or so and fix
everything that has come up until then
