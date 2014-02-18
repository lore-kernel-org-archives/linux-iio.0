Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38398 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbaBRKbQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 05:31:16 -0500
Message-ID: <5303369B.2030301@kernel.org>
Date: Tue, 18 Feb 2014 10:31:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: Avoid unnecessary kasprintf
References: <1392387566-8411-1-git-send-email-lars@metafoo.de> <1392387566-8411-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1392387566-8411-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/02/14 14:19, Lars-Peter Clausen wrote:
> name_format already contains the final name and no format characters. So the
> code basically reads:
>
> 	dev_attr->attr.name = kstrdup(GFP_KERNEL, name_format);
> 	if (dev_attr->attr.name == NULL)
> 		...
> 	kfree(name_format);
>
> Which means we can save one alloc and free pair per attribute name if we
> directly assign name_format to dev_attr->attr.name.
>
> The patch also renames name_format to name to denote that this is indeed the
> final name and has no format characters in it.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> I went back through the log and it looks like it has always been like this.
> name_format never actually contained a format string.
oops ;)

It did in my mind at some point.

Good spot.  Applied to the togreg branch of iio.git.
> ---
>   drivers/iio/industrialio-core.c | 39 +++++++++++++--------------------------
>   1 file changed, 13 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index fd96e8b..85a2a07 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -540,7 +540,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>   			   enum iio_shared_by shared_by)
>   {
>   	int ret = 0;
> -	char *name_format = NULL;
> +	char *name = NULL;
>   	char *full_postfix;
>   	sysfs_attr_init(&dev_attr->attr);
>
> @@ -572,16 +572,15 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>   	if (chan->differential) { /* Differential can not have modifier */
>   		switch (shared_by) {
>   		case IIO_SHARED_BY_ALL:
> -			name_format = kasprintf(GFP_KERNEL, "%s", full_postfix);
> +			name = kasprintf(GFP_KERNEL, "%s", full_postfix);
>   			break;
>   		case IIO_SHARED_BY_DIR:
> -			name_format = kasprintf(GFP_KERNEL, "%s_%s",
> +			name = kasprintf(GFP_KERNEL, "%s_%s",
>   						iio_direction[chan->output],
>   						full_postfix);
>   			break;
>   		case IIO_SHARED_BY_TYPE:
> -			name_format
> -				= kasprintf(GFP_KERNEL, "%s_%s-%s_%s",
> +			name = kasprintf(GFP_KERNEL, "%s_%s-%s_%s",
>   					    iio_direction[chan->output],
>   					    iio_chan_type_name_spec[chan->type],
>   					    iio_chan_type_name_spec[chan->type],
> @@ -593,8 +592,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>   				ret = -EINVAL;
>   				goto error_free_full_postfix;
>   			}
> -			name_format
> -				= kasprintf(GFP_KERNEL,
> +			name = kasprintf(GFP_KERNEL,
>   					    "%s_%s%d-%s%d_%s",
>   					    iio_direction[chan->output],
>   					    iio_chan_type_name_spec[chan->type],
> @@ -607,16 +605,15 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>   	} else { /* Single ended */
>   		switch (shared_by) {
>   		case IIO_SHARED_BY_ALL:
> -			name_format = kasprintf(GFP_KERNEL, "%s", full_postfix);
> +			name = kasprintf(GFP_KERNEL, "%s", full_postfix);
>   			break;
>   		case IIO_SHARED_BY_DIR:
> -			name_format = kasprintf(GFP_KERNEL, "%s_%s",
> +			name = kasprintf(GFP_KERNEL, "%s_%s",
>   						iio_direction[chan->output],
>   						full_postfix);
>   			break;
>   		case IIO_SHARED_BY_TYPE:
> -			name_format
> -				= kasprintf(GFP_KERNEL, "%s_%s_%s",
> +			name = kasprintf(GFP_KERNEL, "%s_%s_%s",
>   					    iio_direction[chan->output],
>   					    iio_chan_type_name_spec[chan->type],
>   					    full_postfix);
> @@ -624,33 +621,24 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>
>   		case IIO_SEPARATE:
>   			if (chan->indexed)
> -				name_format
> -					= kasprintf(GFP_KERNEL, "%s_%s%d_%s",
> +				name = kasprintf(GFP_KERNEL, "%s_%s%d_%s",
>   						    iio_direction[chan->output],
>   						    iio_chan_type_name_spec[chan->type],
>   						    chan->channel,
>   						    full_postfix);
>   			else
> -				name_format
> -					= kasprintf(GFP_KERNEL, "%s_%s_%s",
> +				name = kasprintf(GFP_KERNEL, "%s_%s_%s",
>   						    iio_direction[chan->output],
>   						    iio_chan_type_name_spec[chan->type],
>   						    full_postfix);
>   			break;
>   		}
>   	}
> -	if (name_format == NULL) {
> +	if (name == NULL) {
>   		ret = -ENOMEM;
>   		goto error_free_full_postfix;
>   	}
> -	dev_attr->attr.name = kasprintf(GFP_KERNEL,
> -					name_format,
> -					chan->channel,
> -					chan->channel2);
> -	if (dev_attr->attr.name == NULL) {
> -		ret = -ENOMEM;
> -		goto error_free_name_format;
> -	}
> +	dev_attr->attr.name = name;
>
>   	if (readfunc) {
>   		dev_attr->attr.mode |= S_IRUGO;
> @@ -661,8 +649,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>   		dev_attr->attr.mode |= S_IWUSR;
>   		dev_attr->store = writefunc;
>   	}
> -error_free_name_format:
> -	kfree(name_format);
> +
>   error_free_full_postfix:
>   	kfree(full_postfix);
>
>

