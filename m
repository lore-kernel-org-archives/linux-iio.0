Return-Path: <SRS0=A0tK=SQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C0CC10F13
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 12:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209DF20896
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555245383;
	bh=hoKNX3mwYFGYp7zuYhzjQGSaPTG3IvUFRwJCUc1BOrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pvk0J5NWpMKMeKQekjMazGGI7mhrf4xIJ48XGEOQoHyo5q/draAx19iTTpxqOMjbG
	 AdmzW6NUKtO+bTChy3JPVujvfdrMO0+39rZTKAGPD6ifGyDZyK5NR8BE1SHSLH1NaX
	 J9q+P9JUmVTFulTI42ZlsulMg4jyLJvVpmWIdhtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfDNMgW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Apr 2019 08:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfDNMgV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Apr 2019 08:36:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EA0F20896;
        Sun, 14 Apr 2019 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555245380;
        bh=hoKNX3mwYFGYp7zuYhzjQGSaPTG3IvUFRwJCUc1BOrE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U4a9Hex0g0Hf+gpkmEA7xwIKGxhGrRnE6OE9ftXJLu6ZNK5p7xuYlG4T/khcAlG9l
         B7w05cwmvCUjIHaCx52rDoxuRXugOQvLRX7Hls5RqzliY54hIeaiyH0UNKOuEh3qZv
         gS1yd6ESz7KpvizPYa2Xzl/0IjJMyFjvxJP54hlo=
Date:   Sun, 14 Apr 2019 13:36:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     hongyan.song@intel.com
Cc:     jikos@kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: Re: [PATCH] drivers: iio: Add more data field for iio driver
 hysteresis parsing
Message-ID: <20190414133615.56be4eb1@archlinux>
In-Reply-To: <1554773465-21882-1-git-send-email-hongyan.song@intel.com>
References: <1554773465-21882-1-git-send-email-hongyan.song@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  9 Apr 2019 09:31:04 +0800
hongyan.song@intel.com wrote:

> From: Song Hongyan <hongyan.song@intel.com>
> 
> Add more data field support for als, incli_3d, rotation, press
> hysteresis parsing. In some implementation may uses them as sensitivity
> modifier, without this change hysteresis may not be able to read and
> write.
> 
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Thanks for the patch. I'll be honest I'm lost in these descriptors
sometimes!

Srinivas, could you give some input on this one?

I will note however, that from a quick look we tend to air these
queries with dev_dbg entries.  We should be consistent with these new ones
as well.

Thanks,

Jonathan
> ---
>  drivers/iio/light/hid-sensor-als.c            | 8 ++++++++
>  drivers/iio/orientation/hid-sensor-incl-3d.c  | 8 ++++++++
>  drivers/iio/orientation/hid-sensor-rotation.c | 7 +++++++
>  drivers/iio/pressure/hid-sensor-press.c       | 8 ++++++++
>  include/linux/hid-sensor-ids.h                | 1 +
>  5 files changed, 32 insertions(+)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 94f3325..bb19178 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -271,6 +271,14 @@ static int als_parse_report(struct platform_device *pdev,
>  			st->common_attributes.sensitivity.index,
>  			st->common_attributes.sensitivity.report_id);
>  	}
> +	if (st->common_attributes.sensitivity.index < 0) {
> +		sensor_hub_input_get_attribute_info(hsdev,
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT |
> +			HID_USAGE_SENSOR_LIGHT_ILLUM,
> +			&st->common_attributes.sensitivity);
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
> index bdc5e45..7da1e3f 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> @@ -305,6 +305,14 @@ static int incl_3d_parse_report(struct platform_device *pdev,
>  			st->common_attributes.sensitivity.index,
>  			st->common_attributes.sensitivity.report_id);
>  	}
> +	if (st->common_attributes.sensitivity.index < 0) {
> +		sensor_hub_input_get_attribute_info(hsdev,
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> +			HID_USAGE_SENSOR_ORIENT_TILT,
> +			&st->common_attributes.sensitivity);
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index a69db20..201e320 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -229,6 +229,13 @@ static int dev_rot_parse_report(struct platform_device *pdev,
>  			st->common_attributes.sensitivity.index,
>  			st->common_attributes.sensitivity.report_id);
>  	}
> +	if (st->common_attributes.sensitivity.index < 0) {
> +		sensor_hub_input_get_attribute_info(hsdev,
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> +			HID_USAGE_SENSOR_ORIENT_QUATERNION,
> +			&st->common_attributes.sensitivity);
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index d7b1c00..bf5d2ac 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -250,6 +250,14 @@ static int press_parse_report(struct platform_device *pdev,
>  			st->common_attributes.sensitivity.index,
>  			st->common_attributes.sensitivity.report_id);
>  	}
> +	if (st->common_attributes.sensitivity.index < 0) {
> +		sensor_hub_input_get_attribute_info(hsdev,
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> +			HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE,
> +			&st->common_attributes.sensitivity);
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 76033e0..a875b9be 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -158,6 +158,7 @@
>  /* Per data field properties */
>  #define HID_USAGE_SENSOR_DATA_MOD_NONE					0x00
>  #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		0x1000
> +#define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT            0xE000
>  
>  /* Power state enumerations */
>  #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x200850

