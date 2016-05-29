Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32822 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbcE2OA7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 10:00:59 -0400
Subject: Re: [PATCH] iio: triggers: Make trigger ops structure explicitly non
 optional.
To: linux-iio@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
References: <1463247728-31491-1-git-send-email-jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4231f8d4-61c4-eb1c-67cf-ca8dbe17fc72@kernel.org>
Date: Sun, 29 May 2016 15:00:57 +0100
MIME-Version: 1.0
In-Reply-To: <1463247728-31491-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/05/16 18:42, Jonathan Cameron wrote:
> This structure has not been optional for a long time (if ever) but the
> code implies that it is.  As we then use it later in a fashion that would
> crash if it was infact NULL, gcc may well have optimized all these tests
> out anyway.  However, it's inconsistent so fix it up by removing unnecessary
> checkes.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
As this is trivial, an no one seems to care - applied to the togreg branch
of iio.git with some of the terrible spelling above corrected and the
reference to gcc optimizing the tests out removed (as it is specifically
prevented from doing so).

Jonathan
> ---
>  drivers/iio/industrialio-trigger.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index ae2806aafb72..672911293987 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -68,6 +68,10 @@ int iio_trigger_register(struct iio_trigger *trig_info)
>  {
>  	int ret;
>  
> +	/* trig_info->ops is required for the module member */
> +	if (!trig_info->ops)
> +		return -EINVAL;
> +
>  	trig_info->id = ida_simple_get(&iio_trigger_ida, 0, 0, GFP_KERNEL);
>  	if (trig_info->id < 0)
>  		return trig_info->id;
> @@ -164,8 +168,7 @@ EXPORT_SYMBOL(iio_trigger_poll_chained);
>  
>  void iio_trigger_notify_done(struct iio_trigger *trig)
>  {
> -	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
> -		trig->ops->try_reenable)
> +	if (atomic_dec_and_test(&trig->use_count) && trig->ops->try_reenable)
>  		if (trig->ops->try_reenable(trig))
>  			/* Missed an interrupt so launch new poll now */
>  			iio_trigger_poll(trig);
> @@ -219,7 +222,7 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  		return ret;
>  	}
>  
> -	if (trig->ops && trig->ops->set_trigger_state && notinuse) {
> +	if (trig->ops->set_trigger_state && notinuse) {
>  		ret = trig->ops->set_trigger_state(trig, true);
>  		if (ret < 0)
>  			module_put(pf->indio_dev->info->driver_module);
> @@ -236,7 +239,7 @@ static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
>  		= (bitmap_weight(trig->pool,
>  				 CONFIG_IIO_CONSUMERS_PER_TRIGGER)
>  		   == 1);
> -	if (trig->ops && trig->ops->set_trigger_state && no_other_users) {
> +	if (trig->ops->set_trigger_state && no_other_users) {
>  		ret = trig->ops->set_trigger_state(trig, false);
>  		if (ret)
>  			return ret;
> @@ -358,7 +361,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>  			return ret;
>  	}
>  
> -	if (trig && trig->ops && trig->ops->validate_device) {
> +	if (trig && trig->ops->validate_device) {
>  		ret = trig->ops->validate_device(trig, indio_dev);
>  		if (ret)
>  			return ret;
> 

