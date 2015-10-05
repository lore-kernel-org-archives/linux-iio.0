Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47652 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbbJELSR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 5 Oct 2015 07:18:17 -0400
Date: Mon, 5 Oct 2015 12:17:55 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marek Belisko <marek@goldelico.com>,
	Pradeep Goudagunta <pgoudagunta@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, gg@slimlogic.co.uk,
	jic23@jic23.retrosnub.co.uk, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-iio@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v2 2/3] iio:adc:palmas: add DT support
Message-ID: <20151005111754.GG19064@leverpostej>
References: <86F849CB-1A50-4BEB-99C6-79FF97971DCB@goldelico.com>
 <cover.1443973837.git.hns@goldelico.com>
 <6C211191-87B8-4444-ADA7-8BE454C2B3D3@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6C211191-87B8-4444-ADA7-8BE454C2B3D3@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Oct 04, 2015 at 06:05:59PM +0200, H. Nikolaus Schaller wrote:
> From: Marek Belisko <marek@goldelico.com>
> 
> Code was found at:
> https://android.googlesource.com/kernel/tegra/+/a90856a6626d502d42c6e7abccbdf9d730b36270%5E%21/#F1
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> [Fixed minor typos + add channels list to documentation]
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
> .../devicetree/bindings/iio/adc/palmas-gpadc.txt   | 46 +++++++++++++++++++
> drivers/iio/adc/palmas_gpadc.c                     | 52 +++++++++++++++++++---
> 2 files changed, 93 insertions(+), 5 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> new file mode 100644
> index 0000000..2149afe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> @@ -0,0 +1,46 @@
> +* Palmas general purpose ADC IP block devicetree bindings
> +
> +Channels list:
> +	0 battery type
> +	1 battery temp NTC (optional current source)
> +	2 GP
> +	3 temp (with ext. diode, optional current source)
> +	4 GP
> +	5 GP
> +	6 VBAT_SENSE
> +	7 VCC_SENSE
> +	8 Backup Battery voltage
> +	9 external charger (VCHG)
> +	10 VBUS
> +	11 DC-DC current probe (how does this work?)
> +	12 internal die temp
> +	13 internal die temp
> +	14 USB ID pin voltage
> +	15 test network
> +
> +Required properties:
> +- compatible : Must be "ti,palmas-gpadc".
> +
> +Optional sub-nodes:
> +ti,channel0-current-microamp: Channel 0 current in uA.
> +	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
> +ti,channel3-current-microamp: Channel 3 current in uA.
> +	Valid are rounded to derive 0uA, 10uA, 400uA, 800uA.

It's only possible to configure channels 0 and 3 in this manner?

> +ti,enable-extended-delay: Enable extended delay.

What is this? When would I select it? Why does it belong in the DT
rather than being a runtime option?

> +Example:
> +
> +pmic {
> +	compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
> +	...
> +	gpadc {
> +		compatible = "ti,palmas-gpadc";
> +		interrupts = <18 0
> +			      16 0
> +			      17 0>;
> +		ti,channel0-current-microamp = <5>;
> +		ti,channel3-current-microamp = <10>;
> +		};
> +	};
> +	...
> +};

I thought you needed #iio-cells for encoding the channel?

Mark.
