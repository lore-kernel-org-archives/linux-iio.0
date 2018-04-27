Return-Path: <SRS0=MLpZ=HQ=gmail.com=robherring2@kernel.org>
Date: Fri, 27 Apr 2018 09:48:20 -0500
From: Rob Herring <robh@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
	Michael.Hennerich@analog.com, knaack.h@gmx.de,
	linux-iio@vger.kernel.org, daniel.baluta@nxp.com,
	devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/9] staging: iio: ad2s1200: Add documentation for
 device tree binding
Message-ID: <20180427144820.jfvypgk6tfp2syty@rob-hp-laptop>
References: <cover.1524432236.git.davidjulianveenstra@gmail.com>
 <0aa68c6684c2b45dd0af398c166d6b36c18be1af.1524432236.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0aa68c6684c2b45dd0af398c166d6b36c18be1af.1524432236.git.davidjulianveenstra@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Apr 23, 2018 at 12:03:47AM +0200, David Veenstra wrote:
> Add documentation for the added device tree bindings.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
> ---
> Changes in v3:
>  - Documentation is added to Documentation/devicetree/bindings/iio/resolver
>    instead of staging directory.
>  - Add mention to ad2s1205 device.
> 
>  .../devicetree/bindings/iio/resolver/ad2s1200.txt        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
> new file mode 100644
> index 000000000000..46b51db38368
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
> @@ -0,0 +1,16 @@
> +Analog Devices AD2S1200 and AD2S1205 Resolver-to-Digital Converter
> +
> +Required properties:
> + - compatible : should be "adi,ad2s1200" or "adi,ad2s1205"
> + - reg : the SPI chip select number of the device
> + - sample-gpios : The GPIO pin connected to the SAMPLE line of the AD2S1200
> + - rdvel-gpios : The GPIO pin connected to the RDVEL line of the AD2S1200

Are these gpios something that would be common to resolvers (whatever 
that is) or specific to this chip. For the latter, you need vendor 
prefixes.

> +
> +Example:
> +
> +	resolver {

Missing unit address.

> +		compatible = "adi,ad2s1200";
> +		reg = <4>;
> +		sample-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +		rdvel-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
> +	};
> -- 
> 2.16.2
> 
