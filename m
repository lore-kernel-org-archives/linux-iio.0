Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:56512 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab1DDN01 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2011 09:26:27 -0400
Message-ID: <4D99C762.5030807@cam.ac.uk>
Date: Mon, 04 Apr 2011 14:28:02 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jan Weitzel <J.Weitzel@phytec.de>
CC: linux-iio@vger.kernel.org, mailinglists@phytec.de
Subject: Re: Antwort: Re: [PATCH] staging:iio:adc Add range to max1363
References: <1301487638-26661-1-git-send-email-mailinglists@phytec.de> <4D932D47.8050603@cam.ac.uk> <OFAE673577.F9806504-ONC1257863.004CB7C3-C1257863.004D6F87@phytec.de>
In-Reply-To: <OFAE673577.F9806504-ONC1257863.004CB7C3-C1257863.004D6F87@phytec.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/30/11 15:05, Jan Weitzel wrote:
> Jonathan Cameron <jic23@cam.ac.uk> schrieb am 30.03.2011 15:16:55:
> 
>> Von: Jonathan Cameron <jic23@cam.ac.uk>
>> An: mailinglists@phytec.de
>> Kopie: linux-iio@vger.kernel.org, Jan Weitzel <j.weitzel@phytec.de>
>> Datum: 30.03.2011 15:15
>> Betreff: Re: [PATCH] staging:iio:adc Add range to max1363
>>
>> On 03/30/11 13:20, mailinglists@phytec.de wrote:
>>> From: Jan Weitzel <j.weitzel@phytec.de>
>>>
>>> by default MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_VDD is set, add VDD is
>>> the voltage reference, not the internal one. So in_scale is wrong.
>>> If a regulator is available it is ask about the voltage. If it is
>>> not available the old (wrong) internal reference is used.
>>>
>> Hi Jan,
>>
>> Nice to know this driver has some users.
> :)
>>
>> Firstly there are two completely different elements to this patch, so 
> they
>> should be broken out into 2 patches.
>> For the fix, perhaps the easier option is just to change the defaultto 
> use the
>> internal reference?   Do you have a use that requires it to be up to 
> VDD?
> Ok I can fix it. But in our application we messarue above the internal 
> reference and need vdd reference support. So best solution is platformcode 
> for selecting the source and the its value, right?
> 
>> Now you have pointed out this bug, I am rather dubious about simply 
> outputting
>> vref if the regulator isn't specified.  We could do this via 
>> platform data I guess.
>> I wonder how much trouble it would cause to just remove all options 
>> for not having
>> the reg there?  After all people can just use a fixed voltage 
>> regulator to specify
> thats the way I do it now ;) I didn't want to add max1363 platformcode by 
> now.
Sadly it looks like we will have to.
>> what it is.
>>
>> Hmm. These range attributes are a pain.  Do you have a use case 
>> actually needing
> No but in_scale depents also on the "range"
Sure, but no need to provide it to userspace. What happens inside the
driver doesn't bother me.  It's just a case of avoiding ambiguous
userspace interfaces if we can.
> 
> Kind regards,
> Jan
> 
>> that value?  I'm also tempted to suggest changing the abi to at 
>> least identify them with
>> a type of channel (hence in_range). Right now they aren't well specified
>> (what's the syntax for something covering 1-2V only for example?)
>>
>> Thanks,
>>
>> Jonathan
>>
>>
>>
>>> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
>>> ---
>>>  drivers/staging/iio/adc/max1363_core.c |   29 
> +++++++++++++++++++++++++----
>>>  1 files changed, 25 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/
>> staging/iio/adc/max1363_core.c
>>> index 905f856..cf49124 100644
>>> --- a/drivers/staging/iio/adc/max1363_core.c
>>> +++ b/drivers/staging/iio/adc/max1363_core.c
>>> @@ -279,22 +279,31 @@ static IIO_DEV_ATTR_IN_DIFF_RAW(7, 6, 
>> max1363_read_single_channel, d7m6);
>>>  static IIO_DEV_ATTR_IN_DIFF_RAW(9, 8, max1363_read_single_channel, 
> d9m8);
>>>  static IIO_DEV_ATTR_IN_DIFF_RAW(11, 10, 
>> max1363_read_single_channel, d11m10);
>>>
>>> +static u16 max1363_get_range(struct max1363_state *st)
>>> +{
>>> +   u16 range;
>>> +   if (IS_ERR(st->reg))
>>> +      range = st->chip_info->int_vref_mv;
>>> +   else
>>> +      range = regulator_get_voltage(st->reg) / 1000;
>>> +
>>> +   return range;
>>> +}
>>>
>>>  static ssize_t max1363_show_scale(struct device *dev,
>>>              struct device_attribute *attr,
>>>              char *buf)
>>>  {
>>> -   /* Driver currently only support internal vref */
>>> +   /* Driver currently only support vcc vref */
>>>     struct iio_dev *dev_info = dev_get_drvdata(dev);
>>>     struct max1363_state *st = iio_dev_get_devdata(dev_info);
>>>     /* Corresponds to Vref / 2^(bits) */
>>>
>>> -   if ((1 << (st->chip_info->bits + 1))
>>> -       > st->chip_info->int_vref_mv)
>>> +   if ((1 << (st->chip_info->bits + 1)) > max1363_get_range(st))
>>>        return sprintf(buf, "0.5\n");
>>>     else
>>>        return sprintf(buf, "%d\n",
>>> -         st->chip_info->int_vref_mv >> st->chip_info->bits);
>>> +         max1363_get_range(st) >> st->chip_info->bits);
>>>  }
>>>
>>>  static IIO_DEVICE_ATTR(in_scale, S_IRUGO, max1363_show_scale, NULL, 
> 0);
>>> @@ -310,6 +319,17 @@ static ssize_t max1363_show_name(struct device 
> *dev,
>>>
>>>  static IIO_DEVICE_ATTR(name, S_IRUGO, max1363_show_name, NULL, 0);
>>>
>>> +static ssize_t max1363_show_range(struct device *dev,
>>> +             struct device_attribute *attr,
>>> +             char *buf)
>>> +{
>>> +   struct iio_dev *dev_info = dev_get_drvdata(dev);
>>> +   struct max1363_state *st = iio_dev_get_devdata(dev_info);
>>> +   return sprintf(buf, "%d\n", max1363_get_range(st));
>>> +}
>>> +
>>> +static IIO_DEVICE_ATTR(range, S_IRUGO, max1363_show_range, NULL, 0);
>>> +
>>>  /* Applies to max1363 */
>>>  static const enum max1363_modes max1363_mode_list[] = {
>>>     _s0, _s1, _s2, _s3,
>>> @@ -329,6 +349,7 @@ static struct attribute *max1363_device_attrs[] = 
> {
>>>     &iio_dev_attr_in3min2_raw.dev_attr.attr,
>>>     &iio_dev_attr_name.dev_attr.attr,
>>>     &iio_dev_attr_in_scale.dev_attr.attr,
>>> +   &iio_dev_attr_range.dev_attr.attr,
>>>     NULL
>>>  };
>>>
>>
> 
> 

