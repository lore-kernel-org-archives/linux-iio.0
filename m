Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43256 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbbH0UXF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2015 16:23:05 -0400
Subject: Re: [PATCH v6 2/2] devicetree: Add documentation for UPISEMI us5182d
 ALS and Proximity sensor
To: Adriana Reus <adriana.reus@intel.com>, pmeerw@pmeerw.net,
	daniel.baluta@intel.com
References: <1440065534-8601-1-git-send-email-adriana.reus@intel.com>
 <1440065534-8601-3-git-send-email-adriana.reus@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55DF71A5.1010705@kernel.org>
Date: Thu, 27 Aug 2015 21:23:01 +0100
MIME-Version: 1.0
In-Reply-To: <1440065534-8601-3-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 11:12, Adriana Reus wrote:
> Added entries in i2c/vendor-prefixes for the us5182d als and proximity sensor.
> Also added a documentation file for this sensor's properties.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
This isn't that trivial so I'd like some device tree maintainer
input if possible.

For now I've backed out the driver from my tree (given timing we have
loads of time to sort this out!)

Anyhow, anyone device tree related able to take a look at this.

Adriana, btw these should be cc'd to the device tree maintainers in
the first place (now added).

Jonathan
> ---
>  .../devicetree/bindings/iio/light/us5182d.txt      | 23 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
> new file mode 100644
> index 0000000..7785c56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
> @@ -0,0 +1,23 @@
> +* UPISEMI us5182d I2C ALS and Proximity sensor
> +
> +Required properties:
> +- compatible: must be "upisemi,usd5182"
> +- reg: the I2C address of the device
> +
> +Optional properties:
> +- upisemi,glass-coef: glass attenuation factor
> +- upisemi,dark-ths: array of thresholds (adc counts) corresponding to every scale
> +- upisemi,upper-dark-gain: tuning factor(4 int and 4 fractional bits - Q4.4) applied when light > threshold
> +- upisemi,lower-dark-gain: tuning factor(4 int and 4 fractional bits - Q4.4) applied when light < threshold
> +
> +Example:
> +
> +    usd5182@39 {
> +                compatible = "upisemi,usd5182";
> +                reg = <0x39>;
> +                upisemi,glass-coef = < 1000 >;
> +                upisemi,dark-ths = /bits/ 16 <170 200 512 512 800 2000 4000 8000>;
> +                upisemi,upper-dark-gain = /bits/ 8 <0x00>;
> +                upisemi,lower-dark-gain = /bits/ 8 <0x16>;
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index d444757..5b40bab 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -211,6 +211,7 @@ toshiba	Toshiba Corporation
>  toumaz	Toumaz
>  tplink	TP-LINK Technologies Co., Ltd.
>  truly	Truly Semiconductors Limited
> +upisemi	uPI Semiconductor Corp.
>  usi	Universal Scientific Industrial Co., Ltd.
>  v3	V3 Semiconductor
>  variscite	Variscite Ltd.
> 

