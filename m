Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35315 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933360AbcKLOn6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 09:43:58 -0500
Subject: Re: [PATCH v2] hid: hid-sensor-hub: clear memory to avoid random data
To: Song Hongyan <hongyan.song@intel.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <1478825923-12153-1-git-send-email-hongyan.song@intel.com>
Cc: jikos@kernel.org, srinivas.pandruvada@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e64c6b31-739c-a6ab-cd1e-6637809feae4@kernel.org>
Date: Sat, 12 Nov 2016 14:43:55 +0000
MIME-Version: 1.0
In-Reply-To: <1478825923-12153-1-git-send-email-hongyan.song@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/11/16 00:58, Song Hongyan wrote:
> Initialize user buffer with 0s. This will avoid random data in the buffer,
> when the user buffer size is bigger than the actual report size.
> 
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Please describe the result of this bug in the description.
Why does it matter?

Without that info, it's hard to judge what path this should take
into mainline or whether the fix needs to be marked for stable.

Thanks,

Jonathan
> ---
> Changes in v2:
>     -clear memory in get_feature() instead of set_feature()
> 
>  drivers/hid/hid-sensor-hub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 658a607..b74d954 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -252,6 +252,7 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
>  	int report_size;
>  	int ret = 0;
>  
> +	memset(buffer, 0, buffer_size);
>  	mutex_lock(&data->mutex);
>  	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
>  	if (!report || (field_index >= report->maxfield) ||
> 

