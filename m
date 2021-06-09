Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C54C48BDF
	for <linux-iio@archiver.kernel.org>; Wed,  9 Jun 2021 15:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3536E60E0B
	for <linux-iio@archiver.kernel.org>; Wed,  9 Jun 2021 15:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhFIPZs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235847AbhFIPZq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 11:25:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5D06100A;
        Wed,  9 Jun 2021 15:23:46 +0000 (UTC)
Date:   Wed, 9 Jun 2021 16:25:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v11 10/33] counter: stm32-lptimer-cnt: Add const
 qualifier for functions_list array
Message-ID: <20210609162539.33a3ab0e@jic23-huawei>
In-Reply-To: <08830119594acdb3bc9d36ae2e65b2eb26589ade.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
        <08830119594acdb3bc9d36ae2e65b2eb26589ade.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 10:31:13 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The struct counter_count functions_list member expects a const enum
> counter_count_function array. This patch adds the const qualifier to the
> stm32_lptim_cnt_functions to match functions_list.
> 
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied.

btw a different reasoning for all of these is that static const is
read only and will let linker and compiler do various tricks that it can't
do otherwise.

Jonathan

> ---
>  drivers/counter/stm32-lptimer-cnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 937439635d53..0f7d3f1ec1b6 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -134,7 +134,7 @@ enum stm32_lptim_cnt_function {
>  	STM32_LPTIM_ENCODER_BOTH_EDGE,
>  };
>  
> -static enum counter_count_function stm32_lptim_cnt_functions[] = {
> +static const enum counter_count_function stm32_lptim_cnt_functions[] = {
>  	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
>  	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
>  };

