Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbdHIOl7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 10:41:59 -0400
Date: Wed, 9 Aug 2017 15:41:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <benjamin.gaignard@st.com>,
        <benjamin.gaignard@linaro.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: trigger: stm32-timer: fix get trigger mode
Message-ID: <20170809154139.56259949@archlinux>
In-Reply-To: <1501752137-14534-1-git-send-email-fabrice.gasnier@st.com>
References: <1501752137-14534-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 3 Aug 2017 11:22:17 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Fix reading trigger mode, when other bit-fields are set. SMCR register
> value must be masked to read SMS (slave mode selection) only.
> 
> Fixes: 9eba381 ("iio: make stm32 trigger driver use
> INDIO_HARDWARE_TRIGGERED mode")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the fixes-togreg branch of iio.git.

THanks,

Jonathan
> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 14e6eb0..25ad6ab 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -485,7 +485,7 @@ static int stm32_get_trigger_mode(struct iio_dev *indio_dev,
>  
>  	regmap_read(priv->regmap, TIM_SMCR, &smcr);
>  
> -	return smcr == TIM_SMCR_SMS ? 0 : -EINVAL;
> +	return (smcr & TIM_SMCR_SMS) == TIM_SMCR_SMS ? 0 : -EINVAL;
>  }
>  
>  static const struct iio_enum stm32_trigger_mode_enum = {

