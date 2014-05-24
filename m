Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32962 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbaEXKoX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 May 2014 06:44:23 -0400
Message-ID: <5380786F.9090402@kernel.org>
Date: Sat, 24 May 2014 11:46:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Archana Patni <archana.patni@linux.intel.com>
CC: jkosina@suse.cz, linux-iio@vger.kernel.org,
	srinivas.pandruvada@intel.com,
	Archana Patni <archana.patni@intel.com>,
	Subramony Sesha <subramony.sesha@intel.com>
Subject: Re: [PATCH] iio: hid-sensors: Get feature report from sensor hub
 after changing power state
References: <1400498363-18456-1-git-send-email-archana.patni@linux.intel.com>
In-Reply-To: <1400498363-18456-1-git-send-email-archana.patni@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/14 12:19, Archana Patni wrote:
> Some sensor hubs require a get feature report call to be issued soon after
> changing the power state of the sensor. Without this, the sensor remains in
> the current state. This patch adds a call soon after the power state.
>
> This is retained as a generic call across all sensor hubs since the behavior
> has been noticed on more than one implementation.
>
> Signed-off-by: Archana Patni <archana.patni@intel.com>
> Signed-off-by: Subramony Sesha <subramony.sesha@intel.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
As this isn't a regression (never worked) I've applied it to the
togreg branch of iio.git.

Thanks,

Jonathan
> ---
>   .../iio/common/hid-sensors/hid-sensor-trigger.c    |    3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index dbefbda..f26f52d 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -73,6 +73,9 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>   					(s32)report_val);
>   	}
>
> +	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
> +					st->power_state.index,
> +					&state_val);
>   	return 0;
>   }
>
>

