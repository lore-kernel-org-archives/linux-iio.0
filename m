Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56173 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbdDNOEY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 10:04:24 -0400
Subject: Re: [PATCH v4 1/1] iio:meter:ade7759: Removing use of deprecated
 macros (S_IRUGO, S_IWUSR)
To: Chen Guanqiao <chen.chenchacha@foxmail.com>, pmeerw@pmeerw.net
References: <20170409043027.13930-3-chen.chenchacha@foxmail.com>
 <20170409152100.30778-1-chen.chenchacha@foxmail.com>
 <20170409152100.30778-2-chen.chenchacha@foxmail.com>
Cc: Michael.Hennerich@analog.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <474b93f3-d0b0-105a-87cf-df082d260fa4@kernel.org>
Date: Fri, 14 Apr 2017 15:04:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170409152100.30778-2-chen.chenchacha@foxmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/04/17 16:21, Chen Guanqiao wrote:
> This fixes the coding style issue of using (S_IWUSR | S_IRUGO) in place of
> 4-digit octal numbers.
> 
> Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/meter/ade7759.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index 68405046dae3..1691760339da 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -317,11 +317,11 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
>  		ade7759_read_16bit,
>  		ade7759_write_16bit,
>  		ADE7759_APGAIN);
> -static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CH_OFF(1, 0644,
>  		ade7759_read_8bit,
>  		ade7759_write_8bit,
>  		ADE7759_CH1OS);
> -static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CH_OFF(2, 0644,
>  		ade7759_read_8bit,
>  		ade7759_write_8bit,
>  		ADE7759_CH2OS);
> 

