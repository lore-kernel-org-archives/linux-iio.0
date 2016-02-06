Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41167 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcBFSgF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 13:36:05 -0500
Subject: Re: [PATCH v2 2/4] iio: ad5755: Add DT binding documentation
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, linux-iio@vger.kernel.org
References: <1454509864-32285-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1454509864-32285-2-git-send-email-sean.nyekjaer@prevas.dk>
Cc: devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B63D13.9080005@kernel.org>
Date: Sat, 6 Feb 2016 18:36:03 +0000
MIME-Version: 1.0
In-Reply-To: <1454509864-32285-2-git-send-email-sean.nyekjaer@prevas.dk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/02/16 14:31, Sean Nyekjaer wrote:
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Please pick up Rob's Ack in any future versions of the series
(I'm sending this as mostly as a reminder to myself if this one goes
in as it is!)
> ---
> Changes since v1:
> - none
> 
>  .../devicetree/bindings/iio/dac/ad5755.txt         | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5755.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5755.txt b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
> new file mode 100644
> index 0000000..4c91583
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
> @@ -0,0 +1,24 @@
> +* Analog Device AD5755 IIO Multi-Channel DAC Linux Driver
> +
> +Required properties:
> + - compatible: Has to contain one of the following:
> +	adi,ad5755
> +	adi,ad5755-1
> +	adi,ad5757
> +	adi,ad5735
> +	adi,ad5737
> +
> + - reg: spi chip select number for the device
> + - spi-cpha or spi-cpol: is the only modes that is supported
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +dac@0 {
> +	compatible = "adi,ad5755";
> +	reg = <0>;
> +	spi-max-frequency = <1000000>;
> +	spi-cpha;
> +};
> 

