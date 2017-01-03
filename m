Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35868 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758405AbdACPrl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2017 10:47:41 -0500
Received: by mail-wm0-f52.google.com with SMTP id c85so202372345wmi.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Jan 2017 07:47:19 -0800 (PST)
Date: Tue, 3 Jan 2017 15:51:01 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Thierry Escande <thierry.escande@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add activity motion sense definitions
Message-ID: <20170103155101.GL2977@dell>
References: <1480929198-13671-1-git-send-email-thierry.escande@collabora.com>
 <1480929198-13671-2-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1480929198-13671-2-git-send-email-thierry.escande@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 05 Dec 2016, Thierry Escande wrote:

> From: Gwendal Grignou <gwendal@chromium.org>
> 
> This adds motion sense definitions to the commands header related to the
> activity sensors attached behind the ChromeOS Embedded Controller.
> Supported activities are MOTION and DOUBLE_TAP.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> ---
>  include/linux/mfd/cros_ec_commands.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

I only see this patch?  Where are the other 2?

Do they depend on this one?

In the mean time:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 1683003..80e6060 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -1417,6 +1417,18 @@ enum motionsense_command {
>  	 */
>  	MOTIONSENSE_CMD_SENSOR_OFFSET = 11,
>  
> +	/*
> +	 * List available activities for a MOTION sensor.
> +	 * Indicates if they are enabled or disabled.
> +	 */
> +	MOTIONSENSE_CMD_LIST_ACTIVITIES = 12,
> +
> +	/*
> +	 * Activity management
> +	 * Enable/Disable activity recognition.
> +	 */
> +	MOTIONSENSE_CMD_SET_ACTIVITY = 13,
> +
>  	/* Number of motionsense sub-commands. */
>  	MOTIONSENSE_NUM_CMDS
>  };
> @@ -1494,6 +1506,21 @@ struct ec_response_motion_sensor_data {
>  	};
>  } __packed;
>  
> +/* List supported activity recognition */
> +enum motionsensor_activity {
> +	MOTIONSENSE_ACTIVITY_RESERVED = 0,
> +	MOTIONSENSE_ACTIVITY_SIG_MOTION = 1,
> +	MOTIONSENSE_ACTIVITY_DOUBLE_TAP = 2,
> +};
> +
> +struct ec_motion_sense_activity {
> +	uint8_t sensor_num;
> +	uint8_t activity;       /* one of enum motionsensor_activity */
> +	uint8_t enable;         /* 1: enable, 0: disable */
> +	uint8_t reserved;
> +	uint16_t parameters[3]; /* activity dependent parameters */
> +};
> +
>  struct ec_params_motion_sense {
>  	uint8_t cmd;
>  	union {
> @@ -1561,6 +1588,8 @@ struct ec_params_motion_sense {
>  			/* Data to set or EC_MOTION_SENSE_NO_VALUE to read. */
>  			int32_t data;
>  		} sensor_odr, sensor_range;
> +
> +		struct ec_motion_sense_activity set_activity;
>  	};
>  } __packed;
>  
> @@ -1611,6 +1640,12 @@ struct ec_response_motion_sense {
>  			int16_t temp;
>  			int16_t offset[3];
>  		} sensor_offset, perform_calib;
> +
> +		struct {
> +			uint16_t reserved;
> +			uint32_t enabled;
> +			uint32_t disabled;
> +		} __packed list_activities;
>  	};
>  } __packed;
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
