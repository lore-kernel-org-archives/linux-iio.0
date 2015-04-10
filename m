Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32807 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964852AbbDJNnS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2015 09:43:18 -0400
MIME-Version: 1.0
In-Reply-To: <5526B464.8000502@kernel.org>
References: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>
	<1428329889-18335-2-git-send-email-daniel.baluta@intel.com>
	<CAEnQRZAijAtRdqke5tP-DFL8ROvnzimBEbHwr1=JxhAaqoCndw@mail.gmail.com>
	<5526B464.8000502@kernel.org>
Date: Fri, 10 Apr 2015 16:43:16 +0300
Message-ID: <CAEnQRZA=pSm5DV6PzZ9zQ7W+d_Q9esn6X9cmOOdymNFu8sCyug@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: configfs: Add configfs support to IIO
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, patrick.porlan@intel.com,
	adriana.reus@intel.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Apr 9, 2015 at 8:18 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 08/04/15 14:30, Daniel Baluta wrote:
>> On Mon, Apr 6, 2015 at 5:18 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>> This module is the core of IIO configfs. It creates the "iio" subsystem under
>>> configfs mount point root, with one default group for "triggers".
>>>
>>> It offers basic interface for registering software trigger types. Next patches
>>> will add "hrtimer" and "sysfs" trigger types. To add a new trigger type we must
>>> create a new kernel module which implements iio_configfs_trigger.h interface.
>>>
>>> See Documentation/iio/iio_configfs.txt for more details on how configfs
>>> support for IIO works.
>>>
>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>
>> Hi all,
>>
>> I also need your feedback on the following problem.
>>
>> We would like to be able to create hrtimer triggers from within
>> a kernel module. There are cases where we don't have an interrupt
>> pin or the interrupt pin is not connected, and we would like
>> that applications to run unmodified with these types of sensors too.
> A reasonable aim perhaps, as opposed to locally implemented polling
> all over the place (which should definitely not happen).

Yes, exactly! :)

>
> An alternative the zio guys used was to create timer
> based triggers on the fly purely based on them being requested
> (with an appropriate name IIRC)...  Doesn't quite solve your
> problem though as still needs userspace changes.
>>
>> We will split the current design into 3 parts:
>>
>> (1) IIO trigger handling generic part, which offers an API
>>      to register/unregister/get a reference to a trigger type
>>
>> (2) IIO configfs part that gets a reference to a trigger type and
>> handles user requests to create/destroy a trigger.
>>
>> (3) IIO hrtimer driver that use the API at (1) for registering
>> / deregistering a trigger type.
>>
>> Then, each driver in the case that it doesn't have a "real" trigger,
>> will get a reference to a "hrtimer" trigger type and create
>> a new "hrtimer" trigger.
>>
>> Does this look good to you? This could be easily done from
>> userspace, but we will need to modify our userspace applications.
> My initial thought is this really is a job for userspace, as should
> be in most cases connecting up the device specific trigger as well
> (as it's not always the right thing to use).
>
> In the general case it is far from obvious that an hrtimer is the
> right option.  Many usecases would be better off with a sysfs trigger
> or even running off a different interrupt based trigger entirely.
>>
>> Also, handling sampling_frequency/delay would be transparent to
>> applications if we provide this in kernel API.
> Not really as sampling frequency in this case should only be an
> attribute of the trigger, not the device.  We only really allow
> it for the device rather than always the triggers on the basis
> that it has impacts on other device elements (events etc).

Well, if the trigger is directly created from the driver then we will
have a reference to a function that sets its delay.

Each time the user sets the sampling frequency for the device
with hit write_raw and there on IIO_CHAN_INFO_SAMP_FREQ
case we also call set_delay(). Thus we always have have device
sampling frequency in sync with trigger delay.

I know this sounds crazy :) and I don't like it. I am not sure how
to guarantee that device frequency is always in sync with trigger
delay.

>
> Now sensible userspace ought to search for the trigger sysfs
> directory and look there as well.
>
> I suppose if there is an awful lot of demand for this function
> we could add a control knob somewhere that would set a 'default
> trigger type' to be created for buffered devices that haven't
> provided their own...  I'm not overly keen though.
>>

This functionality would be very nice and useful, lets see if we can
find some elegant way to do it.
