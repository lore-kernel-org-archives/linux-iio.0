Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752614AbdIEUyC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Sep 2017 16:54:02 -0400
MIME-Version: 1.0
In-Reply-To: <CAMV_pUaXQxcD_nrJ32wi0w=sBseL1ioAhYvDt1O-HTX=0QY0aw@mail.gmail.com>
References: <1503383171-15515-1-git-send-email-s.abhisit@gmail.com>
 <20170825183520.doacpiit7mxgsk7v@rob-hp-laptop> <CAMV_pUaXQxcD_nrJ32wi0w=sBseL1ioAhYvDt1O-HTX=0QY0aw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 5 Sep 2017 15:53:40 -0500
Message-ID: <CAL_JsqK5qoBwb=07ocPyYs-4ZwJPFiAvAYVHu_KWGrzv3nOmAQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: Add support for TI LMP92001
To: Abhisit Sangjan <s.abhisit@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        jmondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Peter Rosin <peda@axentia.se>,
        =?UTF-8?Q?Jean=2DFran=C3=A7ois_Dagenais?= <jeff.dagenais@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Adriana Reus <adi.reus@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 30, 2017 at 2:58 AM, Abhisit Sangjan <s.abhisit@gmail.com> wrote:
> Hi Rob,
>
> On Sat, Aug 26, 2017 at 1:35 AM, Rob Herring <robh@kernel.org> wrote:
>>
>> On Tue, Aug 22, 2017 at 01:26:11PM +0700, s.abhisit@gmail.com wrote:
>> > From: Abhisit Sangjan <s.abhisit@gmail.com>
>> >
>> > TI LMP92001 Analog System Monitor and Controller
>> >
>> > 8-bit GPIOs.
>> > 12 DACs with 12-bit resolution.
>> > The GPIOs and DACs are shared port function with Cy function pin to
>> > take control the pin suddenly from external hardware.
>> > DAC's referance voltage selectable for Internal/External.
>> >
>> > 16 + 1 ADCs with 12-bit resolution.
>> > Built-in internal Temperature Sensor on channel 17.
>> > Windows Comparator Function is supported on channel 1-3 and 9-11 for
>> > monitoring with interrupt signal (pending to implement for interrupt).
>> > ADC's referance voltage selectable for Internal/External.
>> >
>> > Signed-off-by: Abhisit Sangjan <s.abhisit@gmail.com>
>> > ---
>> >  Documentation/ABI/testing/sysfs-bus-iio-lmp920001  |  92 ++++
>> >  .../devicetree/bindings/gpio/gpio-lmp92001.txt     |  22 +
>> >  .../bindings/iio/adc/ti-lmp92001-adc.txt           |  21 +
>> >  .../bindings/iio/dac/ti-lmp92001-dac.txt           |  35 ++
>>
>>
>> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
>> > b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
>> > new file mode 100644
>> > index 0000000..c68784e
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
>> > @@ -0,0 +1,22 @@
>> > +* Texas Instruments' LMP92001 GPIOs
>> > +
>> > +Required properties:
>> > + - compatible: Must be set to "ti,lmp92001-gpio".
>> > + - reg: i2c chip address for the device.
>>
>> No, you show this in the parent which needs to be described in
>> bindings/mtd/...
>>
>> You could have reg here too if all the registers for each sub-block are
>> in a well defined range.
>
>
> I am sorry, I do not understand.
>
>>
>>
>> > + - gpio-controller: Marks the device node as a gpio controller.
>> > + - #gpio-cells : Should be two.  The first cell is the pin number and
>> > the
>> > +  second cell is used to specify the gpio polarity:
>> > +        0 = Active high
>> > +        1 = Active low
>> > +
>> > +Example:
>> > +lmp92001@20 {
>> > +        compatible = "ti,lmp92001";
>> > +        reg = <0x20>;
>> > +
>> > +        lmp92001_gpio: lmp92001-gpio {
>>
>> gpio-controller {
>
>
> I am sorry, I do not understand. I took this idea from some things like

Read the section of the DT specification on generic node names.

And actually, it should be just "gpio". I never can remember offhand.

> Documentation/devicetree/bindings/gpio/gpio-lp3943.txt
> ------------------------------------------------------------------------------------------------------------------------------
>
> TI/National Semiconductor LP3943 GPIO controller
>
> Required properties:
>   - compatible: "ti,lp3943-gpio"
>   - gpio-controller: Marks the device node as a GPIO controller.
>   - #gpio-cells: Should be 2. See gpio.txt in this directory for a
>                  description of the cells format.
>
> Example:
> Simple LED controls with LP3943 GPIO controller
>
> &i2c4 {
>         lp3943@60 {
>                 compatible = "ti,lp3943";
>                 reg = <0x60>;
>
>                 gpioex: gpio {

As you see here, the node name for the gpio block is just "gpio".

>                         compatible = "ti,lp3943-gpio";
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                 };
>         };
> };
>
> leds {
>         compatible = "gpio-leds";
>         indicator1 {
>                 label = "indi1";
>                 gpios = <&gpioex 9 GPIO_ACTIVE_LOW>;
>         };
>
>         indicator2 {
>                 label = "indi2";
>                 gpios = <&gpioex 10 GPIO_ACTIVE_LOW>;
>                 default-state = "off";
>         };
> };
>
>>
>>
>> > +                compatible = "ti,lmp92001-gpio";
>> > +                gpio-controller;
>> > +                #gpio-cells = <2>;
>> > +        };
>> > +};
>> > diff --git
>> > a/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
>> > b/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
>> > new file mode 100644
>> > index 0000000..34d7809
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
>> > @@ -0,0 +1,21 @@
>> > +* Texas Instruments' LMP92001 ADCs
>> > +
>> > +Required properties:
>> > + - compatible: Must be set to "ti,lmp92001-adc".
>> > + - reg: i2c chip address for the device.
>>
>> Same comment here.
>>
>> > + - ti,lmp92001-adc-mode: adc operation, either continuous or
>> > single-shot.
>>
>> No standard property for this?
>
>
> I am removed this, regrading to Lukas Wunner (cc) and Adriana Reus discussed
> (cc)
> "it would be fine also as a sysfs property instead".

Depends on who would want to change this. If an end-user would at
run-time, then yes sysfs makes sense. If the h/w design dictates what
mode makes sense, then DT is fine.


>> > +Required properties:
>> > + - compatible: Must be set to "ti,lmp92001-dac".
>> > + - reg: i2c chip address for the device.
>> > + - ti,lmp92001-dac-hiz: hi-impedance control,
>> > +        1 = Forces all OUT[1:12] outputs to hi-z, 0 = normal
>>
>> Just make this a boolean (i.e. no value).
>
>
> Hi-Z will be or to cdac and it is unsigned int, u8 would be safe and work
> fine for this.
>
> lmp92001_dac_probe()
> ...
> u8 gang = 0, outx = 0, hiz = 0;
> unsigned int cdac = 0;
> ...
> of_property_read_u8(np, "ti,lmp92001-dac-hiz", &hiz);
> cdac = hiz;

Make it bool and just do this:

unsigned int cdac = of_property_read_bool(...);

or:

unsigned int cdac = of_property_read_bool(...) > 0 ? 1 : 0;

The DT property and kernel types don't have to match types.

Rob
