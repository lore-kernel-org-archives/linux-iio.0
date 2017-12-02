Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdLBNWa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 08:22:30 -0500
Date: Sat, 2 Dec 2017 13:22:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: hx711: fix bug in reset functionality
Message-ID: <20171202132226.36bc96f3@archlinux>
In-Reply-To: <20171130214445.GA27345@arbeit>
References: <20171130214445.GA27345@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 30 Nov 2017 22:44:45 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> return value in hx711_reset() should indicate status of dout
> otherwise the calling function is reporting an error als false positive
> 
> wait up to 1 second until the device is in normal state
> by changing the channel on every trigger event it turned out that the
> former 100 ms are not enough for waiting until the device is in normal mode

What is the ultimate result of this?  I'm trying to assess if we want
to marked it for stable trees or just apply it ready for the next
merge window.  It think it means that two reads too close to each
other will always result in an error for the second one rather than 
the intended delay and then succeed?

Thanks,

Jonathan
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  drivers/iio/adc/hx711.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index d773fd69a76d..eabd2e66aca3 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -153,15 +153,16 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
>  	int i, val;
>  
>  	/*
> -	 * a maximum reset cycle time of 56 ms was measured.
> -	 * we round it up to 100 ms
> +	 * in some rare cases the reset takes quite a long time
> +	 * especially when the channel is changed.
> +	 * Allow up to one second for it
>  	 */
>  	for (i = 0; i < 100; i++) {
>  		val = gpiod_get_value(hx711_data->gpiod_dout);
>  		if (!val)
>  			break;
> -		/* sleep at least 1 ms */
> -		msleep(1);
> +		/* sleep at least 10 ms */
> +		msleep(10);
>  	}
>  	if (val)
>  		return -EIO;
> @@ -203,9 +204,7 @@ static int hx711_reset(struct hx711_data *hx711_data)
>  		 * after a dummy read we need to wait vor readiness
>  		 * for not mixing gain pulses with the clock
>  		 */
> -		ret = hx711_wait_for_ready(hx711_data);
> -		if (ret)
> -			return ret;
> +		val = hx711_wait_for_ready(hx711_data);
>  	}
>  
>  	return val;

