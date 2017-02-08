Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35240 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdBHWK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Feb 2017 17:10:27 -0500
Date: Wed, 8 Feb 2017 16:10:10 -0600
From: Rob Herring <robh@kernel.org>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH 4/4] iio: chemical: add dsm501 particle sensor driver
 bindings
Message-ID: <20170208221010.hr27zpt5qfuz2cnm@rob-hp-laptop>
References: <20170205150344.11000-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170205150344.11000-1-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 05, 2017 at 04:03:44PM +0100, Tomasz Duszynski wrote:
> This patch adds bindings for dsm501 particle sensor driver.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  .../devicetree/bindings/iio/chemical/dsm501.txt          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/dsm501.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/dsm501.txt b/Documentation/devicetree/bindings/iio/chemical/dsm501.txt
> new file mode 100644
> index 000000000000..918c55c4c401
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/dsm501.txt
> @@ -0,0 +1,16 @@
> +* DSM501 particle sensor
> +
> +Required properties:
> +
> +- compatible: should be one of:
> +	      "samyoung,dsm501"
> +	      "shinyei,ppd42ns"
> +- gpios: should specify the GPIO connected to the sensor's data line, see
> +  	 "gpios property" in Documentation/devicetree/bindings/gpio/gpio.txt

data-gpios would be preferred. With that,

Acked-by: Rob Herring <robh@kernel.org>


> +
> +Example:
> +
> +dsm501 {
> +	compatible = "samyoung,dsm501";
> +	gpios = <&gpio1 28 0>;
> +};
> -- 
> 2.11.1
> 
