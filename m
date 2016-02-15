Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30857 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbcBOJmE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Feb 2016 04:42:04 -0500
Message-ID: <56C19D6A.4020905@parrot.com>
Date: Mon, 15 Feb 2016 10:42:02 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/3] iio:core: timestamping clock selection support
References: <cover.1455184829.git.gregor.boirie@parrot.com> <3e2d224ccd59ecba141e1320e804c674eb61c686.1455184829.git.gregor.boirie@parrot.com> <56BF3A49.1000908@kernel.org> <56C0BCDD.3080006@metafoo.de>
In-Reply-To: <56C0BCDD.3080006@metafoo.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/14/2016 06:43 PM, Lars-Peter Clausen wrote:
> On 02/13/2016 03:14 PM, Jonathan Cameron wrote:
>> On 11/02/16 10:04, Gregor Boirie wrote:
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>>> index 3c66248..4602006 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>> @@ -32,6 +32,13 @@ Description:
>>>   		Description of the physical chip / device for device X.
>>>   		Typically a part number.
>>>   
>>> +What:		/sys/bus/iio/devices/iio:deviceX/clockid
>>> +KernelVersion:	4.5
>>> +Contact:	linux-iio@vger.kernel.org
>>> +Description:
>>> +		Identifier (clockid_t) of current posix clock used to timestamp
>>> +		buffered samples and events for device X.
>> As it's been written into a sysfs attribute I'd normally prefer to see a
>> descriptive string for something like this.  What do others think?
>> clockid_t is clearly fixed abi so this makes reasonable sense.  Are there
>> other sysfs attributes to select the clock already present elsewhere in the
>> kernel?
> Very same thoughts here. clockid_t is already ABI so we don't have to be
> afraid exposing values that might change, but at the same time a string
> would be more suitable for sysfs.
I was driven by simple userspace implementation at the cost of sysfs 
conventions.
Moreover, no kernel side parsing is needed in this way.
Using a stringifi'ed clockid_t allows trivial clock selection with 
following libiio based
code snippet:
</code>
int err;
...
err = iio_device_attr_write(indio_dev, "clockid", 
STRINGIFY(CLOCK_MONOTONIC));
if (err < 0)
goto error;
<code/>

And even simpler retrieval and use of current clock:
</code>
int             err;
long long       clockid;
struct timespec tspec;
...
err = iio_device_attr_read_longlong(indio_dev, "clockid", &clockid);
if (err < 0)
     goto error;
...
clock_gettime((clockid_t) clockid, &tspec);
...
<code/>

Implementing this with a descriptive string is no big deal anyway. I can 
modify this
part if you feel sysfs conventions respect prevails.

gregor.
