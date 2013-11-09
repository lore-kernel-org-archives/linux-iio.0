Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51533 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab3KIKzI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Nov 2013 05:55:08 -0500
Message-ID: <527E22D2.3020605@kernel.org>
Date: Sat, 09 Nov 2013 11:56:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: hid-sensors: magnetometer : Add sensitivity
References: <a> <1383696698-24974-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1383696698-24974-4-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1383696698-24974-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06/13 00:11, Srinivas Pandruvada wrote:
> A number of Properties that can be applied to Data Fields are per data
> field basis or for all data fields. Adding sensitivity field for all
> magnetometer fields, which is most commonly used in currently available
> sensor hubs.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git

Note the first 3 in this series have already been applied.
> ---
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 12 ++++++++++++
>  include/linux/hid-sensor-ids.h                |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index b26e102..6d162b7 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -263,6 +263,18 @@ static int magn_3d_parse_report(struct platform_device *pdev,
>  			st->magn[1].index, st->magn[1].report_id,
>  			st->magn[2].index, st->magn[2].report_id);
>  
> +	/* Set Sensitivity field ids, when there is no individual modifier */
> +	if (st->common_attributes.sensitivity.index < 0) {
> +		sensor_hub_input_get_attribute_info(hsdev,
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> +			HID_USAGE_SENSOR_DATA_ORIENTATION,
> +			&st->common_attributes.sensitivity);
> +		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
> +			st->common_attributes.sensitivity.index,
> +			st->common_attributes.sensitivity.report_id);
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 880e3fa..e6e5fb9 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -42,6 +42,7 @@
>  
>  /* ORIENTATION: Compass 3D: (200083) */
>  #define HID_USAGE_SENSOR_COMPASS_3D				0x200083
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION			0x200470
>  #define HID_USAGE_SENSOR_ORIENT_MAGN_HEADING			0x200471
>  #define HID_USAGE_SENSOR_ORIENT_MAGN_HEADING_X			0x200472
>  #define HID_USAGE_SENSOR_ORIENT_MAGN_HEADING_Y			0x200473
> 
