Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbdIXMJK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 08:09:10 -0400
Date: Sun, 24 Sep 2017 13:09:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <benjamin.gaignard@st.com>,
        <benjamin.gaignard@linaro.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/3] iio: trigger: stm32-timer: preset shouldn't be
 buffered
Message-ID: <20170924130905.64e1bc39@archlinux>
In-Reply-To: <1505729132-1369-2-git-send-email-fabrice.gasnier@st.com>
References: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
        <1505729132-1369-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 18 Sep 2017 12:05:30 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Currently, setting preset value (ARR) will update directly 'Auto reload
> value' only on 1st write access. But then, ARPE is set. This makes
> ARR a shadow register. Preset value should be updated upon each
> write request: ensure ARPE is 0. This fixes successive writes to
> preset attribute.
> 
> Fixes: 4adec7da0536 ("iio: stm32 trigger: Add quadrature encoder device")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Applied to the fixes-togreg-post-rc1 branch of iio.git and marked
for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 9b90534..34cc25b 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -715,8 +715,9 @@ static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> +	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
> +	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
>  	regmap_write(priv->regmap, TIM_ARR, preset);
> -	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
>  
>  	return len;
>  }

