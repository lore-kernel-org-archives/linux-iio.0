Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46227 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbcFZKYk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 06:24:40 -0400
Subject: Re: [PATCH v3 1/3] Documentation: DT: Add iproc-static-adc binding
To: Rob Herring <robh@kernel.org>,
	Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
References: <1466575913-5027-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1466575913-5027-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <20160624154323.GA6046@rob-hp-laptop>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
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
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4c8870ef-8777-7016-465b-9c03463d01fa@kernel.org>
Date: Sun, 26 Jun 2016 11:24:36 +0100
MIME-Version: 1.0
In-Reply-To: <20160624154323.GA6046@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/06/16 16:43, Rob Herring wrote:
> On Wed, Jun 22, 2016 at 11:41:51AM +0530, Raveendra Padasalagi wrote:
>> The patch adds devicetree binding document for broadcom's
>> iproc-static-adc controller driver.
>>
>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  .../bindings/iio/adc/brcm,iproc-static-adc.txt     | 38 ++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
>> new file mode 100644
>> index 0000000..a82076e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
>> @@ -0,0 +1,38 @@
>> +* Broadcom's IPROC Static ADC controller
>> +
>> +Broadcom iProc ADC controller has 8 channels 10bit ADC.
>> +Allows user to convert analog input voltage values to digital.
>> +
>> +Required properties:
>> +
>> +- compatible: Must be "brcm,iproc-static-adc"
>> +
>> +- adc-syscon: Handler of syscon node defining physical base address of the
>> +  controller and length of memory mapped region.
>> +
>> +- #io-channel-cells = <1>; As ADC has multiple outputs
>> +  refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
>> +
>> +- clocks: Clock used for this block.
>> +
>> +- clock-names: Clock name should be given as tsc_clk.
>> +
>> +- interrupts: interrupt line number.
>> +
>> +For example:
>> +
>> +	ts_adc_syscon: ts_adc_syscon@180a6000 {
>> +		compatible = "brcm,iproc-ts-adc-syscon","syscon";
>> +		reg = <0x180a6000 0xc30>;
>> +	};
>> +
>> +	adc: adc@180a6000 {
>> +		compatible = "brcm,iproc-static-adc";
>> +		adc-syscon = <&ts_adc_syscon>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-ranges;
> 
> Not documented.
Core iio docs, but obviously a cross reference would be good.
> 
>> +		clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
>> +		clock-names = "tsc_clk";
>> +		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
>> +		status = "disabled";
>> +	};
>> -- 
>> 1.9.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

