Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58882 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab2IQVLP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Sep 2012 17:11:15 -0400
Message-ID: <505791F2.4030901@kernel.org>
Date: Mon, 17 Sep 2012 22:11:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 1/4] staging:iio:trigger:bfintmr: Avoid divide by zero
References: <1347884808-26833-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1347884808-26833-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/17/2012 01:26 PM, Lars-Peter Clausen wrote:
> If the timer frequency has not been configured yet get_gptimer_period() will
> return 0. Handle this case instead of blindly dividing by the returned value.
Sounds like the sort of thing that only happens when setting board code up
so I'll treat it as an improvement in the code rather than an urgent fix.

Merged to togreg branch.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index ce6a7b1..2772ea2 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -99,9 +99,15 @@ static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
>  {
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	struct bfin_tmr_state *st = trig->private_data;
> +	unsigned int period = get_gptimer_period(st->t->id);
> +	unsigned long val;
>  
> -	return sprintf(buf, "%lu\n",
> -			get_sclk() / get_gptimer_period(st->t->id));
> +	if (period == 0)
> +		val = 0;
> +	else
> +		val = get_sclk() / get_gptimer_period(st->t->id);
> +
> +	return sprintf(buf, "%lu\n", val);
>  }
>  
>  static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR, iio_bfin_tmr_frequency_show,
> 
