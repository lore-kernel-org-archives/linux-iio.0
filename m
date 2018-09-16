Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbeIPQly (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 12:41:54 -0400
Date: Sun, 16 Sep 2018 12:19:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/2] staging:iio:ad7606: Remove incorrect kernel doc
 annotations
Message-ID: <20180916121912.096ab8db@archlinux>
In-Reply-To: <20180913110212.29068-1-alexandru.ardelean@analog.com>
References: <20180913110212.29068-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Sep 2018 14:02:11 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The ad7606_chip_info struct does not have the lock & name fields. Remove
> the kernel documentation annotations for it.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7606.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index 24c2a85f5c5a..57f11b46bc69 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -11,10 +11,8 @@
>  
>  /**
>   * struct ad7606_chip_info - chip specific information
> - * @name:		identification string for chip
>   * @channels:		channel specification
>   * @num_channels:	number of channels
> - * @lock		protect sensor state
>   */
>  
>  struct ad7606_chip_info {
