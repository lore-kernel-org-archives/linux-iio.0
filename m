Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753530AbeFJNm4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Jun 2018 09:42:56 -0400
Date: Sun, 10 Jun 2018 14:42:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>,
        device-drivers-devel@blackfin.uclinux.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7606: fix function pointer
 parameter names missing.
Message-ID: <20180610144252.31794e13@archlinux>
In-Reply-To: <20180608221331.116928-1-giulio.benetti@micronovasrl.com>
References: <20180608221331.116928-1-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  9 Jun 2018 00:13:31 +0200
Giulio Benetti <giulio.benetti@micronovasrl.com> wrote:

> Checkpatch.pl complains about function pointer parameter names missing.
> 
> Add parameter names.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7606.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index acaed8d5379c..9716ee9d94a7 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -57,7 +57,7 @@ struct ad7606_state {
>  
>  struct ad7606_bus_ops {
>  	/* more methods added in future? */
> -	int (*read_block)(struct device *, int, void *);
> +	int (*read_block)(struct device *dev, int num, void *data);
>  };
>  
>  int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,

