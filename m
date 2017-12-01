Return-Path: <SRS0=r+2R=C5=gmail.com=robherring2@kernel.org>
Date: Fri, 1 Dec 2017 16:18:56 -0600
From: Rob Herring <robh@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: temperature: add MLX90632 device
 bindings
Message-ID: <20171201221856.idwpoi5a2btf2kpj@rob-hp-laptop>
References: <20171129220805.11358-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171129220805.11358-1-cmo@melexis.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 29, 2017 at 11:08:05PM +0100, Crt Mori wrote:
> Add device tree bindings for MLX90632 IR temperature sensor.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  .../bindings/iio/temperature/mlx90632.txt          | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
> new file mode 100644
> index 000000000000..6073a5ccf9a4
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
> +mlx90632@02 {

Should be ...@3a

With that,

Reviewed-by: Rob Herring <robh@kernel.org>


> +	compatible = "melexis,mlx90632";
> +	reg = <0x3a>;
> +};
> -- 
> 2.15.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
