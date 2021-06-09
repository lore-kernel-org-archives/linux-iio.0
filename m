Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEADC48BCD
	for <linux-iio@archiver.kernel.org>; Wed,  9 Jun 2021 15:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE6D611CC
	for <linux-iio@archiver.kernel.org>; Wed,  9 Jun 2021 15:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhFIPVL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232495AbhFIPUo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 11:20:44 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D24601FC;
        Wed,  9 Jun 2021 15:18:44 +0000 (UTC)
Date:   Wed, 9 Jun 2021 16:20:37 +0100
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
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v11 07/33] counter: 104-quad-8: Add const qualifier for
 functions_list array
Message-ID: <20210609162037.75aca91d@jic23-huawei>
In-Reply-To: <6847da7553208e7f2554e6c7688e2021f7e19716.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
        <6847da7553208e7f2554e6c7688e2021f7e19716.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 10:31:10 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The struct counter_count functions_list member expects a const enum
> counter_count_function array. This patch adds the const qualifier to the
> quad8_count_functions_list to match functions_list.
> 
> Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied,
> ---
>  drivers/counter/104-quad-8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 51fba8cf9c2a..ae89ad7a91c6 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -193,7 +193,7 @@ enum quad8_count_function {
>  	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
>  };
>  
> -static enum counter_count_function quad8_count_functions_list[] = {
> +static const enum counter_count_function quad8_count_functions_list[] = {
>  	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
>  	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
>  	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,

