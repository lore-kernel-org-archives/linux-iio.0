Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40458 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab3INLJE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 07:09:04 -0400
Message-ID: <523451EE.7080307@kernel.org>
Date: Sat, 14 Sep 2013 13:09:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 12/38] Documentation: dt: iio: Add binding for L3G4200D
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org> <1378817379-8238-13-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-13-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add devicetree list cc
On 09/10/13 13:49, Lee Jones wrote:
> L3G4200D is a Gyroscope Sensor
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../devicetree/bindings/iio/gyro/l3g4200d.txt       | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt b/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt
> new file mode 100644
> index 0000000..29baf9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt
> @@ -0,0 +1,21 @@
> +* STMicroelectronics Gyroscope Sensor
> +
> +Required properties:
> +  - compatible: Should be "st,l3g4200d_gyro"
> +  - reg: The I2C address of the sensor
> +
> +Optional properties:
> +  - vdd-supply: Phandle to the Vdd supply regulator
> +  - vddio-supply: Phandle to the Vdd-IO supply regulator
> +
> +Example:
> +
> +i2c@80128000 {
> +	l3g4200d_gyro@68 {
> +		compatible = "st,l3g4200d_gyro";
> +		reg = <0x68>;
> +
> +		vdd-supply = <&ab8500_ldo_aux1_reg>;
> +		vddio-supply = <&db8500_vsmps2_reg>;
> +	};
> +};
> 
