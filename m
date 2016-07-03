Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57426 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbcGCKes (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 06:34:48 -0400
Subject: Re: [PATCH v4 3/3] ARM:dts-Add dt node for Broadcom iproc-static-adc
To: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1467099636-31855-4-git-send-email-raveendra.padasalagi@broadcom.com>
Cc: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Richardson <jonathar@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Anup Patel <anup.patel@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Pramod Kumar <pramod.kumar@broadcom.com>,
	linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <184c47dc-6cdb-c314-9f29-7b03d5784de6@kernel.org>
Date: Sun, 3 Jul 2016 11:34:46 +0100
MIME-Version: 1.0
In-Reply-To: <1467099636-31855-4-git-send-email-raveendra.padasalagi@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/06/16 08:40, Raveendra Padasalagi wrote:
> This patch adds DT node for Broadcom's iproc-static-adc
> controller driver.
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Driver is working its way towards just making the next merge window...

Guessing this will go through the relevant path to the arm-soc tree
as normal.

Thanks,

Jonathan
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index b42fe55..fabc9f3 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -366,5 +366,16 @@
>  			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
>  			status = "disabled";
>  		};
> +
> +		adc: adc@180a6000 {
> +			compatible = "brcm,iproc-static-adc";
> +			#io-channel-cells = <1>;
> +			io-channel-ranges;
> +			adc-syscon = <&ts_adc_syscon>;
> +			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
> +			clock-names = "tsc_clk";
> +			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
>  	};
>  };
> 

