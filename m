Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:55479 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab2BQOHX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2012 09:07:23 -0500
Message-ID: <4F3E5EF0.8020000@cam.ac.uk>
Date: Fri, 17 Feb 2012 14:06:40 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: jic23@kernel.org, grant.likely@secretlab.ca,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/4] iio: core: Introduce debugfs support, add support
 for direct register access
References: <1329482772-18054-1-git-send-email-michael.hennerich@analog.com> <1329482772-18054-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1329482772-18054-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2/17/2012 12:46 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich<michael.hennerich@analog.com>
Please can we have some documentation for this. We may not 'have'
to keep debugfs interfaces the same, but they are a type of userspace
abi.

Worth having the code disappear if debugfs isn't actually being built?

Otherwise all fine with me.
>
> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
> ---
>   drivers/staging/iio/iio.h               |    5 +
>   drivers/staging/iio/industrialio-core.c |  124 ++++++++++++++++++++++++++++++-
>   2 files changed, 128 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 42a362c..d0cf71f 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -269,6 +269,9 @@ struct iio_info {
>   				struct iio_trigger *trig);
>   	int (*update_scan_mode)(struct iio_dev *indio_dev,
>   				const unsigned long *scan_mask);
> +	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
> +				  unsigned reg, unsigned writeval,
> +				  unsigned *readval);
>   };
>
>   /**
> @@ -347,6 +350,8 @@ struct iio_dev {
>   	int				groupcounter;
>
>   	unsigned long			flags;
> +	struct dentry			*debugfs_dentry;
> +	unsigned			cached_reg_addr;
>   };
>
>   /**
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index e4824fe..cf48489 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -22,6 +22,7 @@
>   #include<linux/cdev.h>
>   #include<linux/slab.h>
>   #include<linux/anon_inodes.h>
> +#include<linux/debugfs.h>
>   #include "iio.h"
>   #include "iio_core.h"
>   #include "iio_core_trigger.h"
> @@ -39,6 +40,8 @@ struct bus_type iio_bus_type = {
>   };
>   EXPORT_SYMBOL(iio_bus_type);
>
> +static struct dentry *iio_debugfs_dentry;
> +
>   static const char * const iio_data_type_name[] = {
>   	[IIO_RAW] = "raw",
>   	[IIO_PROCESSED] = "input",
> @@ -129,6 +132,8 @@ static int __init iio_init(void)
>   		goto error_unregister_bus_type;
>   	}
>
> +	iio_debugfs_dentry = debugfs_create_dir("iio", NULL);
> +
>   	return 0;
>
>   error_unregister_bus_type:
> @@ -142,6 +147,114 @@ static void __exit iio_exit(void)
>   	if (iio_devt)
>   		unregister_chrdev_region(iio_devt, IIO_DEV_MAX);
>   	bus_unregister(&iio_bus_type);
> +	debugfs_remove_recursive(iio_debugfs_dentry);
> +}
> +
> +static int iio_debugfs_open(struct inode *inode, struct file *file)
> +{
> +	if (inode->i_private)
> +		file->private_data = inode->i_private;
> +
> +	return 0;
> +}
> +
> +static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
> +			      size_t count, loff_t *ppos)
> +{
> +	struct iio_dev *indio_dev = file->private_data;
> +	char buf[80], *p = buf;
> +	unsigned val;
> +	int ret;
> +
> +	ret = indio_dev->info->debugfs_reg_access(indio_dev,
> +						  indio_dev->cached_reg_addr,
> +						  0,&val);
> +	if (ret)
> +		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
> +
I'd prefer a length parameter and using &buf.  A little easier to read 
to my mind.
> +	p += sprintf(p, "0x%X\n", val);
snprintf.  80 chars seems excessive but it is fixed length.
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
> +}
> +
> +static ssize_t iio_debugfs_write_reg(struct file *file,
> +		     const char __user *userbuf, size_t count, loff_t *ppos)
> +{
> +	struct iio_dev *indio_dev = file->private_data;
> +	unsigned reg, val;
> +	char buf[80], *p = buf;
> +	int ret;
> +
> +	count = min_t(size_t, count, (sizeof(buf)-1));
> +	if (copy_from_user(p, userbuf, count))
> +		return -EFAULT;
> +
> +	ret = sscanf(p, "%x %x",&reg,&val);
> +
> +	switch (ret) {
> +	case 1:
> +		indio_dev->cached_reg_addr = reg;
> +		break;
> +	case 2:
> +		indio_dev->cached_reg_addr = reg;
> +		ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
> +							  val, NULL);
> +		if (ret) {
> +			dev_err(indio_dev->dev.parent, "%s: write failed\n",
> +				__func__);
> +			return ret;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations iio_debugfs_reg_fops = {
> +	.open = iio_debugfs_open,
> +	.read = iio_debugfs_read_reg,
> +	.write = iio_debugfs_write_reg,
> +};
> +
> +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
> +{
> +	debugfs_remove_recursive(indio_dev->debugfs_dentry);
> +}
> +
> +static int iio_device_register_debugfs(struct iio_dev *indio_dev)
> +{
> +	struct dentry *d;
> +
> +	if (indio_dev->info->debugfs_reg_access == NULL)
> +		return 0;
> +
> +	if (IS_ERR(iio_debugfs_dentry))
> +		return 0;
> +
> +	indio_dev->debugfs_dentry =
> +		debugfs_create_dir(dev_name(&indio_dev->dev),
> +				   iio_debugfs_dentry);
> +	if (IS_ERR(indio_dev->debugfs_dentry))
> +		return IS_ERR(indio_dev->debugfs_dentry);
> +
> +	if (indio_dev->debugfs_dentry == NULL) {
> +		dev_warn(indio_dev->dev.parent,
> +			 "Failed to create debugfs directory\n");
> +		return -EFAULT;
excess blank line.
> +
> +	}
> +
> +	d = debugfs_create_file("direct_reg_access", 0644,
> +				indio_dev->debugfs_dentry,
> +				indio_dev,&iio_debugfs_reg_fops);
> +	if (!d) {
> +		iio_device_unregister_debugfs(indio_dev);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
>   }
>
>   static ssize_t iio_read_channel_info(struct device *dev,
> @@ -565,6 +678,7 @@ static void iio_dev_release(struct device *device)
>   		iio_device_unregister_trigger_consumer(indio_dev);
>   	iio_device_unregister_eventset(indio_dev);
>   	iio_device_unregister_sysfs(indio_dev);
> +	iio_device_unregister_debugfs(indio_dev);
>   }
>
>   static struct device_type iio_dev_type = {
> @@ -680,11 +794,17 @@ int iio_device_register(struct iio_dev *indio_dev)
>   	/* configure elements for the chrdev */
>   	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
>
> +	ret = iio_device_register_debugfs(indio_dev);
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent,
> +			"Failed to register debugfs interfaces\n");
> +		goto error_ret;
> +	}
>   	ret = iio_device_register_sysfs(indio_dev);
>   	if (ret) {
>   		dev_err(indio_dev->dev.parent,
>   			"Failed to register sysfs interfaces\n");
> -		goto error_ret;
> +		goto error_unreg_debugfs;
>   	}
>   	ret = iio_device_register_eventset(indio_dev);
>   	if (ret) {
> @@ -711,6 +831,8 @@ error_unreg_eventset:
>   	iio_device_unregister_eventset(indio_dev);
>   error_free_sysfs:
>   	iio_device_unregister_sysfs(indio_dev);
> +error_unreg_debugfs:
> +	iio_device_unregister_debugfs(indio_dev);
>   error_ret:
>   	return ret;
>   }

