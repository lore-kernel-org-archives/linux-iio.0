Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] iio: sun4i-lradc: Add binding documentation
To: Chen-Yu Tsai <wens@csie.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1467406855-9677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CAGb2v66PzgVqVGxs4FSQkkX=2hX42UmftahOgJmepv4wA-mwnw@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-iio@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring
 <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <777642fd-5e77-206f-a503-23bbf187e6f3@redhat.com>
Date: Sat, 2 Jul 2016 11:32:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAGb2v66PzgVqVGxs4FSQkkX=2hX42UmftahOgJmepv4wA-mwnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 02-07-16 11:12, Chen-Yu Tsai wrote:
> Hi,
>
> On Sat, Jul 2, 2016 at 5:00 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> Document the bindings for the Allwinner LRADC.
>
> We already have Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> and I'm pretty sure Hans (CC-ed) argued that this is not a generic ADC
> block.

Right, this block is used on many tablets and some dev boards to
provide buttons (as in the hid type) and the block is designed for
this purpose, giving an irq when the adc level crosses a certain
threshold.

Sure it can be used in a more generic way, but that is not its
primary goal.

So any generic purpose adc driver must not break the current
use-case (which is already used in mainline kernel dts files
in plenty of cases).

I believe that the best way to deal with this is to add an
"allwinner,general-purpose-mode" flag to the existing binding
(as well as document general purpose mode in the existing
binding rather then in a new binding doc).

That seems to be the right thing to do purely looking at this
from a dt binding pov.

For the implementation of this we can simpy have 2 drivers,
then both drivers can check the flag and if present return
-ENODEV from the existing input driver and likewise if not
present return -ENODEV from the iio driver.

We may actually use a similar solution for the touchscreen
controller which can also be alternatively used as a generic
purpose adc.

Regards,

Hans



> Any plans to reconcile the different bindings?
>
> Thanks
> ChenYu
>
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> ---
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: devicetree@vger.kernel.org
>>
>>  .../devicetree/bindings/iio/adc/sun4i-lradc.txt       | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt b/Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt
>> new file mode 100644
>> index 000000000000..c75a6067b8a5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt
>> @@ -0,0 +1,19 @@
>> +Allwinner sun4i Low Resolution ADC
>> +----------------------------------
>> +
>> +Required properties:
>> + - compatible: "allwinner,sun4i-a10-lradc"
>> + - reg: mmio address range of the chip
>> + - interrupts: interrupt to which the chip is connected
>> + - vref-supply: powersupply for the lradc reference voltage
>> + - #io-channel-cells = <1>; As ADC has multiple outputs
>> +
>> +Example:
>> +
>> +       lradc: lradc@01c22800 {
>> +               compatible = "allwinner,sun4i-a10-lradc";
>> +               reg = <0x01c22800 0x100>;
>> +               interrupts = <31>;
>> +               vref-supply = <&reg_vcc3v0>;
>> +               #io-channel-cells = <1>;
>> +       };
>> --
>> 2.8.1
>>
