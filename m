Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53691 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757030AbcA3QaZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 11:30:25 -0500
Subject: Re: [PATCH] iio: light: opt3001: Add device tree binding
 documentation
To: Andreas Dannenberg <dannenberg@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
References: <1454094180-2688-1-git-send-email-dannenberg@ti.com>
Cc: Alexander Koch <mail@alexanderkoch.net>, knaack.h@gmx.de,
	lars@metafoo.de,
	"pmeerw@pmeerw.net >> Peter Meerwald" <pmeerw@pmeerw.net>,
	mhornung.linux@gmail.com, fengguang.wu@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACE51F.6000906@kernel.org>
Date: Sat, 30 Jan 2016 16:30:23 +0000
MIME-Version: 1.0
In-Reply-To: <1454094180-2688-1-git-send-email-dannenberg@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/01/16 19:03, Andreas Dannenberg wrote:
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Looks straight forward enough I'm happy to take this in a few
weeks with out a devicetree ack.  (though one is as ever welcome!)

In case anyone was wondering, this is retro-documentation - all that has
changed recently is the addition of support for running without an interrupt
line.

Jonathan
> ---
>  .../devicetree/bindings/iio/light/opt3001.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/opt3001.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/opt3001.txt b/Documentation/devicetree/bindings/iio/light/opt3001.txt
> new file mode 100644
> index 0000000..55b9cb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/opt3001.txt
> @@ -0,0 +1,26 @@
> +* Texas Instruments OPT3001 Ambient Light Sensor
> +
> +The driver supports interrupt-driven and interrupt-less operation, depending
> +on whether an interrupt property has been populated into the DT. Note that
> +the optional generation of IIO events on rising/falling light threshold changes
> +requires the use of interrupts. Without interrupts, only the simple reading
> +of the current light value is supported through the IIO API.
> +
> +http://www.ti.com/product/opt3001
> +
> +Required properties:
> +  - compatible: should be "ti,opt3001"
> +  - reg: the I2C address of the sensor
> +  
> +Optional properties:
> +  - interrupt-parent: should be the phandle for the interrupt controller
> +  - interrupts: interrupt mapping for GPIO IRQ (configure for falling edge)
> +
> +Example:
> +
> +opt3001@44 {
> +	compatible = "ti,opt3001";
> +	reg = <0x44>;
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
> +};
> 

