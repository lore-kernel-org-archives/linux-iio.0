Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44598 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbcICOeX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 10:34:23 -0400
Subject: Re: [PATCH v3] iio: trigger: allow immutable triggers to be assigned
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1472884575-29831-1-git-send-email-matt@ranostay.consulting>
Cc: Matt Ranostay <matt@ranostay.consulting>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1b63c7d3-dfb8-65de-2bd7-6cd6993b8ff5@kernel.org>
Date: Sat, 3 Sep 2016 15:32:53 +0100
MIME-Version: 1.0
In-Reply-To: <1472884575-29831-1-git-send-email-matt@ranostay.consulting>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/16 07:36, Matt Ranostay wrote:
> From: Matt Ranostay <mranostay@gmail.com>
> 
> There are times when an assigned trigger to a device shouldn't ever
> change after intialization.
> 
> Examples of this being used is when an provider device has a trigger
> that is assigned to an ADC, which uses it populate data into a callback
> buffer.
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Applied to the togreg branch of iio.git.

Initially pushed out as testing for the autobuilders to play
with it.

Peter, if you want to add an Ack / review or other comment
before I push this out as togreg, that would be cool.

Jonathan
> ---
> 
> Changes from v1:
>  * use bool instead of int for trig_readonly property
> 
> Changes from v2:
>  * make commit message more verbose
>  * change dst to indio_dev
> 
>  drivers/iio/industrialio-trigger.c | 20 ++++++++++++++++++++
>  include/linux/iio/iio.h            |  2 ++
>  include/linux/iio/trigger.h        |  9 +++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 7ad82fdd3e5b..3dde81e57e97 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -119,6 +119,22 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
>  }
>  EXPORT_SYMBOL(iio_trigger_unregister);
>  
> +int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *trig)
> +{
> +	if (!indio_dev || !trig)
> +		return -EINVAL;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	WARN_ON(indio_dev->trig_readonly);
> +
> +	indio_dev->trig = iio_trigger_get(trig);
> +	indio_dev->trig_readonly = true;
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(iio_trigger_set_immutable);
> +
>  /* Search for trigger by name, assuming iio_trigger_list_lock held */
>  static struct iio_trigger *__iio_trigger_find_by_name(const char *name)
>  {
> @@ -384,6 +400,10 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>  		mutex_unlock(&indio_dev->mlock);
>  		return -EBUSY;
>  	}
> +	if (indio_dev->trig_readonly) {
> +		mutex_unlock(&indio_dev->mlock);
> +		return -EPERM;
> +	}
>  	mutex_unlock(&indio_dev->mlock);
>  
>  	trig = iio_trigger_find_by_name(buf, len);
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 854e2dad1e0d..786952cd509f 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -483,6 +483,7 @@ struct iio_buffer_setup_ops {
>   * @scan_timestamp:	[INTERN] set if any buffers have requested timestamp
>   * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
>   * @trig:		[INTERN] current device trigger (buffer modes)
> + * @trig_readonly	[INTERN] mark the current trigger immutable
>   * @pollfunc:		[DRIVER] function run on trigger being received
>   * @pollfunc_event:	[DRIVER] function run on events trigger being received
>   * @channels:		[DRIVER] channel specification structure table
> @@ -523,6 +524,7 @@ struct iio_dev {
>  	bool				scan_timestamp;
>  	unsigned			scan_index_timestamp;
>  	struct iio_trigger		*trig;
> +	bool				trig_readonly;
>  	struct iio_poll_func		*pollfunc;
>  	struct iio_poll_func		*pollfunc_event;
>  
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 1c9e028e0d4a..a122bdd4076c 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -132,6 +132,15 @@ int iio_trigger_register(struct iio_trigger *trig_info);
>  void iio_trigger_unregister(struct iio_trigger *trig_info);
>  
>  /**
> + * iio_trigger_set_immutable() - set an immutable trigger on destination
> + *
> + * @indio_dev - IIO device structure containing the device
> + * @trig - trigger to assign to device
> + *
> + **/
> +int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *trig);
> +
> +/**
>   * iio_trigger_poll() - called on a trigger occurring
>   * @trig:	trigger which occurred
>   *
> 

