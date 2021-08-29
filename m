Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6489CC432BE
	for <linux-iio@archiver.kernel.org>; Sun, 29 Aug 2021 15:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A5A60F25
	for <linux-iio@archiver.kernel.org>; Sun, 29 Aug 2021 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhH2P53 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 29 Aug 2021 11:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235646AbhH2P51 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:57:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E6260F42;
        Sun, 29 Aug 2021 15:56:33 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:59:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: return IRQ_HANDLED when fifo is
 flushed
Message-ID: <20210829165948.4a8051f9@jic23-huawei>
In-Reply-To: <20210817124336.1672169-1-sean@geanix.com>
References: <20210817124336.1672169-1-sean@geanix.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Aug 2021 14:43:36 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> fxls8962af_fifo_flush() will return the samples flushed.
> So return IRQ_NONE only if an error is returned.
> 
> Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/fxls8962af-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 078d87865fde..6b36eb362d07 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -738,7 +738,7 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
>  
>  	if (reg & FXLS8962AF_INT_STATUS_SRC_BUF) {
>  		ret = fxls8962af_fifo_flush(indio_dev);
> -		if (ret)
> +		if (ret < 0)
>  			return IRQ_NONE;
>  
>  		return IRQ_HANDLED;

