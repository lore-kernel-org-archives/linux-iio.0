Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37444 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdDHOhT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 10:37:19 -0400
Subject: Re: [PATCH] iio: hid-sensor: Fix unbalanced pm_runtime_enable error
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20170408001634.4980-1-srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <76a15954-8a82-4db1-a555-8961c1109e93@kernel.org>
Date: Sat, 8 Apr 2017 15:37:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170408001634.4980-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/17 01:16, Srinivas Pandruvada wrote:
> When a hid sensor module is removed and modprobed again we see
> error for unbalanced pm_runtime. This issue is caused by not
> deactivating runtime PM on removal. So on modprobe again when
> activated again, this will print this error.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
Applied to the togreg branch of iio.git which will be pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
>  Not an urgent fix, so targeted for next release only.
> 
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 6082934..0b5dea0 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -152,6 +152,10 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  
>  void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
>  {
> +	pm_runtime_disable(&attrb->pdev->dev);
> +	pm_runtime_set_suspended(&attrb->pdev->dev);
> +	pm_runtime_put_noidle(&attrb->pdev->dev);
> +
>  	cancel_work_sync(&attrb->work);
>  	iio_trigger_unregister(attrb->trigger);
>  	iio_trigger_free(attrb->trigger);
> 

