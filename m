Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F0C388F9
	for <linux-iio@archiver.kernel.org>; Sat, 21 Nov 2020 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7A7221FE
	for <linux-iio@archiver.kernel.org>; Sat, 21 Nov 2020 15:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPBMz81l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgKUPke (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Nov 2020 10:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgKUPke (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 10:40:34 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8D4E221FE;
        Sat, 21 Nov 2020 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605973233;
        bh=McaOV8/zg42IEF5gX/n6qLoPnRy6MYlv2RrjL5vHdY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BPBMz81lFJ2F++dCLKNHA/Izk7ylw4YLhmqjC47V30GVAEG9U06gEpU+enwG1xv5h
         /lhCblg9rmpt+TsnGTRBXbAxqxab3C7C81jYn2Y7AqjjHwMyKMC4YUx1jvYbHGMR4v
         Zf0WQWkALgYqIXAEK1UBx5TmkS/mfqB2n25vibM8=
Date:   Sat, 21 Nov 2020 15:40:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adis16209: remove unneeded
 spi_set_drvdata()
Message-ID: <20201121154029.3950c659@archlinux>
In-Reply-To: <20201119141806.84827-1-alexandru.ardelean@analog.com>
References: <20201119141806.84827-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Nov 2020 16:18:06 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> There is no matching spi_get_drvdata() in the driver. This looks like a
> left-over from before the driver was converted to device-managed functions.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied

> ---
>  drivers/iio/accel/adis16209.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
> index 4a841aec6268..6c2d4a967de7 100644
> --- a/drivers/iio/accel/adis16209.c
> +++ b/drivers/iio/accel/adis16209.c
> @@ -279,7 +279,6 @@ static int adis16209_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->name = spi->dev.driver->name;
>  	indio_dev->info = &adis16209_info;

