Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:47084 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeJ2Asp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Oct 2018 20:48:45 -0400
Date: Sun, 28 Oct 2018 16:03:41 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: linux-iio@vger.kernel.org,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Subject: Re: [PATCH v4 2/2] iio:temperature:max31856:Add device tree bind
 info
Message-ID: <20181028160341.04a2f106@archlinux>
In-Reply-To: <1540489365-3464-2-git-send-email-matthew.weber@rockwellcollins.com>
References: <1540489365-3464-1-git-send-email-matthew.weber@rockwellcollins.com>
        <1540489365-3464-2-git-send-email-matthew.weber@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 Oct 2018 12:42:45 -0500
Matt Weber <matthew.weber@rockwellcollins.com> wrote:

> From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> 
> This patch added device tree binding info for MAX31856 driver.
> 
> Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
Hi Matt, Paresh,

Unfortunately it seems I've been giving misleading advices on the
balance between what should be in the bindings and what should be
driver enforced.

Rob Herring clarified this in some other reviews I've read today.
It should be spi parameters that are not a feature of the device
or the master but rather a decision made based on the board
itself (if it can't cope with the frequency for example because
of a level shifter or something similar...)

Given I got this wrong recently I'd like a Rob review on this
binding if possible.

Jonathan

> ---
> Changes
> v1 -> v2
> [Matt
>  - Removed comment block and added possibilities of
>    thermocouple type in device tree binding doc.
> 
> v2 -> v3
>  - Rebased
> 
> v3 -> v4
>  - Removed one-shot property related information.
>  - Used standard name 'temp-sensor'
> ---
>  .../bindings/iio/temperature/max31856.txt          | 29 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> new file mode 100644
> index 0000000..eb3dc0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> @@ -0,0 +1,29 @@
> +Maxim MAX31856 thermocouple support
> +
> +https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
> +
> +Required properties:
> +	- compatible: must be "maxim,max31856"
> +	- reg: SPI chip select number for the device
> +	- spi-max-frequency: As per datasheet max. supported freq is 5000000

Channelling my inner Rob Herring (he pointed this out twice in patches
I've reviewed today - and it was a detail I've missed before.. :)
spi-max-frequency in a device binding should only be necessary if something
about the board restricts the value more than than either the bus master
or the device.   They should enforce their own limits in the drivers.


> +	- spi-cpha: must be defined for max31856 to enable SPI mode 1
Now this one I would imagine also falls in the should be in the driver, but
I'm happy to have Rob's input on it.

I'm afraid I've given misleading advice on this in the past so would be
good to clear up what the 'right' option is.

> +	- type: Type of thermocouple (By default is K-Type)
> +		0x00 : TYPE_B
> +		0x01 : TYPE_E
> +		0x02 : TYPE_J
> +		0x03 : TYPE_K (default)
> +		0x04 : TYPE_N
> +		0x05 : TYPE_R
> +		0x06 : TYPE_S
> +		0x07 : TYPE_T
> +
> +	Refer to spi/spi-bus.txt for generic SPI slave bindings.
> +
> + Example:
> +	temp-sensor@0 {
> +		compatible = "maxim,max31856";
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +		spi-cpha;
> +		type = <0x03>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3cfa518..44ec309 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7163,6 +7163,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/iio/temperature/max31856.c
>  F:	Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
> +F:	Documentation/devicetree/bindings/iio/temperature/max31856.txt
>  
>  IIO UNIT CONVERTER
>  M:	Peter Rosin <peda@axentia.se>
