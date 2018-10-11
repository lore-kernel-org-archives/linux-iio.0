Return-Path: <SRS0=88Pu=MX=konsulko.com=matt.ranostay@kernel.org>
MIME-Version: 1.0
References: <1539198063-29825-1-git-send-email-matthew.weber@rockwellcollins.com>
 <1539198063-29825-2-git-send-email-matthew.weber@rockwellcollins.com>
In-Reply-To: <1539198063-29825-2-git-send-email-matthew.weber@rockwellcollins.com>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Thu, 11 Oct 2018 09:26:32 +0800
Message-ID: <CAJCx=gk=-0_MDHQrJ69-UrX5fMGjJ5vKTf-C_AMA0izO+4CbdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio:temperature:max31856:Add device tree bind info
To: matthew.weber@rockwellcollins.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, paresh.chaudhary@rockwellcollins.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 11, 2018 at 3:10 AM Matt Weber
<matthew.weber@rockwellcollins.com> wrote:
>
> From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
>
> This patch added device tree binding info for MAX31856 driver.
>
> Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
> ---
>  .../bindings/iio/temperature/max31856.txt          | 36 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> new file mode 100644
> index 0000000..fb1dfca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> @@ -0,0 +1,36 @@
> +Maxim MAX31856 thermocouple support
> +
> +https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
> +
> +Required properties:
> +       - compatible: must be "max31856"
> +       - reg: SPI chip select number for the device
> +       - spi-max-frequency: As per datasheet max. supported freq is 5000000
> +       - spi-cpha: must be defined for max31856 to enable SPI mode 1
> +       - type: Type of thermocouple (By default is K-Type)
> +       /*
Remove the comment block, and just indent the possibilities accordingly.

- Matt
> +         TYPE_B = 0x00
> +         TYPE_E = 0x01
> +         TYPE_J = 0x02
> +         TYPE_K = 0x03
> +         TYPE_N = 0x04
> +         TYPE_R = 0x05
> +         TYPE_S = 0x06
> +         TYPE_T = 0x07
> +         VMODE_G8 = 0x08
> +         VMODE_G32 = 0x12
> +        */
> +
> +       Refer to spi/spi-bus.txt for generic SPI slave bindings.
> +
> +Optional properties:
> +       - one-shot: Enable one-shot Conversion mode (By default mode is auto)
> +
> + Example:
> +       max31856@0 {
> +               compatible = "max31856";
> +               reg = <0>;
> +               spi-max-frequency = <5000000>;
> +               spi-cpha;
> +               type = <0x03>;
> +       };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd9a83d..6482ae8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7161,6 +7161,7 @@ MAX31856 IIO DRIVER
>  M:     Matthew Weber <matthew.weber@rockwellcollins.com>
>  S:     Maintained
>  F:     drivers/iio/temperature/max31856.c
> +F:     Documentation/devicetree/bindings/iio/temperature/max31856.txt
>
>  IIO UNIT CONVERTER
>  M:     Peter Rosin <peda@axentia.se>
> --
> 1.9.1
>
