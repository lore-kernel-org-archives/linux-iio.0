Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEnQRZC0E39C3ucReVqW9SztzmrQxkPL8AEnqGPsg8XWepLe_A@mail.gmail.com>
References: <CAKzfze_cJQXrb4789WpOjpWeLO3PEotuDnKc+FRd4FiFUOuYJA@mail.gmail.com>
 <2C047EEE-7F16-4B5D-A735-301B4AE788CC@jic23.retrosnub.co.uk> <CAEnQRZC0E39C3ucReVqW9SztzmrQxkPL8AEnqGPsg8XWepLe_A@mail.gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Thu, 19 May 2016 19:09:45 -0700
Message-ID: <CAKzfze9baGLnnfXo9vdcf8b_aZpv=1YoR6UBvzsfk-4h-guYLg@mail.gmail.com>
Subject: Re: [RFC] dynamic iio consumer channel mapping
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, May 19, 2016 at 1:25 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> On Thu, May 19, 2016 at 8:58 AM, Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
>>
>>
>> On 19 May 2016 04:38:09 BST, Matt Ranostay <mranostay@gmail.com> wrote:
>>>Jonathan et al,
>>>
>>>Shortly going to be doing a project that requires an iio_map mapping
>>>for using an iio  channel input from an ADC. I've notice all seem to
>>>be platform_data or hardcoded due to it being a SoC or statically
>>>known MFD mapping.
>>>
>>>For my application it isn't correct to create an hardcoded iio_map
>>>mapping with the ADC driver (ti-ads1015) since nobody else would care
>>>about it, and wouldn't help in the case of multiple instances of the
>>>same ADC.
>>>
>>>But I would rather avoid the technical debt and uglyness of using a
>>>board file.
>>>
>>>What would be the best way via ACPI and DT to define channel mappings
>>>between name, consumers, and consumer channel names? Thought I request
>>>input here before I make any core iio subsystem changes.
>>>
>>>Thanks,
>>>
>>>Matt
>>
>> Whilst we have gotten a fair bit of grief over the Linux specific nature of the
>>  binding, iio-hwmon does have bindings for this sort of case.
>>
>> Mid term I have been wondering about taking it as far as having a configfs
>>  interface to create such soft hardware mappings at runtime....
>
> +1 for configfs, would be the most flexible way for users.

Then I suppose the consumer driver would need to return -EIO or
similar until the user has setup the mapping with configfs?

Also I suppose we could add configfs setup for the gpio interrupt
trigger that uses platform data currently. Although not sure it would
be sane to be touching interrupt-controllers from userspace.
