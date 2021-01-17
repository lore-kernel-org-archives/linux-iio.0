Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDE5C433DB
	for <linux-iio@archiver.kernel.org>; Sun, 17 Jan 2021 12:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51602071C
	for <linux-iio@archiver.kernel.org>; Sun, 17 Jan 2021 12:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbhAQMfu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 17 Jan 2021 07:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbhAQMfb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Jan 2021 07:35:31 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448A0206F4;
        Sun, 17 Jan 2021 12:34:49 +0000 (UTC)
Date:   Sun, 17 Jan 2021 12:34:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, krzk@kernel.org,
        andy.shevchenko@gmail.com, bobo.shaobowang@huawei.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: Remove redundant null check
 before clk_disable_unprepare
Message-ID: <20210117123442.5156a509@archlinux>
In-Reply-To: <20201231085322.24398-1-vulab@iscas.ac.cn>
References: <20201231085322.24398-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 31 Dec 2020 08:53:22 +0000
Xu Wang <vulab@iscas.ac.cn> wrote:

> ecause clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to see if we missed anything.

thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 42a7377704a4..bb925a11c8ae 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -117,8 +117,7 @@ static void stm32_dfsdm_clk_disable_unprepare(struct stm32_dfsdm *dfsdm)
>  {
>  	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
>  
> -	if (priv->aclk)
> -		clk_disable_unprepare(priv->aclk);
> +	clk_disable_unprepare(priv->aclk);
>  	clk_disable_unprepare(priv->clk);
>  }
>  

