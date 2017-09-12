Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170912110923.0f80c116@archlinux>
References: <20170830182528.9479-1-s.abhisit@gmail.com> <20170911215841.jaaipbdcf5hchjck@rob-hp-laptop>
 <20170912110923.0f80c116@archlinux>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Sep 2017 08:45:23 -0500
Message-ID: <CAL_Jsq+CVoQskbcSwJgnV1ov8V+8s-sJxMhwu2A6BvVTRdytpg@mail.gmail.com>
Subject: Re: [PATCH 5/5] lmp92001: mfd: doc: Add support LMP92001
To: Jonathan Cameron <jic23@kernel.org>
Cc: Abhisit Sangjan <s.abhisit@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Peter Meerwald <pmeerw@pmeerw.net>, jmondi <jacopo@jmondi.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Fabrice Gasnier <fabrice.gasnier@st.com>,
	"akinobu.mita@gmail.com" <akinobu.mita@gmail.com>, Marek Vasut <marek.vasut+renesas@gmail.com>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>, Mike Looijmans <mike.looijmans@topic.nl>,
	Peter Rosin <peda@axentia.se>, =?UTF-8?Q?Jean=2DFran=C3=A7ois_Dagenais?= <jeff.dagenais@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Adriana Reus <adi.reus@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 12, 2017 at 5:09 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 11 Sep 2017 16:58:41 -0500
> Rob Herring <robh@kernel.org> wrote:
>
>> On Thu, Aug 31, 2017 at 01:25:28AM +0700, s.abhisit@gmail.com wrote:
>> > From: Abhisit Sangjan <s.abhisit@gmail.com>
>> >
>> > TI LMP92001 Analog System Monitor and Controller
>> >
>> > 8-bit GPIOs.
>> > 12 DACs with 12-bit resolution.
>> >
>> > The GPIOs and DACs are shared port function with Cy function pin to
>> > take control the pin suddenly from external hardware.
>> > DAC's referance voltage selectable for Internal/External.
>> >
>> > 16 + 1 ADCs with 12-bit resolution.
>> >
>> > Built-in internal Temperature Sensor on channel 17.
>> > Window Comparator Function is supported on channel 1-3 and 9-11 for
>> > monitoring with interrupt signal (pending to implement for interrupt).
>> > ADC's referance voltage selectable for Internal/External.
>> >
>> > Signed-off-by: Abhisit Sangjan <s.abhisit@gmail.com>
>> > ---
>> >  Documentation/ABI/testing/sysfs-bus-iio-lmp920001  | 65 ++++++++++++++++++++++
>> >  .../devicetree/bindings/gpio/gpio-lmp92001.txt     | 22 ++++++++
>>
>> As Jonathan said, please split.
>>
>> >  .../bindings/iio/adc/ti-lmp92001-adc.txt           | 20 +++++++
>> >  .../bindings/iio/dac/ti-lmp92001-dac.txt           | 35 ++++++++++++
>> >  4 files changed, 142 insertions(+)
>> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-lmp920001
>> >  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
>> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
>> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt
>>
>> [...]
>>
>> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
>> > new file mode 100644
>> > index 000000000000..f9a18c492145
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
>> > @@ -0,0 +1,22 @@
>> > +* Texas Instruments' LMP92001 GPIOs
>> > +
>>
>> Need to state what this is a child of and refer to that binding doc.
>> Same for the others.
>>
>> > +Required properties:
>> > + - compatible: Must be set to "ti,lmp92001-gpio".
>> > + - reg: i2c chip address for the device.
>>
>> ? That's for the parent.
>>
>> > + - gpio-controller: Marks the device node as a gpio controller.
>> > + - #gpio-cells : Should be two.  The first cell is the pin number and the
>> > +  second cell is used to specify the gpio polarity:
>> > +        0 = Active high
>> > +        1 = Active low
>> > +
>> > +Example:
>> > +lmp92001@20 {
>> > +        compatible = "ti,lmp92001";
>> > +        reg = <0x20>;
>> > +
>> > +        gpio-controller {
>>
>> Should be "gpio {"
>>
>> > +                compatible = "ti,lmp92001-gpio";
>> > +                gpio-controller;
>> > +                #gpio-cells = <2>;
>> > +        };
>> > +};
>> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt b/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
>> > new file mode 100644
>> > index 000000000000..4565961bf511
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
>> > @@ -0,0 +1,20 @@
>> > +* Texas Instruments' LMP92001 ADCs
>> > +
>> > +Required properties:
>> > + - compatible: Must be set to "ti,lmp92001-adc".
>> > + - reg: i2c chip address for the device.
>> > + - ti,lmp92001-adc-mask: bit mask for which channel is enable.
>> > +        0 = Off
>> > +        1 = On
>> > +
>> > +Example:
>> > +lmp92001@20 {
>> > +        compatible = "ti,lmp92001";
>> > +        reg = <0x20>;
>> > +
>> > +        lmp92001-adc {
>>
>> adc {
>>
>> > +                compatible = "ti,lmp92001-adc";
>> > +                ti,lmp92001-adc-mode = "continuous";
>>
>> Not documented and I believe we're going to add a common property for
>> this.
>
> Possibly.  I'm not keen on it being explicitly controlled in general.
> It isn't a feature of the hardware in this case (I think) and as userspace
> control it is very hard for userspace to know what to do with it -
> normally it is better to put sufficient smarts in the driver to handle
> this transparently from either dt or userspace abi point of view.

That certainly makes sense.

No property or common property. Your choice. :)

Rob
