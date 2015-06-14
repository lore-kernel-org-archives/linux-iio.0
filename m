Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43116 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbbFNLQK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2015 07:16:10 -0400
Message-ID: <557D6277.3080601@kernel.org>
Date: Sun, 14 Jun 2015 12:16:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>,
	Sanchayan Maity <maitysanchayan@gmail.com>
CC: Shawn Guo <shawn.guo@linaro.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Fugang Duan <B38611@freescale.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v1 1/2] iio: adc: Determine sampling frequencies by using
 minimum sample time
References: <cover.1433740528.git.maitysanchayan@gmail.com> <0e624f1c1efff7e209c93406f5d4bc51c41a9f45.1433740528.git.maitysanchayan@gmail.com> <CAL_JsqLyTo0jvC0rAKXB3ZLdMHeFjmMcCjd7i04D4jqHKUUvqQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLyTo0jvC0rAKXB3ZLdMHeFjmMcCjd7i04D4jqHKUUvqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/06/15 18:51, Rob Herring wrote:
> On Mon, Jun 8, 2015 at 12:42 AM, Sanchayan Maity
> <maitysanchayan@gmail.com> wrote:
>> The driver currently does not take into account the minimum sample time
>> as per the Figure 6-8 Chapter 9.1.1 12-bit ADC electrical characteristics.
>> We set a static amount of cycles instead of considering the sample time as
>> a given value, which depends on hardware characteristics.
>>
>> Determine sampling frequencies by first reading the device tree property
>> node and then calculating the required Long Sample Time Adder (LSTAdder)
>> value based on the ADC clock frequency and sample time value obtained
>> from the device tree, this LSTAdder value is then used for calculating
>> the sampling frequencies possible.
>>
>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>> ---
>>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |  6 ++
>>  drivers/iio/adc/vf610_adc.c                        | 74 ++++++++++++++++++++--
>>  2 files changed, 76 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>> index 3eb40e2..4419126 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>> +++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>> @@ -17,6 +17,11 @@ Recommended properties:
>>    - Frequency in normal mode (ADLPC=0, ADHSC=0)
>>    - Frequency in high-speed mode (ADLPC=0, ADHSC=1)
>>    - Frequency in low-power mode (ADLPC=1, ADHSC=0)
>> +  - fsl,min-sample-time: Minimum sampling time in nanoseconds. This value has
> 
> Add a "-ns' suffix.
> 
> Seems like this could be a common ADC property.
Could be but so far this is a first I think... 

Obviously there are constraints on when you'll get a 'good' answer from any
ADC but often they are not so well defined in the datasheets as we have here.

Having said that, certainly could turn up elsewhere so I've no problem with
having it as normal (non vendor specific) property.
> 
>> +    to be chosen according to the conversion mode and the connected analog
>> +        source resistance (R_as) and capacitance (C_as). Refer the datasheet's
>> +        operating requirements. A safe default across a wide range of R_as and
>> +        C_as as well as conversion modes is 1000ns.
>>
>>  Example:
>>  adc0: adc@4003b000 {
>> @@ -27,5 +32,6 @@ adc0: adc@4003b000 {
>>         clock-names = "adc";
>>         fsl,adck-max-frequency = <30000000>, <40000000>,
>>                                 <20000000>;
>> +       fsl,min-sample-time = <1000>;
>>         vref-supply = <&reg_vcc_3v3_mcu>;
>>  };
>> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
>> index 480f335..bcae8fd 100644
>> --- a/drivers/iio/adc/vf610_adc.c
>> +++ b/drivers/iio/adc/vf610_adc.c
>> @@ -68,6 +68,9 @@
>>  #define VF610_ADC_CLK_DIV8             0x60
>>  #define VF610_ADC_CLK_MASK             0x60
>>  #define VF610_ADC_ADLSMP_LONG          0x10
>> +#define VF610_ADC_ADSTS_SHORT   0x100
>> +#define VF610_ADC_ADSTS_NORMAL  0x200
>> +#define VF610_ADC_ADSTS_LONG    0x300
>>  #define VF610_ADC_ADSTS_MASK           0x300
>>  #define VF610_ADC_ADLPC_EN             0x80
>>  #define VF610_ADC_ADHSC_EN             0x400
>> @@ -124,6 +127,17 @@ enum conversion_mode_sel {
>>         VF610_ADC_CONV_LOW_POWER,
>>  };
>>
>> +enum lst_adder_sel {
>> +       VF610_ADCK_CYCLES_3,
>> +       VF610_ADCK_CYCLES_5,
>> +       VF610_ADCK_CYCLES_7,
>> +       VF610_ADCK_CYCLES_9,
>> +       VF610_ADCK_CYCLES_13,
>> +       VF610_ADCK_CYCLES_17,
>> +       VF610_ADCK_CYCLES_21,
>> +       VF610_ADCK_CYCLES_25,
>> +};
>> +
>>  struct vf610_adc_feature {
>>         enum clk_sel    clk_sel;
>>         enum vol_ref    vol_ref;
>> @@ -132,6 +146,8 @@ struct vf610_adc_feature {
>>         int     clk_div;
>>         int     sample_rate;
>>         int     res_mode;
>> +       u32 lst_adder_index;
>> +       u32 default_sample_time;
>>
>>         bool    calibration;
>>         bool    ovwren;
>> @@ -155,11 +171,13 @@ struct vf610_adc {
>>  };
>>
>>  static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
>> +static const u32 vf610_lst_adder[] = { 3, 5, 7, 9, 13, 17, 21, 25 };
>>
>>  static inline void vf610_adc_calculate_rates(struct vf610_adc *info)
>>  {
>>         struct vf610_adc_feature *adc_feature = &info->adc_feature;
>>         unsigned long adck_rate, ipg_rate = clk_get_rate(info->clk);
>> +       u32 adck_period, lst_addr_min;
>>         int divisor, i;
>>
>>         adck_rate = info->max_adck_rate[adc_feature->conv_mode];
>> @@ -174,6 +192,19 @@ static inline void vf610_adc_calculate_rates(struct vf610_adc *info)
>>         }
>>
>>         /*
>> +        * Determine the long sample time adder value to be used based
>> +        * on the default minimum sample time provided.
>> +        */
>> +       adck_period = NSEC_PER_SEC / adck_rate;
>> +       lst_addr_min = adc_feature->default_sample_time / adck_period;
>> +       for (i = 0; i < ARRAY_SIZE(vf610_lst_adder); i++) {
>> +               if (vf610_lst_adder[i] > lst_addr_min) {
>> +                       adc_feature->lst_adder_index = i;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       /*
>>          * Calculate ADC sample frequencies
>>          * Sample time unit is ADCK cycles. ADCK clk source is ipg clock,
>>          * which is the same as bus clock.
>> @@ -182,12 +213,13 @@ static inline void vf610_adc_calculate_rates(struct vf610_adc *info)
>>          * SFCAdder: fixed to 6 ADCK cycles
>>          * AverageNum: 1, 4, 8, 16, 32 samples for hardware average.
>>          * BCT (Base Conversion Time): fixed to 25 ADCK cycles for 12 bit mode
>> -        * LSTAdder(Long Sample Time): fixed to 3 ADCK cycles
>> +        * LSTAdder(Long Sample Time): 3, 5, 7, 9, 13, 17, 21, 25 ADCK cycles
>>          */
>>         adck_rate = ipg_rate / info->adc_feature.clk_div;
>>         for (i = 0; i < ARRAY_SIZE(vf610_hw_avgs); i++)
>>                 info->sample_freq_avail[i] =
>> -                       adck_rate / (6 + vf610_hw_avgs[i] * (25 + 3));
>> +                       adck_rate / (6 + vf610_hw_avgs[i] *
>> +                        (25 + vf610_lst_adder[adc_feature->lst_adder_index]));
>>  }
>>
>>  static inline void vf610_adc_cfg_init(struct vf610_adc *info)
>> @@ -347,8 +379,40 @@ static void vf610_adc_sample_set(struct vf610_adc *info)
>>                 break;
>>         }
>>
>> -       /* Use the short sample mode */
>> -       cfg_data &= ~(VF610_ADC_ADLSMP_LONG | VF610_ADC_ADSTS_MASK);
>> +       /*
>> +        * Set ADLSMP and ADSTS based on the Long Sample Time Adder value
>> +        * determined.
>> +        */
>> +       switch (adc_feature->lst_adder_index) {
>> +       case VF610_ADCK_CYCLES_3:
>> +               break;
>> +       case VF610_ADCK_CYCLES_5:
>> +               cfg_data |= VF610_ADC_ADSTS_SHORT;
>> +               break;
>> +       case VF610_ADCK_CYCLES_7:
>> +               cfg_data |= VF610_ADC_ADSTS_NORMAL;
>> +               break;
>> +       case VF610_ADCK_CYCLES_9:
>> +               cfg_data |= VF610_ADC_ADSTS_LONG;
>> +               break;
>> +       case VF610_ADCK_CYCLES_13:
>> +               cfg_data |= VF610_ADC_ADLSMP_LONG;
>> +               break;
>> +       case VF610_ADCK_CYCLES_17:
>> +               cfg_data |= VF610_ADC_ADLSMP_LONG;
>> +               cfg_data |= VF610_ADC_ADSTS_SHORT;
>> +               break;
>> +       case VF610_ADCK_CYCLES_21:
>> +               cfg_data |= VF610_ADC_ADLSMP_LONG;
>> +               cfg_data |= VF610_ADC_ADSTS_NORMAL;
>> +               break;
>> +       case VF610_ADCK_CYCLES_25:
>> +               cfg_data |= VF610_ADC_ADLSMP_LONG;
>> +               cfg_data |= VF610_ADC_ADSTS_NORMAL;
>> +               break;
>> +       default:
>> +               dev_err(info->dev, "error in sample time select\n");
>> +       }
>>
>>         /* update hardware average selection */
>>         cfg_data &= ~VF610_ADC_AVGS_MASK;
>> @@ -712,6 +776,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
>>
>>         of_property_read_u32_array(pdev->dev.of_node, "fsl,adck-max-frequency",
>>                         info->max_adck_rate, 3);
>> +       of_property_read_u32(pdev->dev.of_node, "fsl,min-sample-time",
>> +                       &info->adc_feature.default_sample_time);
>>
>>         platform_set_drvdata(pdev, indio_dev);
>>
>> --
>> 2.4.2
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

