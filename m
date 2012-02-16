Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:46114 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab2BPOgS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2012 09:36:18 -0500
Message-ID: <4F3D142E.20403@cam.ac.uk>
Date: Thu, 16 Feb 2012 14:35:26 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/5] staging:iio: Add extended IIO channel info
References: <1329389351-21584-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1329389351-21584-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fairly busy day so just some initial comments.  I'll think about this 
some more when I get
a chance...
> Sometimes devices have per channel properties which either do not map nicely to
> the current channel info scheme (e.g. string properties) or are very device
> specific, so it does not make sense to add generic support for them.
For the second class is it so bad to just put them in via attrs?  The 
first I agree
entirely should be supported in a fashion similar to this.  What you 
have here is
going to involve a fairly similar amount of boiler plate.
>
> Currently drivers define these attributes by hand for each channel. Depending on
> the number of channels this can amount to quite a few lines of boilerplate code.
> Especially if a driver supports multiple variations of a chip with different
> numbers of channels. In this case it becomes necessary to have a individual
> attribute list per chip variation and also a individual iio_info struct.
>
> This patch introduces a new scheme for handling such per channel attributes
> called extended channel info attributes. A extended channel info attribute
> consist of a name, a flag whether it is shared and read and write callbacks.
> The read and write callbacks are similar to the {read,write}_raw callbacks and
> take a IIO device and a channel as their first parameters, but instead of
> pre-parsed integer values they directly get passed the raw string value, which
> has been written to the sysfs file.
>
> It is possible to assign a list of extended channel info attributes to a
> channel. For each extended channel info attribute the IIO core will create a new
> sysfs attribute conforming to the IIO channel naming spec for the channels type,
> similar as for normal info attributes. Read and write access to this sysfs
> attribute will be redirected to the extended channel info attributes read and
> write callbacks.
My questions with this are about how it will interact with in kernel 
users. It is definitely
worth having a string type iio_info element.
I wonder if we want to allow free naming?  Could we define an enum to cover
'string' type iio_info elements?
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
> ---
>   drivers/staging/iio/iio.h               |   23 ++++++++++++
>   drivers/staging/iio/industrialio-core.c |   61 ++++++++++++++++++++++++++++---
>   2 files changed, 78 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index be6ced3..2a0cfbb 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -88,6 +88,25 @@ enum iio_endian {
>   	IIO_LE,
>   };
>
> +struct iio_chan_spec;
> +struct iio_dev;
> +
> +/**
> + * struct iio_chan_spec_ext_info - Extended channel info attribute
> + * @name:	Info attribute name
> + * @shared:	Whether this attribute is shared between all channels.
> + * @read:	Read callback for this info attribute, may be NULL.
> + * @write:	Write callback for this info attribute, may be NULL.
> + */
> +struct iio_chan_spec_ext_info {
> +	const char *name;
> +	bool shared;
> +	ssize_t (*read)(struct iio_dev *, struct iio_chan_spec const *,
> +			char *buf);
> +	ssize_t (*write)(struct iio_dev *, struct iio_chan_spec const *,
> +			const char *buf, size_t len);
> +};
Is it worth making the callbacks also take the const char *name from 
above in the structure or
define some sort of 'private' integer in here. I'm just thinking of 
aiding reuse of the
callbacks
> +
>   /**
>    * struct iio_chan_spec - specification of a single channel
>    * @type:		What type of measurement is the channel making.
> @@ -107,6 +126,9 @@ enum iio_endian {
>    * @info_mask:		What information is to be exported about this channel.
>    *			This includes calibbias, scale etc.
>    * @event_mask:	What events can this channel produce.
> + * @ext_info:		List of extended info attributes for this channel.
> + *			The list is NULL terminated, the last element should
> + *			have it's name field set to NULL.
It's not a list, it's an array.
>    * @extend_name:	Allows labeling of channel attributes with an
>    *			informative name. Note this has no effect codes etc,
>    *			unlike modifiers.
> @@ -141,6 +163,7 @@ struct iio_chan_spec {
>   	} scan_type;
>   	long			info_mask;
>   	long			event_mask;
> +	const struct iio_chan_spec_ext_info *ext_info;
>   	char			*extend_name;
>   	const char		*datasheet_name;
>   	unsigned		processed_val:1;
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index e4824fe..a02b6ec 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -144,6 +144,33 @@ static void __exit iio_exit(void)
>   	bus_unregister(&iio_bus_type);
>   }
>
> +static ssize_t iio_read_channel_ext_info(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	const struct iio_chan_spec_ext_info *ext_info;
> +
> +	ext_info =&this_attr->c->ext_info[this_attr->address];
> +
> +	return ext_info->read(indio_dev, this_attr->c, buf);
> +}
> +
> +static ssize_t iio_write_channel_ext_info(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf,
> +					 size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	const struct iio_chan_spec_ext_info *ext_info;
> +
> +	ext_info =&this_attr->c->ext_info[this_attr->address];
> +
> +	return ext_info->write(indio_dev, this_attr->c, buf, len);
> +}
> +
>   static ssize_t iio_read_channel_info(struct device *dev,
>   				     struct device_attribute *attr,
>   				     char *buf)
> @@ -401,10 +428,13 @@ int __iio_add_chan_devattr(const char *postfix,
>   	list_for_each_entry(t, attr_list, l)
>   		if (strcmp(t->dev_attr.attr.name,
>   			   iio_attr->dev_attr.attr.name) == 0) {
> -			if (!generic)
> +			if (!generic) {
>   				dev_err(dev, "tried to double register : %s\n",
>   					t->dev_attr.attr.name);
> -			ret = -EBUSY;
> +				ret = -EBUSY;
> +			} else {
> +				ret = 0;
> +			}
I would roll this and the next one into a separate precursor patch 
given. It's necessary
for the change you have here, but nice and easily separated.
>   			goto error_device_attr_deinit;
>   		}
>   	list_add(&iio_attr->l, attr_list);
> @@ -423,6 +453,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>   					struct iio_chan_spec const *chan)
>   {
>   	int ret, i, attrcount = 0;
> +	const struct iio_chan_spec_ext_info *ext_info;
>
>   	if (chan->channel<  0)
>   		return 0;
> @@ -449,14 +480,32 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>   					     !(i%2),
>   					&indio_dev->dev,
>   					&indio_dev->channel_attr_list);
> -		if (ret == -EBUSY&&  (i%2 == 0)) {
> -			ret = 0;
> -			continue;
> -		}

>   		if (ret<  0)
>   			goto error_ret;
>   		attrcount++;
>   	}
> +
> +	if (chan->ext_info) {
> +		unsigned int i = 0;
> +		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
> +			ret = __iio_add_chan_devattr(ext_info->name,
> +					chan,
> +					ext_info->read ?
> +					&iio_read_channel_ext_info : NULL,
> +					ext_info->write ?
> +					&iio_write_channel_ext_info : NULL,
> +					i,
> +					ext_info->shared,
> +					&indio_dev->dev,
> +					&indio_dev->channel_attr_list);
> +			if (ret)
> +				goto error_ret;
> +			i++;
> +		}
> +
> +		attrcount += i;
> +	}
> +
>   	ret = attrcount;
>   error_ret:
>   	return ret;

