Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DAFC433EF
	for <linux-iio@archiver.kernel.org>; Sun,  5 Sep 2021 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF1660F6D
	for <linux-iio@archiver.kernel.org>; Sun,  5 Sep 2021 16:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhIEQLM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Sep 2021 12:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhIEQLM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 12:11:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF9E060F5B;
        Sun,  5 Sep 2021 16:10:05 +0000 (UTC)
Date:   Sun, 5 Sep 2021 17:13:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 1/2] iio: accel: adxl355: use if(ret) in place of ret
 < 0
Message-ID: <20210905171328.2cf393ff@jic23-huawei>
In-Reply-To: <20210903184312.21009-2-puranjay12@gmail.com>
References: <20210903184312.21009-1-puranjay12@gmail.com>
        <20210903184312.21009-2-puranjay12@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  4 Sep 2021 00:13:11 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> Replace if(ret < 0) with if(ret) for consistency.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
There are several other cases where it would be good to clean this up.

Just cleaning one of them up leaves it inconsistent.
From a quick look I'm fairly sure all the if (ret < 0) can become if (ret)
with no functional change.

Thanks,

Jonathan


> ---
>  drivers/iio/accel/adxl355_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index c91d2254c..0b9996c17 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -570,7 +570,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
>  
>  	ret = adxl355_setup(data);
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(dev, "ADXL355 setup failed\n");
>  		return ret;
>  	}

