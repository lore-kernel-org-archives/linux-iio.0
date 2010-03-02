Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4B853357.5070500@cam.ac.uk>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com>
	<4B82679F.3000807@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA05A22824@chinexm1.ad.analog.com>
	<4B83BF9E.9010208@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA05A5BE40@chinexm1.ad.analog.com>
	<4B853357.5070500@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Mar 2010 17:57:32 +0800
Message-ID: <3c17e3571003020157rdd35bdpa6811e25301a646f@mail.gmail.com>
Subject: Re: IIO ring buffer
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: jic23@hermes.cam.ac.uk, manuel.stahl@iis.fraunhofer.de,
	uclinux-dist-devel@blackfin.uclinux.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Jonathan,
I know you are changing iio ring buffer. Here a problem to discuss
with you, there are maybe this kind of use cases: the DACs have no
internal clock and buffer, so we need an external bus with continuous
DMA to "play" data flow with constant speed. It is very similar with
alsa driver to play audio by I2S or AC97. ALSA framework is easy to
implement this kind of drivers. But our DACs are not audio cards. Then
in the iio ring buffer core, it seems we also need APIs like
trigger(), pointer(), snd_pcm_period_elapsed()... to get a common
framework. Of course, we can let users to handle blocking in write()
callback like OSS, but alsa-like APIs should be better. So what's your
opinion for that?
If I begin to work on this, I am not sure how much is needed to do to
merge into your new iio ring buffer codes. So if you have some new
codes for reference, it should be better.
Thanks
Barry

On Wed, Feb 24, 2010 at 10:10 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 02/24/10 06:42, Song, Barry wrote:
>>
>>
>>> -----Original Message-----
>>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>>> Sent: Tuesday, February 23, 2010 7:45 PM
>>> To: Song, Barry
>>> Cc: jic23@hermes.cam.ac.uk; manuel.stahl@iis.fraunhofer.de;
>>> uclinux-dist-devel@blackfin.uclinux.org; linux-iio@vger.kernel.org
>>> Subject: Re: IIO ring buffer
>>>
>>> Hi Barry,
>>>>>
>>>>> Just for reference as I'll be doing a proper announcement later.
>>>>> We now have linux-iio@vger.kernel.org as a mailing list for
>>>>> the project.
>>>>
>>>> That's great. Lucky to become the 2nd member.
>>> Welcome :)
>>>>
>>>>> Unless others have tracked it down it currently only has me
>>> as a member
>>>>> though and I'm waiting for confirmation from marc.info of
>>> an archive.
>>>>>
>>>>>> Hi Jonathan,
>>>>>> Now users depend on iio ring
>>>>> events(IIO_EVENT_CODE_RING_50/75/100_FULL)
>>>>>> to read data:
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read_size =
=3D fread(&dat, 1, sizeof(struct
>>>>>> iio_event_data),
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp_ev);
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (dat.=
id) {
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_EVE=
NT_CODE_RING_100_FULL:
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 toread =3D RingLength;
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 break;
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_EVE=
NT_CODE_RING_75_FULL:
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 toread =3D RingLength*3/4;
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 break;
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_EVE=
NT_CODE_RING_50_FULL:
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 toread =3D RingLength/2;
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 break;
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 printf("Unexpecteded event code\n");
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 continue;
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read_size =
=3D read(fp,
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data,
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0toread*size_from_scanmo=
de(NumVals,
>>>>>> scan_ts));
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (read_siz=
e =3D=3D -EAGAIN) {
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 printf("nothing available \n");
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 continue;
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>>> And iio ring access node doesn't support blocking io too.
>>>>> It seems we
>>>>>> lost to let users read data once ring is not empty. And some
>>>>> users maybe
>>>>>> not care about iio ring events at all, but just want to read
>>>>> data like a
>>>>>> input or audio driver. So how about adding the following
>>>>> support in iio
>>>>>> ring:
>>>>>> 1. add NOT EMPTY event in IIO event nodes
>>>>> Not keen. =C2=A0It might lead to a storm of events (at least it
>>> might in a
>>>>> cleverer ring buffer implementation or during a blocking
>>>>> read). =C2=A0Actually
>>>>> in this particular case it probably wouldn't do any harm.
>>>>>> 2. add blocking io support in read function of IIO access nodes
>>>>> That I agree would be a good idea. =C2=A0If we support poll/select
>>>>> on the buffer access
>>>>> chrdev then we will get the same effect per having a not empty
>>>>> event and cleaner
>>>>> semantics for anyone not interested in the other events. Not
>>>>> to mention I expect
>>>>> we will soon have alternative ring buffer implementations that
>>>>> don't supply any
>>>>> events at all and hence don't event have the relevant chrdev.
>>>>
>>>> That means 50%, 75%, 100% event will disappear and the ring
>>> event node
>>>> will disappear too?
>>>> In fact, I doesn't understand the original purpose for those
>>> events. To
>>>> support HW ring buffer
>>>> notification to users?
>>> Partly for hardware events and partly because the 50% full type events
>>> are what I needed. If we were to use a chrdev on which we could select
>>> then where would you set that boundary? =C2=A0The only place it makes s=
ense
>>> to set it is the 'is there anything in the buffer point'. =C2=A0 In a b=
lock
>>> based type algorithm running on the data on top (or for that matter
>>> writing to external flash etc) we really don't care if there is one
>>> set of readings in there. We are only interested once there are a lot
>>> more and would like to be doing other things in the meantime.
>>> Thus no they don't go away unless we can find better semantics for
>>> everything they tell us (and I'm open to suggestions). =C2=A0Note that =
it
>>> may be very hard / impossible for userspace to 'know' what is
>>> a sensible
>>> interval to wait for a decent amount of data to be in the ring
>>> buffer and
>>> for it hence to be sensible to do a read as the trigger events may
>>> vary enormously.
>>>>>
>>>>> As things are, you can quite happily read whenever you like.
>>>>> Now you mention it,
>>>>> that example code is somewhat missleading! The issue with
>>>>> this ring buffer implementation is the handling of a true
>>>>> blocking read is complex
>>>>> as at any given time you aren't guaranteed to get what you
>>>>> asked for even if it was
>>>>> there when you started the read. It should be possible to work
>>>>> around that though.
>>>>>
>>>>> It's possible this functionality might be better added to an
>>>>> alternative ring buffer
>>>>> implementation. Be vary wary of that ring implementation in
>>>>> general! I am and I wrote it.
>>>>
>>>> Then I will not begin to add any new feature in current ring buffer.
>>> Cool, though beware it may be some time until a better option is in
>>> place and all the 'kinks' have been ironed out. This area is definitely
>>> the biggest target left in the todo list! If nothing else I want to
>>> experiment with buffers based on kfifo and the lockless buffer
>>> that came
>>> out of tracing. =C2=A0In their raw form neither of these provides us wi=
th
>>> these sort of events anyway and as such won't have event chrdevs.
>>>>
>>>>>> If you agree with that, I can begin to add these and send
>>>>> you a patch.
>>>>>> And a problem I don't know is what you and other people have
>>>>> changed to
>>>>>> Greg's staging tree, and I am not sure what tree the patch
>>> should be
>>>>>> againest.
>>>>> Nothing has changed in this region of the code. =C2=A0In fact I
>>>>> think all that
>>>>> has gone into Greg's tree is a clean up patch form Mark Brown
>>>>> making a few
>>>>> functions static. Right now I'm still getting the max1363
>>> driver into
>>>>> a state where it will be possible to do the ABI changes.
>>>>>>
>>>>>> For long term plan, is it possible for ring common level to
>>>>> handle more
>>>>>> common work to avoid code repeating in different drivers?
>>>>> I'm certainly happy for that to be the case if it becomes
>>>>> apparent which functionality
>>>>> is shared. =C2=A0I haven't seen any substantial cases as yet, but
>>>>> then I may well be missing
>>>>> things so feel free to submit suggestions (or as ever the
>>>>> better option of patches).
>>>>
>>>> If possibe, the SW ring buffer can hide more details. Users
>>> only need to
>>>> do two things in drivers:
>>>> 1. register device with ring support.
>>>> 2. push data to ring in the interrupt bottom half.
>>>> And even though some devices have HW ring, it is maybe not needed to
>>>> export any detail to users at all.
>>>> It only means the driver developpers use a different way to read data
>>>> from HW and push data to SW ring.
>>>> To users, all can be SW rings. I am not sure whether it will
>>> be better
>>>> for an architecture.
>>> The only other interactions in there at the moment are:
>>> 1. The ability to grab data from the ring when a direct
>>> channel read is made
>>> =C2=A0 from the sysfs interface. =C2=A0This is optional and device
>>> specific anyway.
>>> 2. The ability to control which elements are being buffered.
>>> Again this is
>>> =C2=A0 optional. Here the only interaction is making appropriate
>>> changes to the
>>> =C2=A0 ring buffer allocation. This is really there for reasons of
>>> semantics.
>>> =C2=A0 To a user it makes more sense to request a buffer to take
>>> say 1000 'scans'
>>> =C2=A0 of channels 1,3 and 5 than to directly control the ring buffer s=
ize.
>>> =C2=A0 This could probably move into the userspace library once
>>> the new ABI is in
>>> =C2=A0 place though I haven't thought that option through completely ye=
t.
>>> 3. All the preenable, post enable etc. =C2=A0Yes, in some cases
>>> these could move into
>>> =C2=A0 the core, but I've run into enough device specific quirks
>>> that we will probably
>>> =C2=A0 need these hooks to be available, even if one normally just
>>> leaves them undefined
>>> =C2=A0 and hence gets the default. =C2=A0I think for these we leave it
>>> in the driver for a now and
>>> =C2=A0 do the change as a refactoring once we have enough drivers
>>> with the same code
>>> =C2=A0 to justify what goes in the default.
>>>
>>> So as far as I can see only point 3 could sensibly be merged
>>> with the core and that
>>> not yet. =C2=A0The first two are handy features that require more
>>> 'hooks' but they certainly
>>> aren't obligatory.
>>>
>>> As for the all rings are software approach, this may make
>>> sense, but I'm not inclined
>>> to move that way until we have a decent range of software
>>> rings in place. =C2=A0Right now
>>> for the sca3000 driver, the ring buffer is substantial,
>>> reliable and if we don't want
>>> all the data, leaving it on chip will minimize the bus
>>> traffic. (given how slow the i2c
>>> bus for that chip is, this can be important!)
>> Another possible problem is the current scan mask is maybe not too
>> common. Some devices can't support n functions to work at the same time,
>> but can only support 1 from n or m from n. So sometimes mask setting can
>> be illegal to real hardware.
>> For example, the ADE7753, sampling data can be only one of Channel 1,
>> Channel 2, or the active power signal. For this kind of cases, IIO will
>> let userspace to manage the mask? I mean if users want to use channel2,
>> users must disable channel 1 and "active power signal", then enable
>> channel 2? IIO core will not do any check about users' mask setting?
> This exact issue is why the rewrite of the max1363 driver set is taking m=
e so
> long.
>
> The intention is the following... (this got discussed a few weeks back,
> though it was pre mailing list so I'll cover where we ended up in some de=
pth.
> For reference it was quite a way down in the thread entitled simply IIO t=
hat
> Michael Hennerich started, it's there in an email from the 2/2/2010).
>
> You have identified once of the main problems we ran into when trying to =
work
> out a consistent API for dealing with what I will call 'Scan mode configu=
ration'
> Some devices either provide complete control, or don't have a concept of =
a scan
> at all (in which case we just query the registers corresponding to the re=
adings
> we want, or as in many adc's write the required channel in parallel with =
1 or
> 2 reads before it actually occurs, e.g. ad7949 which I'm currently using =
in a
> baremetal design and hence am far too familiar with :). Some devices
> only allow 'scans' consisting of certain combinations of channels. =C2=A0=
The interface
> that currently exists for the max1363 in mainline is an example of how th=
is
> can be controlled via a rather complex set of sysfs files. =C2=A0As IIO i=
n mainline
> currently stands there are thus 2 approaches for controlling the 'Scan mo=
de'
> of devices, that of the max1363 where we use asci strings and that of eve=
rything
> else where the channels have independent 'enable' sysfs controls.
>
> The 'cunning' plan was to try and unify these before we do the ABI change=
s to
> meet the specification sent out recently. The most adaptable and predicta=
ble
> of the two approaches is the one where every channel is apparently indepe=
ndently
> controlled (i.e. not the max1363 one!)
>
> So as to how this will work,
>
> Userspace sees exactly the same as if all channels were independent from =
the
> point of view of what files exist.
>
> Then the user attempts to set the mask they want, which is matched agains=
t
> an internal set of masks (or a function if you have nice clean cases like=
 above).
> (This requires keeping track of what has been requested).
>
> As each channel is requested we work out which scan mode includes everyth=
ing desired
> and as few as possible other channels.
>
> The userspace library rereads all the scan enable files to find out what
> it actually got, prior to starting the ring up.
>
> Thus say you request channels, 0, 1, 3. =C2=A0The driver (or core in futu=
re) knows that this
> is 'best' served by a scan consisting of 0,1,2,3. =C2=A0Rereading the ind=
ividual enable
> sysfs elements, tells userspace this is what it is actually getting and l=
eaves mangling
> the results to give the desired channels to userspace.
>
> It may make sense in some cases to emulate full hardware mask control (ty=
pically
> 'slow' devices) by munging the data going into the buffer, however this m=
ay be
> costly in time (particularly when we have a device using direct dma into =
the buffer which
> is hopefully going to occur shortly. More to follow on that).
>
> This was the only approach we could come up with in a previous discussion=
 that was
> remotely general from the point of view of a userspace interface. =C2=A0I=
t is a bit
> fiddly, but it covers every possible case.
>
> The intent was to implement it in the max1363 driver first to get more ge=
neral
> opinions based on actual code rather than a description like this one.
> At that point I'll probably add a couple more of the drivers for devices =
that require
> this functionality (several on the desk in front of me) and then do a nic=
e clean
> refactor to move shared functionality into the core. =C2=A0As a general r=
ule, this
> implement in drivers then move into core as appropriate gives a nice clea=
n
> development model.
>
> Thanks,
>
> Jonathan
>
> p.s. Fingers crossed I'll get the bare metal code that has been eating my=
 time out of the
> way shortly and get back to actually testing / finishing implementing the=
 max1363 and
> the follow up api changes!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
