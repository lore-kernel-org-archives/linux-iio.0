Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43948 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdCYSAP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 14:00:15 -0400
Subject: Re: [PATCH] iio: hid-sensor-attributes: Fix sensor property setting
 failure.
To: Song Hongyan <hongyan.song@intel.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <1490352828-40203-1-git-send-email-hongyan.song@intel.com>
Cc: jikos@kernel.org, srinivas.pandruvada@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <48b89e39-011c-34b8-5241-401c8137766d@kernel.org>
Date: Sat, 25 Mar 2017 18:00:01 +0000
MIME-Version: 1.0
In-Reply-To: <1490352828-40203-1-git-send-email-hongyan.song@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/17 10:53, Song Hongyan wrote:
> When system bootup without get sensor property, set sensor
> property will be fail.
> 
> If no get_feature operation done before set_feature, the sensor
> properties will all be the initialized value, which is not the
> same with sensor real properties. When set sensor property it will
> write back to sensor the changed perperty data combines with other
> sensor properties data, it is not right and may be dangerous.
> 
> In order to get all sensor properties, choose to read one of the sensor
> property(no matter read any sensor peroperty, driver will get all
> the peroperties and return the requested one).
property, properties throughout description.
> 
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes?

Definitely sounds like one for stable and that tag helps people quickly
find where it is relevant.
> ---
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 7afdac42..01e02b9 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -379,6 +379,8 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  {
>  
>  	struct hid_sensor_hub_attribute_info timestamp;
> +	s32 value;
> +	int ret;
>  
>  	hid_sensor_get_reporting_interval(hsdev, usage_id, st);
>  
> @@ -417,6 +419,14 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  		st->sensitivity.index, st->sensitivity.report_id,
>  		timestamp.index, timestamp.report_id);
>  
> +	ret = sensor_hub_get_feature(hsdev,
> +				st->power_state.report_id,
> +				st->power_state.index, sizeof(value), &value);
> +	if (ret < 0)
> +		return ret;
> +	if (value < 0)
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(hid_sensor_parse_common_attributes);
> 

