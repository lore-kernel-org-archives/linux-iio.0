Return-Path: <SRS0=QMXo=JG=gmail.com=robherring2@kernel.org>
Date: Wed, 20 Jun 2018 09:58:15 -0600
From: Rob Herring <robh@kernel.org>
To: Borys Movchan <borys.movchan@axis.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Borys Movchan <borysmn@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: add ISL29033 device
 bindings
Message-ID: <20180620155815.GA10569@rob-hp-laptop>
References: <20180613140043.5802-1-borys.movchan@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613140043.5802-1-borys.movchan@axis.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 13, 2018 at 04:00:15PM +0200, Borys Movchan wrote:
> From: Borys Movchan <borysmn@axis.com>

Commit msg missing

> 
> Signed-off-by: Borys Movchan <borys.movchan@axis.com>
> ---
>  .../devicetree/bindings/iio/light/isl29033.txt         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/isl29033.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/isl29033.txt b/Documentation/devicetree/bindings/iio/light/isl29033.txt
> new file mode 100644
> index 000000000000..988e40acc6ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/isl29033.txt

Preferred name if there only one compatible is the full compatible 
string plus '.txt'.

> @@ -0,0 +1,18 @@
> +Intersil ISL29033 Ultra-Low Lux, Low Power, Integrated Digital Ambient Light Sensor
> +
> +Required properties:
> +  - compatible : Must be "isil,isl29033".
> +  - reg: the I2C address of the device
> +
> +Optional properties:
> +  - isil,rext-kohms: External resistor nominal in kOhms used for ADC
> +    reference. If not specified, 499 kOhm value will be used.

-ohms and -micro-ohms are the documented units. Please use '-ohms' 
unless there is a compelling reason not to.

> +
> +Example:
> +
> +        als_sensor@44 {

light-sensor is the documented node name for ALSs.

> +            compatible = "isil,isl29033";
> +            reg = <0x44>;
> +            isil,rext-kohms = <1000>;
> +        };
> +
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
