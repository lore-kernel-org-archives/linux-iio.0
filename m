Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60124 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbAJWmd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jan 2015 17:42:33 -0500
Message-ID: <54B1AAD6.6070303@kernel.org>
Date: Sat, 10 Jan 2015 22:42:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	jkosina@suse.cz, a.zummo@towertech.it
CC: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	holler@ahsoftware.de, rtc-linux@googlegroups.com
Subject: Re: [PATCH 2/9] iio: hid-sensor-accel-3d: Adjust parameter for attribute
 read
References: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1420656483-7093-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1420656483-7093-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/01/15 18:47, Srinivas Pandruvada wrote:
> The new API added a flag for sync/async mode. Added sync mode flag.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Again, please don't break the build between patches like this.

If you want to do things in steps, you'll have to carry to versions of
the function during the conversion and drop the unwanted one at the end.

> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index d5d9531..0085c2f 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -130,7 +130,8 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
>  			*val = sensor_hub_input_attr_get_raw_value(
>  					accel_state->common_attributes.hsdev,
>  					HID_USAGE_SENSOR_ACCEL_3D, address,
> -					report_id);
> +					report_id,
> +					SENSOR_HUB_SYNC);
>  		else {
>  			*val = 0;
>  			hid_sensor_power_state(&accel_state->common_attributes,
> 

