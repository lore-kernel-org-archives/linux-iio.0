Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45120 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab3HDKy5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Aug 2013 06:54:57 -0400
Message-ID: <51FE4117.3040404@kernel.org>
Date: Sun, 04 Aug 2013 12:55:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org, denis.ciocca@st.com,
	devicetree-discuss@lists.ozlabs.org, l.czerwinski@samsung.com,
	maxime.ripard@free-electrons.com,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v2] iio: lps331ap: Add support for DT
References: <1374240981-13560-1-git-send-email-j.anaszewski@samsung.com> <1374240981-13560-2-git-send-email-j.anaszewski@samsung.com>
In-Reply-To: <1374240981-13560-2-git-send-email-j.anaszewski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/19/13 14:36, Jacek Anaszewski wrote:
> This patch adds DT support for the lps331ap barometer
> sensor.
> 
> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
This makes sense to me and looks similar to that in existing bindings
hence,

Applied to the togreg branch of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Note I am one of those maintainers who has very limited knowledge of device
tree so am basing this decision on the 'it looks like existing mappings' rather
than any deep understanding.

Jonathan
> ---
>  .../devicetree/bindings/iio/pressure/lps331ap.txt  |   41 ++++++++++++++++++++
>  drivers/iio/pressure/st_pressure_i2c.c             |   11 +++++-
>  drivers/iio/pressure/st_pressure_spi.c             |   11 +++++-
>  3 files changed, 61 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/lps331ap.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/lps331ap.txt b/Documentation/devicetree/bindings/iio/pressure/lps331ap.txt
> new file mode 100644
> index 0000000..e05b45e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/lps331ap.txt
> @@ -0,0 +1,41 @@
> +* STMicroelectronics LPS331AP barometer sensor
> +
> +Required properties:
> +
> +  - compatible : should be "st,lps331ap"
> +  - reg : the I2C address of the barometer
> +
> +Optional properties:
> +
> +  - drdy-int-pin : redirect DRDY on pin INT1 (1) or pin INT2 (2) (u8)
> +  - interrupt-parent : phandle to the interrupt map subnode
> +  - interrupts : interrupt mapping for LPS331AP interrupt sources:
> +		 2 sources: 0 - data ready, 1 - threshold event
> +  - irq-map : irq sub-node defining interrupt map
> +	      (all properties listed below are required):
> +      - #interrupt-cells : should be 1
> +      - #address-cells : should be 0
> +      - #size-cells : should be 0
> +      - interrupt-map : table of entries consisting of three child elements:
> +	  - unit_interrupt_specifier - 0 : data ready, 1 : threshold event
> +	  - interrupt parent phandle
> +	  - parent unit interrupt specifier consisiting of two elements:
> +	      - index of the interrupt within the controller
> +	      - flags : should be 0
> +
> +Example:
> +
> +lps331ap@5d {
> +	compatible = "st,lps331ap";
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
> index 7cebcc7..1683ebe 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -56,15 +56,24 @@ static int st_press_i2c_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id st_press_id_table[] = {
> -	{ LPS331AP_PRESS_DEV_NAME },
> +	{ "st,lps331ap" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_press_id_table);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id lps331ap_of_match[] = {
> +	{ .compatible = "st,lps331ap", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lps331ap_of_match);
> +#endif
> +
>  static struct i2c_driver st_press_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
>  		.name = "st-press-i2c",
> +		.of_match_table = of_match_ptr(lps331ap_of_match),
>  	},
>  	.probe = st_press_i2c_probe,
>  	.remove = st_press_i2c_remove,
> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> index 17a1490..05c30d6 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -55,15 +55,24 @@ static int st_press_spi_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id st_press_id_table[] = {
> -	{ LPS331AP_PRESS_DEV_NAME },
> +	{ "st,lps331ap" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_press_id_table);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id lps331ap_of_match[] = {
> +	{ .compatible = "st,lps331ap", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lps331ap_of_match);
> +#endif
> +
>  static struct spi_driver st_press_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
>  		.name = "st-press-spi",
> +		.of_match_table = of_match_ptr(lps331ap_of_match),
>  	},
>  	.probe = st_press_spi_probe,
>  	.remove = st_press_spi_remove,
> 
