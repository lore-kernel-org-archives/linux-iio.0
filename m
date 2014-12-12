Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47064 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934845AbaLLK5c (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 05:57:32 -0500
Message-ID: <548ACA1A.7050209@kernel.org>
Date: Fri, 12 Dec 2014 10:57:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 08/11] iio: buffer: Move iio_buffer_alloc_sysfs and iio_buffer_free_sysfs
References: <1417024517-7564-1-git-send-email-lars@metafoo.de> <1417024517-7564-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1417024517-7564-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/11/14 17:55, Lars-Peter Clausen wrote:
> The next patch will introduce new dependencies in iio_buffer_alloc_sysfs()
> to functions which are currently defined after iio_buffer_alloc_sysfs(). To
> avoid forward declarations move both iio_buffer_alloc_sysfs() and
> iio_buffer_free_sysfs() after those function.
> 
> This is split into two patches one moving the functions and one adding the
> dependencies to make review of the actual changes easier.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied though naturally I'm now kind of regretting renaming those functions earlier
as I had to chase that change through here. Not exactly challenging but I could
have been lazy and renamed them as a follow up patch ;)

J
> ---
>  drivers/iio/industrialio-buffer.c | 184 +++++++++++++++++++-------------------
>  1 file changed, 91 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index e1906ad..cdc2482 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -383,99 +383,6 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static const char * const iio_scan_elements_group_name = "scan_elements";
> -
> -int iio_buffer_alloc_sysfs(struct iio_dev *indio_dev)
> -{
> -	struct iio_dev_attr *p;
> -	struct attribute **attr;
> -	struct iio_buffer *buffer = indio_dev->buffer;
> -	int ret, i, attrn, attrcount, attrcount_orig = 0;
> -	const struct iio_chan_spec *channels;
> -
> -	if (!buffer)
> -		return 0;
> -
> -	if (buffer->attrs)
> -		indio_dev->groups[indio_dev->groupcounter++] = buffer->attrs;
> -
> -	if (buffer->scan_el_attrs != NULL) {
> -		attr = buffer->scan_el_attrs->attrs;
> -		while (*attr++ != NULL)
> -			attrcount_orig++;
> -	}
> -	attrcount = attrcount_orig;
> -	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
> -	channels = indio_dev->channels;
> -	if (channels) {
> -		/* new magic */
> -		for (i = 0; i < indio_dev->num_channels; i++) {
> -			if (channels[i].scan_index < 0)
> -				continue;
> -
> -			/* Establish necessary mask length */
> -			if (channels[i].scan_index >
> -			    (int)indio_dev->masklength - 1)
> -				indio_dev->masklength
> -					= channels[i].scan_index + 1;
> -
> -			ret = iio_buffer_add_channel_sysfs(indio_dev,
> -							 &channels[i]);
> -			if (ret < 0)
> -				goto error_cleanup_dynamic;
> -			attrcount += ret;
> -			if (channels[i].type == IIO_TIMESTAMP)
> -				indio_dev->scan_index_timestamp =
> -					channels[i].scan_index;
> -		}
> -		if (indio_dev->masklength && buffer->scan_mask == NULL) {
> -			buffer->scan_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
> -						    sizeof(*buffer->scan_mask),
> -						    GFP_KERNEL);
> -			if (buffer->scan_mask == NULL) {
> -				ret = -ENOMEM;
> -				goto error_cleanup_dynamic;
> -			}
> -		}
> -	}
> -
> -	buffer->scan_el_group.name = iio_scan_elements_group_name;
> -
> -	buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
> -					      sizeof(buffer->scan_el_group.attrs[0]),
> -					      GFP_KERNEL);
> -	if (buffer->scan_el_group.attrs == NULL) {
> -		ret = -ENOMEM;
> -		goto error_free_scan_mask;
> -	}
> -	if (buffer->scan_el_attrs)
> -		memcpy(buffer->scan_el_group.attrs, buffer->scan_el_attrs,
> -		       sizeof(buffer->scan_el_group.attrs[0])*attrcount_orig);
> -	attrn = attrcount_orig;
> -
> -	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> -		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
> -	indio_dev->groups[indio_dev->groupcounter++] = &buffer->scan_el_group;
> -
> -	return 0;
> -
> -error_free_scan_mask:
> -	kfree(buffer->scan_mask);
> -error_cleanup_dynamic:
> -	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> -
> -	return ret;
> -}
> -
> -void iio_buffer_free_sysfs(struct iio_dev *indio_dev)
> -{
> -	if (!indio_dev->buffer)
> -		return;
> -
> -	kfree(indio_dev->buffer->scan_mask);
> -	kfree(indio_dev->buffer->scan_el_group.attrs);
> -	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
> -}
>  
>  ssize_t iio_buffer_read_length(struct device *dev,
>  			       struct device_attribute *attr,
> @@ -855,6 +762,97 @@ done:
>  }
>  EXPORT_SYMBOL(iio_buffer_store_enable);
>  
> +static const char * const iio_scan_elements_group_name = "scan_elements";
> +
> +int iio_buffer_alloc_sysfs(struct iio_dev *indio_dev)
> +{
> +	struct iio_dev_attr *p;
> +	struct attribute **attr;
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	int ret, i, attrn, attrcount, attrcount_orig = 0;
> +	const struct iio_chan_spec *channels;
> +
> +	if (!buffer)
> +		return 0;
> +
> +	if (buffer->scan_el_attrs != NULL) {
> +		attr = buffer->scan_el_attrs->attrs;
> +		while (*attr++ != NULL)
> +			attrcount_orig++;
> +	}
> +	attrcount = attrcount_orig;
> +	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
> +	channels = indio_dev->channels;
> +	if (channels) {
> +		/* new magic */
> +		for (i = 0; i < indio_dev->num_channels; i++) {
> +			if (channels[i].scan_index < 0)
> +				continue;
> +
> +			/* Establish necessary mask length */
> +			if (channels[i].scan_index >
> +			    (int)indio_dev->masklength - 1)
> +				indio_dev->masklength
> +					= channels[i].scan_index + 1;
> +
> +			ret = iio_buffer_add_channel_sysfs(indio_dev,
> +							 &channels[i]);
> +			if (ret < 0)
> +				goto error_cleanup_dynamic;
> +			attrcount += ret;
> +			if (channels[i].type == IIO_TIMESTAMP)
> +				indio_dev->scan_index_timestamp =
> +					channels[i].scan_index;
> +		}
> +		if (indio_dev->masklength && buffer->scan_mask == NULL) {
> +			buffer->scan_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
> +						    sizeof(*buffer->scan_mask),
> +						    GFP_KERNEL);
> +			if (buffer->scan_mask == NULL) {
> +				ret = -ENOMEM;
> +				goto error_cleanup_dynamic;
> +			}
> +		}
> +	}
> +
> +	buffer->scan_el_group.name = iio_scan_elements_group_name;
> +
> +	buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
> +					      sizeof(buffer->scan_el_group.attrs[0]),
> +					      GFP_KERNEL);
> +	if (buffer->scan_el_group.attrs == NULL) {
> +		ret = -ENOMEM;
> +		goto error_free_scan_mask;
> +	}
> +	if (buffer->scan_el_attrs)
> +		memcpy(buffer->scan_el_group.attrs, buffer->scan_el_attrs,
> +		       sizeof(buffer->scan_el_group.attrs[0])*attrcount_orig);
> +	attrn = attrcount_orig;
> +
> +	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> +		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
> +	indio_dev->groups[indio_dev->groupcounter++] = &buffer->scan_el_group;
> +
> +	return 0;
> +
> +error_free_scan_mask:
> +	kfree(buffer->scan_mask);
> +error_cleanup_dynamic:
> +	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> +
> +	return ret;
> +}
> +
> +void iio_buffer_free_sysfs(struct iio_dev *indio_dev)
> +{
> +	if (!indio_dev->buffer)
> +		return;
> +
> +	kfree(indio_dev->buffer->scan_mask);
> +	kfree(indio_dev->buffer->scan_el_group.attrs);
> +	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
> +}
> +
>  /**
>   * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
>   * @indio_dev: the iio device
> 

