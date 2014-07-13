Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52303 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbaGMJNb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 Jul 2014 05:13:31 -0400
Message-ID: <53C24E40.8070700@kernel.org>
Date: Sun, 13 Jul 2014 10:15:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mma8452: add DT support
References: <20140711130654.22566.53801.stgit@localhost>
In-Reply-To: <20140711130654.22566.53801.stgit@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/07/14 14:06, Martin Fuzzey wrote:
> Allow the mma8452 to be described in the device tree.
>
> Since no device specific binding attributes exist the trivial
> I2C binding is sufficient to describe the compatible string.
>
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
>   drivers/iio/accel/mma8452.c                        |    6 ++++++
>   2 files changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index b1cb341..1705f36 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -34,6 +34,7 @@ epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
>   fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
>   fsl,mc13892		MC13892: Power Management Integrated Circuit (PMIC) for i.MX35/51
>   fsl,mma8450		MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
> +fsl,mma8452		MMA8452Q: 3-axis 12-bit / 8-bit Digital Accelerometer
>   fsl,mpr121		MPR121: Proximity Capacitive Touch Sensor Controller
>   fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
>   gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 61eba5a..6804c2e 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -428,9 +428,15 @@ static const struct i2c_device_id mma8452_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, mma8452_id);
>
> +static const struct of_device_id mma8452_dt_ids[] = {
> +	{ .compatible = "fsl,mma8452" },
> +	{ }
> +};
> +
>   static struct i2c_driver mma8452_driver = {
>   	.driver = {
>   		.name	= "mma8452",
> +		.of_match_table = of_match_ptr(mma8452_dt_ids),
>   		.pm	= MMA8452_PM_OPS,
>   	},
>   	.probe = mma8452_probe,
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

