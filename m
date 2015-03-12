Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <550150EC.5080100@metafoo.de>
References: <1426091777-30592-1-git-send-email-daniel.baluta@intel.com>
	<CAE1zot+us4bP2n1xQkFdAvJ3iAWwqTFgMK4SNZbmugPD_nB_Lg@mail.gmail.com>
	<550150EC.5080100@metafoo.de>
Date: Thu, 12 Mar 2015 14:48:51 +0200
Message-ID: <CAEnQRZCyUXpuG1R636c0C9_b0CPctigStkqWgK=PYKYFxGvcbA@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: trigger: Use standard attr for sampling frequency
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Octavian Purdila <octavian.purdila@intel.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 12, 2015 at 10:40 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 03/12/2015 09:16 AM, Octavian Purdila wrote:
>>
>> On Wed, Mar 11, 2015 at 6:36 PM, Daniel Baluta <daniel.baluta@intel.com>
>> wrote:
>>>
>>>
>>> As written in Documentation/ABI/testing/sysfs-bus-iio the trigger
>>> attribute for sampling frequency should be sampling_frequency.
>>>
>>> Fix this for iio-trig-periodic-rtc module in order to prepare it
>>> for moving out of staging.
>>>
>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>> ---
>>> Jonathan, this module is very useful for devices that do not have
>>> an interrupt pin.
>>>
>>> We are working on drivers for such devices and would be very nice to
>>> move this driver in advance to the IIO non-staging location.
>>>
>>> What do you say?
>>>
>>
>> Hmm, I wonder what are the advantages of using RTC timers. Couldn't we
>> use a regular kernel timer instead?
>
>
> The long term plan is to get rid of the RTC timer trigger due to its various
> limitations (poor resolution, etc).
>
> There is the hrtimer trigger
> (https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/staging/iio/trigger/iio-trig-hrtimer.c)
> but we haven't agreed on a proper interface yet how to instantiate the
> hrtimer trigger.
>
> Check the ml archive for the various discussions on it:
> http://marc.info/?l=linux-iio&w=2&r=1&s=hrtimer&q=b


Hi Lars,

That was an interesting reading. There were people trying to push
 hrtimer based IIO trigger 4 years ago :).

I think it's now the time to have this upstream.

I will be back :) (as many others said before) with an RFC patch.

I think we should keep the following requirements:

1) Create a common framework for software based triggers.
2) User space driven configuration for trigger instances,
as opposed to platform device files used for RTC based trigger
3) Remove RTC interrupt source, use hrtimers instead

Still not clear, but I will trying to figure it out during implementation:

4) configfs vs sysfs interface.

At the first glance, I would say we should stay with sysfs interface in order
to avoid another dependency. But let's see how it works.

thanks,
Daniel.
