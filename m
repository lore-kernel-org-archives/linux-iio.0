Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54044 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbbDIRSa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 13:18:30 -0400
Message-ID: <5526B464.8000502@kernel.org>
Date: Thu, 09 Apr 2015 18:18:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Joel Becker <jlbec@evilplan.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, patrick.porlan@intel.com,
	adriana.reus@intel.com
Subject: Re: [PATCH v3 1/3] iio: configfs: Add configfs support to IIO
References: <1428329889-18335-1-git-send-email-daniel.baluta@intel.com>	<1428329889-18335-2-git-send-email-daniel.baluta@intel.com> <CAEnQRZAijAtRdqke5tP-DFL8ROvnzimBEbHwr1=JxhAaqoCndw@mail.gmail.com>
In-Reply-To: <CAEnQRZAijAtRdqke5tP-DFL8ROvnzimBEbHwr1=JxhAaqoCndw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/15 14:30, Daniel Baluta wrote:
> On Mon, Apr 6, 2015 at 5:18 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
>> This module is the core of IIO configfs. It creates the "iio" subsystem under
>> configfs mount point root, with one default group for "triggers".
>>
>> It offers basic interface for registering software trigger types. Next patches
>> will add "hrtimer" and "sysfs" trigger types. To add a new trigger type we must
>> create a new kernel module which implements iio_configfs_trigger.h interface.
>>
>> See Documentation/iio/iio_configfs.txt for more details on how configfs
>> support for IIO works.
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> 
> Hi all,
> 
> I also need your feedback on the following problem.
> 
> We would like to be able to create hrtimer triggers from within
> a kernel module. There are cases where we don't have an interrupt
> pin or the interrupt pin is not connected, and we would like
> that applications to run unmodified with these types of sensors too.
A reasonable aim perhaps, as opposed to locally implemented polling
all over the place (which should definitely not happen).

An alternative the zio guys used was to create timer
based triggers on the fly purely based on them being requested
(with an appropriate name IIRC)...  Doesn't quite solve your
problem though as still needs userspace changes.
> 
> We will split the current design into 3 parts:
> 
> (1) IIO trigger handling generic part, which offers an API
>      to register/unregister/get a reference to a trigger type
> 
> (2) IIO configfs part that gets a reference to a trigger type and
> handles user requests to create/destroy a trigger.
> 
> (3) IIO hrtimer driver that use the API at (1) for registering
> / deregistering a trigger type.
> 
> Then, each driver in the case that it doesn't have a "real" trigger,
> will get a reference to a "hrtimer" trigger type and create
> a new "hrtimer" trigger.
> 
> Does this look good to you? This could be easily done from
> userspace, but we will need to modify our userspace applications.
My initial thought is this really is a job for userspace, as should
be in most cases connecting up the device specific trigger as well
(as it's not always the right thing to use).

In the general case it is far from obvious that an hrtimer is the
right option.  Many usecases would be better off with a sysfs trigger
or even running off a different interrupt based trigger entirely.
> 
> Also, handling sampling_frequency/delay would be transparent to
> applications if we provide this in kernel API.
Not really as sampling frequency in this case should only be an
attribute of the trigger, not the device.  We only really allow
it for the device rather than always the triggers on the basis
that it has impacts on other device elements (events etc).

Now sensible userspace ought to search for the trigger sysfs
directory and look there as well.

I suppose if there is an awful lot of demand for this function
we could add a control knob somewhere that would set a 'default
trigger type' to be created for buffered devices that haven't
provided their own...  I'm not overly keen though.
> 
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

