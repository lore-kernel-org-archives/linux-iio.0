Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52684 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab2IVJI3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2012 05:08:29 -0400
Message-ID: <505D800C.3070506@kernel.org>
Date: Sat, 22 Sep 2012 10:08:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensors: Prevent crash during hot-unplug
References: <1348100144-1826-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1348100144-1826-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/20/2012 01:15 AM, Srinivas Pandruvada wrote:
> When hid sensor hub is unplugged, there is a crash in
> iio_device_unregister_trigger_consumer.
> In a typical IIO driver when remove is called, it will unregister and free
> trigger and then it will call iio_device_free.
> The function iio_trigger_free() will free the allocated memory for trigger.
> If this trigger was assigned to iio_dev->trig, then it should be set to NULL.
> Othewise when iio_device_free() is called later, it finally calls
> iio_device_unregsister_trigger(), which checks for
>        if (indio_dev->trig)
>                 iio_trigger_put(indio_dev->trig);
> If indio_dev->trig is not set to NULL, it calls iio_trigger_put on a bad
> pointer causing crash.
> This scenerio can happen in any driver, which is storing trigger pointer in
> iio_dev structure and following current procedure during remove.
Added to togreg branch.

Good catch, we'll have to audit other drivers for the same problem.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 12277e8..d4b790d 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -56,6 +56,7 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev)
>  {
>  	iio_trigger_unregister(indio_dev->trig);
>  	iio_trigger_free(indio_dev->trig);
> +	indio_dev->trig = NULL;
>  }
>  EXPORT_SYMBOL(hid_sensor_remove_trigger);
>  
> 
