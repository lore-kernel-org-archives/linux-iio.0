Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47000 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbdBYR6J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 12:58:09 -0500
Subject: Re: [PATCH v3 1/2] iio: Allow triggers to be used as parent of others
 triggers
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
References: <1487947695-9305-1-git-send-email-benjamin.gaignard@st.com>
 <1487947695-9305-2-git-send-email-benjamin.gaignard@st.com>
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dd1574ca-cedf-08c3-c8c3-7ee7a701c2ec@kernel.org>
Date: Sat, 25 Feb 2017 17:57:38 +0000
MIME-Version: 1.0
In-Reply-To: <1487947695-9305-2-git-send-email-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/02/17 14:48, Benjamin Gaignard wrote:
> Add "parent_trigger" sysfs attribute to iio trigger to be able
> to set a parent to the current trigger.
> Parent trigger edges or levels could be used to control current
> trigger status for example to start, stop or reset it.
> 
> Introduce validate_trigger function in iio_trigger_ops which does
> the same than validate_device but with a trigger as second parameter.
> Driver must implement this function and add dev_attr_parent_trigger
> in their trigger attribute group to be able to use parent trigger
> feature.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
It might be worth a cover letter for this series with even more detail,
or perhaps even a proposed page for the sphinx docs.

It's interesting stuff, but not necessarily obvious to a newcomer
to this discussion.

We really need to expand those sphinx docs anyway.
I was thinking of a whole series of pages on 'weird / sophiscated'
usage of IIO, touching on stuff like Peter Rosin's analog front
ends and Matt Ranostay's more novel health and chemical sensors.
i.e. the stuff that 'stretches' us ;)

Jonathan
> 
> version 3:
> - try to provide better description of parent_trigger usages
> 
> version 2:
> - add comment about parent trigger usage
> - parent trigger attribute must be set the driver no more by IIO core
> ---
>  .../ABI/testing/sysfs-bus-iio-trigger-sysfs        | 15 +++++
>  drivers/iio/industrialio-trigger.c                 | 69 ++++++++++++++++++++++
>  include/linux/iio/trigger.h                        |  7 ++-
>  3 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
> index 04ac623..1e7fc40 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
> @@ -40,3 +40,18 @@ Description:
>  		associated file, representing the id of the trigger that needs
>  		to be removed. If the trigger can't be found, an invalid
>  		argument message will be returned to the user.
> +
> +What:		/sys/bus/iio/devices/triggerX/parent_trigger
> +KernelVersion:	4.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to set a trigger as parent for the
> +		current trigger. If the trigger can't use the parent an
> +		invalid argument message will be returned.
> +		Parent trigger edges or levels could be used to control current
> +		trigger. For example current trigger could be started on parent
> +		rising edges or be enabled only when parent trigger level is
> +		high.
> +		Since there is many ways to use parent edges and levels to
> +		control current trigger behavoir an additional custom sysfs
> +		attribute may be needed to describe those control modes.
The only bit I'd change in here is dropping the word custom.

I'm an optimist: We may yet figure out a nice generic interface!
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 978729f..9891fb2 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -58,6 +58,74 @@ static ssize_t iio_trigger_read_name(struct device *dev,
>  
>  static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
>  
> +/**
> + * iio_trigger_read_parent() - trigger consumer sysfs query parent trigger
> + * @dev:	device associated with an industrial I/O trigger
> + * @attr:	pointer to the device_attribute structure that
> + *		is being processed
> + * @buf:	buffer where the current trigger name will be printed into
> + *
> + * Return: a negative number on failure, the number of characters written
> + *	   on success or 0 if no trigger is available
> + */
> +static ssize_t iio_trigger_read_parent(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct iio_trigger *trig = to_iio_trigger(dev);
> +
> +	if (trig->parent_trigger)
> +		return sprintf(buf, "%s\n", trig->parent_trigger->name);
> +
> +	return 0;
> +}
> +
> +static struct iio_trigger *iio_trigger_find_by_name(const char *name,
> +						    size_t len);
> +
> +/**
> + * iio_trigger_write_parent() - trigger consumer sysfs set parent trigger
> + * @dev:	device associated with an industrial I/O trigger
> + * @attr:	device attribute that is being processed
> + * @buf:	string buffer that holds the name of the trigger
> + * @len:	length of the trigger name held by buf
> + *
> + * Return: negative error code on failure or length of the buffer
> + *	   on success
> + */
> +static ssize_t iio_trigger_write_parent(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t len)
> +{
> +	struct iio_trigger *parent;
> +	struct iio_trigger *child = to_iio_trigger(dev);
> +	int ret;
> +
> +	if (!child->ops->validate_trigger)
> +		return -EINVAL;
> +
> +	if (atomic_read(&child->use_count))
> +		return -EBUSY;
> +
> +	parent = iio_trigger_find_by_name(buf, len);
> +
> +	if (parent == child->parent_trigger)
> +		return len;
> +
> +	ret = child->ops->validate_trigger(child, parent);
> +	if (ret)
> +		return ret;
> +
> +	child->parent_trigger = parent;
> +
> +	return len;
> +}
> +
> +DEVICE_ATTR(parent_trigger, S_IRUGO | S_IWUSR,
> +	    iio_trigger_read_parent, iio_trigger_write_parent);
> +EXPORT_SYMBOL_GPL(dev_attr_parent_trigger);
> +
>  static struct attribute *iio_trig_dev_attrs[] = {
>  	&dev_attr_name.attr,
>  	NULL,
> @@ -440,6 +508,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>  						     indio_dev->pollfunc_event);
>  		iio_trigger_put(oldtrig);
>  	}
> +
>  	if (indio_dev->trig) {
>  		iio_trigger_get(indio_dev->trig);
>  		if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index ea08302..efa2983 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -20,6 +20,7 @@ struct iio_subirq {
>  
>  struct iio_dev;
>  struct iio_trigger;
> +extern struct device_attribute dev_attr_parent_trigger;
>  
>  /**
>   * struct iio_trigger_ops - operations structure for an iio_trigger.
> @@ -29,6 +30,7 @@ struct iio_subirq {
>   *			use count is zero (may be NULL)
>   * @validate_device:	function to validate the device when the
>   *			current trigger gets changed.
> + * @validate_trigger:	function to validate the parent trigger (may be NULL)
>   *
>   * This is typically static const within a driver and shared by
>   * instances of a given device.
> @@ -39,9 +41,10 @@ struct iio_trigger_ops {
>  	int (*try_reenable)(struct iio_trigger *trig);
>  	int (*validate_device)(struct iio_trigger *trig,
>  			       struct iio_dev *indio_dev);
> +	int (*validate_trigger)(struct iio_trigger *trig,
> +				struct iio_trigger *parent);
>  };
>  
> -
>  /**
>   * struct iio_trigger - industrial I/O trigger device
>   * @ops:		[DRIVER] operations structure
> @@ -59,6 +62,7 @@ struct iio_trigger_ops {
>   * @attached_own_device:[INTERN] if we are using our own device as trigger,
>   *			i.e. if we registered a poll function to the same
>   *			device as the one providing the trigger.
> + * @parent_trigger:	[INTERN] parent trigger
>   **/
>  struct iio_trigger {
>  	const struct iio_trigger_ops	*ops;
> @@ -77,6 +81,7 @@ struct iio_trigger {
>  	unsigned long pool[BITS_TO_LONGS(CONFIG_IIO_CONSUMERS_PER_TRIGGER)];
>  	struct mutex			pool_lock;
>  	bool				attached_own_device;
> +	struct iio_trigger		*parent_trigger;
>  };
>  
>  
> 

