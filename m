Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60760 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbdETSBk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2017 14:01:40 -0400
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: substitute ifdef CONFIG_PM with
 __maybe_unused macro
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>
References: <20170519201136.11658-1-lorenzo.bianconi@st.com>
 <004306ae-015e-0903-f548-82a1d2ed1876@kernel.org>
 <CAA2SeNLiwcG=ZBj36h27n9ApCsThUf+oHOw5fVH_CCuLpusvWw@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b0f5708c-f46d-a4cc-c84a-8be35cdfca05@kernel.org>
Date: Sat, 20 May 2017 19:01:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAA2SeNLiwcG=ZBj36h27n9ApCsThUf+oHOw5fVH_CCuLpusvWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/05/17 17:45, Lorenzo Bianconi wrote:
>> On 19/05/17 21:11, Lorenzo Bianconi wrote:
>>>
>>> Get rid of #ifdef CONFIG_PM by adding __maybe_unused macro to
>>> st_lsm6dsx_suspend and st_lsm6dsx_resume function declarations
>>>
>>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>
>> Why?
>>
>> I'm not against the change, but there should be some sort of
>> explanation of why you are making it in the patch description.
>>
>> I'm going to hazard a guess it is because you can have CONFIG_PM
>> without CONFIG_PM_SLEEP which in pm.h results in you still
>> getting a warning as SET_SYSTEM_SLEEP_PM_OPS is stubbed out..
>>
>> A good reason, but should be stated here.
>>
>> Jonathan
>>
>>
>>> ---
>>>    drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 ++----
>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>> b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>> index 1b53848cdfd8..b485540da89e 100644
>>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>> @@ -732,8 +732,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int
>>> hw_id, const char *name,
>>>    }
>>>    EXPORT_SYMBOL(st_lsm6dsx_probe);
>>>    -#ifdef CONFIG_PM
>>> -static int st_lsm6dsx_suspend(struct device *dev)
>>> +static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
>>>    {
>>>          struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
>>>          struct st_lsm6dsx_sensor *sensor;
>>> @@ -757,7 +756,7 @@ static int st_lsm6dsx_suspend(struct device *dev)
>>>          return err;
>>>    }
>>>    -static int st_lsm6dsx_resume(struct device *dev)
>>> +static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
>>>    {
>>>          struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
>>>          struct st_lsm6dsx_sensor *sensor;
>>> @@ -778,7 +777,6 @@ static int st_lsm6dsx_resume(struct device *dev)
>>>          return err;
>>>    }
>>> -#endif /* CONFIG_PM */
>>>      const struct dev_pm_ops st_lsm6dsx_pm_ops = {
>>>          SET_SYSTEM_SLEEP_PM_OPS(st_lsm6dsx_suspend, st_lsm6dsx_resume)
>>>
>>
> 
> Hi Jonathan,
> 
> Just to align st_lsm6dsx driver to what we have done in hts221. We
> agreed __maybe_unused macro is becoming more common and is the
> preferred choice now.
> 
True enough, but the reason it is becoming the preferred choice is
primarily because of the complexity around the config PM* options!

Meh. I'll take it as is as the reason isn't that important in
a warning squash patch.  I added a brief comment on why this
change is generally desirable.  It may well be the sort of thing
that gets picked up by say outreachy or other relative newbies in
future so helps to have some hint as to why we are bothering.

Jonathan
> Regards,
> Lorenzo
> 

