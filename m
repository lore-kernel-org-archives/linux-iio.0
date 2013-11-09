Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51463 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab3KIKrX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Nov 2013 05:47:23 -0500
Message-ID: <527E2100.408@kernel.org>
Date: Sat, 09 Nov 2013 11:48:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
CC: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH 2/2] iio: Drop scan_type from viperboard adc driver
References: <1383421488-5167-1-git-send-email-pmeerw@pmeerw.net> <1383421488-5167-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1383421488-5167-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/02/13 19:44, Peter Meerwald wrote:
> the driver does not support buffering, hence scan_type is not needed
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Lars Poeschel <poeschel@lemonage.de>
We've left this sort of thing in in the past as it acts as documentation whilst
doing little harm.

Still in this driver there is nothing 'interesting' in the definition
so I've applied your patch to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/adc/viperboard_adc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
> index 09727a7..94f404d 100644
> --- a/drivers/iio/adc/viperboard_adc.c
> +++ b/drivers/iio/adc/viperboard_adc.c
> @@ -42,11 +42,6 @@ struct vprbrd_adc {
>  	.indexed = 1,					\
>  	.channel = _index,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> -	.scan_index = _index,				\
> -	.scan_type = {					\
> -		.sign = 'u',				\
> -		.realbits = 8,				\
> -		.storagebits = 8,			\
>  	},						\
>  }
>  
> @@ -73,7 +68,7 @@ static int vprbrd_iio_read_raw(struct iio_dev *iio_dev,
>  		mutex_lock(&vb->lock);
>  
>  		admsg->cmd = VPRBRD_ADC_CMD_GET;
> -		admsg->chan = chan->scan_index;
> +		admsg->chan = chan->channel;
>  		admsg->val = 0x00;
>  
>  		ret = usb_control_msg(vb->usb_dev,
> 
