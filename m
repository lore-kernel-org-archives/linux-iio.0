Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49100 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbbHOUCC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 16:02:02 -0400
Subject: Re: [PATCH 2/2] Staging: iio: trigger: Use braces on both branches of
 if statement
To: Cristina Opriceana <cristina.opriceana@gmail.com>
References: <cover.1439286814.git.cristina.opriceana@gmail.com>
 <d9079236646cd08ab1f55a71ec67830dd8813e72.1439286814.git.cristina.opriceana@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF9AB8.1030503@kernel.org>
Date: Sat, 15 Aug 2015 21:02:00 +0100
MIME-Version: 1.0
In-Reply-To: <d9079236646cd08ab1f55a71ec67830dd8813e72.1439286814.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/08/15 11:20, Cristina Opriceana wrote:
> Fix style issue related to missing braces, detected by checkpatch.pl.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Applied to the togreg branch of iio.git.

This one used to be left as optional, so there are a lot of these in older
code (and in IIO you don't get much older than this!)

For reference, it is going away the moment the high resolution timer
trigger is in as this support is emulated in all modern rtc drivers
anyway (was using actual hardware in the rtc when this driver was written).

Anyhow, even code with a short likely time to live can be well formatted!

Applied.

Jonathan
> ---
>  drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> index a2a42c2..2db8857 100644
> --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> @@ -74,8 +74,9 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
>  		if (ret == 0 && trig_info->state && trig_info->frequency == 0)
>  			ret = rtc_irq_set_state(trig_info->rtc,
>  						&trig_info->task, 1);
> -	} else
> +	} else {
>  		ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, 0);
> +	}
>  	if (ret)
>  		goto error_ret;
>  
> 

