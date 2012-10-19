Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58444 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759051Ab2JSRmx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 13:42:53 -0400
Message-ID: <508170BE.4060103@kernel.org>
Date: Fri, 19 Oct 2012 16:24:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] staging:iio: Don't compare boolean values with true/false
References: <1350571399-17723-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1350571399-17723-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18/2012 03:43 PM, Lars-Peter Clausen wrote:
> Fixes the following coccicheck warnings:
> 	drivers/staging/iio/accel/lis3l02dq_ring.c:240:5-10: WARNING: Comparison to bool
> 	drivers/staging/iio/iio_dummy_evgen.c:111:6-25: WARNING: Comparison to bool
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Can't say I can summon much enthusiasm for this patch..

Added to togreg branch.
> ---
>  drivers/staging/iio/accel/lis3l02dq_ring.c |    2 +-
>  drivers/staging/iio/iio_dummy_evgen.c      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index fa4190d..ee887e9 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -237,7 +237,7 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  	u8 t;
>  
>  	__lis3l02dq_write_data_ready_config(indio_dev, state);
> -	if (state == false) {
> +	if (!state) {
>  		/*
>  		 * A possible quirk with the handler is currently worked around
>  		 * by ensuring outstanding read events are cleared.
> diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
> index 74e24e8..132d278 100644
> --- a/drivers/staging/iio/iio_dummy_evgen.c
> +++ b/drivers/staging/iio/iio_dummy_evgen.c
> @@ -108,7 +108,7 @@ int iio_dummy_evgen_get_irq(void)
>  
>  	mutex_lock(&iio_evgen->lock);
>  	for (i = 0; i < IIO_EVENTGEN_NO; i++)
> -		if (iio_evgen->inuse[i] == false) {
> +		if (!iio_evgen->inuse[i]) {
>  			ret = iio_evgen->base + i;
>  			iio_evgen->inuse[i] = true;
>  			break;
> 
