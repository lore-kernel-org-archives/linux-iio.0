Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:62206 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932762AbcECNB0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 May 2016 09:01:26 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH 6/7] iio: inv_mpu6050: Check channel configuration on
 preenable
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1461953982.git.leonard.crestez@intel.com>
 <d1135276814b870a7b0e7e079e47c625b25c4ad9.1461953982.git.leonard.crestez@intel.com>
 <514843f4-2f6d-e902-9fdb-212fc5c91e7d@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <GGao@invensense.com>
Message-ID: <5728A129.9010607@intel.com>
Date: Tue, 3 May 2016 16:01:29 +0300
MIME-Version: 1.0
In-Reply-To: <514843f4-2f6d-e902-9fdb-212fc5c91e7d@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/2016 08:34 PM, Jonathan Cameron wrote:
> On 29/04/16 20:02, Crestez Dan Leonard wrote:
>> Right now it is possible to only enable some of the x/y/z channels, for
>> example you can enable accel_z without x or y. If you actually do that
>> what you get is actually only the x channel.
>>
>> In theory the device supports selecting gyro x/y/z channels
>> individually. It would also be possible to selectively enable x/y/z
>> accel by unpacking the data read from the hardware into a format the iio
>> core accepts.
>>
>> It is easier to simply refuse incorrect configuration.
> Or see suggestion inline. This isn't an uncommon problem!
>
>> +/* Validate channels are set in a correct configuration */
>> +static int inv_mpu_buffer_preenable(struct iio_dev *indio_dev)
>> +{
> This should not be in the preenable.  It's perfectly possible to know that mode was invalid
> earlier than this.  Use the core demux to handle this case by providing
> available_scanmasks.  The the core will handle demuxing the data stream if needed to
> provide the channels enabled only in the kfifo.
> 
But available_scanmasks is a list! Listing every valid scanmask would
work for accel/gyro but the next patch adds support for up to 4 slaves
and each slave can be enabled/disabled. This would requires generating
2^6 == 64 possible scanmasks, right?

I tried to do this same validation inside .validate_scan_mask but that
function is called for each individual scan bit. What I want is to
validate the scan mask once it's entirely configured, and preenable
seems to be the best choice.

This could be implemented with an "adjust_scan_mask" driver function
which adds bits to a trial scanmask until the configuration is suitable.

I think a better solution would be to add a .get_buffer_offsets driver
function and have the iio core handled demuxing based on offsets rather
than just scan_mask.

This would also handle alignment for external channels with storagebits
!= 16. For example if I enable accel and an external u32 channel iio
expects the following layout:
    <u16 ACCEL_X> <u16 ACCEL_Y> <u16 ACCEL_Z> <u16 PAD> <u32 external>
while my device gives the following:
    <u16 ACCEL_X> <u16 ACCEL_Y> <u16 ACCEL_Z> <u32 external>
I could add memcpy mangling in my driver but handling this belongs in
the iio core.

I'd rather avoid depending on new features in the iio core and just do
simple validations instead. This is because the feature I'm adding is
already complex.

-- 
Regards,
Leonard
