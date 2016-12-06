Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34664 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbcLFNN3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2016 08:13:29 -0500
Received: by mail-wm0-f43.google.com with SMTP id u144so26958189wmu.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Dec 2016 05:13:24 -0800 (PST)
Date: Tue, 6 Dec 2016 13:16:35 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        linus.walleij@linaro.org, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v4 6/7] IIO: add STM32 timer trigger driver
Message-ID: <20161206131635.GJ25385@dell.home>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
 <1481027929-13704-7-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1481027929-13704-7-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 06 Dec 2016, Benjamin Gaignard wrote:

> Timers IPs can be used to generate triggers for other IPs like
> DAC, ADC or other timers.
> Each trigger may result of timer internals signals like counter enable,
> reset or edge, this configuration could be done through "master_mode"
> device attribute.
> 
> A timer device could be triggered by other timers, we use the trigger
> name and is_stm32_iio_timer_trigger() function to distinguish them
> and configure IP input switch.
> 
> Timer may also decide on which event (edge, level) they could
> be activated by a trigger, this configuration is done by writing in
> "slave_mode" device attribute.
> 
> Since triggers could also be used by DAC or ADC their names are defined
> in include/ nux/iio/timer/stm32-timer-trigger.h so those IPs will be able
> to configure themselves in valid_trigger function
> 
> Trigger have a "sampling_frequency" attribute which allow to configure
> timer sampling frequency without using PWM interface
> 
> version 4:
> - get triggers configuration from "reg" in DT
> - add tables of triggers
> - sampling frequency is enable/disable when writing in trigger
>   sampling_frequency attribute
> - no more use of interruptions
> 
> version 3:
> - change compatible to "st,stm32-timer-trigger"
> - fix attributes access right
> - use string instead of int for master_mode and slave_mode
> - document device attributes in sysfs-bus-iio-timer-stm32
> 
> version 2:
> - keep only one compatible
> - use st,input-triggers-names and st,output-triggers-names
>   to know which triggers are accepted and/or create by the device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  55 +++
>  drivers/iio/Kconfig                                |   2 +-
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/timer/Kconfig                          |  15 +
>  drivers/iio/timer/Makefile                         |   1 +
>  drivers/iio/timer/stm32-timer-trigger.c            | 526 +++++++++++++++++++++
>  drivers/iio/trigger/Kconfig                        |   1 -
>  include/linux/iio/timer/stm32-timer-trigger.h      |  61 +++
>  8 files changed, 660 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>  create mode 100644 drivers/iio/timer/Kconfig
>  create mode 100644 drivers/iio/timer/Makefile
>  create mode 100644 drivers/iio/timer/stm32-timer-trigger.c
>  create mode 100644 include/linux/iio/timer/stm32-timer-trigger.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> new file mode 100644
> index 0000000..26583dd
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> @@ -0,0 +1,55 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/master_mode_available
> +KernelVersion:	4.10
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the list possible master modes which are:
> +		- "reset"     :	The UG bit from the TIMx_EGR register is used as trigger output (TRGO).
> +		- "enable"    : The Counter Enable signal CNT_EN is used as trigger output.
> +		- "update"    : The update event is selected as trigger output.
> +				For instance a master timer can then be used as a prescaler for a slave timer.
> +		- "compare_pulse" : The trigger output send a positive pulse when the CC1IF flag is to be set.
> +		- "OC1REF"    : OC1REF signal is used as trigger output.
> +		- "OC2REF"    : OC2REF signal is used as trigger output.
> +		- "OC3REF"    : OC3REF signal is used as trigger output.
> +		- "OC4REF"    : OC4REF signal is used as trigger output.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/master_mode
> +KernelVersion:	4.10
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the current master modes.
> +		Writing set the master mode
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/slave_mode_available
> +KernelVersion:	4.10
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the list possible slave modes which are:
> +		- "disabled"  : The prescaler is clocked directly by the internal clock.
> +		- "encoder_1" : Counter counts up/down on TI2FP1 edge depending on TI1FP2 level.
> +		- "encoder_2" : Counter counts up/down on TI1FP2 edge depending on TI2FP1 level.
> +		- "encoder_3" : Counter counts up/down on both TI1FP1 and TI2FP2 edges depending
> +				on the level of the other input.
> +		- "reset"     : Rising edge of the selected trigger input reinitializes the counter
> +				and generates an update of the registers.
> +		- "gated"     : The counter clock is enabled when the trigger input is high.
> +				The counter stops (but is not reset) as soon as the trigger becomes low.
> +				Both start and stop of the counter are controlled.
> +		- "trigger"   : The counter starts at a rising edge of the trigger TRGI (but it is not
> +				reset). Only the start of the counter is controlled.
> +		- "external_clock": Rising edges of the selected trigger (TRGI) clock the counter.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/slave_mode
> +KernelVersion:	4.10
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the current slave mode.
> +		Writing set the slave mode
> +
> +What:		/sys/bus/iio/devices/triggerX/sampling_frequency
> +KernelVersion:	4.10
> +Contact:	benjamin.gaignard@st.com
> +Description:
> +		Reading returns the current sampling frequency.
> +		Writing an value different of 0 set and start sampling.
> +		Writing 0 stop sampling.
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 6743b18..2de2a80 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -90,5 +90,5 @@ source "drivers/iio/potentiometer/Kconfig"
>  source "drivers/iio/pressure/Kconfig"
>  source "drivers/iio/proximity/Kconfig"
>  source "drivers/iio/temperature/Kconfig"
> -
> +source "drivers/iio/timer/Kconfig"
>  endif # IIO
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 87e4c43..b797c08 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -32,4 +32,5 @@ obj-y += potentiometer/
>  obj-y += pressure/
>  obj-y += proximity/
>  obj-y += temperature/
> +obj-y += timer/
>  obj-y += trigger/
> diff --git a/drivers/iio/timer/Kconfig b/drivers/iio/timer/Kconfig
> new file mode 100644
> index 0000000..3033869
> --- /dev/null
> +++ b/drivers/iio/timer/Kconfig
> @@ -0,0 +1,15 @@
> +#
> +# Timers drivers
> +
> +menu "Timers"
> +
> +config IIO_STM32_TIMER_TRIGGER
> +	tristate "STM32 Timer Trigger"
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on OF
> +	depends on MFD_STM32_GP_TIMER
> +	select IIO_TRIGGERED_EVENT
> +	help
> +	  Select this option to enable STM32 Timer Trigger
> +
> +endmenu
> diff --git a/drivers/iio/timer/Makefile b/drivers/iio/timer/Makefile
> new file mode 100644
> index 0000000..4ad95ec9
> --- /dev/null
> +++ b/drivers/iio/timer/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_IIO_STM32_TIMER_TRIGGER) += stm32-timer-trigger.o
> diff --git a/drivers/iio/timer/stm32-timer-trigger.c b/drivers/iio/timer/stm32-timer-trigger.c
> new file mode 100644
> index 0000000..58fba33
> --- /dev/null
> +++ b/drivers/iio/timer/stm32-timer-trigger.c
> @@ -0,0 +1,526 @@
> +/*
> + * Copyright (C) STMicroelectronics 2016
> + *
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/timer/stm32-timer-trigger.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_event.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/stm32-gptimer.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +static const char * const triggers0[] = {
> +	TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL,
> +};
> +
> +static const char * const triggers1[] = {
> +	TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL,
> +};
> +
> +static const char * const triggers2[] = {
> +	TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL,
> +};
> +
> +static const char * const triggers3[] = {
> +	TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL,
> +};
> +
> +static const char * const triggers4[] = {
> +	TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL,
> +};
> +
> +static const char * const triggers5[] = {
> +	TIM6_TRGO, NULL,
> +};
> +
> +static const char * const triggers6[] = {
> +	TIM7_TRGO, NULL,
> +};
> +
> +static const char * const triggers7[] = {
> +	TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL,
> +};
> +
> +static const char * const triggers8[] = {
> +	TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL,
> +};
> +
> +static const char * const triggers9[] = {
> +	TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL,
> +};
> +
> +static const void *triggers_table[] = {
> +	triggers0,
> +	triggers1,
> +	triggers2,
> +	triggers3,
> +	triggers4,
> +	triggers5,
> +	triggers6,
> +	triggers7,
> +	triggers8,
> +	triggers9,
> +};

What about:

static const char * const triggers[][] = {
	{ TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL },
	{ TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL },
	{ TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL },
	{ TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL },
	{ TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL },
	{ TIM6_TRGO, NULL },
	{ TIM7_TRGO, NULL },
	{ TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL },
	{ TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL },
	{ TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL }
};

> +static const char * const valids0[] = {
> +	TIM5_TRGO, TIM2_TRGO, TIM4_TRGO, TIM3_TRGO, NULL,
> +};
> +
> +static const char * const valids1[] = {
> +	TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO, NULL,
> +};
> +
> +static const char * const valids2[] = {
> +	TIM1_TRGO, TIM8_TRGO, TIM5_TRGO, TIM4_TRGO, NULL,
> +};
> +
> +static const char * const valids3[] = {
> +	TIM1_TRGO, TIM2_TRGO, TIM3_TRGO, TIM8_TRGO, NULL,
> +};
> +
> +static const char *const valids4[] = {
> +	TIM2_TRGO, TIM3_TRGO, TIM4_TRGO, TIM8_TRGO, NULL,
> +};
> +
> +static const char * const valids7[] = {
> +	TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO, NULL,
> +};
> +
> +static const char * const valids8[] = {
> +	TIM2_TRGO, TIM3_TRGO, NULL,
> +};
> +
> +static const char * const valids9[] = {
> +	TIM4_TRGO, TIM5_TRGO, NULL,
> +};
> +
> +static const void *valids_table[] = {
> +	valids0,
> +	valids1,
> +	valids2,
> +	valids3,
> +	valids4,
> +	NULL,
> +	NULL,
> +	valids7,
> +	valids8,
> +	valids9,
> +};

Same here.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
