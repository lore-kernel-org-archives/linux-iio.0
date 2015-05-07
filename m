Return-Path: <lars@metafoo.de>
Message-ID: <554BAE42.1050702@metafoo.de>
Date: Thu, 07 May 2015 20:26:10 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: Joel Becker <jlbec@evilplan.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "octavian.purdila@intel.com" <octavian.purdila@intel.com>,
 Paul Bolle <pebolle@tiscali.nl>, patrick.porlan@intel.com,
 adriana.reus@intel.com, constantin.musca@intel.com,
 marten@intuitiveaerial.com
Subject: Re: [PATCH v5 3/4] iio: trigger: Introduce IIO hrtimer based trigger
References: <1430736604-22119-1-git-send-email-daniel.baluta@intel.com>	<1430736604-22119-4-git-send-email-daniel.baluta@intel.com>	<5547CE60.5000300@metafoo.de>	<0944C1CC-6F9C-49C5-8195-994413B68680@kernel.org>	<554A4065.8050101@intel.com>	<554A4C6B.10703@kernel.org>	<CAEnQRZACZS=hC13rp7Ft_W8+2EYjLjddCOLr_=mbuKpj56=qqA@mail.gmail.com>	<554B2E22.10807@kernel.org> <CAEnQRZD8x+oxmsPsg_kJTSFVOZDKiwCrzHw0eZ172xCK3S9MZQ@mail.gmail.com>
In-Reply-To: <CAEnQRZD8x+oxmsPsg_kJTSFVOZDKiwCrzHw0eZ172xCK3S9MZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 05/07/2015 12:26 PM, Daniel Baluta wrote:
> On Thu, May 7, 2015 at 12:19 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 06/05/15 18:37, Daniel Baluta wrote:
>>> On Wed, May 6, 2015 at 8:16 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>> On 06/05/15 17:25, Daniel Baluta wrote:
>>>>>
>>>>>
>>>>> On 05/05/2015 04:51 PM, Jonathan Cameron wrote:
>>>>>>
>>>>>>
>>>>>> On 4 May 2015 20:54:08 GMT+01:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>>>>> On 05/04/2015 12:50 PM, Daniel Baluta wrote:
>>>>>>> [...]
>>>>>>>> +IIO_HRTIMER_INFO_ATTR(sampling_frequency, S_IRUGO | S_IWUSR,
>>>>>>>> +              iio_hrtimer_info_show_sampling_frequency,
>>>>>>>> +              iio_hrtimer_info_store_sampling_frequency);
>>>>>>>
>>>>>>> I wonder if the sampling frequency should be configurable the regular
>>>>>>> IIO
>>>>>>> API, just like any other IIO device. But things like min/max sampling
>>>>>>> frequency should be configured in configfs.
>>>>>> Would have to be in the trigger dir rather than device... Makes sense to put it there.
>>>>>> Limits on it here seem like a sensible idea.
>>>>>
>>>>> But then each trigger will have sampling_frequency right? This is not what we want.
>>>> I'm confused now.  Why not?  Each hrtimer trigger created in configfs should have
>>>> it's own sampling frequency should it not?
>>>
>>> I was referring to triggers in general, not just hrtimer triggers.
>>>
>>> But I see now that we can set trig->dev.groups to point to our
>>> specific attributes. This
>>> should work.
>>>
>>> Anyhow, I'm not convinced that sampling_frequency should be configured
>>> from sysfs.
>>> We create the trigger from configfs:
>>>
>>> $ mkdir /config/triggers/hrtimer-instance0
>>>
>>> Then, likely we have to do something like this:
>>>
>>> $ echo 100 > /sys/bus/iio/trigger7/sampling_frequency
>>>
>>> How is the user application going to know which is the exact directory
>>> for hrtimer-instance0 ?
>>>
>>> Daniel.
>>>
>> Find it by name like we normally do?
>
> Ok :). I will move this to sysfs and send v6.

If you add the min/max properties you could still control the frequency via 
configfs by setting min and max to the same. In that case the sysfs property 
would merely inform applications about the currently selected frequency.

- Lars
