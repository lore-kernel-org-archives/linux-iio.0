Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53212 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbcL3Uci (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 15:32:38 -0500
Subject: Re: [PATCH 3/4] iio: hid-sensor-attributes: Add input sample
 frequency check
To: Song Hongyan <hongyan.song@intel.com>, linux-iio@vger.kernel.org
References: <1483089792-11324-1-git-send-email-hongyan.song@intel.com>
 <1483089792-11324-3-git-send-email-hongyan.song@intel.com>
Cc: jikos@kernel.org, srinivas.pandruvada@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9024299e-7692-ef64-3368-051de3fc8870@kernel.org>
Date: Fri, 30 Dec 2016 20:32:36 +0000
MIME-Version: 1.0
In-Reply-To: <1483089792-11324-3-git-send-email-hongyan.song@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/16 09:23, Song Hongyan wrote:
> Check the validity of the sampling frequency set by user.
> 
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Looks like a sensible addition. Will pick up when the rest of the series
is ready to go.

Jonathan
> ---
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index ad30814..408c16e 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -221,12 +221,26 @@ int hid_sensor_read_max_samp_freq_value(struct hid_sensor_common *st,
>  int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
>  				int val1, int val2)
>  {
> +	int max_freq_int, max_freq_dec;
>  	s32 value;
>  	int ret;
>  
>  	if (val1 < 0 || val2 < 0)
>  		ret = -EINVAL;
>  
> +	ret = hid_sensor_read_max_samp_freq_value(st, &max_freq_int,
> +						&max_freq_dec);
> +	if (ret >= 0) {
> +		/*
> +		 * check whether the input sample freqency value is larger than
> +		 * the max_freq_value.
> +		 */
> +		if (val1 > max_freq_int || (val1 == max_freq_int &&
> +				val2 > max_freq_dec))
> +			return -EINVAL;
> +	} else {
> +		hid_info(st->hsdev->hdev, "No max_sample_frequency!!!\n");
> +	}
>  	value = val1 * pow_10(6) + val2;
>  	if (value) {
>  		if (st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
> 

