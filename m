Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <552A91F1.70504@kernel.org>
References: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>
	<1428329889-18335-3-git-send-email-daniel.baluta@intel.com>
	<5526B24D.1010701@kernel.org>
	<CAEnQRZDQM0UM2f=LcCAMpwZqGgNo8JKLw+CJL9wz2Fq3zx35bQ@mail.gmail.com>
	<552A91F1.70504@kernel.org>
Date: Wed, 15 Apr 2015 18:33:03 +0300
Message-ID: <CAEnQRZAD0pT+Na3+SZDbpD-QSt5dpYx_BWQ2XZ2_aF94JhgggA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: trigger: Add support for highres timer
 trigger type
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Paul Bolle <pebolle@tiscali.nl>,
	patrick.porlan@intel.com, adriana.reus@intel.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 12, 2015 at 6:40 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 10/04/15 10:02, Daniel Baluta wrote:
>> On Thu, Apr 9, 2015 at 8:09 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 06/04/15 15:18, Daniel Baluta wrote:
>>>> This patch adds a new trigger type - the high resoluton timer ("hrtimer")
>>>> under /config/iio/triggers/ and also creates a module that implements hrtimer
>>>> trigger type functionality.
>>>>
>>>> A new IIO trigger is allocated when a new directory is created under
>>>> /config/iio/triggers/. The name of the trigger is the same as the dir
>>>> name. Each trigger will have a "delay" attribute representing the delay
>>>> between two successive IIO trigger_poll calls.
>>> Cool ;)
>>>>
>>>> Signed-off-by: Marten Svanfeldt <marten@intuitiveaerial.com>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>> I'd ideally have liked the break up of the patches to be slightly different.
>>> There is stuff in here that would have made more sense in the first patch
>>> as it isn't specific to this particular trigger.
>>
>> Yes :), this was my first thought too (implemented in v1), but then I wanted
>> to make a complete example on how to add a new trigger type.
> I can see where you are coming from, but really think we need to
> make it so there is less of each trigger implementation in the core.
> Preferably none!
>>
>> People implementing a new trigger type will find this patch very useful.
>>
>> Anyhow, I have no objection on this. Can be fixed.
>>>> ---
>>>> Changes since v2:
>>>>       * none
>>>> Changes since v1:
>>>>       * replaced sampling_frequency with delay to make the in kernel
>>>>       processing easier
>>> Then along comes me an suggests going back again ;)  Make your case...
>>
>> Initial hrtimer trigger implementation was limited to using integer sampling
>> frequencies. Adding "rational" frequencies (e.g 12.5 Hz) and converting them
>> back to hrtimer trigger delay  would add some complex calculation in the kernel
>> with the possibility of losing precision.
>>
>> Besides that, for most devices sampling_frequencies (Hz) attribute is natural
>> because this is what the devices expose in its registers, while the timers
>> API uses delays (nsec).
>>
>> Here is how I see the usage of device's sampling_frequency and trigger's
>> delay (this should be kept in sync)
>>
>> User application reads device's sampling_frequency and then based on that
>> it sets trigger's delay to 1/sampling_frequency -- all of that happening in user
>> space where floating point is easy :).
> I'm not keen on the flipping backwards and forwards going on here.  To my
> mind the two should be the same.

I see. So it shouldn't be any direct relation between device
sampling_frequency and
trigger sampling_frequency.

Now, I'm afraid that users will get confused about this naming and they'll
try to keep both of them in sync.

To sum up, I will also use sampling_frequency also for triggers and
make sure this is
well documented. Not sure if supporting rational frequencies will
bring any benefit
(e.g 12.5), since we won't be able to match the exact sampling
frequency of the device.

>
> I'm a little unclear on when we'd actually hit your example and whether
> this is the right approach if we do.
>
> The usual case for using a 'software' trigger is for devices with no
> sampling clock of their own.  So devices with a 'sample now' signal
> (be this an explicit one or a case where the device samples using the
> bus clock to drive the adc).
>
> So here you are dealing with devices that would actually have a dataready
> type signal, but it's not exposed? Any attempt to match sampling is just
> destined to go wrong.  If you want to guarantee getting all the data you'll
> have to over sample, probably by a significant degree given that you'll
> have some variation in any software trigger.

There are devices which do not have an interrupt pin (by design).
Also, there are
cases where is not possible to know if new data is ready. You'll just
have to read it
and compare it with previous values to really figure out if it's new.

>
> In most (possibly) all devices there is a software means of reading whether
> their is new data available.  I'd suggest in this case we do actually need
> to move the polling logic into the driver.  It simply doesn't
> make sense to use the generic timer to do it as we won't sample ever time.

It makes some sense because we want to have a generic way of support
triggered buffers
without having to modify the driver to use polling.

>
> Hence you'll end up with a trigger that has an underlying 'hidden' poll
> of the device and only fires when there is new data available - much cleaner
> interface to userspace and reliable data capture without repeat samples
> and all the mess that will entail.
>>

I agree here that the interface to userspace will be cleaner in this
case (in fact the user
doesn't have to do anything).  But the amount of work needed for the user
in case we use generic trigger described above should be negligible compared
to the amount of work needed to implement polling in every driver.
