Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:55423 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbdA2JbM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jan 2017 04:31:12 -0500
Date: Sun, 29 Jan 2017 10:19:31 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Andreas Klinger <ak@it-klinger.de>
cc: jic23@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: distance: add dt binding for devantech-srf04
In-Reply-To: <20170128235814.GA4786@andreas>
Message-ID: <alpine.DEB.2.02.1701291015510.20492@pmeerw.net>
References: <20170128235814.GA4786@andreas>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 29 Jan 2017, Andreas Klinger wrote:

> This patch adds dt binding for devantech ultrasonic ranger srf04.

comments below
 
> The vendor "devantech" was already added to the vendor list with 
> 	"[PATCH v4 1/3] iio: distance: srf08: add trivial DT binding"
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/devantech-srf04.txt          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
> new file mode 100644
> index 000000000000..4ea29ef3ff89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
> @@ -0,0 +1,17 @@
> +* Devantech SRF04 ultrasonic range finder
> +  Bit-banging driver
> +
> +Required properties:
> + - compatible:	Should be "devantech,srf04"
> + - trig-gpios:	Definition of the GPIO for the triggering input
> + - echo-gpios:	Definition of the GPIO for the echo

"for the echo"
maybe some more explanation? it sounds somewhat incomplete to me

in the driver you have "failed to get echo-gpiod", maybe it should be gpios there?

> +		needs to be an interrupt input
> +		See Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Example:
> +srf04@0 {
> +	compatible = "devantech,srf04";
> +	trig-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +	echo-gpios = <&gpio2  6 GPIO_ACTIVE_HIGH>;
> +};
> +
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
