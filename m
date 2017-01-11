Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33783 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936886AbdAKMlJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2017 07:41:09 -0500
Subject: Re: [PATCH V4] iio: adc: Add Renesas GyroADC driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20170110213338.15855-1-marek.vasut@gmail.com>
 <CAMuHMdW+ayhOgEKjBxYxKq7tVr24fM_Ph=Hd-SRtt1e68e4mcQ@mail.gmail.com>
Cc: linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <14e8b7dc-546d-8f8d-0964-d111e94e1c3f@gmail.com>
Date: Wed, 11 Jan 2017 13:35:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW+ayhOgEKjBxYxKq7tVr24fM_Ph=Hd-SRtt1e68e4mcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/11/2017 09:38 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> Please CC linux-renesas-soc for drivers for (parts of) Renesas ARM SoCs.

I just registered and will CC from now on.

> On Tue, Jan 10, 2017 at 10:33 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> Add IIO driver for the Renesas RCar GyroADC block. This block is a
>> simple 4/8-channel ADC which samples 12/15/24 bits of data every
>> cycle from all channels.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> ---
>> V2: - Spelling fixes
>>     - Rename the driver source file to rcar-gyroadc
>>     - Rework the channel sample width handling
>>     - Use iio_device_claim_mode_direct()
>>     - Rename "renesas,rcar-gyroadc" to "renesas,r8a7791-gyroadc" and
>>       rename "renesas,rcar-gyroadc-r8a7792" to "renesas,r8a7792-gyroadc"
>>       to match the new naming scheme (WARNING: scif uses the old one!)
>>     - Switch to using regulators for channel voltage reference, add new
>>       properties renesas,gyroadc-vref-chN-supply for N in 0..7
>>     - Handle vref regulators as optional to, make channels without
>>       vref regulator return EINVAL on read.
>>     - Fix module license to GPL
>>     - Drop interrupt.h include
>>     - Rename clk to iclk
>>     - Rename RCar to R-Car
>>     - Rework the invalid mode handling
>>     - Don't print error message on EPROBE_DEFER
>>     - Drop fclk handling, use runtime PM for that instead
>> V3: - More R-Car spelling fixes
>>     - Flip checks for V2H, since that's the only one that has
>>       interrupt registers
>>     - Replace if-else statement with switch statement in init_mode
>>     - Use unsigned types where applicable
>>     - Rework timing calculation slightly to drop if-else block
>>     - Use DIV_ROUND_CLOSEST
>> V4: - Add renesas,rcar-gyroadc fallback compatible string into the bindings
>>     - Rework the ADC bindings to use per-channel subdevs
>>     - Support more compatible ADC chips
>> ---
>>  .../bindings/iio/adc/renesas,gyroadc.txt           |  70 +++
>>  MAINTAINERS                                        |   6 +
>>  drivers/iio/adc/Kconfig                            |  10 +
>>  drivers/iio/adc/Makefile                           |   1 +
>>  drivers/iio/adc/rcar-gyroadc.c                     | 531 +++++++++++++++++++++
>>  5 files changed, 618 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>>  create mode 100644 drivers/iio/adc/rcar-gyroadc.c
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>> new file mode 100644
>> index 000000000000..2dcea9c8895b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
>> @@ -0,0 +1,70 @@
>> +* Renesas RCar GyroADC device driver
>> +
>> +Required properties:
>> +- compatible:  Should be "renesas,<chip>-gyroadc", "renesas,rcar-gyroadc".
>> +               Use "renesas,r8a7792-gyroadc" for a GyroADC with interrupt
>> +               block found in R8A7792.
>> +- reg:         Address and length of the register set for the device
>> +- clocks:      References to all the clocks specified in the clock-names
>> +               property as specified in
>> +               Documentation/devicetree/bindings/clock/clock-bindings.txt.
>> +- clock-names: Shall contain "fck" and "if". The "fck" is the GyroADC block
>> +               clock, the "if" is the interface clock.
>> +- power-domains: Must contain a reference to the PM domain, if available.
>> +- #address-cells: Should be <1> (setting for the subnodes)
>> +- #size-cells: Should be <0> (setting for the subnodes)
>> +
>> +Sub-nodes:
>> +Optionally you can define subnodes which define the reference voltage
> 
> which defined the connected ADC type and the reference voltage

Thanks for spotting this.

>> +for the analog inputs.
> 
> "channels", to match the wording below?

Yes

>> +
>> +Required properties for subnodes:
>> +- compatible:  Should be either of:
>> +               "fujitsu,mb88101a"
>> +                       - Fujitsu MB88101A compatible mode,
>> +                         12bit sampling, 4 channels
> 
> For this one, we have to find a better representation in DT.
> Unlike the other two types, the MB88101A is a 4-channel ADC, and thus only
> a single instance is supported, providing 4 channels.
> Hence for MB88101A I suggest to just have a single node "adc", without a
> unit address or "reg" property.

Hmmmmmm, this doesn't look quite right and it does make the binding
complicated and the MB88101A into quite the special snow flake. Also,
what if you have the MB88101A channels 0 and 1 connected only to ie.
gyroadc channels 2 and 3? What about something like:

adc2: adc@2 {
 reg = <0>;
 compatible = "fujitsu,mb88101a";
 vref-supply = <&vref_fujitsu_mb88101a>;
};

adc3: adc@3 {
 reg = <3>;
 renesas,adc-master = <&adc2>;
};

>> +               "ti,adcs7476" or "ti,adc121" or "adi,ad7476"
>> +                       - TI ADCS7476 / TI ADC121 / ADI AD7476 compatible mode,
>> +                         15bit sampling, 8 channels
> 
> ADCS7476 are single channel ADCs.
> "up to 8 channels can be connected"?

Fixed all

-- 
Best regards,
Marek Vasut
