Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56091 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbcCEP0T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 10:26:19 -0500
Subject: Re: [PATCH v2 3/5] iio:magnetometer:ak8975: power regulator support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1457001111.git.gregor.boirie@parrot.com>
 <436d3e01c4aab954bc836454c95360489b03f34b.1457001111.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAFA96.5090605@kernel.org>
Date: Sat, 5 Mar 2016 15:26:14 +0000
MIME-Version: 1.0
In-Reply-To: <436d3e01c4aab954bc836454c95360489b03f34b.1457001111.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 10:44, Gregor Boirie wrote:
> Add support for an optional regulator which, if found into device-tree,
> will power on device at probing time.
> The regulator is declared into ak8975 DTS entry as a "vdd-supply" property.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied.
> ---
>  .../devicetree/bindings/iio/magnetometer/ak8975.txt      |  2 ++
>  drivers/iio/magnetometer/ak8975.c                        | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> index 011679f..34a3206 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> @@ -8,6 +8,7 @@ Required properties:
>  Optional properties:
>  
>    - gpios : should be device tree identifier of the magnetometer DRDY pin
> +  - vdd-supply: an optional regulator that needs to be on to provide VDD
>  
>  Example:
>  
> @@ -15,4 +16,5 @@ ak8975@0c {
>          compatible = "asahi-kasei,ak8975";
>          reg = <0x0c>;
>          gpios = <&gpj0 7 0>;
> +        vdd-supply = <&ldo_3v3_gnss>;
>  };
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 896b13e3..72c03d9 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -32,6 +32,7 @@
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
>  #include <linux/acpi.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -379,8 +380,23 @@ static int ak8975_who_i_am(struct i2c_client *client,
>  			   enum asahi_compass_chipset type)
>  {
>  	u8 wia_val[2];
> +	struct regulator *vdd = devm_regulator_get_optional(&client->dev,
> +							    "vdd");
>  	int ret;
>  
> +	/* Enable attached regulator if any. */
> +	if (!IS_ERR(vdd)) {
> +		ret = regulator_enable(vdd);
> +		if (ret) {
> +			dev_err(&client->dev, "Failed to enable Vdd supply\n");
> +			return ret;
> +		}
> +	} else {
> +		ret = PTR_ERR(vdd);
> +		if (ret != -ENODEV)
> +			return ret;
> +	}
> +
>  	/*
>  	 * Signature for each device:
>  	 * Device   |  WIA1      |  WIA2
> 

