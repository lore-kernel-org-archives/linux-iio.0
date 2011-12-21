Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4EF1D316.80908@analog.com>
Date: Wed, 21 Dec 2011 13:37:42 +0100
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: "J.I. Cameron" <jic23@cam.ac.uk>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: pll: New driver for ADF4350/ADF4351 Wideband Synthesizers
 (PLL)
References: <1323436951-11246-1-git-send-email-michael.hennerich@analog.com> <4EE36FA1.5070902@kernel.org> <4EE5D49E.7010507@analog.com> <4EE90733.9040304@kernel.org> <4EF05092.8050502@analog.com> <Prayer.1.3.4.1112201145580.21192@hermes-2.csi.cam.ac.uk> <4EF1B670.2040306@analog.com> <Prayer.1.3.4.1112211156090.29914@hermes-2.csi.cam.ac.uk>
In-Reply-To: <Prayer.1.3.4.1112211156090.29914@hermes-2.csi.cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 12/21/2011 12:56 PM, J.I. Cameron wrote:
> On Dec 21 2011, Michael Hennerich wrote:
>
>> On 12/20/2011 12:45 PM, J.I. Cameron wrote:
>>> On Dec 20 2011, Michael Hennerich wrote:
>>>
>>>> On 12/14/2011 09:29 PM, Jonathan Cameron wrote:
>>>>> On 12/12/2011 10:17 AM, Michael Hennerich wrote:
>>>>>> On 12/10/2011 03:41 PM, Jonathan Cameron wrote:
>>>>>>> On 12/09/2011 01:22 PM, michael.hennerich@analog.com wrote:
>>>>>>>
>>>>> There is also the double indexes that we don't allow anywhere else.
>>>>> They are here because we have different waveforms with same underlying
>>>>> channel.  We could had a bonus optional index to all channels I suppose
>>>>> and have this as the only current user?  Or maybe just a flag to say its
>>>>> a 'subchannel' and use channel2.  Afterall these channels are neither
>>>>> going to have modifiers or to be differential so I can't see a clash
>>>>> occuring on the use of that...
>>>> Well one of the indexes with the DDS parts is used to distinguish
>>>> the tuning words options, in combination with the pincontrol feature.
>>>> PLL devices typically doesn't feature this.
>>>>
>>>> So bottom line - can we agree on:
>>>>
>>>> out_altvoltageX_freqY
>>>> out_altvoltageX_phaseY
>>>> out_altvoltageX_scale
>>>> out_altvoltageX_enable
>>>> ...
>>>> Where X stands for the output channel, and Y for some sort of option.
>>> Looks good as far as I am concerned. Might be worth a quick check through
>>> of dds and meter devices to see how we can extend this to cover them.
>> Hi Jonathan,
>>
>> Looked at the various use cases. And the only user for the second
>> subindex seems to be the DDS parts.
>>
>> I now wondering if we should handle freqY and phaseY by using extended_name,
>> rather than adding new postfixes for them. Which is going to be
>> difficult anyways,
> Use extend name will make for some hideous logic in the read_raw, write_raw
> functions.

That really depends. I would need to add multiple channels to channel_spec.
We can use .channel2 as well as .address to distinguish the 
'extended_names',
without the need to parse strings.

>    If we need it (and it looks like we do), lets make whatever
> changes are necessary to do this cleanly in the chan spec structure.
> I'd been avoiding the DDS parts so far because I have little idea of
> how to make them play nicely with iio_chan_spec.
>
> Ideally freq and phase would be chaninfo elements. Given that is a mask
> there is no obvious way of storing the associated index.  This also effects
> the write_raw and read_raw functions as they have no way to get to that index
> either.  That one could be avoided by changing them to take a u64 and embedding
> the index in a few bits of that
> (fiddly carrying that through everywhere but not too bad).
>
> We could simply define a set of freq0 freq1 freq2 as separate elements of the
> info mask, but that' really nasty and going to bite us at some point.
My fear is that we run out of bits in chaninfo pretty shortly,
adding bits that aren't used frequently is not going to help.

> How about adding (with better naming);
>
> int *infomask_nums;
> //could drop next one if we define a magic termination value.
> int infomask_nums_number;
> to iio_chan_spec.
>
> where for example
>
> static int inf_mask_nums[] = {
> [IIO_CHAN_INFO_FREQUENCY] = 7;
> ...
> };
> static struct iio_chan_spec bobschannels[] = {
> {
>    ...usual stuff.
>    .info_mask = IIO_CHAN_INFO_FREQUENCY_SEPARATE_BIT,
>    .infomask_nums = inf_mask_nums,
>    .infomask_nums_number = ARRAY_SIZE(inf_mask_nums),
> }
> };
>
> The parsing logic then create
>
> in_accelX_freq0...in_accelX_freq6
 From a core pint of view, it will work an create X attributes,
but without changing [read|write]_raw function parameter API,
how will you determine which X is currently processed?

> This functionality may also be useful for filter taps...
>
> Obviously the above creates large tables, so for space saving we
> may want to use a structure pairing IIO_CHAN_INFO_WWWWW with the
> number.  Can terminate that with a 0,0 entry and loose the counter
> as well.  (I like this version better come to think of it).
Sorry can you explain in more detail?
> One other thought is that we may run into issues with the number
> of elements in the infomask.  Only split I can think of is
> to put the shared elements in one mask and the separate ones in another.
but then we are still limited to 32 versus 16 today...
But we could increase to u64 at some day.

>> since I may need the current postfixes such as _scale as well.
>>
>> out_altvoltageX_freqY_scale
>> out_altvoltageX_phaseY_scale
> My initial thought on this is that these are ulikely to be written
> in a particularly fast path, so we could avoid scale etc for them by
> dictating that they are written in the correct units?  We already do
> this for things like sampling frequency.
>
> If we take things to this many levels it is going to get very confusing.
> The raw and scale stuff only makes sense for stuff on fast paths.
> (Now I expect you will come up with an application where this is
> pushed from a buffer just to prove me wrong ;)
FSK, PSK modulation for example ;-)

>> An alternative could be to introduce an indexed extended_name, using the index passed in channel2?
>> Not sure if it is worth adding it?
> I would rather not as stated above.  Handling logic will rely on reading that name
> which we have been desperately avoiding so far.
See comment above


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
