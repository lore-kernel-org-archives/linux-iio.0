Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52368 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753916AbcHUQJZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 12:09:25 -0400
Subject: Re: [PATCH 1/2] iio: gyro: Add MPU-3050 device tree bindings
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1471286275-25024-1-git-send-email-linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ff9be804-8298-5214-1fdc-3b490a609ca3@kernel.org>
Date: Sun, 21 Aug 2016 17:08:47 +0100
MIME-Version: 1.0
In-Reply-To: <1471286275-25024-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/08/16 19:37, Linus Walleij wrote:
> This adds device tree bindings for the MPU-3050 gyroscope. Since it
> is the first set of bindings for a gyroscope, the folder for it
> is also created.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Leonard, could you take a look at this series.

Whilst the device is somewhat different in it's register map etc, the
i2c master stuff looks at least superficially similar so we should end
up with equivalent bindings...

(any movement on a V3 for that patch set - I know some of the beagle gsoc
guys were making fair use of those patches and would love to have mainlined
version)

Superficially looks like the bypass bindings are the same anyway which is
good but I'd like a quick look from you as well.

Not totally sure we ever convinced Rob on those bindings either, but
perhaps that's waiting for V3.

Jonathan
> ---
>  .../bindings/iio/gyroscope/invensense,mpu3050.txt  | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt b/Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
> new file mode 100644
> index 000000000000..e17231a5f4b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
> @@ -0,0 +1,54 @@
> +Invensense MPU-3050 Gyroscope device tree bindings
> +
> +Required properties:
> +  - compatible : should be "invensense,mpu3050"
> +  - reg : the I2C address of the sensor
> +  - #address-cells : should be <1>, used to indicate the optional
> +    I2C mux node
> +  - #size-cells : should be <0>
> +
> +Optional properties:
> +  - interrupt-parent : should be the phandle for the interrupt controller
> +  - interrupts : interrupt mapping for the trigger interrupt from the
> +    internal oscillator. The following IRQ modes are supported:
> +    IRQ_TYPE_EDGE_RISING, IRQ_TYPE_EDGE_FALLING, IRQ_TYPE_LEVEL_HIGH and
> +    IRQ_TYPE_LEVEL_LOW. The driver should detect and configure the hardware
> +    for the desired interrupt type.
> +  - vdd-supply : supply regulator for the main power voltage.
> +  - vlogic-supply : supply regulator for the signal voltage.
> +  - mount-matrix : see iio/mount-matrix.txt
> +
> +Optional subnodes:
> +  - The MPU-3050 will pass through and forward the I2C signals from the
> +    incoming I2C bus, alternatively drive traffic to a slave device (usually
> +    an accelerometer) on its own initiative. Therefore is supports a subnode
> +    i2c master node. This node is like any I2C master and should contain:
> +    #address-cells = <1>;
> +    #size-cells = <0>;
> +    reg = <0>;
> +
> +Example:
> +
> +mpu3050@68 {
> +	compatible = "invensense,mpu3050";
> +	reg = <0x68>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	interrupt-parent = <&foo>;
> +	interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
> +	vdd-supply = <&bar>;
> +	vlogic-supply = <&baz>;
> +
> +	/* External I2C interface */
> +	i2c@0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0>;
> +		fnord@18 {
> +			compatible = "fnord";
> +			reg = <0x18>;
> +			interrupt-parent = <&foo>;
> +			interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		};
> +	};
> +};
> 

