Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60701 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161466AbbBDSri (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Feb 2015 13:47:38 -0500
Message-ID: <54D26948.30901@kernel.org>
Date: Wed, 04 Feb 2015 18:47:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
CC: srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v3 1/9] iio: buffer: refactor buffer attributes setup
References: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com> <1422662408-8149-2-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1422662408-8149-2-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/01/15 00:00, Octavian Purdila wrote:
> Move all core (non-custom) buffer attributes to a vector to make it
> easier to add more of them in the future.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Applied to the togreg branch of iio.git - will get pushed out as
testing sometime around Sunday/Monday (back home).
> ---
>  drivers/iio/industrialio-buffer.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 7133314..c2d5440 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -761,6 +761,11 @@ static struct device_attribute dev_attr_length_ro = __ATTR(length,
>  static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
>  		   iio_buffer_show_enable, iio_buffer_store_enable);
>  
> +static struct attribute *iio_buffer_attrs[] = {
> +	&dev_attr_length.attr,
> +	&dev_attr_enable.attr,
> +};
> +
>  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  {
>  	struct iio_dev_attr *p;
> @@ -778,21 +783,23 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  			attrcount++;
>  	}
>  
> -	buffer->buffer_group.name = "buffer";
> -	buffer->buffer_group.attrs = kcalloc(attrcount + 3,
> -			sizeof(*buffer->buffer_group.attrs), GFP_KERNEL);
> -	if (!buffer->buffer_group.attrs)
> +	attr = kcalloc(attrcount + ARRAY_SIZE(iio_buffer_attrs) + 1,
> +		       sizeof(struct attribute *), GFP_KERNEL);
> +	if (!attr)
>  		return -ENOMEM;
>  
> -	if (buffer->access->set_length)
> -		buffer->buffer_group.attrs[0] = &dev_attr_length.attr;
> -	else
> -		buffer->buffer_group.attrs[0] = &dev_attr_length_ro.attr;
> -	buffer->buffer_group.attrs[1] = &dev_attr_enable.attr;
> +	memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
> +	if (!buffer->access->set_length)
> +		attr[0] = &dev_attr_length_ro.attr;
> +
>  	if (buffer->attrs)
> -		memcpy(&buffer->buffer_group.attrs[2], buffer->attrs,
> -			sizeof(*&buffer->buffer_group.attrs) * attrcount);
> -	buffer->buffer_group.attrs[attrcount+2] = NULL;
> +		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
> +		       sizeof(struct attribute *) * attrcount);
> +
> +	attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
> +
> +	buffer->buffer_group.name = "buffer";
> +	buffer->buffer_group.attrs = attr;
>  
>  	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
>  
> 

