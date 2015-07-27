Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53691 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430AbbG0OUj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 10:20:39 -0400
Date: Mon, 27 Jul 2015 15:20:05 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Martin Kepplinger <martink@posteo.de>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"mfuzzey@parkeon.com" <mfuzzey@parkeon.com>,
	"roberta.dobrescu@gmail.com" <roberta.dobrescu@gmail.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"christoph.muellner@theobroma-systems.com"
	<christoph.muellner@theobroma-systems.com>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 5/8] iio: mma8452: add devicetree binding document
Message-ID: <20150727142005.GA10821@leverpostej>
References: <1438006095-26920-1-git-send-email-martink@posteo.de>
 <1438006095-26920-6-git-send-email-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438006095-26920-6-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 27, 2015 at 03:08:12PM +0100, Martin Kepplinger wrote:
> As we support more chips now, add a binding document and remove it from
> i2c trivial-devices.txt list.
> 
> The binding document is further extended in a later patch of this series.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> ---
>  .../devicetree/bindings/i2c/trivial-devices.txt     |  1 -
>  .../devicetree/bindings/iio/accel/mma8452.txt       | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/mma8452.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 00f8652..094238a 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -54,7 +54,6 @@ epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
>  fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
>  fsl,mc13892		MC13892: Power Management Integrated Circuit (PMIC) for i.MX35/51
>  fsl,mma8450		MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
> -fsl,mma8452		MMA8452Q: 3-axis 12-bit / 8-bit Digital Accelerometer
>  fsl,mpr121		MPR121: Proximity Capacitive Touch Sensor Controller
>  fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
>  gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> new file mode 100644
> index 0000000..8d98e05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> @@ -0,0 +1,21 @@
> +Freescale MMA8452Q, MMA8453Q, MMA8652FC or MMA8653FC triaxial accelerometer
> +
> +Required properties:
> +
> +  - compatible: should be "fsl,mma8653", "fsl,mma8652", "fsl,mma8453" or
> +    "fsl,mma8452" respectively.


This would be easier to read/search (and easier to extend in future) if
formatted as a list, e.g.

 - compatible: should contain one of:
   * "fsl,mma8653"
   * "fsl,mma8652"
   * "fsl,mma8453"
   * "fsl,mma8452"

Mark.

> +  - reg: the I2C address of the chip
> +
> +Optional properties:
> +
> +  - interrupt-parent: should be the phandle for the interrupt controller
> +  - interrupts: interrupt mapping for GPIO IRQ
> +
> +Example:
> +
> +	mma8653fc@1d {
> +		compatible = "fsl,mma8653";
> +		reg = <0x1d>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <5 0>;
> +	};
> -- 
> 2.1.4
> 
