Return-Path: <lars@metafoo.de>
Message-ID: <4F9835AF.4050206@metafoo.de>
Date: Wed, 25 Apr 2012 19:34:39 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Streamline API function naming
References: <1335356297-21035-1-git-send-email-lars@metafoo.de> <4F9810CA.4070306@cam.ac.uk>
In-Reply-To: <4F9810CA.4070306@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/25/2012 04:57 PM, Jonathan Cameron wrote:
> On 4/25/2012 1:18 PM, Lars-Peter Clausen wrote:
>> Currently we use two different naming schemes in the IIO API,
>> iio_verb_object
>> and iio_object_verb. E.g iio_device_register and iio_allocate_device.
>> This
>> patches renames instances of the later to the former. The patch also
>> renames allocate to
>> alloc as this seems to be the preferred form throughout the kernel.
>>
>> In particular the following renames are performed by the patch:
>>     iio_put_device ->  iio_device_put
>>     iio_allocate_device ->  iio_device_alloc
>>     iio_free_device ->  iio_device_free
>>     iio_get_trigger ->  iio_trigger_get
>>     iio_put_trigger ->  iio_trigger_put
>>     iio_allocate_trigger ->  iio_trigger_alloc
>>     iio_free_trigger ->  iio_trigger_free
>>
>> The conversion was done with the following coccinelle patch with
>> manual fixes to
>> comments and documentation.
> I'm entirely in favour of this. Actually did half of them in the
> original attempt to move out of staging but never pulled back into
> the main tree!
>
> Assuming Greg merges the series that I just sent out to move the core
> out of staging, could you regenerate against the files in their new
> locations?
> 

Yes, sure. I think git may even be able to track the rename, so rebasing the
patch shouldn't be much of a problem.

- Lars
