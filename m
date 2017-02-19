Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37286 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdBSLuX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 06:50:23 -0500
Subject: Re: [PATCH] hid: hid-sensor-prox: Add more data field for hysteresis
 parsing
To: Song Hongyan <hongyan.song@intel.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <1486979692-44878-1-git-send-email-hongyan.song@intel.com>
Cc: jikos@kernel.org, srinivas.pandruvada@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a27a7238-c825-b2d9-733e-0c7a7919a3d6@kernel.org>
Date: Sun, 19 Feb 2017 11:50:21 +0000
MIME-Version: 1.0
In-Reply-To: <1486979692-44878-1-git-send-email-hongyan.song@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/02/17 09:54, Song Hongyan wrote:
> Add HID_USAGE_SENSOR_HUMAN_PRESENCE support for Human Presence sensitivity
> parsing, in case some implementation uses it as sensitivity modifier.
> 
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Do we want to perhaps indicate to userspace in some way that this is what is being
reported? (not that I have any idea how a proximity sensor could potentially tell
a human from a passing cat for example ;)

Otherwise, I'm fine with this but would like an Ack from Srinivas.
> ---
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

