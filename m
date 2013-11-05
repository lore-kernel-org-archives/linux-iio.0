Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55081 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755494Ab3KEWFu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2013 17:05:50 -0500
Message-ID: <52797A03.2020309@kernel.org>
Date: Tue, 05 Nov 2013 23:06:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iio: hid-sensors: magnetometer : Add sensitivity
References: <1383173333-18618-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1383173333-18618-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1383173333-18618-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/30/13 22:48, Srinivas Pandruvada wrote:
> A number of Properties that can be applied to Data Fields are per data
> field basis or for all data fields. Adding sensitivity field for all
> magnetometer fields, which is most commonly used in currently available
> sensor hubs.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
This is dependent on defines that don't exist. I'm guessing they are later
in the series, so please fix this up.

Jonathan
> ---
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index ff7b9da..db9f27b 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -262,6 +262,18 @@ static int magn_3d_parse_report(struct platform_device *pdev,
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
> 
