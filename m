Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f195.google.com ([209.85.214.195]:36106 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbcFTSFC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2016 14:05:02 -0400
Date: Mon, 20 Jun 2016 13:04:58 -0500
From: Rob Herring <robh@kernel.org>
To: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Pawel Moll <pawel.moll@arm.com>,
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
Subject: Re: [PATCH v2 1/3] Documentation: DT: Add iproc-static-adc binding
Message-ID: <20160620180458.GA10171@rob-hp-laptop>
References: <1466330790-2820-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1466330790-2820-2-git-send-email-raveendra.padasalagi@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466330790-2820-2-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jun 19, 2016 at 03:36:28PM +0530, Raveendra Padasalagi wrote:
> The patch adds devicetree binding document for broadcom's
> iproc-static-adc controller driver.
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../bindings/iio/adc/brcm,iproc-static-adc.txt     | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
> new file mode 100644
> index 0000000..1de0dfa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
> @@ -0,0 +1,43 @@
> +* Broadcom's IPROC Static ADC controller
> +
> +Required properties:
> +
> +- compatible: Must be "brcm,iproc-static-adc"
> +

> +- #address-cells: Specify the number of u32 entries needed in child nodes.
> +  Should set to 1.
> +
> +- #size-cells: Specify number of u32 entries needed to specify child nodes size
> +  in reg property. Should set to 1.

Why are these needed? What child nodes can you have?

> +
> +- adc-syscon: Handler of syscon node defining physical base address of the
> +  controller and length of memory mapped region.
> +
> +- #io-channel-cells = <1>; As ADC has multiple outputs
> +  refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
> +
> +- clocks: Clock used for this block.
> +
> +- clock-names: Clock name should be given as tsc_clk.
> +
> +- interrupts: interrupt line number.
> +
> +For example:
> +
> +	ts_adc_syscon: ts_adc_syscon@180a6000 {
> +		compatible = "brcm,iproc-ts-adc-syscon","syscon";
> +		reg = <0x180a6000 0xc30>;
> +	};
> +
> +	adc: adc@180a6000 {
> +		compatible = "brcm,iproc-static-adc";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		adc-syscon = <&ts_adc_syscon>;
> +		#io-channel-cells = <1>;
> +		io-channel-ranges;
> +		clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
> +		clock-names = "tsc_clk";
> +		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +	};
> -- 
> 1.9.1
> 
