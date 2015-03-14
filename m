Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55772 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbbCNR0m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2015 13:26:42 -0400
Message-ID: <55046F50.3050207@kernel.org>
Date: Sat, 14 Mar 2015 17:26:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: trigger: Use standard attr for sampling
 frequency
References: <1426091777-30592-1-git-send-email-daniel.baluta@intel.com> <CAE1zot+us4bP2n1xQkFdAvJ3iAWwqTFgMK4SNZbmugPD_nB_Lg@mail.gmail.com> <550150EC.5080100@metafoo.de>
In-Reply-To: <550150EC.5080100@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/03/15 08:40, Lars-Peter Clausen wrote:
> On 03/12/2015 09:16 AM, Octavian Purdila wrote:
>> On Wed, Mar 11, 2015 at 6:36 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
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
>> Hmm, I wonder what are the advantages of using RTC timers. Couldn't
>> we use a regular kernel timer instead?
> 
> The long term plan is to get rid of the RTC timer trigger due to its
> various limitations (poor resolution, etc).
Just to add to this, the rtc timer stuff was a nasty hack a long time
ago to allow use of additional periodic timers available on the pxa72x.
At one point I had a rtc driver that exposed these.  There was discussion
at the time about more generic 'additional timer' support in the kernel
but no one ever took the job on.  The blackfin timer driver was a later
approach to handling the same sort of timers.

In more recent times, the periodic timer element of the RTC framework
has become entirely simulated anyway with no use made of true periodic
interrupts any more.  As such its a totally silly approach to getting
us a periodic trigger.  Perhaps we should just drop it now.  Previously
we have kept it around on the basis the hrt trigger was always on the
way, but does anyone actively use it?

Jonathan

> 
> There is the hrtimer trigger
> (https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/staging/iio/trigger/iio-trig-hrtimer.c)
> but we haven't agreed on a proper interface yet how to instantiate
> the hrtimer trigger.
> 
> Check the ml archive for the various discussions on it:
> http://marc.info/?l=linux-iio&w=2&r=1&s=hrtimer&q=b
> 
> - Lars

