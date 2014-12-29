Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:38486 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbaL2JoB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 29 Dec 2014 04:44:01 -0500
Date: Mon, 29 Dec 2014 10:37:40 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Vlad Dogaru <vlad.dogaru@intel.com>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: ensure scan index is unique at device register
In-Reply-To: <1419845361-24102-1-git-send-email-vlad.dogaru@intel.com>
Message-ID: <alpine.DEB.2.02.1412291035560.3347@pmeerw.net>
References: <1419845361-24102-1-git-send-email-vlad.dogaru@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Having two or more channels with the same positive scan_index field
> makes no sense.  Prevent this situation by failing to register a device
> if two scan indexes are identical.

I don't see the check whether the device supports buffering; v3 == v4 by 
mistake?

p.

> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> ---
> Changes since v3:
>  - only check for duplicates if device supports buffering.
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
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
