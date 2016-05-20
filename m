Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40513 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850AbcETN5i (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 May 2016 09:57:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 20 May 2016 14:57:35 +0100
From: jic23@jic23.retrosnub.co.uk
To: Matt Ranostay <mranostay@gmail.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio-owner@vger.kernel.org
Subject: Re: [RFC] dynamic iio consumer channel mapping
In-Reply-To: <CAKzfze9baGLnnfXo9vdcf8b_aZpv=1YoR6UBvzsfk-4h-guYLg@mail.gmail.com>
References: <CAKzfze_cJQXrb4789WpOjpWeLO3PEotuDnKc+FRd4FiFUOuYJA@mail.gmail.com>
 <2C047EEE-7F16-4B5D-A735-301B4AE788CC@jic23.retrosnub.co.uk>
 <CAEnQRZC0E39C3ucReVqW9SztzmrQxkPL8AEnqGPsg8XWepLe_A@mail.gmail.com>
 <CAKzfze9baGLnnfXo9vdcf8b_aZpv=1YoR6UBvzsfk-4h-guYLg@mail.gmail.com>
Message-ID: <91f7be5d66d328bce67c0fc0cf55e77c@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20.05.2016 03:09, Matt Ranostay wrote:
> On Thu, May 19, 2016 at 1:25 AM, Daniel Baluta 
> <daniel.baluta@intel.com> wrote:
>> On Thu, May 19, 2016 at 8:58 AM, Jonathan Cameron
>> <jic23@jic23.retrosnub.co.uk> wrote:
>>> 
>>> 
>>> On 19 May 2016 04:38:09 BST, Matt Ranostay <mranostay@gmail.com> 
>>> wrote:
>>>> Jonathan et al,
>>>> 
>>>> Shortly going to be doing a project that requires an iio_map mapping
>>>> for using an iio  channel input from an ADC. I've notice all seem to
>>>> be platform_data or hardcoded due to it being a SoC or statically
>>>> known MFD mapping.
>>>> 
>>>> For my application it isn't correct to create an hardcoded iio_map
>>>> mapping with the ADC driver (ti-ads1015) since nobody else would 
>>>> care
>>>> about it, and wouldn't help in the case of multiple instances of the
>>>> same ADC.
>>>> 
>>>> But I would rather avoid the technical debt and uglyness of using a
>>>> board file.
>>>> 
>>>> What would be the best way via ACPI and DT to define channel 
>>>> mappings
>>>> between name, consumers, and consumer channel names? Thought I 
>>>> request
>>>> input here before I make any core iio subsystem changes.
>>>> 
>>>> Thanks,
>>>> 
>>>> Matt
>>> 
>>> Whilst we have gotten a fair bit of grief over the Linux specific 
>>> nature of the
>>>  binding, iio-hwmon does have bindings for this sort of case.
>>> 
>>> Mid term I have been wondering about taking it as far as having a 
>>> configfs
>>>  interface to create such soft hardware mappings at runtime....
>> 
>> +1 for configfs, would be the most flexible way for users.
> 
> Then I suppose the consumer driver would need to return -EIO or
> similar until the user has setup the mapping with configfs?

Probably instantiate the consumer driver in configfs as well.  Would be 
tricky
if the consumer has real hardware as well though.  If that were the case 
then
yes would indeed need to return -EIO.  Configfs is find for the data 
reformatting
type of consumers.  In this world ultimately we might have data fusing 
drivers
+ filters etc as well as the more direct input, hwmon, thermal, battery 
etc
bridges.

In that case though I thing devicetree bindings are representing real 
things
in some sense so make more sense.
> 
> Also I suppose we could add configfs setup for the gpio interrupt
> trigger that uses platform data currently. Although not sure it would
> be sane to be touching interrupt-controllers from userspace.
We had a discussion about this a while ago and concluded we'd need 
something
like a device tree binding that said 'this gpio can be used for this' 
then
allow specific set up of what it was used for in userspace.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
