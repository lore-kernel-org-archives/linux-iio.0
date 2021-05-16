Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6EFC433B4
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 09:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF4160FE9
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 09:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhEPJRs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 May 2021 05:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234423AbhEPJRr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 05:17:47 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A0C610C9;
        Sun, 16 May 2021 09:16:30 +0000 (UTC)
Date:   Sun, 16 May 2021 10:17:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <gregkh@suse.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] iio: adc: ad7793: Add missing error code in
 ad7793_setup()
Message-ID: <20210516101742.7ff1d3ed@jic23-huawei>
In-Reply-To: <20210514080254.9620-1-yuehaibing@huawei.com>
References: <20210514080254.9620-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 May 2021 16:02:54 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> Set error code while device ID query failed.
> 
> Fixes: 88bc30548aae ("IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI ADC")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This one is going to be 'interesting' as that bit of code has changed a lot
since the fixes tag so chances are we may need to do a manual backport (or several!)

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan


> ---
> v2: use ENODEV instead of EINVAL
> 
>  drivers/iio/adc/ad7793.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 5e980a06258e..b4f9ac3838e1 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -279,6 +279,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
>  	id &= AD7793_ID_MASK;
>  
>  	if (id != st->chip_info->id) {
> +		ret = -ENODEV;
>  		dev_err(&st->sd.spi->dev, "device ID query failed\n");
>  		goto out;
>  	}

