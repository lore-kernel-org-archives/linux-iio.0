Return-Path: <mark.rutland@arm.com>
Date: Tue, 26 Nov 2013 14:09:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Fugang Duan <B38611@freescale.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
   "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>,
   "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
   "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
   "b20596@freescale.com" <b20596@freescale.com>,
   "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] Documentation: add the binding file for
 Freescale vf610 ADC driver
Message-ID: <20131126140926.GA5402@e106331-lin.cambridge.arm.com>
References: <1385463394-11157-1-git-send-email-B38611@freescale.com>
 <1385463394-11157-4-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385463394-11157-4-git-send-email-B38611@freescale.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Nov 26, 2013 at 10:56:34AM +0000, Fugang Duan wrote:
> The patch adds the binding file for Freescale vf610 ADC driver.
> 
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> ---
>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |   57 ++++++++++++++++++++
>  1 files changed, 57 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> new file mode 100644
> index 0000000..4101516
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
> @@ -0,0 +1,57 @@
> +Freescale vf610 Analog to Digital Converter bindings
> +
> +The devicetree bindings are for the new ADC driver written for
> +vf610/i.MX6slx and upward SoCs from Freescale.
> +
> +Required properties:
> +- compatible: Should be "fsl,vf610-adc"

s/be/contain/

> +- reg: Offset and length of the register set for the device
> +- interrupts: Should contain the interrupt for the device
> +- clocks: The clocks needed by the ADC controller

How many? Which ones?

> +- clock-names: the name of the clocks

Either define the set of names, or don't use clock-names. It's useless
if it doesn't tell you anything.

> +
> +Optional properties:
> +- fsl,adc-io-pinctl: Enable field for the I/O port control of MCU pins used as analog inputs.
> +- fsl,adc-vref: ADC refrence voltage value, unit is uV.

Can you not query the regulator to figure this out?

> +- fsl,adc-clk-div: Current clock divider value, such as 1,2,4,8,16 and so on.

Could you elaborate on this? What's it used for and why is it needed?

> +- fsl,adc-res: ADC conversion mode selection, such as 8 for 8-bit, 10 for 10-bit, 12 for 12-bit mode.

This sounds like something that could be changed at runtime. Why does
this need to be configured in the DT?

> +- fsl,adc-sam-time: ADC sample time duration, number of ADC clocks, such as 2, 4, 6, 8, 12, 16, 20, 24

Likewise.

Please don't poinltessly abbreviate, "sample" is much better than "sam"
here...

> +- fsl,adc-aver-sam-sel: Determines how many ADC conversions will be averaged to create the ADC average result.
> +			The Optional value is 4, 8, 16, 32.

Likewise.

> +- fsl,adc-hw-aver-en: Bool type to decide enable hardware average function.

When would you wnat this and when wouldn't you?

Similarly, "averages" is far clearer than "aver".

> +- fsl,adc-low-power-mode: Bool type to decide enable ADC low power mode.

Similarly?

> +- fsl,adc-high-speed-conv: Bool type to decide enable ADC high speed mode.

Similarly?

> +- vref: The regulator to support ADC refrence voltage.

s/vref/vref-supply/

Thanks,
Mark.
