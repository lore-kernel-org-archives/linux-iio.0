Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932132AbdJURfA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:35:00 -0400
Date: Sat, 21 Oct 2017 18:34:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 04/13] staging: iio: tsl2x7x: remove unnecessary struct
 iio_dev definition
Message-ID: <20171021183455.533f7195@archlinux>
In-Reply-To: <20171019200632.25820-5-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
        <20171019200632.25820-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 16:06:23 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x.h has a blank definition for 'struct iio_dev' that is not
> needed. This patch removes that definition.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index a216c6943a84..df00f2ec1719 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -23,8 +23,6 @@
>  #define __TSL2X7X_H
>  #include <linux/pm.h>
>  
> -struct iio_dev;
> -
>  struct tsl2x7x_lux {
>  	unsigned int ratio;
>  	unsigned int ch0;

