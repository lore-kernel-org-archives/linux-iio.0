Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752091AbdHIX3m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 19:29:42 -0400
Date: Thu, 10 Aug 2017 00:29:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: Re: [PATCH 2/3] iio: trigger: stm32-timer: add support for STM32H7
Message-ID: <20170810002933.0b215936@archlinux>
In-Reply-To: <1501751654-14153-3-git-send-email-fabrice.gasnier@st.com>
References: <1501751654-14153-1-git-send-email-fabrice.gasnier@st.com>
        <1501751654-14153-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 3 Aug 2017 11:14:13 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add support for STM32H7 timer triggers:
> - Add new valids_table
> - Introduce compatible, with configuration data
> - Extend up to 15 timers, available on STM32H7
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/iio/trigger/stm32-timer-trigger.c     | 55 +++++++++++++++++++++++++--
>  include/linux/iio/timer/stm32-timer-trigger.h |  2 +
>  2 files changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index d22bc56..33890f9 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -13,6 +13,7 @@
>  #include <linux/mfd/stm32-timers.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/of_device.h>
>  
>  #define MAX_TRIGGERS 7
>  #define MAX_VALIDS 5
> @@ -31,6 +32,9 @@
>  	{ }, /* timer 10 */
>  	{ }, /* timer 11 */
>  	{ TIM12_TRGO, TIM12_CH1, TIM12_CH2,},
> +	{ }, /* timer 13 */
> +	{ }, /* timer 14 */
> +	{ TIM15_TRGO,},
>  };
>  
>  /* List the triggers accepted by each timer */
> @@ -49,6 +53,24 @@
>  	{ TIM4_TRGO, TIM5_TRGO,},
>  };
>  
> +static const void *stm32h7_valids_table[][MAX_VALIDS] = {
> +	{ TIM15_TRGO, TIM2_TRGO, TIM3_TRGO, TIM4_TRGO,},
> +	{ TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO,},
> +	{ TIM1_TRGO, TIM2_TRGO, TIM15_TRGO, TIM4_TRGO,},
> +	{ TIM1_TRGO, TIM2_TRGO, TIM3_TRGO, TIM8_TRGO,},
> +	{ TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO,},
> +	{ }, /* timer 6 */
> +	{ }, /* timer 7 */
> +	{ TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO,},
> +	{ }, /* timer 9 */
> +	{ }, /* timer 10 */
> +	{ }, /* timer 11 */
> +	{ TIM4_TRGO, TIM5_TRGO,},
> +	{ }, /* timer 13 */
> +	{ }, /* timer 14 */
> +	{ TIM1_TRGO, TIM3_TRGO,},
> +};
> +
>  struct stm32_timer_trigger {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -59,6 +81,11 @@ struct stm32_timer_trigger {
>  	bool has_trgo2;
>  };
>  
> +struct stm32_timer_trigger_cfg {
> +	const void *(*valids_table)[MAX_VALIDS];
> +	const unsigned int num_valids_table;
> +};
> +
>  static bool stm32_timer_is_trgo2_name(const char *name)
>  {
>  	return !!strstr(name, "trgo2");
> @@ -734,18 +761,22 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct stm32_timer_trigger *priv;
>  	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
> +	const struct stm32_timer_trigger_cfg *cfg;
>  	unsigned int index;
>  	int ret;
>  
>  	if (of_property_read_u32(dev->of_node, "reg", &index))
>  		return -EINVAL;
>  
> +	cfg = (const struct stm32_timer_trigger_cfg *)
> +		of_match_device(dev->driver->of_match_table, dev)->data;
> +
>  	if (index >= ARRAY_SIZE(triggers_table) ||
> -	    index >= ARRAY_SIZE(valids_table))
> +	    index >= cfg->num_valids_table)
>  		return -EINVAL;
>  
>  	/* Create an IIO device only if we have triggers to be validated */
> -	if (*valids_table[index])
> +	if (*cfg->valids_table[index])
>  		priv = stm32_setup_counter_device(dev);
>  	else
>  		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -758,7 +789,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	priv->clk = ddata->clk;
>  	priv->max_arr = ddata->max_arr;
>  	priv->triggers = triggers_table[index];
> -	priv->valids = valids_table[index];
> +	priv->valids = cfg->valids_table[index];
>  	stm32_timer_detect_trgo2(priv);
>  
>  	ret = stm32_setup_iio_triggers(priv);
> @@ -770,8 +801,24 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct stm32_timer_trigger_cfg stm32_timer_trg_cfg = {
> +	.valids_table = valids_table,
> +	.num_valids_table = ARRAY_SIZE(valids_table),
> +};
> +
> +static const struct stm32_timer_trigger_cfg stm32h7_timer_trg_cfg = {
> +	.valids_table = stm32h7_valids_table,
> +	.num_valids_table = ARRAY_SIZE(stm32h7_valids_table),
> +};
> +
>  static const struct of_device_id stm32_trig_of_match[] = {
> -	{ .compatible = "st,stm32-timer-trigger", },
> +	{
> +		.compatible = "st,stm32-timer-trigger",
> +		.data = (void *)&stm32_timer_trg_cfg,
> +	}, {
> +		.compatible = "st,stm32h7-timer-trigger",
> +		.data = (void *)&stm32h7_timer_trg_cfg,
> +	},
>  	{ /* end node */ },
>  };
>  MODULE_DEVICE_TABLE(of, stm32_trig_of_match);
> diff --git a/include/linux/iio/timer/stm32-timer-trigger.h b/include/linux/iio/timer/stm32-timer-trigger.h
> index fa7d786..20f4653 100644
> --- a/include/linux/iio/timer/stm32-timer-trigger.h
> +++ b/include/linux/iio/timer/stm32-timer-trigger.h
> @@ -59,6 +59,8 @@
>  #define TIM12_CH1	"tim12_ch1"
>  #define TIM12_CH2	"tim12_ch2"
>  
> +#define TIM15_TRGO	"tim15_trgo"
> +
>  bool is_stm32_timer_trigger(struct iio_trigger *trig);
>  
>  #endif

