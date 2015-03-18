Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-210.synserver.de ([212.40.185.210]:1060 "EHLO
	smtp-out-210.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbbCRRZB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2015 13:25:01 -0400
Message-ID: <5509B4F7.7040801@metafoo.de>
Date: Wed, 18 Mar 2015 18:25:11 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: trigger: Use standard attr for sampling
 frequency
References: <1426091777-30592-1-git-send-email-daniel.baluta@intel.com>	<CAE1zot+us4bP2n1xQkFdAvJ3iAWwqTFgMK4SNZbmugPD_nB_Lg@mail.gmail.com>	<550150EC.5080100@metafoo.de>	<CAEnQRZCyUXpuG1R636c0C9_b0CPctigStkqWgK=PYKYFxGvcbA@mail.gmail.com>	<55046E31.3020404@kernel.org>	<CAEnQRZASq1YYGouYtd0Km1rR0Ld51H=nK04CWfeRZNe_=3suvA@mail.gmail.com>	<5509AC15.5070400@metafoo.de> <CAEnQRZCe9A36ouGvZ2k1ng0NrnhiUCn2kSaqxOJszGCMYYbr3Q@mail.gmail.com>
In-Reply-To: <CAEnQRZCe9A36ouGvZ2k1ng0NrnhiUCn2kSaqxOJszGCMYYbr3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/18/2015 06:21 PM, Daniel Baluta wrote:
> On Wed, Mar 18, 2015 at 6:47 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 03/18/2015 04:04 PM, Daniel Baluta wrote:
>>>
>>> On Sat, Mar 14, 2015 at 7:21 PM, Jonathan Cameron <jic23@kernel.org>
>>> wrote:
>>>>
>>>> On 12/03/15 12:48, Daniel Baluta wrote:
>>>>>
>>>>> On Thu, Mar 12, 2015 at 10:40 AM, Lars-Peter Clausen <lars@metafoo.de>
>>>>> wrote:
>>>>>>
>>>>>> On 03/12/2015 09:16 AM, Octavian Purdila wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Wed, Mar 11, 2015 at 6:36 PM, Daniel Baluta
>>>>>>> <daniel.baluta@intel.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> As written in Documentation/ABI/testing/sysfs-bus-iio the trigger
>>>>>>>> attribute for sampling frequency should be sampling_frequency.
>>>>>>>>
>>>>>>>> Fix this for iio-trig-periodic-rtc module in order to prepare it
>>>>>>>> for moving out of staging.
>>>>>>>>
>>>>>>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>>>>>>> ---
>>>>>>>> Jonathan, this module is very useful for devices that do not have
>>>>>>>> an interrupt pin.
>>>>>>>>
>>>>>>>> We are working on drivers for such devices and would be very nice to
>>>>>>>> move this driver in advance to the IIO non-staging location.
>>>>>>>>
>>>>>>>> What do you say?
>>>>>>>>
>>>>>>>
>>>>>>> Hmm, I wonder what are the advantages of using RTC timers. Couldn't we
>>>>>>> use a regular kernel timer instead?
>>>>>>
>>>>>>
>>>>>>
>>>>>> The long term plan is to get rid of the RTC timer trigger due to its
>>>>>> various
>>>>>> limitations (poor resolution, etc).
>>>>>>
>>>>>> There is the hrtimer trigger
>>>>>>
>>>>>> (https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/staging/iio/trigger/iio-trig-hrtimer.c)
>>>>>> but we haven't agreed on a proper interface yet how to instantiate the
>>>>>> hrtimer trigger.
>>>>>>
>>>>>> Check the ml archive for the various discussions on it:
>>>>>> http://marc.info/?l=linux-iio&w=2&r=1&s=hrtimer&q=b
>>>>>
>>>>>
>>>>>
>>>>> Hi Lars,
>>>>>
>>>>> That was an interesting reading. There were people trying to push
>>>>>    hrtimer based IIO trigger 4 years ago :).
>>>>>
>>>>> I think it's now the time to have this upstream.
>>>>>
>>>>> I will be back :) (as many others said before) with an RFC patch.
>>>>>
>>>>> I think we should keep the following requirements:
>>>>>
>>>>> 1) Create a common framework for software based triggers.
>>>>> 2) User space driven configuration for trigger instances,
>>>>> as opposed to platform device files used for RTC based trigger
>>>>> 3) Remove RTC interrupt source, use hrtimers instead
>>>>>
>>>>> Still not clear, but I will trying to figure it out during
>>>>> implementation:
>>>>>
>>>>> 4) configfs vs sysfs interface.
>>>>>
>>>>> At the first glance, I would say we should stay with sysfs interface in
>>>>> order
>>>>> to avoid another dependency. But let's see how it works.
>>>>
>>>> This issue with the sysfs only approach (as originally raised by Lars)
>>>> is that it is actually very poorly suited to instantiating new elements
>>>> of
>>>> the device model.  Configfs was introduced in the first place exactly to
>>>> cover this area.  We only ended up with the instantiation code in
>>>> the sysfs trigger via sysfs because at the time (a good long while ago!)
>>>> I wasn't aware of configfs.
>>>>
>>>> I have some initial work on the base elements on an iio configfs
>>>> interface
>>>> somewhere that I can dig out if you like.  I started working on it in a
>>>> rare
>>>> quiet period about a year ago, but never got all that far.
>>>>
>>>> There aren't that many examples in tree of how to actually use configfs
>>>> so it's a bit more of a learning curve than sysfs!
>>>
>>>
>>> First notable problem with using configfs with IIO is boot time modules
>>> loading.
>>>
>>> Because,
>>>
>>> * configs uses module_init(configfs_init);
>>> * IIO uses subsys_initcall(iio_init);
>>>
>>> it is guaranteed that IIO will be loaded before configfs. Not fun! :)
>>>
>>> So for the moment I will not add configfs support directly into
>>> industrialiio-core but in a separate module.
>>
>>
>> Just fix configfs, that should clearly not be at the module init level.
>>
>> But keeping it in a separate module doesn't hurt either way.
>
> Looking at drivers/fs all filesystems modules are at module init level.
> I'll drop an email to fs folks :).

debugfs is at core_initcall() and in my opinion configfs is on the same 
level from a infrastructure point of view.

>
> What if IIO core should be at module init core?

It's a subsystem, it should be at subsys_initcall().

