Return-Path: <SRS0=c8Cb=MH=gmail.com=robherring2@kernel.org>
Message-ID: <5baa1b01.1c69fb81.f0d8f.30c6@mx.google.com>
From: Rob Herring <robh@kernel.org>
To: Song Qiang <songqiang1304521@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180920131340.6699-1-songqiang1304521@gmail.com>
Date: Mon, 24 Sep 2018 15:23:52 -0700
List-ID: <linux-iio@vger.kernel.org>

On Thu, Sep 20, 2018 at 09:13:40PM +0800, Song Qiang wrote:
> PNI RM3100 magnetometer is a high resolution, large signal immunity
> magnetometer, composed of 3 single sensors and a processing chip.
> PNI is currently not in the vendors list, so this is also adding it.
> 
> Following functions are available:
>  - Single-shot measurement from
>    /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
>  - Triggerd buffer measurement.
>  - Both i2c and spi interface are supported.
>  - Both interrupt and polling measurement is supported, depands on if
>    the 'interrupts' in DT is declared.
> 
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> ---
>  .../bindings/iio/magnetometer/pni,rm3100.txt  |  57 +++
>  .../devicetree/bindings/vendor-prefixes.txt   |   1 +

Please split bindings to separate patch.


>  MAINTAINERS                                   |  10 +
>  drivers/iio/magnetometer/Kconfig              |  29 ++
>  drivers/iio/magnetometer/Makefile             |   4 +
>  drivers/iio/magnetometer/rm3100-core.c        | 399 ++++++++++++++++++
>  drivers/iio/magnetometer/rm3100-i2c.c         |  66 +++
>  drivers/iio/magnetometer/rm3100-spi.c         |  72 ++++
>  drivers/iio/magnetometer/rm3100.h             |  90 ++++
>  9 files changed, 728 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
>  create mode 100644 drivers/iio/magnetometer/rm3100-core.c
>  create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
>  create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
>  create mode 100644 drivers/iio/magnetometer/rm3100.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> new file mode 100644
> index 000000000000..d0d2063e943f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> @@ -0,0 +1,57 @@
> +* PNI RM3100 9-axis magnetometer sensor
> +
> +I2C Bus:
> +
> +Required properties:
> +
> +- compatible : should be "pni,rm3100-i2c"
> +- reg : the I2C address of the magnetometer
> +
> +Optional properties:
> +
> +- interrupts: data ready (DRDY) from the chip.
> +  The interrupts can be triggered on rising edges.
> +
> +	Refer to interrupt-controller/interrupts.txt for generic
> +	interrupt client node bindings.
> +
> +- pinctrl-*: pinctrl setup for DRDY line.
> +
> +Example:
> +
> +rm3100: rm3100@20 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rm3100_pins>;
> +
> +	compatible = "pni,rm3100-i2c";
> +	reg = <0x20>;
> +	interrupt-parent = <&gpio0>;
> +	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
> +};
> +
> +SPI Bus:
> +
> +Required properties:
> +
> +- compatible : should be "pni,rm3100-spi"
> +- reg : address of sensor, usually 0 or 1.
> +
> +Optional properties:
> +
> +- interrupts: data ready (DRDY) from the chip.
> +  The interrupts can be triggered on rising edges.
> +
> +	Refer to interrupt-controller/interrupts.txt for generic
> +	interrupt client node bindings.
> +
> +- pinctrl-*: pinctrl setup for DRDY line, depands on archtechture.
> +
> +Example:
> +
> +rm3100: rm3100@0{
> +	compatible = "pni,rm3100-spi";
> +	reg = <0>;
> +
> +	interrupt-parent = <&gpio0>;
> +	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 41f0b97eb933..5bf3395fe9ae 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -288,6 +288,7 @@ pine64	Pine64
>  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
>  plathome	Plat'Home Co., Ltd.
>  plda	PLDA
> +pni     PNI

PNI doesn't stand for something?

>  portwell	Portwell Inc.
>  poslab	Poslab Technology Co., Ltd.
>  powervr	PowerVR (deprecated, use img)
