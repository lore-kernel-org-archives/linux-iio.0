Return-Path: <pmeerw@pmeerw.net>
Date: Fri, 2 Sep 2016 09:19:16 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Matt Ranostay <mranostay@gmail.com>
cc: linux-iio@vger.kernel.org, jic23@kernel.org,
    Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH v2] iio: trigger: allow immutable triggers to be
 assigned
In-Reply-To: <1472797685-12212-1-git-send-email-matt@ranostay.consulting>
Message-ID: <alpine.DEB.2.02.1609020910130.7602@pmeerw.net>
References: <1472797685-12212-1-git-send-email-matt@ranostay.consulting>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


nitpicking ahead

> There are times when a trigger consumer shouldn't be allowed to change
> triggers after intialization.

> This is useful with use of callback buffers pushing ADC data back to the
> trigger providers iio device.

not clear, grammar

> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
> 
> Changes from v1:
>  * use bool instead of int for trig_readonly property
> 
>  drivers/iio/industrialio-trigger.c | 20 ++++++++++++++++++++
>  include/linux/iio/iio.h            |  2 ++
>  include/linux/iio/trigger.h        |  9 +++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 7ad82fdd3e5b..a3ae3873f998 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -119,6 +119,22 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
>  }
>  EXPORT_SYMBOL(iio_trigger_unregister);
>  
> +int iio_trigger_set_immutable(struct iio_dev *dst, struct iio_trigger *trig)

dst is not an obvious choice for the iio_dev variable, how about 
indio_dev?

> +{
> +	if (!dst || !trig)
> +		return -EINVAL;
> +
> +	mutex_lock(&dst->mlock);
> +	WARN_ON(dst->trig_readonly);
> +
> +	dst->trig = iio_trigger_get(trig);
> +	dst->trig_readonly = true;
> +	mutex_unlock(&dst->mlock);
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
> index 1c9e028e0d4a..9e22284a4122 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -132,6 +132,15 @@ int iio_trigger_register(struct iio_trigger *trig_info);
>  void iio_trigger_unregister(struct iio_trigger *trig_info);
>  
>  /**
> + * iio_trigger_set_immutable() - set an immutable trigger on destination
> + *
> + * @dst - destination device for trigger
> + * @trig - trigger to assign to destination
> + *
> + **/
> +int iio_trigger_set_immutable(struct iio_dev *dst, struct iio_trigger *trig);
> +
> +/**
>   * iio_trigger_poll() - called on a trigger occurring
>   * @trig:	trigger which occurred
>   *
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
