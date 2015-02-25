Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37333 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbbBYUn4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Feb 2015 15:43:56 -0500
Message-ID: <54EDBBF0.7070307@kernel.org>
Date: Wed, 25 Feb 2015 12:11:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	devicetree@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Joe Perches <joe@perches.com>
CC: linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v7 6/7] power: da9150: Add DT binding documentation for
 charger
References: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com> <f6c1bb16817176c5f253aec7cb5a912219bd814a.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <f6c1bb16817176c5f253aec7cb5a912219bd814a.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/02/15 14:08, Adam Thomson wrote:
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  .../devicetree/bindings/power/da9150-charger.txt   | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/da9150-charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/da9150-charger.txt b/Documentation/devicetree/bindings/power/da9150-charger.txt
> new file mode 100644
> index 0000000..f390666
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/da9150-charger.txt
> @@ -0,0 +1,26 @@
> +Dialog Semiconductor DA9150 Charger Power Supply bindings
> +
> +Required properties:
> +- compatible: "dlg,da9150-charger" for DA9150 Charger Power Supply
> +
> +Optional properties:
> +- io-channels: List of phandle and IIO specifier pairs
> +- io-channel-names: List of channel names used by charger
> +      ["CHAN_IBUS", "CHAN_VBUS", "CHAN_TJUNC", "CHAN_VBAT"]
> +  (See Documentation/devicetree/bindings/iio/iio-bindings.txt for further info)
> +
> +
> +Example:
> +
> +	da9150-charger {
> +		compatible = "dlg,da9150-charger";
> +
> +		io-channels = <&gpadc 0>,
> +			      <&gpadc 2>,
> +			      <&gpadc 8>,
> +			      <&gpadc 5>;
> +		io-channel-names = "CHAN_IBUS",
> +				   "CHAN_VBUS",
> +				   "CHAN_TJUNC",
> +				   "CHAN_VBAT";
> +	};
> --
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

