Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:58742 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1HSKSM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Aug 2011 06:18:12 -0400
Message-ID: <4E4E3A4B.7040804@cam.ac.uk>
Date: Fri, 19 Aug 2011 11:26:19 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: capfun: fix - mask must be type u64
References: <1313668903-18115-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1313668903-18115-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/18/11 13:01, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> mask must be type u64 otherwise it won't hold a full event code
Fix merged to original patch.  Thanks and good spot.
All branches updated and pushed to iio-blue.git

(sorry all, nasty forces rebasing  so you'll probably have to create a patch set
of whatever you have on top and rebuild your local tree).

Going to be the case till these patches are in shape I'm afraid.

> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/iio_core.h          |    2 +-
>  drivers/staging/iio/industrialio-core.c |    9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
> index 433952b..85ac5b2 100644
> --- a/drivers/staging/iio/iio_core.h
> +++ b/drivers/staging/iio/iio_core.h
> @@ -33,7 +33,7 @@ int __iio_add_chan_devattr(const char *postfix,
>  						struct device_attribute *attr,
>  						const char *buf,
>  						size_t len),
> -			   int mask,
> +			   u64 mask,
>  			   bool generic,
>  			   struct device *dev,
>  			   struct list_head *attr_list);
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index 4aa538f..35e81f8 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -519,7 +519,7 @@ int __iio_add_chan_devattr(const char *postfix,
>  						struct device_attribute *attr,
>  						const char *buf,
>  						size_t len),
> -			   int mask,
> +			   u64 mask,
>  			   bool generic,
>  			   struct device *dev,
>  			   struct list_head *attr_list)
> @@ -643,7 +643,7 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
>  	else
>  		ret = sysfs_create_group(&dev_info->dev.kobj,
>  					 &iio_base_dummy_group);
> -	
> +
>  	if (ret) {
>  		dev_err(dev_info->dev.parent,
>  			"Failed to register sysfs hooks\n");
> @@ -663,7 +663,7 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
>  			if (ret < 0)
>  				goto error_clear_attrs;
>  		}
> -	if (dev_info->name) { 
> +	if (dev_info->name) {
>  		ret = sysfs_add_file_to_group(&dev_info->dev.kobj,
>  					      &dev_attr_name.attr,
>  					      NULL);
> @@ -796,7 +796,8 @@ static ssize_t iio_ev_value_store(struct device *dev,
>  static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
>  				      struct iio_chan_spec const *chan)
>  {
> -	int ret = 0, i, mask = 0;
> +	int ret = 0, i;
> +	u64 mask = 0;
>  	char *postfix;
>  	if (!chan->event_mask)
>  		return 0;

