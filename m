Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52430 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbcEVTyy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 15:54:54 -0400
Subject: Re: [PATCH 1/3] iio: proximity: as3935: correct IIO_CHAN_INFO_RAW
 output
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1463886063-20004-1-git-send-email-mranostay@gmail.com>
 <1463886063-20004-2-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0819a087-c7e5-9133-6c46-db6ec9f3d0c8@kernel.org>
Date: Sun, 22 May 2016 20:54:51 +0100
MIME-Version: 1.0
In-Reply-To: <1463886063-20004-2-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/05/16 04:01, Matt Ranostay wrote:
> IIO_CHAN_INFO_RAW was returning processed data which was incorrect.
> This also adds the IIO_CHAN_INFO_SCALE value to convert to a processed value.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to the fixes-togreg-post-rc1 branch of iio.git and marked for stable.

Thanks,
Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935 |  2 +-
>  drivers/iio/proximity/as3935.c                           | 10 ++++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935 b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
> index 6708c5e..33e96f7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
> @@ -1,4 +1,4 @@
> -What		/sys/bus/iio/devices/iio:deviceX/in_proximity_raw
> +What		/sys/bus/iio/devices/iio:deviceX/in_proximity_input
>  Date:		March 2014
>  KernelVersion:	3.15
>  Contact:	Matt Ranostay <mranostay@gmail.com>
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index f4d29d5..f0a0def 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -72,7 +72,8 @@ static const struct iio_chan_spec as3935_channels[] = {
>  		.type           = IIO_PROXIMITY,
>  		.info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_PROCESSED),
> +			BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_SCALE),
>  		.scan_index     = 0,
>  		.scan_type = {
>  			.sign           = 'u',
> @@ -181,7 +182,12 @@ static int as3935_read_raw(struct iio_dev *indio_dev,
>  		/* storm out of range */
>  		if (*val == AS3935_DATA_MASK)
>  			return -EINVAL;
> -		*val *= 1000;
> +
> +		if (m == IIO_CHAN_INFO_PROCESSED)
> +			*val *= 1000;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1000;
>  		break;
>  	default:
>  		return -EINVAL;
> 

