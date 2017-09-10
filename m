Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36358 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbdIJOps (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Sep 2017 10:45:48 -0400
Date: Sun, 10 Sep 2017 15:45:44 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: s.abhisit@gmail.com
Cc: linus.walleij@linaro.org, robh@kernel.org, lee.jones@linaro.org,
        Jonathan.Cameron@huawei.com, pmeerw@pmeerw.net, jacopo@jmondi.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        fabrice.gasnier@st.com, akinobu.mita@gmail.com,
        marek.vasut+renesas@gmail.com, jacopo+renesas@jmondi.org,
        mike.looijmans@topic.nl, peda@axentia.se, jeff.dagenais@gmail.com,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, lukas@wunner.de,
        adi.reus@gmail.com
Subject: Re: [PATCH 5/5] lmp92001: mfd: doc: Add support LMP92001
Message-ID: <20170910154544.1349162b@archlinux>
In-Reply-To: <20170830182528.9479-1-s.abhisit@gmail.com>
References: <20170830182528.9479-1-s.abhisit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 31 Aug 2017 01:25:28 +0700
s.abhisit@gmail.com wrote:

> From: Abhisit Sangjan <s.abhisit@gmail.com>
> 
> TI LMP92001 Analog System Monitor and Controller
> 
> 8-bit GPIOs.
> 12 DACs with 12-bit resolution.
> 
> The GPIOs and DACs are shared port function with Cy function pin to
> take control the pin suddenly from external hardware.
> DAC's referance voltage selectable for Internal/External.
> 
> 16 + 1 ADCs with 12-bit resolution.
> 
> Built-in internal Temperature Sensor on channel 17.
> Window Comparator Function is supported on channel 1-3 and 9-11 for
> monitoring with interrupt signal (pending to implement for interrupt).
> ADC's referance voltage selectable for Internal/External.
> 

I would break this patch up somewhat.  Have a set of DT patches separate
from any sysfs attribute documentation.

> Signed-off-by: Abhisit Sangjan <s.abhisit@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-lmp920001  | 65 ++++++++++++++++++++++
>  .../devicetree/bindings/gpio/gpio-lmp92001.txt     | 22 ++++++++
>  .../bindings/iio/adc/ti-lmp92001-adc.txt           | 20 +++++++
>  .../bindings/iio/dac/ti-lmp92001-dac.txt           | 35 ++++++++++++
>  4 files changed, 142 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-lmp920001
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-lmp920001 b/Documentation/ABI/testing/sysfs-bus-iio-lmp920001
> new file mode 100644
> index 000000000000..f0965e7d823f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-lmp920001
> @@ -0,0 +1,65 @@
> +What:           /sys/bus/iio/devices/iio:deviceX/gang
> +Date:           August 2016
> +KernelVersion:  4.12
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +                Controls the association of analog output channels OUTx with
> +                asynchronous control inputs Cy for DAC.
> +                Can be either:
> +                - "0"
> +                - "1"
> +
> +                        Cy to OUTx Assignment
> +                ----------------------------------
> +                | Cy | CDAC:GANG=0 | CDAC:GANG=1 |
> +                ----------------------------------
> +                | C1 | OUT[1:4]    | OUT[1:3]    |
> +                ----------------------------------
> +                | C2 | OUT[5:6]    | OUT[4:6]    |
> +                ----------------------------------
> +                | C3 | OUT[7:8]    | OUT[7:9]    |
> +                ----------------------------------
> +                | C4 | OUT[9:12]   | OUT[10:12]  |
> +                ----------------------------------
> +
> +What:           /sys/bus/iio/devices/iio:deviceX/outx
> +Date:           August 2016
> +KernelVersion:  4.12
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +                The pin output mode for DAC.
> +                Can be either:
> +                - "hiz" = High impedance state.
> +                - "dac" = DAC output.
> +                - "0" = Drive it to low.
> +                - "1" = Drive it to high.

Two options here - consider the hiz 0 and 1 to be powerdown
modes in which case use the standard interfaces for them, or
take the view the 0 1 choice is to allow this device to
act as a gpio chip and support that explicitly.

> +
> +What:           /sys/bus/iio/devices/iio:deviceX/vref
> +Date:           August 2016
> +KernelVersion:  4.12
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +                This is voltage reference source for DACs.
> +                Can be either:
> +                - "external"
> +                - "internal"

It is rare for userspace control of this to make sense.  Tends to be
the case that there is only one right answer for a given piece of
hardware.

> +
> +What:           /sys/devices/.../iio:deviceX/en
> +Date:           August 2016
> +KernelVersion:  4.12
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +                This is ADC Conversion Enable for each channel.
> +                Can be either:
> +                - "enable"
> +                - "disable"

If you want this fine control use the buffered interfaces rather
than sysfs.  I don't want to add this complexity to the sysfs
interface.  For sysfs if nothing outside sysfs is going on (e.g.
no buffered capture) it should be read an attribute get the answer
without having to configure other elements manually.

Also as currently documented, you only have one such file per
iio:device which seems unlikely to be what you were aiming for.


> +
> +What:           /sys/devices/.../iio:deviceX/vref

Here twice...

> +Date:           August 2016
> +KernelVersion:  4.12
> +Contact:        Abhisit Sangjan <s.abhisit@gmail.com>
> +Description:
> +                This is voltage reference source for ADCs.
> +                Can be either:
> +                - "external"
> +                - "internal"
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
> new file mode 100644
> index 000000000000..f9a18c492145
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
> @@ -0,0 +1,22 @@
> +* Texas Instruments' LMP92001 GPIOs
> +
> +Required properties:
> + - compatible: Must be set to "ti,lmp92001-gpio".
> + - reg: i2c chip address for the device.
> + - gpio-controller: Marks the device node as a gpio controller.
> + - #gpio-cells : Should be two.  The first cell is the pin number and the
> +  second cell is used to specify the gpio polarity:
> +        0 = Active high
> +        1 = Active low
> +
> +Example:
> +lmp92001@20 {
> +        compatible = "ti,lmp92001";
> +        reg = <0x20>;
> +
> +        gpio-controller {
> +                compatible = "ti,lmp92001-gpio";
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +        };
> +};
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt b/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
> new file mode 100644
> index 000000000000..4565961bf511
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
> @@ -0,0 +1,20 @@
> +* Texas Instruments' LMP92001 ADCs
> +
> +Required properties:
> + - compatible: Must be set to "ti,lmp92001-adc".
> + - reg: i2c chip address for the device.
> + - ti,lmp92001-adc-mask: bit mask for which channel is enable.
> +        0 = Off
> +        1 = On
> +
> +Example:
> +lmp92001@20 {
> +        compatible = "ti,lmp92001";
> +        reg = <0x20>;
> +
> +        lmp92001-adc {
> +                compatible = "ti,lmp92001-adc";
> +                ti,lmp92001-adc-mode = "continuous";
> +                ti,lmp92001-adc-mask = <0x00000079>;
> +        };
> +};
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt b/Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt
> new file mode 100644
> index 000000000000..882db9ca92f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt
> @@ -0,0 +1,35 @@
> +* Texas Instruments' LMP92001 DACs
> +
> +Required properties:
> + - compatible: Must be set to "ti,lmp92001-dac".
> + - reg: i2c chip address for the device.
> + - ti,lmp92001-dac-hiz: hi-impedance control,
> +        1 = Forces all OUT[1:12] outputs to hi-z, 0 = normal

Why?

> + - ti,lmp92001-dac-outx:
> +        Cy = 0, 1 = will force associated OUTx outputs to VDD
> +        Cy = 0, 0 = will force associated OUTx outputs to GND

Clashes with the above?  I'm not sure why you would want these to
be device tree bindings at all.

> + - ti,lmp92001-dac-gang: What group of Cy is governed to.
> +        -----------------------------------------
> +        |  Cy   | CDAC:GANG = 0 | CDAC:GANG = 1 |
> +        -----------------------------------------
> +        |  C1   |   OUT[1:4]    |    OUT[1:3]   |
> +        -----------------------------------------
> +        |  C2   |   OUT[5:6]    |    OUT[4:6]   |
> +        -----------------------------------------
> +        |  C3   |   OUT[7:8]    |    OUT[7:9]   |
> +        -----------------------------------------
> +        |  C4   |   OUT[9:12]   |    OUT[10:12] |
> +        -----------------------------------------

This last one is an ugly bit of hardware, so probably fine
to have in DT.
> +
> +Example:
> +lmp92001@20 {
> +        compatible = "ti,lmp92001";
> +        reg = <0x20>;
> +
> +        lmp92001-dac {
> +                compatible = "ti,lmp92001-dac";
> +                ti,lmp92001-dac-hiz  = /bits/ 8 <0>;
> +                ti,lmp92001-dac-outx = /bits/ 8 <0>;
> +                ti,lmp92001-dac-gang = /bits/ 8 <0>;
> +        };
> +};

