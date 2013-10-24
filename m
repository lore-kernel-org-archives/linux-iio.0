Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60752 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab3JXJlq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 05:41:46 -0400
Message-ID: <5268F995.3010004@kernel.org>
Date: Thu, 24 Oct 2013 11:42:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/9] iio: hid_Sensors: fix crash during trigger unregister
References: <1382555476-15826-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1382555476-15826-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/23/13 20:11, Srinivas Pandruvada wrote:
> We can't store the trigger instance created by iio_trigger_alloc, in
> trig field of iio_device structure. This needs to be stored in the
> driver private data. Othewise it can result in crash during module
> unload. Hence created a trig_ptr in the common data structure
> for each HID sensor IIO driver and storing here.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Other than the use of a void * this is fine. Please fix that little issue
up...
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -184,6 +184,7 @@ struct hid_sensor_common {
>  	struct platform_device *pdev;
>  	unsigned usage_id;
>  	bool data_ready;
> +	void *trig_ptr;
Why a void *?  It's struct iio_trigger *
Just put
struct iio_trigger;
above if you want to (reasonably) avoid including the
header.  Don't use a void pointer unless you really have no way
of knowing what the type is.

>  	struct hid_sensor_hub_attribute_info poll;
>  	struct hid_sensor_hub_attribute_info report_state;
>  	struct hid_sensor_hub_attribute_info power_state;
>
