Return-Path: <daniel.baluta@intel.com>
Message-ID: <554A4065.8050101@intel.com>
Date: Wed, 06 May 2015 19:25:09 +0300
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
CC: jlbec@evilplan.org, knaack.h@gmx.de, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, octavian.purdila@intel.com,
 pebolle@tiscali.nl, patrick.porlan@intel.com, adriana.reus@intel.com,
 constantin.musca@intel.com, marten@intuitiveaerial.com
Subject: Re: [PATCH v5 3/4] iio: trigger: Introduce IIO hrtimer based trigger
References: <1430736604-22119-1-git-send-email-daniel.baluta@intel.com> <1430736604-22119-4-git-send-email-daniel.baluta@intel.com> <5547CE60.5000300@metafoo.de> <0944C1CC-6F9C-49C5-8195-994413B68680@kernel.org>
In-Reply-To: <0944C1CC-6F9C-49C5-8195-994413B68680@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 05/05/2015 04:51 PM, Jonathan Cameron wrote:
>
>
> On 4 May 2015 20:54:08 GMT+01:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 05/04/2015 12:50 PM, Daniel Baluta wrote:
>> [...]
>>> +IIO_HRTIMER_INFO_ATTR(sampling_frequency, S_IRUGO | S_IWUSR,
>>> +		      iio_hrtimer_info_show_sampling_frequency,
>>> +		      iio_hrtimer_info_store_sampling_frequency);
>>
>> I wonder if the sampling frequency should be configurable the regular
>> IIO
>> API, just like any other IIO device. But things like min/max sampling
>> frequency should be configured in configfs.
> Would have to be in the trigger dir rather than device... Makes sense to put it there.
> Limits on it here seem like a sensible idea.

But then each trigger will have sampling_frequency right? This is not 
what we want.

>>
>> [...]
>>> +#endif /* CONFIGFS_FS */
>>> +
>> [...]
>>> +static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char
>> *name)
>>> +{
>> [...]
>>> +#ifdef CONFIG_CONFIGFS_FS
>>> +	config_group_init_type_name(&trig_info->swt.group, name,
>>> +				    &iio_hrtimer_type);
>>> +#endif
>>
>> This should probably have a helper function in the sw trigger core,
>> that
>> gets stubbed out when CONFIG_FS is disabled. Otherwise we'll see the
>> same
>> #ifdef in every software trigger driver.
>> [...]

Agree with this. Will fix.

>>> +}
>>> +
>>> +static int iio_trig_hrtimer_remove(struct iio_sw_trigger *swt)
>>> +{
>>> +	struct iio_hrtimer_info *trig_info;
>>> +
>>> +	trig_info = iio_trigger_get_drvdata(swt->trigger);
>>> +
>>> +	hrtimer_cancel(&trig_info->timer);
>>> +
>>> +	iio_trigger_unregister(swt->trigger);
>>> +	iio_trigger_free(swt->trigger);
>>
>> There is a bit of a race condition here. hrtimer_cancel() should be
>> called
>> between unregister and free, otherwise it might be re-armed before it
>> is
>> unregistered.

So this can be re-armed only if the buffer is re-enabled between 
hrtimer_cancel and iio_trigger_unregister :). I'm trying to understand 
how the race can happen.


>>
>>> +	kfree(trig_info);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +struct iio_sw_trigger_ops iio_trig_hrtimer_ops = {
>>
>> const

Agree.
>>
>>> +	.probe		= iio_trig_hrtimer_probe,
>>> +	.remove		= iio_trig_hrtimer_remove,
>>> +};
>> [...]
