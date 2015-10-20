Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42021 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbbJTQY3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 20 Oct 2015 12:24:29 -0400
Date: Tue, 20 Oct 2015 09:24:26 -0700
From: Tony Lindgren <tony@atomide.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marek Belisko <marek@goldelico.com>,
	Pradeep Goudagunta <pgoudagunta@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Graeme Gregory <gg@slimlogic.co.uk>,
	jic23@jic23.retrosnub.co.uk, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	linux-iio@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: omap5-uevm: enable iio gpadc for Palmas
Message-ID: <20151020162425.GH3078@atomide.com>
References: <cover.1445000017.git.hns@goldelico.com>
 <05c57453151c9e2cbd3f15145f1e15223410cd87.1445000017.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <05c57453151c9e2cbd3f15145f1e15223410cd87.1445000017.git.hns@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

* H. Nikolaus Schaller <hns@goldelico.com> [151016 05:58]:
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap5-uevm.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 0e8128b..63f81bb 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -342,6 +342,16 @@
>  
>  			ti,ldo6-vibrator;
>  
> +			gpadc {
> +				compatible = "ti,palmas-gpadc";
> +				interrupts = <18 0
> +					      16 0
> +					      17 0>;
> +				#io-channel-cells = <1>;
> +				ti,channel0-current-microamp = <5>;
> +				ti,channel3-current-microamp = <10>;
> +			};
> +
>  			regulators {
>  				smps123_reg: smps123 {
>  					/* VDD_OPP_MPU */

FYI, please send this one separately once the binding and driver is
merged.

This need to be updated arch/arm/boot/dts/omap5-board-common.dts, so
this will cause merge conflicts if applied with the driver.

Regards,

Tony
