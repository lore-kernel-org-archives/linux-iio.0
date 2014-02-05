Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34096 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655AbaBEEnj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Feb 2014 23:43:39 -0500
Received: by mail-ig0-f169.google.com with SMTP id uq10so12318721igb.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Feb 2014 20:43:39 -0800 (PST)
Date: Tue, 4 Feb 2014 23:43:35 -0500
From: Matt Porter <mporter@linaro.org>
To: Matt Ranostay <mranostay@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, pantelis.antoniou@gmail.com
Subject: Re: [PATCH v4 1/2] iio:as3935: Add DT binding docs for AS3935 driver
Message-ID: <20140205044335.GA2172@beef>
References: <1391570096-2932-1-git-send-email-mranostay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391570096-2932-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 04, 2014 at 07:14:55PM -0800, Matt Ranostay Matt Ranostay wrote:
> Document compatible string, required and optional DT properties for
> AS3935 chipset driver.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  .../devicetree/bindings/iio/proximity/as3935.txt   | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/as3935.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/as3935.txt b/Documentation/devicetree/bindings/iio/proximity/as3935.txt
> new file mode 100644
> index 0000000..7e117cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/as3935.txt
> @@ -0,0 +1,25 @@
> +Austrian Microsystems AS3935 Franklin lightning sensor device driver
> +
> +Required properties:
> +	- compatible: must be "ams,as3935"

Change this to "amstaos,as3935"

amstaos (AMS bought Taos) is already a registered vendor prefix in
vendor-prefixes.txt

> +	- reg: SPI chip select number for the device
> +	- spi-cpha: SPI Mode 1

When using generic binding properties, please reference the binding
being used. Like:

	- spi-cpha: SPI Mode 1. Refer to spi/spi-bus.txt for generic SPI
	  slave node bindings.

> +  	- interrupt-parent : should be the phandle for the interrupt controller
> +	- interrupts : interrupt mapping for GPIO IRQ

	Refer to interrupt-controller/interrupts.txt for generic
	interrupt client node bindings.

> +
> +Optional properties:
> +	- ams,tune-cap: Calibration tuning capacitor stepping value 0 - 15.
> +	  Range of 0 to 120 pF, 8pF steps. This will require using the
> +	  calibration data from the manufacturer.
> +
> +
> +Example:
> +
> +as3935@0 {
> +	compatible = "ams,as3935";
> +	reg = <0>;
> +	spi-cpha;
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <16 1>;
> +	ams,tune-cap = /bits/ 8 <10>;

What is this? Why not just ams,tune-cap = <10>; ?

It's a value between 0-15, right?

-Matt
