Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-226.synserver.de ([212.40.185.226]:1082 "HELO
	smtp-out-225.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1754934Ab1JZNVV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Oct 2011 09:21:21 -0400
Message-ID: <4EA8094C.7090708@metafoo.de>
Date: Wed, 26 Oct 2011 15:21:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/2] staging:iio:dac: Add AD5421 driver
References: <1319630467-6924-1-git-send-email-lars@metafoo.de> <1319630467-6924-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1319630467-6924-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/26/2011 02:01 PM, Lars-Peter Clausen wrote:
> This patch adds support for the Analog Devices AD5421 Loop-Powered, 4mA to 20mA
> DAC.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> [...]
>
>  drivers/staging/iio/events.h     |    3 +-
>  
> [...]
> diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
> index 7cf9306..2b4d2d9 100644
> --- a/drivers/staging/iio/events.h
> +++ b/drivers/staging/iio/events.h
> @@ -56,7 +56,8 @@ enum iio_event_direction {
>  		       type, chan, chan1, chan2)			\
>  	(((u64)type << 56) | ((u64)diff << 55) |			\
>  	 ((u64)direction << 48) | ((u64)modifier << 40) |		\
> -	 ((u64)chan_type << 32) | (chan2 << 16) | chan1 | chan)
> +	 ((u64)chan_type << 32) | (((s16)chan2) << 16) | ((s16)chan1) | \
> +	 ((s16)chan))
>  

Uhm, this was not supposed to be in this patch...

>  
>  #define IIO_EV_DIR_MAX 4

