Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42402 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbeHaTwK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Aug 2018 15:52:10 -0400
Date: Fri, 31 Aug 2018 17:41:25 +0200
From: Tomasz Duszynski <tduszyns@gmail.com>
To: Afonso Bordado <afonsobordado@az8.co>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: gyro: add device tree support for fxas21002c
Message-ID: <20180831154124.GB2679@arch>
References: <20180830211825.12202-1-afonsobordado@az8.co>
 <20180830211825.12202-2-afonsobordado@az8.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180830211825.12202-2-afonsobordado@az8.co>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 30, 2018 at 10:18:23PM +0100, Afonso Bordado wrote:
> This patch adds device tree support for the fxas21002c driver, including
> bindings.
>
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> ---
>  .../bindings/iio/gyroscope/fsl,fxas21002c.txt | 35 +++++++++++++++++++
>  drivers/iio/gyro/fxas21002c.c                 | 13 ++++++-
>  2 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> new file mode 100644
> index 000000000000..2feda6da5566
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> @@ -0,0 +1,35 @@
> +* Freescale FXAS21002C Digital Angular Rate Gyroscope
> +
> +Required properties:
> +
> +  - compatible: must be "fsl,fxas21002c"
> +  - reg : the I2C address of the sensor
> +
> +Optional properties:
> +
> +  - interrupt-parent	: phandle to the parent interrupt controller.
> +			  see interrupt-controller/interrupts.txt
> +  - interrupts		: The first interrupt listed must be the one
> +			  connected to the INT1 pin, the second interrupt
> +			  listed must be the one connected to the INT2 pin.
> +			  The interrupts can be triggered on rising or falling
> +			  edges alike.
> +			  see interrupt-controller/interrupts.txt
> +  - vdd-supply		: The main voltage regulator
> +  - iovdd-supply	: The IO voltage regulator
> +			  see regulator/regulator.txt
> +  - reset-gpios	: GPIO used to reset the device.
> +			  see gpio/gpio.txt.
> +  - mount-matrix	: see iio/mount-matrix.txt
> +
> +Example:
> +gyroscope@0 {

By convention if node has a reg value then the address should be
reflected in the node name as well. So i suggest renaming node to
gyroscope@20.

> +	compatible = "fsl,fxas21002c";
> +	reg = <0x20>;
> +	reset-gpios = <&gpio0 2 0>;
> +	vdd-supply = <&vref>;
> +	iovdd-supply = <&vref2>;
> +	interrupt-parent = <&foo>;
> +	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
> +		     <1 (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)>;
> +};
> diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
> index 261b73629544..7471e9b80010 100644
> --- a/drivers/iio/gyro/fxas21002c.c
> +++ b/drivers/iio/gyro/fxas21002c.c
> @@ -8,8 +8,10 @@
>   * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
>   * TODO:
>   *        ODR / Scale Support
> - *        Devicetree
>   *        Power management
> + *        GPIO Reset
> + *        Power supplies
> + *        Mount Matrix
>   *        LowPass/HighPass Filters
>   *        Buffers
>   *        Interrupts
> @@ -345,6 +347,14 @@ static int fxas21002c_probe(struct i2c_client *client,
>  	return ret;
>  }
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id fxas21002c_of_ids[] = {
> +	{.compatible = "fsl,fxas21002c"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, fxas21002c_of_ids);
> +#endif
> +
>  static const struct i2c_device_id fxas21002c_id[] = {
>  	{"fxas21002c", ID_FXAS21002C},
>  	{}
> @@ -355,6 +365,7 @@ MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
>  static struct i2c_driver fxas21002c_driver = {
>  	.driver = {
>  		.name = FXAS21002C_DRV_NAME,
> +		.of_match_table = of_match_ptr(fxas21002c_of_ids),
>  	},
>  	.probe		= fxas21002c_probe,
>  	.id_table	= fxas21002c_id,
> --
> 2.18.0
>
>
