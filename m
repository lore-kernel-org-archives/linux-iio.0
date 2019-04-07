Return-Path: <SRS0=Zm7d=SJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281BFC10F0E
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 11:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48C721738
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554635262;
	bh=oE9nAIvv710UMXXfEF5SIplmCofunw5aeXjjnQmNjjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IQ6apiY+vpWRbPzfroWPlrCZnO0fCUafFS/dfIwZYtmt/8bZ4DymmbuRpmUFdXozw
	 iau18j6cZwki7hrkbZGThH0iNDQM3+rxb2X+smKitb2MUo3aAN47RYyOxwYWTet9Wt
	 CwHcYOIHNGf8tKCW0S1lCVvjnDG4DL86O8RRGsug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDGLHl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGLHl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Apr 2019 07:07:41 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E309720880;
        Sun,  7 Apr 2019 11:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554635260;
        bh=oE9nAIvv710UMXXfEF5SIplmCofunw5aeXjjnQmNjjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HGeL4vbufiTjnP7/kFNai3BPo1rfKxYxcxw9J2H8eEWWqUPp/fEqfU/B+4Of8xlMn
         ocEGRYJtQEQ7F6Dggml6ZbrC/lsJ5oRBbpiL/Xgfdsj55UuTwRpktzVF1lNHP/LvVx
         4oRbHCXBI6a1TPlkuEvmbhaqB0PoYZ+e880247HU=
Date:   Sun, 7 Apr 2019 12:07:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: imx7d_adc: Use devm_iio_device_register()
Message-ID: <20190407120735.6fe78a5b@archlinux>
In-Reply-To: <20190403070325.1077-4-andrew.smirnov@gmail.com>
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
        <20190403070325.1077-4-andrew.smirnov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  3 Apr 2019 00:03:22 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Use devm_iio_device_register() and drop explicit call to
> iio_device_unregister().
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
No to this one.  The thing to think about is the resulting order
of the unwinding that happens in remove.

Do take a look at the code flow, but in short what happens is:

1. driver.remove()
2. Devm release functions run in the opposite order to they were
   called during setup.

The upshot of the change you just made here is that we turn the power
off to the device before we remove the userspace interfaces, giving
potentially interesting failures..

There are two options to avoid this:

1. Make everything use devm_ calls (often using devm_add_action_or_reset
for the ones that don't have their own versions).

2. Stop using devm managed functions at the first non devm_ call that needs
unwinding.  From that point onwards in probe / remove you have to do everything
manually.

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 72cfe9834bcb..9a46838ec7cf 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -517,7 +517,7 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  	imx7d_adc_feature_config(info);
>  	imx7d_adc_hw_init(info);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret) {
>  		imx7d_adc_power_down(info);
>  		dev_err(&pdev->dev, "Couldn't register the device.\n");
> @@ -539,8 +539,6 @@ static int imx7d_adc_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct imx7d_adc *info = iio_priv(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -
>  	imx7d_adc_power_down(info);
>  
>  	clk_disable_unprepare(info->clk);

