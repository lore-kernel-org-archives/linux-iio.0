Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58759 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbbEQIWh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 04:22:37 -0400
Message-ID: <55584FCB.7090408@kernel.org>
Date: Sun, 17 May 2015 09:22:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] HID: hid-sensor-hub: Optimize suspend/resume time
References: <1431711643-1326-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1431711643-1326-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/05/15 18:40, Srinivas Pandruvada wrote:
> When system suspend is issued, the pm core issues resume call for all
> run time suspended devices. This is required for some devices to
> continue suspend.
> For sensor hub we don't need to runtime resume devices and then suspend.
> So when the system suspend is in progress, ignore call to power up
> the sensors. This has a significant impact on suspend/resume performance.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Hi Srinivas,

This isn't an area I know much about and am a little unlikely to get time to
dig into in the next few days. A quick grep didn't throw up lots of other
drivers doing this, so is there precedence somewhere?

Jonathan
> ---
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    | 31 ++++++++++++++++++++++
>  include/linux/hid-sensor-hub.h                     |  2 ++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 610fc98..d9170d2 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -23,6 +23,7 @@
>  #include <linux/irq.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/suspend.h>
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
> @@ -36,6 +37,9 @@ static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>  	s32 poll_value = 0;
>  
>  	if (state) {
> +		if (atomic_read(&st->suspend_in_progress))
> +			return 0;
> +
>  		if (sensor_hub_device_open(st->hsdev))
>  			return -EIO;
>  
> @@ -113,6 +117,28 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>  #endif
>  }
>  
> +static int hid_sensor_pm_notifier(struct notifier_block *nb, unsigned long val,
> +				  void *ptr)
> +{
> +	struct hid_sensor_common *common =
> +			container_of(nb, struct hid_sensor_common, pm_nb);
> +
> +	switch (val) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_SUSPEND_PREPARE:
> +		atomic_set(&common->suspend_in_progress, 1);
> +		break;
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_SUSPEND:
> +	case PM_POST_RESTORE:
> +		atomic_set(&common->suspend_in_progress, 0);
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
>  static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  						bool state)
>  {
> @@ -121,6 +147,7 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  
>  void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
>  {
> +	unregister_pm_notifier(&attrb->pm_nb);
>  	iio_trigger_unregister(attrb->trigger);
>  	iio_trigger_free(attrb->trigger);
>  }
> @@ -168,6 +195,10 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>  					 3000);
>  	pm_runtime_use_autosuspend(&attrb->pdev->dev);
>  
> +	atomic_set(&attrb->suspend_in_progress, 0);
> +	attrb->pm_nb.notifier_call = hid_sensor_pm_notifier;
> +	register_pm_notifier(&attrb->pm_nb);
> +
>  	return ret;
>  error_unreg_trigger:
>  	iio_trigger_unregister(trig);
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index 0042bf3..e38c72a 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -230,6 +230,8 @@ struct hid_sensor_common {
>  	struct platform_device *pdev;
>  	unsigned usage_id;
>  	atomic_t data_ready;
> +	atomic_t suspend_in_progress;
> +	struct notifier_block pm_nb;
>  	struct iio_trigger *trigger;
>  	struct hid_sensor_hub_attribute_info poll;
>  	struct hid_sensor_hub_attribute_info report_state;
> 

