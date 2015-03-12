Return-Path: <lars@metafoo.de>
Message-ID: <550150EC.5080100@metafoo.de>
Date: Thu, 12 Mar 2015 09:40:12 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
 Daniel Baluta <daniel.baluta@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: trigger: Use standard attr for sampling
 frequency
References: <1426091777-30592-1-git-send-email-daniel.baluta@intel.com> <CAE1zot+us4bP2n1xQkFdAvJ3iAWwqTFgMK4SNZbmugPD_nB_Lg@mail.gmail.com>
In-Reply-To: <CAE1zot+us4bP2n1xQkFdAvJ3iAWwqTFgMK4SNZbmugPD_nB_Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/12/2015 09:16 AM, Octavian Purdila wrote:
> On Wed, Mar 11, 2015 at 6:36 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>
>> As written in Documentation/ABI/testing/sysfs-bus-iio the trigger
>> attribute for sampling frequency should be sampling_frequency.
>>
>> Fix this for iio-trig-periodic-rtc module in order to prepare it
>> for moving out of staging.
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> ---
>> Jonathan, this module is very useful for devices that do not have
>> an interrupt pin.
>>
>> We are working on drivers for such devices and would be very nice to
>> move this driver in advance to the IIO non-staging location.
>>
>> What do you say?
>>
>
> Hmm, I wonder what are the advantages of using RTC timers. Couldn't we
> use a regular kernel timer instead?

The long term plan is to get rid of the RTC timer trigger due to its various 
limitations (poor resolution, etc).

There is the hrtimer trigger 
(https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/staging/iio/trigger/iio-trig-hrtimer.c) 
but we haven't agreed on a proper interface yet how to instantiate the 
hrtimer trigger.

Check the ml archive for the various discussions on it: 
http://marc.info/?l=linux-iio&w=2&r=1&s=hrtimer&q=b

- Lars
