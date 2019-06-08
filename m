Return-Path: <SRS0=r/ex=UH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2CDC28CC5
	for <linux-iio@archiver.kernel.org>; Sat,  8 Jun 2019 14:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A69C21537
	for <linux-iio@archiver.kernel.org>; Sat,  8 Jun 2019 14:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFHOK5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 Jun 2019 10:10:57 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33252 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHOK5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 10:10:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 044129E8FD6;
        Sat,  8 Jun 2019 15:10:54 +0100 (BST)
Date:   Sat, 8 Jun 2019 15:10:53 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ad_sigma_delta: return directly in
 ad_sd_buffer_postenable()
Message-ID: <20190608151053.7d09c1b3@archlinux>
In-Reply-To: <20190530072541.22268-1-alexandru.ardelean@analog.com>
References: <20190530072541.22268-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 May 2019 10:25:41 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> There is nothing being done after the `err_predisable` label, so just
> remove it.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index a4310600a853..ec0e38566ece 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -358,7 +358,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  	ret = ad_sigma_delta_set_channel(sigma_delta,
>  		indio_dev->channels[channel].address);
>  	if (ret)
> -		goto err_predisable;
> +		return ret;
>  
>  	spi_bus_lock(sigma_delta->spi->master);
>  	sigma_delta->bus_locked = true;
> @@ -375,7 +375,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  
>  err_unlock:
>  	spi_bus_unlock(sigma_delta->spi->master);
> -err_predisable:
>  
>  	return ret;
>  }

