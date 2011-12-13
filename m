Return-Path: <jic23@hermes.cam.ac.uk>
Date: 13 Dec 2011 08:48:08 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Greg KH <gregkh@suse.de>
Cc: Greg KH <greg@kroah.com>, Lars-Peter Clausen <lars@metafoo.de>,
    Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
    linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Setup buffer access functions when allocating
 the buffer
Message-ID: <Prayer.1.3.4.1112130848080.6245@hermes-2.csi.cam.ac.uk>
In-Reply-To: <20111213073831.GB20154@suse.de>
References: <1323684545-11188-1-git-send-email-lars@metafoo.de>
 <20111213004659.GB11553@kroah.com>
 <8847cb76-be5b-41d3-b893-968bb9cb937a@email.android.com>
 <20111213073831.GB20154@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Dec 13 2011, Greg KH wrote:

>On Tue, Dec 13, 2011 at 07:23:48AM +0000, Jonathan Cameron wrote:
>> 
>> 
>> Greg KH <greg@kroah.com> wrote:
>> 
>> >On Mon, Dec 12, 2011 at 11:09:05AM +0100, Lars-Peter Clausen wrote:
>> >> Setup the buffer access functions in the buffer allocate function.
>> >There is no
>> >> need to let each driver handle this on its own.
>> >
>> >That's nicer.
>> >
>> >So, you have different ways to have "buffers" and the driver doesn't
>> >know what type you have, and it's chosen at build time?  Why are you
>> >making the kernel builder make such a decision?  Why not just pick one,
>> >that you know works well, and use it?
>> >
>> >You would get rid of a whole level of indirection that I really don't
>> >think you need at all, right?
>> 
>> Because there is not currently a buffer that suits all use cases.
>> One might be possible but would involve autoswitching between
>> different approaches a hence have this indirection anyway, be it
>> burried. Also note that some of the buffers are hardware.  Plus the
>> pseudo buffer used for in kernel push interfaces is different again.
>> That code has only reached RFC state so far.
>
>So who choses the buffer type, the driver, or the kernel configurator,
>or something else?
The driver picks a default (and often only) implementation (or the writer
does anyway - this will get reviewed with the code submission).

Iff there are two usecases requiring different buffer implementations,
then the driver picks the default (or Kconfig settings do anyway).  There
is the option of doing at at runtime, but we haven't yet had a usecase
demanding it.  The cases where a particular implementation is needed that
isn't the default will tend to be weird high performance stuff, so in those
cases it's typically a hand crafted kernel anyway.  Kernel configurator
should normally go with the default (unless he knows he is configuring for
a class of application where the alternative makes sense).

To be honest, the biggest gain from these abstractions so far haven't
really been these but:
1) Ability to push in new implementations - I'm not happy with ring_sw for
starters + we don't have anything that handles really high volumes of data
in there yet. The few drivers that currently allow switching are mainly there
so I can hammer the different buffers and verify they work against the same
userspace code.
2) The abstraction is needed anyway to handle the fact we have multiple data
paths in the new code to do in kernel interfaces (the demux stuff you merged
the other day was step one of that).  That works by having a list of buffers
into which the demux unit pushes the data they are wanting. Buffers is a
loose term.  Maybe data sinks is better for those uses.

Saying that the road map in my head and the stuff Analog are working on
both require considerably more sophisticated buffers for some use cases.
>
>> >Make a decision, don't force someone else to make it for you...
>> Defaults are sensible. Preventing other peoples use cases are not.
>
>Ok, but you do agree that this patch is broken as-is, right?
Not sure I do.  I admit it isn't a patch I really cared about either way,
but it is just providing a trivial bit of boiler plate removal.
The buffer allocation and access functions are always pared and all I see
here is moving the access funcs bit inside the allocation call?

Perhaps I have missunderstood what you don't like?
>
>thanks,
>
>greg k-h
>
