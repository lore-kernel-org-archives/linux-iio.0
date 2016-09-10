Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58570 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754249AbcIJPmg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 11:42:36 -0400
Subject: Re: [PATCH] iio: iio_push_event(): Don't crash if the event interface
 is not registered
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1473353350-5797-1-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6b01e25c-4a5a-a775-1693-d4f2b1bc4049@kernel.org>
Date: Sat, 10 Sep 2016 16:42:34 +0100
MIME-Version: 1.0
In-Reply-To: <1473353350-5797-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/09/16 17:49, Lars-Peter Clausen wrote:
> iio_push_event() operates on a struct iio_dev. This struct can be allocated
> using iio_device_alloc() which returns a valid struct iio_dev pointer. But
> iio_push_event() is not safe to use on such a iio_dev until
> iio_device_register() for the same device has successfully completed.
> 
> This restriction is not documented anywhere and most drivers are written
> with the assumption that this restriction does not exist. The basic pattern
> that is followed by all drivers looks like the following:
> 
> 	irqreturn_t event_callback(int irq, void *devid)
> 	{
> 		struct iio_dev *indio_dev = devid;
> 		...
> 		iio_push_event(indio_dev, ...);
> 
> 		return IRQ_HANDLED;
> 	}
> 
> 	int driver_probe(struct device *dev)
> 	{
> 		struct iio_dev *indio_dev;
> 
> 		indio_dev = iio_device_alloc(...);
> 
> 		request_irq(event_irq, event_callback, ..., indio_dev);
> 
> 		return iio_device_register(indio_dev);
> 	}
> 
> And while it is unlikely that the IRQ fires before iio_device_register()
> completes (e.g. because the IRQ is disabled in the device) it is not
> impossible and might be triggered by glitches on the signal line or
> incorrect hardware configuration.
> 
> To avoid undefined behaviour in such a case extend iio_push_event() to
> check if the event has been registered and discard generated events if it
> has not.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
As we haven't had any cases reported of this actually causing crashes in
the wild I'm going to take it via the togreg branch and the next merge
window.

Obviously we can create cases where this is a problem using shared interrupts
or spurious ones so maybe we'll request it goes to stable in the medium term.

Lets see if anyone screams ;)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-event.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 0ebfc92..90fac8e 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -57,6 +57,11 @@ bool iio_event_enabled(const struct iio_event_interface *ev_int)
>   *
>   * Note: The caller must make sure that this function is not running
>   * concurrently for the same indio_dev more than once.
> + *
> + * This function may be safely used as soon as a valid reference to iio_dev has
> + * been obtained via iio_device_alloc(), but any events that are submitted
> + * before iio_device_register() has successfully completed will be silently
> + * discarded.
>   **/
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
>  {
> @@ -64,6 +69,9 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
>  	struct iio_event_data ev;
>  	int copied;
>  
> +	if (!ev_int)
> +		return 0;
> +
>  	/* Does anyone care? */
>  	if (iio_event_enabled(ev_int)) {
>  
> 

