Return-Path: <Josh.wu@atmel.com>
Message-ID: <51E50DCC.4010107@atmel.com>
Date: Tue, 16 Jul 2013 17:09:32 +0800
From: Josh Wu <josh.wu@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: <jic23@cam.ac.uk>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] iio: at91: introduce touch screen support in iio
 adc driver
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-6-git-send-email-josh.wu@atmel.com> <20130715131507.GE2962@lukather>
In-Reply-To: <20130715131507.GE2962@lukather>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi, Maxime

On 7/15/2013 9:15 PM, Maxime Ripard wrote:
> Hi Josh,
>
> On Sun, Jul 14, 2013 at 04:04:29PM +0800, Josh Wu wrote:
>> AT91 ADC hardware integrate touch screen support. So this patch add touch
>> screen support for at91 adc iio driver.
>> To enable touch screen support in adc, you need to add the dt parameters:
>>    which type of touch are used? (4 or 5 wires), sample period time,
>>    pen detect debounce time, average samples and pen detect resistor.
>>
>> In the meantime, since touch screen will use a interal period trigger of adc,
>> so it is conflict to other hardware triggers. Driver will disable the hardware
>> trigger support if touch screen is enabled.
>>
>> This driver has been tested in AT91SAM9X5-EK and SAMA5D3x-EK.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>   .../devicetree/bindings/arm/atmel-adc.txt          |   13 +
>>   arch/arm/mach-at91/include/mach/at91_adc.h         |   34 ++
>>   drivers/iio/adc/at91_adc.c                         |  389 ++++++++++++++++++--
>>   3 files changed, 412 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> index 0db2945..925d656 100644
>> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
>> @@ -29,6 +29,19 @@ Optional properties:
>>     - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
>>     - atmel,adc-clock-rate: ADC clock rate. If not specified, use the default
>>   			  adc_op_clk.
>> +  - atmel,adc-touchscreen-wires: Number of touch screen wires. Only support
>> +				 4 and 5 wires touch screen.
>> +    NOTE: when adc touch screen enabled, the adc hardware trigger will be
>> +          disabled. Since touch screen will occupied the trigger register.
>> +  - atmel,adc-ts-pendet-debounce: Debounce time in microsecond for touch pen
>> +				  detect.
>> +  - atmel,adc-ts-sample-period-time: Sample Period Time in microsecond for
>> +				     touch screen
>> +  - atmel,adc-ts-filter-average: Numbers of sampling data will be averaged.
>> +    0 means no average. 1 means average two samples. 2 means average four
>> +    samples. 3 means average eight samples.
>> +  - atmel,adc-ts-pendet-sensitivity: Pen Detection input pull-up resistor.
>> +    It can be 0, 1, 2, 3.
> Could you expand a bit on what are these properties for? Are they
> board-specific? IP-specific?

+  - atmel,adc-touchscreen-wires: Number of touch screen wires. Only support
+                 4 and 5 wires touch screen.
+    NOTE: when adc touch screen enabled, the adc hardware trigger will be
+          disabled. Since touch screen will occupied the trigger register.

It is board specific. Currently in AT91SAM9M10G45EK, AT91SAM9X5-EK, 
SAMA5D3x-EK all use 4 wire touch.
Now the driver not support 5 wire yet.

+  - atmel,adc-ts-pendet-debounce: Debounce time in microsecond for 
touch pen
+                  detect.

de-glitch time for pen detect. Board specific.

+  - atmel,adc-ts-sample-period-time: Sample Period Time in microsecond for
+                     touch screen

The period to sample a touch data after pen is touched. Board specific.

+  - atmel,adc-ts-filter-average: Numbers of sampling data will be averaged.
+    0 means no average. 1 means average two samples. 2 means average four
+    samples. 3 means average eight samples.
+  - atmel,adc-ts-pendet-sensitivity: Pen Detection input pull-up resistor.
+    It can be 0, 1, 2, 3.

Above two properties only supported in SAM9X5, SAMA5D3 IP.

>
> [...]
>
>> +#define DRIVER_NAME		"at91_adc"
> This looks like this part doesn't belong to another cleanup patch.

it is part of this patch. As it's a little cleanup, I integrate it as 
add touch feature.

>
>> +#define MAX_POS_BITS		12
>> +
>> +#define ZTHRESHOLD		9000
>> +
>>   struct at91_adc_caps {
>> +	bool	has_12bits_xy;	/* true means use 12 bits. Otherwise 10 bits */
> Isn't that redundant with the low_res boolean?

yes, right. I will remove it.

>
>>   	bool	has_tsmr;	/* only at91sam9x5, sama5d3 have TSMR reg */
>>   	u32	mr_prescal_mask;
>>   	u32	mr_startup_mask;
>>   };
>>   
>> +enum atmel_adc_ts_type {
>> +	ATMEL_ADC_TOUCHSCREEN_NONE = 0,
>> +	ATMEL_ADC_TOUCHSCREEN_4WIRE,
>> +	ATMEL_ADC_TOUCHSCREEN_5WIRE,
>> +};
>> +
>>   struct at91_adc_state {
>>   	struct clk		*adc_clk;
>>   	u32			adc_clk_rate;
>> @@ -70,6 +83,29 @@ struct at91_adc_state {
>>   	bool			low_res;	/* the resolution corresponds to the lowest one */
>>   	wait_queue_head_t	wq_data_avail;
>>   	struct at91_adc_caps	caps;
>> +
>> +	/*
>> +	 * Following ADC channels are shared by touchscreen:
>> +	 *
>> +	 * CH0 -- Touch screen XP/UL
>> +	 * CH1 -- Touch screen XM/UR
>> +	 * CH2 -- Touch screen YP/LL
>> +	 * CH3 -- Touch screen YM/Sense
>> +	 * CH4 -- Touch screen LR(5-wire only)
>> +	 *
>> +	 * The bitfields below represents the reserved channel in the
>> +	 * touchscreen mode.
>> +	 */
>> +#define CHAN_MASK_TOUCHSCREEN_4WIRE	(0xf << 0)
>> +#define CHAN_MASK_TOUCHSCREEN_5WIRE	(0x1f << 0)
>> +	enum atmel_adc_ts_type	touchscreen_type;
>> +	struct input_dev		*ts_input;
>> +
>> +	u8			ts_filter_average;
>> +	u16			ts_pen_detect_debounce;
>> +	u8			ts_pen_detect_sensitivity;
>> +	u16			ts_sample_period_time;
>> +	u16			ts_sample_period_val;
>>   };
>>   
>>   static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>> @@ -104,14 +140,10 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> -static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
>> +/* Handler for classic adc channel eoc trigger */
>> +void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
>>   {
>> -	struct iio_dev *idev = private;
>>   	struct at91_adc_state *st = iio_priv(idev);
>> -	u32 status = at91_adc_readl(st, st->registers->status_register);
>> -
>> -	if (!(status & st->registers->drdy_mask))
>> -		return IRQ_HANDLED;
> Why are you changing the prototype and remove most of the useful part
> out of the handler?

I change the protype because I make it as a sub interrupt handler.
Since I just add a new interrupt handler which will check the interrupt 
type, if DRDY interrupt is coming, it will call your original handler.
Otherwise use touch screen interrupt handler code.

Following is the new interrupt handler code in this patch:

+static irqreturn_t at91_adc_interrupt(int irq, void *private)
+{
+	struct iio_dev *idev = private;
+	struct at91_adc_state *st = iio_priv(idev);
+	u32 status = at91_adc_readl(st, st->registers->status_register);
+	const uint32_t ts_data_irq_mask =
+		AT91_ADC_IER_XRDY |
+		AT91_ADC_IER_YRDY |
+		AT91_ADC_IER_PRDY;
+
+	if (status & st->registers->drdy_mask)
+		handle_adc_eoc_trigger(irq, idev);

                              ^
                              |
here we call original trigger handler.

+
+	if (status & AT91_ADC_IER_PEN) {
+		at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_PEN);
+		at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_NOPEN |
+			ts_data_irq_mask);
+		/* Set up period trigger for sampling */
+		at91_adc_writel(st, st->registers->trigger_register,
+			AT91_ADC_TRGR_MOD_PERIOD_TRIG |
+			AT91_ADC_TRGR_TRGPER_(st->ts_sample_period_val));
+	} else if (status & AT91_ADC_IER_NOPEN) {
+		at91_adc_writel(st, st->registers->trigger_register, 0);
+		at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_NOPEN |
+			ts_data_irq_mask);
+		at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_PEN);
+
+		input_report_key(st->ts_input, BTN_TOUCH, 0);
+		input_sync(st->ts_input);
+	} else if ((status & ts_data_irq_mask) == ts_data_irq_mask) {

Those code will handle for the Touch screen interrupt.

>
> Maxime
>

Thanks.
Best Regards,
Josh Wu
