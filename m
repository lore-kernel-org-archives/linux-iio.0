Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612B9C433DB
	for <linux-iio@archiver.kernel.org>; Sun, 14 Mar 2021 17:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F3564E57
	for <linux-iio@archiver.kernel.org>; Sun, 14 Mar 2021 17:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhCNRAk (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Mar 2021 13:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhCNRAF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 13:00:05 -0400
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DCFC64E57;
        Sun, 14 Mar 2021 17:00:01 +0000 (UTC)
Date:   Sun, 14 Mar 2021 16:59:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, Christian Eggers <ceggers@arri.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:AMS AS73211 DRIVER)
Subject: Re: [PATCH v2 4/9] iio/drivers/as73211: Use HZ macros
Message-ID: <20210314165959.549df130@archlinux>
In-Reply-To: <20210224144222.23762-4-daniel.lezcano@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
        <20210224144222.23762-4-daniel.lezcano@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Feb 2021 15:42:14 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> HZ unit conversion macros are available in units.h, use them and
> remove the duplicate definition.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Christian Eggers <ceggers@arri.de>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/light/as73211.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index 7b32dfaee9b3..3ba2378df3dd 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -24,8 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
> -
> -#define HZ_PER_KHZ 1000
> +#include <linux/units.h>
>  
>  #define AS73211_DRV_NAME "as73211"
>  

