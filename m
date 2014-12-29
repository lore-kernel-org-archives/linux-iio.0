Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59422 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbaL2JWc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 29 Dec 2014 04:22:32 -0500
Date: Mon, 29 Dec 2014 11:23:58 +0200
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: ensure scan index is unique at device register
Message-ID: <20141229092358.GC16917@vdogaru>
References: <1419844489-8890-1-git-send-email-vlad.dogaru@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419844489-8890-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Dec 29, 2014 at 11:14:49AM +0200, Vlad Dogaru wrote:
> Having two or more channels with the same positive scan_index field
> makes no sense.  Prevent this situation by failing to register a device
> if two scan indexes are identical.

Please drop this, I will send an updated version shortly.

The current patch refuses to register the rather common situation where
a device doesn't support buffering and doesn't explicitly set scan_index
for its channels (thus defaulting to zero).  Sorry for the noise.

> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> Changes since v2:
>  - rebase to latest togreg branch.
> Changes since v1:
>  - remove redundant check for scan_index < 0 in the inner loop.
> 
>  drivers/iio/industrialio-core.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index ee442ee..dad6163 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1135,6 +1135,26 @@ static const struct file_operations iio_buffer_fileops = {
>  	.compat_ioctl = iio_ioctl,
>  };
>  
> +static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
> +{
> +	int i, j;
> +	const struct iio_chan_spec *channels = indio_dev->channels;
> +
> +	for (i = 0; i < indio_dev->num_channels - 1; i++) {
> +		if (channels[i].scan_index < 0)
> +			continue;
> +		for (j = i + 1; j < indio_dev->num_channels; j++)
> +			if (channels[i].scan_index == channels[j].scan_index) {
> +				dev_err(&indio_dev->dev,
> +					"Duplicate scan index %d\n",
> +					channels[i].scan_index);
> +				return -EINVAL;
> +			}
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>  
>  /**
> @@ -1149,6 +1169,10 @@ int iio_device_register(struct iio_dev *indio_dev)
>  	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
>  		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
>  
> +	ret = iio_check_unique_scan_index(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* configure elements for the chrdev */
>  	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
>  
> -- 
> 1.9.1
> 
