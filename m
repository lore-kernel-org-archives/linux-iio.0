Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:40423 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752560Ab3GBMxN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 08:53:13 -0400
Message-ID: <51D2CE03.2070704@metafoo.de>
Date: Tue, 02 Jul 2013 14:56:35 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lukasz Czerwinski <l.czerwinski@samsung.com>
CC: jic23@kernel.org, denis.ciocca@st.com, linux-iio@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH 4/4] iio: lps331ap: Add support for DT
References: <1372767338-13179-1-git-send-email-l.czerwinski@samsung.com> <1372767338-13179-5-git-send-email-l.czerwinski@samsung.com>
In-Reply-To: <1372767338-13179-5-git-send-email-l.czerwinski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/2013 02:15 PM, Lukasz Czerwinski wrote:
> From: Jacek Anaszewski <j.anaszewski@samsung.com>
> 
> This patch adds DT support for the lps331ap barometer
> sensor.
> 
> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  .../bindings/iio/pressure/st_pressure.txt          |   41 ++++++++++++++++++++
>  drivers/iio/pressure/st_pressure_i2c.c             |    9 +++++
>  drivers/iio/pressure/st_pressure_spi.c             |    9 +++++
>  3 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/st_pressure.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/st_pressure.txt b/Documentation/devicetree/bindings/iio/pressure/st_pressure.txt
> new file mode 100644
> index 0000000..73a4b7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/st_pressure.txt
> @@ -0,0 +1,41 @@
> +* STMicroelectronics LPS331AP barometer sensor
> +
> +Required properties:
> +
> +  - compatible : should be "lps331ap"

Needs the vendor prefix.

> +  - reg : the I2C address of the barometer
> +
> +Optional properties:
> +
> +  - drdy-int-pin : redirect DRDY on pin INT1 (1) or pin INT2 (2) (u8)
> +  - interrupt-parent : phandle to the interrupt map subnode
> +  - interrupts : interrupt mapping for LPS331AP interrupt sources:
> +		2 sources: 0 - INT1, 1 - INT2
> +  - irq-map : irq sub-node defining interrupt map
> +	      (all properties listed below are required):
> +      - #interrupt-cells : should be 1
> +      - #address-cells : should be 0
> +      - #size-cells : should be 0
> +      - interrupt-map : table of entries consisting of three child elements:
> +	  - unit_interrupt_specifier - 0 : INT1, 1 : INT2
> +	  - interrupt parent phandle
> +	  - parent unit interrupt specifier consisiting of two elements:
> +	      - index of the interrupt within the controller
> +	      - flags : should be 0

While this works I wonder why you choose such a complicated example for setting
up the IRQ? Why not just reference the IRQ directly using the interrupts property?

> +
> +Example:
> +
> +lps331ap@5d {
> +	compatible = "lps331ap";
> +	reg = <0x5d>;
> +	drdy-int-pin = /bits/ 8 <2>;
> +	interrupt-parent = <&irq_map>;
> +	interrupts = <0>, <1>;
> +
> +	irq_map: irq-map {
> +		#interrupt-cells = <1>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		interrupt-map = <0 &gpf0 5 0>;
> +	};
> +};
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> index 7cebcc7..a1ad3cf 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -61,10 +61,19 @@ static const struct i2c_device_id st_press_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, st_press_id_table);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id lps331ap_of_match[] = {
> +	{ .compatible = LPS331AP_PRESS_DEV_NAME, },

I think it is better to write the name out. The name the device binds to should
be fixed and not depend on some macro.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lps331ap_of_match);
> +#endif
