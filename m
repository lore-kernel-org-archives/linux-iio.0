Return-Path: <SRS0=Lipv=X3=gmail.com=robherring2@kernel.org>
Date: Mon, 12 Dec 2016 11:15:00 -0600
From: Rob Herring <robh@kernel.org>
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Sanchayan Maity <maitysanchayan@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] Documentation: DT: Add bmi160 imu binding
Message-ID: <20161212171500.7w67evyvicdpfkfc@rob-hp-laptop>
References: <20161208142259.26230-1-m.niestroj@grinn-global.com>
 <20161208142259.26230-4-m.niestroj@grinn-global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161208142259.26230-4-m.niestroj@grinn-global.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Dec 08, 2016 at 03:22:56PM +0100, Marcin Niestroj wrote:
> This adds documentation for Bosch BMI160 Inertial Measurement Unit
> device-tree bindings.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
> Changes v1 -> v2 (suggested by Rob):
>  * remove "gpio" keyword from interrupts property description
>  * describe "INT1" and "INT2" cases for interrupt-names property
> 
>  .../devicetree/bindings/iio/imu/bmi160.txt         | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> new file mode 100644
> index 0000000..ae0112c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> @@ -0,0 +1,36 @@
> +Bosch BMI160 - Inertial Measurement Unit with Accelerometer, Gyroscope
> +and externally connectable Magnetometer
> +
> +https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> +
> +Required properties:
> + - compatible : should be "bosch,bmi160"
> + - reg : the I2C address or SPI chip select number of the sensor
> + - spi-max-frequency : set maximum clock frequency (only for SPI)
> +
> +Optional properties:
> + - interrupt-parent : should be the phandle of the interrupt controller
> + - interrupts : interrupt mapping for IRQ, must be IRQ_TYPE_LEVEL_LOW
> + - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
> +   input, set to "INT2" if INT2 pin should be used instead
> +
> +Examples:
> +
> +bmi160@68 {
> +	compatible = "bosch,bmi160";
> +	reg = <0x68>;
> +
> +	interrupt-parent = <&gpio4>;
> +	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-names = "INT1";
> +};
> +
> +bmi160@0 {
> +	compatible = "bosch,bmi160";
> +	reg = <0>;
> +	spi-max-frequency = <10000000>;
> +
> +	interrupt-parent = <&gpio2>;
> +	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-names = "INT2";
> +};
> -- 
> 2.10.2
> 
