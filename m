Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38282 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab3HCQx7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 12:53:59 -0400
Message-ID: <51FD43BB.5020002@kernel.org>
Date: Sat, 03 Aug 2013 18:54:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
	jic23@cam.ac.uk,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 4/6] iio: light: hid-sensor-als: Use devm_iio_device_alloc
References: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org> <1375173868-13235-4-git-send-email-sachin.kamat@linaro.org> <51FBD985.2000904@linux.intel.com>
In-Reply-To: <51FBD985.2000904@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/13 17:08, Srinivas Pandruvada wrote:
> On 07/30/2013 01:44 AM, Sachin Kamat wrote:
>> Using devm_iio_device_alloc makes code simpler.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Applied to the togreg branch of iio.git.
>> ---
>>   drivers/iio/light/hid-sensor-als.c |   17 +++++------------
>>   1 file changed, 5 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
>> index 9adfef0..84cf004 100644
>> --- a/drivers/iio/light/hid-sensor-als.c
>> +++ b/drivers/iio/light/hid-sensor-als.c
>> @@ -249,11 +249,9 @@ static int hid_als_probe(struct platform_device *pdev)
>>       struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>>       struct iio_chan_spec *channels;
>>   -    indio_dev = iio_device_alloc(sizeof(struct als_state));
>> -    if (indio_dev == NULL) {
>> -        ret = -ENOMEM;
>> -        goto error_ret;
>> -    }
>> +    indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct als_state));
>> +    if (!indio_dev)
>> +        return -ENOMEM;
>>       platform_set_drvdata(pdev, indio_dev);
>>         als_state = iio_priv(indio_dev);
>> @@ -264,14 +262,13 @@ static int hid_als_probe(struct platform_device *pdev)
>>                       &als_state->common_attributes);
>>       if (ret) {
>>           dev_err(&pdev->dev, "failed to setup common attributes\n");
>> -        goto error_free_dev;
>> +        return ret;
>>       }
>>         channels = kmemdup(als_channels, sizeof(als_channels), GFP_KERNEL);
>>       if (!channels) {
>> -        ret = -ENOMEM;
> Don't we have to free indio_dev?
Nope.  Not having to do that is what we gain from the managed interfaces.
Basically anything allocated for a particular devices will be freed (in reverse
order) on that device being freed.  The pdev->dev device will be freed if this
probe fails, taking everything else down with it.

Jonathan
>>           dev_err(&pdev->dev, "failed to duplicate channels\n");
>> -        goto error_free_dev;
>> +        return -ENOMEM;
>>       }
>>         ret = als_parse_report(pdev, hsdev, channels,
> 
> Same here, What if any of the calls fail after this? free indio_dev?
>> @@ -329,9 +326,6 @@ error_unreg_buffer_funcs:
>>       iio_triggered_buffer_cleanup(indio_dev);
>>   error_free_dev_mem:
>>       kfree(indio_dev->channels);
>> -error_free_dev:
>> -    iio_device_free(indio_dev);
>> -error_ret:
>>       return ret;
>>   }
>>   @@ -346,7 +340,6 @@ static int hid_als_remove(struct platform_device *pdev)
>>       hid_sensor_remove_trigger(indio_dev);
>>       iio_triggered_buffer_cleanup(indio_dev);
>>       kfree(indio_dev->channels);
>> -    iio_device_free(indio_dev);
>>         return 0;
>>   }
> 
