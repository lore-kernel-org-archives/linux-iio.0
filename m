Return-Path: <jic23@cam.ac.uk>
Message-ID: <4B83BF9E.9010208@cam.ac.uk>
Date: Tue, 23 Feb 2010 11:44:30 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Song, Barry" <Barry.Song@analog.com>
CC: jic23@hermes.cam.ac.uk, manuel.stahl@iis.fraunhofer.de,
 uclinux-dist-devel@blackfin.uclinux.org, linux-iio@vger.kernel.org
Subject: Re: IIO ring buffer
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com> <4B82679F.3000807@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA05A22824@chinexm1.ad.analog.com>
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA05A22824@chinexm1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Barry,
>>
>> Just for reference as I'll be doing a proper announcement later.
>> We now have linux-iio@vger.kernel.org as a mailing list for 
>> the project.
> 
> That's great. Lucky to become the 2nd member.
Welcome :)
> 
>> Unless others have tracked it down it currently only has me as a member
>> though and I'm waiting for confirmation from marc.info of an archive.
>>
>>> Hi Jonathan,
>>> Now users depend on iio ring 
>> events(IIO_EVENT_CODE_RING_50/75/100_FULL)
>>> to read data:
>>>                 read_size = fread(&dat, 1, sizeof(struct
>>> iio_event_data),
>>>                                   fp_ev);
>>>                 switch (dat.id) {
>>>                 case IIO_EVENT_CODE_RING_100_FULL:
>>>                         toread = RingLength;
>>>                         break;
>>>                 case IIO_EVENT_CODE_RING_75_FULL:
>>>                         toread = RingLength*3/4;
>>>                         break;
>>>                 case IIO_EVENT_CODE_RING_50_FULL:
>>>                         toread = RingLength/2;
>>>                         break;
>>>                 default:
>>>                         printf("Unexpecteded event code\n");
>>>                         continue;
>>>                 }   
>>>                 read_size = read(fp,
>>>                                  data,
>>>                                  toread*size_from_scanmode(NumVals,
>>> scan_ts));
>>>                 if (read_size == -EAGAIN) {
>>>                         printf("nothing available \n");
>>>                         continue;
>>>                 }   
>>> And iio ring access node doesn't support blocking io too.  
>> It seems we
>>> lost to let users read data once ring is not empty. And some 
>> users maybe
>>> not care about iio ring events at all, but just want to read 
>> data like a
>>> input or audio driver. So how about adding the following 
>> support in iio
>>> ring:
>>> 1. add NOT EMPTY event in IIO event nodes
>> Not keen.  It might lead to a storm of events (at least it might in a 
>> cleverer ring buffer implementation or during a blocking 
>> read).  Actually
>> in this particular case it probably wouldn't do any harm.
>>> 2. add blocking io support in read function of IIO access nodes
>> That I agree would be a good idea.  If we support poll/select 
>> on the buffer access
>> chrdev then we will get the same effect per having a not empty 
>> event and cleaner
>> semantics for anyone not interested in the other events. Not 
>> to mention I expect
>> we will soon have alternative ring buffer implementations that 
>> don't supply any
>> events at all and hence don't event have the relevant chrdev.
> 
> That means 50%, 75%, 100% event will disappear and the ring event node
> will disappear too?  
> In fact, I doesn't understand the original purpose for those events. To
> support HW ring buffer
> notification to users?
Partly for hardware events and partly because the 50% full type events
are what I needed. If we were to use a chrdev on which we could select
then where would you set that boundary?  The only place it makes sense
to set it is the 'is there anything in the buffer point'.   In a block
based type algorithm running on the data on top (or for that matter
writing to external flash etc) we really don't care if there is one
set of readings in there. We are only interested once there are a lot
more and would like to be doing other things in the meantime. 
Thus no they don't go away unless we can find better semantics for
everything they tell us (and I'm open to suggestions).  Note that it
may be very hard / impossible for userspace to 'know' what is a sensible
interval to wait for a decent amount of data to be in the ring buffer and
for it hence to be sensible to do a read as the trigger events may
vary enormously. 
>>
>> As things are, you can quite happily read whenever you like.  
>> Now you mention it,
>> that example code is somewhat missleading! The issue with
>> this ring buffer implementation is the handling of a true 
>> blocking read is complex
>> as at any given time you aren't guaranteed to get what you 
>> asked for even if it was
>> there when you started the read. It should be possible to work 
>> around that though.
>>
>> It's possible this functionality might be better added to an 
>> alternative ring buffer
>> implementation. Be vary wary of that ring implementation in 
>> general! I am and I wrote it.
> 
> Then I will not begin to add any new feature in current ring buffer.
Cool, though beware it may be some time until a better option is in
place and all the 'kinks' have been ironed out. This area is definitely
the biggest target left in the todo list! If nothing else I want to
experiment with buffers based on kfifo and the lockless buffer that came
out of tracing.  In their raw form neither of these provides us with
these sort of events anyway and as such won't have event chrdevs.
> 
>>> If you agree with that, I can begin to add these and send 
>> you a patch.
>>> And a problem I don't know is what you and other people have 
>> changed to
>>> Greg's staging tree, and I am not sure what tree the patch should be
>>> againest. 
>> Nothing has changed in this region of the code.  In fact I 
>> think all that
>> has gone into Greg's tree is a clean up patch form Mark Brown 
>> making a few
>> functions static. Right now I'm still getting the max1363 driver into
>> a state where it will be possible to do the ABI changes.
>>>
>>> For long term plan, is it possible for ring common level to 
>> handle more
>>> common work to avoid code repeating in different drivers?
>> I'm certainly happy for that to be the case if it becomes 
>> apparent which functionality
>> is shared.  I haven't seen any substantial cases as yet, but 
>> then I may well be missing
>> things so feel free to submit suggestions (or as ever the 
>> better option of patches).
> 
> If possibe, the SW ring buffer can hide more details. Users only need to
> do two things in drivers:
> 1. register device with ring support.
> 2. push data to ring in the interrupt bottom half.
> And even though some devices have HW ring, it is maybe not needed to
> export any detail to users at all. 
> It only means the driver developpers use a different way to read data
> from HW and push data to SW ring.
> To users, all can be SW rings. I am not sure whether it will be better
> for an architecture.
The only other interactions in there at the moment are:
1. The ability to grab data from the ring when a direct channel read is made
   from the sysfs interface.  This is optional and device specific anyway.
2. The ability to control which elements are being buffered.  Again this is
   optional. Here the only interaction is making appropriate changes to the
   ring buffer allocation. This is really there for reasons of semantics.
   To a user it makes more sense to request a buffer to take say 1000 'scans'
   of channels 1,3 and 5 than to directly control the ring buffer size.
   This could probably move into the userspace library once the new ABI is in
   place though I haven't thought that option through completely yet.
3. All the preenable, post enable etc.  Yes, in some cases these could move into
   the core, but I've run into enough device specific quirks that we will probably
   need these hooks to be available, even if one normally just leaves them undefined
   and hence gets the default.  I think for these we leave it in the driver for a now and
   do the change as a refactoring once we have enough drivers with the same code
   to justify what goes in the default.

So as far as I can see only point 3 could sensibly be merged with the core and that
not yet.  The first two are handy features that require more 'hooks' but they certainly
aren't obligatory.

As for the all rings are software approach, this may make sense, but I'm not inclined
to move that way until we have a decent range of software rings in place.  Right now
for the sca3000 driver, the ring buffer is substantial, reliable and if we don't want
all the data, leaving it on chip will minimize the bus traffic. (given how slow the i2c
bus for that chip is, this can be important!)

Jonathan
