Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37044 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbcEDSYX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 14:24:23 -0400
In-Reply-To: <29729aa1-6c66-6a7a-017f-784beb724089@intel.com>
References: <cover.1461953982.git.leonard.crestez@intel.com> <d1135276814b870a7b0e7e079e47c625b25c4ad9.1461953982.git.leonard.crestez@intel.com> <514843f4-2f6d-e902-9fdb-212fc5c91e7d@kernel.org> <5728A129.9010607@intel.com> <ff467b62-c88e-eba6-01f3-80456ad63c80@kernel.org> <29729aa1-6c66-6a7a-017f-784beb724089@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 6/7] iio: inv_mpu6050: Check channel configuration on preenable
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 04 May 2016 19:22:40 +0100
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <GGao@invensense.com>
Message-ID: <99619C53-F0C2-4A78-84E7-F63398B5CF5A@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 4 May 2016 16:34:46 BST, Crestez Dan Leonard <leonard.crestez@intel.com> wrote:
>On 05/04/2016 12:01 PM, Jonathan Cameron wrote:
>> On 03/05/16 14:01, Crestez Dan Leonard wrote:
>>> On 05/01/2016 08:34 PM, Jonathan Cameron wrote:
>>>> On 29/04/16 20:02, Crestez Dan Leonard wrote:
>>>>> Right now it is possible to only enable some of the x/y/z
>channels, for
>>>>> example you can enable accel_z without x or y. If you actually do
>that
>>>>> what you get is actually only the x channel.
>>>>>
>>>>> In theory the device supports selecting gyro x/y/z channels
>>>>> individually. It would also be possible to selectively enable
>x/y/z
>>>>> accel by unpacking the data read from the hardware into a format
>the iio
>>>>> core accepts.
>>>>>
>>>>> It is easier to simply refuse incorrect configuration.
>>>> Or see suggestion inline. This isn't an uncommon problem!
>>>>
>>>>> +/* Validate channels are set in a correct configuration */
>>>>> +static int inv_mpu_buffer_preenable(struct iio_dev *indio_dev)
>>>>> +{
>>>> This should not be in the preenable.  It's perfectly possible to
>know that mode was invalid
>>>> earlier than this.  Use the core demux to handle this case by
>providing
>>>> available_scanmasks.  The the core will handle demuxing the data
>stream if needed to
>>>> provide the channels enabled only in the kfifo.
>>>>
>>> But available_scanmasks is a list! Listing every valid scanmask
>would
>>> work for accel/gyro but the next patch adds support for up to 4
>slaves
>>> and each slave can be enabled/disabled. This would requires
>generating
>>> 2^6 == 64 possible scanmasks, right?
>> Not that bad (a whole 256 bytes ;), but I get your point.
>> 
>>>
>>> I tried to do this same validation inside .validate_scan_mask but
>that
>>> function is called for each individual scan bit. What I want is to
>>> validate the scan mask once it's entirely configured, and preenable
>>> seems to be the best choice.
>> We want to know earlier that a given set of channels isn't possible. 
>
>>>
>>> This could be implemented with an "adjust_scan_mask" driver function
>>> which adds bits to a trial scanmask until the configuration is
>suitable.
>> I'd call it scan_mask_available_match or similar but yes, this
>> would work for me.  So in iio_scan_mask_set we'd have something like:
>> if (indio_dev->available_scan_masks) {
>> 		mask = iio_scan_mask_match(indio_dev->available_scan_masks,
>> 					   indio_dev->masklength,
>> 					   trialmask, false);
>> 		if (!mask)
>> 			goto err_invalid_mask;
>> } else if (indio_dev->ops->scan_mask_available_match) {
>> 	mask =
>indio_dev->ops->scan_mask_available_match(indio_dev->masklength,
>> 							 trialmask);
>> 	if (!mask)
>> 		goto err_invalid_mask;
>> }
>> 
>> Bit of complexity needed to avoid any memory issues (probably use a
>local
>> buffer in the driver private struct to point mask at once filled),
>> 
>> Scan mask available could then compute the minimum possible scan mask
>for the
>> device in question given the requirements of trialmask.
>> 
>> An easy change that effectively provides a dynamic equivalent of our
>constant
>> list of available scan masks.  I'd advocate only using it when the
>> device complexity make it worthwhile (much like dynamic allocation of
>channel
>> specs currently) - so not many cases.
>> 
>>>
>>> I think a better solution would be to add a .get_buffer_offsets
>driver
>>> function and have the iio core handled demuxing based on offsets
>rather
>>> than just scan_mask.
>> Scan mask isn't about just this.   A common case is not that you have
>> to enable additional channels to end up with a valid set of readings
>> but rather that you can only read a (complex) subset of channels at
>> a time in buffered mode.  The simplest being onehot, but there are
>> quite a few other cases (two parallel ADCs each of which is muxed to
>a
>> subset of the channels via slow muxes for example).
>> 
>>>
>>> This would also handle alignment for external channels with
>storagebits
>>> != 16. For example if I enable accel and an external u32 channel iio
>>> expects the following layout:
>>>     <u16 ACCEL_X> <u16 ACCEL_Y> <u16 ACCEL_Z> <u16 PAD> <u32
>external>
>>> while my device gives the following:
>>>     <u16 ACCEL_X> <u16 ACCEL_Y> <u16 ACCEL_Z> <u32 external>
>>> I could add memcpy mangling in my driver but handling this belongs
>in
>>> the iio core.
>> Matter of opinion.  I'd take this as a driver requirement - much like
>the
>> common case of data that is packed tighter than this or irritatingly
>> interleaved.
>> 
>> <u4 ACCEL_X_11_8> <u4 ACCEL_Y_11_8> <u8 ACCEL_X_7_0> <u8 ACCEL_Y_7_0>
>is
>> not uncommon.
>> 
>> Where do we draw the line between what should be in the core and in a
>> driver?  I'm not against seeing a proposal for byte based packing
>unwinding
>> in the core, but I'm not convinced the added complexity (see other
>email
>> about the endian mess) is worth it without seeing code.
>> 
>>>
>>> I'd rather avoid depending on new features in the iio core and just
>do
>>> simple validations instead. This is because the feature I'm adding
>is
>>> already complex.
>>>
>> I think your earlier suggestion that you dismissed is a trivial
>extension
>> of the core and provides everything you need - so that's the route
>> that I'd advocate.
>> 
>Implementing some sort of "scan_mask_available_match" won't deal with
>alignment issues for external channels so it only partially fixes my
>current problem. Maybe for some other driver?
>
>If you object to validations inside preenable it would be best to just
>implement manual byte mangling inside the driver. I'd split it in two:
>    inv_mpu_get_scan_offsets();
>    iio_format_aligned_sample(&scan_offsets);
>
>The second part would be sortof generic but implemented statically
>inside the driver. Since this would implicitly skip unneeded values
>from
>hardware it will support arbitrary scan masks.

This would be a great first step. Will let us get a handle on how it all works.

Can always shift this put of the driver later if it makes sense.

Will be interesting to see what the code looks like.

J
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
