Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40432 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab3INLIP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 07:08:15 -0400
Message-ID: <523451BD.4080003@kernel.org>
Date: Sat, 14 Sep 2013 13:08:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 10/38] Documentation: dt: iio: Add binding for LPS001WP
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org> <1378817379-8238-11-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-11-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

added devicetree list cc.
On 09/10/13 13:49, Lee Jones wrote:
> LPS001WP is a Pressure and Temperature sensor.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../devicetree/bindings/iio/pressure/lps001wp.txt   | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/lps001wp.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt b/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt
> new file mode 100644
> index 0000000..3294a65c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/lps001wp.txt
> @@ -0,0 +1,21 @@
> +* STMicroelectronics Pressure Sensor
> +
> +Required properties:
> +  - compatible: Should be "st,lps001wp_press"
> +  - reg: The I2C address of the sensor
> +
> +Optional properties:
> +  - vdd-supply: Phandle to the Vdd supply regulator
> +  - vddio-supply: Phandle to the Vdd-IO supply regulator
> +
> +Example:
> +
> +i2c@80128000 {
> +        lps001wp@5c {
> +                compatible = "st,lps001wp_press";
> +                reg = <0x5c>;
> +
> +                vdd-supply = <&ab8500_ldo_aux1_reg>;
> +                vddio-supply = <&db8500_vsmps2_reg>;
> +        };
> +};
> -- 1.8.1.2 -- To unsubscribe from this list: send the line "unsubscribe linux-iio" in the body of a message to
> majordomo@vger.kernel.org More majordomo info at http://vger.kernel.org/majordomo-info.html
