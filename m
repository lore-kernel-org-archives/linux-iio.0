Return-Path: <SRS0=IsJM=34=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D050C352A1
	for <linux-iio@archiver.kernel.org>; Sat,  8 Feb 2020 15:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C99C217BA
	for <linux-iio@archiver.kernel.org>; Sat,  8 Feb 2020 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581176147;
	bh=qC4ltT8jNAGr/7Ix9q3BWAQAqxE+4oG2Cf9FzB/RJgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xm8DsvrrWmvFhkADylahEjaH0Of/+mjJt5qRVJPLBnrfhKBg5muCX2+j9qm5/GCVb
	 fJE+JOQ1fLWIX4pkNq6PpNVO+lNzFh6ThAh+b+/uKld7gthsb4Sj+ck1mrWmUcqpZA
	 3KIbRtqfTB7HLxxMcJyWS+eqfPe9PJswpfEOaKsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgBHPfq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 Feb 2020 10:35:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgBHPfq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Feb 2020 10:35:46 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5257E21741;
        Sat,  8 Feb 2020 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581176145;
        bh=qC4ltT8jNAGr/7Ix9q3BWAQAqxE+4oG2Cf9FzB/RJgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DD8iRaVlpBlQTfZEGEH+GWuR9Xg1vWL2vsI2WQekrUAx2RhQ2oDB+EMUknDLIRo8N
         vPeH8J6dpHX3eOZTzpmUre1dyt6U3+ZqEGex+SKwHIdFHV3g2g9BiWW0x9KdIqYkiL
         yJqrgffQjmExWokIwNfk68BWvBWdKg6QdsH2IL7A=
Date:   Sat, 8 Feb 2020 15:35:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <vilhelm.gray@gmail.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] counter: stm32-timer-cnt: add power management support
Message-ID: <20200208153541.448a0df3@archlinux>
In-Reply-To: <1580899678-26393-1-git-send-email-fabrice.gasnier@st.com>
References: <1580899678-26393-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Feb 2020 11:47:58 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add suspend/resume PM sleep ops. When going to low power, enforce the
> counter isn't active.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/counter/stm32-timer-cnt.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 3eafcce..3b84503 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -12,6 +12,7 @@
>  #include <linux/iio/types.h>
>  #include <linux/mfd/stm32-timers.h>
>  #include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  
>  #define TIM_CCMR_CCXS	(BIT(8) | BIT(0))
> @@ -358,10 +359,33 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
>  	priv->counter.num_signals = ARRAY_SIZE(stm32_signals);
>  	priv->counter.priv = priv;
>  
> +	platform_set_drvdata(pdev, priv);
> +
>  	/* Register Counter device */
>  	return devm_counter_register(dev, &priv->counter);
>  }
>  
> +static int __maybe_unused stm32_timer_cnt_suspend(struct device *dev)
> +{
> +	struct stm32_timer_cnt *priv = dev_get_drvdata(dev);
> +	u32 cr1;
> +
> +	/* Check for active counter */
> +	regmap_read(priv->regmap, TIM_CR1, &cr1);
> +	if (cr1 & TIM_CR1_CEN)
> +		return -EBUSY;

Runtime suspend is allowed to refuse to happen (and that is
explicitly documented)
Is that allowed for normal suspend?  I didn't think it was.
This will stop a suspend, but it's doing it by signalling a failure.
I'm not sure for example that the system will resume everything that
was suspended before this call.

Normally you are in the tough luck category if a system decides
to suspend underneath you.   There are ways to prevent it
from userspace (wakelocks etc).

> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int __maybe_unused stm32_timer_cnt_resume(struct device *dev)
> +{
> +	return pinctrl_pm_select_default_state(dev);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(stm32_timer_cnt_pm_ops, stm32_timer_cnt_suspend,
> +			 stm32_timer_cnt_resume);
> +
>  static const struct of_device_id stm32_timer_cnt_of_match[] = {
>  	{ .compatible = "st,stm32-timer-counter", },
>  	{},
> @@ -373,6 +397,7 @@ static struct platform_driver stm32_timer_cnt_driver = {
>  	.driver = {
>  		.name = "stm32-timer-counter",
>  		.of_match_table = stm32_timer_cnt_of_match,
> +		.pm = &stm32_timer_cnt_pm_ops,
>  	},
>  };
>  module_platform_driver(stm32_timer_cnt_driver);

