Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48612 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab3K3Lb4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:31:56 -0500
Message-ID: <5299CCAA.6090100@kernel.org>
Date: Sat, 30 Nov 2013 11:31:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	jkosina@suse.cz
CC: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: hid-sensor-hub: Add logical min and max
References: <1385590783-27604-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1385590783-27604-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/27/13 22:19, Srinivas Pandruvada wrote:
> Exporting logical minimum and maximum of HID fields as part of the
> hid sensor attribute info. This can be used for range checking and
> to calculate enumeration base for NAry fields of HID sensor hub.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Hi,  I would have preffred this being done in two patches, the first
refactoring the function call and the second doing the min and max.

Anyhow, I'll take it anyway.

Applied to the togreg branch of iio.git.


> ---
>  drivers/hid/hid-sensor-hub.c   | 20 ++++++++------------
>  include/linux/hid-sensor-hub.h |  2 ++
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index a184e19..d87f7cb 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -112,13 +112,15 @@ static int sensor_hub_get_physical_device_count(
>  
>  static void sensor_hub_fill_attr_info(
>  		struct hid_sensor_hub_attribute_info *info,
> -		s32 index, s32 report_id, s32 units, s32 unit_expo, s32 size)
> +		s32 index, s32 report_id, struct hid_field *field)
>  {
>  	info->index = index;
>  	info->report_id = report_id;
> -	info->units = units;
> -	info->unit_expo = unit_expo;
> -	info->size = size/8;
> +	info->units = field->unit;
> +	info->unit_expo = field->unit_exponent;
> +	info->size = (field->report_size * field->report_count)/8;
> +	info->logical_minimum = field->logical_minimum;
> +	info->logical_maximum = field->logical_maximum;
>  }
>  
>  static struct hid_sensor_hub_callbacks *sensor_hub_get_callback(
> @@ -325,9 +327,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
>  			if (field->physical == usage_id &&
>  				field->logical == attr_usage_id) {
>  				sensor_hub_fill_attr_info(info, i, report->id,
> -					field->unit, field->unit_exponent,
> -					field->report_size *
> -							field->report_count);
> +							  field);
>  				ret = 0;
>  			} else {
>  				for (j = 0; j < field->maxusage; ++j) {
> @@ -336,11 +336,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
>  					field->usage[j].collection_index ==
>  					collection_index) {
>  						sensor_hub_fill_attr_info(info,
> -							i, report->id,
> -							field->unit,
> -							field->unit_exponent,
> -							field->report_size *
> -							field->report_count);
> +							  i, report->id, field);
>  						ret = 0;
>  						break;
>  					}
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index a265af2..fd66e45 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -40,6 +40,8 @@ struct hid_sensor_hub_attribute_info {
>  	s32 units;
>  	s32 unit_expo;
>  	s32 size;
> +	s32 logical_minimum;
> +	s32 logical_maximum;
>  };
>  
>  /**
> 
