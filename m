Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35925 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbdC0OYG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 10:24:06 -0400
Date: Mon, 27 Mar 2017 10:23:13 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, mwelling@ieee.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 1/2] iio: stm32 trigger: Add quadrature encoder device
Message-ID: <20170327142313.GA11788@sophia>
References: <1490607804-24889-1-git-send-email-benjamin.gaignard@st.com>
 <1490607804-24889-2-git-send-email-benjamin.gaignard@st.com>
 <20170327134727.GA13775@sophia>
 <CA+M3ks7-TfUZdxa+j3qD-YD1mDbs5JJn7mzQc_kbRd1kc28-qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+M3ks7-TfUZdxa+j3qD-YD1mDbs5JJn7mzQc_kbRd1kc28-qg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 27, 2017 at 04:14:25PM +0200, Benjamin Gaignard wrote:
>2017-03-27 15:47 GMT+02:00 William Breathitt Gray <vilhelm.gray@gmail.com>:
>> On Mon, Mar 27, 2017 at 11:43:23AM +0200, Benjamin Gaignard wrote:
>>>One of the features of STM32 trigger hardware block is a quadrature
>>>encoder that can counts up/down depending of the levels and edges
>>>of the selected external pins.
>>>
>>>This patch allow to read/write the counter, get it direction,
>>>set/get quadrature modes and get scale factor.
>>>
>>>When counting up preset value is the limit of the counter.
>>>When counting down the counter start from preset value down to 0.
>>>This preset value could be set/get by using
>>>/sys/bus/iio/devices/iio:deviceX/in_count0_preset attribute.
>>>
>>>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>
>> Hi Benjamin,
>>
>> This is pretty close to the ABI I had in mind. I'm a bit confused about
>> how to select some of functionality we discussed in the previous version
>> so I'll write those comments inline. Overall nice work! :)
>>
>>>
>>>version 3:
>>>- fix typo in documentation
>>>- change some functions names
>>>---
>>> .../ABI/testing/sysfs-bus-iio-timer-stm32          |  32 +++
>>> drivers/iio/trigger/stm32-timer-trigger.c          | 244 ++++++++++++++++++++-
>>> include/linux/mfd/stm32-timers.h                   |   2 +
>>> 3 files changed, 272 insertions(+), 6 deletions(-)
>>>
>>>diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>index 6534a60..bf795ad 100644
>>>--- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>+++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>@@ -27,3 +27,35 @@ Description:
>>>               Reading returns the current sampling frequency.
>>>               Writing an value different of 0 set and start sampling.
>>>               Writing 0 stop sampling.
>>>+
>>>+What:         /sys/bus/iio/devices/iio:deviceX/in_count0_preset
>>>+KernelVersion:        4.12
>>>+Contact:      benjamin.gaignard@st.com
>>>+Description:
>>>+              Reading returns the current preset value.
>>>+              Writing sets the preset value.
>>>+              When counting up the counter starts from 0 and fires an event when reach preset value.
>>>+              When counting down the counter start from preset value and fire event when reach 0.
>>
>> In one of the previous versions we discussed a "reset" mode of operation
>> where the counter would be reset to the preset value on the rising edge
>> of pin 1. How would a user select this mode of operation using this ABI
>> (I assume the preset value would be the same value as in the
>> in_count0_preset attribute).
>>
>> Also, would this "reset" mode be limited to count just the internal
>> clock, or may an external pin alternatively serve as a counter source?
>
>In reset mode counter is clocked by the internal clock
>Reset can only by drive by a rising edge of an internal signal
>(represented by an IIO trigger).

Ah, my apologies, I was under the incorrect impression that the reset
trigger was an external signal. I think understand how it works now.

>
>>
>>>+
>>>+What:         /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
>>>+KernelVersion:        4.12
>>>+Contact:      benjamin.gaignard@st.com
>>>+Description:
>>>+              Reading returns the list possible quadrature modes.
>>>+
>>>+What:         /sys/bus/iio/devices/iio:deviceX/in_count0_quadrature_mode
>>>+KernelVersion:        4.12
>>>+Contact:      benjamin.gaignard@st.com
>>>+Description:
>>>+              Configure the device counter quadrature modes:
>>>+              channel_A:
>>>+                      Encoder A input servers as the count input and B as
>>>+                      the UP/DOWN direction control input.
>>>+
>>>+              channel_B:
>>>+                      Encoder B input serves as the count input and A as
>>>+                      the UP/DOWN direction control input.
>>>+
>>>+              quadrature:
>>>+                      Encoder A and B inputs are mixed to get direction
>>>+                      and count with a scale of 0.25.
>>
>> If I want to select the internal clock as the counter source, how would
>> I do so? Should there be an "internal_clock" mode available in the
>> quadrature_mode attribute?
>
>To use internal clock as counter source you must select one of the modes
>in in_count0_enable_mode attribute (patch 2/2)
>
>Counter could be drived by 3 "sources": internal clock, encoder input
>and internal signal
>I have in mind to keep this split in 3 attributes:enable_mode,
>quadrature_mode and a futur
>trigger_mode.

Many thanks for the further explanation. This clears up my confusion,
and I believe the interaction between these 3 attributes should work out
quite well for future drivers too.

William Breathitt Gray

>
>
>>
>> Sincerely,
>>
>> William Breathitt Gray
>>
>>>diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
>>>index 994b96d..7db904c 100644
>>>--- a/drivers/iio/trigger/stm32-timer-trigger.c
>>>+++ b/drivers/iio/trigger/stm32-timer-trigger.c
>>>@@ -15,6 +15,7 @@
>>> #include <linux/platform_device.h>
>>>
>>> #define MAX_TRIGGERS 6
>>>+#define MAX_VALIDS 5
>>>
>>> /* List the triggers created by each timer */
>>> static const void *triggers_table[][MAX_TRIGGERS] = {
>>>@@ -32,12 +33,29 @@
>>>       { TIM12_TRGO, TIM12_CH1, TIM12_CH2,},
>>> };
>>>
>>>+/* List the triggers accepted by each timer */
>>>+static const void *valids_table[][MAX_VALIDS] = {
>>>+      { TIM5_TRGO, TIM2_TRGO, TIM3_TRGO, TIM4_TRGO,},
>>>+      { TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO,},
>>>+      { TIM1_TRGO, TIM2_TRGO, TIM5_TRGO, TIM4_TRGO,},
>>>+      { TIM1_TRGO, TIM2_TRGO, TIM3_TRGO, TIM8_TRGO,},
>>>+      { TIM2_TRGO, TIM3_TRGO, TIM4_TRGO, TIM8_TRGO,},
>>>+      { }, /* timer 6 */
>>>+      { }, /* timer 7 */
>>>+      { TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO,},
>>>+      { TIM2_TRGO, TIM3_TRGO,},
>>>+      { }, /* timer 10 */
>>>+      { }, /* timer 11 */
>>>+      { TIM4_TRGO, TIM5_TRGO,},
>>>+};
>>>+
>>> struct stm32_timer_trigger {
>>>       struct device *dev;
>>>       struct regmap *regmap;
>>>       struct clk *clk;
>>>       u32 max_arr;
>>>       const void *triggers;
>>>+      const void *valids;
>>> };
>>>
>>> static int stm32_timer_start(struct stm32_timer_trigger *priv,
>>>@@ -180,8 +198,7 @@ static ssize_t stm32_tt_show_master_mode(struct device *dev,
>>>                                        struct device_attribute *attr,
>>>                                        char *buf)
>>> {
>>>-      struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>>-      struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>+      struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>>>       u32 cr2;
>>>
>>>       regmap_read(priv->regmap, TIM_CR2, &cr2);
>>>@@ -194,8 +211,7 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>>>                                         struct device_attribute *attr,
>>>                                         const char *buf, size_t len)
>>> {
>>>-      struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>>-      struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>+      struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>>>       int i;
>>>
>>>       for (i = 0; i < ARRAY_SIZE(master_mode_table); i++) {
>>>@@ -275,6 +291,216 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
>>>       return 0;
>>> }
>>>
>>>+static int stm32_counter_read_raw(struct iio_dev *indio_dev,
>>>+                                struct iio_chan_spec const *chan,
>>>+                                int *val, int *val2, long mask)
>>>+{
>>>+      struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>+
>>>+      switch (mask) {
>>>+      case IIO_CHAN_INFO_RAW:
>>>+      {
>>>+              u32 cnt;
>>>+
>>>+              regmap_read(priv->regmap, TIM_CNT, &cnt);
>>>+              *val = cnt;
>>>+
>>>+              return IIO_VAL_INT;
>>>+      }
>>>+      case IIO_CHAN_INFO_SCALE:
>>>+      {
>>>+              u32 smcr;
>>>+
>>>+              regmap_read(priv->regmap, TIM_SMCR, &smcr);
>>>+              smcr &= TIM_SMCR_SMS;
>>>+
>>>+              *val = 1;
>>>+              *val2 = 0;
>>>+
>>>+              /* in quadrature case scale = 0.25 */
>>>+              if (smcr == 3)
>>>+                      *val2 = 2;
>>>+
>>>+              return IIO_VAL_FRACTIONAL_LOG2;
>>>+      }
>>>+      }
>>>+
>>>+      return -EINVAL;
>>>+}
>>>+
>>>+static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>>>+                                 struct iio_chan_spec const *chan,
>>>+                                 int val, int val2, long mask)
>>>+{
>>>+      struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>+
>>>+      switch (mask) {
>>>+      case IIO_CHAN_INFO_RAW:
>>>+              regmap_write(priv->regmap, TIM_CNT, val);
>>>+
>>>+              return IIO_VAL_INT;
>>>+      case IIO_CHAN_INFO_SCALE:
>>>+              /* fixed scale */
>>>+              return -EINVAL;
>>>+      }
>>>+
>>>+      return -EINVAL;
>>>+}
>>>+
>>>+static const struct iio_info stm32_trigger_info = {
>>>+      .driver_module = THIS_MODULE,
>>>+      .read_raw = stm32_counter_read_raw,
>>>+      .write_raw = stm32_counter_write_raw
>>>+};
>>>+
>>>+static const char *const stm32_quadrature_modes[] = {
>>>+      "channel_A",
>>>+      "channel_B",
>>>+      "quadrature",
>>>+};
>>>+
>>>+static int stm32_set_quadrature_mode(struct iio_dev *indio_dev,
>>>+                                   const struct iio_chan_spec *chan,
>>>+                                   unsigned int mode)
>>>+{
>>>+      struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>+
>>>+      regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, mode + 1);
>>>+
>>>+      return 0;
>>>+}
>>>+
>>>+static int stm32_get_quadrature_mode(struct iio_dev *indio_dev,
>>>+                                   const struct iio_chan_spec *chan)
>>>+{
>>>+      struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>+      u32 smcr;
>>>+
>>>+      regmap_read(priv->regmap, TIM_SMCR, &smcr);
>>>+      smcr &= TIM_SMCR_SMS;
>>>+
>>>+      return smcr - 1;
>>>+}
>>>+
>>>+static const struct iio_enum stm32_quadrature_mode_enum = {
>>>+      .items = stm32_quadrature_modes,
>>>+      .num_items = ARRAY_SIZE(stm32_quadrature_modes),
>>>+      .set = stm32_set_quadrature_mode,
>>>+      .get = stm32_get_quadrature_mode
>>>+};
>>>+
>>>+static const char *const stm32_count_direction_states[] = {
>>>+      "up",
>>>+      "down"
>>>+};
>>>+
>>>+static int stm32_set_count_direction(struct iio_dev *indio_dev,
>>>+                                   const struct iio_chan_spec *chan,
>>>+                                   unsigned int mode)
>>>+{
>>>+      struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>+
>>>+      regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_DIR, mode);
>>>+
>>>+      return 0;
>>>+}
>>>+
>>>+static int stm32_get_count_direction(struct iio_dev *indio_dev,
>>>+                                   const struct iio_chan_spec *chan)
>>>+{
>>>+      struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>+      u32 cr1;
>>>+
>>>+      regmap_read(priv->regmap, TIM_CR1, &cr1);
>>>+
>>>+      return (cr1 & TIM_CR1_DIR);
>>>+}
>>>+
>>>+static const struct iio_enum stm32_count_direction_enum = {
>>>+      .items = stm32_count_direction_states,
>>>+      .num_items = ARRAY_SIZE(stm32_count_direction_states),
>>>+      .set = stm32_set_count_direction,
>>>+      .get = stm32_get_count_direction
>>>+};
>>>+
>>>+static ssize_t stm32_count_get_preset(struct iio_dev *indio_dev,
>>>+                                    uintptr_t private,
>>>+                                    const struct iio_chan_spec *chan,
>>>+                                    char *buf)
>>>+{
>>>+      struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>+      u32 arr;
>>>+
>>>+      regmap_read(priv->regmap, TIM_ARR, &arr);
>>>+
>>>+      return snprintf(buf, PAGE_SIZE, "%u\n", arr);
>>>+}
>>>+
>>>+static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
>>>+                                    uintptr_t private,
>>>+                                    const struct iio_chan_spec *chan,
>>>+                                    const char *buf, size_t len)
>>>+{
>>>+      struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>>>+      unsigned int preset;
>>>+      int ret;
>>>+
>>>+      ret = kstrtouint(buf, 0, &preset);
>>>+      if (ret)
>>>+              return ret;
>>>+
>>>+      regmap_write(priv->regmap, TIM_ARR, preset);
>>>+      regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
>>>+
>>>+      return len;
>>>+}
>>>+
>>>+static const struct iio_chan_spec_ext_info stm32_trigger_count_info[] = {
>>>+      {
>>>+              .name = "preset",
>>>+              .shared = IIO_SEPARATE,
>>>+              .read = stm32_count_get_preset,
>>>+              .write = stm32_count_set_preset
>>>+      },
>>>+      IIO_ENUM("count_direction", IIO_SEPARATE, &stm32_count_direction_enum),
>>>+      IIO_ENUM_AVAILABLE("count_direction", &stm32_count_direction_enum),
>>>+      IIO_ENUM("quadrature_mode", IIO_SEPARATE, &stm32_quadrature_mode_enum),
>>>+      IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_quadrature_mode_enum),
>>>+      {}
>>>+};
>>>+
>>>+static const struct iio_chan_spec stm32_trigger_channel = {
>>>+      .type = IIO_COUNT,
>>>+      .channel = 0,
>>>+      .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>>>+      .ext_info = stm32_trigger_count_info,
>>>+      .indexed = 1
>>>+};
>>>+
>>>+static struct stm32_timer_trigger *stm32_setup_counter_device(struct device *dev)
>>>+{
>>>+      struct iio_dev *indio_dev;
>>>+      int ret;
>>>+
>>>+      indio_dev = devm_iio_device_alloc(dev,
>>>+                                        sizeof(struct stm32_timer_trigger));
>>>+      if (!indio_dev)
>>>+              return NULL;
>>>+
>>>+      indio_dev->name = dev_name(dev);
>>>+      indio_dev->dev.parent = dev;
>>>+      indio_dev->info = &stm32_trigger_info;
>>>+      indio_dev->num_channels = 1;
>>>+      indio_dev->channels = &stm32_trigger_channel;
>>>+      indio_dev->dev.of_node = dev->of_node;
>>>+
>>>+      ret = devm_iio_device_register(dev, indio_dev);
>>>+      if (ret)
>>>+              return NULL;
>>>+
>>>+      return iio_priv(indio_dev);
>>>+}
>>>+
>>> /**
>>>  * is_stm32_timer_trigger
>>>  * @trig: trigger to be checked
>>>@@ -299,10 +525,15 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>>>       if (of_property_read_u32(dev->of_node, "reg", &index))
>>>               return -EINVAL;
>>>
>>>-      if (index >= ARRAY_SIZE(triggers_table))
>>>+      if (index >= ARRAY_SIZE(triggers_table) ||
>>>+          index >= ARRAY_SIZE(valids_table))
>>>               return -EINVAL;
>>>
>>>-      priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>+      /* Create an IIO device only if we have triggers to be validated */
>>>+      if (*valids_table[index])
>>>+              priv = stm32_setup_counter_device(dev);
>>>+      else
>>>+              priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>
>>>       if (!priv)
>>>               return -ENOMEM;
>>>@@ -312,6 +543,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>>>       priv->clk = ddata->clk;
>>>       priv->max_arr = ddata->max_arr;
>>>       priv->triggers = triggers_table[index];
>>>+      priv->valids = valids_table[index];
>>>
>>>       ret = stm32_setup_iio_triggers(priv);
>>>       if (ret)
>>>diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
>>>index d030004..4a0abbc 100644
>>>--- a/include/linux/mfd/stm32-timers.h
>>>+++ b/include/linux/mfd/stm32-timers.h
>>>@@ -21,6 +21,7 @@
>>> #define TIM_CCMR1     0x18    /* Capt/Comp 1 Mode Reg    */
>>> #define TIM_CCMR2     0x1C    /* Capt/Comp 2 Mode Reg    */
>>> #define TIM_CCER      0x20    /* Capt/Comp Enable Reg    */
>>>+#define TIM_CNT               0x24    /* Counter                 */
>>> #define TIM_PSC               0x28    /* Prescaler               */
>>> #define TIM_ARR               0x2c    /* Auto-Reload Register    */
>>> #define TIM_CCR1      0x34    /* Capt/Comp Register 1    */
>>>@@ -30,6 +31,7 @@
>>> #define TIM_BDTR      0x44    /* Break and Dead-Time Reg */
>>>
>>> #define TIM_CR1_CEN   BIT(0)  /* Counter Enable          */
>>>+#define TIM_CR1_DIR   BIT(4)  /* Counter Direction       */
>>> #define TIM_CR1_ARPE  BIT(7)  /* Auto-reload Preload Ena */
>>> #define TIM_CR2_MMS   (BIT(4) | BIT(5) | BIT(6)) /* Master mode selection */
>>> #define TIM_SMCR_SMS  (BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
>>>--
>>>1.9.1
>>>
>
>
>
>-- 
>Benjamin Gaignard
>
>Graphic Study Group
>
>Linaro.org │ Open source software for ARM SoCs
>
>Follow Linaro: Facebook | Twitter | Blog
