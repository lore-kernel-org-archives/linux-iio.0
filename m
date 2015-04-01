Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <551C2B02.7080400@linux.intel.com>
Date: Wed, 01 Apr 2015 10:29:38 -0700
From: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 0/3] Added LTR501 Interrupt support
References: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com> <CAEnQRZCqHhd054N_5iq4qJHqQfgj4fwvADyFSh218AxCZsXxkA@mail.gmail.com>
In-Reply-To: <CAEnQRZCqHhd054N_5iq4qJHqQfgj4fwvADyFSh218AxCZsXxkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 04/01/2015 06:02 AM, Daniel Baluta wrote:
> On Wed, Apr 1, 2015 at 5:55 AM, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> This patchset adds interrupt support for LTR501 chip. Also
>> added acpi enumaration support.
>>
>> Please let me know your review comments.
>>
>> v1:
>> 1. Added support to enable ALS & PS intterupts based
>>     on threshold settings.
>> 2. Added support to control intrrupt rate.
>> 3. Added acpi enumeration support.
>>
>> Kuppuswamy Sathyanarayanan (3):
>>    iio: ltr501: Add interrupt support
>>    iio: ltr501: Add interrupt rate control support
>>    iio: ltr501: Add ACPI enumeration support
>>
>>   drivers/iio/light/ltr501.c | 395 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 392 insertions(+), 3 deletions(-)
> Nice :). Keep in mind that there are some pending patches for ltr501
> and your code
> might not apply.
>
> I think at least this patch must be applied.
>
> http://marc.info/?l=linux-iio&m=142779829617041&w=2
Do you want me to include this in my patch set. I can rebase my patches 
on top of this.
>
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
