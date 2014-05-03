Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54115 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbaECTj2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 15:39:28 -0400
Message-ID: <5365464E.5090001@kernel.org>
Date: Sat, 03 May 2014 20:41:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 14/16] iio: hid-sensors: Compass 3D: Raw read support
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1397863356-2470-14-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-14-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/14 00:22, Srinivas Pandruvada wrote:
> Added support for raw reading of channel. If the sensor is powered
> off, it will turn on for reading value
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/magnetometer/hid-sensor-magn-3d.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index 54eea6a..41cf29e 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -22,6 +22,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
>   #include <linux/slab.h>
> +#include <linux/delay.h>
>   #include <linux/hid-sensor-hub.h>
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
> @@ -60,6 +61,7 @@ static const struct iio_chan_spec magn_3d_channels[] = {
>   		.type = IIO_MAGN,
>   		.modified = 1,
>   		.channel2 = IIO_MOD_X,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>   		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>   		BIT(IIO_CHAN_INFO_SCALE) |
>   		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> @@ -69,6 +71,7 @@ static const struct iio_chan_spec magn_3d_channels[] = {
>   		.type = IIO_MAGN,
>   		.modified = 1,
>   		.channel2 = IIO_MOD_Y,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>   		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>   		BIT(IIO_CHAN_INFO_SCALE) |
>   		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> @@ -78,6 +81,7 @@ static const struct iio_chan_spec magn_3d_channels[] = {
>   		.type = IIO_MAGN,
>   		.modified = 1,
>   		.channel2 = IIO_MOD_Z,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>   		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>   		BIT(IIO_CHAN_INFO_SCALE) |
>   		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> @@ -108,11 +112,20 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
>   	u32 address;
>   	int ret;
>   	int ret_type;
> +	s32 poll_value;
>
>   	*val = 0;
>   	*val2 = 0;
>   	switch (mask) {
>   	case 0:
> +		poll_value = hid_sensor_read_poll_value(
> +					&magn_state->common_attributes);
> +		if (poll_value < 0)
> +				return -EINVAL;
> +
> +		hid_sensor_power_state(&magn_state->common_attributes, true);
> +		msleep_interruptible(poll_value * 2);
> +
>   		report_id =
>   			magn_state->magn[chan->scan_index].report_id;
>   		address = magn_3d_addresses[chan->scan_index];
> @@ -123,8 +136,11 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
>   				report_id);
>   		else {
>   			*val = 0;
> +			hid_sensor_power_state(&magn_state->common_attributes,
> +						false);
>   			return -EINVAL;
>   		}
> +		hid_sensor_power_state(&magn_state->common_attributes, false);
>   		ret_type = IIO_VAL_INT;
>   		break;
>   	case IIO_CHAN_INFO_SCALE:
>

