Return-Path: <octavian.purdila@intel.com>
MIME-Version: 1.0
In-Reply-To: <552ED97E.1090009@kernel.org>
References: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>
	<1428329889-18335-2-git-send-email-daniel.baluta@intel.com>
	<CAEnQRZAijAtRdqke5tP-DFL8ROvnzimBEbHwr1=JxhAaqoCndw@mail.gmail.com>
	<5526B464.8000502@kernel.org>
	<CAEnQRZA=pSm5DV6PzZ9zQ7W+d_Q9esn6X9cmOOdymNFu8sCyug@mail.gmail.com>
	<552A965B.7030108@kernel.org>
	<CAE1zotLWDGdb57sG8W_i7Lzq5aZb2cnCo9tCD_NhRQE03eRXyA@mail.gmail.com>
	<552ED97E.1090009@kernel.org>
Date: Wed, 15 Apr 2015 15:15:59 -0700
Message-ID: <CAE1zotLjK=rjY3SWZ3npBVUoKiwHTyOw10js=t4iYbqLie7JKw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: configfs: Add configfs support to IIO
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Paul Bolle <pebolle@tiscali.nl>,
	Patrick Porlan <patrick.porlan@intel.com>, Adriana Reus <adriana.reus@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 15, 2015 at 2:34 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 15/04/15 21:58, Octavian Purdila wrote:
>> On Sun, Apr 12, 2015 at 8:59 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 10/04/15 14:43, Daniel Baluta wrote:
>>>> On Thu, Apr 9, 2015 at 8:18 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>>> On 08/04/15 14:30, Daniel Baluta wrote:
>>>>>> On Mon, Apr 6, 2015 at 5:18 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>>>>>> This module is the core of IIO configfs. It creates the "iio" subsystem under
>>>>>>> configfs mount point root, with one default group for "triggers".
>>>>>>>
>>>>>>> It offers basic interface for registering software trigger types. Next patches
>>>>>>> will add "hrtimer" and "sysfs" trigger types. To add a new trigger type we must
>>>>>>> create a new kernel module which implements iio_configfs_trigger.h interface.
>>>>>>>
>>>>>>> See Documentation/iio/iio_configfs.txt for more details on how configfs
>>>>>>> support for IIO works.
>>>>>>>
>>>>>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> I also need your feedback on the following problem.
>>>>>>
>>>>>> We would like to be able to create hrtimer triggers from within
>>>>>> a kernel module. There are cases where we don't have an interrupt
>>>>>> pin or the interrupt pin is not connected, and we would like
>>>>>> that applications to run unmodified with these types of sensors too.
>>>>> A reasonable aim perhaps, as opposed to locally implemented polling
>>>>> all over the place (which should definitely not happen).
>>>>
>>>> Yes, exactly! :)
>>> I'm actually beginning to have my doubts about whether my initial
>>> response here was right.  Given your use cases and the complexity
>>> of matching frequencies, I think you are almost always better
>>> off implementing it in the drivers themselves (which can decide
>>> if there is new data or not).
>>
>> I agree. Although I think having some helper functions in IIO core
>> should help keep the driver modifications to a minimum.
>>
>>>>
>>>>>
>>>>> An alternative the zio guys used was to create timer
>>>>> based triggers on the fly purely based on them being requested
>>>>> (with an appropriate name IIRC)...  Doesn't quite solve your
>>>>> problem though as still needs userspace changes.
>>>>>>
>>>>>> We will split the current design into 3 parts:
>>>>>>
>>>>>> (1) IIO trigger handling generic part, which offers an API
>>>>>>      to register/unregister/get a reference to a trigger type
>>>>>>
>>>>>> (2) IIO configfs part that gets a reference to a trigger type and
>>>>>> handles user requests to create/destroy a trigger.
>>>>>>
>>>>>> (3) IIO hrtimer driver that use the API at (1) for registering
>>>>>> / deregistering a trigger type.
>>>>>>
>>>>>> Then, each driver in the case that it doesn't have a "real" trigger,
>>>>>> will get a reference to a "hrtimer" trigger type and create
>>>>>> a new "hrtimer" trigger.
>>>>>>
>>>>>> Does this look good to you? This could be easily done from
>>>>>> userspace, but we will need to modify our userspace applications.
>>>>> My initial thought is this really is a job for userspace, as should
>>>>> be in most cases connecting up the device specific trigger as well
>>>>> (as it's not always the right thing to use).
>>>>>
>>>>> In the general case it is far from obvious that an hrtimer is the
>>>>> right option.  Many usecases would be better off with a sysfs trigger
>>>>> or even running off a different interrupt based trigger entirely.
>>>>>>
>>>>>> Also, handling sampling_frequency/delay would be transparent to
>>>>>> applications if we provide this in kernel API.
>>>>> Not really as sampling frequency in this case should only be an
>>>>> attribute of the trigger, not the device.  We only really allow
>>>>> it for the device rather than always the triggers on the basis
>>>>> that it has impacts on other device elements (events etc).
>>>>
>>>> Well, if the trigger is directly created from the driver then we will
>>>> have a reference to a function that sets its delay.
>>>>
>>>> Each time the user sets the sampling frequency for the device
>>>> with hit write_raw and there on IIO_CHAN_INFO_SAMP_FREQ
>>>> case we also call set_delay(). Thus we always have have device
>>>> sampling frequency in sync with trigger delay.
>>>>
>>>> I know this sounds crazy :) and I don't like it. I am not sure how
>>>> to guarantee that device frequency is always in sync with trigger
>>>> delay.
>>> You can't that I can see.  Hence you've convinced me this is a bad
>>> idea.
>>
>> I agree we can't accurately synchronize the device frequency with the
>> trigger frequency, but I think we can get it do a good enough level. I
>> also see no difference in accuracy in doing it from userspace or from
>> the driver itself.
>>
>> Why do you think it is a bad idea to synchronize the trigger sample
>> frequency from the device sample frequency handler? I think that if we
>> want to provide the hrtimer trigger from the driver itself, we should
>> do this as well, otherwise there is no real gain to userspace.
>>
> You will get beating problems.  So once in a while you'll either miss
> a reading or you'll get a bonus one.
>
> The point about doing it in the driver is that you actually poll at a
> higher frequency, but only fire a trigger if there is something there
> (by reading the dataready register or equivalent).
>
> Thus your trigger acts more or less the same as a wired interrupt.
> You can't do this with an external hrtimer trigger.

Polling will have a large impact on power. I know that some people
will care more about saving power and that is why I think its worth
having the external hrtimer trigger option.
