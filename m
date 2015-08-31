Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38598 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbbHaR2V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 13:28:21 -0400
Subject: Re: [PATCH] Altera Modular ADC driver device tree binding
To: Chee Nouk Phoo <cnphoon@altera.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1440056795-6190-1-git-send-email-cnphoon@altera.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	cnphoon.linux@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55E48EB1.4030700@kernel.org>
Date: Mon, 31 Aug 2015 18:28:17 +0100
MIME-Version: 1.0
In-Reply-To: <1440056795-6190-1-git-send-email-cnphoon@altera.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 08:46, Chee Nouk Phoo wrote:
> From: Chee Nouk Phoon <cnphoon@altera.com>
> 
> Altera Modular ADC is soft IP that wraps the hardened ADC block in a Max1
> device. It can be configured to dual ADC mode that supports two channel
> synchronous sampling or independent single ADCs. ADC sampled values will be
> written into memory slots in sequence determined by a user configurable
> sequencer block.
> 
> This patch adds device tree binding for Altera Modular ADC driver
> 
> Signed-off-by: Chee Nouk Phoon <cnphoon@altera.com>
> ---
>  .../bindings/iio/adc/altr,modular-adc.txt          |   63 ++++++++++++++++++++
>  1 files changed, 63 insertions(+), 0 deletions(-)
>  create mode 100755 Documentation/devicetree/bindings/iio/adc/altr,modular-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/altr,modular-adc.txt b/Documentation/devicetree/bindings/iio/adc/altr,modular-adc.txt
> new file mode 100755
> index 0000000..4106cb4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/altr,modular-adc.txt
> @@ -0,0 +1,63 @@
> +Altera Modular (Dual) ADC
> +
> +This binding document describes both Altera Modular ADC and Altera Modular Dual
> +ADC. Both options can be configured during generation time in Qsys. This driver
> +only support standard sequencer with Avalon-MM sample storage with up to 64
> +memory slots.
> +
> +Required properties:
> +- compatible: must be one of the following strings
> +  "altr,modular-adc": single ADC configuration
> +  "altr,modular-dual-adc": dual ADC configuration
> +
> +- reg: Address and length of the register set for the device. It contains the
> +  information of registers in the same order as described by reg-names
> +
> +- reg-names: Should contain the reg names
> +  "sequencer_csr": register region for adc sequencer block
> +  "sample_store_csr": register region for sample store block
> +
> +- interrupts: interrupt line for ADC
> +
> +- altr,adc-mode : ADC configuration
> +  1: single ADC mode
> +  2: dual ADC mode
> +
> +- altr,adc-slot-count : specify number of conversion slot in use
> +
> +- altr,adc<ADC index>-slot-sequence-<slot index>: specify ADC channel 
> +  conversion sequence
> +  <ADC index>: instantiated ADC number
> +  <slot index>: slot index for ADC memory slot
> +
> +- altr,adc-number : specify ADC number when single ADC mode is selected
> +  1: 1st ADC
> +  2: 2nd ACD
> +
> +Example: single ADC
> +modular_adc_0: adc@0x20000200 {
> +  compatible = "altr,modular-adc";
> +  reg = <0x20000000 0x00000008>,
> +    <0x20000200 0x00000200>;
> +  reg-names = "sequencer_csr", "sample_store_csr";
> +  interrupt-parent = <&cpu>;
> +  interrupts = <8>;
> +  altr,adc-mode = <1>;
> +  altr,adc-slot-count = <2>;
> +  altr,adc1-slot-sequence-1 = <1>;
> +  altr,adc-number = <1>;
> +};
> +
> +Example: dual ADC
> +modular_adc_1: adc@0x18002200 {
> +  compatible = "altr,modular-dual-adc";
> +  reg = <0x18002000 0x00000008>,
> +    <0x18002200 0x00000200>;
> +  reg-names = "sequencer_csr", "sample_store_csr";
> +  interrupt-parent = <&cpu>;
> +  interrupts = <8>;
> +  altr,adc-mode = <2>;
> +  altr,adc-slot-count = <1>;
> +  altr,adc1-slot-sequence-1 = <6>;
> +  altr,adc2-slot-sequence-1 = <6>;
> +};
> \ No newline at end of file
> 

