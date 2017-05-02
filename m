Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60658 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751206AbdEBMiw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 May 2017 08:38:52 -0400
Subject: Re: [PATCH] iio: stm32 trigger: Add support for TRGO2 triggers
To: Jonathan Cameron <jic23@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
References: <1493194662-14501-1-git-send-email-fabrice.gasnier@st.com>
 <CA+M3ks69FLm+2+t-QQNuGyi+gc-nyUw8rXUAM6WxzC9DurPPCw@mail.gmail.com>
 <11825bb8-ebb3-0679-7c65-3ee6b5ed2214@kernel.org>
 <baaa0dd4-67fe-da83-1431-1e026ec687cb@st.com>
 <72817113-a4c7-c1f7-0ae2-813df78f3acc@kernel.org>
CC: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <a59c48cf-65e8-36db-edfa-23fea78afe46@st.com>
Date: Tue, 2 May 2017 14:38:02 +0200
MIME-Version: 1.0
In-Reply-To: <72817113-a4c7-c1f7-0ae2-813df78f3acc@kernel.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/30/2017 07:07 PM, Jonathan Cameron wrote:
> On 28/04/17 15:52, Fabrice Gasnier wrote:
>> On 04/27/2017 07:49 AM, Jonathan Cameron wrote:
>>> On 26/04/17 09:55, Benjamin Gaignard wrote:
>>>> 2017-04-26 10:17 GMT+02:00 Fabrice Gasnier <fabrice.gasnier@st.com>:
>>>>> Add support for TRGO2 trigger that can be found on STM32F7.
>>>>> Add additional master modes supported by TRGO2.
>>> These additional modes would benefit from more information in the
>>> ABI docs.  Otherwise patch seems fine, though this may win
>>> the award for hardest hardware to come up with a generic
>>> interface for... 
>>>>> Register additional "tim[1/8]_trgo2" triggers for timer1 & timer8.
>>>>> Detect TRGO2 timer capability (master mode selection 2).
>>>>>
>>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>>> ---
>>>>>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  15 +++
>>>>>  drivers/iio/trigger/stm32-timer-trigger.c          | 113 ++++++++++++++++++---
>>>>>  include/linux/iio/timer/stm32-timer-trigger.h      |   2 +
>>>>>  include/linux/mfd/stm32-timers.h                   |   2 +
>>>>>  4 files changed, 118 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>>> index 230020e..47647b4 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>>> @@ -16,6 +16,21 @@ Description:
>>>>>                 - "OC2REF"    : OC2REF signal is used as trigger output.
>>>>>                 - "OC3REF"    : OC3REF signal is used as trigger output.
>>>>>                 - "OC4REF"    : OC4REF signal is used as trigger output.
>>>>> +               Additional modes (on TRGO2 only):
>>>>> +               - "OC5REF"    : OC5REF signal is used as trigger output.
>>>>> +               - "OC6REF"    : OC6REF signal is used as trigger output.
>>>>> +               - "compare_pulse_OC4REF":
>>>>> +                 OC4REF rising or falling edges generate pulses.
>>> I'd like this to be fairly understandable without resorting to reading the
>>> datasheet.  As I understand it you get a fixed term pulse on both edges
>>> of the waveform?  Perhaps this calls for some ascii art :)
>>
>> Hi Jonathan,
>>
>> If you feel like it needs more documentation, I'd rather prefer to add
>> reference or link to the datasheet... That will be more accurate,
>> up-to-date (e.g. like RM0385 pdf). Does this sound ok ? Or...
> Datasheet is good, but give it 10 years and chances are it will disappear
> into a black hole, whereas the hardware might still be in use by someone.
> Some of the hardware I use is at least that old. Frankly this laptop is
> getting close ;)
>>
>> Just in case, I prepared some ascii art, hope it clarify things.
>> I'm wondering if this is best place to put it ?
>> Shouldn't this be added in source code, instead of ABI Doc ?
> Could be either, but arguably the ABI docs should be all that a
> userspace developer should need to see.  This isn't an internal
> detail afterall.
>> Maybe I can skip 1st part of it, heading boxes? (only example is enough?
>> or not...)
>>
>> +-----------+   +-------------+            +---------+
>> | Prescaler +-> | Counter     |        +-> | Master  | TRGO(2)
>> +-----------+   +--+--------+-+        |-> | Control +-->
>>                    |        |          ||  +---------+
>>                 +--v--------+-+ OCxREF ||  +---------+
>>                 | Chx compare +----------> | Output  | ChX
>>                 +-----------+-+         |  | Control +-->
>>                       .     |           |  +---------+
>>                       .     |           |    .
>>                 +-----------v-+ OC6REF  |    .
>>                 | Ch6 compare +---------+>
>>                 +-------------+
>>
>> Example with: "compare_pulse_OC4REF_r_or_OC6REF_r":
>>
>>                 X
>>               X   X
>>             X .   . X
>>           X   .   .   X
>>         X     .   .     X
>> count X .     .   .     . X
>>         .     .   .     .
>>         .     .   .     .
>>         +---------------+
>> OC4REF  |     .   .     |
>>       +-+     .   .     +-+
>>         .     +---+     .
>> OC6REF  .     |   |     .
>>       +-------+   +-------+
>>         +-+   +-+
>> TRGO2   | |   | |
>>       +-+ +---+ +---------+
> This is good stuff so I'd put it in the ABI docs.
> 
Hi Jonathan,

Thanks, I just sent a v2 that includes this.

Best Regards,
Fabrice

> Jonathan
>>
>>
>> side note: this isn't my house ;-)
> :)
>>
>> Please advise,
>> Thanks,
>> Fabrice
>>
>>
>>>>> +               - "compare_pulse_OC6REF":
>>>>> +                 OC6REF rising or falling edges generate pulses.
>>>>> +               - "compare_pulse_OC4REF_r_or_OC6REF_r":
>>>>> +                 OC4REF or OC6REF rising edges generate pulses.
>>>>> +               - "compare_pulse_OC4REF_r_or_OC6REF_f":
>>>>> +                 OC4REF rising or OC6REF falling edges generate pulses.
>>>>> +               - "compare_pulse_OC5REF_r_or_OC6REF_r":
>>>>> +                 OC5REF or OC6REF rising edges generate pulses.
>>>>> +               - "compare_pulse_OC5REF_r_or_OC6REF_f":
>>>>> +                 OC5REF rising or OC6REF falling edges generate pulses.
>>>>>
>>>>>  What:          /sys/bus/iio/devices/triggerX/master_mode
>>>>>  KernelVersion: 4.11
>>>>> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
>>>>> index 0f1a2cf..a0031b7 100644
>>>>> --- a/drivers/iio/trigger/stm32-timer-trigger.c
>>>>> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
>>>>> @@ -14,19 +14,19 @@
>>>>>  #include <linux/module.h>
>>>>>  #include <linux/platform_device.h>
>>>>>
>>>>> -#define MAX_TRIGGERS 6
>>>>> +#define MAX_TRIGGERS 7
>>>>>  #define MAX_VALIDS 5
>>>>>
>>>>>  /* List the triggers created by each timer */
>>>>>  static const void *triggers_table[][MAX_TRIGGERS] = {
>>>>> -       { TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4,},
>>>>> +       { TIM1_TRGO, TIM1_TRGO2, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4,},
>>>>>         { TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4,},
>>>>>         { TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4,},
>>>>>         { TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4,},
>>>>>         { TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4,},
>>>>>         { TIM6_TRGO,},
>>>>>         { TIM7_TRGO,},
>>>>> -       { TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4,},
>>>>> +       { TIM8_TRGO, TIM8_TRGO2, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4,},
>>>>>         { TIM9_TRGO, TIM9_CH1, TIM9_CH2,},
>>>>>         { }, /* timer 10 */
>>>>>         { }, /* timer 11 */
>>>>> @@ -56,9 +56,16 @@ struct stm32_timer_trigger {
>>>>>         u32 max_arr;
>>>>>         const void *triggers;
>>>>>         const void *valids;
>>>>> +       bool has_trgo2;
>>>>>  };
>>>>>
>>>>> +static bool stm32_timer_is_trgo2_name(const char *name)
>>>>> +{
>>>>> +       return !!strstr(name, "trgo2");
>>>>> +}
>>>>> +
>>>>>  static int stm32_timer_start(struct stm32_timer_trigger *priv,
>>>>> +                            struct iio_trigger *trig,
>>>>>                              unsigned int frequency)
>>>>>  {
>>>>>         unsigned long long prd, div;
>>>>> @@ -102,7 +109,12 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>>>>>         regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
>>>>>
>>>>>         /* Force master mode to update mode */
>>>>> -       regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS, 0x20);
>>>>> +       if (stm32_timer_is_trgo2_name(trig->name))
>>>>> +               regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2,
>>>>> +                                  0x2 << TIM_CR2_MMS2_SHIFT);
>>>>> +       else
>>>>> +               regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS,
>>>>> +                                  0x2 << TIM_CR2_MMS_SHIFT);
>>>>>
>>>>>         /* Make sure that registers are updated */
>>>>>         regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
>>>>> @@ -150,7 +162,7 @@ static ssize_t stm32_tt_store_frequency(struct device *dev,
>>>>>         if (freq == 0) {
>>>>>                 stm32_timer_stop(priv);
>>>>>         } else {
>>>>> -               ret = stm32_timer_start(priv, freq);
>>>>> +               ret = stm32_timer_start(priv, trig, freq);
>>>>>                 if (ret)
>>>>>                         return ret;
>>>>>         }
>>>>> @@ -183,6 +195,9 @@ static IIO_DEV_ATTR_SAMP_FREQ(0660,
>>>>>                               stm32_tt_read_frequency,
>>>>>                               stm32_tt_store_frequency);
>>>>>
>>>>> +#define MASTER_MODE_MAX                7
>>>>> +#define MASTER_MODE2_MAX       15
>>>>> +
>>>>>  static char *master_mode_table[] = {
>>>>>         "reset",
>>>>>         "enable",
>>>>> @@ -191,7 +206,16 @@ static IIO_DEV_ATTR_SAMP_FREQ(0660,
>>>>>         "OC1REF",
>>>>>         "OC2REF",
>>>>>         "OC3REF",
>>>>> -       "OC4REF"
>>>>> +       "OC4REF",
>>>>> +       /* Master mode selection 2 only */
>>>>> +       "OC5REF",
>>>>> +       "OC6REF",
>>>>> +       "compare_pulse_OC4REF",
>>>>> +       "compare_pulse_OC6REF",
>>>>> +       "compare_pulse_OC4REF_r_or_OC6REF_r",
>>>>> +       "compare_pulse_OC4REF_r_or_OC6REF_f",
>>>>> +       "compare_pulse_OC5REF_r_or_OC6REF_r",
>>>>> +       "compare_pulse_OC5REF_r_or_OC6REF_f",
>>>>>  };
>>>>>
>>>>>  static ssize_t stm32_tt_show_master_mode(struct device *dev,
>>>>> @@ -199,10 +223,15 @@ static ssize_t stm32_tt_show_master_mode(struct device *dev,
>>>>>                                          char *buf)
>>>>>  {
>>>>>         struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>>>>> +       struct iio_trigger *trig = to_iio_trigger(dev);
>>>>>         u32 cr2;
>>>>>
>>>>>         regmap_read(priv->regmap, TIM_CR2, &cr2);
>>>>> -       cr2 = (cr2 & TIM_CR2_MMS) >> TIM_CR2_MMS_SHIFT;
>>>>> +
>>>>> +       if (stm32_timer_is_trgo2_name(trig->name))
>>>>> +               cr2 = (cr2 & TIM_CR2_MMS2) >> TIM_CR2_MMS2_SHIFT;
>>>>> +       else
>>>>> +               cr2 = (cr2 & TIM_CR2_MMS) >> TIM_CR2_MMS_SHIFT;
>>>>>
>>>>>         return snprintf(buf, PAGE_SIZE, "%s\n", master_mode_table[cr2]);
>>>>>  }
>>>>> @@ -212,13 +241,25 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>>>>>                                           const char *buf, size_t len)
>>>>>  {
>>>>>         struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>>>>> +       struct iio_trigger *trig = to_iio_trigger(dev);
>>>>> +       u32 mask, shift, master_mode_max;
>>>>>         int i;
>>>>>
>>>>> -       for (i = 0; i < ARRAY_SIZE(master_mode_table); i++) {
>>>>> +       if (stm32_timer_is_trgo2_name(trig->name)) {
>>>>> +               mask = TIM_CR2_MMS2;
>>>>> +               shift = TIM_CR2_MMS2_SHIFT;
>>>>> +               master_mode_max = MASTER_MODE2_MAX;
>>>>> +       } else {
>>>>> +               mask = TIM_CR2_MMS;
>>>>> +               shift = TIM_CR2_MMS_SHIFT;
>>>>> +               master_mode_max = MASTER_MODE_MAX;
>>>>> +       }
>>>>> +
>>>>> +       for (i = 0; i <= master_mode_max; i++) {
>>>>>                 if (!strncmp(master_mode_table[i], buf,
>>>>>                              strlen(master_mode_table[i]))) {
>>>>> -                       regmap_update_bits(priv->regmap, TIM_CR2,
>>>>> -                                          TIM_CR2_MMS, i << TIM_CR2_MMS_SHIFT);
>>>>> +                       regmap_update_bits(priv->regmap, TIM_CR2, mask,
>>>>> +                                          i << shift);
>>>>>                         /* Make sure that registers are updated */
>>>>>                         regmap_update_bits(priv->regmap, TIM_EGR,
>>>>>                                            TIM_EGR_UG, TIM_EGR_UG);
>>>>> @@ -229,8 +270,31 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>>>>>         return -EINVAL;
>>>>>  }
>>>>>
>>>>> -static IIO_CONST_ATTR(master_mode_available,
>>>>> -       "reset enable update compare_pulse OC1REF OC2REF OC3REF OC4REF");
>>>>> +static ssize_t stm32_tt_show_master_mode_avail(struct device *dev,
>>>>> +                                              struct device_attribute *attr,
>>>>> +                                              char *buf)
>>>>> +{
>>>>> +       struct iio_trigger *trig = to_iio_trigger(dev);
>>>>> +       unsigned int i, master_mode_max;
>>>>> +       size_t len = 0;
>>>>> +
>>>>> +       if (stm32_timer_is_trgo2_name(trig->name))
>>>>> +               master_mode_max = MASTER_MODE2_MAX;
>>>>> +       else
>>>>> +               master_mode_max = MASTER_MODE_MAX;
>>>>> +
>>>>> +       for (i = 0; i <= master_mode_max; i++)
>>>>> +               len += scnprintf(buf + len, PAGE_SIZE - len,
>>>>> +                       "%s ", master_mode_table[i]);
>>>>> +
>>>>> +       /* replace trailing space by newline */
>>>>> +       buf[len - 1] = '\n';
>>>>> +
>>>>> +       return len;
>>>>> +}
>>>>> +
>>>>> +static IIO_DEVICE_ATTR(master_mode_available, 0444,
>>>>> +                      stm32_tt_show_master_mode_avail, NULL, 0);
>>>>>
>>>>>  static IIO_DEVICE_ATTR(master_mode, 0660,
>>>>>                        stm32_tt_show_master_mode,
>>>>> @@ -240,7 +304,7 @@ static IIO_DEVICE_ATTR(master_mode, 0660,
>>>>>  static struct attribute *stm32_trigger_attrs[] = {
>>>>>         &iio_dev_attr_sampling_frequency.dev_attr.attr,
>>>>>         &iio_dev_attr_master_mode.dev_attr.attr,
>>>>> -       &iio_const_attr_master_mode_available.dev_attr.attr,
>>>>> +       &iio_dev_attr_master_mode_available.dev_attr.attr,
>>>>>         NULL,
>>>>>  };
>>>>>
>>>>> @@ -264,6 +328,12 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
>>>>>
>>>>>         while (cur && *cur) {
>>>>>                 struct iio_trigger *trig;
>>>>> +               bool cur_is_trgo2 = stm32_timer_is_trgo2_name(*cur);
>>>>> +
>>>>> +               if (cur_is_trgo2 && !priv->has_trgo2) {
>>>>> +                       cur++;
>>>>> +                       continue;
>>>>> +               }
>>>>>
>>>>>                 trig = devm_iio_trigger_alloc(priv->dev, "%s", *cur);
>>>>>                 if  (!trig)
>>>>> @@ -277,7 +347,7 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
>>>>>                  * should only be available on trgo trigger which
>>>>>                  * is always the first in the list.
>>>>>                  */
>>>>> -               if (cur == priv->triggers)
>>>>> +               if (cur == priv->triggers || cur_is_trgo2)
>>>>>                         trig->dev.groups = stm32_trigger_attr_groups;
>>>>>
>>>>>                 iio_trigger_set_drvdata(trig, priv);
>>>>> @@ -584,6 +654,20 @@ bool is_stm32_timer_trigger(struct iio_trigger *trig)
>>>>>  }
>>>>>  EXPORT_SYMBOL(is_stm32_timer_trigger);
>>>>>
>>>>> +static void stm32_timer_detect_trgo2(struct stm32_timer_trigger *priv)
>>>>> +{
>>>>> +       u32 val;
>>>>> +
>>>>> +       /*
>>>>> +        * Master mode selection 2 bits can only be written and read back when
>>>>> +        * timer supports it.
>>>>> +        */
>>>>> +       regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, TIM_CR2_MMS2);
>>>>> +       regmap_read(priv->regmap, TIM_CR2, &val);
>>>>> +       regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, 0);
>>>>> +       priv->has_trgo2 = !!val;
>>>>> +}
>>>>> +
>>>>>  static int stm32_timer_trigger_probe(struct platform_device *pdev)
>>>>>  {
>>>>>         struct device *dev = &pdev->dev;
>>>>> @@ -614,6 +698,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>>>>>         priv->max_arr = ddata->max_arr;
>>>>>         priv->triggers = triggers_table[index];
>>>>>         priv->valids = valids_table[index];
>>>>> +       stm32_timer_detect_trgo2(priv);
>>>>>
>>>>>         ret = stm32_setup_iio_triggers(priv);
>>>>>         if (ret)
>>>>> diff --git a/include/linux/iio/timer/stm32-timer-trigger.h b/include/linux/iio/timer/stm32-timer-trigger.h
>>>>> index 55535ae..fa7d786 100644
>>>>> --- a/include/linux/iio/timer/stm32-timer-trigger.h
>>>>> +++ b/include/linux/iio/timer/stm32-timer-trigger.h
>>>>> @@ -10,6 +10,7 @@
>>>>>  #define _STM32_TIMER_TRIGGER_H_
>>>>>
>>>>>  #define TIM1_TRGO      "tim1_trgo"
>>>>> +#define TIM1_TRGO2     "tim1_trgo2"
>>>>>  #define TIM1_CH1       "tim1_ch1"
>>>>>  #define TIM1_CH2       "tim1_ch2"
>>>>>  #define TIM1_CH3       "tim1_ch3"
>>>>> @@ -44,6 +45,7 @@
>>>>>  #define TIM7_TRGO      "tim7_trgo"
>>>>>
>>>>>  #define TIM8_TRGO      "tim8_trgo"
>>>>> +#define TIM8_TRGO2     "tim8_trgo2"
>>>>>  #define TIM8_CH1       "tim8_ch1"
>>>>>  #define TIM8_CH2       "tim8_ch2"
>>>>>  #define TIM8_CH3       "tim8_ch3"
>>>>> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
>>>>> index 4a0abbc..ce7346e 100644
>>>>> --- a/include/linux/mfd/stm32-timers.h
>>>>> +++ b/include/linux/mfd/stm32-timers.h
>>>>> @@ -34,6 +34,7 @@
>>>>>  #define TIM_CR1_DIR    BIT(4)  /* Counter Direction       */
>>>>>  #define TIM_CR1_ARPE   BIT(7)  /* Auto-reload Preload Ena */
>>>>>  #define TIM_CR2_MMS    (BIT(4) | BIT(5) | BIT(6)) /* Master mode selection */
>>>>> +#define TIM_CR2_MMS2   GENMASK(23, 20) /* Master mode selection 2 */
>>>>>  #define TIM_SMCR_SMS   (BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
>>>>>  #define TIM_SMCR_TS    (BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
>>>>>  #define TIM_DIER_UIE   BIT(0)  /* Update interrupt        */
>>>>> @@ -60,6 +61,7 @@
>>>>>
>>>>>  #define MAX_TIM_PSC            0xFFFF
>>>>>  #define TIM_CR2_MMS_SHIFT      4
>>>>> +#define TIM_CR2_MMS2_SHIFT     20
>>>>>  #define TIM_SMCR_TS_SHIFT      4
>>>>>  #define TIM_BDTR_BKF_MASK      0xF
>>>>>  #define TIM_BDTR_BKF_SHIFT     16
>>>>> --
>>>>> 1.9.1
>>>>>
>>>>
>>>> Acked-by: Benjamin Gaiganrd <benjamin.gaignard@linaro.org>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
