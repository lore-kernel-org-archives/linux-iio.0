Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41223 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbIEPMF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 11:12:05 -0400
Subject: Re: [[PATCH v2] 1/2] Altera Modular ADC driver device binding
To: Chee Nouk Phoo <cnphoon@altera.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1441144199-20231-1-git-send-email-cnphoon@altera.com>
 <1441144199-20231-2-git-send-email-cnphoon@altera.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	cnphoon.linux@gmail.com, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Message-ID: <55EB0642.5060107@kernel.org>
Date: Sat, 5 Sep 2015 16:12:02 +0100
MIME-Version: 1.0
In-Reply-To: <1441144199-20231-2-git-send-email-cnphoon@altera.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/15 22:49, Chee Nouk Phoo wrote:
> From: Chee Nouk Phoon <cnphoon@altera.com>
> 
> Altera Modular ADC is soft IP that wraps the hardened ADC block in a Max10
> device. It can be configured to dual ADC mode that supports two channel
> synchronous sampling or independent single ADCs. ADC sampled values will be
> written into memory slots in sequence determined by a user configurable
> sequencer block.
> 
> This patch adds Altera Modular ADC driver device tree binding
I think the convention is still to explicitly cc all device tree maintainers on bindings
patches (added).

A few bits and pieces in line.  Basically I'd like more explanation + examples to
make it clear what is going on.  This hardware has some unusual corners
(inherent in being a highly configurable bit of IP) so perhaps needs more than
we would normally expect in the way of description

Thanks,

Jonathan
> 
> Signed-off-by: Chee Nouk Phoon <cnphoon@altera.com>
> ---
>  .../bindings/iio/adc/altr,modular-adc.txt          |   63 ++++++++++++++++++++
>  1 files changed, 63 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/altr,modular-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/altr,modular-adc.txt b/Documentation/devicetree/bindings/iio/adc/altr,modular-adc.txt
> new file mode 100644
> index 0000000..faafcac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/altr,modular-adc.txt
> @@ -0,0 +1,63 @@
> +Altera Modular (Dual) ADC
> +
> +This binding document describes both Altera Modular ADC and Altera Modular Dual
> +ADC. Both options can be configured during generation time in Qsys. This driver
> +only supports standard sequencer with Avalon-MM sample storage with up to 64
> +memory slots.
> +
> +Required properties:
> +- compatible: must be one of the following strings
> +  "altr,modular-adc-1.0": single ADC configuration
> +  "altr,modular-dual-adc-1.0": dual ADC configuration
> +
> +- reg: Address and length of the register set for the device. It contains the
> +  information of registers in the same order as described by reg-names
> +
> +- reg-names: Should contain the reg names
> +  "sequencer_csr": register region for adc sequencer block
> +  "sample_store_csr": register region for sample store block
> +
> +- interrupts: interrupt line for ADC
Normal to add a cross reference here to the standard interrupt binding
docs (as there are loads of ways of specifying an interrupt!)
> +
> +- altr,adc-mode : ADC configuration
> +  1: single ADC mode
> +  2: dual ADC mode
I'd guess this is only relevant if the compatible is the dual-adc version?
Please document that if so.
> +
> +- altr,adc-slot-count : specify number of conversion slot in use
slots  Could you add an example below of multiple slots in use?
Would make it clearer what is going on here and what the expected
syntax is for the bindings.

> +
> +- altr,adc<ADC index>-slot-sequence-<slot index>: specify ADC channel
> +  conversion sequence
> +  <ADC index>: instantiated ADC number
> +  <slot index>: slot index for ADC memory slot
What for does the value take?

> +
> +- altr,adc-number : specify ADC number when single ADC mode is selected
> +  1: 1st ADC
> +  2: 2nd ACD
ADC

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
These needs some comments to explain the settings.
There is more here than simply dual vs single ADCs.  Perhaps
even a more complex example with multipel slots in use would
clarify things?  As I understand it the slot sequencing is baked
into the fpga logic and not configurable at runtime?
Perhaps add some detail of that in this document as well to make it
easier to review.

> +  altr,adc1-slot-sequence-1 = <6>;
> +  altr,adc2-slot-sequence-1 = <6>;
> +};
There's a hint here.  There should be a new line at the end of the file ;)

> \ No newline at end of file
> 

