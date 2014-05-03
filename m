Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54108 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaECTie (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 15:38:34 -0400
Message-ID: <53654618.3090109@kernel.org>
Date: Sat, 03 May 2014 20:40:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 13/16] iio: hid-sensors: Proximity: Raw read support
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1397863356-2470-13-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-13-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/14 00:22, Srinivas Pandruvada wrote:
> Added support for raw reading of channel. If the sensor is powered
> off, it will turn on for reading value.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied.
> ---
>   drivers/iio/light/hid-sensor-prox.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 07e98ec8..d203ef4 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -21,6 +21,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
>   #include <linux/slab.h>
> +#include <linux/delay.h>
>   #include <linux/hid-sensor-hub.h>
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
> @@ -75,6 +76,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>   	u32 address;
>   	int ret;
>   	int ret_type;
> +	s32 poll_value;
>
>   	*val = 0;
>   	*val2 = 0;
> @@ -90,12 +92,24 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>   			report_id = -1;
>   			break;
>   		}
> -		if (report_id >= 0)
> +		if (report_id >= 0) {
> +			poll_value = hid_sensor_read_poll_value(
> +					&prox_state->common_attributes);
> +			if (poll_value < 0)
> +				return -EINVAL;
> +
> +			hid_sensor_power_state(&prox_state->common_attributes,
> +						true);
> +
> +			msleep_interruptible(poll_value * 2);
> +
>   			*val = sensor_hub_input_attr_get_raw_value(
>   				prox_state->common_attributes.hsdev,
>   				HID_USAGE_SENSOR_PROX, address,
>   				report_id);
> -		else {
> +			hid_sensor_power_state(&prox_state->common_attributes,
> +						false);
> +		} else {
>   			*val = 0;
>   			return -EINVAL;
>   		}
>

