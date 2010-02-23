Return-Path: <Barry.Song@analog.com>
From: "Song, Barry" <Barry.Song@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: IIO ring buffer
Date: Tue, 23 Feb 2010 12:11:01 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA05A22824@chinexm1.ad.analog.com>
In-Reply-To: <4B82679F.3000807@cam.ac.uk>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com> <4B82679F.3000807@cam.ac.uk>
To: "Jonathan Cameron" <jic23@cam.ac.uk>
CC: <jic23@hermes.cam.ac.uk>,
	<manuel.stahl@iis.fraunhofer.de>,
	<uclinux-dist-devel@blackfin.uclinux.org>,
	<linux-iio@vger.kernel.org>
List-ID: <linux-iio@vger.kernel.org>

=20

>-----Original Message-----
>From: Jonathan Cameron [mailto:jic23@cam.ac.uk]=20
>Sent: Monday, February 22, 2010 7:17 PM
>To: Song, Barry
>Cc: jic23@hermes.cam.ac.uk; manuel.stahl@iis.fraunhofer.de;=20
>uclinux-dist-devel@blackfin.uclinux.org; linux-iio@vger.kernel.org
>Subject: Re: IIO ring buffer
>
>Hi All,
>
>Just for reference as I'll be doing a proper announcement later.
>We now have linux-iio@vger.kernel.org as a mailing list for=20
>the project.

That's great. Lucky to become the 2nd member.

>Unless others have tracked it down it currently only has me as a member
>though and I'm waiting for confirmation from marc.info of an archive.
>
>> Hi Jonathan,
>> Now users depend on iio ring=20
>events(IIO_EVENT_CODE_RING_50/75/100_FULL)
>> to read data:
>>                 read_size =3D fread(&dat, 1, sizeof(struct
>> iio_event_data),
>>                                   fp_ev);
>>                 switch (dat.id) {
>>                 case IIO_EVENT_CODE_RING_100_FULL:
>>                         toread =3D RingLength;
>>                         break;
>>                 case IIO_EVENT_CODE_RING_75_FULL:
>>                         toread =3D RingLength*3/4;
>>                         break;
>>                 case IIO_EVENT_CODE_RING_50_FULL:
>>                         toread =3D RingLength/2;
>>                         break;
>>                 default:
>>                         printf("Unexpecteded event code\n");
>>                         continue;
>>                 }  =20
>>                 read_size =3D read(fp,
>>                                  data,
>>                                  toread*size_from_scanmode(NumVals,
>> scan_ts));
>>                 if (read_size =3D=3D -EAGAIN) {
>>                         printf("nothing available \n");
>>                         continue;
>>                 }  =20
>> And iio ring access node doesn't support blocking io too. =20
>It seems we
>> lost to let users read data once ring is not empty. And some=20
>users maybe
>> not care about iio ring events at all, but just want to read=20
>data like a
>> input or audio driver. So how about adding the following=20
>support in iio
>> ring:
>> 1. add NOT EMPTY event in IIO event nodes
>Not keen.  It might lead to a storm of events (at least it might in a=20
>cleverer ring buffer implementation or during a blocking=20
>read).  Actually
>in this particular case it probably wouldn't do any harm.
>> 2. add blocking io support in read function of IIO access nodes
>That I agree would be a good idea.  If we support poll/select=20
>on the buffer access
>chrdev then we will get the same effect per having a not empty=20
>event and cleaner
>semantics for anyone not interested in the other events. Not=20
>to mention I expect
>we will soon have alternative ring buffer implementations that=20
>don't supply any
>events at all and hence don't event have the relevant chrdev.

That means 50%, 75%, 100% event will disappear and the ring event node
will disappear too? =20
In fact, I doesn't understand the original purpose for those events. To
support HW ring buffer
notification to users?

>
>As things are, you can quite happily read whenever you like. =20
>Now you mention it,
>that example code is somewhat missleading! The issue with
>this ring buffer implementation is the handling of a true=20
>blocking read is complex
>as at any given time you aren't guaranteed to get what you=20
>asked for even if it was
>there when you started the read. It should be possible to work=20
>around that though.
>
>It's possible this functionality might be better added to an=20
>alternative ring buffer
>implementation. Be vary wary of that ring implementation in=20
>general! I am and I wrote it.

Then I will not begin to add any new feature in current ring buffer.=20

>> If you agree with that, I can begin to add these and send=20
>you a patch.
>> And a problem I don't know is what you and other people have=20
>changed to
>> Greg's staging tree, and I am not sure what tree the patch should be
>> againest.=20
>Nothing has changed in this region of the code.  In fact I=20
>think all that
>has gone into Greg's tree is a clean up patch form Mark Brown=20
>making a few
>functions static. Right now I'm still getting the max1363 driver into
>a state where it will be possible to do the ABI changes.
>>=20
>> For long term plan, is it possible for ring common level to=20
>handle more
>> common work to avoid code repeating in different drivers?
>I'm certainly happy for that to be the case if it becomes=20
>apparent which functionality
>is shared.  I haven't seen any substantial cases as yet, but=20
>then I may well be missing
>things so feel free to submit suggestions (or as ever the=20
>better option of patches).

If possibe, the SW ring buffer can hide more details. Users only need to
do two things in drivers:
1. register device with ring support.
2. push data to ring in the interrupt bottom half.
And even though some devices have HW ring, it is maybe not needed to
export any detail to users at all.=20
It only means the driver developpers use a different way to read data
from HW and push data to SW ring.
To users, all can be SW rings. I am not sure whether it will be better
for an architecture.

>
>Thanks,
>
>Jonathan
>
>
