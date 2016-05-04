Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37015 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbcEDSTM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 14:19:12 -0400
In-Reply-To: <5fd25f50-5fe3-ba5e-7b8e-f2ba754b6de0@intel.com>
References: <5728A9B5.6080902@intel.com> <a9f31cb3-07f8-b0dd-4eab-89f29e3fed98@kernel.org> <5fd25f50-5fe3-ba5e-7b8e-f2ba754b6de0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC] iio: Add support for describing scan offsets in buffer ops
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 04 May 2016 19:18:38 +0100
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Daniel Baluta <daniel.baluta@intel.com>
Message-ID: <950DDC1E-52AC-449B-AA66-027BFD95AA33@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 4 May 2016 17:01:17 BST, Crestez Dan Leonard <leonard.crestez@intel.com> wrote:
>On 05/04/2016 11:44 AM, Jonathan Cameron wrote:
>> On 03/05/16 14:37, Crestez Dan Leonard wrote:
>>> I propose that we add a new function in iio_buffer_setup_ops which
>looks
>>> like this:
>>>
>>> int (*get_scan_offsets)(struct iio_dev *indio_dev,
>>>                         off_t *scan_offsets,
>>> 			size_t *sample_bytes);
>>>
>>> This would be called when enabling a buffer to fetch the offset in
>the
>>> sample for each channel (by scan_index) based on the currently
>>> configured scan mask. Then the iio core would then handle
>rearranging
>>> sample bytes as expected by the buffer consumer. Driver
>implementations
>>> could look something like this:
>>>
>>> off_t pos = 0;
>>> if (scan_mask & (1 << SCAN_INDEX_TEMP))) {
>>>     scan_offsets[SCAN_INDEX_TEMP] = pos++;
>>> }
>>> /* No 2-bytes alignment here! */
>>> if (scan_mask & SCAN_MASK_ACCEL_ANY) {
>>>     scan_offsets[SCAN_INDEX_ACCEL_X] = pos + 0;
>>>     scan_offsets[SCAN_INDEX_ACCEL_Y] = pos + 2;
>>>     scan_offsets[SCAN_INDEX_ACCEL_Z] = pos + 4;
>>>     pos += 6;
>>> }
>>> *sample_bytes = pos;
>> Sure - this side is straight forward enough.  It's the core
>complexity
>> that makes me wonder if this is worthwhile.  Btw if this is worth
>doing
>> then we should really be looking at non byte aligned packed records
>as
>> well (just to make it really hideous!)
>
>You could have a bunch of channels with different realbits/shift and
>the
>same offset.
Good point.
>
>> The killer in here is endian requirements. If the core is repacking
>data
>> it will need to understand these completely.  Two options exist,
>either
>> the core needs to 'edit' the shift provided by the driver, or it
>needs
>> to do endian dependent data realignment.
>> 
>> Take a typical 3 byte unaligned packed record being expanded to a
>> 4 byte aligned record.  I think the easy cases are:
>> 
>> ABC -> 0ABC
>> CBA -> CBA0
>> so endian dependent shifts.
>> 
>I'm not sure how unaligned 24bit channels would be handled. Maybe it
>could be done storagebits=32, realbits=24, shift=8 or 0 and offsets
>that
>are multiples of 3?
>
>I guess it would have to know about endianness.
>
>>> This would be particularly useful if IIO sample buffers are
>>> memory-mapped eventually. I think that this extension would be
>>> incrementally useful to that effort.
>> 
>> Perhaps.  I'm interested to hear other views on this suggestion, but
>> right now I'm not convinced.  I'd argue that we want clean data
>> presentations to userspace and that the restrictions as they
>currently
>> stand are not really that burdensome on the data.
>> 
>> The exception is dma buffers - in those cases it really might be the
>> case that we want to allow more complex alignment.
>> 
>The point of exposing this through the iio core to userspace is that it
>could be used to support this kind of devices. It's not worth exposing
>as ABI unless it can support a lot of stuff at once.
>
>It might make more sense to just provide some helpers for drivers to do
>their own easy reformatting.

Certainly seems like that to me. Nothing stops us looking again at this in the
future.

J


-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
