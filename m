Return-Path: <jic23@kernel.org>
Message-ID: <4FFF23C6.6080707@kernel.org>
Date: Thu, 12 Jul 2012 20:21:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 Fengguang Wu <wfg@linux.intel.com>
Subject: Re: [PATCH] staging:iio:max1363: Don't free uninitialized variable
References: <1341998903-4702-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1341998903-4702-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/11/2012 10:28 AM, Lars-Peter Clausen wrote:
> It is possible that on one of the error paths we are going to try to free
> 'rxbuf', even though it has not been allocated yet, which cause the following
> warning:
> 	drivers/staging/iio/adc/max1363_ring.c: In function 'max1363_trigger_handler':
> 		drivers/staging/iio/adc/max1363_ring.c:87:7: warning: 'rxbuf' may be used
> 		uninitialized in this function
> 
> Reported-by: Fengguang Wu <wfg@linux.intel.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
merged to fixes-togreg and pull request sent.
> ---
>  drivers/staging/iio/adc/max1363_ring.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
> index bf6b0c2..774ae1b 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -74,7 +74,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  	else
>  		b_sent = i2c_master_recv(st->client, rxbuf, numvals);
>  	if (b_sent < 0)
> -		goto done;
> +		goto done_free;
>  
>  	time_ns = iio_get_time_ns();
>  
> @@ -82,9 +82,10 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  		memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
>  	iio_push_to_buffer(indio_dev->buffer, rxbuf, time_ns);
>  
> +done_free:
> +	kfree(rxbuf);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> -	kfree(rxbuf);
>  
>  	return IRQ_HANDLED;
>  }
> 
