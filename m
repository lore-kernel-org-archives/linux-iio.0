Return-Path: <SRS0=TOo6=4C=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B5DC2BA83
	for <linux-iio@archiver.kernel.org>; Fri, 14 Feb 2020 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4571A217F4
	for <linux-iio@archiver.kernel.org>; Fri, 14 Feb 2020 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695332;
	bh=uGCGLRGoU3g45VCxwnCAPerREcE8t/lFXtzjEKoahHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dwfnwZESPi6iWe2B6+X2jzWPimTrPkn+rLcQve6lsAqemtKFKUAjABIMohj95NJdR
	 WxqXrppQWUtGSlbDoROES+Dw6+DeO9XN+SWG2UEIyp2Nu/y3hTMHHLtKCgSjnQ/0j0
	 603qJJEik5U6yL5LQRwafCirhmlWUi8FpMRidiag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgBNPsv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbgBNPsv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 10:48:51 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B592086A;
        Fri, 14 Feb 2020 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695331;
        bh=uGCGLRGoU3g45VCxwnCAPerREcE8t/lFXtzjEKoahHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jonSeFxLGd0GwMK9iCwlLlOh1yN0kH4R4m90Co623DJqk3q0eFf/6WppwgzJ+fUyc
         +yrgcrwF7dABE8ZQ+qdH4LndsJySmLCHQ4zOttAzWo6zwh5MqpTyXxZgi2OekSEpDG
         hxwbtErh+Zky5v1/qa4IBY7ctbZYS3mrJATDgLQs=
Date:   Fri, 14 Feb 2020 15:48:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] staging: iio: adc: ad7192: removed spi_device_id
Message-ID: <20200214154846.7daf946c@archlinux>
In-Reply-To: <20200212161721.16200-4-alexandru.tachici@analog.com>
References: <20200212161721.16200-1-alexandru.tachici@analog.com>
        <20200212161721.16200-4-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Feb 2020 18:17:19 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This patch removes spi_device_id table and moves the
> init data (id of the chip) in the .data field
> of of_device_id table.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Applied

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.c | 33 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 8fca8915543d..8ec28aa8fa8a 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/sched.h>
>  #include <linux/delay.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -876,6 +877,15 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static const struct of_device_id ad7192_of_match[] = {
> +	{ .compatible = "adi,ad7190", .data = (void *)ID_AD7190 },
> +	{ .compatible = "adi,ad7192", .data = (void *)ID_AD7192 },
> +	{ .compatible = "adi,ad7193", .data = (void *)ID_AD7193 },
> +	{ .compatible = "adi,ad7195", .data = (void *)ID_AD7195 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ad7192_of_match);
> +
>  static int ad7192_probe(struct spi_device *spi)
>  {
>  	struct ad7192_state *st;
> @@ -928,7 +938,7 @@ static int ad7192_probe(struct spi_device *spi)
>  	}
>  
>  	spi_set_drvdata(spi, indio_dev);
> -	st->devid = spi_get_device_id(spi)->driver_data;
> +	st->devid = (unsigned long)of_device_get_match_data(&spi->dev);
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -1009,26 +1019,6 @@ static int ad7192_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static const struct spi_device_id ad7192_id[] = {
> -	{"ad7190", ID_AD7190},
> -	{"ad7192", ID_AD7192},
> -	{"ad7193", ID_AD7193},
> -	{"ad7195", ID_AD7195},
> -	{}
> -};
> -
> -MODULE_DEVICE_TABLE(spi, ad7192_id);
> -
> -static const struct of_device_id ad7192_of_match[] = {
> -	{ .compatible = "adi,ad7190" },
> -	{ .compatible = "adi,ad7192" },
> -	{ .compatible = "adi,ad7193" },
> -	{ .compatible = "adi,ad7195" },
> -	{}
> -};
> -
> -MODULE_DEVICE_TABLE(of, ad7192_of_match);
> -
>  static struct spi_driver ad7192_driver = {
>  	.driver = {
>  		.name	= "ad7192",
> @@ -1036,7 +1026,6 @@ static struct spi_driver ad7192_driver = {
>  	},
>  	.probe		= ad7192_probe,
>  	.remove		= ad7192_remove,
> -	.id_table	= ad7192_id,
>  };
>  module_spi_driver(ad7192_driver);
>  

