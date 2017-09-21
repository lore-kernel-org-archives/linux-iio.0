Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37577 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdIUX1C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2017 19:27:02 -0400
Date: Thu, 21 Sep 2017 18:26:59 -0500
From: Rob Herring <robh@kernel.org>
To: Ismail Kose <Ismail.Kose@maximintegrated.com>
Cc: "Ismail H. Kose" <ihkose@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: dac: ds4422/ds4424 dac driver
Message-ID: <20170921232659.yfvdkynzlqeetuau@rob-hp-laptop>
References: <DM5PR11MB18650DDCB6E1D4D2EA0C327AFD600@DM5PR11MB1865.namprd11.prod.outlook.com>
 <20170919072341.10249-1-Ismail.Kose@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170919072341.10249-1-Ismail.Kose@maximintegrated.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Sep 19, 2017 at 12:23:32AM -0700, Ismail Kose wrote:
> From: "Ismail H. Kose" <ihkose@gmail.com>
> 
> This patch provides an iio device driver for DS4422/DS4424 chips that support
> two/four channel 7-bit Sink/Source Current DAC.
> 
> Signed-off-by: Ismail Kose <Ismail.Kose@maximintegrated.com>
> ---
> v5:
> 	* Removed unused variable
> v4:
> 	* Removed unnecessary code and space optimization
> 	* Alphabetic order in Kcobfig and Makefile
> v3:
> 	* Removed iio-map and platform file support
> 	* Removed ds4424.h file
> 	* Fixed ADC value read bug
> 	* Removed confused comments
> 	* Added device tree binding file
> 	* Fixed bugs in probe and read function
> 
> v2:
> 	* Fixed coding style and removed unncessary code
> 	* Removed min/max rfs, ifs-scale, etc values from device tree
> 	* Removed unused code, definitions and some comments
> 	* Removed regulator control and made standard structure
> 	* Removed data processing and channel scale
> 	* Removed device tree binding file
> 
>  .../devicetree/bindings/iio/dac/ds4424.txt         |  20 ++

It's preferred to split bindings to separate patch.

>  drivers/iio/dac/Kconfig                            |   9 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/ds4424.c                           | 394 +++++++++++++++++++++
>  4 files changed, 424 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ds4424.txt
>  create mode 100644 drivers/iio/dac/ds4424.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ds4424.txt b/Documentation/devicetree/bindings/iio/dac/ds4424.txt
> new file mode 100644
> index 000000000000..840b11e1d813
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ds4424.txt
> @@ -0,0 +1,20 @@
> +Maxim Integrated DS4422/DS4424 7-bit Sink/Source Current DAC Device Driver
> +
> +Datasheet publicly available at:
> +https://datasheets.maximintegrated.com/en/ds/DS4422-DS4424.pdf
> +
> +Required properties:
> +	- compatible: Must be "maxim,ds4422" or "maxim,ds4424"

One compatible per line please.

> +	- reg: Should contain the DAC I2C address
> +	- maxim,rfs-resistors-ohms: Should contain reference resistor

...reference resistor ohms

> +
> +Optional properties:
> +	- vcc-supply: Power supply is optional. If not defined, driver will ignore it.
> +
> +Example:
> +	ds4224@10 {
> +		compatible = "maxim,ds4424";
> +		reg = <0x10>; /* When A0, A1 pins are ground */
> +		vcc-supply = "dac_vcc_3v3";

This is not how the regulator binding works.

> +		maxim,rfs-resistors-ohms = <400 800 1000 1600>;

The description needs to explain this is 4 values.

> +	};
