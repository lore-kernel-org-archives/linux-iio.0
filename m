Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60701 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbcBUVAU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 16:00:20 -0500
Subject: Re: [PATCH v3 4/6] iio:pressure:ms5611: DT bindings documentation
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1455731233.git.gregor.boirie@parrot.com>
 <b94c67ed8d9148707e4b613c747fc654c52c62d3.1455731233.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, "Andrew F. Davis" <afd@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CA2562.8080208@kernel.org>
Date: Sun, 21 Feb 2016 21:00:18 +0000
MIME-Version: 1.0
In-Reply-To: <b94c67ed8d9148707e4b613c747fc654c52c62d3.1455731233.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/02/16 17:52, Gregor Boirie wrote:
> From: Grégor Boirie <gregor.boirie@parrot.com>
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
One comment inline - though a quick look shows this idiom is common
which isn't great.

Also ideal would be to add the device_tree id tables and have the
documented binding include the manufacturer prefix.
> ---
>  .../devicetree/bindings/iio/pressure/ms5611.txt       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5611.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/ms5611.txt b/Documentation/devicetree/bindings/iio/pressure/ms5611.txt
> new file mode 100644
> index 0000000..986415a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/ms5611.txt
> @@ -0,0 +1,19 @@
> +MEAS ms5611 family pressure sensors
> +
> +Pressure sensors from MEAS Switzerland with SPI and I2C bus interfaces.
> +
> +Required properties:
> +- compatible: "ms5611" or "ms5607"
Preferred to be prefixed with the manufacturer though that requires adding
tables to the various drivers.  Ideally please do so and update this to include those
values as the preferred choices.


> +- reg: the I2C or SPI address the device will respond to
SPI buses don't have an address (they do have a chip select though).

> +
> +Optional properties:
> +- vdd-supply: an optional regulator that needs to be on to provide VDD
> +  power to the sensor.
> +
> +Example:
> +
> +ms5607@77 {
> +	compatible = "ms5607";
> +	reg = <0x77>;
> +	vdd-supply = <&ldo_3v3_gnss>;
> +};
> 

