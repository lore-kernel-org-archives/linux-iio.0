Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46695 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbdBYQyo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 11:54:44 -0500
Subject: Re: [PATCH v2] hid: hid-sensor-prox: Add more data field for
 hysteresis parsing
To: Song Hongyan <hongyan.song@intel.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <1487755413-31421-1-git-send-email-hongyan.song@intel.com>
Cc: jikos@kernel.org, srinivas.pandruvada@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <433426f5-28c2-80eb-74d2-5c980774a1ca@kernel.org>
Date: Sat, 25 Feb 2017 16:44:33 +0000
MIME-Version: 1.0
In-Reply-To: <1487755413-31421-1-git-send-email-hongyan.song@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/02/17 09:23, Song Hongyan wrote:
> Add HID_USAGE_SENSOR_HUMAN_PRESENCE support for Human Presence sensitivity
> parsing, in case some implementation uses it as sensitivity modifier.
> 
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git which will be initially pushed out as
testing for the autobuilders to play with it.
> ---
> change: adding Srinivas ack
No actual need to post a new version to add an Ack. I'll generally pick them
up directly from the thread whilst applying.

Thanks,

Jonathan
> 
>  drivers/iio/light/hid-sensor-prox.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 45ca056..73fced8 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -240,6 +240,13 @@ static int prox_parse_report(struct platform_device *pdev,
>  			st->common_attributes.sensitivity.index,
>  			st->common_attributes.sensitivity.report_id);
>  	}
> +	if (st->common_attributes.sensitivity.index < 0)
> +		sensor_hub_input_get_attribute_info(hsdev,
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> +			HID_USAGE_SENSOR_HUMAN_PRESENCE,
> +			&st->common_attributes.sensitivity);
> +
>  	return ret;
>  }
>  
> 

