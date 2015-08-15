Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47397 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbHOObu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 10:31:50 -0400
Subject: Re: [PATCH v3 2/2] devicetree: Add documentation for UPISEMI us5182d
 ALS and Proximity sensor
To: Adriana Reus <adriana.reus@intel.com>, pmeerw@pmeerw.net,
	daniel.baluta@intel.com
References: <1439544580-21179-1-git-send-email-adriana.reus@intel.com>
 <1439544580-21179-3-git-send-email-adriana.reus@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF4D54.8010007@kernel.org>
Date: Sat, 15 Aug 2015 15:31:48 +0100
MIME-Version: 1.0
In-Reply-To: <1439544580-21179-3-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/08/15 10:29, Adriana Reus wrote:
> Added entries in trivial-devices and i2c/vendor-prefixes for
> the us5182d als and proximity sensor. Also added a documentation file for
> this sensor's properties.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
It's not a trivial device if it has it's own docs.  So don't add it to that list
(the point is to not have separate docs for devices that don't really have
any device tree data other than where they are.

Few more bits inline.  
> ---
>   No changes - resending because I forgot to cc devicetree.
>  .../devicetree/bindings/i2c/trivial-devices.txt    |  1 +
>  .../devicetree/bindings/iio/light/us5182d.txt      | 24 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  3 files changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 00f8652..96d3b9c 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -99,4 +99,5 @@ ti,tsc2003		I2C Touch-Screen Controller
>  ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>  ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>  ti,tmp275		Digital Temperature Sensor
> +upisemi,usd5182		Als and Proximity Sensor
>  winbond,wpct301		i2c trusted platform module (TPM)
> diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
> new file mode 100644
> index 0000000..9ac3336
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
> @@ -0,0 +1,24 @@
> +* UPISEMI us5182d I2C ALS and Proximity sensor
> +
> +Required properties:
> +- compatible: must be "upisemi,usd5182"
> +- reg: the I2C address of the device
> +
> +Optional properties:
> +- upisemi,glass-coef: glass attenuation factor
> +- upisemi,dark-ths: array of thresholds corresponding to every scale
That needs more detail. I've read the driver and I am not sure what exactly
you mean!  Why should a scale have a threshold?
> +- upisemi,upper-dark-gain: tuning factor applied when light > th
> +- upisemi,lower-dark-gain: tuning factor applied when light < th
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
Not sure why these are in hex.. Or why we care if they are 8 bits.  If there is a limit
on the possible values, perhaps mention it in the docs above.


> +    };
> +
One blank line at the end is neough.
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

