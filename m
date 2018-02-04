Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeBDKVT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Feb 2018 05:21:19 -0500
Date: Sun, 4 Feb 2018 10:21:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v13 2/3] dt-bindings: iio: temperature: add MLX90632
 device bindings
Message-ID: <20180204102116.04838c24@archlinux>
In-Reply-To: <20180111102010.27350-1-cmo@melexis.com>
References: <20180111102010.27350-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 11 Jan 2018 11:20:10 +0100
Crt Mori <cmo@melexis.com> wrote:

> Add device tree bindings for MLX90632 IR temperature sensor.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Jonathan

> ---
>  .../bindings/iio/temperature/mlx90632.txt          | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
> new file mode 100644
> index 000000000000..0b05812001f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
> @@ -0,0 +1,28 @@
> +* Melexis MLX90632 contactless Infra Red temperature sensor
> +
> +Link to datasheet: https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90632
> +
> +There are various applications for the Infra Red contactless temperature sensor
> +and MLX90632 is most suitable for consumer applications where measured object
> +temperature is in range between -20 to 200 degrees Celsius with relative error
> +of measurement below 1 degree Celsius in object temperature range for
> +industrial applications. Since it can operate and measure ambient temperature
> +in range of -20 to 85 degrees Celsius it is suitable also for outdoor use.
> +
> +Be aware that electronics surrounding the sensor can increase ambient
> +temperature. MLX90632 can be calibrated to reduce the housing effect via
> +already existing EEPROM parameters.
> +
> +Since measured object emissivity effects Infra Red energy emitted, emissivity
> +should be set before requesting the object temperature.
> +
> +Required properties:
> +  - compatible: should be "melexis,mlx90632"
> +  - reg: the I2C address of the sensor (default 0x3a)
> +
> +Example:
> +
> +mlx90632@3a {
> +	compatible = "melexis,mlx90632";
> +	reg = <0x3a>;
> +};

