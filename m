Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751360AbdG3Nnz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Jul 2017 09:43:55 -0400
Date: Sun, 30 Jul 2017 14:43:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <benjamin.gaignard@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/4] iio: trigger: stm32-timer: fix quadrature mode get
 routine
Message-ID: <20170730144350.17095cf1@kernel.org>
In-Reply-To: <1501172340-8448-2-git-send-email-fabrice.gasnier@st.com>
References: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
        <1501172340-8448-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 27 Jul 2017 18:18:57 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Fixes: 4adec7da0536 ("iio: stm32 trigger: Add quadrature encoder device")
> 
> SMS bitfiled is mode + 1. After reset, upon boot, SMS = 0. When reading
> from sysfs, stm32_get_quadrature_mode() returns -1 (e.g. -EPERM) which is
> wrong error code here. So, check SMS bitfiled matches valid encoder mode,
> or return -EINVAL.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index d22bc56..6aa73d6 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -571,11 +571,14 @@ static int stm32_get_quadrature_mode(struct iio_dev *indio_dev,
>  {
>  	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>  	u32 smcr;
> +	int mode;
>  
>  	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> -	smcr &= TIM_SMCR_SMS;
> +	mode = (smcr & TIM_SMCR_SMS) - 1;
> +	if ((mode < 0) || (mode > ARRAY_SIZE(stm32_quadrature_modes)))
> +		return -EINVAL;
>  
> -	return smcr - 1;
> +	return mode;
>  }
>  
>  static const struct iio_enum stm32_quadrature_mode_enum = {

