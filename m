Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:49377 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbcFUOkE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 21 Jun 2016 10:40:04 -0400
Subject: Re: [PATCH v3] iio: Add driver for Silabs si1132, si1141/2/3 and
 si1145/6/7 ambient light, uv index and proximity sensors
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cfa05b01fcdcdc7ec5d3e5a7bb937122162d1176.1466161813.git.leonard.crestez@intel.com>
 <1b9f19dc-4d86-9d0d-f630-0395b116738b@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <916196ba-3ba1-9eac-12d5-0c512916f349@intel.com>
Date: Tue, 21 Jun 2016 17:37:57 +0300
MIME-Version: 1.0
In-Reply-To: <1b9f19dc-4d86-9d0d-f630-0395b116738b@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/19/2016 02:57 PM, Jonathan Cameron wrote:
> On 17/06/16 12:10, Crestez Dan Leonard wrote:
>> From: Peter Meerwald <pmeerw@pmeerw.net>
>>
>> The si114x supports x=1,2,3 IR LEDs for proximity sensing together with
>> visible and IR ambient light sensing (ALS).
>>
>> Newer parts (si1132, si1145/6/7) can measure UV light and compute an UV index
>>
>> Changes since v2:
>> * Add myself to copyright
>> * Remove TODO: power management.
>> It's fine because by default the device remains sleeping.
>> * Elaborate comments on si1145_data
>> * Adjust comment syntax
>> * Drop special case for reading single words.
>> * Use manual request_irq to ensure proper init/free ordering
>>
>> Changes since Peter's v1:
>> * Fix set_chlist returning positive value on success
>> * Do not assume channel addresses are in order of scan index
>> * Take lock in buffer_preenable
>> * Print part/rev/seq id at probe time
>> * Cleanup param query/update
>> * Poll for response when executing commands
>> * Allow writes even when buffer enabled
>> * Add interrupt support
>> * Rename new to uncompressed_meas_rate for clarity
>> * Fix handling IIO_CHAN_INFO_SCALE:
>> Make it so that when changing the scale the processed value remains
>> identical in identical conditions. The exposed value should be
>> proportional to 2 ** -ADC_GAIN.
>> * Initialize UCOEF registers to default values from datasheet
>> Otherwise by default the coefficients are zero and so are all the
>> values read back
>> * Fix reading in_uvindex_raw manually (not in buffer mode)
>> * Expose in_uvindex_scale=0.01
>> * Expose ADC offset, making zero values meaningful
>> This is not very well documented, for example the si1145/6/7 datasheet
>> lists register 0x1a as 'reserved'. It might make sense to just return a
>> constant on these models.
>>
>> This was tested on si1143 and si1145
>>
>> Link to v2: https://www.spinics.net/lists/linux-iio/msg25055.html
>>
> Can you explain what the autonomous stuff is about?  Has me confused.
> Is it an attempt to allow driving the device with a software trigger
> when no interrupt is provided?  (I think it is but correct me if I'm
> wrong).  I'm definitely not happy with this approach as a trigger 'in'
> should always result in data 'out'.  If you are running multiple
> sensors off one software trigger you'd expect to get the same amount of
> data from each.

That "bool autonomous" is true when the device is in "autonomous
measurement" mode rather than the default "on-demand" mode. I guess it
might even be possible to replace it with a macro that checks for
indio_dev flags?

The driver supports both hardware triggers (from the interrupt) and
software triggers. With software triggers the device is instructed to
make measurements automatically and the data is read at the frequency of
the software trigger.

I guess this would work a bit strange if the device sampling frequency
is too different from the software trigger sampling frequency. Since the
device has no internal fifo to drain at a specific rate it will not
misbehave. It's just that if the sw freq is higher than the hw freq you
will see a "square-ish" signal out.

I also don't think this issue is specific to this driver. It would
affect most devices with software triggers, right?
