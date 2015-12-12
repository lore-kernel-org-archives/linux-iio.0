Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56557 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbbLLP7W (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2015 10:59:22 -0500
Subject: Re: [PATCH 2/3] iio: ina2xx: give the capture kthread a more useful
 name string.
To: Marc Titinger <mtitinger@baylibre.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1449852557-3138-1-git-send-email-mtitinger@baylibre.com>
 <1449852557-3138-2-git-send-email-mtitinger@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <566C4458.3040108@kernel.org>
Date: Sat, 12 Dec 2015 15:59:20 +0000
MIME-Version: 1.0
In-Reply-To: <1449852557-3138-2-git-send-email-mtitinger@baylibre.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/12/15 16:49, Marc Titinger wrote:
>   PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
>   144     2 root     DW       0   0%  33% [ina226:1-8800us]
>   141     2 root     DW       0   0%  25% [ina226:0-8800us]
>    40     2 root     SW       0   0%  15% [irq/156-4802a00]
>   147     2 root     DW       0   0%   7% [ina226:2-8800us]
>   145     1 root     S     1236   0%   6% dd if /dev/iio:device1 of /dev/null
>   148     1 root     S     1236   0%   4% dd if /dev/iio:device2 of /dev/null
>   149   137 root     R     1244   0%   3% top -d 1
>   142     1 root     S     1236   0%   2% dd if /dev/iio:device0 of /dev/null
> 
> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
Could have slightly improved your patch, but saying what it was before in the
description but otherwise seems reasonable so applied to the
togreg branch of iio.git - initially pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ina2xx-adc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index fe42872..99afa6e 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -542,7 +542,8 @@ int ina2xx_buffer_enable(struct iio_dev *indio_dev)
>  	chip->prev_ns = iio_get_time_ns();
>  
>  	chip->task = kthread_run(ina2xx_capture_thread, (void *)indio_dev,
> -				 "ina2xx-%uus", sampling_us);
> +				 "%s:%d-%uus", indio_dev->name, indio_dev->id,
> +				 sampling_us);
>  
>  	return PTR_ERR_OR_ZERO(chip->task);
>  }
> 

