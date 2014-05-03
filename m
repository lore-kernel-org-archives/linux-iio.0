Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54054 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaECTdP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 15:33:15 -0400
Message-ID: <536544D8.8010408@kernel.org>
Date: Sat, 03 May 2014 20:34:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 02/16] iio: hid-sensors: Add api to get poll value
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1397863356-2470-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/14 00:22, Srinivas Pandruvada wrote:
> Added interface to get poll value in milli-seconds. This value is
> changed by changing sampling frequency. This API allows clients
> to wait for atleast some poll milli seconds before reading a new sample.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
applied to the togreg branch of iio.git

> ---
>   .../iio/common/hid-sensors/hid-sensor-attributes.c   | 20 ++++++++++++++++++++
>   include/linux/hid-sensor-hub.h                       |  2 ++
>   2 files changed, 22 insertions(+)
>
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 451a95b..4a533b8 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -147,6 +147,26 @@ static u32 convert_to_vtf_format(int size, int exp, int val1, int val2)
>   	return value;
>   }
>
> +s32 hid_sensor_read_poll_value(struct hid_sensor_common *st)
> +{
> +	s32 value = 0;
> +	int ret;
> +
> +	ret = sensor_hub_get_feature(st->hsdev,
> +		st->poll.report_id,
> +		st->poll.index, &value);
> +
> +	if (ret < 0 || value < 0) {
> +		return -EINVAL;
> +	} else {
> +		if (st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
> +			value = value * 1000;
> +	}
> +
> +	return value;
> +}
> +EXPORT_SYMBOL(hid_sensor_read_poll_value);
> +
>   int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
>   				int *val1, int *val2)
>   {
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index 89626b2..88d8d63 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -227,4 +227,6 @@ int hid_sensor_format_scale(u32 usage_id,
>   			    struct hid_sensor_hub_attribute_info *attr_info,
>   			    int *val0, int *val1);
>
> +s32 hid_sensor_read_poll_value(struct hid_sensor_common *st);
> +
>   #endif
>

