Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbdG3NpN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Jul 2017 09:45:13 -0400
Date: Sun, 30 Jul 2017 14:45:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <benjamin.gaignard@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/4] iio: trigger: stm32-timer: fix write_raw return
 value
Message-ID: <20170730144508.3aec7595@kernel.org>
In-Reply-To: <1501172340-8448-3-git-send-email-fabrice.gasnier@st.com>
References: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
        <1501172340-8448-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 27 Jul 2017 18:18:58 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Fixes: 4adec7da0536 ("iio: stm32 trigger: Add quadrature encoder device")
> 
> IIO core expects zero as return value for write_raw() callback
> in case of success.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the fixes-togreg branch of iio.git.

Thanks

Jonathan
> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 6aa73d6..107918b 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -406,9 +406,8 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		regmap_write(priv->regmap, TIM_CNT, val);
> +		return regmap_write(priv->regmap, TIM_CNT, val);
>  
> -		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		/* fixed scale */
>  		return -EINVAL;

