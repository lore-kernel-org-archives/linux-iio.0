Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45288 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbcJAP4M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 11:56:12 -0400
Subject: Re: [PATCH v3 5/5] staging: iio: isl29018: check if the chip is in a
 suspended state
To: Brian Masney <masneyb@onstation.org>
References: <20160926075935.GA25938@kroah.com>
 <1474935620-13151-1-git-send-email-masneyb@onstation.org>
 <1474935620-13151-5-git-send-email-masneyb@onstation.org>
 <547487cf-87f7-0922-ad30-cf8dff599d71@kernel.org>
 <20161001153031.GA16708@basecamp.onstation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cb002783-5902-7436-9b53-967199aa5518@kernel.org>
Date: Sat, 1 Oct 2016 16:56:09 +0100
MIME-Version: 1.0
In-Reply-To: <20161001153031.GA16708@basecamp.onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/10/16 16:30, Brian Masney wrote:
> On Sat, Oct 01, 2016 at 02:59:49PM +0100, Jonathan Cameron wrote:
>> On 27/09/16 01:20, Brian Masney wrote:
>>> Add a check to isl29018_write_raw() to ensure that the chip is not in a
>>> suspended state. This makes the code consistent with what is present
>>> in isl29018_read_raw().
>>>
>>> Signed-off-by: Brian Masney <masneyb@onstation.org>
>> Applied to the togreg branch of iio.git.
>>
>> Out of curiosity, do you actually have one of these?
>>
>> At a quick glance, the only remaining bit keeping this driver
>> in staging is the lack of docs on the infrared_supression
>> attribute.  If you want to add something on that and a patch
>> moving it out of staging that would be great.
>>
>> However, note that the graduation patch is usually the one
>> that gets the driver thoroughly reviewed by several people so
>> more stuff may come out of the woodwork.
> 
> I do not have a device with this hardware. I picked a random driver in
> the IIO subsystem to cleanup with the goal of getting it closer towards
> graduation from staging. I'm planning to move on to another driver in
> IIO once I can't get any further without having the hardware on
> hand.
> 
> I see two other issues that need to be addressed with that driver:
> 
> - in_illuminance_scale_available_show() and
>   in_illuminance_integration_time_available_show() each return four
>   different values in their sysfs attribute. My understanding is that
>   only a single value should be in the sysfs attribute.
It's considered fine when they are providing the range of values
another sysfs attribute can take.  There are two common ways of
doing that

1) What we do in IIO, just have a separate sysfs attribute to say
what values it can take.
2) Have a list with markings in it.
e.g.
 1 2 4 8 [31] 1003
where the 31 was last written to the attribute.

With hindsight I rather prefer the second, but went with the
first long  ago.  Anyhow, upshot is that these are fine as is.

The argument is they represent one thing.  The range of values
that another attribute can take.  Actually the one value
also extends to things like rotation matrices where they
only have meaning as a set (also quaternions)

> If that is the
>   case, then should the attributes be something like:
> 
>   in_illuminance_scale_available_16
>   in_illuminance_scale_available_12
>   in_illuminance_scale_available_8
>   in_illuminance_scale_available_4
> 
>   in_illuminance_integration_time_available_16
>   ...
That would be hideous!
> 
>   I got the numbers from the isl29018_int_time enum. If this is
>   acceptable, then I'll submit some patches with these changes.
> 
> - checkpatch - need to add device tree documentation
cool. I'd forgotten that.

> 
> I'll also investigate adding the infrared supression documentation
> although I'm not sure how far I'll get on that without having the
> hardware available.
If the docs that are out there are any good then should be doable
without.

Sounds good and we might have this moved very soon by the sound
of it.

Jonathan

> 
> Brian
> 

