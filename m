Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FC73C71.9000006@cam.ac.uk>
Date: Thu, 31 May 2012 10:40:01 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Laxman Dewangan <ldewangan@nvidia.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Leed Aguilar <leed.aguilar@ti.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] staging:iio:magnetometer:ak8975: fix the sensor enable
 logic
References: <1338437446-12829-1-git-send-email-leed.aguilar@ti.com> <4FC71DAC.3080802@kernel.org> <4FC735DF.4050507@nvidia.com>
In-Reply-To: <4FC735DF.4050507@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 5/31/2012 10:11 AM, Laxman Dewangan wrote:
> On Thursday 31 May 2012 12:58 PM, Jonathan Cameron wrote:
>> Also cc'd Laxman for comments.
>>> Allow the magn sensor raw attributes to be available only
>>> when enable is true.
>>>
>>> The single measurement mode change to power-down mode
>>> automatically once the sensor data is measured, so there
>>> is no need to enable this mode to allow the data reading
>>> process (ak8975_read_axis) to begin, which internally is
>>> setting the single measurement mode to take a sample.
>> Hmm. I'm not terribly keen on this as it's just changed from one non
>> abi compliant attribute to a different one.
>>
>> We need to take another look at how to handle low power modes etc.
>> We could add some heuristics in driver on when to disable the device,
>> but that is obviously not that flexible.
>>
>> Otherwise I'd much prefer a kernel wide view on manual disables
>> of indivual devices to adhoc bits of code liek this...
>>
>> The underlying change to do with not explicitly setting power down
>> modes is fine, but I'd like Laxman's comment on this as I don't have
>> one.
>
> The measurement is done in ONCE mode and once conversion completes the
> device automatically goes into the power down mode. Hence we need not to
> set the power-down mode explictly.
> However, do we really require this "enable" sysfs? I think we can get
> rid of this sysfs as it just does the flag setting now and so we really
> dont need as per lots of improvement done in staging driver recently.
>
> I will go with getting rid of this sysfs (enable or old name " mode").
>
Now that's a solution I like!

Thanks, Laxman. Leed, does this work for you?
