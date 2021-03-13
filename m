Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71FDC433E0
	for <linux-iio@archiver.kernel.org>; Sat, 13 Mar 2021 15:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902AD64ED9
	for <linux-iio@archiver.kernel.org>; Sat, 13 Mar 2021 15:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhCMPMI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 13 Mar 2021 10:12:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233877AbhCMPLq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 10:11:46 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31A8C64ECE;
        Sat, 13 Mar 2021 15:11:45 +0000 (UTC)
Date:   Sat, 13 Mar 2021 15:11:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/1] iio: light: gp2ap002: Drop unneeded explicit
 casting
Message-ID: <20210313151142.20be8230@archlinux>
In-Reply-To: <20210312134903.4296-1-andriy.shevchenko@linux.intel.com>
References: <20210312134903.4296-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Mar 2021 15:49:03 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The unnecessary explicit casting is being used. Drop it for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git.

These were all so simple I didn't wait for reviews, but if anyone wants
to add any tags I can still do that as only pushed out as testing
so far to give the autobuilders something to poke at.

Thanks,

Jonathan

> ---
>  drivers/iio/light/gp2ap002.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index 7ba7aa59437c..d048ae257c51 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -465,8 +465,7 @@ static int gp2ap002_probe(struct i2c_client *client,
>  
>  	regmap = devm_regmap_init(dev, &gp2ap002_regmap_bus, dev, &config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  	gp2ap002->map = regmap;

