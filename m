Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60028 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbbGEOJD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 10:09:03 -0400
Message-ID: <55993A7D.7090806@kernel.org>
Date: Sun, 05 Jul 2015 15:09:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Andreas Dannenberg <dannenberg@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: opt3001: Add device tree binding documentation
References: <1435876079-26287-1-git-send-email-dannenberg@ti.com> <1435876079-26287-3-git-send-email-dannenberg@ti.com>
In-Reply-To: <1435876079-26287-3-git-send-email-dannenberg@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/07/15 23:27, Andreas Dannenberg wrote:
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Utterly standard binding so unless someone shouts, I'll pick this
up with the driver.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/light/opt3001.txt          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/opt3001.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/opt3001.txt b/Documentation/devicetree/bindings/iio/light/opt3001.txt
> new file mode 100644
> index 0000000..d5f0765
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/opt3001.txt
> @@ -0,0 +1,18 @@
> +* Texas Instruments OPT3001 Ambient Light Sensor
> +
> +http://www.ti.com/product/opt3001
> +
> +Required properties:
> +  - compatible: should be "ti,opt3001"
> +  - reg: the I2C address of the sensor
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

