Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbeIBNed (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 09:34:33 -0400
Date: Sun, 2 Sep 2018 10:19:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] Revert "iio: temperature: maxim_thermocouple: add
 MAX31856 part"
Message-ID: <20180902101924.03f63471@archlinux>
In-Reply-To: <20180825090048.17438-1-matt.ranostay@konsulko.com>
References: <20180825090048.17438-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 25 Aug 2018 02:00:48 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> This reverts commit 535fba29b3e1afef4ba201b3c69a6992583ec0bd.
> 
> Seems the submitter (er me, hang head in shame) didn't look at the datasheet
> enough to see that the registers are quite different.
> 
> This needs to be reverted because a) would never work b) to open it  be added
> to a Maxim RTDs (Resistance Temperature Detectors) under development by author
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the fixes-to greg branch of iio.git and marked for stable
so we avoid confusing people in the future.

Jonathan

> ---
>  drivers/iio/temperature/maxim_thermocouple.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index 54e383231d1e..c31b9633f32d 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -258,7 +258,6 @@ static int maxim_thermocouple_remove(struct spi_device *spi)
>  static const struct spi_device_id maxim_thermocouple_id[] = {
>  	{"max6675", MAX6675},
>  	{"max31855", MAX31855},
> -	{"max31856", MAX31855},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
> -- 
> 2.17.1
> 
