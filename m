Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C065AE1.9090302@cam.ac.uk>
Date: Wed, 02 Jun 2010 14:21:37 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, manuel.stahl@iis.fraunhofer.de,
 jic23@hermes.cam.ac.uk
Subject: Re: [Uclinux-dist-devel] IIO ring buffer
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com> 	<4B82679F.3000807@cam.ac.uk> <AANLkTimmdhiZXBCTVvMNyjdf6n59wrWkLXPY1HkB14-p@mail.gmail.com>
In-Reply-To: <AANLkTimmdhiZXBCTVvMNyjdf6n59wrWkLXPY1HkB14-p@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 06/02/10 09:01, Barry Song wrote:
> On Mon, Feb 22, 2010 at 7:16 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> Hi All,
>>
>> Just for reference as I'll be doing a proper announcement later.
>> We now have linux-iio@vger.kernel.org as a mailing list for the project.
>> Unless others have tracked it down it currently only has me as a member
>> though and I'm waiting for confirmation from marc.info of an archive.
>>
>>> Hi Jonathan,
>>> Now users depend on iio ring events(IIO_EVENT_CODE_RING_50/75/100_FULL)
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
>>> And iio ring access node doesn't support blocking io too.  It seems we
>>> lost to let users read data once ring is not empty. And some users maybe
>>> not care about iio ring events at all, but just want to read data like a
>>> input or audio driver. So how about adding the following support in iio
>>> ring:
>>> 1. add NOT EMPTY event in IIO event nodes
>> Not keen.  It might lead to a storm of events (at least it might in a
>> cleverer ring buffer implementation or during a blocking read).  Actually
>> in this particular case it probably wouldn't do any harm.
>>> 2. add blocking io support in read function of IIO access nodes
>> That I agree would be a good idea.  If we support poll/select on the buffer access
>> chrdev then we will get the same effect per having a not empty event and cleaner
>> semantics for anyone not interested in the other events. Not to mention I expect
>> we will soon have alternative ring buffer implementations that don't supply any
>> events at all and hence don't event have the relevant chrdev.
>>
>> As things are, you can quite happily read whenever you like.  Now you mention it,
>> that example code is somewhat missleading! The issue with
>> this ring buffer implementation is the handling of a true blocking read is complex
>> as at any given time you aren't guaranteed to get what you asked for even if it was
>> there when you started the read. It should be possible to work around that though.
>>
>> It's possible this functionality might be better added to an alternative ring buffer
>> implementation. Be vary wary of that ring implementation in general! I am and I wrote it.
>>> If you agree with that, I can begin to add these and send you a patch.
>>> And a problem I don't know is what you and other people have changed to
>>> Greg's staging tree, and I am not sure what tree the patch should be
>>> againest.
>> Nothing has changed in this region of the code.  In fact I think all that
>> has gone into Greg's tree is a clean up patch form Mark Brown making a few
>> functions static. Right now I'm still getting the max1363 driver into
>> a state where it will be possible to do the ABI changes.
>>>
>>> For long term plan, is it possible for ring common level to handle more
>>> common work to avoid code repeating in different drivers?
>> I'm certainly happy for that to be the case if it becomes apparent which functionality
>> is shared.  I haven't seen any substantial cases as yet, but then I may well be missing
>> things so feel free to submit suggestions (or as ever the better option of patches).
> 
> Now we have many drivers using SW ring with same
> preenable(),postenable(),predisable(),
> initialize_ring(),uninitialize_ring(),poll_func(),probe_trigger(),
> remove_trigger(). Can we move them to IIO common layer as a base class
> methods. And the derived class can overload them if they have special
> implement? Most devices just use the common layer and don't need to
> copy codes.
Sounds sensible. Please propose a patch.

Jonathan
