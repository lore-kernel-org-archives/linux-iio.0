Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34764 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbcHTCzE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Aug 2016 22:55:04 -0400
MIME-Version: 1.0
In-Reply-To: <b43674fb-6a68-de05-0f06-e1f92986705d@kernel.org>
References: <1470583330-6850-1-git-send-email-akinobu.mita@gmail.com> <b43674fb-6a68-de05-0f06-e1f92986705d@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 20 Aug 2016 11:54:42 +0900
Message-ID: <CAC5umyg831=Q4iih+4rPpdNSyEEgBKqHk00cLCd6XJ5dTw92Jw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: add ADC12130/ADC12132/ADC12138 ADC driver
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Rob,

2016-08-16 1:42 GMT+09:00 Jonathan Cameron <jic23@kernel.org>:
> On 07/08/16 16:22, Akinobu Mita wrote:
>> This adds Texas Instruments' ADC12130/ADC12132/ADC12138 12-bit plus
>> sign ADC driver.  I have tested with the ADC12138.  The ADC12130 and
>> ADC12132 are not tested but these are similar to ADC12138 except that
>> the mode programming instruction is a bit different.
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Acked-by: Rob Herring <robh@kernel.org>
> Hi,
>
> Now had time for a closer look.  A few minor bits and bobs to fix
> up highlighted inline.
>
> Looks pretty good.
>
> Jonathan
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Hartmut Knaack <knaack.h@gmx.de>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Peter Meerwald <pmeerw@pmeerw.net>
>> ---
>> * Changes from v2
>> - improve error label names
>>
>>  .../devicetree/bindings/iio/adc/ti-adc12138.txt    |  32 ++
>>  drivers/iio/adc/Kconfig                            |  12 +
>>  drivers/iio/adc/Makefile                           |   1 +
>>  drivers/iio/adc/ti-adc12138.c                      | 542 +++++++++++++++++++++
>>  4 files changed, 587 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
>>  create mode 100644 drivers/iio/adc/ti-adc12138.c
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
>> new file mode 100644
>> index 0000000..3a11d2a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
>> @@ -0,0 +1,32 @@
>> +* Texas Instruments' ADC12130/ADC12132/ADC12138
>> +
>> +Required properties:
>> + - compatible: Should be one of
>> +     * "ti,adc12130"
>> +     * "ti,adc12132"
>> +     * "ti,adc12138"
>> + - reg: SPI chip select number for the device
>> + - interrupts: Should contain interrupt for EOC (end of conversion)
>> + - clocks: phandle to conversion clock input
>> + - spi-max-frequency: Definision as per
>> +     Documentation/devicetree/bindings/spi/spi-bus.txt
>> + - vref-p-supply: The regulator supply for positive analog voltage reference
>> +
>> +Optional properties:
>> + - vref-n-supply: The regulator supply for negative analog voltage reference
>> +     If not specified, this is assumed to be analog ground.
> This is novel. Documented in the datasheet as a negative reference which
> must be positive (greater than 0) for it to work well.
>
> Intersting question on whether this should be optional. Easy enough to
> provided a fixed regulator at 0V afterall.
>
>
>> + - acquisition-time: The number of conversion clock periods for the S/H's
>> +     acquisition time.  Should be one of 6, 10, 18, 34.  If not specified,
>> +     default value of 10 is used.
> Should this be a ti specific parameter.  Not sure.

Is it better to change this parameter to "ti,acquisition-time" ?

> I'd also add a note here about why one would set this to other than the
> default (source impedance etc).
>
>
>> +
>> +Example:
>> +adc@0 {
>> +     compatible = "ti,adc12138";
>> +     reg = <0>;
>> +     interrupts = <28 IRQ_TYPE_EDGE_RISING>;
>> +     interrupt-parent = <&gpio1>;
>> +     clocks = <&cclk>;
>> +     vref-p-supply = <&ldo4_reg>;
>> +     spi-max-frequency = <5000000>;
>> +     acquisition-time = <6>;
>> +};
