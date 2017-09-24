Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751987AbdIXMKb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 08:10:31 -0400
Date: Sun, 24 Sep 2017 13:10:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <benjamin.gaignard@st.com>,
        <benjamin.gaignard@linaro.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/3] iio: trigger: stm32-timer: fix a corner case to
 write preset
Message-ID: <20170924131027.2d6c5d90@archlinux>
In-Reply-To: <1505729132-1369-3-git-send-email-fabrice.gasnier@st.com>
References: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
        <1505729132-1369-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 18 Sep 2017 12:05:31 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Balance timer start routine that sets ARPE: clear it in stop routine.
> This fixes a corner case, when timer is used successively as trigger
> (with sampling_frequency start/stop routines), then as a counter
> (with preset).
> 
> Fixes: 93fbe91b5521 ("iio: Add STM32 timer trigger driver")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Applied to the fixes-togreg-post-rc1 branch of iio.git and
marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 34cc25b..eb212f8c 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -174,6 +174,7 @@ static void stm32_timer_stop(struct stm32_timer_trigger *priv)
>  		clk_disable(priv->clk);
>  
>  	/* Stop timer */
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
>  	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
>  	regmap_write(priv->regmap, TIM_PSC, 0);
>  	regmap_write(priv->regmap, TIM_ARR, 0);

