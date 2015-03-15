Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34928 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbbCOUt7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2015 16:49:59 -0400
Message-ID: <5505F073.3090609@kernel.org>
Date: Sun, 15 Mar 2015 20:49:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: trigger: Use standard attr for sampling
 frequency
References: <1426091777-30592-1-git-send-email-daniel.baluta@intel.com>	<CAE1zot+us4bP2n1xQkFdAvJ3iAWwqTFgMK4SNZbmugPD_nB_Lg@mail.gmail.com>	<550150EC.5080100@metafoo.de>	<CAEnQRZCyUXpuG1R636c0C9_b0CPctigStkqWgK=PYKYFxGvcbA@mail.gmail.com>	<55046E31.3020404@kernel.org> <CAEnQRZD=XcAjV0YNHVRn30oEtXa++e-vSb3y_oS9h3+A2LSH4Q@mail.gmail.com>
In-Reply-To: <CAEnQRZD=XcAjV0YNHVRn30oEtXa++e-vSb3y_oS9h3+A2LSH4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/03/15 20:34, Daniel Baluta wrote:
> On Sat, Mar 14, 2015 at 7:21 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 12/03/15 12:48, Daniel Baluta wrote:
>>> On Thu, Mar 12, 2015 at 10:40 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>> On 03/12/2015 09:16 AM, Octavian Purdila wrote:
>>>>>
>>>>> On Wed, Mar 11, 2015 at 6:36 PM, Daniel Baluta <daniel.baluta@intel.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> As written in Documentation/ABI/testing/sysfs-bus-iio the trigger
>>>>>> attribute for sampling frequency should be sampling_frequency.
>>>>>>
>>>>>> Fix this for iio-trig-periodic-rtc module in order to prepare it
>>>>>> for moving out of staging.
>>>>>>
>>>>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>>>>> ---
>>>>>> Jonathan, this module is very useful for devices that do not have
>>>>>> an interrupt pin.
>>>>>>
>>>>>> We are working on drivers for such devices and would be very nice to
>>>>>> move this driver in advance to the IIO non-staging location.
>>>>>>
>>>>>> What do you say?
>>>>>>
>>>>>
>>>>> Hmm, I wonder what are the advantages of using RTC timers. Couldn't we
>>>>> use a regular kernel timer instead?
>>>>
>>>>
>>>> The long term plan is to get rid of the RTC timer trigger due to its various
>>>> limitations (poor resolution, etc).
>>>>
>>>> There is the hrtimer trigger
>>>> (https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/staging/iio/trigger/iio-trig-hrtimer.c)
>>>> but we haven't agreed on a proper interface yet how to instantiate the
>>>> hrtimer trigger.
>>>>
>>>> Check the ml archive for the various discussions on it:
>>>> http://marc.info/?l=linux-iio&w=2&r=1&s=hrtimer&q=b
>>>
>>>
>>> Hi Lars,
>>>
>>> That was an interesting reading. There were people trying to push
>>>  hrtimer based IIO trigger 4 years ago :).
>>>
>>> I think it's now the time to have this upstream.
>>>
>>> I will be back :) (as many others said before) with an RFC patch.
>>>
>>> I think we should keep the following requirements:
>>>
>>> 1) Create a common framework for software based triggers.
>>> 2) User space driven configuration for trigger instances,
>>> as opposed to platform device files used for RTC based trigger
>>> 3) Remove RTC interrupt source, use hrtimers instead
>>>
>>> Still not clear, but I will trying to figure it out during implementation:
>>>
>>> 4) configfs vs sysfs interface.
>>>
>>> At the first glance, I would say we should stay with sysfs interface in order
>>> to avoid another dependency. But let's see how it works.
>> This issue with the sysfs only approach (as originally raised by Lars)
>> is that it is actually very poorly suited to instantiating new elements of
>> the device model.  Configfs was introduced in the first place exactly to
>> cover this area.  We only ended up with the instantiation code in
>> the sysfs trigger via sysfs because at the time (a good long while ago!)
>> I wasn't aware of configfs.
>>
>> I have some initial work on the base elements on an iio configfs interface
>> somewhere that I can dig out if you like.  I started working on it in a rare
>> quiet period about a year ago, but never got all that far.
>>
>> There aren't that many examples in tree of how to actually use configfs
>> so it's a bit more of a learning curve than sysfs!
> 
> I use this:
> 
> http://lxr.free-electrons.com/source/Documentation/filesystems/configfs/configfs_example_explicit.c
> 
> as an example. But, sure if you find your work please share.
Hmm I think the branch I just pushed to iio.git as configfstest might be
the last code I had.  Not sure I got much beyond trying to create the infrastructure
for the subsystem to have quite a few different things under a semi unified location in
configfs.  Honestly can't really recall what this actually does!

Jonathan
> 
> I am not sure if we could use this approach for iio-trig-interrupt trigger?
> 
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

