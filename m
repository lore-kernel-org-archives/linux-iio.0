Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58625 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755153AbcIJPuD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 11:50:03 -0400
Subject: Re: [PATCH 2/3] iio: st_sensors: use the helper function
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1472718439-16734-1-git-send-email-linus.walleij@linaro.org>
 <1472718439-16734-2-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4bf712f5-6afd-d14f-02c1-55d7d6fb8876@kernel.org>
Date: Sat, 10 Sep 2016 16:50:01 +0100
MIME-Version: 1.0
In-Reply-To: <1472718439-16734-2-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/16 09:27, Linus Walleij wrote:
> The ST sensors can be used as a trigger for its own triggered buffer
> but it is also possible to use an external trigger: a HRTimer or
> even a different sensor (!) as trigger. In that case we should not
> pick the timestamp from our own interrupt top half even if it is
> active.
> 
> This could practically happen if some other sensor is using the
> ST sensor as trigger but the ST sensor itself is using e.g.
> an HRTimer as trigger. So the trigger is on, but not used by us.
> 
> We used to assume that whenever the hardware interrupt is turned
> on, we are using it for our own trigger, but this is an
> oversimplification.
> 
> Handle this logically by using the iio_trigger_using_own() helper.
> 
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Crestez Dan Leonard <leonard.crestez@intel.com>
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index d06e728cea37..fe7775bb3740 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -63,7 +63,7 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
>  	 * the hardware trigger) and the hw_timestamp may get updated.
>  	 * By storing it in a local variable first, we are safe.
>  	 */
> -	if (sdata->hw_irq_trigger)
> +	if (iio_trigger_using_own(indio_dev))
>  		timestamp = sdata->hw_timestamp;
>  	else
>  		timestamp = iio_get_time_ns(indio_dev);
> 

