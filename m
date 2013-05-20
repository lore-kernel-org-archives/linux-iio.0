Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:33925 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab3ETB1j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 May 2013 21:27:39 -0400
Received: by mail-ea0-f173.google.com with SMTP id n15so3549248ead.4
        for <linux-iio@vger.kernel.org>; Sun, 19 May 2013 18:27:35 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: Abstracting and extending evdev to work with the iio subsystem
From: Alessandro Osima <alex.osima@gmail.com>
In-Reply-To: <518E5339.3090006@kernel.org>
Date: Mon, 20 May 2013 03:27:19 +0200
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Hunyue Yau <hy-gsoc@hy-research.com>
Message-Id: <E8A906FB-968B-4311-BBE4-C98359CE4027@gmail.com>
References: <CAOTW74kb_qJP=by_iKOTCHVurh2wEc6nfmdL-F2ddqq3aQ672g@mail.gmail.com> <51836C28.4050806@metafoo.de> <62B3B14C-0FFA-4914-9CD0-B4D5742780C7@gmail.com> <518E5339.3090006@kernel.org>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan.

I’m very thankful for your attention and for the time you spent reading and commenting my application.
> Note that we do have the ability (though the driver hasn't merged yet
> mainly because I got distracted) to have a fully fledged input driver
> running as a client of IIO.
> Also a lot of what you are focusing on in your description seems to be that
> IIO uses sysfs to provide access to the various data channels on a device.
> 
> Note that is only one option so please take a close
> look at the buffered methods as they are much closer to evdev but with
> rather less overhead.  In fact early discussions that lead to IIO
> focused on the fact that for high performance we would want to loose
> the overhead of labeling every event.
> 
> As it is we have one dev file per iio device - though events are accessed
> via an anonymous file descriptor obtained from the buffer access file that
> sits under /dev (note there was quite a lot of pressure to not have multiple
> files in dev for a single physical device).
> The sysfs stuff then acts as a description of what is coming out
> of the device (to take it out of band and hence loose the overhead of
> constantly describing the data).  Now I agree there are plenty
> of usecases where evdev type interfaces make sense - such as actual
> events (rather than consistent data streams).
Ooops, I  looked at the files in /staging/iio but I missed it, I'll read it as soon as possible.

> If you do want to do that you'll want to use a very similar approach to the iio-input driver to get access to the
> main data flow 
Yes, I am planing to follow the iio-input approach.
When IIO register a device with it evdev will register as that device consumer to tap into the iio data stream.
The data read from a device channels can then be translated to their input EV_* counterparts and handled as normal input events.

> and come up with something similar for what are termed
> 'events' in IIO (threshold type interrupts sources).
The iio events handling is a bit harder to do since there is no way (that I know of) to recover pushed events from outside of iio inside the kernel.

A possible approach is to extend the iio consumer interface to handle events.
Evdev can register a callback function for all the events sent by a device.
When an event is pushed from that device the callback function will be called with the type of event that was pushed as an argument.
Evdev will then report these events to userspace. 
This approach can be useful for other subsystems interested in receiving iio events, but may be quite tricky to implement.

Another option is to have a general evdev_event function that can be used by a subsystem to report events to evdev:

int evdev_event(struct evdev * device, void * event);

The variable "event" is declared as a void * so that this function can remain subsystem-agnostic.
Evedev will recognise the type of subsystem using a "type" variable stored in the evdev  struct and cast/handle the void * pointer accordingly.
The evdev structure (and consequently the subsystem handling a driver) type is set during registration.
IIO will have to be be modified so that every time an event is pushed on an evedev-registered driver this function is called with the pushed event.

Both solutions will require to add new entries to the evdev userspace interface (/uapi/input.h) to handle iio events.

I'm a bit uncertain about which of this two solution is the best one, I'd love to know your opinion on it.

> Good luck
Thanks !!!! 
I'll keep you up to date on my work.

Regards,
Alessandro Osima.

On May 11, 2013, at 4:18 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> Hi Alessandro,
> 
> Note that we do have the ability (though the driver hasn't merged yet
> mainly because I got distracted) to have a fully fledged input driver
> running as a client of IIO.
> Also a lot of what you are focusing on in your description seems to be that
> IIO uses sysfs to provide access to the various data channels on a device.
> 
> Note that is only one option so please take a close
> look at the buffered methods as they are much closer to evdev but with
> rather less overhead.  In fact early discussions that lead to IIO
> focused on the fact that for high performance we would want to loose
> the overhead of labeling every event.
> 
> As it is we have one dev file per iio device - though events are accessed
> via an anonymous file descriptor obtained from the buffer access file that
> sits under /dev (note there was quite a lot of pressure to not have multiple
> files in dev for a single physical device).
> 
> The sysfs stuff then acts as a description of what is coming out
> of the device (to take it out of band and hence loose the overhead of
> constantly describing the data).  Now I agree there are plenty
> of usecases where evdev type interfaces make sense - such as actual
> events (rather than consistent data streams).  Whether it makes sense
> from a userspace point of view to have a generalized ev dev or instead
> a means of making relevant devices run through input is not clear to me.
> 
> Now the IIO event interface (not used for the primary data flow) is
> clunky (and loosely based on evdev) so there may be more scope there.
> Note however that as things stand IIO events do not carry data.  They
> merely indicate events like a threshold being crossed.  This is again
> rather different from typical evdev usage. (it's been a while since
> I last looked at evdev so I may have missremembered some of the details!)
> 
> So I'd favour some work on the events side of IIO and how that could
> make use of a generalized evdev but am unsure of whether evdev would make
> sense for more general IIO usage.  If you do want to do that you'll want
> to use a very similar approach to the iio-input driver to get access to the
> main data flow and come up with something similar for what are termed
> 'events' in IIO (threshold type interrupts sources).
> 
> Good luck
> 
> Jonathan
> 
> On 05/06/2013 11:47 PM, Alessandro Osima wrote:
>> Hello Lars.
>> 
>> Thank you for your interest and sorry for the late answer.
>> 
>> When I posted the proposal I was still studying the event interface, so I decided not to add it as a possible use case yet. 
>> I believe an input abstracted evdev would allow the creation of a more flexible and simpler to use event interface.
>> Every event generated by a device could be broadcasted trough a single file in /dev (created by the abstracted evdev) and read by an application with the help of an header file describing the new event interface (like input currently does with evdev and input.h).
>> This approach will allow to have an event interface that's simpler to use for an userspace app because instead of reading N sysfs files concurrently the app will have to read just one file in /dev and then handle the events received with something like a switch statement. 
>> Input abstracted evdev will help by creating the /dev file and forwarding the file_operations on that file to iio. 
>> I have added a bit more detailed explanations on my proposal.
>> 
>> This is just an idea, I'm looking for your feedbacks to make it better.
>> 
>> Regards,
>> Alessandro Osima
>> 
>> On May 3, 2013, at 9:50 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> 
>>> On 04/30/2013 04:24 AM, alessandro osima wrote:
>>>> Hello everyone, my name is  Alessandro Osima and I'm a computer
>>>> science student at Università degli Studi di Milano, Italy (second
>>>> year, equivalent to bachelor).
>>>> 
>>>> 
>>>> For this year's Google Summer of Code I have decided to submit an
>>>> application proposal focused on abstracting evdev  from input to allow
>>>> iio and other subsystems to take advantage of it to send/receive
>>>> events and data to userspace application troughout files located in
>>>> the /dev directory.
>>>> 
>>>> This http://www.google-melange.com/gsoc/proposal/review/google/gsoc2013/asion/1#
>>>> is my proposal.
>>>> 
>>>> I would kindly ask your opinions about this project and would be very
>>>> grateful for any comments and suggestion to improve it.
>>>> 
>>> 
>>> Hi,
>>> 
>>> Sounds interesting. Did you hd a look at the existing IIO event interface
>>> (drivers/iio/industrialio-event.c)? I'm asking because you don't seem to
>>> mention it in your proposal.
>>> 
>>> - Lars
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 

