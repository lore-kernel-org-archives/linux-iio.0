Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:37141 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab0IDQiy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Sep 2010 12:38:54 -0400
Message-ID: <4C827747.7070209@cam.ac.uk>
Date: Sat, 04 Sep 2010 17:43:51 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] staging:iio:trigger match leds trigger ABI
References: <1283441854-31560-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <Prayer.1.3.3.1009021714490.10022@hermes-1.csi.cam.ac.uk> <4C7FD38A.8090305@iis.fraunhofer.de>
In-Reply-To: <4C7FD38A.8090305@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/02/10 17:40, Manuel Stahl wrote:
> Am 02.09.2010 18:14, schrieb J.I. Cameron:
>> Hi Manuel,
>>
>> More explanation would be good.
>>
>> This falls into the debate of using a single sysfs param to list
>> available options with the selected one highlighted in the list
>> (what you have here)
>>
>> For every other element of iio we have gone with the separate attribute
>> listing what is available.
> 
> I think it makes a big difference if the attribute accepts names or
> numbers. With names, a list is always handy. The first time I tried
> to use a different trigger than the device's own, I was totally lost.
> I couldn't figure out which names are valid and which are not.
You should just be able to look at names of the registered triggers in
their individual directories.
> 
>> I'm also a little dubious about this as it massively
>> crosses over between different drivers (basically it gives an alternative
>> way of listing all triggers currently on the system). Obviously this is
>> to a certain extent true of led triggers as well, but there are relatively
>> few of them (as far as I know?)
> 
> I think the led subsystem is not the only one using the list style.
> Just have to lookup where I found other uses.
It is quite common.  It was an issue highlighted in an lwn article
a while back... http://lwn.net/Articles/378884/
> 
>> We could easily have hundreds of triggers on a complex sensor rig. That
>> makes for a very bit attribute indeed.
> 
> The same could happen to led triggers...
True.  I can't see it happening any time soon, but it might.
> 
>> So this is a nice idea, but in practice I'm not yet convinced it is
>> actually
>> a good idea in practice. This may be one to bounce up to lkml for a wider
>> set of opinions.
> 
> Yes, let's here what other think about it. Was more like a proposal
> patch to see what it will look like and how useful it is.
> 
>>>
>>> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de> ---
>>> drivers/staging/iio/industrialio-trigger.c | 27
>>> ++++++++++++++++++++------- 1 files changed, 20 insertions(+), 7
>>> deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/industrialio-trigger.c
>>> b/drivers/staging/iio/industrialio-trigger.c index 57dd923..25ee00f
>>> 100644 --- a/drivers/staging/iio/industrialio-trigger.c +++
>>> b/drivers/staging/iio/industrialio-trigger.c @@ -293,11 +293,25 @@
>>> static ssize_t iio_trigger_read_current(struct device *dev,
>>> char *buf)
>>> {
>>> struct iio_dev *dev_info = dev_get_drvdata(dev);
>>> + struct iio_trigger *trig;
>>> int len = 0;
>>> - if (dev_info->trig)
>>> - len = sprintf(buf,
>>> - "%s\n",
>>> - dev_info->trig->name);
>>> +
>>> + if (!dev_info->trig)
>>> + len += sprintf(buf+len, "[none]");
>> spaces round the +? I have a vague feeling checkpatch is fussy about that.
>>> + else
>>> + len += sprintf(buf+len, "none ");
>>> +
>>> + mutex_lock(&iio_trigger_list_lock);
>>> + list_for_each_entry(trig, &iio_trigger_list, list) {
>> what is the point of this?
>>> + if (dev_info->trig && !strcmp(dev_info->trig->name,
>>> + trig->name))
>>> + len += sprintf(buf+len, " [%s]", trig->name);
>>> + else
>>> + len += sprintf(buf+len, " %s", trig->name);
>> At very least these need some protection to prevent a buffer overrun.
>>> + }
>>> + mutex_unlock(&iio_trigger_list_lock);
>>> +
>>> + len += sprintf(len+buf, "\n");
>>> return len;
>>> }
>>>
>>> @@ -331,17 +345,16 @@ static ssize_t iio_trigger_write_current(struct
>>> device *dev,
>>> return len;
>>> }
>>>
>>> -static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
>>> +static DEVICE_ATTR(trigger, S_IRUGO | S_IWUSR,
>>> iio_trigger_read_current,
>>> iio_trigger_write_current);
>>>
>>> static struct attribute *iio_trigger_consumer_attrs[] = {
>>> - &dev_attr_current_trigger.attr,
>>> + &dev_attr_trigger.attr,
>>> NULL,
>>> };
>>>
>>> static const struct attribute_group iio_trigger_consumer_attr_group = {
>>> - .name = "trigger",
>>> .attrs = iio_trigger_consumer_attrs,
>>> };
>>>
>>>
> 
> 

