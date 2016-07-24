Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58335 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbcGXJ6r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 05:58:47 -0400
Subject: Re: [PATCH 1/2] iio: magn: DT bindings for AK8974
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1469346695-15302-1-git-send-email-linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, Samu Onkalo <samu.onkalo@intel.com>,
	Sebastian Reichel <sre@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3dc38fa7-82b9-3bdb-41bc-30e19e297421@kernel.org>
Date: Sun, 24 Jul 2016 10:58:42 +0100
MIME-Version: 1.0
In-Reply-To: <1469346695-15302-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/07/16 08:51, Linus Walleij wrote:
> This adds device tree bindings for the AK8974 magnetometer, similar
> to those for the AK8975.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Samu Onkalo <samu.onkalo@intel.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
> ChangeLog v3->v4:
> - Add support for an optional mounting matrix
> ChangeLog v2->v3:
> - No changes, just reposting to keep together with the series
> ChangeLog v1->v2:
> - No changes, just reposting to keep together with the series
> ---
>  .../bindings/iio/magnetometer/ak8974.txt           | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
> new file mode 100644
> index 000000000000..77d5aba1bd8c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
> @@ -0,0 +1,29 @@
> +* Asahi Kasei AK8974 magnetometer sensor
> +
> +Required properties:
> +
> +- compatible : should be "asahi-kasei,ak8974"
> +- reg : the I2C address of the magnetometer
> +
> +Optional properties:
> +
> +- avdd-supply: regulator supply for the analog voltage
> +  (see regulator/regulator.txt)
> +- dvdd-supply: regulator supply for the digital voltage
> +  (see regulator/regulator.txt)
> +- interrupts: data ready (DRDY) and interrupt (INT1) lines
> +  from the chip, the DRDY interrupt must be placed first.
> +  The interrupts can be triggered on rising or falling
> +  edges alike.
> +- mount-matrix: an optional 3x3 mounting rotation matrix
> +
> +Example:
> +
> +ak8974@0f {
> +	compatible = "asahi-kasei,ak8974";
> +	reg = <0x0f>;
> +	avdd-supply = <&foo_reg>;
> +	dvdd-supply = <&bar_reg>;
> +	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
> +		     <1 IRQ_TYPE_EDGE_RISING>;
> +};
> 

