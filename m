Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbeH0VBN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Aug 2018 17:01:13 -0400
Date: Mon, 27 Aug 2018 18:13:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Afonso Bordado <afonsobordado@az8.co>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: gyro: add device tree support for fxas21002c
Message-ID: <20180827181341.6563c0bf@archlinux>
In-Reply-To: <20180825211910.22929-2-afonsobordado@az8.co>
References: <20180825211910.22929-1-afonsobordado@az8.co>
        <20180825211910.22929-2-afonsobordado@az8.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 25 Aug 2018 22:19:08 +0100
Afonso Bordado <afonsobordado@az8.co> wrote:

> This patch adds device tree support for the fxas21002c driver, including
> bindings.
> 
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
Now, the devicetree bindings should not reflect just what the driver
uses right now, but rather describe the hardware.

There are interrupts on there for starters that definitely want to be
described from the start.  Also there is a reset line that should probably
be here from the start.

Potentially also the two power supplies though that's less critical
(nice to have though)

It is also an i2c and spi part though that can probably be added later as
we can argue we are only documenting the bindings for the device in i2c mode
for now.

So what is here is fine, but I think we need to describe more.

It's all well understood details of how it is connected so no need to
have tested it with a driver to be sure it will be right.

Jonathan

> ---
>  .../bindings/iio/gyroscope/fsl,fxas21002c.txt        | 12 ++++++++++++
>  drivers/iio/gyro/fxas21002c.c                        | 10 +++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> new file mode 100644
> index 000000000000..62f8c1bad85a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> @@ -0,0 +1,12 @@
> +* Freescale FXAS21002C Digital Angular Rate Gyroscope
> +
> +Required properties:
> +
> +  - compatible: must be "fsl,fxas21002c"
> +  - reg : the I2C address of the sensor
> +
> +Example:
> +gyroscope@0 {
> +       compatible = "fsl,fxas21002c";
> +       reg = <0x20>;
> +};
> diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
> index 7626b2f88d72..6fef210630e0 100644
> --- a/drivers/iio/gyro/fxas21002c.c
> +++ b/drivers/iio/gyro/fxas21002c.c
> @@ -8,7 +8,6 @@
>   * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
>   * TODO:
>   *        ODR / Scale Support
> - *        Devicetree
>   *        Power management
>   *        LowPass/HighPass Filters
>   *        Buffers
> @@ -340,6 +339,14 @@ static int fxas21002c_remove(struct i2c_client *client)
>  	return 0;
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
> @@ -350,6 +357,7 @@ MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
>  static struct i2c_driver fxas21002c_driver = {
>  	.driver = {
>  		.name = FXAS21002C_DRV_NAME,
> +		.of_match_table = of_match_ptr(fxas21002c_of_ids),
>  	},
>  	.probe		= fxas21002c_probe,
>  	.remove		= fxas21002c_remove,
