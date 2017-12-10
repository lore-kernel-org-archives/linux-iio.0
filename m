Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbdLJS2i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 13:28:38 -0500
Date: Sun, 10 Dec 2017 18:28:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: hx711: fix bug in reset functionality
Message-ID: <20171210182834.7ecdb9fe@archlinux>
In-Reply-To: <20171206085220.GA15428@arbeit>
References: <20171206085220.GA15428@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 6 Dec 2017 09:52:20 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Return value in hx711_reset() should indicate status of dout otherwise the
> calling function is reporting an error as false positive
> 
> If there are two reads too close to each other, then the second one will
> never succeed. This happens especially when using buffered mode with both
> channels enabled.
> 
> When changing the channel on every trigger event the former 100 ms are not
> enough for waiting until the device indicates normal mode.
> 
> Wait up to 1 second until the device turns into normal mode.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
This looks fine to me. I'll pick it up once patch 1 is ready.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/hx711.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 37982b93a227..0a2d0b6cd38a 100644
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

