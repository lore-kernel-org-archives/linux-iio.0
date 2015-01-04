Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48333 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbADLSJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 06:18:09 -0500
Message-ID: <54A9216F.8070200@kernel.org>
Date: Sun, 04 Jan 2015 11:18:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5] iio: ensure scan index is unique at device register
References: <1419845868-24562-1-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1419845868-24562-1-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/12/14 09:37, Vlad Dogaru wrote:
> Having two or more channels with the same positive scan_index field
> makes no sense if the device supports buffering.  Prevent this situation
> by failing to register such a device.
> 
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git.
Initially pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Changes since v4:
>  - actually include the check mentioned in v4, forgot to 'git add' it the first
>    time around :)
>  - reword description to mention that we only check devices that support
>    buffering.
> Changes since v3:
>  - only check for duplicates if device supports buffering.
> Changes since v2:
>  - rebase to latest togreg branch.
> Changes since v1:
>  - remove redundant check for scan_index < 0 in the inner loop.
>  drivers/iio/industrialio-core.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index ee442ee..cc80c59 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1135,6 +1135,29 @@ static const struct file_operations iio_buffer_fileops = {
>  	.compat_ioctl = iio_ioctl,
>  };
>  
> +static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
> +{
> +	int i, j;
> +	const struct iio_chan_spec *channels = indio_dev->channels;
> +
> +	if (!(indio_dev->modes & INDIO_ALL_BUFFER_MODES))
> +		return 0;
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
> @@ -1149,6 +1172,10 @@ int iio_device_register(struct iio_dev *indio_dev)
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

