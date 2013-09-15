Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54175 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147Ab3IORGQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 13:06:16 -0400
Message-ID: <5235F726.2090208@kernel.org>
Date: Sun, 15 Sep 2013 19:06:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/27] staging:iio: Remove unnecessary casts for iio_push_to_buffers()
References: <1379263880-18405-1-git-send-email-lars@metafoo.de> <1379263880-18405-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/15/13 17:50, Lars-Peter Clausen wrote:
> Now that iio_push_to_buffers() takes a void pointer for the data parameter we
> can remove those casts to u8*.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks.  I'll get to the rest of series another time.
> ---
>  drivers/staging/iio/accel/lis3l02dq_ring.c      | 2 +-
>  drivers/staging/iio/adc/mxs-lradc.c             | 2 +-
>  drivers/staging/iio/iio_simple_dummy_buffer.c   | 2 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
>  drivers/staging/iio/meter/ade7758_ring.c        | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index 5b8f0f6..36dcc7e 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -150,7 +150,7 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
>  			= pf->timestamp;
> -	iio_push_to_buffers(indio_dev, (u8 *)data);
> +	iio_push_to_buffers(indio_dev, data);
>  
>  	kfree(data);
>  done:
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index f36cde5..7401230 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -631,7 +631,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq, void *p)
>  		*timestamp = pf->timestamp;
>  	}
>  
> -	iio_push_to_buffers(iio, (u8 *)lradc->buffer);
> +	iio_push_to_buffers(iio, lradc->buffer);
>  
>  	iio_trigger_notify_done(iio->trig);
>  
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index 72f400c..3921865 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -86,7 +86,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64)))
>  			= iio_get_time_ns();
> -	iio_push_to_buffers(indio_dev, (u8 *)data);
> +	iio_push_to_buffers(indio_dev, data);
>  
>  	kfree(data);
>  
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 00f7067..712f3c2 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -676,7 +676,7 @@ static void ad5933_work(struct work_struct *work)
>  		} else {
>  			buf[0] = be16_to_cpu(buf[0]);
>  		}
> -		iio_push_to_buffers(indio_dev, (u8 *)buf);
> +		iio_push_to_buffers(indio_dev, buf);
>  	} else {
>  		/* no data available - try again later */
>  		schedule_delayed_work(&st->work, st->poll_time_jiffies);
> diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
> index 7d5db71..3d8bc2d 100644
> --- a/drivers/staging/iio/meter/ade7758_ring.c
> +++ b/drivers/staging/iio/meter/ade7758_ring.c
> @@ -73,7 +73,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
>  	if (indio_dev->scan_timestamp)
>  		dat64[1] = pf->timestamp;
>  
> -	iio_push_to_buffers(indio_dev, (u8 *)dat64);
> +	iio_push_to_buffers(indio_dev, dat64);
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> 
