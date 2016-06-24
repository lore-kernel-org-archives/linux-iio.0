Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34678 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbcFXPnZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jun 2016 11:43:25 -0400
Date: Fri, 24 Jun 2016 10:43:23 -0500
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
Subject: Re: [PATCH v3 1/3] Documentation: DT: Add iproc-static-adc binding
Message-ID: <20160624154323.GA6046@rob-hp-laptop>
References: <1466575913-5027-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1466575913-5027-2-git-send-email-raveendra.padasalagi@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466575913-5027-2-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 22, 2016 at 11:41:51AM +0530, Raveendra Padasalagi wrote:
> The patch adds devicetree binding document for broadcom's
> iproc-static-adc controller driver.
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../bindings/iio/adc/brcm,iproc-static-adc.txt     | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
> new file mode 100644
> index 0000000..a82076e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
> @@ -0,0 +1,38 @@
> +* Broadcom's IPROC Static ADC controller
> +
> +Broadcom iProc ADC controller has 8 channels 10bit ADC.
> +Allows user to convert analog input voltage values to digital.
> +
> +Required properties:
> +
> +- compatible: Must be "brcm,iproc-static-adc"
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
> +		adc-syscon = <&ts_adc_syscon>;
> +		#io-channel-cells = <1>;
> +		io-channel-ranges;

Not documented.

> +		clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
> +		clock-names = "tsc_clk";
> +		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +	};
> -- 
> 1.9.1
> 
