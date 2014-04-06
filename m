Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:57592 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143AbaDFKLI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 6 Apr 2014 06:11:08 -0400
Message-ID: <53412836.1010802@gmx.de>
Date: Sun, 06 Apr 2014 12:11:02 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 2/6] staging:iio:adc:spear_adc drop initialization of
 unused scan_type
References: <1396716315-2465-1-git-send-email-jic23@kernel.org> <1396716315-2465-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1396716315-2465-3-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb:
> As the driver does not support the buffered interfaces of IIO this is
> not used.
I trust you in this one, but I can't assess it right now with my limited IIO-buffer background knowledge. So, regard it as a silent ack, to not hold you back.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Stefan Roese <sr@denx.de>
> ---
>  drivers/staging/iio/adc/spear_adc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
> index 49293f9..c4e928b 100644
> --- a/drivers/staging/iio/adc/spear_adc.c
> +++ b/drivers/staging/iio/adc/spear_adc.c
> @@ -179,10 +179,6 @@ static int spear_read_raw(struct iio_dev *indio_dev,
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>  	.channel = idx,					\
> -	.scan_type = {					\
> -		.sign = 'u',				\
> -		.storagebits = 16,			\
> -	},						\
>  }
>  
>  static const struct iio_chan_spec spear_adc_iio_channels[] = {

