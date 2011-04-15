Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:45242 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026Ab1DONEG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2011 09:04:06 -0400
Message-ID: <4DA842B7.6010905@cam.ac.uk>
Date: Fri, 15 Apr 2011 14:05:59 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO-onwards: ADC: AD7476: Fix ringbuffer registration
References: <1302859676-24706-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1302859676-24706-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/15/11 10:27, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
Thanks, merged into rebase of tree.  The type cast is no unnecessary
as I've constified inputs to iio_ring_buffer_register_ex
(that was in the branch I accidentally didn't push last night!)

> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/adc/ad7476_core.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
> index 5867b92..a3cd4cd 100644
> --- a/drivers/staging/iio/adc/ad7476_core.c
> +++ b/drivers/staging/iio/adc/ad7476_core.c
> @@ -209,7 +209,9 @@ static int __devinit ad7476_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_free_device;
>  
> -	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
> +	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
> +			(struct iio_chan_spec *) st->chip_info->channel,
> +			ARRAY_SIZE(st->chip_info->channel));
>  	if (ret)
>  		goto error_cleanup_ring;
>  	return 0;

