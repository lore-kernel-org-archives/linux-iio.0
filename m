Return-Path: <SRS0=KlWK=5X=gmail.com=robherring2@kernel.org>
Date: Sun, 18 Jun 2017 09:04:43 -0500
From: Rob Herring <robh@kernel.org>
To: Michael Stecklein <m-stecklein@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: humidity: add bindings for HDC100x
 sensors
Message-ID: <20170618140443.5nstmwkbaibprg2l@rob-hp-laptop>
References: <1497278950-12973-1-git-send-email-m-stecklein@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497278950-12973-1-git-send-email-m-stecklein@ti.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 12, 2017 at 09:49:08AM -0500, Michael Stecklein wrote:
> Add the bindings for the family of HDC100x sensors.
> 
> Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
> ---
>  .../devicetree/bindings/iio/humidity/hdc100x.txt         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt b/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
> new file mode 100644
> index 0000000..6f272fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
> @@ -0,0 +1,16 @@
> +* HDC100x temperature + humidity sensors
> +
> +Required properties:
> +  - compatible: Should contain one of the following:
> +	ti,hdc100x

No wildcards in compatible strings please.

> +	ti,hdc1010
> +	ti,hdc1050
> +	ti,hdc1080
> +  - reg: i2c address of the sensor
> +
> +Example:
> +
> +hdc100x@40 {
> +	compatible = "ti,hdc100x";
> +	reg = <0x40>;
> +};
> -- 
> 2.7.4
> 
