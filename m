Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58693 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbEQIKw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 04:10:52 -0400
Message-ID: <55584D0B.8010900@kernel.org>
Date: Sun, 17 May 2015 09:10:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Fabio Estevam <festevam@gmail.com>
CC: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH v3 2/6] iio: gyro: hid-sensor-gyro-3d: Fix memory leak
 in probe()
References: <1431540374-3168-1-git-send-email-festevam@gmail.com>	 <1431540374-3168-2-git-send-email-festevam@gmail.com> <1431543143.11262.78.camel@spandruv-DESK3.jf.intel.com>
In-Reply-To: <1431543143.11262.78.camel@spandruv-DESK3.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/05/15 19:52, Srinivas Pandruvada wrote:
> On Wed, 2015-05-13 at 15:06 -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> 'channels' is allocated via kmemdup and it is never freed in the
>> subsequent error paths.
>>
>> Use 'indio_dev->channels' directly instead, so that we avoid such
>> memory leak problem.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied.
>> ---
>> Build-tested only.
>>
>> Changes since v2:
>> - None
>> Changes since v1:
>> - Make clear in the commit log that the proble only occurs in the error
>> paths
>>
>>  drivers/iio/gyro/hid-sensor-gyro-3d.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
>> index b5883b6..7b60b58 100644
>> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
>> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
>> @@ -298,7 +298,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>>  	struct iio_dev *indio_dev;
>>  	struct gyro_3d_state *gyro_state;
>>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>> -	struct iio_chan_spec *channels;
>>  
>>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*gyro_state));
>>  	if (!indio_dev)
>> @@ -317,21 +316,21 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> -	channels = kmemdup(gyro_3d_channels, sizeof(gyro_3d_channels),
>> -			   GFP_KERNEL);
>> -	if (!channels) {
>> +	indio_dev->channels = kmemdup(gyro_3d_channels,
>> +				      sizeof(gyro_3d_channels), GFP_KERNEL);
>> +	if (!indio_dev->channels) {
>>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>>  		return -ENOMEM;
>>  	}
>>  
>> -	ret = gyro_3d_parse_report(pdev, hsdev, channels,
>> -					HID_USAGE_SENSOR_GYRO_3D, gyro_state);
>> +	ret = gyro_3d_parse_report(pdev, hsdev,
>> +				   (struct iio_chan_spec *)indio_dev->channels,
>> +				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>>  		goto error_free_dev_mem;
>>  	}
>>  
>> -	indio_dev->channels = channels;
>>  	indio_dev->num_channels = ARRAY_SIZE(gyro_3d_channels);
>>  	indio_dev->dev.parent = &pdev->dev;
>>  	indio_dev->info = &gyro_3d_info;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

