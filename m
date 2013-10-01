Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51384 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab3JAHmE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 03:42:04 -0400
Message-ID: <524A8AF7.8030304@kernel.org>
Date: Tue, 01 Oct 2013 09:42:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org
CC: jkosina@suse.cz, holler@ahsoftware.de
Subject: Re: [PATCH 2/3] IIO: call sensor hub open close function
References: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1379524399-16995-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1379524399-16995-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 18:13, Srinivas Pandruvada wrote:
> Call hid_sensor_hub_device_open when user space opens device and call
> hid_sensor_hub_device_close when device is closed. This helps in
> saving power.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 87419c4..b6e77e0 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -34,6 +34,12 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  	struct hid_sensor_common *st = iio_trigger_get_drvdata(trig);
>  	int state_val;
>  
> +	if (state) {
> +		if (sensor_hub_device_open(st->hsdev))
> +			return -EIO;
> +	} else
> +		sensor_hub_device_close(st->hsdev);
> +
>  	state_val = state ? 1 : 0;
>  	if (IS_ENABLED(CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS))
>  		++state_val;
> 
