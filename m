Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58713 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbbEQIL5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 04:11:57 -0400
Message-ID: <55584D4C.7070804@kernel.org>
Date: Sun, 17 May 2015 09:11:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Fabio Estevam <festevam@gmail.com>
CC: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH v3 6/6] iio: pressure: hid-sensor-press: Fix memory leak
 in probe()
References: <1431540374-3168-1-git-send-email-festevam@gmail.com>	 <1431540374-3168-6-git-send-email-festevam@gmail.com> <1431543796.11262.82.camel@spandruv-DESK3.jf.intel.com>
In-Reply-To: <1431543796.11262.82.camel@spandruv-DESK3.jf.intel.com>
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
>> - Properly align "press_parse_report(" in multiple lines
>> Changes since v1:
>> - Make clear in the commit log that the proble only occurs in the error
>> paths
>>  drivers/iio/pressure/hid-sensor-press.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
>> index 7bb8d4c..5a10dbc 100644
>> --- a/drivers/iio/pressure/hid-sensor-press.c
>> +++ b/drivers/iio/pressure/hid-sensor-press.c
>> @@ -262,7 +262,6 @@ static int hid_press_probe(struct platform_device *pdev)
>>  	struct iio_dev *indio_dev;
>>  	struct press_state *press_state;
>>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>> -	struct iio_chan_spec *channels;
>>  
>>  	indio_dev = devm_iio_device_alloc(&pdev->dev,
>>  				sizeof(struct press_state));
>> @@ -282,20 +281,21 @@ static int hid_press_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> -	channels = kmemdup(press_channels, sizeof(press_channels), GFP_KERNEL);
>> -	if (!channels) {
>> +	indio_dev->channels = kmemdup(press_channels, sizeof(press_channels),
>> +				      GFP_KERNEL);
>> +	if (!indio_dev->channels) {
>>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>>  		return -ENOMEM;
>>  	}
>>  
>> -	ret = press_parse_report(pdev, hsdev, channels,
>> -				HID_USAGE_SENSOR_PRESSURE, press_state);
>> +	ret = press_parse_report(pdev, hsdev,
>> +				 (struct iio_chan_spec *)indio_dev->channels,
>> +				 HID_USAGE_SENSOR_PRESSURE, press_state);
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>>  		goto error_free_dev_mem;
>>  	}
>>  
>> -	indio_dev->channels = channels;
>>  	indio_dev->num_channels =
>>  				ARRAY_SIZE(press_channels);
>>  	indio_dev->dev.parent = &pdev->dev;
> 
> 

