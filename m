Return-Path: <Barry.Song@analog.com>
From: "Song, Barry" <Barry.Song@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [Uclinux-dist-devel] IIO ring buffer
Date: Wed, 24 Feb 2010 14:48:15 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA05A5BE65@chinexm1.ad.analog.com>
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA05A5BE40@chinexm1.ad.analog.com>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com><4B82679F.3000807@cam.ac.uk><0F1B54C89D5F954D8535DB252AF412FA05A22824@chinexm1.ad.analog.com><4B83BF9E.9010208@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA05A5BE40@chinexm1.ad.analog.com>
To: "Song, Barry" <Barry.Song@analog.com>,
	"Jonathan Cameron" <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>,
	<uclinux-dist-devel@blackfin.uclinux.org>,
	<manuel.stahl@iis.fraunhofer.de>,
	<jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

=20

>-----Original Message-----
>From: uclinux-dist-devel-bounces@blackfin.uclinux.org=20
>[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On=20
>Behalf Of Song, Barry
>Sent: Wednesday, February 24, 2010 2:43 PM
>To: Jonathan Cameron
>Cc: linux-iio@vger.kernel.org;=20
>uclinux-dist-devel@blackfin.uclinux.org;=20
>manuel.stahl@iis.fraunhofer.de; jic23@hermes.cam.ac.uk
>Subject: Re: [Uclinux-dist-devel] IIO ring buffer
>
>
>=20
>
>>-----Original Message-----
>>From: Jonathan Cameron [mailto:jic23@cam.ac.uk]=20
>>Sent: Tuesday, February 23, 2010 7:45 PM
>>To: Song, Barry
>>Cc: jic23@hermes.cam.ac.uk; manuel.stahl@iis.fraunhofer.de;=20
>>uclinux-dist-devel@blackfin.uclinux.org; linux-iio@vger.kernel.org
>>Subject: Re: IIO ring buffer
>>
>>Hi Barry,
>>>>
>>>> Just for reference as I'll be doing a proper announcement later.
>>>> We now have linux-iio@vger.kernel.org as a mailing list for=20
>>>> the project.
>>>=20
>>> That's great. Lucky to become the 2nd member.
>>Welcome :)
>>>=20
>>>> Unless others have tracked it down it currently only has me=20
>>as a member
>>>> though and I'm waiting for confirmation from marc.info of=20
>>an archive.
>>>>
>>>>> Hi Jonathan,
>>>>> Now users depend on iio ring=20
>>>> events(IIO_EVENT_CODE_RING_50/75/100_FULL)
>>>>> to read data:
>>>>>                 read_size =3D fread(&dat, 1, sizeof(struct
>>>>> iio_event_data),
>>>>>                                   fp_ev);
>>>>>                 switch (dat.id) {
>>>>>                 case IIO_EVENT_CODE_RING_100_FULL:
>>>>>                         toread =3D RingLength;
>>>>>                         break;
>>>>>                 case IIO_EVENT_CODE_RING_75_FULL:
>>>>>                         toread =3D RingLength*3/4;
>>>>>                         break;
>>>>>                 case IIO_EVENT_CODE_RING_50_FULL:
>>>>>                         toread =3D RingLength/2;
>>>>>                         break;
>>>>>                 default:
>>>>>                         printf("Unexpecteded event code\n");
>>>>>                         continue;
>>>>>                 }  =20
>>>>>                 read_size =3D read(fp,
>>>>>                                  data,
>>>>>                                 =20
>toread*size_from_scanmode(NumVals,
>>>>> scan_ts));
>>>>>                 if (read_size =3D=3D -EAGAIN) {
>>>>>                         printf("nothing available \n");
>>>>>                         continue;
>>>>>                 }  =20
>>>>> And iio ring access node doesn't support blocking io too. =20
>>>> It seems we
>>>>> lost to let users read data once ring is not empty. And some=20
>>>> users maybe
>>>>> not care about iio ring events at all, but just want to read=20
>>>> data like a
>>>>> input or audio driver. So how about adding the following=20
>>>> support in iio
>>>>> ring:
>>>>> 1. add NOT EMPTY event in IIO event nodes
>>>> Not keen.  It might lead to a storm of events (at least it=20
>>might in a=20
>>>> cleverer ring buffer implementation or during a blocking=20
>>>> read).  Actually
>>>> in this particular case it probably wouldn't do any harm.
>>>>> 2. add blocking io support in read function of IIO access nodes
>>>> That I agree would be a good idea.  If we support poll/select=20
>>>> on the buffer access
>>>> chrdev then we will get the same effect per having a not empty=20
>>>> event and cleaner
>>>> semantics for anyone not interested in the other events. Not=20
>>>> to mention I expect
>>>> we will soon have alternative ring buffer implementations that=20
>>>> don't supply any
>>>> events at all and hence don't event have the relevant chrdev.
>>>=20
>>> That means 50%, 75%, 100% event will disappear and the ring=20
>>event node
>>> will disappear too? =20
>>> In fact, I doesn't understand the original purpose for those=20
>>events. To
>>> support HW ring buffer
>>> notification to users?
>>Partly for hardware events and partly because the 50% full type events
>>are what I needed. If we were to use a chrdev on which we could select
>>then where would you set that boundary?  The only place it makes sense
>>to set it is the 'is there anything in the buffer point'.   In a block
>>based type algorithm running on the data on top (or for that matter
>>writing to external flash etc) we really don't care if there is one
>>set of readings in there. We are only interested once there are a lot
>>more and would like to be doing other things in the meantime.=20
>>Thus no they don't go away unless we can find better semantics for
>>everything they tell us (and I'm open to suggestions).  Note that it
>>may be very hard / impossible for userspace to 'know' what is=20
>>a sensible
>>interval to wait for a decent amount of data to be in the ring=20
>>buffer and
>>for it hence to be sensible to do a read as the trigger events may
>>vary enormously.=20
>>>>
>>>> As things are, you can quite happily read whenever you like. =20
>>>> Now you mention it,
>>>> that example code is somewhat missleading! The issue with
>>>> this ring buffer implementation is the handling of a true=20
>>>> blocking read is complex
>>>> as at any given time you aren't guaranteed to get what you=20
>>>> asked for even if it was
>>>> there when you started the read. It should be possible to work=20
>>>> around that though.
>>>>
>>>> It's possible this functionality might be better added to an=20
>>>> alternative ring buffer
>>>> implementation. Be vary wary of that ring implementation in=20
>>>> general! I am and I wrote it.
>>>=20
>>> Then I will not begin to add any new feature in current ring buffer.
>>Cool, though beware it may be some time until a better option is in
>>place and all the 'kinks' have been ironed out. This area is=20
>definitely
>>the biggest target left in the todo list! If nothing else I want to
>>experiment with buffers based on kfifo and the lockless buffer=20
>>that came
>>out of tracing.  In their raw form neither of these provides us with
>>these sort of events anyway and as such won't have event chrdevs.
>>>=20
>>>>> If you agree with that, I can begin to add these and send=20
>>>> you a patch.
>>>>> And a problem I don't know is what you and other people have=20
>>>> changed to
>>>>> Greg's staging tree, and I am not sure what tree the patch=20
>>should be
>>>>> againest.=20
>>>> Nothing has changed in this region of the code.  In fact I=20
>>>> think all that
>>>> has gone into Greg's tree is a clean up patch form Mark Brown=20
>>>> making a few
>>>> functions static. Right now I'm still getting the max1363=20
>>driver into
>>>> a state where it will be possible to do the ABI changes.
>>>>>
>>>>> For long term plan, is it possible for ring common level to=20
>>>> handle more
>>>>> common work to avoid code repeating in different drivers?
>>>> I'm certainly happy for that to be the case if it becomes=20
>>>> apparent which functionality
>>>> is shared.  I haven't seen any substantial cases as yet, but=20
>>>> then I may well be missing
>>>> things so feel free to submit suggestions (or as ever the=20
>>>> better option of patches).
>>>=20
>>> If possibe, the SW ring buffer can hide more details. Users=20
>>only need to
>>> do two things in drivers:
>>> 1. register device with ring support.
>>> 2. push data to ring in the interrupt bottom half.
>>> And even though some devices have HW ring, it is maybe not needed to
>>> export any detail to users at all.=20
>>> It only means the driver developpers use a different way to=20
>read data
>>> from HW and push data to SW ring.
>>> To users, all can be SW rings. I am not sure whether it will=20
>>be better
>>> for an architecture.
>>The only other interactions in there at the moment are:
>>1. The ability to grab data from the ring when a direct=20
>>channel read is made
>>   from the sysfs interface.  This is optional and device=20
>>specific anyway.
>>2. The ability to control which elements are being buffered. =20
>>Again this is
>>   optional. Here the only interaction is making appropriate=20
>>changes to the
>>   ring buffer allocation. This is really there for reasons of=20
>>semantics.
>>   To a user it makes more sense to request a buffer to take=20
>>say 1000 'scans'
>>   of channels 1,3 and 5 than to directly control the ring=20
>buffer size.
>>   This could probably move into the userspace library once=20
>>the new ABI is in
>>   place though I haven't thought that option through completely yet.
>>3. All the preenable, post enable etc.  Yes, in some cases=20
>>these could move into
>>   the core, but I've run into enough device specific quirks=20
>>that we will probably
>>   need these hooks to be available, even if one normally just=20
>>leaves them undefined
>>   and hence gets the default.  I think for these we leave it=20
>>in the driver for a now and
>>   do the change as a refactoring once we have enough drivers=20
>>with the same code
>>   to justify what goes in the default.
>>
>>So as far as I can see only point 3 could sensibly be merged=20
>>with the core and that
>>not yet.  The first two are handy features that require more=20
>>'hooks' but they certainly
>>aren't obligatory.
>>
>>As for the all rings are software approach, this may make=20
>>sense, but I'm not inclined
>>to move that way until we have a decent range of software=20
>>rings in place.  Right now
>>for the sca3000 driver, the ring buffer is substantial,=20
>>reliable and if we don't want
>>all the data, leaving it on chip will minimize the bus=20
>>traffic. (given how slow the i2c
>>bus for that chip is, this can be important!)
>Another possible problem is the current scan mask is maybe not too
>common. Some devices can't support n functions to work at the=20
>same time,
>but can only support 1 from n or m from n. So sometimes mask=20
>setting can
>be illegal to real hardware.
>For example, the ADE7753, sampling data can be only one of Channel 1,
>Channel 2, or the active power signal. For this kind of cases, IIO will
>let userspace to manage the mask? I mean if users want to use channel2,
>users must disable channel 1 and "active power signal", then enable
>channel 2? IIO core will not do any check about users' mask setting?

If possible, could we add a callback in:
static inline int iio_scan_mask_set(struct iio_dev *dev_info, int bit)
{
        if (bit > IIO_MAX_SCAN_LENGTH)
                return -EINVAL;
        dev_info->scan_mask |=3D (1 << bit);
        dev_info->scan_count++;
        return 0;
};
Like this:
static inline int iio_scan_mask_set(struct iio_dev *dev_info, int bit)
{
        if (bit > IIO_MAX_SCAN_LENGTH)
                return -EINVAL;
+        if (dev_info->ops->scan_mask_set)
+	dev_info->ops->scan_mask_set(struct iio_dev *dev_info, int bit);
+        else {
        	dev_info->scan_mask |=3D (1 << bit);
        	dev_info->scan_count++;
+        }
        return 0;
};
Or other way?

>
>>
>>Jonathan
>>
>>
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel@blackfin.uclinux.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
