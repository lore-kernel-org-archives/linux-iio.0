Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-018.synserver.de ([212.40.185.18]:1496 "EHLO
	smtp-out-221.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751571AbcBNR5m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2016 12:57:42 -0500
Subject: Re: [RFC PATCH v1 1/3] iio:core: timestamping clock selection support
To: Jonathan Cameron <jic23@kernel.org>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org
References: <cover.1455184829.git.gregor.boirie@parrot.com>
 <3e2d224ccd59ecba141e1320e804c674eb61c686.1455184829.git.gregor.boirie@parrot.com>
 <56BF3A49.1000908@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56C0BCDD.3080006@metafoo.de>
Date: Sun, 14 Feb 2016 18:43:57 +0100
MIME-Version: 1.0
In-Reply-To: <56BF3A49.1000908@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/13/2016 03:14 PM, Jonathan Cameron wrote:
> On 11/02/16 10:04, Gregor Boirie wrote:
>> Adds a new per-device sysfs attribute "clockid" to allow userspace to select a
>> particular POSIX clock for buffered samples and events timestamping.
>>
>> When read, the attribute file returns a stringifi'ed clockid_t matching the
>> currently selected clock.
>> Writing a stringifi'ed clockid_t to the attribute file will select the
>> corresponding clock for the device.
>>
>> Following clocks, as listed in clock_gettime(2), are supported: CLOCK_REALTIME,
>> CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE,
>> CLOCK_MONOTONIC_COARSE, CLOCK_BOOTTIME and CLOCK_TAI.
>>
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio |   7 +++
>>  Documentation/DocBook/iio.tmpl          |   2 +-
>>  drivers/iio/iio_core.h                  |   3 +
>>  drivers/iio/industrialio-core.c         | 107 ++++++++++++++++++++++++++++++--
>>  drivers/iio/industrialio-event.c        |  19 +++++-
>>  drivers/iio/industrialio-trigger.c      |   2 +-
>>  include/linux/iio/iio.h                 |  10 +--
>>  7 files changed, 134 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 3c66248..4602006 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -32,6 +32,13 @@ Description:
>>  		Description of the physical chip / device for device X.
>>  		Typically a part number.
>>  
>> +What:		/sys/bus/iio/devices/iio:deviceX/clockid
>> +KernelVersion:	4.5
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Identifier (clockid_t) of current posix clock used to timestamp
>> +		buffered samples and events for device X.
> As it's been written into a sysfs attribute I'd normally prefer to see a
> descriptive string for something like this.  What do others think?
> clockid_t is clearly fixed abi so this makes reasonable sense.  Are there
> other sysfs attributes to select the clock already present elsewhere in the
> kernel?

Very same thoughts here. clockid_t is already ABI so we don't have to be
afraid exposing values that might change, but at the same time a string
would be more suitable for sysfs.
