Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39992 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdAVMa3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 07:30:29 -0500
Subject: Re: [PATCH v3 1/4] Documentation: dt-bindings: add the Amlogic Meson
 SAR ADC documentation
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
References: <20170115224221.15510-1-martin.blumenstingl@googlemail.com>
 <20170119145822.26239-1-martin.blumenstingl@googlemail.com>
 <20170119145822.26239-2-martin.blumenstingl@googlemail.com>
 <20170121205635.4qeiqyeyjrweryrh@rob-hp-laptop>
 <CAFBinCDghzRXnzdBd0qh=LYDTpkQg7r2zdj1QE7cRKAU0fAFPQ@mail.gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, khilman@baylibre.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        carlo@caione.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4d5361a2-1343-14b9-d269-2c1b86eabb19@kernel.org>
Date: Sun, 22 Jan 2017 12:30:26 +0000
MIME-Version: 1.0
In-Reply-To: <CAFBinCDghzRXnzdBd0qh=LYDTpkQg7r2zdj1QE7cRKAU0fAFPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/01/17 23:10, Martin Blumenstingl wrote:
> Hi Rob,
> 
> thanks for reviewing this!
> 
> On Sat, Jan 21, 2017 at 9:56 PM, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Jan 19, 2017 at 03:58:19PM +0100, Martin Blumenstingl wrote:
>>> This adds the devicetree binding documentation for the SAR ADC found in
>>> Amlogic Meson SoCs.
>>> Currently only the GXBB, GXL and GXM SoCs are supported.
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  .../bindings/iio/adc/amlogic,meson-saradc.txt      | 31 ++++++++++++++++++++++
>>>  1 file changed, 31 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
>>> new file mode 100644
>>> index 000000000000..9a0bec7afc63
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
>>> @@ -0,0 +1,31 @@
>>> +* Amlogic Meson SAR (Successive Approximation Register) A/D converter
>>> +
>>> +Required properties:
>>> +- compatible:        depending on the SoC this should be one of:
>>> +                     - "amlogic,meson-gxbb-saradc" for GXBB
>>> +                     - "amlogic,meson-gxl-saradc" for GXL and GXM
>>
>> GXL and GXM should probably be 2 compatibles.
> Amlogic's ADC driver does not differentiate between GXL and GXM
> (because both SoCs are identical except the CPU and GPU cores).
> I can still introduce a separate binding for GXM if you want (better
> safe than sorry and takes less than 5 minutes) - just let me know
Probably best to do so as it's just conceivable there will be a hardware
bug in the the silicon or similar.  Also makes things a little more
'obviously correct'.

Jonathan
> 
>>> +             along with the generic "amlogic,meson-saradc"
>>> +- reg:               the physical base address and length of the registers
>>> +- clocks:    phandle and clock identifier (see clock-names)
>>> +- clock-names:       mandatory clocks:
>>> +                     - "clkin" for the reference clock (typically XTAL)
>>> +                     - "core" for the SAR ADC core clock
>>> +             optional clocks:
>>> +                     - "sana" for the analog clock
>>> +                     - "adc_clk" for the ADC (sampling) clock
>>> +                     - "adc_sel" for the ADC (sampling) clock mux
>>> +- vref-supply:       the regulator supply for the ADC reference voltage
>>> +- #io-channel-cells: must be 1, see ../iio-bindings.txt
>>> +
>>> +Example:
>>> +     saradc: adc@8680 {
>>> +             compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
>>> +             #io-channel-cells = <1>;
>>> +             reg = <0x0 0x8680 0x0 0x34>;
>>> +             clocks = <&xtal>,
>>> +                      <&clkc CLKID_SAR_ADC>,
>>> +                      <&clkc CLKID_SANA>,
>>> +                      <&clkc CLKID_SAR_ADC_CLK>,
>>> +                      <&clkc CLKID_SAR_ADC_SEL>;
>>> +             clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
>>> +     };
>>> --
>>> 2.11.0
>>>

