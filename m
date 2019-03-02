Return-Path: <SRS0=Vd33=RF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0BBC43381
	for <linux-iio@archiver.kernel.org>; Sat,  2 Mar 2019 18:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599AB20863
	for <linux-iio@archiver.kernel.org>; Sat,  2 Mar 2019 18:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551550111;
	bh=fWWAzmka0fTx0xXQu1o7TRkFHi04+pOl6fTWSTmoKCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EP2oX6PBlJQ7u292UDbDCAcgNcUPwM9r4dzzKlRZ9n6Ny3YO8Lo13Nss4fvBSnpQ7
	 75M0Zcd925QvV8lhhV7AHS8IR2Wn18plXWIWlrr5vOAgd2UXNuQSvjHZ7Y7grCw19H
	 aZiiBF+0pp09WFnrrp79czYfMMeZlzLp4aG/9hxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfCBSIa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:08:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCBSIa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Mar 2019 13:08:30 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43ECF20830;
        Sat,  2 Mar 2019 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551550109;
        bh=fWWAzmka0fTx0xXQu1o7TRkFHi04+pOl6fTWSTmoKCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cx9qRsxgJi1vaEhynLrp3zbfAiKXjVDmcFW0qsPfOrZF+W9h/hysHfZaMw6Brq921
         pJImtNyPLHRZeXg0VRUfI40J/l4grlfueAxXgsvySqJ7siWawdBctT8U3+pMeA/uXq
         Zt+kCd48XxNM6T1Xn++GUwqe2wT8mzOzmgPqWtls=
Date:   Sat, 2 Mar 2019 18:08:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergey Larin <cerg2010cerg2010@mail.ru>
Cc:     linus.walleij@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: fix chip ID reading
Message-ID: <20190302180824.646398a2@archlinux>
In-Reply-To: <20190302165455.6594-1-cerg2010cerg2010@mail.ru>
References: <20190302165455.6594-1-cerg2010cerg2010@mail.ru>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  2 Mar 2019 19:54:55 +0300
Sergey Larin <cerg2010cerg2010@mail.ru> wrote:

> According to the datasheet, the last bit of CHIP_ID register controls
> I2C bus, and the first one is unused. Handle this correctly.
> 
> Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
Fix certainly seems to be correct, but seeing as we only support i2c for
this chip and that I assume the bottom bit is actually set (though
reserved), currently this is a tidy up rather than a fix.

Hence I'll take this the slow way rather than quickly as I would
a fix with actual effect.

Let me know if I've missed something!

Jonathan

> ---
>  drivers/iio/gyro/mpu3050-core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 77fac81a3adc..5ddebede31a6 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -29,7 +29,8 @@
>  
>  #include "mpu3050.h"
>  
> -#define MPU3050_CHIP_ID		0x69
> +#define MPU3050_CHIP_ID		0x68
> +#define MPU3050_CHIP_ID_MASK	0x7E
>  
>  /*
>   * Register map: anything suffixed *_H is a big-endian high byte and always
> @@ -1176,8 +1177,9 @@ int mpu3050_common_probe(struct device *dev,
>  		goto err_power_down;
>  	}
>  
> -	if (val != MPU3050_CHIP_ID) {
> -		dev_err(dev, "unsupported chip id %02x\n", (u8)val);
> +	if ((val & MPU3050_CHIP_ID_MASK) != MPU3050_CHIP_ID) {
> +		dev_err(dev, "unsupported chip id %02x\n",
> +				(u8)(val & MPU3050_CHIP_ID_MASK));
>  		ret = -ENODEV;
>  		goto err_power_down;
>  	}

