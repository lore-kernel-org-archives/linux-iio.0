Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58707 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbbEQILq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 04:11:46 -0400
Message-ID: <55584D41.4050303@kernel.org>
Date: Sun, 17 May 2015 09:11:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Fabio Estevam <festevam@gmail.com>
CC: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH v3 5/6] iio: orientation: hid-sensor-rotation: Fix memory
 leak in probe()
References: <1431540374-3168-1-git-send-email-festevam@gmail.com>	 <1431540374-3168-5-git-send-email-festevam@gmail.com> <1431543783.11262.81.camel@spandruv-DESK3.jf.intel.com>
In-Reply-To: <1431543783.11262.81.camel@spandruv-DESK3.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/05/15 20:03, Srinivas Pandruvada wrote:
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
Applied to the togreg branch of iio.git - initially pushed out as testing.
Thanks.

>> ---
>> Build-tested only.
>>
>> Changes since v2:
>> - None
>> Changes since v1:
>> - Make clear in the commit log that the proble only occurs in the error
>> paths
>>
>>  drivers/iio/orientation/hid-sensor-rotation.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
>> index 4afb6c7..b6ee50f 100644
>> --- a/drivers/iio/orientation/hid-sensor-rotation.c
>> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
>> @@ -222,7 +222,6 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
>>  	struct iio_dev *indio_dev;
>>  	struct dev_rot_state *rot_state;
>>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>> -	struct iio_chan_spec *channels;
>>  
>>  	indio_dev = devm_iio_device_alloc(&pdev->dev,
>>  					  sizeof(struct dev_rot_state));
>> @@ -243,21 +242,23 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> -	channels = devm_kmemdup(&pdev->dev, dev_rot_channels,
>> -					sizeof(dev_rot_channels), GFP_KERNEL);
>> -	if (!channels) {
>> +	indio_dev->channels = devm_kmemdup(&pdev->dev, dev_rot_channels,
>> +					   sizeof(dev_rot_channels),
>> +					   GFP_KERNEL);
>> +	if (!indio_dev->channels) {
>>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>>  		return -ENOMEM;
>>  	}
>>  
>> -	ret = dev_rot_parse_report(pdev, hsdev, channels,
>> -			HID_USAGE_SENSOR_DEVICE_ORIENTATION, rot_state);
>> +	ret = dev_rot_parse_report(pdev, hsdev,
>> +				   (struct iio_chan_spec *)indio_dev->channels,
>> +				   HID_USAGE_SENSOR_DEVICE_ORIENTATION,
>> +				   rot_state);
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>>  		return ret;
>>  	}
>>  
>> -	indio_dev->channels = channels;
>>  	indio_dev->num_channels = ARRAY_SIZE(dev_rot_channels);
>>  	indio_dev->dev.parent = &pdev->dev;
>>  	indio_dev->info = &dev_rot_info;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

