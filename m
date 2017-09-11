Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33567 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdIKV6n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Sep 2017 17:58:43 -0400
Date: Mon, 11 Sep 2017 16:58:41 -0500
From: Rob Herring <robh@kernel.org>
To: s.abhisit@gmail.com
Cc: linus.walleij@linaro.org, lee.jones@linaro.org,
        Jonathan.Cameron@huawei.com, pmeerw@pmeerw.net, jacopo@jmondi.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        fabrice.gasnier@st.com, akinobu.mita@gmail.com,
        marek.vasut+renesas@gmail.com, jacopo+renesas@jmondi.org,
        mike.looijmans@topic.nl, peda@axentia.se, jeff.dagenais@gmail.com,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, lukas@wunner.de,
        adi.reus@gmail.com
Subject: Re: [PATCH 5/5] lmp92001: mfd: doc: Add support LMP92001
Message-ID: <20170911215841.jaaipbdcf5hchjck@rob-hp-laptop>
References: <20170830182528.9479-1-s.abhisit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170830182528.9479-1-s.abhisit@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 31, 2017 at 01:25:28AM +0700, s.abhisit@gmail.com wrote:
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
> Signed-off-by: Abhisit Sangjan <s.abhisit@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-lmp920001  | 65 ++++++++++++++++++++++
>  .../devicetree/bindings/gpio/gpio-lmp92001.txt     | 22 ++++++++

As Jonathan said, please split.

>  .../bindings/iio/adc/ti-lmp92001-adc.txt           | 20 +++++++
>  .../bindings/iio/dac/ti-lmp92001-dac.txt           | 35 ++++++++++++
>  4 files changed, 142 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-lmp920001
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt

[...]

> diff --git a/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
> new file mode 100644
> index 000000000000..f9a18c492145
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
> @@ -0,0 +1,22 @@
> +* Texas Instruments' LMP92001 GPIOs
> +

Need to state what this is a child of and refer to that binding doc. 
Same for the others.

> +Required properties:
> + - compatible: Must be set to "ti,lmp92001-gpio".
> + - reg: i2c chip address for the device.

? That's for the parent.

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

Should be "gpio {"

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

adc {

> +                compatible = "ti,lmp92001-adc";
> +                ti,lmp92001-adc-mode = "continuous";

Not documented and I believe we're going to add a common property for 
this.

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
> + - ti,lmp92001-dac-outx:
> +        Cy = 0, 1 = will force associated OUTx outputs to VDD
> +        Cy = 0, 0 = will force associated OUTx outputs to GND
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
> +
> +Example:
> +lmp92001@20 {
> +        compatible = "ti,lmp92001";
> +        reg = <0x20>;
> +
> +        lmp92001-dac {

dac {

> +                compatible = "ti,lmp92001-dac";
> +                ti,lmp92001-dac-hiz  = /bits/ 8 <0>;
> +                ti,lmp92001-dac-outx = /bits/ 8 <0>;
> +                ti,lmp92001-dac-gang = /bits/ 8 <0>;
> +        };
> +};
> -- 
> 2.13.0
> 
