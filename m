Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f196.google.com ([209.85.212.196]:34825 "EHLO
	mail-wi0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbbI1BMD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 21:12:03 -0400
MIME-Version: 1.0
In-Reply-To: <5607EFB0.2000406@kernel.org>
References: <20150914160849.GA21748@localhost>
	<55FF068A.30302@kernel.org>
	<55FFBD5F.5020304@samsung.com>
	<664C26F2-9F25-4D1F-9A3A-986471CEAD57@jic23.retrosnub.co.uk>
	<55FFE7A1.3040202@samsung.com>
	<CAK-LDbLXSxE8HjvO-Qbn2-TMT_2q9kaor-9YW8CDsgVfOosm1Q@mail.gmail.com>
	<5607EFB0.2000406@kernel.org>
Date: Mon, 28 Sep 2015 06:42:00 +0530
Message-ID: <CAK-LDbLjiE5r8P4Lzd5rmOWCCUujF7vauO2s32ErA++zksE8dQ@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: ssp_gyro_sensor: Use devm_iio_device_register
From: Vaishali Thakkar <vthakkar1994@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Karol Wrona <k.wrona@samsung.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 27, 2015 at 7:01 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 27/09/15 05:16, Vaishali Thakkar wrote:
>> On Mon, Sep 21, 2015 at 4:48 PM, Karol Wrona <k.wrona@samsung.com> wrote:
>>> On 09/21/2015 11:53 AM, Jonathan Cameron wrote:
>>>>
>>>>
>>>> On 21 September 2015 09:18:39 BST, Karol Wrona <k.wrona@samsung.com> wrote:
>>>>> On 09/20/2015 09:18 PM, Jonathan Cameron wrote:
>>>>>> On 14/09/15 17:08, Vaishali Thakkar wrote:
>>>>>>> Use resourced managed function devm_iio_device_register to
>>>>>>> make error path simpler. To be compatible with the change,
>>>>>>> the remove function is removed as it is now redundant.
>>>>>>>
>>>>>>> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
>>>>>> This patch is reasonable, but makes me wonder if there is an issue
>>>>>> in the remove path for this driver.  It relies on the ssp_sensors
>>>>> common
>>>>>> module.  That in ssp_spi.c uses the fact ssp_register_consumer
>>>>>> has saved the struct iio_dev into a local array in the core driver.
>>>>>> I think this means that a remove of this function will leave a
>>>>> possible
>>>>>> null pointer de reference.
>>>>> You are right. In this case we need something like
>>>>> ssp_deregister_consumer(...) in ssp_dev.c. So I think that "remove
>>>>> func"
>>>>> should stay. Of course we can switch to devm iio register.
>>>> Not if you want to remove the userspace interface before doing you new function call.  Doing so gives a nasty race.
>>> So better leave it out:
>>> iio_device_unregister(indio_dev) will disable the buffers and through
>>> ops disables the sensor and than remove iio dev ptr from the internal table.
>>>
>>
>> Sorry for the late reply. Yes, I guess I missed the point that
>> 'ssp_register_consumer' is
>> used in probe function. And I believe that devm_iio_register is useful
>> only when we
>> can convert all other functions to their devm counterparts and remove
>> function will go
>> away.
> Yes. Exactly.
>>
>> But then why don't we need ssp_deregister_consumer here in the remove function?
>> Is it automatically handled by  iio_device_unregister? I guess Karol
>> tried to explain
>> the same thing but I am still confused. Same case applies for
>> ssp_sensors/ssp_dev.c.
> We do indeed need an ssp_deregister_consumer function to be called in the remove.
> I don't think one currently exists, so that needs fixing.

Ok. Then I'll send patches for both of these files.

>>>>>
>>>>> Also the same can (rather should) be done for accelerometer sensor
>>>>> (ssp_accel_sensor.c).
>>>>>
>>>>> Vaishali, if you want please feel free and send patch.
>>>>>
>>>>>>
>>>>>> Now I suspect that case doesn't actually occur because the relevant
>>>>>> device elements are disabled whenever this module is removed.  Having
>>>>>> said that we might expect an ssp_unregister_consumer function that
>>>>>> sets the relevant pointer back to null on removal so as to avoid
>>>>>> any possible race conditions around driver removal / reprobing.
>>>>>> A spot of defensive programming rather than necessarily a bug to be
>>>>>> fixed!
>>>>>>
>>>>>> One little process thing. This driver was written by Karol so patches
>>>>>> should probably always cc Karol as well as the more general
>>>>>> maintainer / reviewers for IIO.  Added cc.
>>>>>>
>>>>>> Jonathan
>>>>>>> ---
>>>>>>>  drivers/iio/gyro/ssp_gyro_sensor.c | 12 +-----------
>>>>>>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iio/gyro/ssp_gyro_sensor.c
>>>>> b/drivers/iio/gyro/ssp_gyro_sensor.c
>>>>>>> index 0a8afdd..ac88de7 100644
>>>>>>> --- a/drivers/iio/gyro/ssp_gyro_sensor.c
>>>>>>> +++ b/drivers/iio/gyro/ssp_gyro_sensor.c
>>>>>>> @@ -134,7 +134,7 @@ static int ssp_gyro_probe(struct platform_device
>>>>> *pdev)
>>>>>>>
>>>>>>>    platform_set_drvdata(pdev, indio_dev);
>>>>>>>
>>>>>>> -  ret = iio_device_register(indio_dev);
>>>>>>> +  ret = devm_iio_device_register(&pdev->dev, indio_dev);
>>>>>>>    if (ret < 0)
>>>>>>>            return ret;
>>>>>>>
>>>>>>> @@ -144,21 +144,11 @@ static int ssp_gyro_probe(struct
>>>>> platform_device *pdev)
>>>>>>>    return 0;
>>>>>>>  }
>>>>>>>
>>>>>>> -static int ssp_gyro_remove(struct platform_device *pdev)
>>>>>>> -{
>>>>>>> -  struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>>>>>> -
>>>>>>> -  iio_device_unregister(indio_dev);
>>>>>>> -
>>>>>>> -  return 0;
>>>>>>> -}
>>>>>>> -
>>>>>>>  static struct platform_driver ssp_gyro_driver = {
>>>>>>>    .driver = {
>>>>>>>            .name = SSP_GYROSCOPE_NAME,
>>>>>>>    },
>>>>>>>    .probe = ssp_gyro_probe,
>>>>>>> -  .remove = ssp_gyro_remove,
>>>>>>>  };
>>>>>>>
>>>>>>>  module_platform_driver(ssp_gyro_driver);
>>>>>>>
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>>>>> in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>
>>>
>>
>>
>>
>



-- 
Vaishali
